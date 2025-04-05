//base for most shaders. you should use or extend this to reduce code duplication unless you really need specialized shaders for an effect
#define PARABOLOID_HEIGHT_OFFSET 512

#include "megashader_todo.fxh"
#include "common_functions.fxh"
#include "common_shadow.fxh"

#ifndef NO_LIGHTING
    float2 ComputeDayNightEffects(in float2 vertexColor)
    {
        float2 color = gDayNightEffects.xy * vertexColor;
        color.x = color.y + color.x;
        color.x = color.x * globalScalars.z  - 1;
        color.x = color.x * globalScalars2.z + 1;
        return color.xx;
    }
#endif //NO_LIGHTING

#ifdef ANIMATED
    float2 ComputeUvAnimation(in float2 texCoord)
    {
        //float3(IN.TexCoord0.xy, 1)
        float3 uv = texCoord.xyx * float3(1.0, 1.0, 0.0) + float3(0.0, 0.0, 1.0);
        return float2(dot(globalAnimUV0, uv), dot(globalAnimUV1, uv));
    }
#endif //ANIMATED

#ifdef DEPTH_SHIFT
    float3 ComputeDepthShift(inout float4 posClip)
    {
        float3 posClipOut = posClip.xyz;
        posClipOut.xy = globalScreenSize.zw * (posClip.w / 2) + posClip.xy; //?
        #ifdef DEPTH_SHIFT_POSITIVE
            posClipOut.z = posClip.z + zShift;
        #else
            posClipOut.z = posClip.z - zShift;
        #endif //DEPTH_SHIFT_POSITIVE

        return posClipOut;
    }
#endif //DEPTH_SHIFT

#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 UnpackNormalMap(float4 normalMap)
    {
        float3 normal;
        #ifdef PARALLAX
            normal.xy = normalMap.xy;
        #else
            //use wy as the xy axis if the alpha channel is not white and the red channel is black. gives better precision if using dxt5 compression
            normal.xy = (1.0 - normalMap.w) - normalMap.x >= 0.0 ? normalMap.wy : normalMap.xy;
        #endif //PARALLAX
        normal.xy = (normal.xy - 0.5) * bumpiness;
        normal.z = sqrt(dot(normal.xy, -normal.xy) + 1.0);

        return normal;
    }
#endif //NORMAL_MAP || PARALLAX


struct VS_Input
{
    float3 Position  : POSITION;
    float4 Color     : COLOR0;
    float2 TexCoord0 : TEXCOORD0;
    float2 TexCoord1 : TEXCOORD1; 
    float3 Normal    : NORMAL;
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float4 Tangent   : TANGENT; 
#endif //NORMAL_MAP || PARALLAX
};

struct VS_Output
{
    float4 Position                 : POSITION;
    float2 TexCoord                 : TEXCOORD0;
    float4 NormalWorldAndDepthColor : TEXCOORD1;
#ifdef SPECULAR
    //view pos to vertex
    float3 ViewDir                  : TEXCOORD3;
#endif //SPECULAR
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld             : TEXCOORD4; 
    float3 BitangentWorld           : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color                    : COLOR0;
    float4 PositionWorld            : TEXCOORD6;
#ifdef PARALLAX
    //(tangent) view pos to vertex
    float4 ViewDirTangent           : TEXCOORD7;
#endif //PARALLAX
};

VS_Output VS_Transform(VS_Input IN)
{
    VS_Output OUT;
    
    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;

    #ifdef SPECULAR
        float3 viewDir = gViewInverse[3].xyz - posWorld;
        OUT.ViewDir = viewDir;
    #endif //SPECULAR
    OUT.PositionWorld.xyz = posWorld;
    
    float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
    #endif //NORMAL_MAP || PARALLAX

    OUT.NormalWorldAndDepthColor.xyz = normalWorld;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    #ifdef PARALLAX
        OUT.ViewDirTangent.x = dot(tangentWorld, viewDir);
        OUT.ViewDirTangent.y = dot(bitangentWorld, viewDir);
        OUT.ViewDirTangent.z = dot(normalWorld, viewDir);
    #endif //PARALLAX

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord0);
    #endif //ANIMATED

    #ifdef DAY_NIGHT_EFFECTS
        OUT.Color.xy = ComputeDayNightEffects(IN.Color.xy);
    #else
        OUT.Color.xy = IN.Color.xy;
    #endif //DAY_NIGHT_EFFECTS

    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);

    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(posClip);
    #else
        OUT.Position.xyz = posClip.xyz;
    #endif //DEPTH_SHIFT

    OUT.Position.w = OUT.NormalWorldAndDepthColor.w = posClip.w;
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord0;
    #endif //ANIMATED
    OUT.Color.zw = IN.Color.zw;

    OUT.PositionWorld.w = 1.0;
    #ifdef PARALLAX
        OUT.ViewDirTangent.w = 1.0;
    #endif
    return OUT;
}


struct VS_OutputDeferred
{
    float4 Position                 : POSITION;
    float2 TexCoord                 : TEXCOORD0;
    float4 NormalWorldAndDepthColor : TEXCOORD1;
#ifdef ENVIRONMENT_MAP
    //view pos to vertex
    float3 ViewDir                  : TEXCOORD3;
#endif //ENVIRONMENT_MAP
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld             : TEXCOORD4; 
    float3 BitangentWorld           : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color                    : COLOR0;
    float4 PositionWorld            : TEXCOORD6;
#ifdef PARALLAX
    //(tangent) view pos to vertex
    float4 ViewDirTangent           : TEXCOORD7;
#endif //PARALLAX
};

//ignoring macros this produces the same result as VS_Transform just with some stuff moved around to generate the same(ish) assembly
VS_OutputDeferred VS_TransformD(VS_Input IN)
{
    VS_OutputDeferred OUT;
    
    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;
    float3 viewDir = gViewInverse[3].xyz - posWorld;

    #ifdef ENVIRONMENT_MAP
        OUT.ViewDir = viewDir;
    #endif //ENVIRONMENT_MAP
    OUT.PositionWorld.xyz = posWorld;
    
    #ifdef PARALLAX
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        OUT.ViewDirTangent.x = dot(tangentWorld, viewDir);
        
        float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);

        OUT.TangentWorld.xyz = tangentWorld;
        bitangentWorld *= IN.Tangent.w;
        OUT.ViewDirTangent.y = dot(bitangentWorld, viewDir);
        OUT.BitangentWorld.xyz = bitangentWorld;
        OUT.ViewDirTangent.z = dot(normalWorld, viewDir);
        OUT.NormalWorldAndDepthColor.xyz = normalWorld;
    #else
        float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
        #if defined(NORMAL_MAP) || defined(PARALLAX)
            float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
            float3 bitangentWorld = cross(tangentWorld, normalWorld);
        #endif //NORMAL_MAP

        OUT.NormalWorldAndDepthColor.xyz = normalWorld;

        #if defined(NORMAL_MAP)
            OUT.TangentWorld.xyz = tangentWorld;
            OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
        #endif //NORMAL_MAP
    #endif //PARALLAX

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord0);
    #endif //ANIMATED

    #if !defined(DIRT_DECAL_MASK) && !defined(NO_LIGHTING) //idk
        OUT.Color.xy = ComputeDayNightEffects(IN.Color.xy);
    #else
        OUT.Color.xy = IN.Color.xy;
    #endif //DIRT_DECAL_MASK

    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);

    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(posClip);
    #else
        OUT.Position.xyz = posClip.xyz;
    #endif //DEPTH_SHIFT

    OUT.Position.w = OUT.NormalWorldAndDepthColor.w = posClip.w;
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord0;
    #endif //ANIMATED
    OUT.Color.zw = IN.Color.zw;

    OUT.PositionWorld.w = 1.0;
    #ifdef PARALLAX
        OUT.ViewDirTangent.w = 1.0;
    #endif
    return OUT;
}

VS_OutputDeferred VS_TransformAlphaClipD(VS_Input IN)
{
    return VS_TransformD(IN);
}


struct PS_OutputDeferred
{
    float4 Diffuse       : COLOR0;
    float4 Normal        : COLOR1;
    //intensity and power/shininess
    float4 SpecularAndAO : COLOR2;
    float4 Stencil       : COLOR3;
};

#ifdef NO_DEFERRED_ALPHA_DITHER
    PS_OutputDeferred PS_DeferredTextured(VS_OutputDeferred IN)
#else
    PS_OutputDeferred PS_DeferredTextured(VS_OutputDeferred IN, float2 screenCoords : VPOS)
#endif //NO_DEFERRED_ALPHA_DITHER
{
    PS_OutputDeferred OUT;
    
    #if defined(PARALLAX) && !defined(PARALLAX_STEEP)
        float2 viewDirTan = normalize(IN.ViewDirTangent.xyz + 0.00001).xy;
        float height = (tex2D(BumpSampler, IN.TexCoord).w * parallaxScaleBias) - (parallaxScaleBias / 2.0);
        float2 texCoord = saturate(viewDirTan * height + IN.TexCoord);
        float4 normalMap = tex2D(BumpSampler, texCoord);
    #elif defined(PARALLAX) && defined(PARALLAX_STEEP)
        const int numSamples = 8;
        const float stepSize = 1.0 / numSamples;

        float2 viewDirTan = normalize(IN.ViewDirTangent.xyz + 0.00001).xy;
        viewDirTan = -viewDirTan * parallaxScaleBias;

        float2 texCoord = IN.TexCoord;
        float4 normalMap = tex2D(BumpSampler, texCoord);
        float height = -normalMap.w;
        float layerHeight = -1.0;

        for(int i = 0; i < numSamples; i++)
        {
            float2 sampleTexCoord = texCoord + (viewDirTan * stepSize);
            float4 sampleNormalMap = tex2D(BumpSampler, sampleTexCoord);

            if(layerHeight <= height)
            {
                texCoord = sampleTexCoord;
                normalMap = sampleNormalMap;
                height = -normalMap.w;
                layerHeight += stepSize;
            }
        }
    #elif defined(NORMAL_MAP)
        float2 texCoord = IN.TexCoord;
        float4 normalMap = tex2D(BumpSampler, texCoord);
    #else
        float2 texCoord = IN.TexCoord;
    #endif

    float4 diffuse = tex2D(TextureSampler, texCoord);
    #ifdef EMISSIVE
        diffuse *= colorize;
    #endif

    #ifdef NO_DIFFUSE_WRITE
        float alpha = 0.0;
    #else
        float alpha = diffuse.w * IN.Color.w * globalScalars.x;
    #endif //NO_DIFFUSE_WRITE

    #ifdef DIRT_DECAL_MASK
        float dirtMask = dot(diffuse.xyz, dirtDecalMask.xyz) * IN.Color.w * globalScalars.x;
    #endif //DIRT_DECAL_MASK

    #ifdef NO_DEFERRED_ALPHA_DITHER
        if(alpha <= 0.176470593)
            discard;
    #else
        AlphaClip(globalScalars.x, screenCoords);
    #endif //NO_DEFERRED_ALPHA_DITHER

    float3 normal;
    #if defined(NO_NORMAL_WRITE)
        normal = float3(0, 0, 0);
        OUT.Normal = float4(normal, 0);
    #elif defined(NORMAL_MAP) || defined(PARALLAX)
        float3x3 tbn = float3x3(IN.TangentWorld.xyz, IN.BitangentWorld.xyz, IN.NormalWorldAndDepthColor.xyz);
        normal = UnpackNormalMap(normalMap);
        normal = normalize(mul(normal, tbn) + 0.00001);
        OUT.Normal.xyz = (normal + 1.0) * 0.5;
        #ifdef NO_DIFFUSE_WRITE
            OUT.Normal.w = normalMap.z * globalScalars.x;
        #elif defined(PARALLAX) && defined(DEPTH_SHIFT_SCALE) //?
            OUT.Normal.w = normalMap.z * alpha * globalScalars.x;
        #else
            OUT.Normal.w = alpha;
        #endif //NO_DIFFUSE_WRITE

        float v0 = dot(normalMap.xy, normalMap.xy) >= 0.02 ? 1.0 : 0.0;
    #else
        normal = normalize(IN.NormalWorldAndDepthColor.xyz + 0.00001);
        OUT.Normal.xyz = (normal + 1.0) * 0.5;
        OUT.Normal.w = alpha;
    #endif //NO_NORMAL_WRITE
    
    #if defined(NO_DIFFUSE_WRITE)
        OUT.Diffuse = float4(0, 0, 0, 0);
    #elif defined(DIRT_DECAL_MASK)
        OUT.Diffuse.xyz = IN.Color.xyz;
        OUT.Diffuse.w = dirtMask;
    #else
        OUT.Diffuse.xyz = diffuse.xyz;
        OUT.Diffuse.w = alpha;
    #endif //NO_DIFFUSE_WRITE

    #ifdef SPECULAR_MAP
        float4 specMap = tex2D(SpecSampler, texCoord);
        float specShininess = specMap.w * specularFactor;
        float specIntensity = dot(specMap.xyz, specMapIntMask.xyz) * specularColorFactor;
    #elif defined(SPECULAR)
        float specIntensity = specularColorFactor;
        float specShininess = specularFactor;
    #endif //SPECULAR_MAP

    #ifdef ENVIRONMENT_MAP
        float3 viewDir = -normalize(IN.ViewDir + 0.00001);
        float3 R = reflect(viewDir, normal);
        R = normalize(R + 0.00001);

        #ifdef CUBEMAP_ENVIRONMENT_MAP
            float3 specular = texCUBE(EnvironmentSampler, R).xyz;
        #else
            float3 specular = tex2D(EnvironmentSampler, (R.xy + 1.0) * -0.5).xyz;
        #endif //CUBEMAP_ENVIRONMENT_MAP

        #ifdef SPECULAR
            specular *= specIntensity;
        #endif

        OUT.Diffuse.xyz += (specular * reflectivePower);
    #endif //ENVIRONMENT_MAP

    //?
    #ifdef PARALLAX
        OUT.Diffuse.xyz *= v0;
        specIntensity *= v0;
    #endif //PARALLAX
    
    #ifdef SPECULAR
        OUT.SpecularAndAO.x = specIntensity * 0.5;
        OUT.SpecularAndAO.y = sqrt(specShininess / 512.0);
        #ifdef DIRT_DECAL_MASK
            OUT.SpecularAndAO.z = 0.0;
        #else
            OUT.SpecularAndAO.z = IN.Color.x;
        #endif //DIRT_DECAL_MASK
    #else
        #if defined(NO_SPECULAR_WRITE)
            OUT.SpecularAndAO.xyz = float3(0, 0, 0);
        #elif defined(EMISSIVE)
            OUT.SpecularAndAO.xyz = globalScalars.z * float3(0, 0, 1) + float3(0, 0.25, 0);
        #else
            OUT.SpecularAndAO.xyz = IN.Color.x * float3(0, 0, 1) + float3(0, 0.25, 0);
        #endif //NO_SPECULAR_WRITE
    #endif //SPECULAR

    #ifdef PARALLAX
        OUT.SpecularAndAO.z *= v0;
    #endif //PARALLAX

    #if defined(AMBIENT_DECAL_MASK)
        OUT.SpecularAndAO.w = saturate(1.0 - dot(diffuse.xyz, ambientDecalMask.xyz)) * alpha * globalScalars2.z;
    #elif defined(DIRT_DECAL_MASK)
        OUT.SpecularAndAO.w = dirtMask;
    #else
        OUT.SpecularAndAO.w = alpha;
    #endif //AMBIENT_DECAL_MASK

    OUT.Stencil = float4(1, 0, 0, 0) * stencil.x;
    
    return OUT;
}

//just PS_DeferredTextured but with dithering
PS_OutputDeferred PS_DeferredTexturedAlphaClip(VS_OutputDeferred IN, float2 screenCoords : VPOS)
{
    PS_OutputDeferred OUT;
    
    #if defined(PARALLAX) && !defined(PARALLAX_STEEP)
        float2 viewDirTan = normalize(IN.ViewDirTangent.xyz + 0.00001).xy;
        float height = (tex2D(BumpSampler, IN.TexCoord).w * parallaxScaleBias) - (parallaxScaleBias / 2.0);
        float2 texCoord = saturate(viewDirTan * height + IN.TexCoord);
        float4 normalMap = tex2D(BumpSampler, texCoord);
    #elif defined(PARALLAX) && defined(PARALLAX_STEEP)
        const int numSamples = 8;
        const float stepSize = 1.0 / numSamples;

        float2 viewDirTan = normalize(IN.ViewDirTangent.xyz + 0.00001).xy;
        viewDirTan = -viewDirTan * parallaxScaleBias;

        float2 texCoord = IN.TexCoord;
        float4 normalMap = tex2D(BumpSampler, texCoord);
        float height = -normalMap.w;
        float layerHeight = -1.0;

        for(int i = 0; i < numSamples; i++)
        {
            float2 sampleTexCoord = texCoord + (viewDirTan * stepSize);
            float4 sampleNormalMap = tex2D(BumpSampler, sampleTexCoord);

            if(layerHeight <= height)
            {
                texCoord = sampleTexCoord;
                normalMap = sampleNormalMap;
                height = -normalMap.w;
                layerHeight += stepSize;
            }
        }
    #elif defined(NORMAL_MAP)
        float2 texCoord = IN.TexCoord;
        float4 normalMap = tex2D(BumpSampler, texCoord);
    #else
        float2 texCoord = IN.TexCoord;
    #endif

    float4 diffuse = tex2D(TextureSampler, texCoord);
    #ifdef EMISSIVE
        diffuse *= colorize;
    #endif

    #ifdef NO_DIFFUSE_WRITE
        float alpha = 0.0;
    #else
        float alpha = diffuse.w * IN.Color.w * globalScalars.x;
    #endif //NO_DIFFUSE_WRITE

    #ifdef DIRT_DECAL_MASK
        float dirtMask = dot(diffuse.xyz, dirtDecalMask.xyz) * IN.Color.w * globalScalars.x;
    #endif //DIRT_DECAL_MASK

    AlphaClip(globalScalars.x, screenCoords);

    float3 normal;
    #if defined(NO_NORMAL_WRITE)
        normal = float3(0, 0, 0);
        OUT.Normal = float4(normal, 0);
    #elif defined(NORMAL_MAP) || defined(PARALLAX)
        float3x3 tbn = float3x3(IN.TangentWorld.xyz, IN.BitangentWorld.xyz, IN.NormalWorldAndDepthColor.xyz);
        normal = UnpackNormalMap(normalMap);
        normal = normalize(mul(normal, tbn) + 0.00001);
        OUT.Normal.xyz = (normal + 1.0) * 0.5;
        #ifdef NO_DIFFUSE_WRITE
            OUT.Normal.w = normalMap.z * globalScalars.x;
        #elif defined(PARALLAX) && defined(DEPTH_SHIFT_SCALE) //?
            OUT.Normal.w = normalMap.z * alpha * globalScalars.x;
        #else
            OUT.Normal.w = alpha;
        #endif //NO_DIFFUSE_WRITE

        float v0 = dot(normalMap.xy, normalMap.xy) >= 0.02 ? 1.0 : 0.0;
    #else
        normal = normalize(IN.NormalWorldAndDepthColor.xyz + 0.00001);
        OUT.Normal.xyz = (normal + 1.0) * 0.5;
        OUT.Normal.w = alpha;
    #endif //NO_NORMAL_WRITE
    
    #if defined(NO_DIFFUSE_WRITE)
        OUT.Diffuse = float4(0, 0, 0, 0);
    #elif defined(DIRT_DECAL_MASK)
        OUT.Diffuse.xyz = IN.Color.xyz;
        OUT.Diffuse.w = dirtMask;
    #else
        OUT.Diffuse.xyz = diffuse.xyz;
        OUT.Diffuse.w = alpha;
    #endif //NO_DIFFUSE_WRITE

    #ifdef SPECULAR_MAP
        float4 specMap = tex2D(SpecSampler, texCoord);
        float specShininess = specMap.w * specularFactor;
        float specIntensity = dot(specMap.xyz, specMapIntMask.xyz) * specularColorFactor;
    #elif defined(SPECULAR)
        float specIntensity = specularColorFactor;
        float specShininess = specularFactor;
    #endif //SPECULAR_MAP

    #ifdef ENVIRONMENT_MAP
        float3 viewDir = -normalize(IN.ViewDir + 0.00001);
        float3 R = reflect(viewDir, normal);
        R = normalize(R + 0.00001);

        #ifdef CUBEMAP_ENVIRONMENT_MAP
            float3 specular = texCUBE(EnvironmentSampler, R).xyz;
        #else
            float3 specular = tex2D(EnvironmentSampler, (R.xy + 1.0) * -0.5).xyz;
        #endif //CUBEMAP_ENVIRONMENT_MAP

        #ifdef SPECULAR
            specular *= specIntensity;
        #endif

        OUT.Diffuse.xyz += (specular * reflectivePower);
    #endif //ENVIRONMENT_MAP

    //?
    #ifdef PARALLAX
        OUT.Diffuse.xyz *= v0;
        specIntensity *= v0;
    #endif //PARALLAX
    
    #ifdef SPECULAR
        OUT.SpecularAndAO.x = specIntensity * 0.5;
        OUT.SpecularAndAO.y = sqrt(specShininess / 512.0);
        #ifdef DIRT_DECAL_MASK
            OUT.SpecularAndAO.z = 0.0;
        #else
            OUT.SpecularAndAO.z = IN.Color.x;
        #endif //DIRT_DECAL_MASK
    #else
        #if defined(NO_SPECULAR_WRITE)
            OUT.SpecularAndAO.xyz = float3(0, 0, 0);
        #elif defined(EMISSIVE)
            OUT.SpecularAndAO.xyz = globalScalars.z * float3(0, 0, 1) + float3(0, 0.25, 0);
        #else
            OUT.SpecularAndAO.xyz = IN.Color.x * float3(0, 0, 1) + float3(0, 0.25, 0);
        #endif //NO_SPECULAR_WRITE
    #endif //SPECULAR

    #ifdef PARALLAX
        OUT.SpecularAndAO.z *= v0;
    #endif //PARALLAX

    #if defined(AMBIENT_DECAL_MASK)
        OUT.SpecularAndAO.w = saturate(1.0 - dot(diffuse.xyz, ambientDecalMask.xyz)) * alpha * globalScalars2.z;
    #elif defined(DIRT_DECAL_MASK)
        OUT.SpecularAndAO.w = dirtMask;
    #else
        OUT.SpecularAndAO.w = alpha;
    #endif //AMBIENT_DECAL_MASK

    OUT.Stencil = float4(1, 0, 0, 0) * stencil.x;
    
    return OUT;
}


struct VS_InputUnlit
{
    float3 Position : POSITION;
    float4 Color    : COLOR;
    float2 TexCoord : TEXCOORD0;
};

struct VS_OutputUnlit
{
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
    float4 Color    : COLOR;
};

VS_OutputUnlit VS_TransformUnlit(VS_InputUnlit IN)
{
    VS_OutputUnlit OUT;

    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);
    #ifndef DEPTH_SHIFT
        OUT.Position = posClip;
    #endif //DEPTH_SHIFT

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord);
    #else
        OUT.TexCoord = IN.TexCoord;
    #endif //ANIMATED

    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(posClip);
        OUT.Position.w = posClip.w;
    #endif

    OUT.Color = IN.Color;
    return OUT;
}


#ifndef NO_SKINNING
    struct VS_InputSkin
    {
        float3 Position     : POSITION;
        float4 BlendWeights : BLENDWEIGHT;
        float4 BlendIndices : BLENDINDICES;
        float2 TexCoord0    : TEXCOORD0;
        float3 Normal       : NORMAL;
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float4 Tangent      : TANGENT;
    #endif //NORMAL_MAP || PARALLAX
        float4 Color        : COLOR;
    };

    VS_Output VS_TransformSkin(VS_InputSkin IN)
    {
        VS_Output OUT;

        float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);
        float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz;
        float3 viewDir = gViewInverse[3].xyz - posWorld;

        #ifdef SPECULAR
            OUT.ViewDir = viewDir;
        #endif //SPECULAR
        OUT.PositionWorld.xyz = posWorld + gWorld[3].xyz;
        
        float3 normalWorld = mul(IN.Normal, (float3x3)gWorld);
        #if defined(NORMAL_MAP) || defined(PARALLAX)
            float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)gWorld);
            float3 bitangentWorld = cross(tangentWorld, normalWorld);
        #endif //NORMAL_MAP || PARALLAX

        OUT.NormalWorldAndDepthColor.xyz = normalWorld;

        #if defined(NORMAL_MAP) || defined(PARALLAX)
            OUT.TangentWorld.xyz = tangentWorld;
            OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
        #endif //NORMAL_MAP || PARALLAX

        #ifdef PARALLAX
            OUT.ViewDirTangent.x = dot(tangentWorld, viewDir);
            OUT.ViewDirTangent.y = dot(bitangentWorld, viewDir);
            OUT.ViewDirTangent.z = dot(normalWorld, viewDir);
        #endif //PARALLAX

        #ifdef ANIMATED
            OUT.TexCoord = ComputeUvAnimation(IN.TexCoord0);
        #endif //ANIMATED

        #ifdef DAY_NIGHT_EFFECTS
            OUT.Color.xy = ComputeDayNightEffects(IN.Color.xy);
        #else
            OUT.Color.xy = IN.Color.xy;
        #endif //DAY_NIGHT_EFFECTS

        float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);

        #ifdef DEPTH_SHIFT
            OUT.Position.xyz = ComputeDepthShift(posClip);
        #else
            OUT.Position.xyz = posClip.xyz;
        #endif //DEPTH_SHIFT

        OUT.Position.w = OUT.NormalWorldAndDepthColor.w = posClip.w;
        #ifndef ANIMATED
            OUT.TexCoord = IN.TexCoord0;
        #endif //ANIMATED
        OUT.Color.zw = IN.Color.zw;

        OUT.PositionWorld.w = 1.0;
        #ifdef PARALLAX
            OUT.ViewDirTangent.w = 1.0;
        #endif
        return OUT;
    }


    VS_OutputDeferred VS_TransformSkinD(VS_InputSkin IN)
    {
        VS_OutputDeferred OUT;

        float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);
        float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz;
        float3 viewDir = gViewInverse[3].xyz - posWorld;

        #ifdef ENVIRONMENT_MAP
            OUT.ViewDir = viewDir;
        #endif //ENVIRONMENT_MAP
        OUT.PositionWorld.xyz = posWorld;
        
        #ifdef PARALLAX
            float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)skinMtx);
            OUT.ViewDirTangent.x = dot(tangentWorld, viewDir);
            
            float3 normalWorld = mul(IN.Normal, (float3x3)skinMtx);
            float3 bitangentWorld = cross(tangentWorld, normalWorld);

            OUT.TangentWorld.xyz = tangentWorld;
            bitangentWorld *= IN.Tangent.w;
            OUT.ViewDirTangent.y = dot(bitangentWorld, viewDir);
            OUT.BitangentWorld.xyz = bitangentWorld;
            OUT.ViewDirTangent.z = dot(normalWorld, viewDir);
            OUT.NormalWorldAndDepthColor.xyz = normalWorld;
        #else
            float3 normalWorld = mul(IN.Normal, (float3x3)skinMtx);
            #if defined(NORMAL_MAP) || defined(PARALLAX)
                float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)skinMtx);
                float3 bitangentWorld = cross(tangentWorld, normalWorld);
            #endif //NORMAL_MAP

            OUT.NormalWorldAndDepthColor.xyz = normalWorld;

            #if defined(NORMAL_MAP)
                OUT.TangentWorld.xyz = tangentWorld;
                OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
            #endif //NORMAL_MAP
        #endif //PARALLAX

        #ifdef ANIMATED
            OUT.TexCoord = ComputeUvAnimation(IN.TexCoord0);
        #endif //ANIMATED

        #ifdef DAY_NIGHT_EFFECTS
            OUT.Color.xy = ComputeDayNightEffects(IN.Color.xy);
        #else
            OUT.Color.xy = IN.Color.xy;
        #endif //DIRT_DECAL_MASK

        float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);

        OUT.Position.xyz = posClip.xyz;

        OUT.Position.w = OUT.NormalWorldAndDepthColor.w = posClip.w;
        #ifndef ANIMATED
            OUT.TexCoord = IN.TexCoord0;
        #endif //ANIMATED
        OUT.Color.zw = IN.Color.zw;

        OUT.PositionWorld.w = 1.0;
        #ifdef PARALLAX
            OUT.ViewDirTangent.w = 1.0;
        #endif

        return OUT;
    }


    VS_OutputUnlit VS_TransformSkinUnlit(VS_InputSkin IN)
    {
        VS_OutputUnlit OUT;

        float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);
        float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz;
        
        float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);
        #ifndef DEPTH_SHIFT
            OUT.Position = posClip;
        #endif //DEPTH_SHIFT

        #ifdef ANIMATED
            OUT.TexCoord = ComputeUvAnimation(IN.TexCoord0);
        #else
            OUT.TexCoord = IN.TexCoord0;
        #endif //ANIMATED

        #ifdef DEPTH_SHIFT
            OUT.Position.xyz = ComputeDepthShift(posClip);
            OUT.Position.w = posClip.w;
        #endif

        OUT.Color = IN.Color;
        return OUT;
    }
#endif


struct VS_InputInst
{
    float3 Position                : POSITION;
    float2 TexCoord                : TEXCOORD0;
    float3 Normal                  : NORMAL;
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float4 Tangent                 : TANGENT; 
#endif //NORMAL_MAP || PARALLAX
    float4 WorldMatrixRow1AndColor : TEXCOORD1;
    float4 WorldMatrixRow2AndColor : TEXCOORD2;
    float4 WorldMatrixRow3AndColor : TEXCOORD3;
    float4 WorldMatrixRow4AndColor : TEXCOORD4;
};

struct VS_OutputInst
{
    float4 Position                 : POSITION;
    float2 TexCoord                 : TEXCOORD0;
    float4 NormalWorldAndDepthColor : TEXCOORD1;
#if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
    //view pos to vertex
    float3 ViewDir                  : TEXCOORD3;
#endif //SPECULAR || ENVIRONMENT_MAP
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld             : TEXCOORD4; 
    float3 BitangentWorld           : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color                    : COLOR0;
    float4 PositionWorld            : TEXCOORD6;
#ifdef PARALLAX
    //(tangent) view pos to vertex
    float4 ViewDirTangent           : TEXCOORD7;
#endif //PARALLAX
};

VS_OutputInst VS_TransformInst(VS_InputInst IN)
{
    VS_OutputInst OUT;
    
    float4x3 instanceWorldMtx = float4x3(IN.WorldMatrixRow1AndColor.xyz, IN.WorldMatrixRow2AndColor.xyz, IN.WorldMatrixRow3AndColor.xyz, IN.WorldMatrixRow4AndColor.xyz);
    float3 posWorld = mul(float4(IN.Position, 1.0), instanceWorldMtx).xyz;

    OUT.PositionWorld.xyz = mul(float4(posWorld, 1.0), gWorld).xyz;
    #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
        float3 viewDir = gViewInverse[3].xyz - OUT.PositionWorld.xyz;
        OUT.ViewDir = viewDir;
    #endif //SPECULAR

    float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
    #endif //NORMAL_MAP || PARALLAX

    OUT.NormalWorldAndDepthColor.xyz = normalWorld;
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX
    
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX
    
    #ifdef PARALLAX
        OUT.ViewDirTangent.x = dot(tangentWorld, viewDir);
        OUT.ViewDirTangent.y = dot(bitangentWorld, viewDir);
        OUT.ViewDirTangent.z = dot(normalWorld, viewDir);
    #endif //PARALLAX

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord);
    #endif //ANIMATED

    float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);
    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(posClip);
    #else
        OUT.Position.xyz = posClip.xyz;
    #endif //DEPTH_SHIFT
    OUT.Position.w = posClip.w;

    float4 vertexColor = float4(IN.WorldMatrixRow1AndColor.w, IN.WorldMatrixRow2AndColor.w, IN.WorldMatrixRow3AndColor.w, IN.WorldMatrixRow4AndColor.w);
    #ifdef DAY_NIGHT_EFFECTS
        OUT.Color.xy = ComputeDayNightEffects(vertexColor.xy);
    #else
        OUT.Color.xy = vertexColor.xy;
    #endif

    OUT.NormalWorldAndDepthColor.w = OUT.Position.w;
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord;
    #endif //ANIMATED
    OUT.Color.zw = vertexColor.zw;
    OUT.PositionWorld.w = 1.0;
    #ifdef PARALLAX
        OUT.ViewDirTangent.w = 1.0;
    #endif

    return OUT;
}


struct VS_InputUnlitInst
{
    float3 Position                : POSITION;
    float2 TexCoord                : TEXCOORD0;
    float4 WorldMatrixRow1AndColor : TEXCOORD1;
    float4 WorldMatrixRow2AndColor : TEXCOORD2;
    float4 WorldMatrixRow3AndColor : TEXCOORD3;
    float4 WorldMatrixRow4AndColor : TEXCOORD4;
};

VS_OutputUnlit VS_TransformUnlitInst(VS_InputUnlitInst IN)
{
    VS_OutputUnlit OUT;
    
    float4x3 instanceWorldMtx = float4x3(IN.WorldMatrixRow1AndColor.xyz, IN.WorldMatrixRow2AndColor.xyz, IN.WorldMatrixRow3AndColor.xyz, IN.WorldMatrixRow4AndColor.xyz);
    float3 posWorld = mul(float4(IN.Position, 1.0), instanceWorldMtx).xyz;

    float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);
    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(posClip);
    #else
        OUT.Position.xyz = posClip.xyz;
    #endif //DEPTH_SHIFT
    OUT.Position.w = posClip.w;

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord);
    #else
        OUT.TexCoord = IN.TexCoord;
    #endif //ANIMATED
    OUT.Color = float4(IN.WorldMatrixRow1AndColor.w, IN.WorldMatrixRow2AndColor.w, IN.WorldMatrixRow3AndColor.w, IN.WorldMatrixRow4AndColor.w);

    return OUT;
}

VS_OutputUnlit VS_TransformSkinInst(VS_InputUnlitInst IN)
{
    return VS_TransformUnlitInst(IN);
}


struct VS_InputParaboloid
{
    float3 Position : POSITION;
    float4 Color    : COLOR0;
    float2 TexCoord : TEXCOORD0;
    float3 Normal   : NORMAL;
};

struct VS_OutputParaboloid
{
    float4 Position            : POSITION;
    float2 TexCoord            : TEXCOORD0;
    float4 NormalWorldAndDepth : TEXCOORD1;
    //view pos to world pos 
    float3 ViewDir             : TEXCOORD3;
    float4 Color               : COLOR0;
};

VS_OutputParaboloid VS_TransformParaboloid(VS_InputParaboloid IN)
{
    VS_OutputParaboloid OUT;
    
    OUT.NormalWorldAndDepth.xyz = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);

    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;
    float3 viewDir = gViewInverse[3].xyz - posWorld;
    OUT.ViewDir = -viewDir;

    float3 posView = mul(float4(IN.Position, 1.0), gWorldView).xyz;
    posView.z += PARABOLOID_HEIGHT_OFFSET;
    float L = length(posView);
    posView.z = 1.0 - (posView.z / L);
    posView.z *= L;

    OUT.Position.xy = posView.xy / posView.z;
    OUT.NormalWorldAndDepth.w = L;
    L = 1.0 / (L + 1.0);
    OUT.Position.z = 1.0 - L;

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord);
    #endif //ANIMATED

    #ifdef DAY_NIGHT_EFFECTS
        OUT.Color.xy = ComputeDayNightEffects(IN.Color.xy);
    #else
        OUT.Color.xy = IN.Color.xy;
    #endif //DAY_NIGHT_EFFECTS

    OUT.Position.w = 1.0;
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord;
    #endif //ANIMATED
    OUT.Color.zw = IN.Color.zw;

    return OUT;
}


float4 PS_TexturedUnlit(VS_OutputUnlit IN, float2 screenCoords : VPOS) : COLOR
{
    AlphaClip(globalScalars.x, screenCoords);
    
    float4 color = tex2D(TextureSampler, IN.TexCoord) * IN.Color;

    #ifdef EMISSIVE
        color.xyz *= emissiveMultiplier;
        #if defined(EMISSIVE_NIGHT)
            color.xyz *= gDayNightEffects.w;
            color.w *= globalScalars.x;
        #elif defined(EMISSIVE_IDK)
            float v0 = 1.0 - globalScalars.x;
            v0 = 1.0 / (v0 * color.w - 1.0);
            float v1 = v0 * -globalScalars.x;
            v0 = globalScalars.x - (globalScalars.x * v0);
            v0 = globalScalars.y * v0 + v1;
            color.w *= v0;
        #else
            color.w *= globalScalars.x;
        #endif //EMISSIVE_NIGHT
        color *= colorize;
    #else
        color.w *= globalScalars.x;
    #endif //EMISSIVE

    return color;
}
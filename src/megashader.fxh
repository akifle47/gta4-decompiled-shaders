//base for most shaders. you should use or extend this to reduce code duplication unless you really need specialized shaders for an effect
#define PARABOLOID_HEIGHT_OFFSET 512

#include "megashader_todo.fxh"
#include "common_functions.fxh"
#include "common_shadow.fxh"
#include "common_lighting.fxh"
#include "shader_inputs.fxh"

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

#ifdef PARALLAX
    void ComputeParallax(in float3 fragToViewDirTangent, in float2 texCoordIn, out float2 texCoordOut, out float4 normalMapOut)
    {
        fragToViewDirTangent.xy = normalize(fragToViewDirTangent + 0.00001).xy;

        #if defined(PARALLAX_STEEP)
            const int numSamples = 8;
            const float stepSize = 1.0 / numSamples;
            
            fragToViewDirTangent.xy = -fragToViewDirTangent.xy * parallaxScaleBias;
            texCoordOut = texCoordIn;
            normalMapOut = tex2D(BumpSampler, texCoordOut);
            float height = -normalMapOut.w;
            float layerHeight = -1.0;

            for(int i = 0; i < numSamples; i++)
            {
                float2 sampleTexCoord = texCoordOut + (fragToViewDirTangent.xy * stepSize);
                float4 sampleNormalMap = tex2D(BumpSampler, sampleTexCoord);

                if(layerHeight <= height)
                {
                    texCoordOut = sampleTexCoord;
                    normalMapOut = sampleNormalMap;
                    height = -normalMapOut.w;
                    layerHeight += stepSize;
                }
            }
        #else
            float height = (tex2D(BumpSampler, texCoordIn).w * parallaxScaleBias) - (parallaxScaleBias / 2.0);
            #ifndef DEPTH_SHIFT_SCALE
                height = saturate(height);
            #endif //DEPTH_SHIFT_SCALE
            texCoordOut = saturate(fragToViewDirTangent.xy * height + texCoordIn);
            normalMapOut = tex2D(BumpSampler, texCoordOut);
        #endif //PARALLAX_STEEP
    }
#endif //PARALLAX

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
    float4 Position             : POSITION;
    float2 TexCoord             : TEXCOORD0;
    float4 NormalWorldAndDepth  : TEXCOORD1;
#if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
    //view pos to vertex
    float3 FragToViewDir        : TEXCOORD3;
#endif //SPECULAR || ENVIRONMENT_MAP
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld         : TEXCOORD4; 
    float3 BitangentWorld       : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color                : COLOR0;
    float4 PositionWorld        : TEXCOORD6;
#ifdef PARALLAX
    //(tangent) view pos to vertex
    float4 FragToViewDirTangent : TEXCOORD7;
#elif defined(WIRE)
    //xyw = original clip pos, z = ndc delta * 320?
    float4 WireParams1          : TEXCOORD7;
    //clip pos
    float4 WireParams2          : TEXCOORD8;
#endif //PARALLAX
};

VS_Output VS_Transform(VS_Input IN)
{
    VS_Output OUT;
    
    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;

    #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
        float3 fragToViewDir = gViewInverse[3].xyz - posWorld;
        OUT.FragToViewDir = fragToViewDir;
    #endif //SPECULAR || ENVIRONMENT_MAP
    OUT.PositionWorld.xyz = posWorld;
    
    float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
    #endif //NORMAL_MAP || PARALLAX

    OUT.NormalWorldAndDepth.xyz = normalWorld;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    #ifdef PARALLAX
        OUT.FragToViewDirTangent.x = dot(tangentWorld, fragToViewDir);
        OUT.FragToViewDirTangent.y = dot(bitangentWorld, fragToViewDir);
        OUT.FragToViewDirTangent.z = dot(normalWorld, fragToViewDir);
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
    #elif defined(WIRE)
        float4 originalPosClip = posClip;
        float3 v0 = IN.Position + mul(gViewInverse[0].xyz * Fade_Thickness, transpose((float3x3)gWorld)).xyz;
        float4 v1 = mul(float4(v0, 1), gWorldViewProj);

        OUT.WireParams1.z = (v1.x / v1.w) - (originalPosClip.x / originalPosClip.w);
        OUT.WireParams1.z = saturate(OUT.WireParams1.z * 320);

        float distFromView = distance(posWorld, gViewInverse[3].xyz);

        float4 v2 = mul(float4(IN.Position + IN.Normal, 1), gWorldViewProj);
        posClip.xy = (originalPosClip.xy - v2.xy) * 0.002;
        posClip.xy = originalPosClip.xy - (posClip.xy * distFromView);

        OUT.WireParams1.xyw = originalPosClip.xyw;
        OUT.Position = posClip;
        OUT.WireParams2 = posClip;
    #else //WIRE
        OUT.Position.xyz = posClip.xyz;
    #endif //DEPTH_SHIFT

    OUT.Position.w = OUT.NormalWorldAndDepth.w = posClip.w;
    
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord0;
    #endif //ANIMATED
    OUT.Color.zw = IN.Color.zw;

    OUT.PositionWorld.w = 1.0;
    #ifdef PARALLAX
        OUT.FragToViewDirTangent.w = 1.0;
    #endif
    return OUT;
}


struct VS_OutputDeferred
{
    float4 Position             : POSITION;
    float2 TexCoord             : TEXCOORD0;
    float4 NormalWorldAndDepth  : TEXCOORD1;
#ifdef ENVIRONMENT_MAP
    float3 FragToViewDir        : TEXCOORD3;
#endif //ENVIRONMENT_MAP
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld         : TEXCOORD4; 
    float3 BitangentWorld       : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color                : COLOR0;
    float4 PositionWorld        : TEXCOORD6;
#ifdef PARALLAX
    float4 FragToViewDirTangent : TEXCOORD7;
#endif //PARALLAX
};

//ignoring macros this produces the same result as VS_Transform just with some stuff moved around to generate the same(ish) assembly
VS_OutputDeferred VS_TransformD(VS_Input IN)
{
    VS_OutputDeferred OUT;
    
    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;
    float3 fragToViewDir = gViewInverse[3].xyz - posWorld;

    #ifdef ENVIRONMENT_MAP
        OUT.FragToViewDir = fragToViewDir;
    #endif //ENVIRONMENT_MAP
    OUT.PositionWorld.xyz = posWorld;
    
    #ifdef PARALLAX
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        OUT.FragToViewDirTangent.x = dot(tangentWorld, fragToViewDir);
        
        float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);

        OUT.TangentWorld.xyz = tangentWorld;
        bitangentWorld *= IN.Tangent.w;
        OUT.FragToViewDirTangent.y = dot(bitangentWorld, fragToViewDir);
        OUT.BitangentWorld.xyz = bitangentWorld;
        OUT.FragToViewDirTangent.z = dot(normalWorld, fragToViewDir);
        OUT.NormalWorldAndDepth.xyz = normalWorld;
    #else
        float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
        #if defined(NORMAL_MAP) || defined(PARALLAX)
            float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
            float3 bitangentWorld = cross(tangentWorld, normalWorld);
        #endif //NORMAL_MAP

        OUT.NormalWorldAndDepth.xyz = normalWorld;

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

    OUT.Position.xyz = posClip.xyz;
    OUT.Position.w = OUT.NormalWorldAndDepth.w = posClip.w;
    
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord0;
    #endif //ANIMATED
    OUT.Color.zw = IN.Color.zw;

    OUT.PositionWorld.w = 1.0;
    #ifdef PARALLAX
        OUT.FragToViewDirTangent.w = 1.0;
    #endif
    return OUT;
}

VS_OutputDeferred VS_TransformAlphaClipD(VS_Input IN)
{
    return VS_TransformD(IN);
}


PS_OutputDeferred DeferredTextured(bool dither, VS_OutputDeferred IN, float2 screenCoords)
{
    PS_OutputDeferred OUT;
    
    #if defined(PARALLAX)
        float2 texCoord;
        float4 normalMap;
        ComputeParallax(IN.FragToViewDirTangent.xyz, IN.TexCoord, texCoord, normalMap);
    #elif defined(NORMAL_MAP)
        float2 texCoord = IN.TexCoord;
        float4 normalMap = tex2D(BumpSampler, texCoord);
    #else
        float2 texCoord = IN.TexCoord;
    #endif //PARALLAX

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

    if(dither)
    {
        AlphaClip(globalScalars.x, screenCoords);
    }
    else
    {
        if(alpha <= 0.176470593)
            discard;
    }

    float3 normal;
    #if defined(NO_NORMAL_WRITE)
        normal = float3(0, 0, 0);
        OUT.Normal = float4(normal, 0);
    #elif defined(NORMAL_MAP) || defined(PARALLAX)
        float3x3 tbn = float3x3(IN.TangentWorld.xyz, IN.BitangentWorld.xyz, IN.NormalWorldAndDepth.xyz);
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
        normal = normalize(IN.NormalWorldAndDepth.xyz + 0.00001);
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
        float specPower = specMap.w * specularFactor;
        float specIntensity = dot(specMap.xyz, specMapIntMask.xyz) * specularColorFactor;
    #elif defined(SPECULAR)
        float specIntensity = specularColorFactor;
        float specPower = specularFactor;
    #endif //SPECULAR_MAP

    #ifdef ENVIRONMENT_MAP
        float3 viewToFragDir = -normalize(IN.FragToViewDir + 0.00001);
        float3 R = reflect(viewToFragDir, normal);
        R = normalize(R + 0.00001);

        #ifdef CUBEMAP_ENVIRONMENT_MAP
            float3 specular = texCUBE(EnvironmentSampler, R).xyz;
        #else
            float3 specular = tex2D(EnvironmentSampler, (R.xz + 1.0) * -0.5).xyz;
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
        OUT.SpecularAndAO.y = sqrt(specPower / 512.0);
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

PS_OutputDeferred PS_DeferredTextured(VS_OutputDeferred IN, float2 screenCoords : VPOS)
{
    #ifdef NO_DEFERRED_ALPHA_DITHER
        return DeferredTextured(false, IN, screenCoords);
    #else
        return DeferredTextured(true, IN, screenCoords);
    #endif //NO_DEFERRED_ALPHA_DITHER
}

//just PS_DeferredTextured but with dithering
PS_OutputDeferred PS_DeferredTexturedAlphaClip(VS_OutputDeferred IN, float2 screenCoords : VPOS)
{
    return DeferredTextured(true, IN, screenCoords);
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
    VS_Output VS_TransformSkin(VS_InputSkin IN)
    {
        VS_Output OUT;

        float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);
        float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz;
        float3 fragToViewDir = gViewInverse[3].xyz - posWorld;

        #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
            OUT.FragToViewDir = fragToViewDir;
        #endif //SPECULAR || ENVIRONMENT_MAP
        OUT.PositionWorld.xyz = posWorld + gWorld[3].xyz;
        
        float3 normalWorld = mul(IN.Normal, (float3x3)gWorld);
        #if defined(NORMAL_MAP) || defined(PARALLAX)
            float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)gWorld);
            float3 bitangentWorld = cross(tangentWorld, normalWorld);
        #endif //NORMAL_MAP || PARALLAX

        OUT.NormalWorldAndDepth.xyz = normalWorld;

        #if defined(NORMAL_MAP) || defined(PARALLAX)
            OUT.TangentWorld.xyz = tangentWorld;
            OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
        #endif //NORMAL_MAP || PARALLAX

        #ifdef PARALLAX
            OUT.FragToViewDirTangent.x = dot(tangentWorld, fragToViewDir);
            OUT.FragToViewDirTangent.y = dot(bitangentWorld, fragToViewDir);
            OUT.FragToViewDirTangent.z = dot(normalWorld, fragToViewDir);
        #endif //PARALLAX

        #ifdef ANIMATED
            OUT.TexCoord = ComputeUvAnimation(IN.TexCoord);
        #endif //ANIMATED

        #ifdef DAY_NIGHT_EFFECTS
            OUT.Color.xy = ComputeDayNightEffects(IN.Color.xy);
        #else
            OUT.Color.xy = IN.Color.xy;
        #endif //DAY_NIGHT_EFFECTS

        float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);

        #ifdef DEPTH_SHIFT
            OUT.Position.xyz = ComputeDepthShift(posClip);
    #elif defined(WIRE)
            float distFromView = distance(posWorld, gViewInverse[3].xyz);

            float4 v2 = mul(float4(IN.Position + IN.Normal, 1), gWorldViewProj);
            posClip.xy = (posClip.xy - v2.xy) * 0.002;
            posClip.xy = posClip.xy - (posClip.xy * distFromView);
            OUT.Position = posClip;
            OUT.WireParams1 = OUT.WireParams2 = float4(0, 0, 0, 0);
        #else //WIRE
            OUT.Position.xyz = posClip.xyz;
        #endif //DEPTH_SHIFT

        OUT.Position.w = OUT.NormalWorldAndDepth.w = posClip.w;
        #ifndef ANIMATED
            OUT.TexCoord = IN.TexCoord;
        #endif //ANIMATED
        OUT.Color.zw = IN.Color.zw;

        OUT.PositionWorld.w = 1.0;
        #ifdef PARALLAX
            OUT.FragToViewDirTangent.w = 1.0;
        #endif
        
        return OUT;
    }


    VS_OutputDeferred VS_TransformSkinD(VS_InputSkin IN)
    {
        VS_OutputDeferred OUT;

        float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);
        float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz;
        float3 fragToViewDir = gViewInverse[3].xyz - posWorld;

        #ifdef ENVIRONMENT_MAP
            OUT.FragToViewDir = fragToViewDir;
        #endif //ENVIRONMENT_MAP
        OUT.PositionWorld.xyz = posWorld;
        
        #ifdef PARALLAX
            float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)skinMtx);
            OUT.FragToViewDirTangent.x = dot(tangentWorld, fragToViewDir);
            
            float3 normalWorld = mul(IN.Normal, (float3x3)skinMtx);
            float3 bitangentWorld = cross(tangentWorld, normalWorld);

            OUT.TangentWorld.xyz = tangentWorld;
            bitangentWorld *= IN.Tangent.w;
            OUT.FragToViewDirTangent.y = dot(bitangentWorld, fragToViewDir);
            OUT.BitangentWorld.xyz = bitangentWorld;
            OUT.FragToViewDirTangent.z = dot(normalWorld, fragToViewDir);
            OUT.NormalWorldAndDepth.xyz = normalWorld;
        #else
            float3 normalWorld = mul(IN.Normal, (float3x3)skinMtx);
            #if defined(NORMAL_MAP) || defined(PARALLAX)
                float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)skinMtx);
                float3 bitangentWorld = cross(tangentWorld, normalWorld);
            #endif //NORMAL_MAP

            OUT.NormalWorldAndDepth.xyz = normalWorld;

            #if defined(NORMAL_MAP)
                OUT.TangentWorld.xyz = tangentWorld;
                OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
            #endif //NORMAL_MAP
        #endif //PARALLAX

        #ifdef ANIMATED
            OUT.TexCoord = ComputeUvAnimation(IN.TexCoord);
        #endif //ANIMATED

        #ifdef DAY_NIGHT_EFFECTS
            OUT.Color.xy = ComputeDayNightEffects(IN.Color.xy);
        #else
            OUT.Color.xy = IN.Color.xy;
        #endif //DIRT_DECAL_MASK

        float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);

        OUT.Position.xyz = posClip.xyz;

        OUT.Position.w = OUT.NormalWorldAndDepth.w = posClip.w;
        #ifndef ANIMATED
            OUT.TexCoord = IN.TexCoord;
        #endif //ANIMATED
        OUT.Color.zw = IN.Color.zw;

        OUT.PositionWorld.w = 1.0;
        #ifdef PARALLAX
            OUT.FragToViewDirTangent.w = 1.0;
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
    float4 Position             : POSITION;
    float2 TexCoord             : TEXCOORD0;
    float4 NormalWorldAndDepth  : TEXCOORD1;
#if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
    float3 FragToViewDir        : TEXCOORD3;
#endif //SPECULAR || ENVIRONMENT_MAP
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld         : TEXCOORD4; 
    float3 BitangentWorld       : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color                : COLOR0;
    float4 PositionWorld        : TEXCOORD6;
#ifdef PARALLAX
    float4 FragToViewDirTangent : TEXCOORD7;
#endif //PARALLAX
};

VS_OutputInst VS_TransformInst(VS_InputInst IN)
{
    VS_OutputInst OUT;
    
    float4x3 instanceWorldMtx = float4x3(IN.WorldMatrixRow1AndColor.xyz, IN.WorldMatrixRow2AndColor.xyz, IN.WorldMatrixRow3AndColor.xyz, IN.WorldMatrixRow4AndColor.xyz);
    float3 posWorld = mul(float4(IN.Position, 1.0), instanceWorldMtx).xyz;

    OUT.PositionWorld.xyz = mul(float4(posWorld, 1.0), gWorld).xyz;
    #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
        float3 fragToViewDir = gViewInverse[3].xyz - OUT.PositionWorld.xyz;
        OUT.FragToViewDir = fragToViewDir;
    #endif //SPECULAR

    float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
    #endif //NORMAL_MAP || PARALLAX

    OUT.NormalWorldAndDepth.xyz = normalWorld;
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX
    
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX
    
    #ifdef PARALLAX
        OUT.FragToViewDirTangent.x = dot(tangentWorld, fragToViewDir);
        OUT.FragToViewDirTangent.y = dot(bitangentWorld, fragToViewDir);
        OUT.FragToViewDirTangent.z = dot(normalWorld, fragToViewDir);
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

    OUT.NormalWorldAndDepth.w = OUT.Position.w;
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord;
    #endif //ANIMATED
    OUT.Color.zw = vertexColor.zw;
    OUT.PositionWorld.w = 1.0;
    #ifdef PARALLAX
        OUT.FragToViewDirTangent.w = 1.0;
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
    float3 ViewToFragDir       : TEXCOORD3;
    float4 Color               : COLOR0;
};

VS_OutputParaboloid VS_TransformParaboloid(VS_InputParaboloid IN)
{
    VS_OutputParaboloid OUT;
    
    OUT.NormalWorldAndDepth.xyz = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);

    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;
    OUT.ViewToFragDir = -(gViewInverse[3].xyz - posWorld);

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
            v0 = (globalScalars.x * v0) + globalScalars.x;
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

float4 TexturedLit(in int numLights, in bool instanced, in VS_Output IN, in float2 screenCoords)
{
    if(!instanced)
        AlphaClip(globalScalars.x, screenCoords);

    #if defined(PARALLAX)
        float2 texCoord;
        float4 normalMap;
        ComputeParallax(IN.FragToViewDirTangent.xyz, IN.TexCoord, texCoord, normalMap);
    #elif defined(NORMAL_MAP)
        float2 texCoord = IN.TexCoord;
        float4 normalMap = tex2D(BumpSampler, texCoord);
    #else
        float2 texCoord = IN.TexCoord;
    #endif //PARALLAX

    float4 diffuse = tex2D(TextureSampler, texCoord);

    #ifdef DIRT_DECAL_MASK
        float dirtMask = dot(diffuse.xyz, dirtDecalMask);
        diffuse = float4(1, 1, 1, dirtMask) * IN.Color;
    #endif //DIRT_DECAL_MASK

    #ifdef COLORIZE
        diffuse *= colorize;
    #endif //COLORIZE

    #ifdef EMISSIVE
        if(instanced)
        {
            diffuse *= colorize;
        }
        else
        {
            diffuse *= IN.Color;
            diffuse.xyz *= emissiveMultiplier;
            #if defined(EMISSIVE_NIGHT)
                diffuse.xyz *= gDayNightEffects.w;
                diffuse.w *= globalScalars.x;
            #elif defined(EMISSIVE_IDK)
                float v0 = 1.0 - globalScalars.x;
                v0 = 1.0 / (v0 * diffuse.w - 1.0);
                float v1 = v0 * -globalScalars.x;
                v0 = (globalScalars.x * v0) + globalScalars.x;
                v0 = globalScalars.y * v0 + v1;
                diffuse.w *= v0;
            #else
                diffuse.w *= globalScalars.x;
            #endif //EMISSIVE_NIGHT

            return diffuse * colorize;
        }
    #elif !defined(WIRE)
        diffuse.w *= IN.Color.w;
    #endif //EMISSIVE

    if(instanced)
        diffuse.xyz *= IN.Color.xyz;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3x3 tbn = float3x3(IN.TangentWorld.xyz, IN.BitangentWorld.xyz, IN.NormalWorldAndDepth.xyz);
        float3 normal = UnpackNormalMap(normalMap);
        normal = normalize(mul(normal, tbn) + 0.00001);

        #ifdef PARALLAX
            float v1 = dot(normalMap.xy, normalMap.xy) >= 0.02 ? 1.0 : 0.0;
        #endif //PARALLAX
    #else
        float3 normal = normalize(IN.NormalWorldAndDepth.xyz + 0.00001);
    #endif //NORMAL_MAP || PARALLAX

    float specIntensity = 1;
    float specPower = 1;
    #ifdef SPECULAR
        specIntensity = specularColorFactor;
        specPower = specularFactor;
    
        #ifdef SPECULAR_MAP
            float4 specMap = tex2D(SpecSampler, texCoord);
            specIntensity *= dot(specMap.xyz, specMapIntMask.xyz);
            specPower *= specMap.w;
        #endif //SPECULAR_MAP
    #endif //SPECULAR

    float ambientOcclusion = IN.Color.x;
    #ifdef EMISSIVE
        if(instanced)
            ambientOcclusion = globalScalars.z;
    #endif //EMISSIVE

    #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
        float3 viewToFragDir = -normalize(IN.FragToViewDir.xyz + 0.00001);
        float3 R = reflect(viewToFragDir, normal);
    #else
        float3 viewToFragDir = float3(0, 0, 0);
    #endif //SPECULAR || ENVIRONMENT_MAP

    #ifdef ENVIRONMENT_MAP
        #ifdef CUBEMAP_ENVIRONMENT_MAP
            float3 envRefl = texCUBE(EnvironmentSampler, normalize(R + 0.00001)).xyz;
        #else
            float3 envRefl = tex2D(EnvironmentSampler, (normalize(R + 0.00001).xz + 1) * -0.5).xyz;
        #endif //CUBEMAP_ENVIRONMENT_MAP

        envRefl *= reflectivePower;
        float envReflIntensity = diffuse.w * IN.Color.w >= 0.001 ? 1.0 / diffuse.w : 100;
        diffuse.xyz += envRefl * envReflIntensity;
    #endif //ENVIRONMENT_MAP
    
    #ifdef PARALLAX
        diffuse.xyz *= v1;
        ambientOcclusion *= v1;
        specIntensity *= v1;
    #endif //PARALLAX

    SurfaceProperties surfaceProperties;
    surfaceProperties.Diffuse = diffuse.xyz;
    surfaceProperties.Normal = normal;
    surfaceProperties.SpecularIntensity = specIntensity;
    surfaceProperties.SpecularPower = specPower;
    surfaceProperties.AmbientOcclusion = ambientOcclusion;
    float4 lighting = float4(ComputeLighting(numLights, true, IN.PositionWorld.xyz, viewToFragDir, surfaceProperties), globalScalars.x);
    if(!instanced)
        lighting.xyz = ComputeDepthEffects(1.0, lighting.xyz, IN.NormalWorldAndDepth.w);

    #ifdef WIRE
        float2 p1 = (IN.WireParams1.xy / IN.WireParams1.w) * float2(640, 576);
        float2 p2 = (IN.WireParams2.xy / IN.WireParams2.w) * float2(640, 576);

        float v0 = 1.0 - (distance(p1, p2) * 0.35);
        lighting.w = v0 >= 0.0 ? v0 * IN.WireParams1.z : 0.0;
    #else
        lighting.w *= diffuse.w;
    #endif //WIRE

    if(instanced)
        AlphaClip(globalScalars.x, lighting.w);

    return lighting;
}

float4 PS_TexturedZero(VS_Output IN, float2 screenCoords : VPOS) : COLOR
{
    return TexturedLit(0, false, IN, screenCoords);
}

float4 PS_TexturedFour(VS_Output IN, float2 screenCoords : VPOS) : COLOR
{
    return TexturedLit(4, false, IN, screenCoords);
}

float4 PS_TexturedEight(VS_Output IN, float2 screenCoords : VPOS) : COLOR
{
    return TexturedLit(8, false, IN, screenCoords);
}

float4 PS_TexturedEightInst(VS_Output IN, float2 screenCoords : VPOS) : COLOR
{
    return TexturedLit(8, true, IN, screenCoords);
}


struct InputBasic
{
    float2 TexCoord;
    float4 NormalWorldAndDepth;
    float3 FragToViewDir;
    float4 Color;
    float2 ScreenCoords;
};

float4 TexturedBasic(InputBasic IN)
{
    #ifndef DIFFUSE_ALPHA
        AlphaClip(globalScalars.x, IN.ScreenCoords);
    #endif //!DIFFUSE_ALPHA
    
    float4 diffuse = tex2D(TextureSampler, IN.TexCoord);
    #ifdef DIRT_DECAL_MASK
        diffuse *= IN.Color;
    #else
        diffuse.w *= IN.Color.w;
    #endif

    float3 normal = normalize(IN.NormalWorldAndDepth.xyz + 0.00001);
    
    #if defined(EMISSIVE)
        float ambientOcclusion = globalScalars.z;
    #elif defined(DIRT_DECAL_MASK)
        float ambientOcclusion = 1.0;
    #else
        float ambientOcclusion = IN.Color.x;
    #endif //EMISSIVE

    float specIntensity = 1.0;
    float specPower = 1.0;
    #ifdef SPECULAR
        specIntensity = specularColorFactor;
        specPower = specularFactor;
    #endif //SPECULAR

    #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
        float3 fragToViewDir = normalize(IN.FragToViewDir.xyz + 0.00001);
    #else
        float3 fragToViewDir = float3(0, 0, 0);
    #endif //SPECULAR || ENVIRONMENT_MAP

    SurfaceProperties surfaceProperties;
    surfaceProperties.Diffuse = diffuse.xyz;
    surfaceProperties.Normal = normal;
    surfaceProperties.SpecularIntensity = specIntensity;
    surfaceProperties.SpecularPower = specPower;
    surfaceProperties.AmbientOcclusion = ambientOcclusion;
    float4 lighting = float4(ComputeLighting(0, false, float3(-1, -1, -1), fragToViewDir, surfaceProperties), diffuse.w * globalScalars.x);

    #ifdef EMISSIVE
        diffuse.xyz *= IN.Color.xyz;
        #ifdef EMISSIVE_IDK
            lighting.xyz = diffuse.xyz * emissiveMultiplier;
        #else
            lighting.xyz += diffuse.xyz * emissiveMultiplier;
        #endif //EMISSIVE_IDK

        #ifdef EMISSIVE_NIGHT
            lighting.xyz *= gDayNightEffects.w;
        #endif //EMISSIVE_NIGHT
    #endif //EMISSIVE

    #ifdef DIFFUSE_ALPHA
        AlphaClip(lighting.w, IN.ScreenCoords);
    #endif //DIFFUSE_ALPHA

    float fogStartToEndFactor = saturate((IN.NormalWorldAndDepth.w - globalFogParams.x) / (globalFogParams.y - globalFogParams.x));
    lighting.xyz = lerp(lighting, globalFogColor, fogStartToEndFactor).xyz;

    return lighting;
}

float4 PS_TexturedBasic(VS_Output IN, float2 screenCoords : VPOS) : COLOR
{
    InputBasic inputBasic;
    inputBasic.TexCoord = IN.TexCoord;
    inputBasic.NormalWorldAndDepth = IN.NormalWorldAndDepth;
    #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
        inputBasic.FragToViewDir = IN.FragToViewDir;
    #else
        inputBasic.FragToViewDir = float3(0, 0, 0);
    #endif //SPECULAR || ENVIRONMENT_MAP
    inputBasic.Color = IN.Color;
    inputBasic.ScreenCoords = screenCoords;
    return TexturedBasic(inputBasic);
}

float4 PS_TexturedBasicParaboloid(VS_OutputParaboloid IN, float2 screenCoords : VPOS) : COLOR
{
    clip(IN.ViewToFragDir.z - PARABOLOID_HEIGHT_OFFSET);

    InputBasic inputBasic;
    inputBasic.TexCoord = IN.TexCoord;
    inputBasic.NormalWorldAndDepth = IN.NormalWorldAndDepth;
    inputBasic.FragToViewDir = IN.ViewToFragDir;
    inputBasic.Color = IN.Color;
    inputBasic.ScreenCoords = screenCoords;
    float4 lighting = TexturedBasic(inputBasic);

    float fogStartToEndFactor = saturate((IN.NormalWorldAndDepth.w - globalFogParams.x) / (globalFogParams.y - globalFogParams.x));
    lighting.xyz = lerp(lighting, globalFogColor, fogStartToEndFactor).xyz;
    lighting.w *= saturate((64 - IN.NormalWorldAndDepth.w) / 4);

    return lighting;
}

float4 PS_DeferredImposter() : COLOR
{
    return float4(0, 0, 0, 0);
}
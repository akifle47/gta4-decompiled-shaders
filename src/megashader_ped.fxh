#include "common_functions.fxh"
#include "common_shadow.fxh"
#include "shader_inputs.fxh"

#if defined(SPECULAR_MAP) && !defined(HAIR_SORTED_EXP)
    #define USE_SPECULAR_MAP 
#endif //SPECULAR_MAP && !HAIR_SORTED_EXP

float ComputeBoneDamage(int4 boneIndices, float4 boneWeights)
{
    int4 dmgIndex = boneIndices / 4;
    int4 mtxIndex = boneIndices % 4;

    const float4x4 identity = float4x4(1, 0, 0, 0,
                                       0, 1, 0, 0,
                                       0, 0, 1, 0,
                                       0, 0, 0, 1);
    float4 v0;
    v0.x = dot(gBoneDamage0[dmgIndex.x], identity[mtxIndex.x]);
    v0.y = dot(gBoneDamage0[dmgIndex.y], identity[mtxIndex.y]);
    v0.z = dot(gBoneDamage0[dmgIndex.z], identity[mtxIndex.z]);
    v0.w = dot(gBoneDamage0[dmgIndex.w], identity[mtxIndex.w]);

    return dot(v0, boneWeights);
}

struct VS_InputPed
{
    float3 Position : POSITION;
    float4 Color    : COLOR0;
    float2 TexCoord : TEXCOORD0;
    float3 Normal   : NORMAL;
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float4 Tangent  : TANGENT; 
#endif //NORMAL_MAP || PARALLAX
};

struct VS_OutputPed
{
    float4 Position            : POSITION;
    float2 TexCoord            : TEXCOORD0;
    float4 NormalWorldAndDepth : TEXCOORD1;
    float4 PositionWorld       : TEXCOORD2;
#if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
    float3 FragToViewDir       : TEXCOORD3;
#endif //SPECULAR || ENVIRONMENT_MAP
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld        : TEXCOORD4;
    float3 BitangentWorld      : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float  DamageMask          : TEXCOORD6;
    float4 Color               : COLOR0;
};

VS_OutputPed VS_PedTransform(VS_InputPed IN)
{
    VS_OutputPed OUT;

    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;
    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);
    OUT.PositionWorld.xyz = posWorld;
    OUT.Position = posClip;
    
    #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
        OUT.FragToViewDir = gViewInverse[3].xyz - posWorld;
    #endif //SPECULAR || ENVIRONMENT_MAP

    float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    OUT.TexCoord = IN.TexCoord;
    OUT.Color = IN.Color;
    OUT.DamageMask = 0;
    OUT.PositionWorld.w = 1;

    return OUT;
}


VS_OutputPed VS_PedTransformSkin(VS_InputSkin IN)
{
    VS_OutputPed OUT;

    #ifdef PED_BONE_DAMAGE
        if(gBoneDamageEnabled)
        {
            OUT.DamageMask = ComputeBoneDamage(D3DCOLORtoUBYTE4(IN.BlendIndices).bgra, IN.BlendWeights);
        }
        else
    #endif //PED_BONE_DAMAGE
    {
        OUT.DamageMask = 0;
    }

    float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);

    float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz;
    float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);
    OUT.PositionWorld = float4(posWorld + gWorld[3].xyz, 1);
    OUT.Position = posClip;

    #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
        OUT.FragToViewDir = gViewInverse[3].xyz - posWorld;
    #endif //SPECULAR || ENVIRONMENT_MAP

    float3 normalWorld = mul(IN.Normal, (float3x3)skinMtx);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)skinMtx);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    OUT.Color = IN.Color;
    OUT.TexCoord = IN.TexCoord;

    return OUT;
}

struct VS_OutputDeferredPed
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
#ifdef ENVIRONMENT_MAP
    float4 PositionWorld        : TEXCOORD2;
#else
    float4 PositionWorld        : TEXCOORD7;
#endif //ENVIRONMENT_MAP
    float  DamageMask           : TEXCOORD6;
};

VS_OutputDeferredPed VS_PedTransformD(VS_InputPed IN)
{
    VS_OutputDeferredPed OUT;

    float3 posWorld = mul(float4(IN.Position, 0.0), gWorld).xyz;
    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);
    OUT.PositionWorld = float4(posWorld + gWorld[3].xyz * 2, 1);
    OUT.Position = posClip;

    #ifdef ENVIRONMENT_MAP
        OUT.FragToViewDir = gViewInverse[3].xyz - posWorld;
    #endif //ENVIRONMENT_MAP

    float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    OUT.Color.x = (globalScalars2.y * globalScalars2.z) * (IN.Color.x * globalScalars.z - 1) + 1;
    OUT.Color.y = globalScalars2.w * IN.Color.y;
    #ifdef SUBSURFACE_SCATTERING
        OUT.Color.z = 1.0 - (IN.Color.y * IN.Color.x);
    #else
        OUT.Color.z = IN.Color.z;
    #endif //SUBSURFACE_SCATTERING
    OUT.Color.w = IN.Color.w;

    OUT.TexCoord = IN.TexCoord;
    OUT.DamageMask = 0;

    return OUT;
}

VS_OutputDeferredPed VS_PedTransformSkinD(VS_InputSkin IN)
{
    VS_OutputDeferredPed OUT;

    #ifdef PED_BONE_DAMAGE
        if(gBoneDamageEnabled)
        {
            OUT.DamageMask = ComputeBoneDamage(D3DCOLORtoUBYTE4(IN.BlendIndices).bgra, IN.BlendWeights);
        }
        else
    #endif //PED_BONE_DAMAGE
    {
        OUT.DamageMask = 0;
    }

    float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);

    float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz;
    float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);
    OUT.PositionWorld = float4(posWorld + gWorld[3].xyz, 1);
    OUT.Position = posClip;

    #ifdef ENVIRONMENT_MAP
        OUT.FragToViewDir = gViewInverse[3].xyz - posWorld;
    #endif //ENVIRONMENT_MAP

    float3 normalWorld = mul(IN.Normal, (float3x3)skinMtx);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)skinMtx);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    #ifdef ENVIRONMENT_MAP
        OUT.Color = IN.Color;
    #else
        OUT.Color.x = (globalScalars2.y * globalScalars2.z) * (IN.Color.x * globalScalars.z - 1) + 1;
        OUT.Color.y = globalScalars2.w * IN.Color.y;
        #ifdef SUBSURFACE_SCATTERING
            OUT.Color.z = 1.0 - (IN.Color.y * IN.Color.x);
        #else
            OUT.Color.z = IN.Color.z;
        #endif //SUBSURFACE_SCATTERING
        OUT.Color.w = IN.Color.w;
    #endif //ENVIRONMENT_MAP

    OUT.TexCoord = IN.TexCoord;

    return OUT;
}


PS_OutputDeferred PS_DeferredPedTextured(VS_OutputDeferredPed IN, float2 screenCoords : VPOS)
{
    PS_OutputDeferred OUT;

    float4 diffuse = tex2D(TextureSampler, IN.TexCoord);
    diffuse.w *= globalScalars.x;

    #ifdef USE_SPECULAR_MAP
        float4 specMap = tex2D(SpecSampler, IN.TexCoord);
        float specPower = specMap.w * specularFactor;
        float specIntensity = dot(specMap.xyz, specMapIntMask.xyz) * specularColorFactor;
    #else
        float specIntensity = 0;
        float specPower = 0.3125;
    #endif //USE_SPECULAR_MAP

    if(IN.DamageMask > 0)
    {
        float4 damageDiffTex = tex2D(damageTextureSampler, IN.TexCoord);
        if(damageDiffTex.w > 0)
        {
            #ifdef USE_SPECULAR_MAP
                float4 damageSpecTex = tex2D(damageSpecTextureSampler, IN.TexCoord);
                specPower = lerp(damageSpecTex.w * specularFactor, specPower, IN.DamageMask);
                float damageSpecInt = damageSpecTex.x + damageSpecTex.y + damageSpecTex.z;
                damageSpecInt = (damageSpecInt * IN.DamageMask * specularColorFactor) / 3;
                specIntensity = (1 - IN.DamageMask) * specIntensity + damageSpecInt;
            #endif //USE_SPECULAR_MAP

            float damageAlpha = 1 - (IN.DamageMask * damageDiffTex.w);
            float3 damage = damageDiffTex.xyz * damageDiffTex.w * IN.DamageMask;

            diffuse.xyz = diffuse.xyz * damageAlpha + damage;
        }
    }

    #ifdef HAIR_SORTED
        AlphaClip(diffuse.w, screenCoords);
    #else
        AlphaClip(globalScalars.x, screenCoords);
    #endif //HAIR_SORTED

    float4 normalMap = tex2D(BumpSampler, IN.TexCoord);
    float3 normal = UnpackNormalMap(normalMap);
    float3x3 tbn = float3x3(IN.TangentWorld.xyz, IN.BitangentWorld.xyz, IN.NormalWorldAndDepth.xyz);
    normal = normalize(mul(normal, tbn) + 0.00001);

    #ifdef SUBSURFACE_SCATTERING
        float v0 = dot(gDirectionalLight.xyz, normal) + SubScatWrap;
        v0 = max(v0 / (1 + SubScatWrap), 0);
        float v1 = saturate(v0 / SubScatWidth);
        v1 = (v1 * v1) * (v1 * -2 + 3);
        float v2 = v0 - (SubScatWidth * 2);
        v2 = saturate(v2 / -SubScatWidth);
        float v3 = v2 * -2 + 3;
        v2 = v2 * v2 * v3;
        v1 = v1 * v2;
        float3 subScattColor = v1 * SubColor.xyz * diffuse.w;
        diffuse.xyz += (subScattColor * 0.5);
    #endif //SUBSURFACE_SCATTERING

    OUT.Diffuse.xyz = diffuse.xyz * matMaterialColorScale.x;
    OUT.Diffuse.w = diffuse.w * IN.Color.w;
    
    #ifdef USE_SPECULAR_MAP
        specIntensity *= matMaterialColorScale.w;
        specPower *= matMaterialColorScale.w;
        #ifdef HAIR_SORTED
            specPower /= 1024.0;
        #else
            specPower /= 682.6666666666666;
        #endif //HAIR_SORTED
    #endif //USE_SPECULAR_MAP

    float3 viewToFragDir = IN.PositionWorld.xyz - gViewInverse[3].xyz;
    viewToFragDir = normalize(viewToFragDir + 0.00001);

    float specHighlight = dot(normal, viewToFragDir);
    specHighlight = specHighlight <= 0 ? specHighlight * 2 + 1 : 1;
    specHighlight = specHighlight >= 0 ? specHighlight * IN.Color.y : 0;
    specHighlight = specHighlight * specHighlight;

    specIntensity = specIntensity * 0.5 + specHighlight;

    #ifdef HAIR_SORTED_EXP
        OUT.Normal.xyz = (normal + 1) * 0.5;
        OUT.Normal.w = diffuse.w;
    #else
        OUT.Normal = EncodeGBufferNormal(normal);
    #endif //HAIR_SORTED_EXP

    OUT.SpecularAndAO.x = specIntensity * 0.5;

    #ifdef USE_SPECULAR_MAP
        OUT.SpecularAndAO.y = sqrt(specPower);
        OUT.SpecularAndAO.z = IN.Color.x + specHighlight;
    #else
        OUT.SpecularAndAO.y = specPower;
        OUT.SpecularAndAO.z = IN.Color.x;
    #endif //USE_SPECULAR_MAP

    #ifdef HAIR_SORTED_EXP
        OUT.SpecularAndAO.w = diffuse.w;
    #else
        OUT.SpecularAndAO.w = 1;
    #endif //HAIR_SORTED_EXP
    
    OUT.Stencil = float4(stencil.x, 0, 0, 0);

    return OUT;
}
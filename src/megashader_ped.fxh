#include "common_functions.fxh"
#include "common_shadow.fxh"

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
    float  Unknown             : TEXCOORD6;
    float4 Color               : COLOR0;
};

VS_OutputPed VS_PedTransform(VS_InputPed IN)
{
    VS_OutputPed OUT;

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

    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);
    OUT.Position = posClip;
    OUT.NormalWorldAndDepth.w = posClip.w;

    OUT.TexCoord = IN.TexCoord;
    OUT.Color = IN.Color;

    OUT.Unknown = 0;
    OUT.PositionWorld.w = 1;

    return OUT;
}


struct VS_InputSkinPed
{
    float3 Position     : POSITION;
    float4 BlendWeights : BLENDWEIGHT;
    float4 BlendIndices : BLENDINDICES;
    float2 TexCoord     : TEXCOORD0;
    float3 Normal       : NORMAL;
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float4 Tangent      : TANGENT; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color        : COLOR0;
};

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

VS_OutputDeferredPed VS_PedTransformSkinD(VS_InputSkinPed IN)
{
    VS_OutputDeferredPed OUT;

    #ifdef PED_BONE_DAMAGE
        if(gBoneDamageEnabled)
        {
            int4 boneIndices = D3DCOLORtoUBYTE4(IN.BlendIndices).bgra;
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

            OUT.DamageMask = dot(v0, IN.BlendWeights);
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
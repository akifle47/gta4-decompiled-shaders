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
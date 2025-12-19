#include "common.fxh" //todo?
#include "common_functions.fxh"

texture DiffuseTexture_layer0;
sampler TextureSampler_layer0<string UIName = "Diffuse Texture Layer 1";> = 
sampler_state
{
    Texture = <DiffuseTexture_layer0>;
    AddressU = WRAP;
    AddressV = WRAP;
    AddressW = WRAP;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
};

texture DiffuseTexture_layer1;
sampler TextureSampler_layer1<string UIName = "Diffuse Texture Layer 2";> = 
sampler_state
{
    Texture = <DiffuseTexture_layer1>;
    AddressU = WRAP;
    AddressV = WRAP;
    AddressW = WRAP;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
};

#if defined(TERRAIN_3LYR) || defined(TERRAIN_4LYR)
    texture DiffuseTexture_layer2;
    sampler TextureSampler_layer2<string UIName = "Diffuse Texture Layer 3";> = 
    sampler_state
    {
        Texture = <DiffuseTexture_layer2>;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
        MipFilter = LINEAR;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
    };
#endif //TERRAIN_3LYR || TERRAIN_4LYR

#if defined(TERRAIN_4LYR)
    texture DiffuseTexture_layer3;
    sampler TextureSampler_layer3<string UIName = "Diffuse Texture Layer 4";> = 
    sampler_state
    {
        Texture = <DiffuseTexture_layer3>;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
        MipFilter = LINEAR;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
    };
#endif //TERRAIN_4LYR

float3 materialDiffuse : MaterialDiffuse <string UIWidget = "slider"; float UIMin = 0.000000; float UIMax = 200.000000; float UIStep = 0.010000; string UIName = "diffuse color";> = float3(1.0, 1.0, 1.0);

struct VS_InputTerrain
{
    float3 Position           : POSITION;
    float4 Color              : COLOR;
    float2 Layer0TexCoord     : TEXCOORD0;
    float2 Layer1TexCoord     : TEXCOORD1;
    #if defined(TERRAIN_3LYR)
        float2 Layer2TexCoord : TEXCOORD2;
        float2 BlendWeights1  : TEXCOORD3;
        float2 BlendWeights2  : TEXCOORD4;
    #elif defined(TERRAIN_4LYR)
        float2 Layer2TexCoord : TEXCOORD2;
        float2 Layer3TexCoord : TEXCOORD3;
        float2 BlendWeights1  : TEXCOORD4;
        float2 BlendWeights2  : TEXCOORD5;
    #else
        float2 BlendWeights1  : TEXCOORD2;
    #endif //TERRAIN_3LYR
    float3 Normal             : NORMAL;
};

struct VS_OutputTerrainDeferred
{
    float4 Position           : POSITION;
    float2 Layer0TexCoord     : TEXCOORD0;
    float2 Layer1TexCoord     : TEXCOORD3;
    #if defined(TERRAIN_3LYR)
        float2 Layer2TexCoord : TEXCOORD4;
    #elif defined(TERRAIN_4LYR)
        float2 Layer2TexCoord : TEXCOORD4;
        float2 Layer3TexCoord : TEXCOORD5;
    #endif //TERRAIN_3LYR
    float4 ColorAndAO         : COLOR;
    float4 BlendWeights       : COLOR1;
    float3 PositionWorld      : TEXCOORD1;
    float3 NormalWorld        : TEXCOORD2;
};

VS_OutputTerrainDeferred VS_TransformDeferredC(VS_InputTerrain IN)
{
    VS_OutputTerrainDeferred OUT;

    OUT.Position = mul(float4(IN.Position, 1.0), gWorldViewProj);
    OUT.PositionWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;
    OUT.NormalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.000001).xyz;

    OUT.ColorAndAO.xyz = materialDiffuse;
    OUT.ColorAndAO.w = ComputeDayNightEffects(IN.Color.xy).x;
    
    OUT.Layer0TexCoord = IN.Layer0TexCoord;
    OUT.Layer1TexCoord = IN.Layer1TexCoord;
    OUT.BlendWeights.xy = IN.BlendWeights1;

    #if defined(TERRAIN_3LYR) || defined(TERRAIN_4LYR)
        OUT.Layer2TexCoord = IN.Layer2TexCoord;
        #if defined(TERRAIN_4LYR)
            OUT.Layer3TexCoord = IN.Layer3TexCoord;
        #endif //TERRAIN_4LYR
        OUT.BlendWeights.zw = IN.BlendWeights2.xy;
    #else
        OUT.BlendWeights.zw = float2(0, 0);
    #endif //TERRAIN_3LYR || TERRAIN_4LYR

    return OUT;
}
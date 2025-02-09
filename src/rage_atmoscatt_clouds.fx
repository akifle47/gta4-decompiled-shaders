#define NO_SKINNING
#define NO_LIGHTING
#define NO_SHADOWS
#define PAD_LIGHT_CONSTANTS
#define PAD_FORCED_COLOR
#include "common.fxh"

texture AttenuationMap;
sampler AttenuationSampler : AttenuationMap <string UIName = "Attenuation Map";>;
float SunElevation : SunElevation<string UIName = "Sun Elevation"; string UIWidget = "Numeric"; float UIMin = -10.000000; float UIMax = 10.000000; float UIStep = 0.500000;> = -1.000000;
float3 SunCentre : SunCentre;
float4 TexelSize : TexelSize = float4(0.0, 0.0, 0.0, 0.0);
texture DepthMap;
sampler DepthMapSampler = 
sampler_state
{
    Texture = <DepthMap>;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = NONE;
    AddressU = CLAMP;
    AddressV = CLAMP;
};
texture SkyMapTexture;
sampler SkyMapSampler = 
sampler_state
{
    Texture = <SkyMapTexture>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    AddressW = WRAP;
    MipFilter = LINEAR;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipMapLodBias = 0.000000;
};
texture MoonTexture;
sampler MoonSampler<string UIName = "MoonTexture";> = 
sampler_state
{
    Texture = <MoonTexture>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    AddressW = WRAP;
    MipFilter = LINEAR;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipMapLodBias = 0.000000;
    BorderColor = 0xffffffff;
};
texture MoonGlowTexture;
sampler MoonGlowSampler<string UIName = "MoonTexture";> = 
sampler_state
{
    Texture = <MoonGlowTexture>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    AddressW = CLAMP;
    MipFilter = LINEAR;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipMapLodBias = 0.000000;
    BorderColor = 0xffffffff;
};
texture StarFieldTexture;
sampler StarFieldSampler<string UIName = "StarFieldTexture";> = 
sampler_state
{
    Texture = <StarFieldTexture>;
    AddressU = WRAP;
    AddressV = WRAP;
    AddressW = WRAP;
    MipFilter = LINEAR;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipMapLodBias = 0.000000;
};
texture GalaxyTexture;
sampler GalaxySampler<string UIName = "GalaxyTexture";> = 
sampler_state
{
    Texture = <GalaxyTexture>;
    AddressU = WRAP;
    AddressV = WRAP;
    AddressW = WRAP;
    MipFilter = NONE;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipMapLodBias = 0.000000;
};
texture PerlinNoiseMap;
sampler PerlinNoiseSampler<string UIName = "Perlin Noise Map";> = 
sampler_state
{
    Texture = <PerlinNoiseMap>;
    AddressU = WRAP;
    AddressV = WRAP;
    AddressW = WRAP;
    MipFilter = LINEAR;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipMapLodBias = 0.000000;
};
texture HighDetailNoiseMap;
sampler HighDetailNoiseSampler<string UIName = "HighDetailNoiseMap";> = 
sampler_state
{
    Texture = <HighDetailNoiseMap>;
    AddressU = WRAP;
    AddressV = WRAP;
    AddressW = WRAP;
    MipFilter = LINEAR;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipMapLodBias = 0.000000;
};
texture HighDetailNoiseBumpMap;
sampler HighDetailNoiseBumpSampler<string UIName = "HighDetailNoiseBumpMap";> = 
sampler_state
{
    Texture = <HighDetailNoiseBumpMap>;
    AddressU = WRAP;
    AddressV = WRAP;
    AddressW = WRAP;
    MipFilter = LINEAR;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipMapLodBias = 0.000000;
};
float4 SunDirection : SunDirection;
float3 SkyColor : SkyColor;
float3 AzimuthColor : AzimuthColor;
float3 SunColor : SunColor;
float UnderLightStrength : UnderLightStrength;
float gtaSkyDomeClip : gtaSkyDomeClip = 0.000000;
float3 gtaWaterColor : gtaWaterColor = float3(0.0, 0.0, 0.0);
float MoonGlow : MoonGlow<string UIName = "Moon Glow"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 2.000000; float UIStep = 0.010000;> = 0.200000;
float2 SunAxias : SunAxias<string UIName = "Sun Axias"; string UIWidget = "Numeric"; float UIMin = -1.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = float2(1.0, 0.0);
float3 AzimuthColorEast : AzimuthColorEast<string UIName = "Azimuth Color East"; string UIWidget = "Color"; float UIMin = 0.000000; float UIMax = 1.000000;> = float3(1.0, 0.0, 1.0);
float AzimuthHeight : AzimuthHeight<string UIName = "Azimuth Height"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 20.000000;> = 8.000000;
float4 CloudColor : CloudColor<string UIName = "Cloud Color"; string UIWidget = "Color"; float UIMin = 0.000000; float UIMax = 1.000000;> = float4(0.930000, 1.0, 1.0, 1.0);
float4 SunsetColor : SunsetColor<string UIName = "Sunset Color"; string UIWidget = "Color"; float UIMin = 0.000000; float UIMax = 1.000000;> = float4(1.0, 0.510000, 0.380000, 1.0);
float CloudThreshold : CloudThreshold<string UIName = "Cloud Threshold"; string UIWidget = "Numeric"; float UIMin = -5.000000; float UIMax = 5.000000; float UIStep = 0.050000;> = 1.800000;
float CloudBias : CloudBias<string UIName = "Cloud Bias"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.050000;> = 0.800000;
float CloudFadeOut : CloudFadeOut<string UIName = "Cloud Fade Out"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.050000;> = 1.000000;
float TopCloudHeight : TopCloudHeight<string UIName = "Top Cloudlayer Height"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.050000;> = 2.000000;
float TopCloudDetail : TopCloudDetail<string UIName = "Top Cloudlayer Detail"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.050000;> = 3.000000;
float TopCloudThreshold : TopCloudThreshold<string UIName = "Top Cloudlayer Threshold"; string UIWidget = "Numeric"; float UIMin = -5.000000; float UIMax = 5.000000; float UIStep = 0.020000;> = 0.900000;
float4 TopCloudBiasDetailThresholdHeight : TopCloudBiasDetailThresholdHeight<string UIName = "Top CloudLayer Bias Height"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.020000;> = float4(0.400000, 3.0, 0.900000, 2.0);
float3 TopCloudColor : TopCloudColor<string UIName = "Top Cloud Color"; string UIWidget = "Color"; float UIMin = 0.000000; float UIMax = 1.000000;> = float3(0.930000, 1.0, 1.0);
float TopCloudLight : TopCloudLight<string UIName = "Top Cloud LIght"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 10.000000;> = 0.000000;
float CloudShadowStrength : CloudShadowStrength<string UIName = "Cloud Shadow Strength"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.025000;> = 0.400000;
float CloudShadowOffset : CloudShadowOffset<string UIName = "Cloud Shadow Offset"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = 0.120000;
float CloudInscatteringRange : CloudInscatteringRange<string UIName = "Cloud Inscattering Range"; string UIWidget = "Numeric"; float UIMin = 0.100000; float UIMax = 1.000000; float UIStep = 0.100000;> = 1.000000;
float AzimuthStrength : AzimuthStrength<string UIName = "Azimuth Strength"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.100000;> = 0.500000;
float4 CloudThicknessEdgeSmoothDetailScaleStrength : CloudThicknessEdgeSmoothDetailScaleStrength<string UIName = "Cloud Thickness &  EdgeSmooth DetailScale & Strength"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 64.000000; float UIStep = 0.100000;> = float4(0.350000, 1.0, 16.0, 0.150000);
float4 StarFieldBrightness : StarFieldBrightness;
float StarFieldUVRepeat : StarFieldUVRepeat<string UIName = "StarFieldUVRepeat"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 64.000000; float UIStep = 0.010000;> = 16.000000;
float2 GalaxyOffset : GalaxyOffset<string UIName = "GalaxyOffset"; string UIWidget = "Numeric"; float UIMin = -16.000000; float UIMax = 16.000000; float UIStep = 0.010000;> = float2(0.0, 0.0);
float4 MoonTexPosition : MoonTexPosition<string UIName = "MoonTexPosition"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 64.000000; float UIStep = 0.010000;> = float4(0.500000, 0.500000, 0.500000, 0.500000);
float4 MoonLight : MoonLight<string UIName = "Moon Light"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 64.000000; float UIStep = 0.010000;> = float4(0.500000, 0.500000, 0.500000, 1.0);
float StarThreshold : StarThreshold<string UIName = "StarField Threshold"; string UIWidget = "Numeric"; float UIMin = -1.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = 0.000000;
float MoonVisiblity : MoonVisiblity<string UIName = "Moon Visiblity"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 5.000000; float UIStep = 0.010000;> = 1.000000;
float SunSize : SunSize = 1.000000;
float4 MoonColorConstant : MoonColorConstant = float4(1.0, 1.0, 1.0, 1.0);
float3 MoonPosition : MoonPosition;
float3 MoonXVector : MoonXVector;
float3 MoonYVector : MoonYVector;
float2 DetailOffset : DetailOffset = float2(0.0, 0.0);
float TimeOfDay : TimeOfDay = 5.000000;
float HDRExposure : HDRExposure;
float HDRSunExposure : HDRSunExposure;
float3 HDRExposureClamp : HDRExposureClamp;
float dpMapNearClip : dpMapNearClip = 0.000000;
float dpMapFarClip : dpMapFarClip = 20000.000000;

//Vertex shaders
VertexShader VS_Main
<
    string AzimuthColor                                = "parameter register(66)";
    string AzimuthColorEast                            = "parameter register(67)";
    string AzimuthHeight                               = "parameter register(68)";
    string AzimuthStrength                             = "parameter register(71)";
    string CloudShadowOffset                           = "parameter register(70)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(72)";
    string DetailOffset                                = "parameter register(75)";
    string GalaxyOffset                                = "parameter register(74)";
    string SkyColor                                    = "parameter register(65)";
    string StarFieldUVRepeat                           = "parameter register(73)";
    string SunDirection                                = "parameter register(64)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(69)";
    string gWorld                                      = "parameter register(0)";
    string gWorldViewProj                              = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float3 AzimuthColor;
    //   float3 AzimuthColorEast;
    //   float AzimuthHeight;
    //   float AzimuthStrength;
    //   float CloudShadowOffset;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float2 DetailOffset;
    //   float2 GalaxyOffset;
    //   float3 SkyColor;
    //   float StarFieldUVRepeat;
    //   float4 SunDirection;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                                        Reg   Size
    //   ------------------------------------------- ----- ----
    //   gWorld                                      c0       4
    //   gWorldViewProj                              c8       4
    //   SunDirection                                c64      1
    //   SkyColor                                    c65      1
    //   AzimuthColor                                c66      1
    //   AzimuthColorEast                            c67      1
    //   AzimuthHeight                               c68      1
    //   TopCloudBiasDetailThresholdHeight           c69      1
    //   CloudShadowOffset                           c70      1
    //   AzimuthStrength                             c71      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c72      1
    //   StarFieldUVRepeat                           c73      1
    //   GalaxyOffset                                c74      1
    //   DetailOffset                                c75      1
    //
    
        vs_3_0
        def c4, -2, 3.14159274, 0.317732662, 0.100000001
        def c5, -0.0187292993, 0.0742610022, 1.57072878, 1.57079637
        def c6, 0.5, 1.5, 1, -0.212114394
        def c7, 2, -1, 0, 0
        dcl_position v0
        dcl_texcoord v1
        dcl_position o0
        dcl_texcoord o1.xyz
        dcl_texcoord1 o2.xyz
        dcl_texcoord2 o3
        dcl_texcoord3 o4
        dcl_texcoord4 o5.xyz
        dcl_texcoord5 o6.xyz
        mul r0.xyz, c1, v0.y
        mad r0.xyz, v0.x, c0, r0
        mad r0.xyz, v0.z, c2, r0
        mad r0.xyz, v0.w, c3, r0
        add r0.xyz, r0, -c3
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul r1.xyz, r0, r0.w
        mad r2.xy, r0.xzzw, -r0.w, c64.xzzw
        mov o2.xyz, r0
        mad r1.w, r1.y, c6.y, c6.x
        dp3 r0.x, r1.xzww, r1.xzww
        rsq r0.x, r0.x
        mul r0.xy, r1.xzzw, r0.x
        mad r0.zw, r0_abs.xyxy, c5.x, c5.y
        mad r0.zw, r0, r0_abs.xyxy, c6.w
        mad r0.zw, r0, r0_abs.xyxy, c5.z
        add r1.zw, -r0_abs.xyxy, c6.z
        slt r0.xy, r0, -r0
        rsq r1.z, r1.z
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        mul r0.w, r0.w, r1.w
        rcp r1.z, r1.z
        mul r0.z, r0.z, r1.z
        mad r1.z, r0.z, c4.x, c4.y
        mad r0.x, r1.z, r0.x, r0.z
        add r0.x, -r0.x, c5.w
        mov r1.zw, c4
        mad r2.z, r0.x, r1.z, c74.x
        mad r0.x, r0.w, c4.x, c4.y
        mad r0.x, r0.x, r0.y, r0.w
        add r0.x, -r0.x, c5.w
        mad r2.w, r0.x, r1.z, c74.y
        add r0.xy, r2.zwzw, c6.x
        mul o4.xy, r0, c73.x
        mov o4.zw, r0.xyxy
        mul r0.x, r1.w, c70.x
        mul r0.xy, r2, r0.x
        mad r0.zw, v1.xyxy, c7.x, c7.y
        mul r0.zw, r0, r0
        add r0.z, r0.w, r0.z
        add r0.z, -r0.z, c6.z
        mad o3.xy, r0, r0.z, v1
        add r0.xy, -c6.x, v1
        mul r0.zw, r0.xyxy, r0.xyxy
        add r0.z, r0.w, r0.z
        rsq r0.w, r0.z
        mul r1.zw, r0.xyxy, r0.w
        sge r0.w, -r0.z, r0.z
        mad r1.zw, r0.w, -r1, r1
        mul r0.zw, r0.z, r1
        mov r1.z, c72.z
        mad o3.zw, r0, r1.z, c75.xyxy
        mul r0.zw, r0.xyxy, c69.w
        mov r2.x, c6.x
        mad o5.xy, r0, c69.w, r2.x
        mul r0.xy, r0.zwzw, r0.zwzw
        add r0.x, r0.y, r0.x
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        add o5.z, -r0.x, c6.z
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        mad r0, v0.w, c11, r0
        rcp r1.z, r0.w
        mad o1.z, r0.z, -r1.z, c6.z
        mov o0, r0
        mul_sat r0.x, r1.y, c68.x
        mad r0.y, r1.x, c6.x, c6.x
        add r0.x, -r0.x, c6.z
        mul r0.x, r0.x, c71.x
        mov r1.xyz, c67
        add r1.xyz, -r1, c66
        mad r0.yzw, r0.y, r1.xxyz, c67.xxyz
        mad o6.xyz, r0.yzww, r0.x, c65
        mov o1.xy, v1
    
    // approximately 78 instruction slots used
};

VertexShader VS_DpFrontMain
<
    string AzimuthColor                                = "parameter register(66)";
    string AzimuthColorEast                            = "parameter register(67)";
    string AzimuthHeight                               = "parameter register(68)";
    string AzimuthStrength                             = "parameter register(71)";
    string CloudShadowOffset                           = "parameter register(70)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(72)";
    string DetailOffset                                = "parameter register(75)";
    string GalaxyOffset                                = "parameter register(74)";
    string SkyColor                                    = "parameter register(65)";
    string StarFieldUVRepeat                           = "parameter register(73)";
    string SunDirection                                = "parameter register(64)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(69)";
    string dpMapFarClip                                = "parameter register(76)";
    string gWorld                                      = "parameter register(0)";
    string gWorldViewProj                              = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float3 AzimuthColor;
    //   float3 AzimuthColorEast;
    //   float AzimuthHeight;
    //   float AzimuthStrength;
    //   float CloudShadowOffset;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float2 DetailOffset;
    //   float2 GalaxyOffset;
    //   float3 SkyColor;
    //   float StarFieldUVRepeat;
    //   float4 SunDirection;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   float dpMapFarClip;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                                        Reg   Size
    //   ------------------------------------------- ----- ----
    //   gWorld                                      c0       4
    //   gWorldViewProj                              c8       4
    //   SunDirection                                c64      1
    //   SkyColor                                    c65      1
    //   AzimuthColor                                c66      1
    //   AzimuthColorEast                            c67      1
    //   AzimuthHeight                               c68      1
    //   TopCloudBiasDetailThresholdHeight           c69      1
    //   CloudShadowOffset                           c70      1
    //   AzimuthStrength                             c71      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c72      1
    //   StarFieldUVRepeat                           c73      1
    //   GalaxyOffset                                c74      1
    //   DetailOffset                                c75      1
    //   dpMapFarClip                                c76      1
    //
    
        vs_3_0
        def c4, -0.0187292993, 0.0742610022, 1.57072878, 1.57079637
        def c5, -2, 3.14159274, 0.317732662, 0.100000001
        def c6, 1, 0.5, 1.5, -0.212114394
        def c7, 2, -1, 0, 0
        def c12, 0.5, 1, 0, -0.5
        dcl_position v0
        dcl_texcoord v1
        dcl_position o0
        dcl_texcoord o1.xyz
        dcl_texcoord1 o2.xyz
        dcl_texcoord2 o3
        dcl_texcoord3 o4
        dcl_texcoord4 o5.xyz
        dcl_texcoord5 o6.xyz
        mul r0.xyz, c1, v0.y
        mad r0.xyz, v0.x, c0, r0
        mad r0.xyz, v0.z, c2, r0
        mad r0.xyz, v0.w, c3, r0
        add r0.xyz, r0, -c3
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul r1.xyz, r0, r0.w
        mad r2.xy, r0.xzzw, -r0.w, c64.xzzw
        mov o2.xyz, r0
        mad r1.w, r1.y, c6.z, c6.y
        dp3 r0.x, r1.xzww, r1.xzww
        rsq r0.x, r0.x
        mul r0.xy, r1.xzzw, r0.x
        mad r0.zw, r0_abs.xyxy, c4.x, c4.y
        mad r0.zw, r0, r0_abs.xyxy, c6.w
        mad r0.zw, r0, r0_abs.xyxy, c4.z
        add r1.zw, -r0_abs.xyxy, c6.x
        slt r0.xy, r0, -r0
        rsq r1.z, r1.z
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        mul r0.w, r0.w, r1.w
        rcp r1.z, r1.z
        mul r0.z, r0.z, r1.z
        mad r1.z, r0.z, c5.x, c5.y
        mad r0.x, r1.z, r0.x, r0.z
        add r0.x, -r0.x, c4.w
        mov r1.zw, c5
        mad r2.z, r0.x, r1.z, c74.x
        mad r0.x, r0.w, c5.x, c5.y
        mad r0.x, r0.x, r0.y, r0.w
        add r0.x, -r0.x, c4.w
        mad r2.w, r0.x, r1.z, c74.y
        add r0.xy, r2.zwzw, c6.y
        mul o4.xy, r0, c73.x
        mov o4.zw, r0.xyxy
        mul r0.x, r1.w, c70.x
        mul r0.xy, r2, r0.x
        mad r0.zw, v1.xyxy, c7.x, c7.y
        mul r0.zw, r0, r0
        add r0.z, r0.w, r0.z
        add r0.z, -r0.z, c6.x
        mad o3.xy, r0, r0.z, v1
        add r0.xy, -c6.y, v1
        mul r0.zw, r0.xyxy, r0.xyxy
        add r0.z, r0.w, r0.z
        rsq r0.w, r0.z
        mul r1.zw, r0.xyxy, r0.w
        sge r0.w, -r0.z, r0.z
        mad r1.zw, r0.w, -r1, r1
        mul r0.zw, r0.z, r1
        mov r1.z, c72.z
        mad o3.zw, r0, r1.z, c75.xyxy
        mul r0.zw, r0.xyxy, c69.w
        mov r2.y, c6.y
        mad o5.xy, r0, c69.w, r2.y
        mul r0.xy, r0.zwzw, r0.zwzw
        add r0.x, r0.y, r0.x
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        add o5.z, -r0.x, c6.x
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add r0, r0, c11
        rcp r1.z, c76.x
        mad o1.z, r0.z, -r1.z, c6.x
        mul r1.z, r0.z, r1.z
        mov o0.z, r1.z
        mul_sat r1.y, r1.y, c68.x
        mad r1.x, r1.x, c6.y, c6.y
        add r1.y, -r1.y, c6.x
        mul r1.y, r1.y, c71.x
        mov r2.xyz, c67
        add r2.xyz, -r2, c66
        mad r1.xzw, r1.x, r2.xyyz, c67.xyyz
        mad o6.xyz, r1.xzww, r1.y, c65
        rcp r0.w, r0_abs.w
        mul r0.xyz, r0, r0.w
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mad r0.z, r0.z, r0.w, c6.x
        mul r0.xy, r0, r0.w
        rcp r0.z, r0.z
        mul r0.xyz, r0.xyxw, r0.z
        mad o0.xyw, r0.xyzz, c12.xyzz, c12.wzzy
        mov o1.xy, v1
    
    // approximately 88 instruction slots used
};

VertexShader VS_DpBackMain
<
    string AzimuthColor                                = "parameter register(66)";
    string AzimuthColorEast                            = "parameter register(67)";
    string AzimuthHeight                               = "parameter register(68)";
    string AzimuthStrength                             = "parameter register(71)";
    string CloudShadowOffset                           = "parameter register(70)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(72)";
    string DetailOffset                                = "parameter register(75)";
    string GalaxyOffset                                = "parameter register(74)";
    string SkyColor                                    = "parameter register(65)";
    string StarFieldUVRepeat                           = "parameter register(73)";
    string SunDirection                                = "parameter register(64)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(69)";
    string dpMapFarClip                                = "parameter register(76)";
    string gWorld                                      = "parameter register(0)";
    string gWorldViewProj                              = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float3 AzimuthColor;
    //   float3 AzimuthColorEast;
    //   float AzimuthHeight;
    //   float AzimuthStrength;
    //   float CloudShadowOffset;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float2 DetailOffset;
    //   float2 GalaxyOffset;
    //   float3 SkyColor;
    //   float StarFieldUVRepeat;
    //   float4 SunDirection;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   float dpMapFarClip;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                                        Reg   Size
    //   ------------------------------------------- ----- ----
    //   gWorld                                      c0       4
    //   gWorldViewProj                              c8       4
    //   SunDirection                                c64      1
    //   SkyColor                                    c65      1
    //   AzimuthColor                                c66      1
    //   AzimuthColorEast                            c67      1
    //   AzimuthHeight                               c68      1
    //   TopCloudBiasDetailThresholdHeight           c69      1
    //   CloudShadowOffset                           c70      1
    //   AzimuthStrength                             c71      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c72      1
    //   StarFieldUVRepeat                           c73      1
    //   GalaxyOffset                                c74      1
    //   DetailOffset                                c75      1
    //   dpMapFarClip                                c76      1
    //
    
        vs_3_0
        def c4, -0.0187292993, 0.0742610022, 1.57072878, 1.57079637
        def c5, -2, 3.14159274, 0.317732662, 0.100000001
        def c6, 1, 0.5, 1.5, -0.212114394
        def c7, 2, -1, -0.5, -0
        dcl_position v0
        dcl_texcoord v1
        dcl_position o0
        dcl_texcoord o1.xyz
        dcl_texcoord1 o2.xyz
        dcl_texcoord2 o3
        dcl_texcoord3 o4
        dcl_texcoord4 o5.xyz
        dcl_texcoord5 o6.xyz
        mul r0.xyz, c1, v0.y
        mad r0.xyz, v0.x, c0, r0
        mad r0.xyz, v0.z, c2, r0
        mad r0.xyz, v0.w, c3, r0
        add r0.xyz, r0, -c3
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul r1.xyz, r0, r0.w
        mad r2.xy, r0.xzzw, -r0.w, c64.xzzw
        mov o2.xyz, r0
        mad r1.w, r1.y, c6.z, c6.y
        dp3 r0.x, r1.xzww, r1.xzww
        rsq r0.x, r0.x
        mul r0.xy, r1.xzzw, r0.x
        mad r0.zw, r0_abs.xyxy, c4.x, c4.y
        mad r0.zw, r0, r0_abs.xyxy, c6.w
        mad r0.zw, r0, r0_abs.xyxy, c4.z
        add r1.zw, -r0_abs.xyxy, c6.x
        slt r0.xy, r0, -r0
        rsq r1.z, r1.z
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        mul r0.w, r0.w, r1.w
        rcp r1.z, r1.z
        mul r0.z, r0.z, r1.z
        mad r1.z, r0.z, c5.x, c5.y
        mad r0.x, r1.z, r0.x, r0.z
        add r0.x, -r0.x, c4.w
        mov r1.zw, c5
        mad r2.z, r0.x, r1.z, c74.x
        mad r0.x, r0.w, c5.x, c5.y
        mad r0.x, r0.x, r0.y, r0.w
        add r0.x, -r0.x, c4.w
        mad r2.w, r0.x, r1.z, c74.y
        add r0.xy, r2.zwzw, c6.y
        mul o4.xy, r0, c73.x
        mov o4.zw, r0.xyxy
        mul r0.x, r1.w, c70.x
        mul r0.xy, r2, r0.x
        mad r0.zw, v1.xyxy, c7.x, c7.y
        mul r0.zw, r0, r0
        add r0.z, r0.w, r0.z
        add r0.z, -r0.z, c6.x
        mad o3.xy, r0, r0.z, v1
        add r0.xy, -c6.y, v1
        mul r0.zw, r0.xyxy, r0.xyxy
        add r0.z, r0.w, r0.z
        rsq r0.w, r0.z
        mul r1.zw, r0.xyxy, r0.w
        sge r0.w, -r0.z, r0.z
        mad r1.zw, r0.w, -r1, r1
        mul r0.zw, r0.z, r1
        mov r1.z, c72.z
        mad o3.zw, r0, r1.z, c75.xyxy
        mul r0.zw, r0.xyxy, c69.w
        mov r2.y, c6.y
        mad o5.xy, r0, c69.w, r2.y
        mul r0.xy, r0.zwzw, r0.zwzw
        add r0.x, r0.y, r0.x
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        add o5.z, -r0.x, c6.x
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add r0, r0, c11
        rcp r1.z, c76.x
        mad o1.z, r0.z, -r1.z, c6.x
        mul r1.z, r0.z, r1.z
        mov o0.z, r1.z
        mul_sat r1.y, r1.y, c68.x
        mad r1.x, r1.x, c6.y, c6.y
        add r1.y, -r1.y, c6.x
        mul r1.y, r1.y, c71.x
        mov r2.xyz, c67
        add r2.xyz, -r2, c66
        mad r1.xzw, r1.x, r2.xyyz, c67.xyyz
        mad o6.xyz, r1.xzww, r1.y, c65
        rcp r0.w, r0_abs.w
        mul r0.xyz, r0, r0.w
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mad r0.z, r0.z, r0.w, c6.x
        mul r0.xy, r0, r0.w
        rcp r0.z, r0.z
        mul r0.xyz, r0.xyxw, r0.z
        mad o0.xyw, r0.xyzz, -c7.zyzw, -c7.zwzy
        mov o1.xy, v1
    
    // approximately 88 instruction slots used
};

VertexShader VS_MiniSky
<
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        vs_3_0
        def c0, 2, 0, -1, 1
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1.xy
        mad o0, v0.xyxx, c0.xxyy, c0.zzyw
        mad o1.xy, v0, c0.wzzw, c0.ywzw
    
    // approximately 2 instruction slots used
};

VertexShader VS_BlurSky
<
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        vs_3_0
        def c0, 2, 0, -1, 1
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1.xy
        mad o0, v0.xyxx, c0.xxyy, c0.zzyw
        mad o1.xy, v0, c0.wzzw, c0.ywzw
    
    // approximately 2 instruction slots used
};

VertexShader VS_DpGTAMain
<
    string AzimuthColor                                = "parameter register(66)";
    string AzimuthColorEast                            = "parameter register(67)";
    string AzimuthHeight                               = "parameter register(68)";
    string AzimuthStrength                             = "parameter register(71)";
    string CloudShadowOffset                           = "parameter register(70)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(72)";
    string DetailOffset                                = "parameter register(75)";
    string GalaxyOffset                                = "parameter register(74)";
    string SkyColor                                    = "parameter register(65)";
    string StarFieldUVRepeat                           = "parameter register(73)";
    string SunDirection                                = "parameter register(64)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(69)";
    string gWorld                                      = "parameter register(0)";
    string gWorldView                                  = "parameter register(4)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float3 AzimuthColor;
    //   float3 AzimuthColorEast;
    //   float AzimuthHeight;
    //   float AzimuthStrength;
    //   float CloudShadowOffset;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float2 DetailOffset;
    //   float2 GalaxyOffset;
    //   float3 SkyColor;
    //   float StarFieldUVRepeat;
    //   float4 SunDirection;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldView;
    //
    //
    // Registers:
    //
    //   Name                                        Reg   Size
    //   ------------------------------------------- ----- ----
    //   gWorld                                      c0       4
    //   gWorldView                                  c4       4
    //   SunDirection                                c64      1
    //   SkyColor                                    c65      1
    //   AzimuthColor                                c66      1
    //   AzimuthColorEast                            c67      1
    //   AzimuthHeight                               c68      1
    //   TopCloudBiasDetailThresholdHeight           c69      1
    //   CloudShadowOffset                           c70      1
    //   AzimuthStrength                             c71      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c72      1
    //   StarFieldUVRepeat                           c73      1
    //   GalaxyOffset                                c74      1
    //   DetailOffset                                c75      1
    //
    
        vs_3_0
        def c8, 512, 1, 1.5, 0.5
        def c9, -2, 3.14159274, 1.57079637, 0.317732662
        def c10, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
        def c11, 0.100000001, 2, -1, 0
        dcl_position v0
        dcl_texcoord v1
        dcl_position o0
        dcl_texcoord o1.xyz
        dcl_texcoord1 o2.xyz
        dcl_texcoord2 o3
        dcl_texcoord3 o4
        dcl_texcoord4 o5.xyz
        dcl_texcoord5 o6.xyz
        mul r0.xyz, c1, v0.y
        mad r0.xyz, v0.x, c0, r0
        mad r0.xyz, v0.z, c2, r0
        mad r0.xyz, v0.w, c3, r0
        add r0.xyz, r0, -c3
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul r1.xyz, r0, r0.w
        mad r2.xy, r0.xzzw, -r0.w, c64.xzzw
        mov o2.xyz, r0
        mad r1.w, r1.y, c8.z, c8.w
        dp3 r0.x, r1.xzww, r1.xzww
        rsq r0.x, r0.x
        mul r0.xy, r1.xzzw, r0.x
        mad r0.zw, r0_abs.xyxy, c10.x, c10.y
        mad r0.zw, r0, r0_abs.xyxy, c10.z
        mad r0.zw, r0, r0_abs.xyxy, c10.w
        add r1.zw, -r0_abs.xyxy, c8.y
        slt r0.xy, r0, -r0
        rsq r1.z, r1.z
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        mul r0.w, r0.w, r1.w
        rcp r1.z, r1.z
        mul r0.z, r0.z, r1.z
        mad r1.z, r0.z, c9.x, c9.y
        mad r0.x, r1.z, r0.x, r0.z
        add r0.x, -r0.x, c9.z
        mov r1.w, c9.w
        mad r2.z, r0.x, r1.w, c74.x
        mad r0.x, r0.w, c9.x, c9.y
        mad r0.x, r0.x, r0.y, r0.w
        add r0.x, -r0.x, c9.z
        mad r2.w, r0.x, r1.w, c74.y
        add r0.xy, r2.zwzw, c8.w
        mul o4.xy, r0, c73.x
        mov o4.zw, r0.xyxy
        mov r0.x, c11.x
        mul r0.x, r0.x, c70.x
        mul r0.xy, r2, r0.x
        mad r0.zw, v1.xyxy, c11.y, c11.z
        mul r0.zw, r0, r0
        add r0.z, r0.w, r0.z
        add r0.z, -r0.z, c8.y
        mad o3.xy, r0, r0.z, v1
        add r0.xy, -c8.w, v1
        mul r0.zw, r0.xyxy, r0.xyxy
        add r0.z, r0.w, r0.z
        rsq r0.w, r0.z
        mul r1.zw, r0.xyxy, r0.w
        sge r0.w, -r0.z, r0.z
        mad r1.zw, r0.w, -r1, r1
        mul r0.zw, r0.z, r1
        mov r1.z, c72.z
        mad o3.zw, r0, r1.z, c75.xyxy
        mul r0.zw, r0.xyxy, c69.w
        mov r1.w, c8.w
        mad o5.xy, r0, c69.w, r1.w
        mul r0.xy, r0.zwzw, r0.zwzw
        add r0.x, r0.y, r0.x
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        add o5.z, -r0.x, c8.y
        mul r0.xyz, c5, v0.y
        mad r0.xyz, v0.x, c4, r0
        mad r0.xyz, v0.z, c6, r0
        add r0.xyz, r0, c7
        add r0.w, r0.z, c8.x
        dp3 r0.w, r0.xyww, r0.xyww
        rsq r0.w, r0.w
        rcp r1.z, r0.w
        add r1.w, r1.z, c8.y
        rcp r1.w, r1.w
        add r2.z, -r1.w, c8.y
        mad o1.z, r2.z, -c8.y, c8.y
        mul_sat r1.y, r1.y, c68.x
        mad r1.x, r1.x, c8.w, c8.w
        add r1.y, -r1.y, c8.y
        mul r1.y, r1.y, c71.x
        mov r3.xyz, c67
        add r3.xyz, -r3, c66
        mad r3.xyz, r1.x, r3, c67
        mad o6.xyz, r3, r1.y, c65
        add r0.z, r0.z, c8.x
        mad r0.z, r0.z, -r0.w, c8.y
        mul r0.z, r1.z, r0.z
        rcp r0.z, r0.z
        mul r2.xy, r0, r0.z
        mul r0.xyz, r2, c8.zzyw
        mov o0.xyz, r0
        mov o0.w, c8.y
        mov o1.xy, v1
    
    // approximately 92 instruction slots used
};

VertexShader VS_MainFast
<
    string AzimuthColor                      = "parameter register(65)";
    string AzimuthColorEast                  = "parameter register(66)";
    string AzimuthHeight                     = "parameter register(67)";
    string AzimuthStrength                   = "parameter register(70)";
    string CloudFadeOut                      = "parameter register(68)";
    string GalaxyOffset                      = "parameter register(72)";
    string MoonTexPosition                   = "parameter register(73)";
    string SkyColor                          = "parameter register(64)";
    string StarFieldUVRepeat                 = "parameter register(71)";
    string TopCloudBiasDetailThresholdHeight = "parameter register(69)";
    string gWorld                            = "parameter register(0)";
    string gWorldViewProj                    = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float3 AzimuthColor;
    //   float3 AzimuthColorEast;
    //   float AzimuthHeight;
    //   float AzimuthStrength;
    //   float CloudFadeOut;
    //   float2 GalaxyOffset;
    //   float4 MoonTexPosition;
    //   float3 SkyColor;
    //   float StarFieldUVRepeat;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                              Reg   Size
    //   --------------------------------- ----- ----
    //   gWorld                            c0       4
    //   gWorldViewProj                    c8       4
    //   SkyColor                          c64      1
    //   AzimuthColor                      c65      1
    //   AzimuthColorEast                  c66      1
    //   AzimuthHeight                     c67      1
    //   CloudFadeOut                      c68      1
    //   TopCloudBiasDetailThresholdHeight c69      1
    //   AzimuthStrength                   c70      1
    //   StarFieldUVRepeat                 c71      1
    //   GalaxyOffset                      c72      1
    //   MoonTexPosition                   c73      1
    //
    
        vs_3_0
        def c4, 4, 0.5, 1, -0.212114394
        def c5, -2, 3.14159274, 0.317732662, 0.5
        def c6, -0.0187292993, 0.0742610022, 1.57072878, 1.57079637
        def c7, 1, 1.5, 0, 0.5
        dcl_position v0
        dcl_texcoord v1
        dcl_position o0
        dcl_texcoord o1
        dcl_texcoord1 o2
        dcl_texcoord2 o3
        dcl_texcoord3 o4
        dcl_texcoord4 o5.xyz
        mul r0, c1.yxyz, v0.y
        mad r0, v0.x, c0.yxyz, r0
        mad r0, v0.z, c2.yxyz, r0
        mad r0, v0.w, c3.yxyz, r0
        add r0, r0, -c3.yxyz
        dp3 r1.x, r0.yzww, r0.yzww
        rsq r1.x, r1.x
        mul r1, r0, r1.x
        mov r2.xy, c4
        mad_sat o3.w, r1.x, r2.x, -c68.x
        mad r2.xzw, r1.yyzw, c7.xyyx, c7.zywz
        dp3 r0.x, r2.xzww, r2.xzww
        rsq r0.x, r0.x
        mul r1.xw, r1.yyzw, r0.x
        mad r2.xz, r1_abs.xyww, c6.x, c6.y
        mad r2.xz, r2, r1_abs.xyww, c4.w
        mad r2.xz, r2, r1_abs.xyww, c6.z
        add r3.xy, -r1_abs.xwzw, c4.z
        slt r1.xw, r1, -r1
        rsq r0.x, r3.x
        rsq r2.w, r3.y
        rcp r2.w, r2.w
        mul r2.z, r2.z, r2.w
        rcp r0.x, r0.x
        mul r0.x, r2.x, r0.x
        mad r2.x, r0.x, c5.x, c5.y
        mad r0.x, r2.x, r1.x, r0.x
        add r0.x, -r0.x, c6.w
        mad r3.x, r0.x, c5.z, c5.w
        mad r0.x, r2.z, c5.x, c5.y
        mad r0.x, r0.x, r1.w, r2.z
        add r0.x, -r0.x, c6.w
        mad r3.y, r0.x, c5.z, c5.w
        add r1.xw, r3.xyzy, c72.xyzy
        add r2.xz, r3.xyyw, -c73.zyww
        mul o2.xy, r2.xzzw, c73.x
        mul o4.xy, r1.xwzw, c71.x
        mov o4.zw, r1.xyxw
        add r1.xw, -c4.y, v1.xyzy
        mul r2.xz, r1.xyww, c69.w
        mad o3.xy, r1.xwzw, c69.w, r2.y
        mul r1.xw, r2.xyzz, r2.xyzz
        add r0.x, r1.w, r1.x
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        add o3.z, -r0.x, c4.z
        mul r2, c9, v0.y
        mad r2, v0.x, c8, r2
        mad r2, v0.z, c10, r2
        mad r2, v0.w, c11, r2
        rcp r0.x, r2.w
        mad o1.z, r2.z, -r0.x, c4.z
        mov o0, r2
        mul_sat r0.x, r1.z, c67.x
        mad r1.x, r1.y, c4.y, c4.y
        add r0.x, -r0.x, c4.z
        mul r0.x, r0.x, c70.x
        mov r2.xyz, c66
        add r1.yzw, -r2.xxyz, c65.xxyz
        mad r1.xyz, r1.x, r1.yzww, c66
        mad o5.xyz, r1, r0.x, c64
        mov o1.xy, v1
        mov o1.w, r0.w
        mov o2.zw, r0.xyyz
    
    // approximately 64 instruction slots used
};

VertexShader VS_Stencil
<
    string gWorldViewProj = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   gWorldViewProj c8       4
    //
    
        vs_3_0
        dcl_position v0
        dcl_position o0
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        mad o0, v0.w, c11, r0
    
    // approximately 4 instruction slots used
};

//Pixel shaders
PixelShader PixelShader0 = NULL;

PixelShader PS_Main
<
    string CloudBias                                   = "parameter register(72)";
    string CloudColor                                  = "parameter register(69)";
    string CloudFadeOut                                = "parameter register(73)";
    string CloudShadowStrength                         = "parameter register(76)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(77)";
    string CloudThreshold                              = "parameter register(71)";
    string GalaxySampler                               = "parameter register(0)";
    string HDRExposure                                 = "parameter register(80)";
    string HDRExposureClamp                            = "parameter register(82)";
    string HDRSunExposure                              = "parameter register(81)";
    string HighDetailNoiseSampler                      = "parameter register(2)";
    string PerlinNoiseSampler                          = "parameter register(1)";
    string StarFieldBrightness                         = "parameter register(78)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(66)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(79)";
    string SunsetColor                                 = "parameter register(70)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(74)";
    string TopCloudColor                               = "parameter register(75)";
    string gtaSkyDomeClip                              = "parameter register(67)";
    string gtaWaterColor                               = "parameter register(68)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float CloudBias;
    //   float4 CloudColor;
    //   float CloudFadeOut;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float HDRSunExposure;
    //   sampler2D HighDetailNoiseSampler;
    //   sampler2D PerlinNoiseSampler;
    //   float4 StarFieldBrightness;
    //   float3 SunCentre;
    //   float3 SunColor;
    //   float4 SunDirection;
    //   float SunSize;
    //   float4 SunsetColor;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   float3 TopCloudColor;
    //   float gtaSkyDomeClip;
    //   float3 gtaWaterColor;
    //
    //
    // Registers:
    //
    //   Name                                        Reg   Size
    //   ------------------------------------------- ----- ----
    //   SunCentre                                   c64      1
    //   SunDirection                                c65      1
    //   SunColor                                    c66      1
    //   gtaSkyDomeClip                              c67      1
    //   gtaWaterColor                               c68      1
    //   CloudColor                                  c69      1
    //   SunsetColor                                 c70      1
    //   CloudThreshold                              c71      1
    //   CloudBias                                   c72      1
    //   CloudFadeOut                                c73      1
    //   TopCloudBiasDetailThresholdHeight           c74      1
    //   TopCloudColor                               c75      1
    //   CloudShadowStrength                         c76      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c77      1
    //   StarFieldBrightness                         c78      1
    //   SunSize                                     c79      1
    //   HDRExposure                                 c80      1
    //   HDRSunExposure                              c81      1
    //   HDRExposureClamp                            c82      1
    //   GalaxySampler                               s0       1
    //   PerlinNoiseSampler                          s1       1
    //   HighDetailNoiseSampler                      s2       1
    //
    
        ps_3_0
        def c0, 12.5799999, -0.0625, 0.5, 0.25
        def c1, -11.6163721, 0.9375, 0.5, 0.349999994
        def c2, 32, 0.600000024, -2, 3
        def c3, 4, 1, 0.200000003, 0
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2
        dcl_texcoord3 v3.zw
        dcl_texcoord4 v4.xyz
        dcl_texcoord5 v5.xyz
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        mov r0.w, c65.w
        add_sat r0.x, r0.w, c2.y
        nrm r1.xyz, v1
        dp3 r0.y, r1, c65
        mov r1.x, c3.x
        mad_sat r0.z, r1.y, r1.x, -c73.x
        mov r1, c0
        mad r1, r0.y, r1, c1
        mov_sat r1.xyz, r1
        mul r0.y, r1.y, r1.y
        mul r0.y, r1.y, r0.y
        pow r0.w, r1.x, c2.x
        mad r0.x, r0.y, -r0.x, r0.w
        mad r0.x, r1.z, c79.x, r0.x
        mad_sat r0.y, r1.z, c64.y, c64.x
        mul_sat r0.x, r0.x, c0.z
        mul r0.w, r0.y, r0.y
        mad r0.y, r0.y, c2.z, c2.w
        mul r0.y, r0.w, r0.y
        mul r0.y, r0.y, c64.z
        mad r0.x, r0.x, c3.x, r0.y
        mul r1.xyz, r0.x, c66
        add_sat r0.x, -r0.x, c3.y
        mul r0.x, r0.x, c81.x
        mul_sat r0.xyw, r0.x, v5.xyzz
        mul r2.xyz, r1, r1
        mad r1.xyz, r2, r2, r1
        mad r0.xyw, r1.xyzz, c81.x, r0
        texld r2, v3.zwzw, s0
        mad r0.xyw, r2.xyzz, c78.y, r0
        mul r1.xy, c77.z, v2
        texld r2, r1, s2
        mul r1.x, r2.x, c77.w
        texld r2, v2, s1
        mad r1.x, r1.x, c3.z, r2.x
        mov r2.x, c71.x
        mad r1.x, r2.x, r1.x, -c72.x
        mul_sat r1.x, r1.x, c76.x
        add r1.y, -r1.x, c3.y
        add r2.yzw, -r1.x, c69.xxyz
        texld r3, v0, s1
        texld r4, v2.zwzw, s2
        add r1.x, r4.x, -c0.z
        mad r1.z, r1.x, c77.w, r3.x
        mad_sat r3.x, r1.x, c3.z, r3.z
        mul r1.x, r1.x, c77.w
        mad_sat r1.z, r2.x, r1.z, -c72.x
        pow r2.x, r1.z, c77.x
        mul_sat r1.z, r1.z, c77.y
        mul r3.y, r2.x, r1.z
        mad r1.z, r2.x, -r1.z, c3.y
        mul r1.y, r1.y, r3.y
        mad r1.y, r1.y, r3.x, r3.x
        mul r1.y, r1.w, r1.y
        mad r2.xyz, c70, r1.y, r2.yzww
        texld r4, v4, s1
        mad r1.x, r1.x, c74.y, r4.y
        mad_sat r1.x, c74.z, r1.x, -c74.x
        mul r1.x, r1.x, v4.z
        mul r1.x, r1.z, r1.x
        mad r1.y, r1.z, r1.x, r3.y
        lrp r3.xyz, r1.x, c75, r2
        mul r0.z, r0.z, r1.y
        lrp r1.xyz, r0.z, r3, r0.xyww
        mul r0.xyz, r1, c80.x
        min r1.xyz, r0, c82
        min r0.xyz, c82, r1
        add r0.w, -c67.x, v1.y
        cmp oC0.xyz, r0.w, r0, c68
        mov oC0.w, c3.y
    
    // approximately 76 instruction slots used (6 texture, 70 arithmetic)
};

PixelShader PS_MiniSky
<
    string AzimuthColor                                = "parameter register(67)";
    string AzimuthColorEast                            = "parameter register(69)";
    string AzimuthHeight                               = "parameter register(70)";
    string AzimuthStrength                             = "parameter register(79)";
    string CloudBias                                   = "parameter register(74)";
    string CloudColor                                  = "parameter register(71)";
    string CloudFadeOut                                = "parameter register(75)";
    string CloudShadowStrength                         = "parameter register(78)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(80)";
    string CloudThreshold                              = "parameter register(73)";
    string GalaxySampler                               = "parameter register(0)";
    string HDRExposure                                 = "parameter register(83)";
    string HDRExposureClamp                            = "parameter register(85)";
    string HDRSunExposure                              = "parameter register(84)";
    string HighDetailNoiseSampler                      = "parameter register(2)";
    string PerlinNoiseSampler                          = "parameter register(1)";
    string SkyColor                                    = "parameter register(66)";
    string StarFieldBrightness                         = "parameter register(81)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(68)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(82)";
    string SunsetColor                                 = "parameter register(72)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(76)";
    string TopCloudColor                               = "parameter register(77)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float3 AzimuthColor;
    //   float3 AzimuthColorEast;
    //   float AzimuthHeight;
    //   float AzimuthStrength;
    //   float CloudBias;
    //   float4 CloudColor;
    //   float CloudFadeOut;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float HDRSunExposure;
    //   sampler2D HighDetailNoiseSampler;
    //   sampler2D PerlinNoiseSampler;
    //   float3 SkyColor;
    //   float4 StarFieldBrightness;
    //   float3 SunCentre;
    //   float3 SunColor;
    //   float4 SunDirection;
    //   float SunSize;
    //   float4 SunsetColor;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   float3 TopCloudColor;
    //
    //
    // Registers:
    //
    //   Name                                        Reg   Size
    //   ------------------------------------------- ----- ----
    //   SunCentre                                   c64      1
    //   SunDirection                                c65      1
    //   SkyColor                                    c66      1
    //   AzimuthColor                                c67      1
    //   SunColor                                    c68      1
    //   AzimuthColorEast                            c69      1
    //   AzimuthHeight                               c70      1
    //   CloudColor                                  c71      1
    //   SunsetColor                                 c72      1
    //   CloudThreshold                              c73      1
    //   CloudBias                                   c74      1
    //   CloudFadeOut                                c75      1
    //   TopCloudBiasDetailThresholdHeight           c76      1
    //   TopCloudColor                               c77      1
    //   CloudShadowStrength                         c78      1
    //   AzimuthStrength                             c79      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c80      1
    //   StarFieldBrightness                         c81      1
    //   SunSize                                     c82      1
    //   HDRExposure                                 c83      1
    //   HDRSunExposure                              c84      1
    //   HDRExposureClamp                            c85      1
    //   GalaxySampler                               s0       1
    //   PerlinNoiseSampler                          s1       1
    //   HighDetailNoiseSampler                      s2       1
    //
    
        ps_3_0
        def c0, -0.5, 0, 1, 4000
        def c1, 12.5799999, -0.0625, 0.5, 0.25
        def c2, -11.6163721, 0.9375, 0.5, 0.349999994
        def c3, 32, 0.600000024, -2, 3
        def c4, 4, 0.200000003, 0, 0
        dcl_texcoord v0.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        add r0.xy, c0.x, v0
        add r0.xy, r0, r0
        dp2add r0.z, r0, r0, c0.y
        rsq r0.w, r0.z
        mul r0.xy, r0, r0.w
        rcp r0.w, r0.w
        add r0.w, -r0.w, c0.z
        mul r1.y, r0.w, c0.w
        mul r0.xy, r0.z, r0
        mul r1.xz, r0.xyyw, c0.w
        nrm r0.xyz, r1
        mul_sat r0.w, r0.y, c70.x
        add r0.w, -r0.w, c0.z
        mul r0.w, r0.w, c79.x
        mad r1.x, r0.x, -c0.x, -c0.x
        mov r2.xyz, c69
        add r1.yzw, -r2.xxyz, c67.xxyz
        mad r1.xyz, r1.x, r1.yzww, c69
        mad r1.xyz, r1, r0.w, c66
        dp3 r0.x, r0, c65
        mov r2.x, c4.x
        mad_sat r0.y, r0.y, r2.x, -c75.x
        mov r2, c1
        mad r2, r0.x, r2, c2
        mov_sat r2.xyz, r2
        mul r0.x, r2.y, r2.y
        mul r0.x, r2.y, r0.x
        pow r0.z, r2.x, c3.x
        mov r0.w, c65.w
        add_sat r0.w, r0.w, c3.y
        mad r0.x, r0.x, -r0.w, r0.z
        mad r0.x, r2.z, c82.x, r0.x
        mad_sat r0.z, r2.z, c64.y, c64.x
        mul_sat r0.x, r0.x, -c0.x
        mul r0.w, r0.z, r0.z
        mad r0.z, r0.z, c3.z, c3.w
        mul r0.z, r0.w, r0.z
        mul r0.z, r0.z, c64.z
        mad r0.x, r0.x, c4.x, r0.z
        mul r2.xyz, r0.x, c68
        add_sat r3.w, -r0.x, c0.z
        mul r0.xzw, r2.xyyz, r2.xyyz
        mad r3.xyz, r0.xzww, r0.xzww, r2
        mul r3, r3, c84.x
        mul_sat r0.xzw, r1.xyyz, r3.w
        min r1.xyz, c85, r3
        add r0.xzw, r0, r1.xyyz
        texld r1, v0, s0
        mad r0.xzw, r1.xyyz, c81.y, r0
        mul r1.xy, c80.z, v0
        texld r1, r1, s2
        mul r1.x, r1.x, c80.w
        texld r3, v0, s1
        mad r1.x, r1.x, c4.y, r3.x
        mov r2.x, c73.x
        mad r1.x, r2.x, r1.x, -c74.x
        mul_sat r1.x, r1.x, c78.x
        add r1.y, -r1.x, c0.z
        add r1.xzw, -r1.x, c71.xyyz
        texld r4, v0, s2
        add r2.y, r4.x, c0.x
        mad r2.z, r2.y, c80.w, r3.x
        mad_sat r2.x, r2.x, r2.z, -c74.x
        pow r3.x, r2.x, c80.x
        mul_sat r2.x, r2.x, c80.y
        mul r2.z, r3.x, r2.x
        mad r2.x, r3.x, -r2.x, c0.z
        mul r1.y, r1.y, r2.z
        mad_sat r3.x, r2.y, c4.y, r3.z
        mul r2.y, r2.y, c80.w
        mad r2.y, r2.y, c76.y, r3.y
        mad_sat r2.y, c76.z, r2.y, -c76.x
        mul r2.y, r2.y, v0.x
        mul r2.y, r2.x, r2.y
        mad r2.x, r2.x, r2.y, r2.z
        mul r0.y, r0.y, r2.x
        mad r1.y, r1.y, r3.x, r3.x
        mul r1.y, r2.w, r1.y
        mad r1.xyz, c72, r1.y, r1.xzww
        lrp r3.xyz, r2.y, c77, r1
        lrp r1.xyz, r0.y, r3, r0.xzww
        mul r0.xyz, r1, c83.x
        min oC0.xyz, r0, c85
        mov oC0.w, c0.z
    
    // approximately 91 instruction slots used (4 texture, 87 arithmetic)
};

PixelShader PS_BlurSkyFast
<
    string SkyMapSampler = "parameter register(0)";
    string TexelSize     = "parameter register(64)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D SkyMapSampler;
    //   float4 TexelSize;
    //
    //
    // Registers:
    //
    //   Name          Reg   Size
    //   ------------- ----- ----
    //   TexelSize     c64      1
    //   SkyMapSampler s0       1
    //
    
        ps_3_0
        def c0, -0.5, 0.5, 0.25, 0
        dcl_texcoord v0.xy
        dcl_2d s0
        mov r0.xy, c0
        mad r0.zw, c64.x, r0.x, v0.xyxy
        texld r1, r0.zwzw, s0
        mad r0.zw, c64.x, r0.xyyx, v0.xyxy
        texld r2, r0.zwzw, s0
        add r1, r1, r2
        mad r0.xz, c64.x, r0.xyyw, v0.xyyw
        texld r2, r0.xzzw, s0
        add r1, r1, r2
        mad r0.xy, c64.x, r0.y, v0
        texld r0, r0, s0
        add r0, r1, r0
        mul oC0, r0, c0.z
    
    // approximately 13 instruction slots used (4 texture, 9 arithmetic)
};

PixelShader PS_BlurSky
<
    string SkyMapSampler = "parameter register(0)";
    string TexelSize     = "parameter register(64)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D SkyMapSampler;
    //   float4 TexelSize;
    //
    //
    // Registers:
    //
    //   Name          Reg   Size
    //   ------------- ----- ----
    //   TexelSize     c64      1
    //   SkyMapSampler s0       1
    //
    
        ps_3_0
        def c0, -1.5, -0.5, 0.5, 0.25
        def c1, 1.5, -1.5, 0.111111112, 0
        dcl_texcoord v0.xy
        dcl_2d s0
        mov r0.xyz, c0
        mad r1.xy, c64, r0.yxzw, v0
        texld r1, r1, s0
        mul r1, r1, c0.z
        mad r2.xy, c64, r0.x, v0
        texld r2, r2, s0
        mad r1, r2, c0.w, r1
        mad r2.xy, c64, r0.zxzw, v0
        texld r2, r2, s0
        mad r1, r2, c0.z, r1
        mov r2.xy, c64
        mad r2.zw, r2.xyxy, c1.xyxy, v0.xyxy
        texld r3, r2.zwzw, s0
        mad r1, r3, c0.w, r1
        mad r2.zw, c64.xyxy, r0.xyxy, v0.xyxy
        texld r3, r2.zwzw, s0
        mad r1, r3, c0.z, r1
        mad r2.zw, c64.xyxy, r0.y, v0.xyxy
        texld r3, r2.zwzw, s0
        add r1, r1, r3
        mad r2.zw, c64.xyxy, r0.xyzy, v0.xyxy
        texld r3, r2.zwzw, s0
        add r1, r1, r3
        mad r2.zw, c64.xyxy, -r0.xyxz, v0.xyxy
        texld r3, r2.zwzw, s0
        mad r1, r3, c0.z, r1
        mad r2.zw, c64.xyxy, r0.xyxz, v0.xyxy
        texld r3, r2.zwzw, s0
        mad r1, r3, c0.z, r1
        mad r2.zw, c64.xyxy, r0.xyyz, v0.xyxy
        texld r3, r2.zwzw, s0
        add r1, r1, r3
        mad r2.zw, c64.xyxy, r0.z, v0.xyxy
        texld r3, r2.zwzw, s0
        add r1, r1, r3
        mad r2.zw, c64.xyxy, -r0.xyxy, v0.xyxy
        texld r3, r2.zwzw, s0
        mad r1, r3, c0.z, r1
        mad r2.xy, r2, c1.yxzw, v0
        texld r2, r2, s0
        mad r1, r2, c0.w, r1
        mad r0.zw, c64.xyxy, -r0.xyzx, v0.xyxy
        texld r2, r0.zwzw, s0
        mad r1, r2, c0.z, r1
        mad r0.yz, c64.xxyw, -r0.xyxw, v0.xxyw
        texld r2, r0.yzzw, s0
        mad r1, r2, c0.z, r1
        mad r0.xy, c64, -r0.x, v0
        texld r0, r0, s0
        mad r0, r0, c0.w, r1
        mul oC0, r0, c1.z
    
    // approximately 51 instruction slots used (16 texture, 35 arithmetic)
};

PixelShader PS_DpGTAMain
<
    string CloudBias                                   = "parameter register(72)";
    string CloudColor                                  = "parameter register(69)";
    string CloudFadeOut                                = "parameter register(73)";
    string CloudShadowStrength                         = "parameter register(76)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(77)";
    string CloudThreshold                              = "parameter register(71)";
    string GalaxySampler                               = "parameter register(0)";
    string HDRExposure                                 = "parameter register(80)";
    string HDRExposureClamp                            = "parameter register(82)";
    string HDRSunExposure                              = "parameter register(81)";
    string HighDetailNoiseSampler                      = "parameter register(2)";
    string PerlinNoiseSampler                          = "parameter register(1)";
    string StarFieldBrightness                         = "parameter register(78)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(66)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(79)";
    string SunsetColor                                 = "parameter register(70)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(74)";
    string TopCloudColor                               = "parameter register(75)";
    string gtaSkyDomeClip                              = "parameter register(67)";
    string gtaWaterColor                               = "parameter register(68)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float CloudBias;
    //   float4 CloudColor;
    //   float CloudFadeOut;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float HDRSunExposure;
    //   sampler2D HighDetailNoiseSampler;
    //   sampler2D PerlinNoiseSampler;
    //   float4 StarFieldBrightness;
    //   float3 SunCentre;
    //   float3 SunColor;
    //   float4 SunDirection;
    //   float SunSize;
    //   float4 SunsetColor;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   float3 TopCloudColor;
    //   float gtaSkyDomeClip;
    //   float3 gtaWaterColor;
    //
    //
    // Registers:
    //
    //   Name                                        Reg   Size
    //   ------------------------------------------- ----- ----
    //   SunCentre                                   c64      1
    //   SunDirection                                c65      1
    //   SunColor                                    c66      1
    //   gtaSkyDomeClip                              c67      1
    //   gtaWaterColor                               c68      1
    //   CloudColor                                  c69      1
    //   SunsetColor                                 c70      1
    //   CloudThreshold                              c71      1
    //   CloudBias                                   c72      1
    //   CloudFadeOut                                c73      1
    //   TopCloudBiasDetailThresholdHeight           c74      1
    //   TopCloudColor                               c75      1
    //   CloudShadowStrength                         c76      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c77      1
    //   StarFieldBrightness                         c78      1
    //   SunSize                                     c79      1
    //   HDRExposure                                 c80      1
    //   HDRSunExposure                              c81      1
    //   HDRExposureClamp                            c82      1
    //   GalaxySampler                               s0       1
    //   PerlinNoiseSampler                          s1       1
    //   HighDetailNoiseSampler                      s2       1
    //
    
        ps_3_0
        def c0, 12.5799999, -0.0625, 0.5, 0.25
        def c1, -11.6163721, 0.9375, 0.5, 0.349999994
        def c2, 32, 0.600000024, -2, 3
        def c3, 4, 1, 0.200000003, 0
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2
        dcl_texcoord3 v3.zw
        dcl_texcoord4 v4.xyz
        dcl_texcoord5 v5.xyz
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        mov r0.w, c65.w
        add_sat r0.x, r0.w, c2.y
        nrm r1.xyz, v1
        dp3 r0.y, r1, c65
        mov r1.x, c3.x
        mad_sat r0.z, r1.y, r1.x, -c73.x
        mov r1, c0
        mad r1, r0.y, r1, c1
        mov_sat r1.xyz, r1
        mul r0.y, r1.y, r1.y
        mul r0.y, r1.y, r0.y
        pow r0.w, r1.x, c2.x
        mad r0.x, r0.y, -r0.x, r0.w
        mad r0.x, r1.z, c79.x, r0.x
        mad_sat r0.y, r1.z, c64.y, c64.x
        mul_sat r0.x, r0.x, c0.z
        mul r0.w, r0.y, r0.y
        mad r0.y, r0.y, c2.z, c2.w
        mul r0.y, r0.w, r0.y
        mul r0.y, r0.y, c64.z
        mad r0.x, r0.x, c3.x, r0.y
        mul r1.xyz, r0.x, c66
        add_sat r0.x, -r0.x, c3.y
        mul r0.x, r0.x, c81.x
        mul_sat r0.xyw, r0.x, v5.xyzz
        mul r2.xyz, r1, r1
        mad r1.xyz, r2, r2, r1
        mad r0.xyw, r1.xyzz, c81.x, r0
        texld r2, v3.zwzw, s0
        mad r0.xyw, r2.xyzz, c78.y, r0
        mul r1.xy, c77.z, v2
        texld r2, r1, s2
        mul r1.x, r2.x, c77.w
        texld r2, v2, s1
        mad r1.x, r1.x, c3.z, r2.x
        mov r2.x, c71.x
        mad r1.x, r2.x, r1.x, -c72.x
        mul_sat r1.x, r1.x, c76.x
        add r1.y, -r1.x, c3.y
        add r2.yzw, -r1.x, c69.xxyz
        texld r3, v0, s1
        texld r4, v2.zwzw, s2
        add r1.x, r4.x, -c0.z
        mad r1.z, r1.x, c77.w, r3.x
        mad_sat r3.x, r1.x, c3.z, r3.z
        mul r1.x, r1.x, c77.w
        mad_sat r1.z, r2.x, r1.z, -c72.x
        pow r2.x, r1.z, c77.x
        mul_sat r1.z, r1.z, c77.y
        mul r3.y, r2.x, r1.z
        mad r1.z, r2.x, -r1.z, c3.y
        mul r1.y, r1.y, r3.y
        mad r1.y, r1.y, r3.x, r3.x
        mul r1.y, r1.w, r1.y
        mad r2.xyz, c70, r1.y, r2.yzww
        texld r4, v4, s1
        mad r1.x, r1.x, c74.y, r4.y
        mad_sat r1.x, c74.z, r1.x, -c74.x
        mul r1.x, r1.x, v4.z
        mul r1.x, r1.z, r1.x
        mad r1.y, r1.z, r1.x, r3.y
        lrp r3.xyz, r1.x, c75, r2
        mul r0.z, r0.z, r1.y
        lrp r1.xyz, r0.z, r3, r0.xyww
        mul r0.xyz, r1, c80.x
        min r1.xyz, r0, c82
        min r0.xyz, c82, r1
        add r0.w, -c67.x, v1.y
        cmp oC0.xyz, r0.w, r0, c68
        mov oC0.w, c3.y
    
    // approximately 76 instruction slots used (6 texture, 70 arithmetic)
};

PixelShader PS_SunOnly
<
    string HDRExposureClamp = "parameter register(68)";
    string HDRSunExposure   = "parameter register(67)";
    string SunCentre        = "parameter register(64)";
    string SunColor         = "parameter register(66)";
    string SunDirection     = "parameter register(65)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float3 HDRExposureClamp;
    //   float HDRSunExposure;
    //   float3 SunCentre;
    //   float3 SunColor;
    //   float4 SunDirection;
    //
    //
    // Registers:
    //
    //   Name             Reg   Size
    //   ---------------- ----- ----
    //   SunCentre        c64      1
    //   SunDirection     c65      1
    //   SunColor         c66      1
    //   HDRSunExposure   c67      1
    //   HDRExposureClamp c68      1
    //
    
        ps_3_0
        def c0, 1, 0.5, -2, 3
        def c1, 4, 0, 0, 0
        dcl_texcoord v0.w
        dcl_texcoord1 v1.zw
        mov r0.xy, v1.zwzw
        mov r0.z, v0.w
        nrm r1.xyz, r0
        nrm r0.xyz, c65
        dp3 r0.x, r1, r0
        add r0.x, r0.x, c0.x
        mov r0.y, c0.y
        mad r0.x, r0.x, r0.y, -c64.x
        add r0.y, -c64.x, c64.y
        rcp r0.y, r0.y
        mul_sat r0.x, r0.x, r0.y
        mad r0.y, r0.x, c0.z, c0.w
        mul r0.x, r0.x, r0.x
        mul r0.x, r0.y, r0.x
        mul r0.x, r0.x, c64.z
        mul r0.x, r0.x, c1.x
        mul r0.xyz, r0.x, c66
        mul r1.xyz, r0, r0
        mad r0.xyz, r1, r1, r0
        mul r0.xyz, r0, c67.x
        min oC0.xyz, c68, r0
        mov oC0.w, c0.x
    
    // approximately 26 instruction slots used
};

PixelShader PS_MainWithMoon
<
    string CloudBias                                   = "parameter register(73)";
    string CloudColor                                  = "parameter register(70)";
    string CloudFadeOut                                = "parameter register(74)";
    string CloudShadowStrength                         = "parameter register(77)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(78)";
    string CloudThreshold                              = "parameter register(72)";
    string GalaxySampler                               = "parameter register(2)";
    string HDRExposure                                 = "parameter register(87)";
    string HDRExposureClamp                            = "parameter register(89)";
    string HDRSunExposure                              = "parameter register(88)";
    string HighDetailNoiseSampler                      = "parameter register(4)";
    string MoonColorConstant                           = "parameter register(83)";
    string MoonGlow                                    = "parameter register(69)";
    string MoonGlowSampler                             = "parameter register(1)";
    string MoonLight                                   = "parameter register(80)";
    string MoonPosition                                = "parameter register(84)";
    string MoonSampler                                 = "parameter register(0)";
    string MoonVisiblity                               = "parameter register(81)";
    string MoonXVector                                 = "parameter register(85)";
    string MoonYVector                                 = "parameter register(86)";
    string PerlinNoiseSampler                          = "parameter register(3)";
    string StarFieldBrightness                         = "parameter register(79)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(66)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(82)";
    string SunsetColor                                 = "parameter register(71)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(75)";
    string TopCloudColor                               = "parameter register(76)";
    string gtaSkyDomeClip                              = "parameter register(67)";
    string gtaWaterColor                               = "parameter register(68)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float CloudBias;
    //   float4 CloudColor;
    //   float CloudFadeOut;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float HDRSunExposure;
    //   sampler2D HighDetailNoiseSampler;
    //   float4 MoonColorConstant;
    //   float MoonGlow;
    //   sampler2D MoonGlowSampler;
    //   float4 MoonLight;
    //   float3 MoonPosition;
    //   sampler2D MoonSampler;
    //   float MoonVisiblity;
    //   float3 MoonXVector;
    //   float3 MoonYVector;
    //   sampler2D PerlinNoiseSampler;
    //   float4 StarFieldBrightness;
    //   float3 SunCentre;
    //   float3 SunColor;
    //   float4 SunDirection;
    //   float SunSize;
    //   float4 SunsetColor;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   float3 TopCloudColor;
    //   float gtaSkyDomeClip;
    //   float3 gtaWaterColor;
    //
    //
    // Registers:
    //
    //   Name                                        Reg   Size
    //   ------------------------------------------- ----- ----
    //   SunCentre                                   c64      1
    //   SunDirection                                c65      1
    //   SunColor                                    c66      1
    //   gtaSkyDomeClip                              c67      1
    //   gtaWaterColor                               c68      1
    //   MoonGlow                                    c69      1
    //   CloudColor                                  c70      1
    //   SunsetColor                                 c71      1
    //   CloudThreshold                              c72      1
    //   CloudBias                                   c73      1
    //   CloudFadeOut                                c74      1
    //   TopCloudBiasDetailThresholdHeight           c75      1
    //   TopCloudColor                               c76      1
    //   CloudShadowStrength                         c77      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c78      1
    //   StarFieldBrightness                         c79      1
    //   MoonLight                                   c80      1
    //   MoonVisiblity                               c81      1
    //   SunSize                                     c82      1
    //   MoonColorConstant                           c83      1
    //   MoonPosition                                c84      1
    //   MoonXVector                                 c85      1
    //   MoonYVector                                 c86      1
    //   HDRExposure                                 c87      1
    //   HDRSunExposure                              c88      1
    //   HDRExposureClamp                            c89      1
    //   MoonSampler                                 s0       1
    //   MoonGlowSampler                             s1       1
    //   GalaxySampler                               s2       1
    //   PerlinNoiseSampler                          s3       1
    //   HighDetailNoiseSampler                      s4       1
    //
    
        ps_3_0
        def c0, 12.5799999, -0.0625, 0.5, 0.25
        def c1, -11.6163721, 0.9375, 0.5, 0.349999994
        def c2, 32, 0.600000024, -2, 3
        def c3, 4, 1, 0.200000003, 0
        def c4, 0.899999976, 0.5, 0.49000001, 0.99000001
        def c5, 64, 0.300000012, 0.699999988, 0.170000002
        def c6, 1, 1.39999998, 0, 0
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2
        dcl_texcoord3 v3.zw
        dcl_texcoord4 v4.xyz
        dcl_texcoord5 v5.xyz
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s3
        dcl_2d s4
        mov r0.w, c65.w
        add_sat r0.x, r0.w, c2.y
        dp3 r0.y, v1, v1
        rsq r0.y, r0.y
        mul r1.xyz, r0.y, v1
        mad r0.yzw, v1.xxyz, r0.y, -c84.xxyz
        add r0.yzw, r0, -c85.xxyz
        add r0.yzw, r0, -c86.xxyz
        dp3 r1.x, r1, c65
        mov r2.xy, c3
        mad_sat r1.y, r1.y, r2.x, -c74.x
        mov r3, c0
        mad r3, r1.x, r3, c1
        mov_sat r3.xyz, r3
        mul r1.x, r3.y, r3.y
        mul r1.x, r3.y, r1.x
        pow r1.z, r3.x, c2.x
        mad r0.x, r1.x, -r0.x, r1.z
        mad r0.x, r3.z, c82.x, r0.x
        mad_sat r1.x, r3.z, c64.y, c64.x
        mul_sat r0.x, r0.x, c0.z
        mul r1.z, r1.x, r1.x
        mad r1.x, r1.x, c2.z, c2.w
        mul r1.x, r1.z, r1.x
        mul r1.x, r1.x, c64.z
        mad r0.x, r0.x, c3.x, r1.x
        mul r1.xzw, r0.x, c66.xyyz
        add_sat r0.x, -r0.x, c3.y
        mul r0.x, r0.x, c88.x
        mul_sat r2.xzw, r0.x, v5.xyyz
        mul r3.xyz, r1.xzww, r1.xzww
        mad r1.xzw, r3.xyyz, r3.xyyz, r1
        mad r1.xzw, r1, c88.x, r2
        dp3 r3.x, c85, r0.yzww
        dp3 r3.y, c86, r0.yzww
        add r0.xy, -r3, c3.y
        cmp r0.xy, r0, c3.w, c3.y
        cmp r0.zw, r3.xyxy, c3.w, c3.y
        add r0.xy, r0, r0.zwzw
        cmp r0.xy, -r0, c3.w, c3.y
        add_sat r0.x, r0.y, r0.x
        add r0.x, -r0.x, c3.y
        mad r0.yz, r3.xxyw, c80.xxyw, c80.xzww
        add r4, r3.xyxy, -c0.z
        mad r4, r4, c4.x, c4.yyzz
        texld r5, r0.yzzw, s0
        mul r0, r0.x, r5
        mul r2.xzw, r0.w, c83.xyyz
        mad r3.xy, r4, c80, c80.zwzw
        texld r5, r3, s1
        add r3.xyz, r2.y, c83
        mul r3.xyz, r5.x, r3
        mul r3.xyz, r3, c69.x
        mad r0.xyz, r0, r2.xzww, r3
        dp3 r2.x, r1.xzww, c5.yzww
        mad_sat r2.x, r2.x, -c81.x, r2.y
        mul r2.x, r2.x, r2.x
        texld r5, v4, s3
        texld r6, v2.zwzw, s4
        add r2.y, r6.x, -c0.z
        mul r2.z, r2.y, c78.w
        mad r2.z, r2.z, c75.y, r5.y
        mad_sat r2.z, c75.z, r2.z, -c75.x
        mul r2.z, r2.z, v4.z
        texld r5, v0, s3
        mad r2.w, r2.y, c78.w, r5.x
        mad_sat r2.y, r2.y, c3.z, r5.z
        mov r5.x, c72.x
        mad_sat r2.w, r5.x, r2.w, -c73.x
        pow r5.y, r2.w, c78.x
        mul_sat r2.w, r2.w, c78.y
        mad r5.z, r5.y, -r2.w, c3.y
        mul r2.w, r5.y, r2.w
        mul r2.z, r2.z, r5.z
        mad r5.y, r5.z, r2.z, r2.w
        add r5.zw, -r5.y, c6.xyxy
        mul r1.y, r1.y, r5.y
        mul r2.x, r2.x, r5.z
        mad r0.xyz, r0, r2.x, r1.xzww
        mul r3.xyz, r3, r2.x
        mad r3.xyz, r3, r5.w, c3.y
        add r4.xy, -r4, c4.w
        cmp r4, r4, c3.w, c3.y
        add r4.xy, r4, r4.zwzw
        cmp r4.xy, -r4, c3.w, c3.y
        add r2.x, r4.y, r4.x
        cmp r0.xyz, -r2.x, r0, r1.xzww
        mov r1.w, c83.w
        mul_sat r1.x, r1.w, c5.x
        mad r0.w, r0.w, -r1.x, c3.y
        texld r4, v3.zwzw, s2
        mul r1.xzw, r4.xyyz, c79.y
        mul r4.xyz, r0.w, r1.xzww
        cmp r1.xzw, -r2.x, r4.xyyz, r1
        add r0.xyz, r0, r1.xzww
        mul r1.xz, c78.z, v2.xyyw
        texld r4, r1.xzzw, s4
        mul r0.w, r4.x, c78.w
        texld r4, v2, s3
        mad r0.w, r0.w, c3.z, r4.x
        mad r0.w, r5.x, r0.w, -c73.x
        mul_sat r0.w, r0.w, c77.x
        add r1.x, -r0.w, c3.y
        add r4.xyz, -r0.w, c70
        mul r0.w, r2.w, r1.x
        mad r0.w, r0.w, r2.y, r2.y
        mul r0.w, r3.w, r0.w
        mad r1.xzw, c71.xyyz, r0.w, r4.xyyz
        lrp r4.xyz, r2.z, c76, r1.xzww
        mul r1.xzw, r3.xyyz, r4.xyyz
        cmp r1.xzw, -r2.x, r1, r4.xyyz
        lrp r2.xyz, r1.y, r1.xzww, r0
        mul r0.xyz, r2, c87.x
        min r1.xyz, r0, c89
        min r0.xyz, c89, r1
        add r0.w, -c67.x, v1.y
        cmp oC0.xyz, r0.w, r0, c68
        mov oC0.w, c3.y
    
    // approximately 122 instruction slots used (8 texture, 114 arithmetic)
};

PixelShader PS_MainWithStarfield
<
    string CloudBias                                   = "parameter register(72)";
    string CloudColor                                  = "parameter register(69)";
    string CloudFadeOut                                = "parameter register(73)";
    string CloudShadowStrength                         = "parameter register(76)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(77)";
    string CloudThreshold                              = "parameter register(71)";
    string GalaxySampler                               = "parameter register(1)";
    string HDRExposure                                 = "parameter register(80)";
    string HDRExposureClamp                            = "parameter register(82)";
    string HDRSunExposure                              = "parameter register(81)";
    string HighDetailNoiseSampler                      = "parameter register(3)";
    string PerlinNoiseSampler                          = "parameter register(2)";
    string StarFieldBrightness                         = "parameter register(78)";
    string StarFieldSampler                            = "parameter register(0)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(66)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(79)";
    string SunsetColor                                 = "parameter register(70)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(74)";
    string TopCloudColor                               = "parameter register(75)";
    string gtaSkyDomeClip                              = "parameter register(67)";
    string gtaWaterColor                               = "parameter register(68)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float CloudBias;
    //   float4 CloudColor;
    //   float CloudFadeOut;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float HDRSunExposure;
    //   sampler2D HighDetailNoiseSampler;
    //   sampler2D PerlinNoiseSampler;
    //   float4 StarFieldBrightness;
    //   sampler2D StarFieldSampler;
    //   float3 SunCentre;
    //   float3 SunColor;
    //   float4 SunDirection;
    //   float SunSize;
    //   float4 SunsetColor;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   float3 TopCloudColor;
    //   float gtaSkyDomeClip;
    //   float3 gtaWaterColor;
    //
    //
    // Registers:
    //
    //   Name                                        Reg   Size
    //   ------------------------------------------- ----- ----
    //   SunCentre                                   c64      1
    //   SunDirection                                c65      1
    //   SunColor                                    c66      1
    //   gtaSkyDomeClip                              c67      1
    //   gtaWaterColor                               c68      1
    //   CloudColor                                  c69      1
    //   SunsetColor                                 c70      1
    //   CloudThreshold                              c71      1
    //   CloudBias                                   c72      1
    //   CloudFadeOut                                c73      1
    //   TopCloudBiasDetailThresholdHeight           c74      1
    //   TopCloudColor                               c75      1
    //   CloudShadowStrength                         c76      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c77      1
    //   StarFieldBrightness                         c78      1
    //   SunSize                                     c79      1
    //   HDRExposure                                 c80      1
    //   HDRSunExposure                              c81      1
    //   HDRExposureClamp                            c82      1
    //   StarFieldSampler                            s0       1
    //   GalaxySampler                               s1       1
    //   PerlinNoiseSampler                          s2       1
    //   HighDetailNoiseSampler                      s3       1
    //
    
        ps_3_0
        def c0, 12.5799999, -0.0625, 0.5, 0.25
        def c1, -11.6163721, 0.9375, 0.5, 0.349999994
        def c2, 32, 0.600000024, -2, 3
        def c3, 4, 1, 0.200000003, 1.20000005
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2
        dcl_texcoord3 v3
        dcl_texcoord4 v4.xyz
        dcl_texcoord5 v5.xyz
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s3
        mov r0.w, c65.w
        add_sat r0.x, r0.w, c2.y
        nrm r1.xyz, v1
        dp3 r0.y, r1, c65
        mov r1.x, c3.x
        mad_sat r0.z, r1.y, r1.x, -c73.x
        mov r1, c0
        mad r1, r0.y, r1, c1
        mov_sat r1.xyz, r1
        mul r0.y, r1.y, r1.y
        mul r0.y, r1.y, r0.y
        pow r0.w, r1.x, c2.x
        mad r0.x, r0.y, -r0.x, r0.w
        mad r0.x, r1.z, c79.x, r0.x
        mad_sat r0.y, r1.z, c64.y, c64.x
        mul_sat r0.x, r0.x, c0.z
        mul r0.w, r0.y, r0.y
        mad r0.y, r0.y, c2.z, c2.w
        mul r0.y, r0.w, r0.y
        mul r0.y, r0.y, c64.z
        mad r0.x, r0.x, c3.x, r0.y
        mul r1.xyz, r0.x, c66
        add_sat r0.x, -r0.x, c3.y
        mul r0.x, r0.x, c81.x
        mul_sat r0.xyw, r0.x, v5.xyzz
        mul r2.xyz, r1, r1
        mad r1.xyz, r2, r2, r1
        mad r0.xyw, r1.xyzz, c81.x, r0
        texld r2, v3, s0
        mad r1.xyz, r2, c78.x, -c78.z
        texld r2, v3.zwzw, s1
        mul r3.xyz, r2, c78.y
        dp3 r2.w, r3, c3.w
        mad r1.xyz, r1, r2.w, r1
        mad_sat r1.xyz, r2, c78.y, r1
        add r0.xyw, r0, r1.xyzz
        mul r1.xy, c77.z, v2
        texld r2, r1, s3
        mul r1.x, r2.x, c77.w
        texld r2, v2, s2
        mad r1.x, r1.x, c3.z, r2.x
        mov r2.x, c71.x
        mad r1.x, r2.x, r1.x, -c72.x
        mul_sat r1.x, r1.x, c76.x
        add r1.y, -r1.x, c3.y
        add r2.yzw, -r1.x, c69.xxyz
        texld r3, v0, s2
        texld r4, v2.zwzw, s3
        add r1.x, r4.x, -c0.z
        mad r1.z, r1.x, c77.w, r3.x
        mad_sat r3.x, r1.x, c3.z, r3.z
        mul r1.x, r1.x, c77.w
        mad_sat r1.z, r2.x, r1.z, -c72.x
        pow r2.x, r1.z, c77.x
        mul_sat r1.z, r1.z, c77.y
        mul r3.y, r2.x, r1.z
        mad r1.z, r2.x, -r1.z, c3.y
        mul r1.y, r1.y, r3.y
        mad r1.y, r1.y, r3.x, r3.x
        mul r1.y, r1.w, r1.y
        mad r2.xyz, c70, r1.y, r2.yzww
        texld r4, v4, s2
        mad r1.x, r1.x, c74.y, r4.y
        mad_sat r1.x, c74.z, r1.x, -c74.x
        mul r1.x, r1.x, v4.z
        mul r1.x, r1.z, r1.x
        mad r1.y, r1.z, r1.x, r3.y
        lrp r3.xyz, r1.x, c75, r2
        mul r0.z, r0.z, r1.y
        lrp r1.xyz, r0.z, r3, r0.xyww
        mul r0.xyz, r1, c80.x
        min r1.xyz, r0, c82
        min r0.xyz, c82, r1
        add r0.w, -c67.x, v1.y
        cmp oC0.xyz, r0.w, r0, c68
        mov oC0.w, c3.y
    
    // approximately 82 instruction slots used (7 texture, 75 arithmetic)
};

PixelShader PS_MainWithStarfieldWithMoon
<
    string CloudBias                                   = "parameter register(73)";
    string CloudColor                                  = "parameter register(70)";
    string CloudFadeOut                                = "parameter register(74)";
    string CloudShadowStrength                         = "parameter register(77)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(78)";
    string CloudThreshold                              = "parameter register(72)";
    string GalaxySampler                               = "parameter register(3)";
    string HDRExposure                                 = "parameter register(87)";
    string HDRExposureClamp                            = "parameter register(89)";
    string HDRSunExposure                              = "parameter register(88)";
    string HighDetailNoiseSampler                      = "parameter register(5)";
    string MoonColorConstant                           = "parameter register(83)";
    string MoonGlow                                    = "parameter register(69)";
    string MoonGlowSampler                             = "parameter register(1)";
    string MoonLight                                   = "parameter register(80)";
    string MoonPosition                                = "parameter register(84)";
    string MoonSampler                                 = "parameter register(0)";
    string MoonVisiblity                               = "parameter register(81)";
    string MoonXVector                                 = "parameter register(85)";
    string MoonYVector                                 = "parameter register(86)";
    string PerlinNoiseSampler                          = "parameter register(4)";
    string StarFieldBrightness                         = "parameter register(79)";
    string StarFieldSampler                            = "parameter register(2)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(66)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(82)";
    string SunsetColor                                 = "parameter register(71)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(75)";
    string TopCloudColor                               = "parameter register(76)";
    string gtaSkyDomeClip                              = "parameter register(67)";
    string gtaWaterColor                               = "parameter register(68)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float CloudBias;
    //   float4 CloudColor;
    //   float CloudFadeOut;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float HDRSunExposure;
    //   sampler2D HighDetailNoiseSampler;
    //   float4 MoonColorConstant;
    //   float MoonGlow;
    //   sampler2D MoonGlowSampler;
    //   float4 MoonLight;
    //   float3 MoonPosition;
    //   sampler2D MoonSampler;
    //   float MoonVisiblity;
    //   float3 MoonXVector;
    //   float3 MoonYVector;
    //   sampler2D PerlinNoiseSampler;
    //   float4 StarFieldBrightness;
    //   sampler2D StarFieldSampler;
    //   float3 SunCentre;
    //   float3 SunColor;
    //   float4 SunDirection;
    //   float SunSize;
    //   float4 SunsetColor;
    //   float4 TopCloudBiasDetailThresholdHeight;
    //   float3 TopCloudColor;
    //   float gtaSkyDomeClip;
    //   float3 gtaWaterColor;
    //
    //
    // Registers:
    //
    //   Name                                        Reg   Size
    //   ------------------------------------------- ----- ----
    //   SunCentre                                   c64      1
    //   SunDirection                                c65      1
    //   SunColor                                    c66      1
    //   gtaSkyDomeClip                              c67      1
    //   gtaWaterColor                               c68      1
    //   MoonGlow                                    c69      1
    //   CloudColor                                  c70      1
    //   SunsetColor                                 c71      1
    //   CloudThreshold                              c72      1
    //   CloudBias                                   c73      1
    //   CloudFadeOut                                c74      1
    //   TopCloudBiasDetailThresholdHeight           c75      1
    //   TopCloudColor                               c76      1
    //   CloudShadowStrength                         c77      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c78      1
    //   StarFieldBrightness                         c79      1
    //   MoonLight                                   c80      1
    //   MoonVisiblity                               c81      1
    //   SunSize                                     c82      1
    //   MoonColorConstant                           c83      1
    //   MoonPosition                                c84      1
    //   MoonXVector                                 c85      1
    //   MoonYVector                                 c86      1
    //   HDRExposure                                 c87      1
    //   HDRSunExposure                              c88      1
    //   HDRExposureClamp                            c89      1
    //   MoonSampler                                 s0       1
    //   MoonGlowSampler                             s1       1
    //   StarFieldSampler                            s2       1
    //   GalaxySampler                               s3       1
    //   PerlinNoiseSampler                          s4       1
    //   HighDetailNoiseSampler                      s5       1
    //
    
        ps_3_0
        def c0, 12.5799999, -0.0625, 0.5, 0.25
        def c1, -11.6163721, 0.9375, 0.5, 0.349999994
        def c2, 32, 0.600000024, -2, 3
        def c3, 4, 1, 0.200000003, 1.20000005
        def c4, 0.899999976, 0.5, 0.49000001, 0.99000001
        def c5, 0, 1, 64, 1.39999998
        def c6, 0.300000012, 0.699999988, 0.170000002, 0
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2
        dcl_texcoord3 v3
        dcl_texcoord4 v4.xyz
        dcl_texcoord5 v5.xyz
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s3
        dcl_2d s4
        dcl_2d s5
        mov r0.w, c65.w
        add_sat r0.x, r0.w, c2.y
        dp3 r0.y, v1, v1
        rsq r0.y, r0.y
        mul r1.xyz, r0.y, v1
        mad r0.yzw, v1.xxyz, r0.y, -c84.xxyz
        add r0.yzw, r0, -c85.xxyz
        add r0.yzw, r0, -c86.xxyz
        dp3 r1.x, r1, c65
        mov r2.xy, c3
        mad_sat r1.y, r1.y, r2.x, -c74.x
        mov r3, c0
        mad r3, r1.x, r3, c1
        mov_sat r3.xyz, r3
        mul r1.x, r3.y, r3.y
        mul r1.x, r3.y, r1.x
        pow r1.z, r3.x, c2.x
        mad r0.x, r1.x, -r0.x, r1.z
        mad r0.x, r3.z, c82.x, r0.x
        mad_sat r1.x, r3.z, c64.y, c64.x
        mul_sat r0.x, r0.x, c0.z
        mul r1.z, r1.x, r1.x
        mad r1.x, r1.x, c2.z, c2.w
        mul r1.x, r1.z, r1.x
        mul r1.x, r1.x, c64.z
        mad r0.x, r0.x, c3.x, r1.x
        mul r1.xzw, r0.x, c66.xyyz
        add_sat r0.x, -r0.x, c3.y
        mul r0.x, r0.x, c88.x
        mul_sat r2.xzw, r0.x, v5.xyyz
        mul r3.xyz, r1.xzww, r1.xzww
        mad r1.xzw, r3.xyyz, r3.xyyz, r1
        mad r1.xzw, r1, c88.x, r2
        dp3 r3.x, c85, r0.yzww
        dp3 r3.y, c86, r0.yzww
        add r0.xy, -r3, c3.y
        cmp r0.xy, r0, c5.x, c5.y
        cmp r0.zw, r3.xyxy, c5.x, c5.y
        add r0.xy, r0, r0.zwzw
        cmp r0.xy, -r0, c5.x, c5.y
        add_sat r0.x, r0.y, r0.x
        add r0.x, -r0.x, c3.y
        mad r0.yz, r3.xxyw, c80.xxyw, c80.xzww
        add r4, r3.xyxy, -c0.z
        mad r4, r4, c4.x, c4.yyzz
        texld r5, r0.yzzw, s0
        mul r0, r0.x, r5
        mul r2.xzw, r0.w, c83.xyyz
        mad r3.xy, r4, c80, c80.zwzw
        texld r5, r3, s1
        add r3.xyz, r2.y, c83
        mul r3.xyz, r5.x, r3
        mul r3.xyz, r3, c69.x
        mad r0.xyz, r0, r2.xzww, r3
        dp3 r2.x, r1.xzww, c6
        mad_sat r2.x, r2.x, -c81.x, r2.y
        mul r2.x, r2.x, r2.x
        texld r5, v4, s4
        texld r6, v2.zwzw, s5
        add r2.y, r6.x, -c0.z
        mul r2.z, r2.y, c78.w
        mad r2.z, r2.z, c75.y, r5.y
        mad_sat r2.z, c75.z, r2.z, -c75.x
        mul r2.z, r2.z, v4.z
        texld r5, v0, s4
        mad r2.w, r2.y, c78.w, r5.x
        mad_sat r2.y, r2.y, c3.z, r5.z
        mov r5.x, c72.x
        mad_sat r2.w, r5.x, r2.w, -c73.x
        pow r5.y, r2.w, c78.x
        mul_sat r2.w, r2.w, c78.y
        mad r5.z, r5.y, -r2.w, c3.y
        mul r2.w, r5.y, r2.w
        mul r2.z, r2.z, r5.z
        mad r5.y, r5.z, r2.z, r2.w
        add r5.zw, -r5.y, c5.xyyw
        mul r1.y, r1.y, r5.y
        mul r2.x, r2.x, r5.z
        mad r0.xyz, r0, r2.x, r1.xzww
        mul r3.xyz, r3, r2.x
        mad r3.xyz, r3, r5.w, c3.y
        add r4.xy, -r4, c4.w
        cmp r4, r4, c5.x, c5.y
        add r4.xy, r4, r4.zwzw
        cmp r4.xy, -r4, c5.x, c5.y
        add r2.x, r4.y, r4.x
        cmp r0.xyz, -r2.x, r0, r1.xzww
        mov r1.z, c5.z
        mul_sat r1.x, r1.z, c83.w
        mad r0.w, r0.w, -r1.x, c3.y
        texld r4, v3, s2
        mad r1.xzw, r4.xyyz, c79.x, -c79.z
        texld r4, v3.zwzw, s3
        mul r5.yzw, r4.xxyz, c79.y
        dp3 r4.w, r5.yzww, c3.w
        mad r1.xzw, r1, r4.w, r1
        mad_sat r1.xzw, r4.xyyz, c79.y, r1
        mul r4.xyz, r0.w, r1.xzww
        cmp r1.xzw, -r2.x, r4.xyyz, r1
        add r0.xyz, r0, r1.xzww
        mul r1.xz, c78.z, v2.xyyw
        texld r4, r1.xzzw, s5
        mul r0.w, r4.x, c78.w
        texld r4, v2, s4
        mad r0.w, r0.w, c3.z, r4.x
        mad r0.w, r5.x, r0.w, -c73.x
        mul_sat r0.w, r0.w, c77.x
        add r1.x, -r0.w, c3.y
        add r4.xyz, -r0.w, c70
        mul r0.w, r2.w, r1.x
        mad r0.w, r0.w, r2.y, r2.y
        mul r0.w, r3.w, r0.w
        mad r1.xzw, c71.xyyz, r0.w, r4.xyyz
        lrp r4.xyz, r2.z, c76, r1.xzww
        mul r1.xzw, r3.xyyz, r4.xyyz
        cmp r1.xzw, -r2.x, r1, r4.xyyz
        lrp r2.xyz, r1.y, r1.xzww, r0
        mul r0.xyz, r2, c87.x
        min r1.xyz, r0, c89
        min r0.xyz, c89, r1
        add r0.w, -c67.x, v1.y
        cmp oC0.xyz, r0.w, r0, c68
        mov oC0.w, c3.y
    
    // approximately 127 instruction slots used (9 texture, 118 arithmetic)
};

PixelShader PS_Black
<
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        ps_3_0
        def c0, 0, 0, 0, 0
        mov oC0, c0.x
    
    // approximately 1 instruction slot used
};

technique draw
{
    pass p0
    {
        ZEnable = true;
        ZWriteEnable = false;
        CullMode = NONE;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_Main;
        PixelShader = PS_Main;
    }
}

technique unlit_draw
{
    pass p0
    {
        ZEnable = true;
        ZWriteEnable = false;
        CullMode = NONE;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_Main;
        PixelShader = PS_Main;
    }
}

technique dpskyfront_draw
{
    pass p0
    {
        ZEnable = true;
        ZWriteEnable = false;
        CullMode = NONE;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_DpFrontMain;
        PixelShader = PS_Main;
    }
}

technique dpskyback_draw
{
    pass p0
    {
        ZEnable = true;
        ZWriteEnable = false;
        CullMode = NONE;
        AlphaBlendEnable = false;

        VertexShader = VS_DpBackMain;
        PixelShader = PS_Main;
    }
}

technique drawMiniMe
{
    pass p0
    {
        ZEnable = false;
        ZWriteEnable = true;
        CullMode = NONE;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_MiniSky;
        PixelShader = PS_MiniSky;
    }
}

technique FastblurMiniMe
{
    pass p0
    {
        ZEnable = false;
        ZWriteEnable = true;
        CullMode = NONE;
        AlphaTestEnable = false;
        AlphaBlendEnable = false;

        VertexShader = VS_BlurSky;
        PixelShader = PS_BlurSkyFast;
    }
}

technique blurMiniMe
{
    pass p0
    {
        ZEnable = false;
        ZWriteEnable = true;
        CullMode = NONE;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_BlurSky;
        PixelShader = PS_BlurSky;
    }
}

technique paraboloid_draw
{
    pass p0
    {
        ZEnable = true;
        ZWriteEnable = false;
        CullMode = NONE;
        AlphaBlendEnable = false;

        VertexShader = VS_DpGTAMain;
        PixelShader = PS_DpGTAMain;
    }
}

technique draw_sunonly
{
    pass p0
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;
        AlphaTestEnable = false;

        VertexShader = VS_MainFast;
        PixelShader = PS_SunOnly;
    }
}

technique draw_withmoon
{
    pass p0
    {
        VertexShader = VS_Main;
        PixelShader = PS_MainWithMoon;
    }
}

technique draw_withstarfield
{
    pass p0
    {
        VertexShader = VS_Main;
        PixelShader = PS_MainWithStarfield;
    }
}

technique draw_withstarfield_withmoon
{
    pass p0
    {
        VertexShader = VS_Main;
        PixelShader = PS_MainWithStarfieldWithMoon;
    }
}

technique draw_stencil
{
    pass p0
    {
        VertexShader = VS_Stencil;
        PixelShader = PS_Black;
    }
}


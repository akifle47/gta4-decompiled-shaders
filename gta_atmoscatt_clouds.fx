//Globals
shared float4 gAllGlobals[64] : AllGlobals;
shared float4x4 gWorld : World;
shared float4x4 gWorldView : WorldView;
shared float4x4 gWorldViewProj : WorldViewProjection;
shared float4x4 gViewInverse : ViewInverse;
shared float4 gLightPosDir[4] : Position<string Object = "PointDirLight"; string Space = "World";> = 
{
    float4(1403.000000, 1441.000000, 1690.000000, 0.000000), 
    float4(0.000000, 0.000000, 0.000000, 0.000000), 
    float4(0.000000, 0.000000, 0.000000, 0.000000), 
    float4(0.000000, 0.000000, 0.000000, 0.000000)
};
shared float4 gLightDir[4] : Direction<string Object = "Light Direction"; string Space = "World";> = 
{
    float4(0.000000, 0.000000, -1.000000, 0.000000), 
    float4(0.000000, 0.000000, 0.000000, 0.000000), 
    float4(0.000000, 0.000000, 0.000000, 0.000000), 
    float4(0.000000, 0.000000, 0.000000, 0.000000)
};
shared float4 gLightColor[4] : Diffuse<string UIName = "Diffuse Light Color"; string Object = "LightPos";> = 
{
    float4(1.000000, 1.000000, 1.000000, 1.000000), 
    float4(0.000000, 0.000000, 0.000000, 0.000000), 
    float4(0.000000, 0.000000, 0.000000, 0.000000), 
    float4(0.000000, 0.000000, 0.000000, 0.000000)
};
shared float4 gLightType : LightType<string UIName = "The type of each light source";> = float4(0.000000, 0.000000, 0.000000, 0.000000);
shared float4 gLightAmbient : Ambient<string UIWidget = "Ambient Light Color"; string Space = "material";> = float4(0.000000, 0.000000, 0.000000, 1.000000);
shared float gInvColorExpBias : ColorExpBias;
shared float4 gForcedColor : ForcedColor = float4(1.000000, 1.000000, 1.000000, 1.000000);
shared float4 gAspectRatio : AspectRatio = float4(1.000000, 1.000000, 1.000000, 1.000000);

//Locals
texture AttenuationMap;
sampler AttenuationSampler : AttenuationMap <string UIName = "Attenuation Map";>;
float SunElevation : SunElevation<string UIName = "Sun Elevation"; string UIWidget = "Numeric"; float UIMin = -10.000000; float UIMax = 10.000000; float UIStep = 0.500000;> = -1.000000;
float3 SunCentre : SunCentre;
float4 TexelSize : TexelSize = float4(0.000000, 0.000000, 0.000000, 0.000000);
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
    MinFilter = ANISOTROPIC;
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
    MinFilter = ANISOTROPIC;
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
    MinFilter = ANISOTROPIC;
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
    MinFilter = ANISOTROPIC;
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
    MinFilter = ANISOTROPIC;
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
    MinFilter = ANISOTROPIC;
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
    MinFilter = ANISOTROPIC;
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
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    MipMapLodBias = 0.000000;
};
float4 SunDirection : SunDirection;
float3 SkyColor : SkyColor;
float3 AzimuthColor : AzimuthColor;
float3 SunColor : SunColor;
float UnderLightStrength : UnderLightStrength;
float3 gtaSkyDomeFade : gtaSkyDomeFade = float3(0.000000, 0.000000, 0.000000);
float3 gtaWaterColor : gtaWaterColor = float3(0.000000, 0.000000, 0.000000);
float MoonGlow : MoonGlow<string UIName = "Moon Glow"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 2.000000; float UIStep = 0.010000;> = 0.200000;
float2 SunAxias : SunAxias<string UIName = "Sun Axias"; string UIWidget = "Numeric"; float UIMin = -1.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = float2(1.000000, 0.000000);
float3 AzimuthColorEast : AzimuthColorEast<string UIName = "Azimuth Color East"; string UIWidget = "Color"; float UIMin = 0.000000; float UIMax = 1.000000;> = float3(1.000000, 0.000000, 1.000000);
float AzimuthHeight : AzimuthHeight<string UIName = "Azimuth Height"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 20.000000;> = 8.000000;
float4 CloudColor : CloudColor<string UIName = "Cloud Color"; string UIWidget = "Color"; float UIMin = 0.000000; float UIMax = 1.000000;> = float4(0.930000, 1.000000, 1.000000, 1.000000);
float4 SunsetColor : SunsetColor<string UIName = "Sunset Color"; string UIWidget = "Color"; float UIMin = 0.000000; float UIMax = 1.000000;> = float4(1.000000, 0.510000, 0.380000, 1.000000);
float CloudThreshold : CloudThreshold<string UIName = "Cloud Threshold"; string UIWidget = "Numeric"; float UIMin = -5.000000; float UIMax = 5.000000; float UIStep = 0.050000;> = 1.800000;
float CloudBias : CloudBias<string UIName = "Cloud Bias"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.050000;> = 0.800000;
float CloudFadeOut : CloudFadeOut<string UIName = "Cloud Fade Out"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.050000;> = 1.000000;
float TopCloudHeight : TopCloudHeight<string UIName = "Top Cloudlayer Height"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.050000;> = 2.000000;
float TopCloudDetail : TopCloudDetail<string UIName = "Top Cloudlayer Detail"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.050000;> = 3.000000;
float TopCloudThreshold : TopCloudThreshold<string UIName = "Top Cloudlayer Threshold"; string UIWidget = "Numeric"; float UIMin = -5.000000; float UIMax = 5.000000; float UIStep = 0.020000;> = 0.900000;
float4 TopCloudBiasDetailThresholdHeight : TopCloudBiasDetailThresholdHeight<string UIName = "Top CloudLayer Bias Height"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.020000;> = float4(0.400000, 3.000000, 0.900000, 2.000000);
float3 TopCloudColor : TopCloudColor<string UIName = "Top Cloud Color"; string UIWidget = "Color"; float UIMin = 0.000000; float UIMax = 1.000000;> = float3(0.930000, 1.000000, 1.000000);
float TopCloudLight : TopCloudLight<string UIName = "Top Cloud LIght"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 10.000000;> = 0.000000;
float CloudShadowStrength : CloudShadowStrength<string UIName = "Cloud Shadow Strength"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.025000;> = 0.400000;
float CloudShadowOffset : CloudShadowOffset<string UIName = "Cloud Shadow Offset"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = 0.120000;
float CloudInscatteringRange : CloudInscatteringRange<string UIName = "Cloud Inscattering Range"; string UIWidget = "Numeric"; float UIMin = 0.100000; float UIMax = 1.000000; float UIStep = 0.100000;> = 1.000000;
float AzimuthStrength : AzimuthStrength<string UIName = "Azimuth Strength"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.100000;> = 0.500000;
float4 CloudThicknessEdgeSmoothDetailScaleStrength : CloudThicknessEdgeSmoothDetailScaleStrength<string UIName = "Cloud Thickness &  EdgeSmooth DetailScale & Strength"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 64.000000; float UIStep = 0.100000;> = float4(0.350000, 1.000000, 16.000000, 0.150000);
float4 StarFieldBrightness : StarFieldBrightness;
float StarFieldUVRepeat : StarFieldUVRepeat<string UIName = "StarFieldUVRepeat"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 64.000000; float UIStep = 0.010000;> = 16.000000;
float2 GalaxyOffset : GalaxyOffset<string UIName = "GalaxyOffset"; string UIWidget = "Numeric"; float UIMin = -16.000000; float UIMax = 16.000000; float UIStep = 0.010000;> = float2(0.000000, 0.000000);
float4 MoonTexPosition : MoonTexPosition<string UIName = "MoonTexPosition"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 64.000000; float UIStep = 0.010000;> = float4(0.500000, 0.500000, 0.500000, 0.500000);
float4 MoonLight : MoonLight<string UIName = "Moon Light"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 64.000000; float UIStep = 0.010000;> = float4(0.500000, 0.500000, 0.500000, 1.000000);
float StarThreshold : StarThreshold<string UIName = "StarField Threshold"; string UIWidget = "Numeric"; float UIMin = -1.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = 0.000000;
float MoonVisiblity : MoonVisiblity<string UIName = "Moon Visiblity"; string UIWidget = "Numeric"; float UIMin = 0.000000; float UIMax = 5.000000; float UIStep = 0.010000;> = 1.000000;
float SunSize : SunSize = 1.000000;
float4 MoonColorConstant : MoonColorConstant = float4(1.000000, 1.000000, 1.000000, 1.000000);
float3 MoonPosition : MoonPosition;
float3 MoonXVector : MoonXVector;
float3 MoonYVector : MoonYVector;
float2 DetailOffset : DetailOffset = float2(0.000000, 0.000000);
float TimeOfDay : TimeOfDay = 5.000000;
float HDRExposure : HDRExposure;
float3 HDRSunExposure : HDRSunExposure;
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
        def c4, 9.99999975e-006, 1.5, 0.500010014, 1
        def c5, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
        def c6, -2, 3.14159274, 1.57079637, 0.317732662
        def c7, 0.5, 0.100000001, 2, -1
        def c12, -0.5, -0.499989986, 0, 0
        dcl_position v0
        dcl_texcoord v1
        dcl_position o0
        dcl_texcoord o1.xyz
        dcl_texcoord1 o2.xyz
        dcl_texcoord2 o3
        dcl_texcoord3 o4
        dcl_texcoord4 o5.xyz
        dcl_texcoord5 o6.xyz
        mov_sat r0.x, -v0.y
        add r0.x, -r0.x, v0.y
        mul r0.yzw, r0.x, c1.xxyz
        mul r1, r0.x, c9
        mad r1, v0.x, c8, r1
        mad r1, v0.z, c10, r1
        mad r1, v0.w, c11, r1
        mad r0.xyz, v0.x, c0, r0.yzww
        mad r0.xyz, v0.z, c2, r0
        mad r0.xyz, v0.w, c3, r0
        add r0.xyz, r0, -c3
        add r2.xyz, r0, c4.x
        mov o2.xyz, r0
        dp3 r0.x, r2, r2
        rsq r0.x, r0.x
        mul r3.xyz, r2, r0.x
        mad r0.xy, r2.xzzw, -r0.x, c64.xzzw
        mul r3.w, r3.y, c4.y
        add r2.xyz, r3.xwzw, c4.xzxw
        dp3 r0.z, r2, r2
        rsq r0.z, r0.z
        mul r0.zw, r2.xyxz, r0.z
        mad r2.xy, r0_abs.zwzw, c5.x, c5.y
        mad r2.xy, r2, r0_abs.zwzw, c5.z
        mad r2.xy, r2, r0_abs.zwzw, c5.w
        add r2.zw, -r0_abs, c4.w
        slt r0.zw, r0, -r0
        rsq r2.z, r2.z
        rsq r2.w, r2.w
        rcp r2.w, r2.w
        mul r2.y, r2.y, r2.w
        rcp r2.z, r2.z
        mul r2.x, r2.x, r2.z
        mad r2.z, r2.x, c6.x, c6.y
        mad r0.z, r2.z, r0.z, r2.x
        add r0.z, -r0.z, c6.z
        mov r2.w, c6.w
        mad r3.z, r0.z, r2.w, c74.x
        mad r0.z, r2.y, c6.x, c6.y
        mad r0.z, r0.z, r0.w, r2.y
        add r0.z, -r0.z, c6.z
        mad r3.w, r0.z, r2.w, c74.y
        add r0.zw, r3, c7.x
        mul o4.xy, r0.zwzw, c73.x
        mov o4.zw, r0
        mov r2.xy, c7
        mul r0.z, r2.y, c70.x
        mul r0.xy, r0, r0.z
        mad r0.zw, v1.xyxy, c7.z, c7.w
        mul r0.zw, r0, r0
        add r0.z, r0.w, r0.z
        add r0.z, -r0.z, c4.w
        mad o3.xy, r0, r0.z, v1
        add r0, c12.xxyy, v1.xyxy
        mul r4, r0, r0
        add r2.yz, r4.xyww, r4.xxzw
        rsq r2.z, r2.z
        mul r0.zw, r0, r2.z
        mul r0.zw, r2.y, r0
        mov r2.z, c72.z
        mad o3.zw, r0, r2.z, c75.xyxy
        mul r0.zw, r0.xyxy, c69.w
        mad o5.xy, r0, c69.w, r2.x
        mul r0.xy, r0.zwzw, r0.zwzw
        add r0.x, r0.y, r0.x
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        add o5.z, -r0.x, c4.w
        rcp r0.x, r1.w
        mad o1.z, r1.z, -r0.x, c4.w
        mov o0, r1
        mul_sat r0.x, r3.y, c68.x
        mad r0.y, r3.x, c7.x, c7.x
        add r0.x, -r0.x, c4.w
        mul r0.x, r0.x, c71.x
        mov r1.xyz, c67
        add r1.xyz, -r1, c66
        mad r0.yzw, r0.y, r1.xxyz, c67.xxyz
        mad o6.xyz, r0.yzww, r0.x, c65
        mov o1.xy, v1
    
    // approximately 80 instruction slots used
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
        def c4, 1, 9.99999975e-006, 1.5, 0.500010014
        def c5, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
        def c6, -2, 3.14159274, 1.57079637, 0.317732662
        def c7, 0.5, 0.100000001, 2, -1
        def c12, -0.5, -0.499989986, 0, 0
        def c13, 0.5, 1, 0, -0.5
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
        add r1.xyz, r0, c4.y
        mov o2.xyz, r0
        dp3 r0.x, r1, r1
        rsq r0.x, r0.x
        mul r2.xyz, r1, r0.x
        mad r0.xy, r1.xzzw, -r0.x, c64.xzzw
        mul r2.w, r2.y, c4.z
        add r1.xyz, r2.xwzw, c4.ywyw
        dp3 r0.z, r1, r1
        rsq r0.z, r0.z
        mul r0.zw, r1.xyxz, r0.z
        mad r1.xy, r0_abs.zwzw, c5.x, c5.y
        mad r1.xy, r1, r0_abs.zwzw, c5.z
        mad r1.xy, r1, r0_abs.zwzw, c5.w
        add r1.zw, -r0_abs, c4.x
        slt r0.zw, r0, -r0
        rsq r1.z, r1.z
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        mul r1.y, r1.y, r1.w
        rcp r1.z, r1.z
        mul r1.x, r1.x, r1.z
        mad r1.z, r1.x, c6.x, c6.y
        mad r0.z, r1.z, r0.z, r1.x
        add r0.z, -r0.z, c6.z
        mov r1.w, c6.w
        mad r2.z, r0.z, r1.w, c74.x
        mad r0.z, r1.y, c6.x, c6.y
        mad r0.z, r0.z, r0.w, r1.y
        add r0.z, -r0.z, c6.z
        mad r2.w, r0.z, r1.w, c74.y
        add r0.zw, r2, c7.x
        mul o4.xy, r0.zwzw, c73.x
        mov o4.zw, r0
        mov r1.xy, c7
        mul r0.z, r1.y, c70.x
        mul r0.xy, r0, r0.z
        mad r0.zw, v1.xyxy, c7.z, c7.w
        mul r0.zw, r0, r0
        add r0.z, r0.w, r0.z
        add r0.z, -r0.z, c4.x
        mad o3.xy, r0, r0.z, v1
        add r0, c12.xxyy, v1.xyxy
        mul r3, r0, r0
        add r1.yz, r3.xyww, r3.xxzw
        rsq r1.z, r1.z
        mul r0.zw, r0, r1.z
        mul r0.zw, r1.y, r0
        mov r1.z, c72.z
        mad o3.zw, r0, r1.z, c75.xyxy
        mul r0.zw, r0.xyxy, c69.w
        mad o5.xy, r0, c69.w, r1.x
        mul r0.xy, r0.zwzw, r0.zwzw
        add r0.x, r0.y, r0.x
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        add o5.z, -r0.x, c4.x
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add r0, r0, c11
        rcp r1.x, c76.x
        mad o1.z, r0.z, -r1.x, c4.x
        mul r1.x, r0.z, r1.x
        mov o0.z, r1.x
        mul_sat r1.x, r2.y, c68.x
        mad r1.y, r2.x, c7.x, c7.x
        add r1.x, -r1.x, c4.x
        mul r1.x, r1.x, c71.x
        mov r2.xyz, c67
        add r2.xyz, -r2, c66
        mad r1.yzw, r1.y, r2.xxyz, c67.xxyz
        mad o6.xyz, r1.yzww, r1.x, c65
        rcp r0.w, r0_abs.w
        mul r0.xyz, r0, r0.w
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mad r0.z, r0.z, r0.w, c4.x
        mul r0.xy, r0, r0.w
        rcp r0.z, r0.z
        mul r0.xyz, r0.xyxw, r0.z
        mad o0.xyw, r0.xyzz, c13.xyzz, c13.wzzy
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
        def c4, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
        def c5, -2, 3.14159274, 1.57079637, 0.317732662
        def c6, 0.5, 0.100000001, 2, -1
        def c7, 1, 9.99999975e-006, 1.5, 0.500010014
        def c12, -0.5, -0.499989986, -1, -0
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
        add r1.xyz, r0, c7.y
        mov o2.xyz, r0
        dp3 r0.x, r1, r1
        rsq r0.x, r0.x
        mul r2.xyz, r1, r0.x
        mad r0.xy, r1.xzzw, -r0.x, c64.xzzw
        mul r2.w, r2.y, c7.z
        add r1.xyz, r2.xwzw, c7.ywyw
        dp3 r0.z, r1, r1
        rsq r0.z, r0.z
        mul r0.zw, r1.xyxz, r0.z
        mad r1.xy, r0_abs.zwzw, c4.x, c4.y
        mad r1.xy, r1, r0_abs.zwzw, c4.z
        mad r1.xy, r1, r0_abs.zwzw, c4.w
        add r1.zw, -r0_abs, c7.x
        slt r0.zw, r0, -r0
        rsq r1.z, r1.z
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        mul r1.y, r1.y, r1.w
        rcp r1.z, r1.z
        mul r1.x, r1.x, r1.z
        mad r1.z, r1.x, c5.x, c5.y
        mad r0.z, r1.z, r0.z, r1.x
        add r0.z, -r0.z, c5.z
        mov r1.w, c5.w
        mad r2.z, r0.z, r1.w, c74.x
        mad r0.z, r1.y, c5.x, c5.y
        mad r0.z, r0.z, r0.w, r1.y
        add r0.z, -r0.z, c5.z
        mad r2.w, r0.z, r1.w, c74.y
        add r0.zw, r2, c6.x
        mul o4.xy, r0.zwzw, c73.x
        mov o4.zw, r0
        mov r1.xy, c6
        mul r0.z, r1.y, c70.x
        mul r0.xy, r0, r0.z
        mad r0.zw, v1.xyxy, c6.z, c6.w
        mul r0.zw, r0, r0
        add r0.z, r0.w, r0.z
        add r0.z, -r0.z, c7.x
        mad o3.xy, r0, r0.z, v1
        add r0, c12.xxyy, v1.xyxy
        mul r3, r0, r0
        add r1.yz, r3.xyww, r3.xxzw
        rsq r1.z, r1.z
        mul r0.zw, r0, r1.z
        mul r0.zw, r1.y, r0
        mov r1.z, c72.z
        mad o3.zw, r0, r1.z, c75.xyxy
        mul r0.zw, r0.xyxy, c69.w
        mad o5.xy, r0, c69.w, r1.x
        mul r0.xy, r0.zwzw, r0.zwzw
        add r0.x, r0.y, r0.x
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        add o5.z, -r0.x, c7.x
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add r0, r0, c11
        rcp r1.x, c76.x
        mad o1.z, r0.z, -r1.x, c7.x
        mul r1.x, r0.z, r1.x
        mov o0.z, r1.x
        mul_sat r1.x, r2.y, c68.x
        mad r1.y, r2.x, c6.x, c6.x
        add r1.x, -r1.x, c7.x
        mul r1.x, r1.x, c71.x
        mov r2.xyz, c67
        add r2.xyz, -r2, c66
        mad r1.yzw, r1.y, r2.xxyz, c67.xxyz
        mad o6.xyz, r1.yzww, r1.x, c65
        rcp r0.w, r0_abs.w
        mul r0.xyz, r0, r0.w
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mad r0.z, r0.z, r0.w, c7.x
        mul r0.xy, r0, r0.w
        rcp r0.z, r0.z
        mul r0.xyz, r0.xyxw, r0.z
        mad o0.xyw, r0.xyzz, -c12.xzzw, -c12.xwzz
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
        def c8, 512, -0.00039999999, 0.00039999999, -1
        def c9, 0.200000003, 1, 9.99999975e-006, 1.5
        def c10, 9.99999975e-006, 0.500010014, -0.0187292993, 0.0742610022
        def c11, -0.212114394, 1.57072878, -2, 3.14159274
        def c12, 1.57079637, 0.317732662, 0.5, 0.100000001
        def c13, 2, -1, -0.5, -0.499989986
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
        add r1.xyz, r0, c9.z
        mov o2.xyz, r0
        dp3 r0.x, r1, r1
        rsq r0.x, r0.x
        mul r2.xyz, r1, r0.x
        mad r0.xy, r1.xzzw, -r0.x, c64.xzzw
        mul r2.w, r2.y, c9.w
        add r1.xyz, r2.xwzw, c10.xyxw
        dp3 r0.z, r1, r1
        rsq r0.z, r0.z
        mul r0.zw, r1.xyxz, r0.z
        mad r1.xy, r0_abs.zwzw, c10.z, c10.w
        mad r1.xy, r1, r0_abs.zwzw, c11.x
        mad r1.xy, r1, r0_abs.zwzw, c11.y
        add r1.zw, -r0_abs, -c8.w
        slt r0.zw, r0, -r0
        rsq r1.z, r1.z
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        mul r1.y, r1.y, r1.w
        rcp r1.z, r1.z
        mul r1.x, r1.x, r1.z
        mad r1.z, r1.x, c11.z, c11.w
        mad r0.z, r1.z, r0.z, r1.x
        add r0.z, -r0.z, c12.x
        mov r3.yzw, c12
        mad r1.z, r0.z, r3.y, c74.x
        mad r0.z, r1.y, c11.z, c11.w
        mad r0.z, r0.z, r0.w, r1.y
        add r0.z, -r0.z, c12.x
        mad r1.w, r0.z, r3.y, c74.y
        add r0.zw, r1, c12.z
        mul o4.xy, r0.zwzw, c73.x
        mov o4.zw, r0
        mul r0.z, r3.w, c70.x
        mul r0.xy, r0, r0.z
        mad r0.zw, v1.xyxy, c13.x, c13.y
        mul r0.zw, r0, r0
        add r0.z, r0.w, r0.z
        add r0.z, -r0.z, -c8.w
        mad o3.xy, r0, r0.z, v1
        add r0, c13.zzww, v1.xyxy
        mul r1, r0, r0
        add r1.xy, r1.ywzw, r1.xzzw
        rsq r1.y, r1.y
        mul r0.zw, r0, r1.y
        mul r0.zw, r1.x, r0
        mov r1.z, c72.z
        mad o3.zw, r0, r1.z, c75.xyxy
        mul r0.zw, r0.xyxy, c69.w
        mad o5.xy, r0, c69.w, r3.z
        mul r0.xy, r0.zwzw, r0.zwzw
        add r0.x, r0.y, r0.x
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        add o5.z, -r0.x, -c8.w
        mul r0.xyz, c5, v0.y
        mad r0.xyz, v0.x, c4, r0
        mad r0.xyz, v0.z, c6, r0
        add r0.xyz, r0, c7
        add r0.w, r0.z, c8.x
        dp3 r0.w, r0.xyww, r0.xyww
        rsq r0.w, r0.w
        rcp r1.x, r0.w
        add r1.y, r1.x, -c8.w
        rcp r1.y, r1.y
        add r3.z, -r1.y, -c8.w
        mov r4.z, -c8.w
        mad o1.z, r3.z, -r4.z, -c8.w
        mul_sat r1.y, r2.y, c68.x
        mad r1.z, r2.x, c12.z, c12.z
        add r1.y, -r1.y, -c8.w
        mul r1.y, r1.y, c71.x
        mov r2.xyz, c67
        add r2.xyz, -r2, c66
        mad r2.xyz, r1.z, r2, c67
        mad o6.xyz, r2, r1.y, c65
        add r0.z, r0.z, c8.x
        mad r0.w, r0.z, -r0.w, -c8.w
        mul r1.yz, r0.z, c8.xzyw
        mul r0.z, r1.x, r0.w
        rcp r0.z, r0.z
        mul r3.xy, r0, r0.z
        max r0.x, r1.z, c8.w
        mov_sat r1.y, r1.y
        mad r4.y, r1.y, c9.x, c9.y
        min r0.x, r0.x, -c8.w
        mad r4.x, r0.x, -c9.x, c9.y
        mul r0.xyz, r3, r4
        mov o0.xyz, r0
        mov o0.w, -c8.w
        mov o1.xy, v1
    
    // approximately 97 instruction slots used
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
        def c4, 9.99999975e-006, 4, 1, -0.212114394
        def c5, -0.0187292993, 0.0742610022, 1.57072878, 1.57079637
        def c6, -2, 3.14159274, 0.317732662, 0.5
        def c7, 1, 1.5, 9.99999975e-006, 0.500010014
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
        add r1, r0, c4.x
        dp3 r0.x, r1.yzww, r1.yzww
        rsq r0.x, r0.x
        mul r1, r1, r0.x
        mov r2.y, c4.y
        mad_sat o3.w, r1.x, r2.y, -c68.x
        mad r2.xyz, r1.yzww, c7.xyxw, c7.zwzw
        dp3 r0.x, r2, r2
        rsq r0.x, r0.x
        mul r1.xw, r2.xyzz, r0.x
        mad r2.xy, r1_abs.xwzw, c5.x, c5.y
        mad r2.xy, r2, r1_abs.xwzw, c4.w
        mad r2.xy, r2, r1_abs.xwzw, c5.z
        add r2.zw, -r1_abs.xyxw, c4.z
        slt r1.xw, r1, -r1
        rsq r0.x, r2.z
        rsq r2.z, r2.w
        rcp r2.z, r2.z
        mul r2.y, r2.y, r2.z
        rcp r0.x, r0.x
        mul r0.x, r2.x, r0.x
        mad r2.x, r0.x, c6.x, c6.y
        mad r0.x, r2.x, r1.x, r0.x
        add r0.x, -r0.x, c5.w
        mad r3.x, r0.x, c6.z, c6.w
        mad r0.x, r2.y, c6.x, c6.y
        mad r0.x, r0.x, r1.w, r2.y
        add r0.x, -r0.x, c5.w
        mad r3.y, r0.x, c6.z, c6.w
        add r1.xw, r3.xyzy, c72.xyzy
        add r2.xy, r3, -c73.zwzw
        mul o2.xy, r2, c73.x
        mul o4.xy, r1.xwzw, c71.x
        mov o4.zw, r1.xyxw
        add r1.xw, -c6.w, v1.xyzy
        mul r2.xy, r1.xwzw, c69.w
        mov r2.w, c6.w
        mad o3.xy, r1.xwzw, c69.w, r2.w
        mul r1.xw, r2.xyzy, r2.xyzy
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
        mad r1.x, r1.y, c6.w, c6.w
        add r0.x, -r0.x, c4.z
        mul r0.x, r0.x, c70.x
        mov r2.xyz, c66
        add r1.yzw, -r2.xxyz, c65.xxyz
        mad r1.xyz, r1.x, r1.yzww, c66
        mad o5.xyz, r1, r0.x, c64
        mov o1.xy, v1
        mov o1.w, r0.w
        mov o2.zw, r0.xyyz
    
    // approximately 66 instruction slots used
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
        mul r0, c9.xyww, v0.y
        mad r0, v0.x, c8.xyww, r0
        mad r0, v0.z, c10.xyww, r0
        mad o0, v0.w, c11.xyww, r0
    
    // approximately 4 instruction slots used
};

//Pixel shaders
PixelShader PixelShader0 = NULL;

PixelShader PS_Main
<
    string CloudBias                                   = "parameter register(72)";
    string CloudColor                                  = "parameter register(69)";
    string CloudFadeOut                                = "parameter register(73)";
    string CloudInscatteringRange                      = "parameter register(77)";
    string CloudShadowStrength                         = "parameter register(76)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(78)";
    string CloudThreshold                              = "parameter register(71)";
    string GalaxySampler                               = "parameter register(0)";
    string HDRExposure                                 = "parameter register(81)";
    string HDRExposureClamp                            = "parameter register(83)";
    string HDRSunExposure                              = "parameter register(82)";
    string HighDetailNoiseSampler                      = "parameter register(2)";
    string PerlinNoiseSampler                          = "parameter register(1)";
    string StarFieldBrightness                         = "parameter register(79)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(66)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(80)";
    string SunsetColor                                 = "parameter register(70)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(74)";
    string TopCloudColor                               = "parameter register(75)";
    string gtaSkyDomeFade                              = "parameter register(67)";
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
    //   float CloudInscatteringRange;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float3 HDRSunExposure;
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
    //   float3 gtaSkyDomeFade;
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
    //   gtaSkyDomeFade                              c67      1
    //   gtaWaterColor                               c68      1
    //   CloudColor                                  c69      1
    //   SunsetColor                                 c70      1
    //   CloudThreshold                              c71      1
    //   CloudBias                                   c72      1
    //   CloudFadeOut                                c73      1
    //   TopCloudBiasDetailThresholdHeight           c74      1
    //   TopCloudColor                               c75      1
    //   CloudShadowStrength                         c76      1
    //   CloudInscatteringRange                      c77      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c78      1
    //   StarFieldBrightness                         c79      1
    //   SunSize                                     c80      1
    //   HDRExposure                                 c81      1
    //   HDRSunExposure                              c82      1
    //   HDRExposureClamp                            c83      1
    //   GalaxySampler                               s0       1
    //   PerlinNoiseSampler                          s1       1
    //   HighDetailNoiseSampler                      s2       1
    //
    
        ps_3_0
        def c0, 0.200000003, 0, 0.25, 0.349999994
        def c1, 9.99999975e-006, 1, -11.6163721, 32
        def c2, 0.9375, 0.5, 12.5799999, -0.0625
        def c3, 0.600000024, -2, 3, 4
        dcl_texcoord_pp v0.xy
        dcl_texcoord1_pp v1.xyz
        dcl_texcoord2_pp v2
        dcl_texcoord3_pp v3.zw
        dcl_texcoord4_pp v4.xyz
        dcl_texcoord5_pp v5.xyz
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        mov r0.xw, c3
        add_sat r0.x, r0.x, c65.w
        mov r1.yz, c2.xxyw
        mov r0.y, c1.y
        add_sat r0.z, r0.y, -c82.y
        mul r1.x, r0.z, c1.z
        add r2.xyz, c1.x, v1
        nrm_pp r3.xyz, r2
        dp3_pp r2.y, r3, c65
        mad_sat_pp r0.w, r3.y, r0.w, -c73.x
        mul r2.x, r0.z, r2.y
        mad_sat r1.xyz, r2.xyyw, c2.zwyw, r1
        mul r0.z, r1.y, r1.y
        mul r0.z, r1.y, r0.z
        pow r2.x, r1.x, c1.w
        mad r0.x, r0.z, -r0.x, r2.x
        mad r0.x, r1.z, c80.x, r0.x
        mad_sat r0.z, r1.z, c64.y, c64.x
        mul_sat r0.x, r0.x, c2.y
        mul r1.x, r0.z, r0.z
        mad r0.z, r0.z, c3.y, c3.z
        mul r0.z, r1.x, r0.z
        mul r0.z, r0.z, c64.z
        mad_pp r0.x, r0.x, c3.w, r0.z
        mul_pp r1.xyz, r0.x, c66
        add_sat_pp r0.x, -r0.x, c1.y
        mul_pp r0.x, r0.x, c82.x
        mul_sat_pp r2.xzw, r0.x, v5.xyyz
        mul r3.xyz, r1_abs, r1_abs
        mad_pp r1.xyz, r3, r3, r1
        mad_pp r1.xyz, r1, c82.x, r2.xzww
        texld_pp r3, v3.zwzw, s0
        mad_pp r1.xyz, r3, c79.y, r1
        mad r0.x, r2.y, c0.z, c0.w
        mul_pp r0.z, r2.y, r2.y
        mul r2.xy, c78.z, v2
        texld r2, r2, s2
        mul r1.w, r2.x, c78.w
        texld_pp r2, v2, s1
        mad_pp r1.w, r1.w, c0.x, r2.x
        mov r2.x, c71.x
        mad r1.w, r2.x, r1.w, -c72.x
        mul_sat_pp r1.w, r1.w, c76.x
        add r2.y, -r1.w, c1.y
        texld_pp r3, v0, s1
        texld_pp r4, v2.zwzw, s2
        add_pp r2.z, r4.x, -c2.y
        mad_pp r2.w, r2.z, c78.w, r3.x
        mad_sat r3.x, r2.z, c0.x, r3.z
        mul_pp r2.z, r2.z, c78.w
        mad_sat_pp r2.x, r2.x, r2.w, -c72.x
        pow r3.y, r2.x, c78.x
        mul_sat r2.x, r2.x, c78.y
        mul_pp r2.w, r3.y, r2.x
        mad r2.x, r3.y, -r2.x, c1.y
        mul r2.y, r2.y, r2.w
        mad_pp r2.y, r2.y, r3.x, r3.x
        mul_pp r0.x, r0.x, r2.y
        mad r2.y, r1.w, -c2.y, r2.x
        max r3.x, r2.y, c0.y
        mul r0.z, r0.z, r3.x
        mad_pp r0.y, r0.z, c77.x, r0.y
        mad r3.xyz, r0.y, c69, -r1.w
        mad_pp r0.xyz, c70, r0.x, r3
        texld_pp r3, v4, s1
        mad_pp r1.w, r2.z, c74.y, r3.y
        mad_sat r1.w, c74.z, r1.w, -c74.x
        mul_pp r1.w, r1.w, v4.z
        mul_pp r1.w, r2.x, r1.w
        mad_pp r2.x, r2.x, r1.w, r2.w
        lrp_pp r2.yzw, r1.w, c75.xxyz, r0.xxyz
        mul_pp r0.x, r0.w, r2.x
        lrp_pp r3.xyz, r0.x, r2.yzww, r1
        mul_pp r0.xyz, r3, c81.x
        min_pp r1.xyz, r0, c83
        min_pp r0.xyz, c83, r1
        add r1.xyz, -r0, c68
        add r0.w, c67.x, -v1.y
        mul_sat r0.w, r0.w, c67.y
        mad oC0.xyz, r0.w, r1, r0
        mov oC0.w, c1.y
    
    // approximately 87 instruction slots used (6 texture, 81 arithmetic)
};

PixelShader PS_MiniSky
<
    string AzimuthColor                                = "parameter register(67)";
    string AzimuthColorEast                            = "parameter register(69)";
    string AzimuthHeight                               = "parameter register(70)";
    string AzimuthStrength                             = "parameter register(80)";
    string CloudBias                                   = "parameter register(74)";
    string CloudColor                                  = "parameter register(71)";
    string CloudFadeOut                                = "parameter register(75)";
    string CloudInscatteringRange                      = "parameter register(79)";
    string CloudShadowStrength                         = "parameter register(78)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(81)";
    string CloudThreshold                              = "parameter register(73)";
    string GalaxySampler                               = "parameter register(0)";
    string HDRExposure                                 = "parameter register(84)";
    string HDRExposureClamp                            = "parameter register(86)";
    string HDRSunExposure                              = "parameter register(85)";
    string HighDetailNoiseSampler                      = "parameter register(2)";
    string PerlinNoiseSampler                          = "parameter register(1)";
    string SkyColor                                    = "parameter register(66)";
    string StarFieldBrightness                         = "parameter register(82)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(68)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(83)";
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
    //   float CloudInscatteringRange;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float3 HDRSunExposure;
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
    //   CloudInscatteringRange                      c79      1
    //   AzimuthStrength                             c80      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c81      1
    //   StarFieldBrightness                         c82      1
    //   SunSize                                     c83      1
    //   HDRExposure                                 c84      1
    //   HDRSunExposure                              c85      1
    //   HDRExposureClamp                            c86      1
    //   GalaxySampler                               s0       1
    //   PerlinNoiseSampler                          s1       1
    //   HighDetailNoiseSampler                      s2       1
    //
    
        ps_3_0
        def c0, -0.5, 0, 1, 4000
        def c1, 2, 9.99999975e-006, 32, 0.600000024
        def c2, 12.5799999, -0.0625, 0.5, 0.25
        def c3, -11.6163721, 0.9375, 0.5, 0.349999994
        def c4, -2, 3, 4, 0.200000003
        dcl_texcoord_pp v0.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        add_pp r0.xy, c0.x, v0
        mad r0.zw, r0.xyxy, c1.x, c1.y
        add r0.xy, r0, r0
        dp2add r0.x, r0, r0, c0.y
        dp2add r0.y, r0.zwzw, r0.zwzw, c0.y
        rsq r0.y, r0.y
        mul r0.yz, r0.xzww, r0.y
        mul r0.yz, r0.x, r0
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        add r0.x, -r0.x, c0.z
        mul r1.xyz, r0.yxzw, c0.w
        add r0.xyz, r1, c1.y
        nrm r1.xyz, r0
        mul_sat r0.x, r1.y, c70.x
        add r0.x, -r0.x, c0.z
        mul r0.x, r0.x, c80.x
        mad r0.y, r1.x, -c0.x, -c0.x
        mov r2.xyz, c69
        add r2.xyz, -r2, c67
        mad r0.yzw, r0.y, r2.xxyz, c69.xxyz
        mad_pp r0.xyz, r0.yzww, r0.x, c66
        dp3 r0.w, r1, c65
        mov r1.z, c4.z
        mad_sat_pp r1.x, r1.y, r1.z, -c75.x
        mov r2, c2
        mad r2, r0.w, r2, c3
        mul_pp r0.w, r0.w, r0.w
        mov_sat r2.xyz, r2
        mul r1.y, r2.y, r2.y
        mul r1.y, r2.y, r1.y
        pow r1.z, r2.x, c1.z
        mov r1.w, c1.w
        add_sat r1.w, r1.w, c65.w
        mad r1.y, r1.y, -r1.w, r1.z
        mad r1.y, r2.z, c83.x, r1.y
        mad_sat r1.z, r2.z, c64.y, c64.x
        mul_sat r1.y, r1.y, -c0.x
        mul r1.w, r1.z, r1.z
        mad r1.z, r1.z, c4.x, c4.y
        mul r1.z, r1.w, r1.z
        mul r1.z, r1.z, c64.z
        mad r1.y, r1.y, c4.z, r1.z
        mul r2.xyz, r1.y, c68
        add_sat r3.w, -r1.y, c0.z
        mul r1.yzw, r2_abs.xxyz, r2_abs.xxyz
        mad r3.xyz, r1.yzww, r1.yzww, r2
        mul_pp r3, r3, c85.x
        mul_sat_pp r0.xyz, r0, r3.w
        min_pp r1.yzw, c86.xxyz, r3.xxyz
        add_pp r0.xyz, r0, r1.yzww
        texld_pp r3, v0, s0
        mad_pp r0.xyz, r3, c82.y, r0
        mul r1.yz, c81.z, v0.xxyw
        texld r3, r1.yzzw, s2
        mul r1.y, r3.x, c81.w
        texld_pp r3, v0, s1
        mad_pp r1.y, r1.y, c4.w, r3.x
        mov r2.x, c73.x
        mad r1.y, r2.x, r1.y, -c74.x
        mul_sat_pp r1.y, r1.y, c78.x
        add r1.z, -r1.y, c0.z
        texld_pp r4, v0, s2
        add_pp r1.w, r4.x, c0.x
        mad_pp r2.y, r1.w, c81.w, r3.x
        mad_sat_pp r2.x, r2.x, r2.y, -c74.x
        pow r3.x, r2.x, c81.x
        mul_sat r2.x, r2.x, c81.y
        mul_pp r2.y, r3.x, r2.x
        mad r2.x, r3.x, -r2.x, c0.z
        mul r1.z, r1.z, r2.y
        mad_sat r2.z, r1.w, c4.w, r3.z
        mul_pp r1.w, r1.w, c81.w
        mad_pp r1.w, r1.w, c76.y, r3.y
        mad_sat r1.w, c76.z, r1.w, -c76.x
        mul_pp r1.w, r1.w, v0.x
        mul_pp r1.w, r2.x, r1.w
        mad_pp r1.z, r1.z, r2.z, r2.z
        mul_pp r1.z, r2.w, r1.z
        mad r2.z, r1.y, c0.x, r2.x
        mad_pp r2.x, r2.x, r1.w, r2.y
        mul_pp r1.x, r1.x, r2.x
        max r3.x, r2.z, c0.y
        mul r0.w, r0.w, r3.x
        mov r2.z, c0.z
        mad_pp r0.w, r0.w, c79.x, r2.z
        mad r2.xyz, r0.w, c71, -r1.y
        mad_pp r2.xyz, c72, r1.z, r2
        lrp_pp r3.xyz, r1.w, c77, r2
        lrp_pp r2.xyz, r1.x, r3, r0
        mul_pp r0.xyz, r2, c84.x
        min_pp oC0.xyz, r0, c86
        mov oC0.w, c0.z
    
    // approximately 101 instruction slots used (4 texture, 97 arithmetic)
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
    string CloudInscatteringRange                      = "parameter register(77)";
    string CloudShadowStrength                         = "parameter register(76)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(78)";
    string CloudThreshold                              = "parameter register(71)";
    string GalaxySampler                               = "parameter register(0)";
    string HDRExposure                                 = "parameter register(81)";
    string HDRExposureClamp                            = "parameter register(83)";
    string HDRSunExposure                              = "parameter register(82)";
    string HighDetailNoiseSampler                      = "parameter register(2)";
    string PerlinNoiseSampler                          = "parameter register(1)";
    string StarFieldBrightness                         = "parameter register(79)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(66)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(80)";
    string SunsetColor                                 = "parameter register(70)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(74)";
    string TopCloudColor                               = "parameter register(75)";
    string gtaSkyDomeFade                              = "parameter register(67)";
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
    //   float CloudInscatteringRange;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float3 HDRSunExposure;
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
    //   float3 gtaSkyDomeFade;
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
    //   gtaSkyDomeFade                              c67      1
    //   gtaWaterColor                               c68      1
    //   CloudColor                                  c69      1
    //   SunsetColor                                 c70      1
    //   CloudThreshold                              c71      1
    //   CloudBias                                   c72      1
    //   CloudFadeOut                                c73      1
    //   TopCloudBiasDetailThresholdHeight           c74      1
    //   TopCloudColor                               c75      1
    //   CloudShadowStrength                         c76      1
    //   CloudInscatteringRange                      c77      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c78      1
    //   StarFieldBrightness                         c79      1
    //   SunSize                                     c80      1
    //   HDRExposure                                 c81      1
    //   HDRSunExposure                              c82      1
    //   HDRExposureClamp                            c83      1
    //   GalaxySampler                               s0       1
    //   PerlinNoiseSampler                          s1       1
    //   HighDetailNoiseSampler                      s2       1
    //
    
        ps_3_0
        def c0, 0.200000003, 0, 0.25, 0.349999994
        def c1, 9.99999975e-006, 1, -11.6163721, 32
        def c2, 0.9375, 0.5, 12.5799999, -0.0625
        def c3, 0.600000024, -2, 3, 4
        dcl_texcoord_pp v0.xy
        dcl_texcoord1_pp v1.xyz
        dcl_texcoord2_pp v2
        dcl_texcoord3_pp v3.zw
        dcl_texcoord4_pp v4.xyz
        dcl_texcoord5_pp v5.xyz
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        mov r0.xw, c3
        add_sat r0.x, r0.x, c65.w
        mov r1.yz, c2.xxyw
        mov r0.y, c1.y
        add_sat r0.z, r0.y, -c82.y
        mul r1.x, r0.z, c1.z
        add r2.xyz, c1.x, v1
        nrm_pp r3.xyz, r2
        dp3_pp r2.y, r3, c65
        mad_sat_pp r0.w, r3.y, r0.w, -c73.x
        mul r2.x, r0.z, r2.y
        mad_sat r1.xyz, r2.xyyw, c2.zwyw, r1
        mul r0.z, r1.y, r1.y
        mul r0.z, r1.y, r0.z
        pow r2.x, r1.x, c1.w
        mad r0.x, r0.z, -r0.x, r2.x
        mad r0.x, r1.z, c80.x, r0.x
        mad_sat r0.z, r1.z, c64.y, c64.x
        mul_sat r0.x, r0.x, c2.y
        mul r1.x, r0.z, r0.z
        mad r0.z, r0.z, c3.y, c3.z
        mul r0.z, r1.x, r0.z
        mul r0.z, r0.z, c64.z
        mad_pp r0.x, r0.x, c3.w, r0.z
        mul_pp r1.xyz, r0.x, c66
        add_sat_pp r0.x, -r0.x, c1.y
        mul_pp r0.x, r0.x, c82.x
        mul_sat_pp r2.xzw, r0.x, v5.xyyz
        mul r3.xyz, r1_abs, r1_abs
        mad_pp r1.xyz, r3, r3, r1
        mad_pp r1.xyz, r1, c82.x, r2.xzww
        texld_pp r3, v3.zwzw, s0
        mad_pp r1.xyz, r3, c79.y, r1
        mad r0.x, r2.y, c0.z, c0.w
        mul_pp r0.z, r2.y, r2.y
        mul r2.xy, c78.z, v2
        texld r2, r2, s2
        mul r1.w, r2.x, c78.w
        texld_pp r2, v2, s1
        mad_pp r1.w, r1.w, c0.x, r2.x
        mov r2.x, c71.x
        mad r1.w, r2.x, r1.w, -c72.x
        mul_sat_pp r1.w, r1.w, c76.x
        add r2.y, -r1.w, c1.y
        texld_pp r3, v0, s1
        texld_pp r4, v2.zwzw, s2
        add_pp r2.z, r4.x, -c2.y
        mad_pp r2.w, r2.z, c78.w, r3.x
        mad_sat r3.x, r2.z, c0.x, r3.z
        mul_pp r2.z, r2.z, c78.w
        mad_sat_pp r2.x, r2.x, r2.w, -c72.x
        pow r3.y, r2.x, c78.x
        mul_sat r2.x, r2.x, c78.y
        mul_pp r2.w, r3.y, r2.x
        mad r2.x, r3.y, -r2.x, c1.y
        mul r2.y, r2.y, r2.w
        mad_pp r2.y, r2.y, r3.x, r3.x
        mul_pp r0.x, r0.x, r2.y
        mad r2.y, r1.w, -c2.y, r2.x
        max r3.x, r2.y, c0.y
        mul r0.z, r0.z, r3.x
        mad_pp r0.y, r0.z, c77.x, r0.y
        mad r3.xyz, r0.y, c69, -r1.w
        mad_pp r0.xyz, c70, r0.x, r3
        texld_pp r3, v4, s1
        mad_pp r1.w, r2.z, c74.y, r3.y
        mad_sat r1.w, c74.z, r1.w, -c74.x
        mul_pp r1.w, r1.w, v4.z
        mul_pp r1.w, r2.x, r1.w
        mad_pp r2.x, r2.x, r1.w, r2.w
        lrp_pp r2.yzw, r1.w, c75.xxyz, r0.xxyz
        mul_pp r0.x, r0.w, r2.x
        lrp_pp r3.xyz, r0.x, r2.yzww, r1
        mul_pp r0.xyz, r3, c81.x
        min_pp r1.xyz, r0, c83
        min_pp r0.xyz, c83, r1
        add r1.xyz, -r0, c68
        add r0.w, c67.x, -v1.y
        mul_sat r0.w, r0.w, c67.y
        mad oC0.xyz, r0.w, r1, r0
        mov oC0.w, c1.y
    
    // approximately 87 instruction slots used (6 texture, 81 arithmetic)
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
    //   float3 HDRSunExposure;
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
        def c0, 9.99999975e-006, 1, 0.5, 4
        def c1, -2, 3, 0, 0
        dcl_texcoord_pp v0.w
        dcl_texcoord1_pp v1.zw
        mov_pp r0.xy, v1.zwzw
        mov_pp r0.z, v0.w
        add r0.xyz, r0, c0.x
        nrm_pp r1.xyz, r0
        mov r0.xz, c0
        add r0.xyw, r0.x, c65.xyzz
        nrm_pp r2.xyz, r0.xyww
        dp3_pp r0.x, r1, r2
        add_pp r0.x, r0.x, c0.y
        mad r0.x, r0.x, r0.z, -c64.x
        add r0.y, -c64.x, c64.y
        rcp r0.y, r0.y
        mul_sat r0.x, r0.x, r0.y
        mad r0.y, r0.x, c1.x, c1.y
        mul r0.x, r0.x, r0.x
        mul r0.x, r0.y, r0.x
        mul_pp r0.x, r0.x, c64.z
        mul_pp r0.x, r0.x, c0.w
        mul_pp r0.xyz, r0.x, c66
        mul r1.xyz, r0_abs, r0_abs
        mad_pp r0.xyz, r1, r1, r0
        mul_pp r0.xyz, r0, c67.x
        min_pp oC0.xyz, c68, r0
        mov_pp oC0.w, c0.y
    
    // approximately 28 instruction slots used
};

PixelShader PS_MainWithMoon
<
    string CloudBias                                   = "parameter register(73)";
    string CloudColor                                  = "parameter register(70)";
    string CloudFadeOut                                = "parameter register(74)";
    string CloudInscatteringRange                      = "parameter register(78)";
    string CloudShadowStrength                         = "parameter register(77)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(79)";
    string CloudThreshold                              = "parameter register(72)";
    string GalaxySampler                               = "parameter register(2)";
    string HDRExposure                                 = "parameter register(88)";
    string HDRExposureClamp                            = "parameter register(90)";
    string HDRSunExposure                              = "parameter register(89)";
    string HighDetailNoiseSampler                      = "parameter register(4)";
    string MoonColorConstant                           = "parameter register(84)";
    string MoonGlow                                    = "parameter register(69)";
    string MoonGlowSampler                             = "parameter register(1)";
    string MoonLight                                   = "parameter register(81)";
    string MoonPosition                                = "parameter register(85)";
    string MoonSampler                                 = "parameter register(0)";
    string MoonVisiblity                               = "parameter register(82)";
    string MoonXVector                                 = "parameter register(86)";
    string MoonYVector                                 = "parameter register(87)";
    string PerlinNoiseSampler                          = "parameter register(3)";
    string StarFieldBrightness                         = "parameter register(80)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(66)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(83)";
    string SunsetColor                                 = "parameter register(71)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(75)";
    string TopCloudColor                               = "parameter register(76)";
    string gtaSkyDomeFade                              = "parameter register(67)";
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
    //   float CloudInscatteringRange;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float3 HDRSunExposure;
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
    //   float3 gtaSkyDomeFade;
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
    //   gtaSkyDomeFade                              c67      1
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
    //   CloudInscatteringRange                      c78      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c79      1
    //   StarFieldBrightness                         c80      1
    //   MoonLight                                   c81      1
    //   MoonVisiblity                               c82      1
    //   SunSize                                     c83      1
    //   MoonColorConstant                           c84      1
    //   MoonPosition                                c85      1
    //   MoonXVector                                 c86      1
    //   MoonYVector                                 c87      1
    //   HDRExposure                                 c88      1
    //   HDRSunExposure                              c89      1
    //   HDRExposureClamp                            c90      1
    //   MoonSampler                                 s0       1
    //   MoonGlowSampler                             s1       1
    //   GalaxySampler                               s2       1
    //   PerlinNoiseSampler                          s3       1
    //   HighDetailNoiseSampler                      s4       1
    //
    
        ps_3_0
        def c0, 9.99999975e-006, 1, -11.6163721, 32
        def c1, 0.9375, 0.5, 12.5799999, -0.0625
        def c2, 0.600000024, -2, 3, 4
        def c3, 0.200000003, 0, 0.25, 0.349999994
        def c4, 0.899999976, 0.5, 0, 1
        def c5, 64, 0.300000012, 0.699999988, 0.170000002
        def c6, 1, 1.39999998, 0, 0
        dcl_texcoord_pp v0.xy
        dcl_texcoord1_pp v1.xyz
        dcl_texcoord2_pp v2
        dcl_texcoord3_pp v3.zw
        dcl_texcoord4_pp v4.xyz
        dcl_texcoord5_pp v5.xyz
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s3
        dcl_2d s4
        add r0.xyz, c0.x, v1
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul_pp r1.xyz, r0, r0.w
        mov r2.y, c0.y
        add_sat r1.w, r2.y, -c89.y
        dp3_pp r3.y, r1, c65
        mul r3.x, r1.w, r3.y
        mul r4.x, r1.w, c0.z
        mov r4.yz, c1.xxyw
        mad_sat r1.xzw, r3.xyyy, c1.zywy, r4.xyyz
        pow r2.x, r1.x, c0.w
        mul r1.x, r1.z, r1.z
        mul r1.x, r1.z, r1.x
        mov r3.xw, c2
        add_sat r1.z, r3.x, c65.w
        mad r1.x, r1.x, -r1.z, r2.x
        mad r1.x, r1.w, c83.x, r1.x
        mul_sat r1.x, r1.x, c1.y
        mad_sat r1.z, r1.w, c64.y, c64.x
        mul r1.w, r1.z, r1.z
        mad r1.z, r1.z, c2.y, c2.z
        mul r1.z, r1.w, r1.z
        mul r1.z, r1.z, c64.z
        mad_pp r1.x, r1.x, c2.w, r1.z
        add_sat_pp r1.z, -r1.x, c0.y
        mul_pp r2.xzw, r1.x, c66.xyyz
        mul r4.xyz, r2_abs.xzww, r2_abs.xzww
        mad_pp r2.xzw, r4.xyyz, r4.xyyz, r2
        mul_pp r1.x, r1.z, c89.x
        texld_pp r4, v0, s3
        texld_pp r5, v2.zwzw, s4
        add_pp r1.z, r5.x, -c1.y
        mul_pp r1.w, r1.z, c79.w
        mad_pp r3.x, r1.z, c79.w, r4.x
        mov r4.x, c72.x
        mad_sat_pp r3.x, r4.x, r3.x, -c73.x
        pow r4.y, r3.x, c79.x
        mul_sat r3.x, r3.x, c79.y
        mul_pp r3.z, r4.y, r3.x
        texld_pp r5, v2, s3
        mul r5.yz, c79.z, v2.xxyw
        texld r6, r5.yzzw, s4
        mul r4.w, r6.x, c79.w
        mad_pp r4.w, r4.w, c3.x, r5.x
        mad r4.x, r4.x, r4.w, -c73.x
        mul_sat_pp r4.x, r4.x, c77.x
        texld_pp r5, v4, s3
        mad_pp r1.w, r1.w, c75.y, r5.y
        mad_sat r1.w, c75.z, r1.w, -c75.x
        mul_pp r1.w, r1.w, v4.z
        mul_pp r4.w, r3.y, r3.y
        mad r3.x, r4.y, -r3.x, c0.y
        mad r4.y, r4.x, -c1.y, r3.x
        max r5.x, r4.y, c3.y
        mul r4.y, r4.w, r5.x
        mad_pp r4.y, r4.y, c78.x, r2.y
        mad_sat r1.z, r1.z, c3.x, r4.z
        add r4.z, -r4.x, c0.y
        mul r4.z, r3.z, r4.z
        mad_pp r1.z, r4.z, r1.z, r1.z
        mad r3.y, r3.y, c3.z, c3.w
        mul_pp r1.z, r1.z, r3.y
        mad r4.xyz, r4.y, c70, -r4.x
        mad_pp r4.xyz, c71, r1.z, r4
        mul_pp r1.z, r1.w, r3.x
        lrp_pp r5.xyz, r1.z, c76, r4
        mad_pp r1.z, r3.x, r1.z, r3.z
        mul_sat_pp r3.xyz, r1.x, v5
        mad_pp r2.xzw, r2, c89.x, r3.xyyz
        texld_pp r4, v3.zwzw, s2
        mul_pp r3.xyz, r4, c80.y
        mad_pp r0.xyz, r0, r0.w, -c85
        dp3 r4.x, c86, r0
        dp3 r4.y, c87, r0
        mad_pp r0.xy, r4, c4.x, c4.y
        cmp r0.zw, r0.xyxy, c4.z, c4.w
        add r1.xw, -r0.xyzy, c0.y
        cmp r1.xw, r1, c4.z, c4.w
        add r0.zw, r0, r1.xyxw
        cmp_pp r0.zw, -r0, c4.z, c4.w
        mad_pp r0.xy, r0, c81, c81.zwzw
        dsx_pp r1.xw, r0.xyzy
        dsy_pp r4.zw, r0.xyxy
        add_pp r0.z, r0.w, r0.z
        if_ge -r0.z, c3.y
          add_pp r0.zw, r4.xyxy, c1.y
          add r4.xy, -r0.zwzw, c0.y
          cmp r4.xy, r4, c4.z, c4.w
          cmp r6.xy, r0.zwzw, c4.z, c4.w
          add r4.xy, r4, r6
          cmp_pp r4.xy, -r4, c4.z, c4.w
          add_sat_pp r4.x, r4.y, r4.x
          add_pp r4.x, -r4.x, c0.y
          mad_pp r0.zw, r0, c81.xyxy, c81
          texldd_pp r6, r0.zwzw, s0, r1.xwzw, r4.zwzw
          mul_pp r6, r4.x, r6
          mul r7.xyz, r6.w, c84
          texldd_pp r0, r0, s1, r1.xwzw, r4.zwzw
          add r0.yzw, r2.y, c84.xxyz
          mul r0.xyz, r0.x, r0.yzww
          mul_pp r0.xyz, r0, c69.x
          mad_pp r4.xyz, r6, r7, r0
          mov r0.w, c84.w
          mul_sat r0.w, r0.w, c5.x
          mad r0.w, r6.w, -r0.w, c0.y
          mul_pp r3.xyz, r3, r0.w
          dp3_pp r0.w, r2.xzww, c5.yzww
          mad_sat_pp r0.w, r0.w, -c82.x, r2.y
          mul_pp r0.w, r0.w, r0.w
          add r1.xw, -r1.z, c6.xyzy
          mul_pp r0.w, r0.w, r1.x
          mul_pp r0.xyz, r0, r0.w
          mad r0.xyz, r0, r1.w, c0.y
          mul_pp r5.xyz, r5, r0
          mad_pp r2.xzw, r4.xyyz, r0.w, r2
        endif
        add_pp r0.xyz, r2.xzww, r3
        mad_sat_pp r0.w, r1.y, r3.w, -c74.x
        mul_pp r0.w, r1.z, r0.w
        lrp_pp r1.xyz, r0.w, r5, r0
        mul_pp r0.xyz, r1, c88.x
        min_pp r1.xyz, r0, c90
        min_pp r0.xyz, c90, r1
        add r0.w, c67.x, -v1.y
        mul_sat r0.w, r0.w, c67.y
        add r1.xyz, -r0, c68
        mad oC0.xyz, r0.w, r1, r0
        mov oC0.w, c0.y
    
    // approximately 141 instruction slots used (8 texture, 133 arithmetic)
};

PixelShader PS_MainWithStarfield
<
    string CloudBias                                   = "parameter register(72)";
    string CloudColor                                  = "parameter register(69)";
    string CloudFadeOut                                = "parameter register(73)";
    string CloudInscatteringRange                      = "parameter register(77)";
    string CloudShadowStrength                         = "parameter register(76)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(78)";
    string CloudThreshold                              = "parameter register(71)";
    string GalaxySampler                               = "parameter register(1)";
    string HDRExposure                                 = "parameter register(81)";
    string HDRExposureClamp                            = "parameter register(83)";
    string HDRSunExposure                              = "parameter register(82)";
    string HighDetailNoiseSampler                      = "parameter register(3)";
    string PerlinNoiseSampler                          = "parameter register(2)";
    string StarFieldBrightness                         = "parameter register(79)";
    string StarFieldSampler                            = "parameter register(0)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(66)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(80)";
    string SunsetColor                                 = "parameter register(70)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(74)";
    string TopCloudColor                               = "parameter register(75)";
    string gtaSkyDomeFade                              = "parameter register(67)";
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
    //   float CloudInscatteringRange;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float3 HDRSunExposure;
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
    //   float3 gtaSkyDomeFade;
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
    //   gtaSkyDomeFade                              c67      1
    //   gtaWaterColor                               c68      1
    //   CloudColor                                  c69      1
    //   SunsetColor                                 c70      1
    //   CloudThreshold                              c71      1
    //   CloudBias                                   c72      1
    //   CloudFadeOut                                c73      1
    //   TopCloudBiasDetailThresholdHeight           c74      1
    //   TopCloudColor                               c75      1
    //   CloudShadowStrength                         c76      1
    //   CloudInscatteringRange                      c77      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c78      1
    //   StarFieldBrightness                         c79      1
    //   SunSize                                     c80      1
    //   HDRExposure                                 c81      1
    //   HDRSunExposure                              c82      1
    //   HDRExposureClamp                            c83      1
    //   StarFieldSampler                            s0       1
    //   GalaxySampler                               s1       1
    //   PerlinNoiseSampler                          s2       1
    //   HighDetailNoiseSampler                      s3       1
    //
    
        ps_3_0
        def c0, 0.200000003, 0, 0.25, 0.349999994
        def c1, 9.99999975e-006, 1, -11.6163721, 32
        def c2, 0.9375, 0.5, 12.5799999, -0.0625
        def c3, 0.600000024, -2, 3, 4
        def c4, 1.20000005, 0, 0, 0
        dcl_texcoord_pp v0.xy
        dcl_texcoord1_pp v1.xyz
        dcl_texcoord2_pp v2
        dcl_texcoord3_pp v3
        dcl_texcoord4_pp v4.xyz
        dcl_texcoord5_pp v5.xyz
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s3
        texld_pp r0, v3, s0
        mad_pp r0.xyz, r0, c79.x, -c79.z
        texld_pp r1, v3.zwzw, s1
        mul_pp r2.xyz, r1, c79.y
        dp3 r0.w, r2, c4.x
        mad r0.xyz, r0, r0.w, r0
        mad_sat_pp r0.xyz, r1, c79.y, r0
        mov r1.xw, c3
        add_sat r0.w, r1.x, c65.w
        mov r1.yz, c2.xxyw
        mov r2.y, c1.y
        add_sat r2.x, r2.y, -c82.y
        mul r1.x, r2.x, c1.z
        add r3.xyz, c1.x, v1
        nrm_pp r4.xyz, r3
        dp3_pp r3.y, r4, c65
        mad_sat_pp r1.w, r4.y, r1.w, -c73.x
        mul r3.x, r2.x, r3.y
        mad_sat r1.xyz, r3.xyyw, c2.zwyw, r1
        mul r2.x, r1.y, r1.y
        mul r1.y, r1.y, r2.x
        pow r2.x, r1.x, c1.w
        mad r0.w, r1.y, -r0.w, r2.x
        mad r0.w, r1.z, c80.x, r0.w
        mad_sat r1.x, r1.z, c64.y, c64.x
        mul_sat r0.w, r0.w, c2.y
        mul r1.y, r1.x, r1.x
        mad r1.x, r1.x, c3.y, c3.z
        mul r1.x, r1.y, r1.x
        mul r1.x, r1.x, c64.z
        mad_pp r0.w, r0.w, c3.w, r1.x
        mul_pp r1.xyz, r0.w, c66
        add_sat_pp r0.w, -r0.w, c1.y
        mul_pp r0.w, r0.w, c82.x
        mul_sat_pp r2.xzw, r0.w, v5.xyyz
        mul r3.xzw, r1_abs.xyyz, r1_abs.xyyz
        mad_pp r1.xyz, r3.xzww, r3.xzww, r1
        mad_pp r1.xyz, r1, c82.x, r2.xzww
        add_pp r0.xyz, r0, r1
        mad r0.w, r3.y, c0.z, c0.w
        mul_pp r1.x, r3.y, r3.y
        mul r1.yz, c78.z, v2.xxyw
        texld r3, r1.yzzw, s3
        mul r1.y, r3.x, c78.w
        texld_pp r3, v2, s2
        mad_pp r1.y, r1.y, c0.x, r3.x
        mov r2.x, c71.x
        mad r1.y, r2.x, r1.y, -c72.x
        mul_sat_pp r1.y, r1.y, c76.x
        add r1.z, -r1.y, c1.y
        texld_pp r3, v0, s2
        texld_pp r4, v2.zwzw, s3
        add_pp r2.z, r4.x, -c2.y
        mad_pp r2.w, r2.z, c78.w, r3.x
        mad_sat r3.x, r2.z, c0.x, r3.z
        mul_pp r2.z, r2.z, c78.w
        mad_sat_pp r2.x, r2.x, r2.w, -c72.x
        pow r3.y, r2.x, c78.x
        mul_sat r2.x, r2.x, c78.y
        mul_pp r2.w, r3.y, r2.x
        mad r2.x, r3.y, -r2.x, c1.y
        mul r1.z, r1.z, r2.w
        mad_pp r1.z, r1.z, r3.x, r3.x
        mul_pp r0.w, r0.w, r1.z
        mad r1.z, r1.y, -c2.y, r2.x
        max r3.x, r1.z, c0.y
        mul r1.x, r1.x, r3.x
        mad_pp r1.x, r1.x, c77.x, r2.y
        mad r1.xyz, r1.x, c69, -r1.y
        mad_pp r1.xyz, c70, r0.w, r1
        texld_pp r3, v4, s2
        mad_pp r0.w, r2.z, c74.y, r3.y
        mad_sat r0.w, c74.z, r0.w, -c74.x
        mul_pp r0.w, r0.w, v4.z
        mul_pp r0.w, r2.x, r0.w
        mad_pp r2.x, r2.x, r0.w, r2.w
        lrp_pp r2.yzw, r0.w, c75.xxyz, r1.xxyz
        mul_pp r0.w, r1.w, r2.x
        lrp_pp r1.xyz, r0.w, r2.yzww, r0
        mul_pp r0.xyz, r1, c81.x
        min_pp r1.xyz, r0, c83
        min_pp r0.xyz, c83, r1
        add r1.xyz, -r0, c68
        add r0.w, c67.x, -v1.y
        mul_sat r0.w, r0.w, c67.y
        mad oC0.xyz, r0.w, r1, r0
        mov oC0.w, c1.y
    
    // approximately 93 instruction slots used (7 texture, 86 arithmetic)
};

PixelShader PS_MainWithStarfieldWithMoon
<
    string CloudBias                                   = "parameter register(73)";
    string CloudColor                                  = "parameter register(70)";
    string CloudFadeOut                                = "parameter register(74)";
    string CloudInscatteringRange                      = "parameter register(78)";
    string CloudShadowStrength                         = "parameter register(77)";
    string CloudThicknessEdgeSmoothDetailScaleStrength = "parameter register(79)";
    string CloudThreshold                              = "parameter register(72)";
    string GalaxySampler                               = "parameter register(3)";
    string HDRExposure                                 = "parameter register(88)";
    string HDRExposureClamp                            = "parameter register(90)";
    string HDRSunExposure                              = "parameter register(89)";
    string HighDetailNoiseSampler                      = "parameter register(5)";
    string MoonColorConstant                           = "parameter register(84)";
    string MoonGlow                                    = "parameter register(69)";
    string MoonGlowSampler                             = "parameter register(1)";
    string MoonLight                                   = "parameter register(81)";
    string MoonPosition                                = "parameter register(85)";
    string MoonSampler                                 = "parameter register(0)";
    string MoonVisiblity                               = "parameter register(82)";
    string MoonXVector                                 = "parameter register(86)";
    string MoonYVector                                 = "parameter register(87)";
    string PerlinNoiseSampler                          = "parameter register(4)";
    string StarFieldBrightness                         = "parameter register(80)";
    string StarFieldSampler                            = "parameter register(2)";
    string SunCentre                                   = "parameter register(64)";
    string SunColor                                    = "parameter register(66)";
    string SunDirection                                = "parameter register(65)";
    string SunSize                                     = "parameter register(83)";
    string SunsetColor                                 = "parameter register(71)";
    string TopCloudBiasDetailThresholdHeight           = "parameter register(75)";
    string TopCloudColor                               = "parameter register(76)";
    string gtaSkyDomeFade                              = "parameter register(67)";
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
    //   float CloudInscatteringRange;
    //   float CloudShadowStrength;
    //   float4 CloudThicknessEdgeSmoothDetailScaleStrength;
    //   float CloudThreshold;
    //   sampler2D GalaxySampler;
    //   float HDRExposure;
    //   float3 HDRExposureClamp;
    //   float3 HDRSunExposure;
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
    //   float3 gtaSkyDomeFade;
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
    //   gtaSkyDomeFade                              c67      1
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
    //   CloudInscatteringRange                      c78      1
    //   CloudThicknessEdgeSmoothDetailScaleStrength c79      1
    //   StarFieldBrightness                         c80      1
    //   MoonLight                                   c81      1
    //   MoonVisiblity                               c82      1
    //   SunSize                                     c83      1
    //   MoonColorConstant                           c84      1
    //   MoonPosition                                c85      1
    //   MoonXVector                                 c86      1
    //   MoonYVector                                 c87      1
    //   HDRExposure                                 c88      1
    //   HDRSunExposure                              c89      1
    //   HDRExposureClamp                            c90      1
    //   MoonSampler                                 s0       1
    //   MoonGlowSampler                             s1       1
    //   StarFieldSampler                            s2       1
    //   GalaxySampler                               s3       1
    //   PerlinNoiseSampler                          s4       1
    //   HighDetailNoiseSampler                      s5       1
    //
    
        ps_3_0
        def c0, 9.99999975e-006, 1, -11.6163721, 32
        def c1, 0.9375, 0.5, 12.5799999, -0.0625
        def c2, 0.600000024, -2, 3, 4
        def c3, 0.200000003, 0, 0.25, 0.349999994
        def c4, 1.20000005, 0.899999976, 0.5, 64
        def c5, 0.300000012, 0.699999988, 0.170000002, 0
        def c6, 0, 1, 1.39999998, 0
        dcl_texcoord_pp v0.xy
        dcl_texcoord1_pp v1.xyz
        dcl_texcoord2_pp v2
        dcl_texcoord3_pp v3
        dcl_texcoord4_pp v4.xyz
        dcl_texcoord5_pp v5.xyz
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s3
        dcl_2d s4
        dcl_2d s5
        add r0.xyz, c0.x, v1
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul_pp r1.xyz, r0, r0.w
        mov r2.y, c0.y
        add_sat r1.w, r2.y, -c89.y
        dp3_pp r3.y, r1, c65
        mul r3.x, r1.w, r3.y
        mul r4.x, r1.w, c0.z
        mov r4.yz, c1.xxyw
        mad_sat r1.xzw, r3.xyyy, c1.zywy, r4.xyyz
        pow r2.x, r1.x, c0.w
        mul r1.x, r1.z, r1.z
        mul r1.x, r1.z, r1.x
        mov r3.xw, c2
        add_sat r1.z, r3.x, c65.w
        mad r1.x, r1.x, -r1.z, r2.x
        mad r1.x, r1.w, c83.x, r1.x
        mul_sat r1.x, r1.x, c1.y
        mad_sat r1.z, r1.w, c64.y, c64.x
        mul r1.w, r1.z, r1.z
        mad r1.z, r1.z, c2.y, c2.z
        mul r1.z, r1.w, r1.z
        mul r1.z, r1.z, c64.z
        mad_pp r1.x, r1.x, c2.w, r1.z
        add_sat_pp r1.z, -r1.x, c0.y
        mul_pp r2.xzw, r1.x, c66.xyyz
        mul r4.xyz, r2_abs.xzww, r2_abs.xzww
        mad_pp r2.xzw, r4.xyyz, r4.xyyz, r2
        mul_pp r1.x, r1.z, c89.x
        texld_pp r4, v0, s4
        texld_pp r5, v2.zwzw, s5
        add_pp r1.z, r5.x, -c1.y
        mul_pp r1.w, r1.z, c79.w
        mad_pp r3.x, r1.z, c79.w, r4.x
        mov r4.x, c72.x
        mad_sat_pp r3.x, r4.x, r3.x, -c73.x
        pow r4.y, r3.x, c79.x
        mul_sat r3.x, r3.x, c79.y
        mul_pp r3.z, r4.y, r3.x
        texld_pp r5, v2, s4
        mul r5.yz, c79.z, v2.xxyw
        texld r6, r5.yzzw, s5
        mul r4.w, r6.x, c79.w
        mad_pp r4.w, r4.w, c3.x, r5.x
        mad r4.x, r4.x, r4.w, -c73.x
        mul_sat_pp r4.x, r4.x, c77.x
        texld_pp r5, v4, s4
        mad_pp r1.w, r1.w, c75.y, r5.y
        mad_sat r1.w, c75.z, r1.w, -c75.x
        mul_pp r1.w, r1.w, v4.z
        mul_pp r4.w, r3.y, r3.y
        mad r3.x, r4.y, -r3.x, c0.y
        mad r4.y, r4.x, -c1.y, r3.x
        max r5.x, r4.y, c3.y
        mul r4.y, r4.w, r5.x
        mad_pp r4.y, r4.y, c78.x, r2.y
        mad_sat r1.z, r1.z, c3.x, r4.z
        add r4.z, -r4.x, c0.y
        mul r4.z, r3.z, r4.z
        mad_pp r1.z, r4.z, r1.z, r1.z
        mad r3.y, r3.y, c3.z, c3.w
        mul_pp r1.z, r1.z, r3.y
        mad r4.xyz, r4.y, c70, -r4.x
        mad_pp r4.xyz, c71, r1.z, r4
        mul_pp r1.z, r1.w, r3.x
        lrp_pp r5.xyz, r1.z, c76, r4
        mad_pp r1.z, r3.x, r1.z, r3.z
        mul_sat_pp r3.xyz, r1.x, v5
        mad_pp r2.xzw, r2, c89.x, r3.xyyz
        texld_pp r4, v3, s2
        mad_pp r3.xyz, r4, c80.x, -c80.z
        texld_pp r4, v3.zwzw, s3
        mul_pp r6.xyz, r4, c80.y
        dp3 r1.x, r6, c4.x
        mad r3.xyz, r3, r1.x, r3
        mad_sat_pp r3.xyz, r4, c80.y, r3
        mad_pp r0.xyz, r0, r0.w, -c85
        dp3 r4.x, c86, r0
        dp3 r4.y, c87, r0
        mad_pp r0.xy, r4, c4.y, c4.z
        cmp r0.zw, r0.xyxy, c6.x, c6.y
        add r1.xw, -r0.xyzy, c0.y
        cmp r1.xw, r1, c6.x, c6.y
        add r0.zw, r0, r1.xyxw
        cmp_pp r0.zw, -r0, c6.x, c6.y
        mad_pp r0.xy, r0, c81, c81.zwzw
        dsx_pp r1.xw, r0.xyzy
        dsy_pp r4.zw, r0.xyxy
        add_pp r0.z, r0.w, r0.z
        if_ge -r0.z, c3.y
          add_pp r0.zw, r4.xyxy, c1.y
          add r4.xy, -r0.zwzw, c0.y
          cmp r4.xy, r4, c6.x, c6.y
          cmp r6.xy, r0.zwzw, c6.x, c6.y
          add r4.xy, r4, r6
          cmp_pp r4.xy, -r4, c6.x, c6.y
          add_sat_pp r4.x, r4.y, r4.x
          add_pp r4.x, -r4.x, c0.y
          mad_pp r0.zw, r0, c81.xyxy, c81
          texldd_pp r6, r0.zwzw, s0, r1.xwzw, r4.zwzw
          mul_pp r6, r4.x, r6
          mul r7.xyz, r6.w, c84
          texldd_pp r0, r0, s1, r1.xwzw, r4.zwzw
          add r0.yzw, r2.y, c84.xxyz
          mul r0.xyz, r0.x, r0.yzww
          mul_pp r0.xyz, r0, c69.x
          mad_pp r4.xyz, r6, r7, r0
          mov r0.w, c4.w
          mul_sat r0.w, r0.w, c84.w
          mad r0.w, r6.w, -r0.w, c0.y
          mul_pp r3.xyz, r3, r0.w
          dp3_pp r0.w, r2.xzww, c5
          mad_sat_pp r0.w, r0.w, -c82.x, r2.y
          mul_pp r0.w, r0.w, r0.w
          add r1.xw, -r1.z, c6.yyzz
          mul_pp r0.w, r0.w, r1.x
          mul_pp r0.xyz, r0, r0.w
          mad r0.xyz, r0, r1.w, c0.y
          mul_pp r5.xyz, r5, r0
          mad_pp r2.xzw, r4.xyyz, r0.w, r2
        endif
        add_pp r0.xyz, r2.xzww, r3
        mad_sat_pp r0.w, r1.y, r3.w, -c74.x
        mul_pp r0.w, r1.z, r0.w
        lrp_pp r1.xyz, r0.w, r5, r0
        mul_pp r0.xyz, r1, c88.x
        min_pp r1.xyz, r0, c90
        min_pp r0.xyz, c90, r1
        add r0.w, c67.x, -v1.y
        mul_sat r0.w, r0.w, c67.y
        add r1.xyz, -r0, c68
        mad oC0.xyz, r0.w, r1, r0
        mov oC0.w, c0.y
    
    // approximately 146 instruction slots used (9 texture, 137 arithmetic)
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


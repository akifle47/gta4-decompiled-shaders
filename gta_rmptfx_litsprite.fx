//Globals
shared float4 gAllGlobals[64] : AllGlobals;
shared float4x4 gWorld : World;
shared float4x4 gWorldView : WorldView;
shared float4x4 gWorldViewProj : WorldViewProjection;
shared float4x4 gViewInverse : ViewInverse;
shared texture stippletexture;
shared sampler StippleTexture = 
sampler_state
{
    Texture = <stippletexture>;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
    AddressU = WRAP;
    AddressV = WRAP;
};
shared float4 gDepthFxParams : DepthFxParams = float4(1.000000, 1.000000, 1.000000, 1.000000);
shared float4 gDirectionalLight : DirectionalLight;
shared float4 gDirectionalColour : DirectionalColour;
shared float4 gLightPosX : LightPositionX;
shared float4 gLightPosY : LightPositionY;
shared float4 gLightPosZ : LightPositionZ;
shared float4 gLightDirX : LightDirX;
shared float4 gLightDirY : LightDirY;
shared float4 gLightDirZ : LightDirZ;
shared float4 gLightFallOff : LightFallOff;
shared float4 gLightConeScale : LightConeScale;
shared float4 gLightConeOffset : LightConeOffset;
shared float4 gLightColR : LightColR;
shared float4 gLightColG : LightColG;
shared float4 gLightColB : LightColB;
shared float4 gLightPointPosX : LightPointPositionX;
shared float4 gLightPointPosY : LightPointPositionY;
shared float4 gLightPointPosZ : LightPointPositionZ;
shared float4 gLightPointColR : LightPointColR;
shared float4 gLightPointColG : LightPointColG;
shared float4 gLightPointColB : LightPointColB;
shared float4 gLightPointFallOff : LightPointFallOff;
shared float4 gLightDir2X : LightDir2X;
shared float4 gLightDir2Y : LightDir2Y;
shared float4 gLightDir2Z : LightDir2Z;
shared float4 gLightConeScale2 : LightConeScale2;
shared float4 gLightConeOffset2 : LightConeOffset2;
shared float4 gLightAmbient0 : LightAmbientColor0<string UIWidget = "Ambient Light Color 0"; string Space = "material";> = float4(0.000000, 0.000000, 0.000000, 1.000000);
shared float4 gLightAmbient1 : LightAmbientColor1<string UIWidget = "Ambient Light Color 1"; string Space = "material";> = float4(0.000000, 0.000000, 0.000000, 1.000000);
shared float4 globalScalars : globalScalars = float4(1.000000, 1.000000, 1.000000, 1.000000);
shared float4 globalScalars2 : globalScalars2 = float4(1.000000, 1.000000, 1.000000, 1.000000);
shared float4 gAspectRatio : gAspectRatio = float4(1.000000, 1.000000, 1.000000, 1.000000);
shared float4 globalScreenSize : globalScreenSize = float4(1.000000, 1.000000, 1.000000, 1.000000);
shared float4 globalFogParams : globalFogParams = float4(1600.000000, 9000000.000000, 0.010000, 1.000000);
shared float4 globalFogColor : globalFogColor = float4(1.000000, 1.000000, 1.000000, 1.000000);
shared float4 globalFogColorN : globalFogColorN = float4(1.000000, 1.000000, 1.000000, 1.000000);
shared float4 gDayNightEffects : globalDayNightEffects = float4(1.000000, 0.000000, 1.000000, 0.000000);
shared float gInvColorExpBias : ColorExpBias = 1.000000;
shared float4 colorize : Colorize = float4(1.000000, 1.000000, 1.000000, 1.000000);
shared float4 stencil : Stencil = float4(0.000000, 255.000000, 0.000000, 0.000000);
shared float4 gFacetCentre : FacetCentre;
shared float4 gShadowCommonParam0123 : ShadowCommonParam0123;
shared float4 gShadowParam14151617 : ShadowParam14151617;
shared float4 gShadowParam18192021 : ShadowParam18192021;
shared float4 gShadowParam0123 : ShadowParam0123;
shared float4 gShadowParam4567 : ShadowParam4567;
shared float4 gShadowParam891113 : ShadowParam891113;
shared float4x4 gShadowMatrix : ShadowMatrix;
shared texture ShadowZTextureDir;
shared sampler gShadowZSamplerDir = 
sampler_state
{
    Texture = <ShadowZTextureDir>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MipFilter = POINT;
    MinFilter = POINT;
    MagFilter = POINT;
};
shared texture ShadowZTextureDirVS;
shared sampler gShadowZSamplerDirVS = 
sampler_state
{
    Texture = <ShadowZTextureDirVS>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MipFilter = POINT;
    MinFilter = POINT;
    MagFilter = POINT;
};
shared texture ShadowZTextureCache;
shared sampler gShadowZSamplerCache = 
sampler_state
{
    Texture = <ShadowZTextureCache>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MipFilter = POINT;
    MinFilter = POINT;
    MagFilter = POINT;
};
shared texture ShadowTextureLUT;
shared sampler gShadowSamplerLUT = 
sampler_state
{
    Texture = <ShadowTextureLUT>;
    AddressU = WRAP;
    AddressV = WRAP;
    MipFilter = POINT;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
};
shared float4 NearFarPlane : NearFarPlane;
shared float4 gInvScreenSize : InvScreenSize;
shared texture DepthMap;
shared sampler DepthMapTexSampler = 
sampler_state
{
    Texture = <DepthMap>;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = NONE;
    AddressU = CLAMP;
    AddressV = CLAMP;
};

//Locals
float shadowmap_res : ShadowMapResolution = 1280.000000;
float2 facetMask[4] : facetMask = 
{
    float2(-1.000000, 0.000000), 
    float2(1.000000, 0.000000), 
    float2(0.000000, -1.000000), 
    float2(0.000000, 1.000000)
};
float gSoftness : gSoftness<string UIName = "Softness Fade : Controls how much soft particles fade out as objects become close to them ;"; float UIMin = 0.000000; float UIMax = 1000.000000; float UIStep = 0.010000;> = 2.000000;
float HybridAdd : HybridAdd = 1.000000;
texture DiffuseTex2;
sampler DiffuseTexSampler<string UIName = "Texture Map";> = 
sampler_state
{
    Texture = <DiffuseTex2>;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    MipFilter = LINEAR;
    AddressU = CLAMP;
    AddressV = CLAMP;
};
float HybridAddRatio : HybridAddRatio<string UIName = "Hybrid Add Ratio"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.010000; string UIHint = "Keyframeable";> = 0.000000;
float HDRIntensityMultiplier : HDRIntensityMultiplier<string UIName = "HDR Intensity Multiplier"; float UIMin = 0.000000; float UIMax = 255.000000; float UIStep = 0.010000; string UIHint = "Keyframeable";> = 1.000000;
float3 LuminanceConstants : LuminanceConstants = float3(0.212500, 0.715400, 0.072100);
float gBiasToCamera : BiasToCamera<string UIName = "Wrap Scale : Controls how strong sun light hits particle ( 0 - no direct light , 1 - all direct light)"; float UIMin = -1000.000000; float UIMax = 1000.000000; float UIStep = 0.010000;> = 0.000000;
float gWrapScale : WrapScale<string UIName = "Wrap Scale : Controls how strong sun light hits particle ( 0 - no direct light , 1 - all direct light)"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = 1.000000;
float gWrapBias : WrapBias<string UIName = "Wrap Bias : Controls how sun light spreads over surface ( 0 - no extra spread, 1- spreads all over surface) "; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.010000;> = 0.000000;
float gDiffuse : Diffuse<string UIName = "Diffuse : Controls the amount of lighting on surface, color also controls this ( 0 - no light, 1- light)"; float UIMin = 0.000000; float UIMax = 2.000000; float UIStep = 0.010000;> = 1.000000;
float gExtraLights : ExtraLights<string UIName = "ExtraLights : Controls the amount of lighting applied from the additional 4 lights in gta ( 0 - no light, 4- light)"; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.010000;> = 1.000000;
float gAmbientAmount : AmbientAmount<string UIName = "Ambient Scale : Controls how much double ambient lighting  to alpy to surface"; float UIMin = 0.000000; float UIMax = 2.000000; float UIStep = 0.010000;> = 1.000000;
float gSuperAlpha : SuperAlpha<string UIName = "Super Alpha : Boosts the alpha amount by the given value ( 1 - normal alpha,  2 - super alpha) "; float UIMin = 0.000000; float UIMax = 4.000000; float UIStep = 0.010000;> = 2.000000;
float gNormalArc : NormalArc<string UIName = "Normal Arc : Determines how much to bend normals outwards for vertex lighting  ( 0 - bend completely outwards, 4 bend nearly ompletely inwards) "; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = 1.000000;
float gScaleFade : gScaleFade<string UIName = "Near Scale : Amount to scale down particles as the camera gets near 1.0 means same as alpha fades down, 2.0 means twice as slow as alpha fades"; float UIMin = 0.000000; float UIMax = 1000.000000; float UIStep = 0.010000;> = 2.000000;
float gUseShadows : UseShadows<string UIName = "Percentage of shadows to apply to directional light"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = 1.000000;
float gAmbientShadow : AmbientShadows<string UIName = "Percentage of shadows to apply to ambient term"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = 1.000000;
float gLightIntensityClamp : LightIntensityClamp<string UIName = "Clamp the max value a dotproduct can be"; float UIMin = 0.000000; float UIMax = 1.000000; float UIStep = 0.010000;> = 0.700000;

//Vertex shaders
VertexShader VS_TransformVertexLitVS
<
    string NearFarPlane         = "parameter register(128)";
    string gAmbientAmount       = "parameter register(68)";
    string gAspectRatio         = "parameter register(47)";
    string gBiasToCamera        = "parameter register(64)";
    string gDepthFxParams       = "parameter register(16)";
    string gDiffuse             = "parameter register(67)";
    string gDirectionalColour   = "parameter register(18)";
    string gDirectionalLight    = "parameter register(17)";
    string gFacetCentre         = "parameter register(54)";
    string gLightAmbient0       = "parameter register(37)";
    string gLightAmbient1       = "parameter register(38)";
    string gLightColB           = "parameter register(31)";
    string gLightColG           = "parameter register(30)";
    string gLightColR           = "parameter register(29)";
    string gLightConeOffset     = "parameter register(27)";
    string gLightConeScale      = "parameter register(26)";
    string gLightDirX           = "parameter register(22)";
    string gLightDirY           = "parameter register(23)";
    string gLightDirZ           = "parameter register(24)";
    string gLightFallOff        = "parameter register(25)";
    string gLightPosX           = "parameter register(19)";
    string gLightPosY           = "parameter register(20)";
    string gLightPosZ           = "parameter register(21)";
    string gNormalArc           = "parameter register(70)";
    string gScaleFade           = "parameter register(71)";
    string gShadowMatrix        = "parameter register(60)";
    string gShadowParam0123     = "parameter register(57)";
    string gShadowParam14151617 = "parameter register(56)";
    string gShadowParam4567     = "parameter register(58)";
    string gShadowParam891113   = "parameter register(59)";
    string gShadowZSamplerDirVS = "parameter register(3)";
    string gSuperAlpha          = "parameter register(69)";
    string gUseShadows          = "parameter register(72)";
    string gViewInverse         = "parameter register(12)";
    string gWorldView           = "parameter register(4)";
    string gWorldViewProj       = "parameter register(8)";
    string gWrapBias            = "parameter register(66)";
    string gWrapScale           = "parameter register(65)";
    string globalFogColor       = "parameter register(42)";
    string globalFogColorN      = "parameter register(43)";
    string globalFogParams      = "parameter register(41)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 NearFarPlane;
    //   float gAmbientAmount;
    //   float4 gAspectRatio;
    //   float gBiasToCamera;
    //   float4 gDepthFxParams;
    //   float gDiffuse;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float4 gFacetCentre;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   float4 gLightColB;
    //   float4 gLightColG;
    //   float4 gLightColR;
    //   float4 gLightConeOffset;
    //   float4 gLightConeScale;
    //   float4 gLightDirX;
    //   float4 gLightDirY;
    //   float4 gLightDirZ;
    //   float4 gLightFallOff;
    //   float4 gLightPosX;
    //   float4 gLightPosY;
    //   float4 gLightPosZ;
    //   float gNormalArc;
    //   float gScaleFade;
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam4567;
    //   float4 gShadowParam891113;
    //   sampler2D gShadowZSamplerDirVS;
    //   float gSuperAlpha;
    //   float gUseShadows;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldView;
    //   row_major float4x4 gWorldViewProj;
    //   float gWrapBias;
    //   float gWrapScale;
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //
    //
    // Registers:
    //
    //   Name                 Reg   Size
    //   -------------------- ----- ----
    //   gWorldView           c4       4
    //   gWorldViewProj       c8       4
    //   gViewInverse         c12      4
    //   gDepthFxParams       c16      1
    //   gDirectionalLight    c17      1
    //   gDirectionalColour   c18      1
    //   gLightPosX           c19      1
    //   gLightPosY           c20      1
    //   gLightPosZ           c21      1
    //   gLightDirX           c22      1
    //   gLightDirY           c23      1
    //   gLightDirZ           c24      1
    //   gLightFallOff        c25      1
    //   gLightConeScale      c26      1
    //   gLightConeOffset     c27      1
    //   gLightColR           c29      1
    //   gLightColG           c30      1
    //   gLightColB           c31      1
    //   gLightAmbient0       c37      1
    //   gLightAmbient1       c38      1
    //   globalFogParams      c41      1
    //   globalFogColor       c42      1
    //   globalFogColorN      c43      1
    //   gAspectRatio         c47      1
    //   gFacetCentre         c54      1
    //   gShadowParam14151617 c56      1
    //   gShadowParam0123     c57      1
    //   gShadowParam4567     c58      1
    //   gShadowParam891113   c59      1
    //   gShadowMatrix        c60      4
    //   gBiasToCamera        c64      1
    //   gWrapScale           c65      1
    //   gWrapBias            c66      1
    //   gDiffuse             c67      1
    //   gAmbientAmount       c68      1
    //   gSuperAlpha          c69      1
    //   gNormalArc           c70      1
    //   gScaleFade           c71      1
    //   gUseShadows          c72      1
    //   NearFarPlane         c128     1
    //   gShadowZSamplerDirVS s3       1
    //
    
        vs_3_0
        def c0, 0.100000001, 9.99999997e-007, 0.159154937, 0.5
        def c1, 6.28318548, -3.14159274, 0, 9.99999975e-006
        def c2, -1, 0, 1, 1.11111116
        def c3, 0.111111112, 0, 0, 0
        def c12, 0.5, 0, -0.5, 0.25
        dcl_position v0
        dcl_normal v1
        dcl_color v2
        dcl_texcoord v3
        dcl_texcoord1 v4
        dcl_texcoord2 v5
        dcl_texcoord3 v6
        dcl_2d s3
        dcl_position o0
        dcl_color o1
        dcl_texcoord o2
        dcl_texcoord1 o3
        dcl_texcoord2 o4
        dcl_texcoord3 o5
        dcl_texcoord4 o6
        mov r0.x, c0.x
        mul r0.x, r0.x, c64.x
        lrp r1.xyz, r0.x, c15, v0
        mul r0, r1.y, c9
        mad r0, r1.x, c8, r0
        mad r0, r1.z, c10, r0
        add r0, r0, c11
        rcp r1.w, c71.x
        add r2.x, r0.w, -c128.x
        mul_sat r1.w, r1.w, r2.x
        sge r2.x, c0.y, v2.w
        mad r1.w, r2.x, -r1.w, r1.w
        mul r2, r1.w, v1.xyxy
        mul r1.w, r1.w, v2.w
        mad r3.x, v1.z, c0.z, c0.w
        frc r3.x, r3.x
        mad r3.x, r3.x, c1.x, c1.y
        sincos r4.xy, r3.x
        mul r3.xyz, r2.yzww, r4.yyxw
        mad r4.x, r2.x, r4.x, -r3.x
        add r4.y, r3.z, r3.y
        mov r4.zw, c1.z
        mul r2.xy, r4, c47
        mad r0, r4, c47, r0
        mul r3.xyz, r1.y, c5
        mad r3.xyz, r1.x, c4, r3
        mad r3.xyz, r1.z, c6, r3
        add r3.xyz, r3, c7
        add r5.xyz, -r3, c1.w
        nrm r6.xyz, r5
        mul r5.xyz, r6.zxyw, c2.xyyw
        mad r5.xyz, r6.yzxw, c2.yyxw, -r5
        add r5.xyz, r5, c1.w
        nrm r7.xyz, r5
        mul r5.xyz, r6.zxyw, r7.yzxw
        mad r5.xyz, r6.yzxw, r7.zxyw, -r5
        mul r2.xy, r2, r2
        add r2.x, r2.y, r2.x
        rsq r2.x, r2.x
        rcp r2.x, r2.x
        slt r2.x, -r2.x, r2.x
        mov r3.w, c1.w
        mad r4.xy, r4, c47, r3.w
        mul r4.zw, r4.xyxy, r4.xyxy
        add r2.y, r4.w, r4.z
        rsq r2.y, r2.y
        mul r4.xy, r4, r2.y
        mul r2.xy, r2.x, r4
        mul r4.xyz, r5, r2.y
        mad r4.xyz, r7, r2.x, r4
        mad r4.xyz, r6, c70.x, r4
        dp3 r2.x, r4, r4
        rsq r2.x, r2.x
        rcp r2.x, r2.x
        slt r2.x, -r2.x, r2.x
        add r5.xyz, r4, c1.w
        dp3 r2.y, r5, r5
        rsq r2.y, r2.y
        lrp r5.xyz, r2.y, c1.w, -r4
        mad r4.xyz, r2.x, r5, r4
        add r5, -r3.x, c19
        add r6, -r3.y, c20
        add r3, -r3.z, c21
        mul r7, r5, r5
        mad r7, r6, r6, r7
        mad r7, r3, r3, r7
        add r8, r7, c1.w
        rsq r9.x, r8.x
        rsq r9.y, r8.y
        rsq r9.z, r8.z
        rsq r9.w, r8.w
        mov r8.xz, c2
        mad r7, r7, -c25, r8.z
        max r7, r7, c1.z
        mul r7, r7, r7
        mad r7, r7, r7, -c0.x
        max r7, r7, c1.z
        mul r7, r9, r7
        mul r7, r7, c2.w
        min r7, r7, c2.z
        mul r10, r5, -c22
        mad r10, r6, -c23, r10
        mad r10, r3, -c24, r10
        mul r10, r9, r10
        mov r11, c26
        mad_sat r10, r10, r11, c27
        mul r7, r7, r10
        mul r7, r9, r7
        mul r5, r5, r7
        mul r6, r6, r7
        mul r3, r3, r7
        mul r2.x, r7.x, c66.x
        add r2.y, r8.x, c72.x
        if_ge -r2_abs.y, r2_abs.y
          add r2.y, r2.w, r2.z
          mul r7.xyz, r1.y, c61.xyww
          mad r7.xyz, r1.x, c60.xyww, r7
          mad r7.xyz, r1.z, c62.xyww, r7
          add r7.xyz, r7, c63.xyww
          dp3 r2.z, c14, r1
          sge r9.yzw, -r2.z, c54.xxyz
          mov r9.x, c2.z
          dp4 r10.x, r9, c57
          dp4 r10.y, r9, c58
          dp4 r11.x, r9, c59
          dp4 r11.y, r9, c56
          mad r9.xy, r7, r10, r11
          mov r9.zw, c1.z
          texldl r9, r9, s3
          add r2.z, -r7.z, r9.x
          slt r2.z, r2.z, c1.z
          mad r7.xyz, r2.y, c12.xxyw, r1
          mul r8.yzw, r7.y, c61.xxyw
          mad r8.yzw, r7.x, c60.xxyw, r8
          mad r8.yzw, r7.z, c62.xxyw, r8
          add r8.yzw, r8, c63.xxyw
          dp3 r2.w, c14, r7
          sge r7.yzw, -r2.w, c54.xxyz
          mov r7.x, c2.z
          dp4 r9.x, r7, c57
          dp4 r9.y, r7, c58
          dp4 r10.x, r7, c59
          dp4 r10.y, r7, c56
          mad r7.xy, r8.yzzw, r9, r10
          mov r7.zw, c1.z
          texldl r7, r7, s3
          add r2.w, -r8.w, r7.x
          slt r2.w, r2.w, c1.z
          add r2.z, r2.z, r2.w
          mad r7.xyz, r2.y, c12.xzyw, r1
          mul r8.yzw, r7.y, c61.xxyw
          mad r8.yzw, r7.x, c60.xxyw, r8
          mad r8.yzw, r7.z, c62.xxyw, r8
          add r8.yzw, r8, c63.xxyw
          dp3 r2.w, c14, r7
          sge r7.yzw, -r2.w, c54.xxyz
          mov r7.x, c2.z
          dp4 r9.x, r7, c57
          dp4 r9.y, r7, c58
          dp4 r10.x, r7, c59
          dp4 r10.y, r7, c56
          mad r7.xy, r8.yzzw, r9, r10
          mov r7.zw, c1.z
          texldl r7, r7, s3
          add r2.w, -r8.w, r7.x
          slt r2.w, r2.w, c1.z
          add r2.z, r2.z, r2.w
          mad r7.xyz, r2.y, c12.zxyw, r1
          mul r8.yzw, r7.y, c61.xxyw
          mad r8.yzw, r7.x, c60.xxyw, r8
          mad r8.yzw, r7.z, c62.xxyw, r8
          add r8.yzw, r8, c63.xxyw
          dp3 r2.w, c14, r7
          sge r7.yzw, -r2.w, c54.xxyz
          mov r7.x, c2.z
          dp4 r9.x, r7, c57
          dp4 r9.y, r7, c58
          dp4 r10.x, r7, c59
          dp4 r10.y, r7, c56
          mad r7.xy, r8.yzzw, r9, r10
          mov r7.zw, c1.z
          texldl r7, r7, s3
          add r2.w, -r8.w, r7.x
          slt r2.w, r2.w, c1.z
          add r2.z, r2.z, r2.w
          mad r7.xyz, r2.y, c12.zzyw, r1
          mul r8.yzw, r7.y, c61.xxyw
          mad r8.yzw, r7.x, c60.xxyw, r8
          mad r8.yzw, r7.z, c62.xxyw, r8
          add r8.yzw, r8, c63.xxyw
          dp3 r2.w, c14, r7
          sge r7.yzw, -r2.w, c54.xxyz
          mov r7.x, c2.z
          dp4 r9.x, r7, c57
          dp4 r9.y, r7, c58
          dp4 r10.x, r7, c59
          dp4 r10.y, r7, c56
          mad r7.xy, r8.yzzw, r9, r10
          mov r7.zw, c1.z
          texldl r7, r7, s3
          add r2.w, -r8.w, r7.x
          slt r2.w, r2.w, c1.z
          add r2.z, r2.z, r2.w
          mad r7.xyz, r2.y, c12.xxww, r1
          mul r8.yzw, r7.y, c61.xxyw
          mad r8.yzw, r7.x, c60.xxyw, r8
          mad r8.yzw, r7.z, c62.xxyw, r8
          add r8.yzw, r8, c63.xxyw
          dp3 r2.w, c14, r7
          sge r7.yzw, -r2.w, c54.xxyz
          mov r7.x, c2.z
          dp4 r9.x, r7, c57
          dp4 r9.y, r7, c58
          dp4 r10.x, r7, c59
          dp4 r10.y, r7, c56
          mad r7.xy, r8.yzzw, r9, r10
          mov r7.zw, c1.z
          texldl r7, r7, s3
          add r2.w, -r8.w, r7.x
          slt r2.w, r2.w, c1.z
          add r2.z, r2.z, r2.w
          mad r7.xyz, r2.y, c12.xzww, r1
          mul r8.yzw, r7.y, c61.xxyw
          mad r8.yzw, r7.x, c60.xxyw, r8
          mad r8.yzw, r7.z, c62.xxyw, r8
          add r8.yzw, r8, c63.xxyw
          dp3 r2.w, c14, r7
          sge r7.yzw, -r2.w, c54.xxyz
          mov r7.x, c2.z
          dp4 r9.x, r7, c57
          dp4 r9.y, r7, c58
          dp4 r10.x, r7, c59
          dp4 r10.y, r7, c56
          mad r7.xy, r8.yzzw, r9, r10
          mov r7.zw, c1.z
          texldl r7, r7, s3
          add r2.w, -r8.w, r7.x
          slt r2.w, r2.w, c1.z
          add r2.z, r2.z, r2.w
          mad r7.xyz, r2.y, c12.zxww, r1
          mul r8.yzw, r7.y, c61.xxyw
          mad r8.yzw, r7.x, c60.xxyw, r8
          mad r8.yzw, r7.z, c62.xxyw, r8
          add r8.yzw, r8, c63.xxyw
          dp3 r2.w, c14, r7
          sge r7.yzw, -r2.w, c54.xxyz
          mov r7.x, c2.z
          dp4 r9.x, r7, c57
          dp4 r9.y, r7, c58
          dp4 r10.x, r7, c59
          dp4 r10.y, r7, c56
          mad r7.xy, r8.yzzw, r9, r10
          mov r7.zw, c1.z
          texldl r7, r7, s3
          add r2.w, -r8.w, r7.x
          slt r2.w, r2.w, c1.z
          add r2.z, r2.z, r2.w
          mad r1.xyz, r2.y, c12.zzww, r1
          mul r7.xyz, r1.y, c61.xyww
          mad r7.xyz, r1.x, c60.xyww, r7
          mad r7.xyz, r1.z, c62.xyww, r7
          add r7.xyz, r7, c63.xyww
          dp3 r1.x, c14, r1
          sge r9.yzw, -r1.x, c54.xxyz
          mov r9.x, c2.z
          dp4 r1.x, r9, c57
          dp4 r1.y, r9, c58
          dp4 r10.x, r9, c59
          dp4 r10.y, r9, c56
          mad r9.xy, r7, r1, r10
          mov r9.zw, c1.z
          texldl r9, r9, s3
          add r1.x, -r7.z, r9.x
          slt r1.x, r1.x, c1.z
          add r1.x, r2.z, r1.x
          mul r1.x, r1.x, c3.x
        else
          mov r1.x, c2.z
        endif
        dp3 r1.y, r4, -c17
        mad_sat r1.y, r1.y, c65.x, r2.x
        mul r2.xyz, r1.y, c18
        mul r2.xyz, r2, c18.w
        mul r5, r4.x, r5
        mad r5, r4.y, r6, r5
        mad_sat r3, r4.z, r3, r5
        dp4 r5.x, c29, r3
        dp4 r5.y, c30, r3
        dp4 r5.z, c31, r3
        mad r1.xyz, r2, r1.x, r5
        dp3 r2.x, r4, c6
        mad_sat r2.x, r2.x, c12.z, c12.x
        mov r3.xyz, c38
        mad r2.xyz, r3, r2.x, c37
        mad r1.xyz, r2, c68.x, r1
        mul r1.xyz, r1, c67.x
        mul o1.xyz, r1, v2
        mul_sat o1.w, r1.w, c69.x
        add r1.x, -r0.w, c16.w
        add r1.y, -c16.z, c16.w
        rcp r1.y, r1.y
        mul_sat r1.x, r1.x, r1.y
        add r1.x, -r1.x, c2.z
        add r1.yz, r8.x, c16.xxyw
        mad o3.zw, r1.x, r1.xyyz, c2.z
        rcp r1.x, c41.x
        mul_sat r1.x, r0.w, r1.x
        add r1.y, r0.w, -c41.x
        add r1.z, -c41.x, c41.y
        rcp r1.z, r1.z
        mul_sat r1.y, r1.y, r1.z
        lrp r2.x, c41.w, r1.x, r1.y
        add o5.w, r2.x, c41.z
        mov r2.xyz, c43
        add r1.xzw, -r2.xyyz, c42.xyyz
        mad o5.xyz, r1.y, r1.xzww, c43
        mov o0, r0
        mov o2, v3
        mov o3.xy, v4
        mul o4, c2.zyyy, v5.z
        mov o6, v6
    
    // approximately 323 instruction slots used (18 texture, 305 arithmetic)
};

VertexShader VS_TransformLitVS
<
    string NearFarPlane         = "parameter register(128)";
    string gAmbientAmount       = "parameter register(69)";
    string gAmbientShadow       = "parameter register(74)";
    string gAspectRatio         = "parameter register(47)";
    string gBiasToCamera        = "parameter register(64)";
    string gDepthFxParams       = "parameter register(16)";
    string gDiffuse             = "parameter register(67)";
    string gDirectionalColour   = "parameter register(18)";
    string gDirectionalLight    = "parameter register(17)";
    string gExtraLights         = "parameter register(68)";
    string gFacetCentre         = "parameter register(54)";
    string gLightAmbient0       = "parameter register(37)";
    string gLightAmbient1       = "parameter register(38)";
    string gLightColB           = "parameter register(31)";
    string gLightColG           = "parameter register(30)";
    string gLightColR           = "parameter register(29)";
    string gLightConeOffset     = "parameter register(27)";
    string gLightConeScale      = "parameter register(26)";
    string gLightDirX           = "parameter register(22)";
    string gLightDirY           = "parameter register(23)";
    string gLightDirZ           = "parameter register(24)";
    string gLightFallOff        = "parameter register(25)";
    string gLightIntensityClamp = "parameter register(75)";
    string gLightPosX           = "parameter register(19)";
    string gLightPosY           = "parameter register(20)";
    string gLightPosZ           = "parameter register(21)";
    string gNormalArc           = "parameter register(71)";
    string gScaleFade           = "parameter register(72)";
    string gShadowMatrix        = "parameter register(60)";
    string gShadowParam0123     = "parameter register(57)";
    string gShadowParam14151617 = "parameter register(56)";
    string gShadowParam4567     = "parameter register(58)";
    string gShadowParam891113   = "parameter register(59)";
    string gShadowZSamplerDirVS = "parameter register(3)";
    string gSuperAlpha          = "parameter register(70)";
    string gUseShadows          = "parameter register(73)";
    string gViewInverse         = "parameter register(12)";
    string gWorldView           = "parameter register(4)";
    string gWorldViewProj       = "parameter register(8)";
    string gWrapBias            = "parameter register(66)";
    string gWrapScale           = "parameter register(65)";
    string globalFogColor       = "parameter register(42)";
    string globalFogColorN      = "parameter register(43)";
    string globalFogParams      = "parameter register(41)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 NearFarPlane;
    //   float gAmbientAmount;
    //   float gAmbientShadow;
    //   float4 gAspectRatio;
    //   float gBiasToCamera;
    //   float4 gDepthFxParams;
    //   float gDiffuse;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float gExtraLights;
    //   float4 gFacetCentre;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   float4 gLightColB;
    //   float4 gLightColG;
    //   float4 gLightColR;
    //   float4 gLightConeOffset;
    //   float4 gLightConeScale;
    //   float4 gLightDirX;
    //   float4 gLightDirY;
    //   float4 gLightDirZ;
    //   float4 gLightFallOff;
    //   float gLightIntensityClamp;
    //   float4 gLightPosX;
    //   float4 gLightPosY;
    //   float4 gLightPosZ;
    //   float gNormalArc;
    //   float gScaleFade;
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam4567;
    //   float4 gShadowParam891113;
    //   sampler2D gShadowZSamplerDirVS;
    //   float gSuperAlpha;
    //   float gUseShadows;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldView;
    //   row_major float4x4 gWorldViewProj;
    //   float gWrapBias;
    //   float gWrapScale;
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //
    //
    // Registers:
    //
    //   Name                 Reg   Size
    //   -------------------- ----- ----
    //   gWorldView           c4       4
    //   gWorldViewProj       c8       4
    //   gViewInverse         c12      4
    //   gDepthFxParams       c16      1
    //   gDirectionalLight    c17      1
    //   gDirectionalColour   c18      1
    //   gLightPosX           c19      1
    //   gLightPosY           c20      1
    //   gLightPosZ           c21      1
    //   gLightDirX           c22      1
    //   gLightDirY           c23      1
    //   gLightDirZ           c24      1
    //   gLightFallOff        c25      1
    //   gLightConeScale      c26      1
    //   gLightConeOffset     c27      1
    //   gLightColR           c29      1
    //   gLightColG           c30      1
    //   gLightColB           c31      1
    //   gLightAmbient0       c37      1
    //   gLightAmbient1       c38      1
    //   globalFogParams      c41      1
    //   globalFogColor       c42      1
    //   globalFogColorN      c43      1
    //   gAspectRatio         c47      1
    //   gFacetCentre         c54      1
    //   gShadowParam14151617 c56      1
    //   gShadowParam0123     c57      1
    //   gShadowParam4567     c58      1
    //   gShadowParam891113   c59      1
    //   gShadowMatrix        c60      4
    //   gBiasToCamera        c64      1
    //   gWrapScale           c65      1
    //   gWrapBias            c66      1
    //   gDiffuse             c67      1
    //   gExtraLights         c68      1
    //   gAmbientAmount       c69      1
    //   gSuperAlpha          c70      1
    //   gNormalArc           c71      1
    //   gScaleFade           c72      1
    //   gUseShadows          c73      1
    //   gAmbientShadow       c74      1
    //   gLightIntensityClamp c75      1
    //   NearFarPlane         c128     1
    //   gShadowZSamplerDirVS s3       1
    //
    
        vs_3_0
        def c0, 0.100000001, 9.99999997e-007, 0.159154937, 0.5
        def c1, 6.28318548, -3.14159274, 0, 9.99999975e-006
        def c2, 0.111111112, -1, 1.11111116, 0
        def c3, 1, 0.5, 0, -0.5
        def c12, 0.5, 0.25, -0.5, 0.375
        dcl_position v0
        dcl_normal v1
        dcl_color v2
        dcl_texcoord v3
        dcl_texcoord1 v4
        dcl_texcoord2 v5
        dcl_texcoord3 v6
        dcl_2d s3
        dcl_position o0
        dcl_color o1
        dcl_texcoord o2
        dcl_texcoord1 o3
        dcl_texcoord2 o4
        dcl_texcoord3 o5
        dcl_texcoord4 o6
        mov r0.zw, c1.z
        mov r1.x, c0.x
        mul r1.x, r1.x, c64.x
        lrp r2.xyz, r1.x, c15, v0
        mul r1.xyz, r2.y, c61.xyww
        mad r1.xyz, r2.x, c60.xyww, r1
        mad r1.xyz, r2.z, c62.xyww, r1
        add r1.xyz, r1, c63.xyww
        mov r3.x, c3.x
        dp3 r1.w, c14, r2
        sge r3.yzw, -r1.w, c54.xxyz
        dp4 r4.x, r3, c57
        dp4 r4.y, r3, c58
        dp4 r5.x, r3, c59
        dp4 r5.y, r3, c56
        mad r0.xy, r1, r4, r5
        texldl r0, r0, s3
        add r0.x, -r1.z, r0.x
        slt r0.x, r0.x, c1.z
        mov r1.zw, c1.z
        sge r0.y, c0.y, v2.w
        rcp r0.z, c72.x
        mul r3, r2.y, c9
        mad r3, r2.x, c8, r3
        mad r3, r2.z, c10, r3
        add r3, r3, c11
        add r0.w, r3.w, -c128.x
        mul_sat r0.z, r0.z, r0.w
        mad r0.y, r0.y, -r0.z, r0.z
        mul r4, r0.y, v1.xyxy
        mul r0.y, r0.y, v2.w
        mul_sat o1.w, r0.y, c70.x
        add r0.y, r4.w, r4.z
        mad r5.xyz, r0.y, c3.yyzw, r2
        mul r6.xyz, r5.y, c61.xyww
        mad r6.xyz, r5.x, c60.xyww, r6
        mad r6.xyz, r5.z, c62.xyww, r6
        dp3 r0.z, c14, r5
        sge r5.yzw, -r0.z, c54.xxyz
        add r6.xyz, r6, c63.xyww
        mov r5.x, c3.x
        dp4 r7.x, r5, c57
        dp4 r7.y, r5, c58
        dp4 r8.x, r5, c59
        dp4 r8.y, r5, c56
        mad r1.xy, r6, r7, r8
        texldl r1, r1, s3
        add r0.z, -r6.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mov r1.zw, c1.z
        mad r5.xyz, r0.y, c3.ywzw, r2
        mul r6.xyz, r5.y, c61.xyww
        mad r6.xyz, r5.x, c60.xyww, r6
        mad r6.xyz, r5.z, c62.xyww, r6
        dp3 r0.z, c14, r5
        sge r5.yzw, -r0.z, c54.xxyz
        add r6.xyz, r6, c63.xyww
        mov r5.x, c3.x
        dp4 r7.x, r5, c57
        dp4 r7.y, r5, c58
        dp4 r8.x, r5, c59
        dp4 r8.y, r5, c56
        mad r1.xy, r6, r7, r8
        texldl r1, r1, s3
        add r0.z, -r6.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mov r1.zw, c1.z
        mad r5.xyz, r0.y, c3.wyzw, r2
        mul r6.xyz, r5.y, c61.xyww
        mad r6.xyz, r5.x, c60.xyww, r6
        mad r6.xyz, r5.z, c62.xyww, r6
        dp3 r0.z, c14, r5
        sge r5.yzw, -r0.z, c54.xxyz
        add r6.xyz, r6, c63.xyww
        mov r5.x, c3.x
        dp4 r7.x, r5, c57
        dp4 r7.y, r5, c58
        dp4 r8.x, r5, c59
        dp4 r8.y, r5, c56
        mad r1.xy, r6, r7, r8
        texldl r1, r1, s3
        add r0.z, -r6.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mov r1.zw, c1.z
        mad r5.xyz, r0.y, c3.wwzw, r2
        mul r6.xyz, r5.y, c61.xyww
        mad r6.xyz, r5.x, c60.xyww, r6
        mad r6.xyz, r5.z, c62.xyww, r6
        dp3 r0.z, c14, r5
        sge r5.yzw, -r0.z, c54.xxyz
        add r6.xyz, r6, c63.xyww
        mov r5.x, c3.x
        dp4 r7.x, r5, c57
        dp4 r7.y, r5, c58
        dp4 r8.x, r5, c59
        dp4 r8.y, r5, c56
        mad r1.xy, r6, r7, r8
        texldl r1, r1, s3
        add r0.z, -r6.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mad r1.xyz, r0.y, c12.xxyw, r2
        mul r5.xyz, r1.y, c61.xyww
        mad r5.xyz, r1.x, c60.xyww, r5
        mad r5.xyz, r1.z, c62.xyww, r5
        dp3 r0.z, c14, r1
        sge r1.yzw, -r0.z, c54.xxyz
        add r5.xyz, r5, c63.xyww
        mov r1.x, c3.x
        dp4 r6.x, r1, c57
        dp4 r6.y, r1, c58
        dp4 r7.x, r1, c59
        dp4 r7.y, r1, c56
        mad r1.xy, r5, r6, r7
        mov r1.zw, c1.z
        texldl r1, r1, s3
        add r0.z, -r5.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mad r1.xyz, r0.y, c12.xzyw, r2
        mul r5.xyz, r1.y, c61.xyww
        mad r5.xyz, r1.x, c60.xyww, r5
        mad r5.xyz, r1.z, c62.xyww, r5
        dp3 r0.z, c14, r1
        sge r1.yzw, -r0.z, c54.xxyz
        add r5.xyz, r5, c63.xyww
        mov r1.x, c3.x
        dp4 r6.x, r1, c57
        dp4 r6.y, r1, c58
        dp4 r7.x, r1, c59
        dp4 r7.y, r1, c56
        mad r1.xy, r5, r6, r7
        mov r1.zw, c1.z
        texldl r1, r1, s3
        add r0.z, -r5.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mad r1.xyz, r0.y, c12.zxyw, r2
        mad r0.yzw, r0.y, c12.xzzy, r2.xxyz
        mul r5.xyz, r1.y, c61.xyww
        mad r5.xyz, r1.x, c60.xyww, r5
        mad r5.xyz, r1.z, c62.xyww, r5
        dp3 r1.x, c14, r1
        sge r1.yzw, -r1.x, c54.xxyz
        add r5.xyz, r5, c63.xyww
        mov r1.x, c3.x
        dp4 r6.x, r1, c57
        dp4 r6.y, r1, c58
        dp4 r7.x, r1, c59
        dp4 r7.y, r1, c56
        mad r1.xy, r5, r6, r7
        mov r1.zw, c1.z
        texldl r1, r1, s3
        add r1.x, -r5.z, r1.x
        slt r1.x, r1.x, c1.z
        add r0.x, r0.x, r1.x
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r5.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r5.x, c3.x
        dp4 r1.x, r5, c57
        dp4 r1.y, r5, c58
        dp4 r6.x, r5, c59
        dp4 r6.y, r5, c56
        mad r1.xy, r0.yzzw, r1, r6
        mov r1.zw, c1.z
        texldl r1, r1, s3
        add r0.y, -r0.w, r1.x
        slt r0.y, r0.y, c1.z
        add r0.x, r0.x, r0.y
        mad r0.x, r0.x, c2.x, c2.y
        mov r1.x, c3.x
        mad r0.x, c73.x, r0.x, r1.x
        mad r0.y, v1.z, c0.z, c0.w
        frc r0.y, r0.y
        mad r0.y, r0.y, c1.x, c1.y
        sincos r5.xy, r0.y
        mul r0.yzw, r4, r5.xyyx
        mad r4.x, r4.x, r5.x, -r0.y
        add r4.y, r0.w, r0.z
        mul r0.yz, r4.xxyw, c47.xxyw
        rcp r5.x, c47.x
        rcp r5.y, c47.y
        mul r5.xy, r0.yzzw, r5
        mov r5.z, c1.z
        add r0.yzw, r5.xxyz, c1.w
        nrm r5.xyz, r0.yzww
        mov_sat r0.y, -c17.z
        mul r5.w, r0.y, c12.w
        dp3 r0.y, r5.xyww, -c17
        max r0.y, r0.y, -c75.x
        min r0.y, r0.y, c75.x
        add r0.z, -r0.y, c3.x
        mad r0.y, c71.x, r0.z, r0.y
        mov r6.x, c65.x
        mad r0.y, r0.y, r6.x, c66.x
        mul r0.y, r0.y, c18.x
        mul r0.y, r0.y, c18.w
        mul r0.y, r0.x, r0.y
        max r0.x, r0.x, c74.x
        mul r0.y, r0.y, c67.x
        mul r0.yzw, r0.y, v2.xxyz
        max r0.yzw, r0, c1.z
        add r0.yzw, r0, v2.xxyz
        mul r1.yzw, r2.y, c5.xxyz
        mad r1.yzw, r2.x, c4.xxyz, r1
        mad r1.yzw, r2.z, c6.xxyz, r1
        add r1.yzw, r1, c7.xxyz
        add r2, -r1.y, c19
        mul r6, r5.x, r2
        add r7, -r1.z, c20
        add r8, -r1.w, c21
        mad r6, r7, r5.y, r6
        mad r6, r8, r5.z, r6
        mad_sat r1.y, r5.y, c3.w, c3.y
        mov r5.xyz, c38
        mad r1.yzw, r5.xxyz, r1.y, c37.xxyz
        mul r1.yzw, r1, c69.x
        mul r1.yzw, r1, v2.xxyz
        max r1.yzw, r1, c1.z
        mul r5, r2, r2
        mul r2, r2, -c22
        mad r2, r7, -c23, r2
        mad r5, r7, r7, r5
        mad r5, r8, r8, r5
        mad r2, r8, -c24, r2
        mad r7, r5, -c25, r1.x
        add r5, r5, c1.w
        max r7, r7, c1.z
        mul r7, r7, r7
        mad r7, r7, r7, -c0.x
        max r7, r7, c1.z
        mul r7, r7, c2.z
        mul r6, r6, r7
        mul r7, r8, r7
        rsq r8.x, r5.x
        rsq r8.y, r5.y
        rsq r8.z, r5.z
        rsq r8.w, r5.w
        mul r5, r6, r8
        mul r2, r2, r8
        mul r6, r7, r8
        mov r7, c26
        mad_sat r2, r2, r7, c27
        mul r5, r5, r2
        mul r2, r6, r2
        dp4 r6.x, c29, r5
        dp4 r6.y, c29, r2
        mad r6.x, r6.y, c12.y, r6.x
        dp4 r6.w, c30, r2
        dp4 r2.x, c31, r2
        dp4 r2.y, c30, r5
        dp4 r2.z, c31, r5
        mad r6.z, r2.x, c12.y, r2.z
        mad r6.y, r6.w, c12.y, r2.y
        mul r2.xyz, r6, v2
        mul r2.xyz, r2, c68.x
        max r2.xyz, r2, c1.z
        add r0.yzw, r0, r2.xxyz
        mad o1.xyz, r1.yzww, r0.x, r0.yzww
        mov r4.zw, c1.z
        mad r0, r4, c47, r3
        add r1.y, -r0.w, c16.w
        add r1.z, -c16.z, c16.w
        rcp r1.z, r1.z
        mul_sat r1.y, r1.y, r1.z
        add r1.y, -r1.y, c3.x
        add r1.xz, -r1.x, c16.xyyw
        mad o3.zw, r1.y, r1.xyxz, c3.x
        rcp r1.x, c41.x
        mul_sat r1.x, r0.w, r1.x
        add r1.y, r0.w, -c41.x
        mov o0, r0
        add r0.x, -c41.x, c41.y
        rcp r0.x, r0.x
        mul_sat r0.x, r1.y, r0.x
        lrp r2.x, c41.w, r1.x, r0.x
        add o5.w, r2.x, c41.z
        mov r1.xyz, c43
        add r0.yzw, -r1.xxyz, c42.xxyz
        mad o5.xyz, r0.x, r0.yzww, c43
        mov o2, v3
        mov o3.xy, v4
        mul o4, c3.xzzz, v5.z
        mov o6, v6
    
    // approximately 309 instruction slots used (18 texture, 291 arithmetic)
};

VertexShader VS_TransformLitSoftVS
<
    string NearFarPlane         = "parameter register(128)";
    string gAmbientAmount       = "parameter register(69)";
    string gAmbientShadow       = "parameter register(74)";
    string gAspectRatio         = "parameter register(47)";
    string gBiasToCamera        = "parameter register(64)";
    string gDepthFxParams       = "parameter register(16)";
    string gDiffuse             = "parameter register(67)";
    string gDirectionalColour   = "parameter register(18)";
    string gDirectionalLight    = "parameter register(17)";
    string gExtraLights         = "parameter register(68)";
    string gFacetCentre         = "parameter register(54)";
    string gLightAmbient0       = "parameter register(37)";
    string gLightAmbient1       = "parameter register(38)";
    string gLightColB           = "parameter register(31)";
    string gLightColG           = "parameter register(30)";
    string gLightColR           = "parameter register(29)";
    string gLightConeOffset     = "parameter register(27)";
    string gLightConeScale      = "parameter register(26)";
    string gLightDirX           = "parameter register(22)";
    string gLightDirY           = "parameter register(23)";
    string gLightDirZ           = "parameter register(24)";
    string gLightFallOff        = "parameter register(25)";
    string gLightIntensityClamp = "parameter register(75)";
    string gLightPosX           = "parameter register(19)";
    string gLightPosY           = "parameter register(20)";
    string gLightPosZ           = "parameter register(21)";
    string gNormalArc           = "parameter register(71)";
    string gScaleFade           = "parameter register(72)";
    string gShadowMatrix        = "parameter register(60)";
    string gShadowParam0123     = "parameter register(57)";
    string gShadowParam14151617 = "parameter register(56)";
    string gShadowParam4567     = "parameter register(58)";
    string gShadowParam891113   = "parameter register(59)";
    string gShadowZSamplerDirVS = "parameter register(3)";
    string gSuperAlpha          = "parameter register(70)";
    string gUseShadows          = "parameter register(73)";
    string gViewInverse         = "parameter register(12)";
    string gWorldView           = "parameter register(4)";
    string gWorldViewProj       = "parameter register(8)";
    string gWrapBias            = "parameter register(66)";
    string gWrapScale           = "parameter register(65)";
    string globalFogColor       = "parameter register(42)";
    string globalFogColorN      = "parameter register(43)";
    string globalFogParams      = "parameter register(41)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 NearFarPlane;
    //   float gAmbientAmount;
    //   float gAmbientShadow;
    //   float4 gAspectRatio;
    //   float gBiasToCamera;
    //   float4 gDepthFxParams;
    //   float gDiffuse;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float gExtraLights;
    //   float4 gFacetCentre;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   float4 gLightColB;
    //   float4 gLightColG;
    //   float4 gLightColR;
    //   float4 gLightConeOffset;
    //   float4 gLightConeScale;
    //   float4 gLightDirX;
    //   float4 gLightDirY;
    //   float4 gLightDirZ;
    //   float4 gLightFallOff;
    //   float gLightIntensityClamp;
    //   float4 gLightPosX;
    //   float4 gLightPosY;
    //   float4 gLightPosZ;
    //   float gNormalArc;
    //   float gScaleFade;
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam4567;
    //   float4 gShadowParam891113;
    //   sampler2D gShadowZSamplerDirVS;
    //   float gSuperAlpha;
    //   float gUseShadows;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldView;
    //   row_major float4x4 gWorldViewProj;
    //   float gWrapBias;
    //   float gWrapScale;
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //
    //
    // Registers:
    //
    //   Name                 Reg   Size
    //   -------------------- ----- ----
    //   gWorldView           c4       4
    //   gWorldViewProj       c8       4
    //   gViewInverse         c12      4
    //   gDepthFxParams       c16      1
    //   gDirectionalLight    c17      1
    //   gDirectionalColour   c18      1
    //   gLightPosX           c19      1
    //   gLightPosY           c20      1
    //   gLightPosZ           c21      1
    //   gLightDirX           c22      1
    //   gLightDirY           c23      1
    //   gLightDirZ           c24      1
    //   gLightFallOff        c25      1
    //   gLightConeScale      c26      1
    //   gLightConeOffset     c27      1
    //   gLightColR           c29      1
    //   gLightColG           c30      1
    //   gLightColB           c31      1
    //   gLightAmbient0       c37      1
    //   gLightAmbient1       c38      1
    //   globalFogParams      c41      1
    //   globalFogColor       c42      1
    //   globalFogColorN      c43      1
    //   gAspectRatio         c47      1
    //   gFacetCentre         c54      1
    //   gShadowParam14151617 c56      1
    //   gShadowParam0123     c57      1
    //   gShadowParam4567     c58      1
    //   gShadowParam891113   c59      1
    //   gShadowMatrix        c60      4
    //   gBiasToCamera        c64      1
    //   gWrapScale           c65      1
    //   gWrapBias            c66      1
    //   gDiffuse             c67      1
    //   gExtraLights         c68      1
    //   gAmbientAmount       c69      1
    //   gSuperAlpha          c70      1
    //   gNormalArc           c71      1
    //   gScaleFade           c72      1
    //   gUseShadows          c73      1
    //   gAmbientShadow       c74      1
    //   gLightIntensityClamp c75      1
    //   NearFarPlane         c128     1
    //   gShadowZSamplerDirVS s3       1
    //
    
        vs_3_0
        def c0, 0.100000001, 9.99999997e-007, 0.159154937, 0.5
        def c1, 6.28318548, -3.14159274, 0, 9.99999975e-006
        def c2, 0.111111112, -1, 1.11111116, 0
        def c3, 1, 0.5, 0, -0.5
        def c12, 0.5, 0.25, -0.5, 0.375
        dcl_position v0
        dcl_normal v1
        dcl_color v2
        dcl_texcoord v3
        dcl_texcoord1 v4
        dcl_texcoord2 v5
        dcl_texcoord3 v6
        dcl_2d s3
        dcl_position o0
        dcl_color o1
        dcl_texcoord o2
        dcl_texcoord1 o3
        dcl_texcoord2 o4
        dcl_texcoord3 o5
        dcl_texcoord4 o6
        mov r0.zw, c1.z
        mov r1.x, c0.x
        mul r1.x, r1.x, c64.x
        lrp r2.xyz, r1.x, c15, v0
        mul r1.xyz, r2.y, c61.xyww
        mad r1.xyz, r2.x, c60.xyww, r1
        mad r1.xyz, r2.z, c62.xyww, r1
        add r1.xyz, r1, c63.xyww
        mov r3.x, c3.x
        dp3 r1.w, c14, r2
        sge r3.yzw, -r1.w, c54.xxyz
        dp4 r4.x, r3, c57
        dp4 r4.y, r3, c58
        dp4 r5.x, r3, c59
        dp4 r5.y, r3, c56
        mad r0.xy, r1, r4, r5
        texldl r0, r0, s3
        add r0.x, -r1.z, r0.x
        slt r0.x, r0.x, c1.z
        mov r1.zw, c1.z
        sge r0.y, c0.y, v2.w
        rcp r0.z, c72.x
        mul r3, r2.y, c9
        mad r3, r2.x, c8, r3
        mad r3, r2.z, c10, r3
        add r3, r3, c11
        add r0.w, r3.w, -c128.x
        mul_sat r0.z, r0.z, r0.w
        mad r0.y, r0.y, -r0.z, r0.z
        mul r4, r0.y, v1.xyxy
        mul r0.y, r0.y, v2.w
        mul_sat o1.w, r0.y, c70.x
        add r0.y, r4.w, r4.z
        mad r5.xyz, r0.y, c3.yyzw, r2
        mul r6.xyz, r5.y, c61.xyww
        mad r6.xyz, r5.x, c60.xyww, r6
        mad r6.xyz, r5.z, c62.xyww, r6
        dp3 r0.z, c14, r5
        sge r5.yzw, -r0.z, c54.xxyz
        add r6.xyz, r6, c63.xyww
        mov r5.x, c3.x
        dp4 r7.x, r5, c57
        dp4 r7.y, r5, c58
        dp4 r8.x, r5, c59
        dp4 r8.y, r5, c56
        mad r1.xy, r6, r7, r8
        texldl r1, r1, s3
        add r0.z, -r6.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mov r1.zw, c1.z
        mad r5.xyz, r0.y, c3.ywzw, r2
        mul r6.xyz, r5.y, c61.xyww
        mad r6.xyz, r5.x, c60.xyww, r6
        mad r6.xyz, r5.z, c62.xyww, r6
        dp3 r0.z, c14, r5
        sge r5.yzw, -r0.z, c54.xxyz
        add r6.xyz, r6, c63.xyww
        mov r5.x, c3.x
        dp4 r7.x, r5, c57
        dp4 r7.y, r5, c58
        dp4 r8.x, r5, c59
        dp4 r8.y, r5, c56
        mad r1.xy, r6, r7, r8
        texldl r1, r1, s3
        add r0.z, -r6.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mov r1.zw, c1.z
        mad r5.xyz, r0.y, c3.wyzw, r2
        mul r6.xyz, r5.y, c61.xyww
        mad r6.xyz, r5.x, c60.xyww, r6
        mad r6.xyz, r5.z, c62.xyww, r6
        dp3 r0.z, c14, r5
        sge r5.yzw, -r0.z, c54.xxyz
        add r6.xyz, r6, c63.xyww
        mov r5.x, c3.x
        dp4 r7.x, r5, c57
        dp4 r7.y, r5, c58
        dp4 r8.x, r5, c59
        dp4 r8.y, r5, c56
        mad r1.xy, r6, r7, r8
        texldl r1, r1, s3
        add r0.z, -r6.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mov r1.zw, c1.z
        mad r5.xyz, r0.y, c3.wwzw, r2
        mul r6.xyz, r5.y, c61.xyww
        mad r6.xyz, r5.x, c60.xyww, r6
        mad r6.xyz, r5.z, c62.xyww, r6
        dp3 r0.z, c14, r5
        sge r5.yzw, -r0.z, c54.xxyz
        add r6.xyz, r6, c63.xyww
        mov r5.x, c3.x
        dp4 r7.x, r5, c57
        dp4 r7.y, r5, c58
        dp4 r8.x, r5, c59
        dp4 r8.y, r5, c56
        mad r1.xy, r6, r7, r8
        texldl r1, r1, s3
        add r0.z, -r6.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mad r1.xyz, r0.y, c12.xxyw, r2
        mul r5.xyz, r1.y, c61.xyww
        mad r5.xyz, r1.x, c60.xyww, r5
        mad r5.xyz, r1.z, c62.xyww, r5
        dp3 r0.z, c14, r1
        sge r1.yzw, -r0.z, c54.xxyz
        add r5.xyz, r5, c63.xyww
        mov r1.x, c3.x
        dp4 r6.x, r1, c57
        dp4 r6.y, r1, c58
        dp4 r7.x, r1, c59
        dp4 r7.y, r1, c56
        mad r1.xy, r5, r6, r7
        mov r1.zw, c1.z
        texldl r1, r1, s3
        add r0.z, -r5.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mad r1.xyz, r0.y, c12.xzyw, r2
        mul r5.xyz, r1.y, c61.xyww
        mad r5.xyz, r1.x, c60.xyww, r5
        mad r5.xyz, r1.z, c62.xyww, r5
        dp3 r0.z, c14, r1
        sge r1.yzw, -r0.z, c54.xxyz
        add r5.xyz, r5, c63.xyww
        mov r1.x, c3.x
        dp4 r6.x, r1, c57
        dp4 r6.y, r1, c58
        dp4 r7.x, r1, c59
        dp4 r7.y, r1, c56
        mad r1.xy, r5, r6, r7
        mov r1.zw, c1.z
        texldl r1, r1, s3
        add r0.z, -r5.z, r1.x
        slt r0.z, r0.z, c1.z
        add r0.x, r0.x, r0.z
        mad r1.xyz, r0.y, c12.zxyw, r2
        mad r0.yzw, r0.y, c12.xzzy, r2.xxyz
        mul r5.xyz, r1.y, c61.xyww
        mad r5.xyz, r1.x, c60.xyww, r5
        mad r5.xyz, r1.z, c62.xyww, r5
        dp3 r1.x, c14, r1
        sge r1.yzw, -r1.x, c54.xxyz
        add r5.xyz, r5, c63.xyww
        mov r1.x, c3.x
        dp4 r6.x, r1, c57
        dp4 r6.y, r1, c58
        dp4 r7.x, r1, c59
        dp4 r7.y, r1, c56
        mad r1.xy, r5, r6, r7
        mov r1.zw, c1.z
        texldl r1, r1, s3
        add r1.x, -r5.z, r1.x
        slt r1.x, r1.x, c1.z
        add r0.x, r0.x, r1.x
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r5.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r5.x, c3.x
        dp4 r1.x, r5, c57
        dp4 r1.y, r5, c58
        dp4 r6.x, r5, c59
        dp4 r6.y, r5, c56
        mad r1.xy, r0.yzzw, r1, r6
        mov r1.zw, c1.z
        texldl r1, r1, s3
        add r0.y, -r0.w, r1.x
        slt r0.y, r0.y, c1.z
        add r0.x, r0.x, r0.y
        mad r0.x, r0.x, c2.x, c2.y
        mov r1.x, c3.x
        mad r0.x, c73.x, r0.x, r1.x
        mov_sat r0.y, -c17.z
        mul r5.w, r0.y, c12.w
        mad r0.y, v1.z, c0.z, c0.w
        frc r0.y, r0.y
        mad r0.y, r0.y, c1.x, c1.y
        sincos r6.xy, r0.y
        mul r0.yzw, r4, r6.xyyx
        mad r4.x, r4.x, r6.x, -r0.y
        add r4.y, r0.w, r0.z
        mul r0.yz, r4.xxyw, c47.xxyw
        rcp r6.x, c47.x
        rcp r6.y, c47.y
        mul r6.xy, r0.yzzw, r6
        mov r6.z, c1.z
        add r0.yzw, r6.xxyz, c1.w
        nrm r5.xyz, r0.yzww
        dp3 r0.y, r5.xyww, -c17
        max r0.y, r0.y, -c75.x
        min r0.y, r0.y, c75.x
        add r0.z, -r0.y, c3.x
        mad r0.y, c71.x, r0.z, r0.y
        mov r6.x, c65.x
        mad r0.y, r0.y, r6.x, c66.x
        mul r0.y, r0.y, c18.x
        mul r0.y, r0.y, c18.w
        mul r0.y, r0.x, r0.y
        max r0.x, r0.x, c74.x
        mul r0.y, r0.y, c67.x
        mul r0.yzw, r0.y, v2.xxyz
        max r0.yzw, r0, c1.z
        add r0.yzw, r0, v2.xxyz
        mul r1.yzw, r2.y, c5.xxyz
        mad r1.yzw, r2.x, c4.xxyz, r1
        mad r1.yzw, r2.z, c6.xxyz, r1
        add r1.yzw, r1, c7.xxyz
        add r2, -r1.y, c19
        mul r6, r5.x, r2
        add r7, -r1.z, c20
        add r8, -r1.w, c21
        mad r6, r7, r5.y, r6
        mad r6, r8, r5.z, r6
        mad_sat r1.y, r5.y, c3.w, c3.y
        mov r5.xyz, c38
        mad r1.yzw, r5.xxyz, r1.y, c37.xxyz
        mul r1.yzw, r1, c69.x
        mul r1.yzw, r1, v2.xxyz
        max r1.yzw, r1, c1.z
        mul r5, r2, r2
        mul r2, r2, -c22
        mad r2, r7, -c23, r2
        mad r5, r7, r7, r5
        mad r5, r8, r8, r5
        mad r2, r8, -c24, r2
        mad r7, r5, -c25, r1.x
        add r5, r5, c1.w
        max r7, r7, c1.z
        mul r7, r7, r7
        mad r7, r7, r7, -c0.x
        max r7, r7, c1.z
        mul r7, r7, c2.z
        mul r6, r6, r7
        mul r7, r8, r7
        rsq r8.x, r5.x
        rsq r8.y, r5.y
        rsq r8.z, r5.z
        rsq r8.w, r5.w
        mul r5, r6, r8
        mul r2, r2, r8
        mul r6, r7, r8
        mov r7, c26
        mad_sat r2, r2, r7, c27
        mul r5, r5, r2
        mul r2, r6, r2
        dp4 r6.x, c29, r5
        dp4 r6.y, c29, r2
        mad r6.x, r6.y, c12.y, r6.x
        dp4 r6.w, c30, r2
        dp4 r2.x, c31, r2
        dp4 r2.y, c30, r5
        dp4 r2.z, c31, r5
        mad r6.z, r2.x, c12.y, r2.z
        mad r6.y, r6.w, c12.y, r2.y
        mul r2.xyz, r6, v2
        mul r2.xyz, r2, c68.x
        max r2.xyz, r2, c1.z
        add r0.yzw, r0, r2.xxyz
        mad o1.xyz, r1.yzww, r0.x, r0.yzww
        mov r4.zw, c1.z
        mad r0, r4, c47, r3
        mov o4.y, r3.w
        add r1.y, -r0.w, c16.w
        add r1.z, -c16.z, c16.w
        rcp r1.z, r1.z
        mul_sat r1.y, r1.y, r1.z
        add r1.y, -r1.y, c3.x
        add r1.xz, -r1.x, c16.xyyw
        mad o3.zw, r1.y, r1.xyxz, c3.x
        rcp r1.x, c41.x
        mul_sat r1.x, r0.w, r1.x
        add r1.y, r0.w, -c41.x
        mov o0, r0
        add r0.x, -c41.x, c41.y
        rcp r0.x, r0.x
        mul_sat r0.x, r1.y, r0.x
        lrp r2.x, c41.w, r1.x, r0.x
        add o5.w, r2.x, c41.z
        mov r1.xyz, c43
        add r0.yzw, -r1.xxyz, c42.xxyz
        mad o5.xyz, r0.x, r0.yzww, c43
        mov o2, v3
        mov o3.xy, v4
        mul o4.xzw, c3.xyzz, v5.z
        mov o6, v6
    
    // approximately 310 instruction slots used (18 texture, 292 arithmetic)
};

VertexShader VS_TransformLitScreenSpaceVS
<
    string gAmbientAmount       = "parameter register(68)";
    string gAmbientShadow       = "parameter register(72)";
    string gAspectRatio         = "parameter register(47)";
    string gDepthFxParams       = "parameter register(16)";
    string gDiffuse             = "parameter register(66)";
    string gDirectionalColour   = "parameter register(18)";
    string gDirectionalLight    = "parameter register(17)";
    string gExtraLights         = "parameter register(67)";
    string gFacetCentre         = "parameter register(54)";
    string gLightAmbient0       = "parameter register(37)";
    string gLightAmbient1       = "parameter register(38)";
    string gLightColB           = "parameter register(31)";
    string gLightColG           = "parameter register(30)";
    string gLightColR           = "parameter register(29)";
    string gLightConeOffset     = "parameter register(27)";
    string gLightConeScale      = "parameter register(26)";
    string gLightDirX           = "parameter register(22)";
    string gLightDirY           = "parameter register(23)";
    string gLightDirZ           = "parameter register(24)";
    string gLightFallOff        = "parameter register(25)";
    string gLightIntensityClamp = "parameter register(73)";
    string gLightPosX           = "parameter register(19)";
    string gLightPosY           = "parameter register(20)";
    string gLightPosZ           = "parameter register(21)";
    string gNormalArc           = "parameter register(70)";
    string gShadowMatrix        = "parameter register(60)";
    string gShadowParam0123     = "parameter register(57)";
    string gShadowParam14151617 = "parameter register(56)";
    string gShadowParam4567     = "parameter register(58)";
    string gShadowParam891113   = "parameter register(59)";
    string gShadowZSamplerDirVS = "parameter register(3)";
    string gSuperAlpha          = "parameter register(69)";
    string gUseShadows          = "parameter register(71)";
    string gViewInverse         = "parameter register(12)";
    string gWorldView           = "parameter register(4)";
    string gWrapBias            = "parameter register(65)";
    string gWrapScale           = "parameter register(64)";
    string globalFogColor       = "parameter register(42)";
    string globalFogColorN      = "parameter register(43)";
    string globalFogParams      = "parameter register(41)";
    string globalScreenSize     = "parameter register(44)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float gAmbientAmount;
    //   float gAmbientShadow;
    //   float4 gAspectRatio;
    //   float4 gDepthFxParams;
    //   float gDiffuse;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float gExtraLights;
    //   float4 gFacetCentre;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   float4 gLightColB;
    //   float4 gLightColG;
    //   float4 gLightColR;
    //   float4 gLightConeOffset;
    //   float4 gLightConeScale;
    //   float4 gLightDirX;
    //   float4 gLightDirY;
    //   float4 gLightDirZ;
    //   float4 gLightFallOff;
    //   float gLightIntensityClamp;
    //   float4 gLightPosX;
    //   float4 gLightPosY;
    //   float4 gLightPosZ;
    //   float gNormalArc;
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam4567;
    //   float4 gShadowParam891113;
    //   sampler2D gShadowZSamplerDirVS;
    //   float gSuperAlpha;
    //   float gUseShadows;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldView;
    //   float gWrapBias;
    //   float gWrapScale;
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //   float4 globalScreenSize;
    //
    //
    // Registers:
    //
    //   Name                 Reg   Size
    //   -------------------- ----- ----
    //   gWorldView           c4       4
    //   gViewInverse         c12      3
    //   gDepthFxParams       c16      1
    //   gDirectionalLight    c17      1
    //   gDirectionalColour   c18      1
    //   gLightPosX           c19      1
    //   gLightPosY           c20      1
    //   gLightPosZ           c21      1
    //   gLightDirX           c22      1
    //   gLightDirY           c23      1
    //   gLightDirZ           c24      1
    //   gLightFallOff        c25      1
    //   gLightConeScale      c26      1
    //   gLightConeOffset     c27      1
    //   gLightColR           c29      1
    //   gLightColG           c30      1
    //   gLightColB           c31      1
    //   gLightAmbient0       c37      1
    //   gLightAmbient1       c38      1
    //   globalFogParams      c41      1
    //   globalFogColor       c42      1
    //   globalFogColorN      c43      1
    //   globalScreenSize     c44      1
    //   gAspectRatio         c47      1
    //   gFacetCentre         c54      1
    //   gShadowParam14151617 c56      1
    //   gShadowParam0123     c57      1
    //   gShadowParam4567     c58      1
    //   gShadowParam891113   c59      1
    //   gShadowMatrix        c60      4
    //   gWrapScale           c64      1
    //   gWrapBias            c65      1
    //   gDiffuse             c66      1
    //   gExtraLights         c67      1
    //   gAmbientAmount       c68      1
    //   gSuperAlpha          c69      1
    //   gNormalArc           c70      1
    //   gUseShadows          c71      1
    //   gAmbientShadow       c72      1
    //   gLightIntensityClamp c73      1
    //   gShadowZSamplerDirVS s3       1
    //
    
        vs_3_0
        def c0, -1, 0.159154937, 0.5, 0
        def c1, 6.28318548, -3.14159274, 9.99999975e-006, 0.375
        def c2, 0.111111112, -1, -0.100000001, 1.11111116
        def c3, 0.5, -0.5, 0, 0.25
        dcl_position v0
        dcl_normal v1
        dcl_color v2
        dcl_texcoord v3
        dcl_texcoord1 v4
        dcl_texcoord2 v5
        dcl_texcoord3 v6
        dcl_2d s3
        dcl_position o0
        dcl_color o1
        dcl_texcoord o2
        dcl_texcoord1 o3
        dcl_texcoord2 o4
        dcl_texcoord3 o5
        dcl_texcoord4 o6
        mad r0.x, v1.z, c0.y, c0.z
        frc r0.x, r0.x
        mad r0.x, r0.x, c1.x, c1.y
        sincos r1.xy, r0.x
        mul r0.xyz, r1.yyxw, v1.yxyw
        mad r1.x, v1.x, r1.x, -r0.x
        add r1.y, r0.z, r0.y
        rcp r0.x, c44.y
        mul r0.y, r0.x, c44.x
        mov r1.z, c0.w
        mov r0.xz, -c0.x
        mul r2.xyz, r1, r0
        mad r0.xyz, r1, r0, -v0
        add r0.w, c0.x, v1.w
        sge r0.w, -r0_abs.w, r0_abs.w
        mul r1.xyz, r2, r0.w
        mad r0.xyz, r0.w, r0, v0
        mad o0.xyz, v0.xyxw, c0_abs.xxww, r1
        mul r1.xyz, c61.xyww, v0.y
        mad r1.xyz, v0.x, c60.xyww, r1
        mad r1.xyz, v0.z, c62.xyww, r1
        add r1.xyz, r1, c63.xyww
        dp3 r0.w, c14, v0
        sge r2.yzw, -r0.w, c54.xxyz
        mov r2.x, -c0.x
        dp4 r3.x, r2, c57
        dp4 r3.y, r2, c58
        dp4 r4.x, r2, c59
        dp4 r4.y, r2, c56
        mad r2.xy, r1, r3, r4
        mov r2.zw, c0.w
        texldl r2, r2, s3
        add r0.w, -r1.z, r2.x
        slt r0.w, r0.w, c0.w
        mov r1.zw, c0.w
        add r2.x, v1.y, v1.x
        mad r2.yzw, r2.x, c0.xzzw, v0.xxyz
        mul r3.xyz, r2.z, c61.xyww
        mad r3.xyz, r2.y, c60.xyww, r3
        mad r3.xyz, r2.w, c62.xyww, r3
        dp3 r2.y, c14, r2.yzww
        sge r4.yzw, -r2.y, c54.xxyz
        add r2.yzw, r3.xxyz, c63.xxyw
        mov r4.x, -c0.x
        dp4 r3.x, r4, c57
        dp4 r3.y, r4, c58
        dp4 r5.x, r4, c59
        dp4 r5.y, r4, c56
        mad r1.xy, r2.yzzw, r3, r5
        texldl r1, r1, s3
        add r1.x, -r2.w, r1.x
        slt r1.x, r1.x, c0.w
        add r0.w, r0.w, r1.x
        mad r1.xyz, r2.x, c3, v0
        mul r2.yzw, r1.y, c61.xxyw
        mad r2.yzw, r1.x, c60.xxyw, r2
        mad r2.yzw, r1.z, c62.xxyw, r2
        dp3 r1.x, c14, r1
        sge r1.yzw, -r1.x, c54.xxyz
        add r2.yzw, r2, c63.xxyw
        mov r1.x, -c0.x
        dp4 r3.x, r1, c57
        dp4 r3.y, r1, c58
        dp4 r4.x, r1, c59
        dp4 r4.y, r1, c56
        mad r1.xy, r2.yzzw, r3, r4
        mov r1.zw, c0.w
        texldl r1, r1, s3
        add r1.x, -r2.w, r1.x
        slt r1.x, r1.x, c0.w
        add r0.w, r0.w, r1.x
        mad r1.xyz, r2.x, c3.yxzw, v0
        mul r2.yzw, r1.y, c61.xxyw
        mad r2.yzw, r1.x, c60.xxyw, r2
        mad r2.yzw, r1.z, c62.xxyw, r2
        dp3 r1.x, c14, r1
        sge r1.yzw, -r1.x, c54.xxyz
        add r2.yzw, r2, c63.xxyw
        mov r1.x, -c0.x
        dp4 r3.x, r1, c57
        dp4 r3.y, r1, c58
        dp4 r4.x, r1, c59
        dp4 r4.y, r1, c56
        mad r1.xy, r2.yzzw, r3, r4
        mov r1.zw, c0.w
        texldl r1, r1, s3
        add r1.x, -r2.w, r1.x
        slt r1.x, r1.x, c0.w
        add r0.w, r0.w, r1.x
        mad r1.xyz, r2.x, c3.yyzw, v0
        mul r2.yzw, r1.y, c61.xxyw
        mad r2.yzw, r1.x, c60.xxyw, r2
        mad r2.yzw, r1.z, c62.xxyw, r2
        dp3 r1.x, c14, r1
        sge r1.yzw, -r1.x, c54.xxyz
        add r2.yzw, r2, c63.xxyw
        mov r1.x, -c0.x
        dp4 r3.x, r1, c57
        dp4 r3.y, r1, c58
        dp4 r4.x, r1, c59
        dp4 r4.y, r1, c56
        mad r1.xy, r2.yzzw, r3, r4
        mov r1.zw, c0.w
        texldl r1, r1, s3
        add r1.x, -r2.w, r1.x
        slt r1.x, r1.x, c0.w
        add r0.w, r0.w, r1.x
        mad r1.xyz, r2.x, c3.xxww, v0
        mul r2.yzw, r1.y, c61.xxyw
        mad r2.yzw, r1.x, c60.xxyw, r2
        mad r2.yzw, r1.z, c62.xxyw, r2
        dp3 r1.x, c14, r1
        sge r1.yzw, -r1.x, c54.xxyz
        add r2.yzw, r2, c63.xxyw
        mov r1.x, -c0.x
        dp4 r3.x, r1, c57
        dp4 r3.y, r1, c58
        dp4 r4.x, r1, c59
        dp4 r4.y, r1, c56
        mad r1.xy, r2.yzzw, r3, r4
        mov r1.zw, c0.w
        texldl r1, r1, s3
        add r1.x, -r2.w, r1.x
        slt r1.x, r1.x, c0.w
        add r0.w, r0.w, r1.x
        mad r1.xyz, r2.x, c3.xyww, v0
        mul r2.yzw, r1.y, c61.xxyw
        mad r2.yzw, r1.x, c60.xxyw, r2
        mad r2.yzw, r1.z, c62.xxyw, r2
        dp3 r1.x, c14, r1
        sge r1.yzw, -r1.x, c54.xxyz
        add r2.yzw, r2, c63.xxyw
        mov r1.x, -c0.x
        dp4 r3.x, r1, c57
        dp4 r3.y, r1, c58
        dp4 r4.x, r1, c59
        dp4 r4.y, r1, c56
        mad r1.xy, r2.yzzw, r3, r4
        mov r1.zw, c0.w
        texldl r1, r1, s3
        add r1.x, -r2.w, r1.x
        slt r1.x, r1.x, c0.w
        add r0.w, r0.w, r1.x
        mad r1.xyz, r2.x, c3.yxww, v0
        mad r2.xyz, r2.x, c3.yyww, v0
        mul r3.xyz, r1.y, c61.xyww
        mad r3.xyz, r1.x, c60.xyww, r3
        mad r3.xyz, r1.z, c62.xyww, r3
        dp3 r1.x, c14, r1
        sge r1.yzw, -r1.x, c54.xxyz
        add r3.xyz, r3, c63.xyww
        mov r1.x, -c0.x
        dp4 r4.x, r1, c57
        dp4 r4.y, r1, c58
        dp4 r5.x, r1, c59
        dp4 r5.y, r1, c56
        mad r1.xy, r3, r4, r5
        mov r1.zw, c0.w
        texldl r1, r1, s3
        add r1.x, -r3.z, r1.x
        slt r1.x, r1.x, c0.w
        add r0.w, r0.w, r1.x
        mul r1.xyz, r2.y, c61.xyww
        mad r1.xyz, r2.x, c60.xyww, r1
        mad r1.xyz, r2.z, c62.xyww, r1
        dp3 r1.w, c14, r2
        sge r2.yzw, -r1.w, c54.xxyz
        add r1.xyz, r1, c63.xyww
        mov r2.x, -c0.x
        dp4 r3.x, r2, c57
        dp4 r3.y, r2, c58
        dp4 r4.x, r2, c59
        dp4 r4.y, r2, c56
        mad r2.xy, r1, r3, r4
        mov r2.zw, c0.w
        texldl r2, r2, s3
        add r1.x, -r1.z, r2.x
        slt r1.x, r1.x, c0.w
        add r0.w, r0.w, r1.x
        mad r0.w, r0.w, c2.x, c2.y
        mov r1.x, c0.x
        mad r0.w, c71.x, r0.w, -r1.x
        rcp r2.x, c47.x
        rcp r2.y, c47.y
        mov r2.z, -c0.x
        mad r0.xyz, r0, r2, c1.z
        nrm r2.xyz, r0
        mov_sat r0.x, -c17.z
        mul r2.w, r0.x, c1.w
        dp3 r0.x, r2.xyww, -c17
        max r0.x, r0.x, -c73.x
        min r0.x, r0.x, c73.x
        add r0.y, -r0.x, -c0.x
        mad r0.x, c70.x, r0.y, r0.x
        mov r3.x, c64.x
        mad r0.x, r0.x, r3.x, c65.x
        mul r0.x, r0.x, c18.x
        mul r0.x, r0.x, c18.w
        mul r0.x, r0.w, r0.x
        max r0.y, r0.w, c72.x
        mul r0.x, r0.x, c66.x
        mul r0.xzw, r0.x, v2.xyyz
        max r0.xzw, r0, c0.w
        add r0.xzw, r0, v2.xyyz
        mul r1.yzw, c5.xxyz, v0.y
        mad r1.yzw, v0.x, c4.xxyz, r1
        mad r1.yzw, v0.z, c6.xxyz, r1
        add r1.yzw, r1, c7.xxyz
        add r3, -r1.y, c19
        mul r4, r2.x, r3
        add r5, -r1.z, c20
        add r6, -r1.w, c21
        mad r4, r5, r2.y, r4
        mad r4, r6, r2.z, r4
        mad_sat r1.y, r2.y, c3.y, c3.x
        mov r2.xyz, c38
        mad r1.yzw, r2.xxyz, r1.y, c37.xxyz
        mul r1.yzw, r1, c68.x
        mul r1.yzw, r1, v2.xxyz
        max r1.yzw, r1, c0.w
        mul r2, r3, r3
        mul r3, r3, -c22
        mad r3, r5, -c23, r3
        mad r2, r5, r5, r2
        mad r2, r6, r6, r2
        mad r3, r6, -c24, r3
        mad r5, r2, -c25, -r1.x
        add r2, r2, c1.z
        max r5, r5, c0.w
        mul r5, r5, r5
        mad r5, r5, r5, c2.z
        max r5, r5, c0.w
        mul r5, r5, c2.w
        mul r4, r4, r5
        mul r5, r6, r5
        rsq r6.x, r2.x
        rsq r6.y, r2.y
        rsq r6.z, r2.z
        rsq r6.w, r2.w
        mul r2, r4, r6
        mul r3, r3, r6
        mul r4, r5, r6
        mov r5, c26
        mad_sat r3, r3, r5, c27
        mul r2, r2, r3
        mul r3, r4, r3
        dp4 r4.x, c29, r2
        dp4 r4.y, c29, r3
        mad r4.x, r4.y, c3.w, r4.x
        dp4 r4.w, c30, r2
        dp4 r2.x, c31, r2
        dp4 r2.y, c30, r3
        dp4 r2.z, c31, r3
        mad r4.z, r2.z, c3.w, r2.x
        mad r4.y, r2.y, c3.w, r4.w
        mul r2.xyz, r4, v2
        mul r2.xyz, r2, c67.x
        max r2.xyz, r2, c0.w
        add r0.xzw, r0, r2.xyyz
        mad o1.xyz, r1.yzww, r0.y, r0.xzww
        mul_sat o1.w, c69.x, v2.w
        add r0.x, -c16.z, c16.w
        rcp r0.x, r0.x
        add r0.yzw, r1.x, c16.xwxy
        mul_sat r0.x, r0.x, r0.y
        add r0.x, -r0.x, -c0.x
        mad o3.zw, r0.x, r0, -c0.x
        add r0.x, -c41.x, c41.y
        rcp r0.x, r0.x
        add r0.y, -r1.x, -c41.x
        mul_sat r0.x, r0.x, r0.y
        rcp_sat r0.y, c41.x
        lrp r1.x, c41.w, r0.y, r0.x
        add o5.w, r1.x, c41.z
        mov r1.xyz, c43
        add r0.yzw, -r1.xxyz, c42.xxyz
        mad o5.xyz, r0.x, r0.yzww, c43
        mov o0.w, -c0.x
        mov o2, v3
        mov o3.xy, v4
        mul o4, c0_abs.xwww, v5.z
        mov o6, v6
    
    // approximately 300 instruction slots used (18 texture, 282 arithmetic)
};

VertexShader VS_TransformUnLitVS
<
    string NearFarPlane    = "parameter register(128)";
    string gAspectRatio    = "parameter register(47)";
    string gBiasToCamera   = "parameter register(64)";
    string gDepthFxParams  = "parameter register(16)";
    string gScaleFade      = "parameter register(66)";
    string gSuperAlpha     = "parameter register(65)";
    string gViewInverse    = "parameter register(12)";
    string gWorldViewProj  = "parameter register(8)";
    string globalFogColor  = "parameter register(42)";
    string globalFogColorN = "parameter register(43)";
    string globalFogParams = "parameter register(41)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 NearFarPlane;
    //   float4 gAspectRatio;
    //   float gBiasToCamera;
    //   float4 gDepthFxParams;
    //   float gScaleFade;
    //   float gSuperAlpha;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //
    //
    // Registers:
    //
    //   Name            Reg   Size
    //   --------------- ----- ----
    //   gWorldViewProj  c8       4
    //   gViewInverse    c12      4
    //   gDepthFxParams  c16      1
    //   globalFogParams c41      1
    //   globalFogColor  c42      1
    //   globalFogColorN c43      1
    //   gAspectRatio    c47      1
    //   gBiasToCamera   c64      1
    //   gSuperAlpha     c65      1
    //   gScaleFade      c66      1
    //   NearFarPlane    c128     1
    //
    
        vs_3_0
        def c0, 0.100000001, 9.99999997e-007, 0.159154937, 0.5
        def c1, 6.28318548, -3.14159274, 0, 1
        dcl_position v0
        dcl_normal v1
        dcl_color v2
        dcl_texcoord v3
        dcl_texcoord1 v4
        dcl_texcoord2 v5
        dcl_texcoord3 v6
        dcl_position o0
        dcl_color o1
        dcl_texcoord o2
        dcl_texcoord1 o3
        dcl_texcoord2 o4
        dcl_texcoord3 o5
        dcl_texcoord4 o6
        mov r0.x, c0.x
        mul r0.x, r0.x, c64.x
        lrp r1.xyz, r0.x, c15, v0
        mul r0, r1.y, c9
        mad r0, r1.x, c8, r0
        mad r0, r1.z, c10, r0
        add r0, r0, c11
        add r1.x, r0.w, -c128.x
        rcp r1.y, c66.x
        mul_sat r1.x, r1.x, r1.y
        sge r1.y, c0.y, v2.w
        mad r1.x, r1.y, -r1.x, r1.x
        mul r1.y, r1.x, v2.w
        mul r2, r1.x, v1.xyxy
        mul_sat o1.w, r1.y, c65.x
        mad r1.x, v1.z, c0.z, c0.w
        frc r1.x, r1.x
        mad r1.x, r1.x, c1.x, c1.y
        sincos r3.xy, r1.x
        mul r1.xyz, r2.yzww, r3.yyxw
        mad r2.x, r2.x, r3.x, -r1.x
        add r2.y, r1.z, r1.y
        mov r2.zw, c1.z
        mad r0, r2, c47, r0
        add r1.x, -r0.w, c16.w
        add r1.y, -c16.z, c16.w
        rcp r1.y, r1.y
        mul_sat r1.x, r1.x, r1.y
        add r1.x, -r1.x, c1.w
        mov r1.w, c1.w
        add r1.yz, -r1.w, c16.xxyw
        mad o3.zw, r1.x, r1.xyyz, c1.w
        rcp r1.x, c41.x
        mul_sat r1.x, r0.w, r1.x
        add r1.y, r0.w, -c41.x
        mov o0, r0
        add r0.x, -c41.x, c41.y
        rcp r0.x, r0.x
        mul_sat r0.x, r1.y, r0.x
        lrp r2.x, c41.w, r1.x, r0.x
        add o5.w, r2.x, c41.z
        mov r1.xyz, c43
        add r0.yzw, -r1.xxyz, c42.xxyz
        mad o5.xyz, r0.x, r0.yzww, c43
        mov o1.xyz, v2
        mov o2, v3
        mov o3.xy, v4
        mul o4, c1.wzzz, v5.z
        mov o6, v6
    
    // approximately 56 instruction slots used
};

VertexShader VS_TransformUnLitSoftVS
<
    string NearFarPlane    = "parameter register(128)";
    string gAspectRatio    = "parameter register(47)";
    string gBiasToCamera   = "parameter register(64)";
    string gDepthFxParams  = "parameter register(16)";
    string gScaleFade      = "parameter register(66)";
    string gSuperAlpha     = "parameter register(65)";
    string gViewInverse    = "parameter register(12)";
    string gWorldViewProj  = "parameter register(8)";
    string globalFogColor  = "parameter register(42)";
    string globalFogColorN = "parameter register(43)";
    string globalFogParams = "parameter register(41)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 NearFarPlane;
    //   float4 gAspectRatio;
    //   float gBiasToCamera;
    //   float4 gDepthFxParams;
    //   float gScaleFade;
    //   float gSuperAlpha;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //
    //
    // Registers:
    //
    //   Name            Reg   Size
    //   --------------- ----- ----
    //   gWorldViewProj  c8       4
    //   gViewInverse    c12      4
    //   gDepthFxParams  c16      1
    //   globalFogParams c41      1
    //   globalFogColor  c42      1
    //   globalFogColorN c43      1
    //   gAspectRatio    c47      1
    //   gBiasToCamera   c64      1
    //   gSuperAlpha     c65      1
    //   gScaleFade      c66      1
    //   NearFarPlane    c128     1
    //
    
        vs_3_0
        def c0, 0.100000001, 9.99999997e-007, 0.159154937, 0.5
        def c1, 6.28318548, -3.14159274, 0, 1
        dcl_position v0
        dcl_normal v1
        dcl_color v2
        dcl_texcoord v3
        dcl_texcoord1 v4
        dcl_texcoord2 v5
        dcl_texcoord3 v6
        dcl_position o0
        dcl_color o1
        dcl_texcoord o2
        dcl_texcoord1 o3
        dcl_texcoord2 o4
        dcl_texcoord3 o5
        dcl_texcoord4 o6
        mov r0.x, c0.x
        mul r0.x, r0.x, c64.x
        lrp r1.xyz, r0.x, c15, v0
        mul r0, r1.y, c9
        mad r0, r1.x, c8, r0
        mad r0, r1.z, c10, r0
        add r0, r0, c11
        add r1.x, r0.w, -c128.x
        rcp r1.y, c66.x
        mul_sat r1.x, r1.x, r1.y
        sge r1.y, c0.y, v2.w
        mad r1.x, r1.y, -r1.x, r1.x
        mul r1.y, r1.x, v2.w
        mul r2, r1.x, v1.xyxy
        mul_sat o1.w, r1.y, c65.x
        mad r1.x, v1.z, c0.z, c0.w
        frc r1.x, r1.x
        mad r1.x, r1.x, c1.x, c1.y
        sincos r3.xy, r1.x
        mul r1.xyz, r2.yzww, r3.yyxw
        mad r2.x, r2.x, r3.x, -r1.x
        add r2.y, r1.z, r1.y
        mov r2.zw, c1.z
        mad r1, r2, c47, r0
        mov o4.y, r0.w
        add r0.x, -r1.w, c16.w
        add r0.y, -c16.z, c16.w
        rcp r0.y, r0.y
        mul_sat r0.x, r0.x, r0.y
        add r0.x, -r0.x, c1.w
        mov r0.w, c1.w
        add r0.yz, -r0.w, c16.xxyw
        mad o3.zw, r0.x, r0.xyyz, c1.w
        rcp r0.x, c41.x
        mul_sat r0.x, r1.w, r0.x
        add r0.y, r1.w, -c41.x
        mov o0, r1
        add r0.z, -c41.x, c41.y
        rcp r0.z, r0.z
        mul_sat r0.y, r0.y, r0.z
        lrp r1.x, c41.w, r0.x, r0.y
        add o5.w, r1.x, c41.z
        mov r1.xyz, c43
        add r0.xzw, -r1.xyyz, c42.xyyz
        mad o5.xyz, r0.y, r0.xzww, c43
        mov o1.xyz, v2
        mov o2, v3
        mov o3.xy, v4
        mul o4.xzw, c1.wyzz, v5.z
        mov o6, v6
    
    // approximately 57 instruction slots used
};

VertexShader VS_TransformUnLitScreenSpaceVS
<
    string gDepthFxParams   = "parameter register(16)";
    string gSuperAlpha      = "parameter register(64)";
    string globalFogColor   = "parameter register(42)";
    string globalFogColorN  = "parameter register(43)";
    string globalFogParams  = "parameter register(41)";
    string globalScreenSize = "parameter register(44)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDepthFxParams;
    //   float gSuperAlpha;
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //   float4 globalScreenSize;
    //
    //
    // Registers:
    //
    //   Name             Reg   Size
    //   ---------------- ----- ----
    //   gDepthFxParams   c16      1
    //   globalFogParams  c41      1
    //   globalFogColor   c42      1
    //   globalFogColorN  c43      1
    //   globalScreenSize c44      1
    //   gSuperAlpha      c64      1
    //
    
        vs_3_0
        def c0, -1, 0.159154937, 0.5, 1
        def c1, 6.28318548, -3.14159274, 0, 1
        dcl_position v0
        dcl_normal v1
        dcl_color v2
        dcl_texcoord v3
        dcl_texcoord1 v4
        dcl_texcoord2 v5
        dcl_texcoord3 v6
        dcl_position o0
        dcl_color o1
        dcl_texcoord o2
        dcl_texcoord1 o3
        dcl_texcoord2 o4
        dcl_texcoord3 o5
        dcl_texcoord4 o6
        mad r0.x, v1.z, c0.y, c0.z
        frc r0.x, r0.x
        mad r0.x, r0.x, c1.x, c1.y
        sincos r1.xy, r0.x
        mul r0.xyz, r1.yyxw, v1.yxyw
        mad r1.x, v1.x, r1.x, -r0.x
        add r1.y, r0.z, r0.y
        rcp r0.x, c44.y
        mul r0.y, r0.x, c44.x
        mov r0.x, c0.w
        mul r0.xy, r1, r0
        add r0.z, c0.x, v1.w
        sge r0.z, -r0_abs.z, r0_abs.z
        mul r0.xy, r0, r0.z
        mov r0.z, c1.z
        mad o0.xyz, v0.xyxw, c1.wwzw, r0
        mul_sat o1.w, c64.x, v2.w
        add r0.x, -c16.z, c16.w
        rcp r0.x, r0.x
        mov r1.xw, c0
        add r0.yzw, r1.x, c16.xwxy
        mul_sat r0.x, r0.x, r0.y
        add r0.x, -r0.x, c0.w
        mad o3.zw, r0.x, r0, c0.w
        add r0.x, -c41.x, c41.y
        rcp r0.x, r0.x
        add r0.y, r1.w, -c41.x
        mul_sat r0.x, r0.x, r0.y
        rcp_sat r0.y, c41.x
        lrp r1.x, c41.w, r0.y, r0.x
        add o5.w, r1.x, c41.z
        mov r1.xyz, c43
        add r0.yzw, -r1.xxyz, c42.xxyz
        mad o5.xyz, r0.x, r0.yzww, c43
        mov o0.w, c0.w
        mov o1.xyz, v2
        mov o2, v3
        mov o3.xy, v4
        mul o4, c1.wzzz, v5.z
        mov o6, v6
    
    // approximately 47 instruction slots used
};

//Pixel shaders
PixelShader PixelShader0 = NULL;

PixelShader PS_Draw
<
    string DiffuseTexSampler = "parameter register(0)";
    string HybridAdd         = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D DiffuseTexSampler;
    //   float HybridAdd;
    //
    //
    // Registers:
    //
    //   Name              Reg   Size
    //   ----------------- ----- ----
    //   HybridAdd         c66      1
    //   DiffuseTexSampler s0       1
    //
    
        ps_3_0
        def c0, 0.5, 0.212500006, 0.715399981, 0.0720999986
        def c1, -1, 1, 0, 0
        dcl_color v0
        dcl_texcoord v1
        dcl_texcoord1 v2.zw
        dcl_texcoord3 v3
        dcl_texcoord4 v4.xy
        dcl_2d s0
        texld r0, v1, s0
        texld r1, v1.zwzw, s0
        lrp r2, c0.x, r1, r0
        mul r0, r2, v0
        mul r1.xyz, r0, v4.y
        dp3 r1.x, r1, c0.yzww
        mad r1.yzw, r0.xxyz, v4.y, -r1.x
        mov_sat r0.w, r0.w
        mad r1.yzw, v2.z, r1, r1.x
        add r2.x, c1.x, v2.w
        pow r3.x, r1_abs.x, r2.x
        mul r2.xyz, r1.yzww, r3.x
        mad r1.xyz, r1.yzww, -r3.x, v3
        mad r0.xyz, v3.w, r1, r2
        mul r1.xyz, r0.w, r0
        abs r2.x, c66.x
        add r2.y, c1.y, -v4.x
        mul r1.w, r0.w, r2.y
        cmp r0, -r2.x, r0, r1
        max oC0, r0, c1.z
    
    // approximately 22 instruction slots used (2 texture, 20 arithmetic)
};

PixelShader PS_DrawSoft
<
    string DepthMapTexSampler = "parameter register(12)";
    string DiffuseTexSampler  = "parameter register(0)";
    string HybridAdd          = "parameter register(72)";
    string gInvScreenSize     = "parameter register(129)";
    string gSoftness          = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D DepthMapTexSampler;
    //   sampler2D DiffuseTexSampler;
    //   float HybridAdd;
    //   float4 gInvScreenSize;
    //   float gSoftness;
    //
    //
    // Registers:
    //
    //   Name               Reg   Size
    //   ------------------ ----- ----
    //   gSoftness          c66      1
    //   HybridAdd          c72      1
    //   gInvScreenSize     c129     1
    //   DiffuseTexSampler  s0       1
    //   DepthMapTexSampler s12      1
    //
    
        ps_3_0
        def c0, 0.5, 0.212500006, 0.715399981, 0.0720999986
        def c1, -1, 1, 0, 0
        dcl_color v0
        dcl_texcoord v1
        dcl_texcoord1 v2.zw
        dcl_texcoord2 v3.y
        dcl_texcoord3 v4
        dcl_texcoord4 v5.xy
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s12
        mad r0.xy, vPos, c129, c129.zwzw
        texld r0, r0, s12
        add r0.x, r0.x, -v3.y
        mul r0.x, r0.x, r0.x
        mul_sat r0.x, r0.x, c66.x
        mul r0.w, r0.x, v0.w
        texld r1, v1, s0
        texld r2, v1.zwzw, s0
        lrp r3, c0.x, r2, r1
        mov r0.xyz, v0
        mul r0, r0, r3
        mul r1.xyz, r0, v5.y
        dp3 r1.x, r1, c0.yzww
        mad r1.yzw, r0.xxyz, v5.y, -r1.x
        mov_sat r0.w, r0.w
        mad r1.yzw, v2.z, r1, r1.x
        add r2.x, c1.x, v2.w
        pow r3.x, r1_abs.x, r2.x
        mul r2.xyz, r1.yzww, r3.x
        mad r1.xyz, r1.yzww, -r3.x, v4
        mad r0.xyz, v4.w, r1, r2
        mul r1.xyz, r0.w, r0
        add r2.x, c1.y, -v5.x
        mul r1.w, r0.w, r2.x
        abs r2.x, c72.x
        cmp r0, -r2.x, r0, r1
        max oC0, r0, c1.z
    
    // approximately 29 instruction slots used (3 texture, 26 arithmetic)
};

PixelShader PS_DrawUnLit
<
    string DiffuseTexSampler = "parameter register(0)";
    string HybridAdd         = "parameter register(66)";
    string globalScalars     = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D DiffuseTexSampler;
    //   float HybridAdd;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name              Reg   Size
    //   ----------------- ----- ----
    //   globalScalars     c39      1
    //   HybridAdd         c66      1
    //   DiffuseTexSampler s0       1
    //
    
        ps_3_0
        def c0, 0.5, 0.212500006, 0.715399981, 0.0720999986
        def c1, -1, 1, 0, 0
        dcl_color v0
        dcl_texcoord v1
        dcl_texcoord1 v2.zw
        dcl_texcoord3 v3
        dcl_texcoord4 v4.xy
        dcl_2d s0
        texld r0, v1, s0
        texld r1, v1.zwzw, s0
        lrp r2, c0.x, r1, r0
        mul r0, r2, v0
        mul r1.x, c39.y, v4.y
        mul r1.yzw, r0.xxyz, r1.x
        dp3 r1.y, r1.yzww, c0.yzww
        mad r1.xzw, r0.xyyz, r1.x, -r1.y
        mov_sat r0.w, r0.w
        mad r1.xzw, v2.z, r1, r1.y
        add r2.x, c1.x, v2.w
        pow r3.x, r1_abs.y, r2.x
        mul r2.xyz, r1.xzww, r3.x
        mad r1.xyz, r1.xzww, -r3.x, v3
        mad r0.xyz, v3.w, r1, r2
        mul r1.xyz, r0.w, r0
        abs r2.x, c66.x
        add r2.y, c1.y, -v4.x
        mul r1.w, r0.w, r2.y
        cmp r0, -r2.x, r0, r1
        max oC0, r0, c1.z
    
    // approximately 23 instruction slots used (2 texture, 21 arithmetic)
};

PixelShader PS_DrawSoftUnLit
<
    string DepthMapTexSampler = "parameter register(12)";
    string DiffuseTexSampler  = "parameter register(0)";
    string HybridAdd          = "parameter register(72)";
    string gInvScreenSize     = "parameter register(129)";
    string gSoftness          = "parameter register(66)";
    string globalScalars      = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D DepthMapTexSampler;
    //   sampler2D DiffuseTexSampler;
    //   float HybridAdd;
    //   float4 gInvScreenSize;
    //   float gSoftness;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name               Reg   Size
    //   ------------------ ----- ----
    //   globalScalars      c39      1
    //   gSoftness          c66      1
    //   HybridAdd          c72      1
    //   gInvScreenSize     c129     1
    //   DiffuseTexSampler  s0       1
    //   DepthMapTexSampler s12      1
    //
    
        ps_3_0
        def c0, 0.5, 0.212500006, 0.715399981, 0.0720999986
        def c1, -1, 1, 0, 0
        dcl_color v0
        dcl_texcoord v1
        dcl_texcoord1 v2.zw
        dcl_texcoord2 v3.y
        dcl_texcoord3 v4
        dcl_texcoord4 v5.xy
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s12
        mad r0.xy, vPos, c129, c129.zwzw
        texld r0, r0, s12
        add r0.x, r0.x, -v3.y
        mul r0.x, r0.x, r0.x
        mul_sat r0.x, r0.x, c66.x
        mul r0.w, r0.x, v0.w
        texld r1, v1, s0
        texld r2, v1.zwzw, s0
        lrp r3, c0.x, r2, r1
        mov r0.xyz, v0
        mul r0, r0, r3
        mul r1.x, c39.y, v5.y
        mul r1.yzw, r0.xxyz, r1.x
        dp3 r1.y, r1.yzww, c0.yzww
        mad r1.xzw, r0.xyyz, r1.x, -r1.y
        mov_sat r0.w, r0.w
        mad r1.xzw, v2.z, r1, r1.y
        add r2.x, c1.x, v2.w
        pow r3.x, r1_abs.y, r2.x
        mul r2.xyz, r1.xzww, r3.x
        mad r1.xyz, r1.xzww, -r3.x, v4
        mad r0.xyz, v4.w, r1, r2
        mul r1.xyz, r0.w, r0
        add r2.x, c1.y, -v5.x
        mul r1.w, r0.w, r2.x
        abs r2.x, c72.x
        cmp r0, -r2.x, r0, r1
        max oC0, r0, c1.z
    
    // approximately 30 instruction slots used (3 texture, 27 arithmetic)
};

technique draw_old
{
    pass p0
    {
        VertexShader = VS_TransformVertexLitVS;
        PixelShader = PS_Draw;
    }
}

technique draw
{
    pass p0
    {
        VertexShader = VS_TransformLitVS;
        PixelShader = PS_Draw;
    }
}

technique draw_soft
{
    pass p0
    {
        VertexShader = VS_TransformLitSoftVS;
        PixelShader = PS_DrawSoft;
    }
}

technique draw_screenspace
{
    pass p0
    {
        VertexShader = VS_TransformLitScreenSpaceVS;
        PixelShader = PS_Draw;
    }
}

technique unlit_draw
{
    pass p0
    {
        VertexShader = VS_TransformUnLitVS;
        PixelShader = PS_DrawUnLit;
    }
}

technique unlit_draw_soft
{
    pass p0
    {
        VertexShader = VS_TransformUnLitSoftVS;
        PixelShader = PS_DrawSoftUnLit;
    }
}

technique unlit_draw_screenspace
{
    pass p0
    {
        VertexShader = VS_TransformUnLitScreenSpaceVS;
        PixelShader = PS_DrawUnLit;
    }
}


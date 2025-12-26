#include "common_globals.fxh"

float shadowmap_res : ShadowMapResolution = 1280.0;
float4 dShadowParam0123 : dShadowParam0123;
float4 dShadowParam4567 : dShadowParam4567;
float4 dShadowParam891113 : dShadowParam891113;
float4 dShadowOffsetScale : dShadowOffsetScale;
row_major float4x4 dShadowMatrix : dShadowMatrix;
float3 LuminanceConstants : LuminanceConstants = float3(0.212500, 0.715400, 0.072100);
float gDeferredLightType : deferredLightType;
float3 gDeferredLightPosition : deferredLightPosition;
float3 gDeferredLightDirection : deferredLightDirection;
float3 gDeferredLightTangent : deferredLightTangent;
float gDeferredLightRadius : deferredLightRadius;
float gDeferredLightInvSqrRadius : deferredLightInvSqrRadius;
float gDeferredVolumeRadiusScale : deferredVolumeRadiusScale;
float gDeferredLightConeAngleI : deferredLightConeAngleI;
float gDeferredLightConeAngle : deferredLightConeAngle;
float gDeferredLightConeOffset : deferredLightConeOffset;
float gDeferredLightConeScale : deferredLightConeScale;
float4 gDeferredLightColourAndIntensity : deferredLightColourAndIntensity;
float4 gooDeferredLightScreenSize : deferredLightScreenSize;
float4 gDeferredProjParams : deferredProjectionParams;
float4 gDeferredLightShaftParams : deferredLightShaftParams;
float4 gDeferredLightVolumeParams : deferredLightVolumeParams;
float4x4 gDeferredInverseViewProjMatrix : deferredLightInverseViewProjMatrix;

texture deferredLightTexture;
sampler gDeferredLightSampler = 
sampler_state
{
    Texture = <deferredLightTexture>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipFilter = LINEAR;
};
texture deferredLightTexture1;
sampler gDeferredLightSampler1 = 
sampler_state
{
    Texture = <deferredLightTexture1>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipFilter = LINEAR;
};
texture deferredLightTexture2;
sampler gDeferredLightSampler2 = 
sampler_state
{
    Texture = <deferredLightTexture2>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipFilter = LINEAR;
};

texture gbufferTexture0;
sampler GBufferTextureSampler0 = 
sampler_state
{
    Texture = <gbufferTexture0>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
};
texture gbufferTexture1;
sampler GBufferTextureSampler1 = 
sampler_state
{
    Texture = <gbufferTexture1>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
};
texture gbufferTexture2;
sampler GBufferTextureSampler2 = 
sampler_state
{
    Texture = <gbufferTexture2>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
};
texture gbufferTexture3;
sampler GBufferTextureSampler3 = 
sampler_state
{
    Texture = <gbufferTexture3>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
};
texture gbufferStencilTexture;
sampler GBufferStencilTextureSampler = 
sampler_state
{
    Texture = <gbufferStencilTexture>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
};

float4 dReflectionParams : ReflectionParams = float4(0.00666666683, 0.0, 0.0, 0.0);
texture ParabTexture;
sampler ParabSampler = 
sampler_state
{
    Texture = <ParabTexture>;
    AddressU = WRAP;
    AddressV = WRAP;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
    MipFilter = LINEAR;
};
//unused
texture importanceBufferTexture;
sampler importanceBufferSampler = 
sampler_state
{
    Texture = <importanceBufferTexture>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
};
//unused
texture accumulationBufferTexture0;
sampler accumulationBufferSampler0 = 
sampler_state
{
    Texture = <accumulationBufferTexture0>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
};
//unused
texture accumulationBufferTexture1;
sampler accumulationBufferSampler1 = 
sampler_state
{
    Texture = <accumulationBufferTexture1>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
};

texture depthSourceTexture;
sampler depthSourceSampler = 
sampler_state
{
    Texture = <depthSourceTexture>;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
};

float2 poisson12[12] : poisson12 = 
{
    float2(-0.326212, -0.405810), 
    float2(-0.840144, -0.073580), 
    float2(-0.695914, 0.457137), 
    float2(-0.203345, 0.620716), 
    float2(0.962340, -0.194983), 
    float2(0.473434, -0.480026), 
    float2(0.519456, 0.767022), 
    float2(0.185461, -0.893124), 
    float2(0.507431, 0.064425), 
    float2(0.896420, 0.412458), 
    float2(-0.321940, -0.932615), 
    float2(-0.791559, -0.597710)
};
float2 vol_offsets[12] : vol_offsets = 
{
    float2(0.0, -0.700000), 
    float2(0.500000, 0.500000), 
    float2(-0.500000, 0.500000), 
    float2(1.0, -1.0), 
    float2(0.0, 1.500000), 
    float2(-1.0, -1.0), 
    float2(-4.0, 0.0), 
    float2(-2.500000, -3.0), 
    float2(2.500000, -3.0), 
    float2(4.0, 0.0), 
    float2(2.500000, 3.0), 
    float2(-2.500000, 3.0)
};
float4 debugLightColour : debugLightColour = float4(1.0, 1.0, 1.0, 1.0);

#define IS_DEFERRED_LIGHTING_SHADER
#define NO_SKINNING
#include "common_shadow.fxh"
#include "common_lighting.fxh"

//Vertex shaders
VertexShader VS_ScreenTransformS
<
    string gDeferredProjParams        = "parameter register(209)";
    string gViewInverse               = "parameter register(12)";
    string gooDeferredLightScreenSize = "parameter register(208)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDeferredProjParams;
    //   row_major float4x4 gViewInverse;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gViewInverse               c12      3
    //   gooDeferredLightScreenSize c208     1
    //   gDeferredProjParams        c209     1
    //
    
        vs_3_0
        def c0, -0.5, 1, -1, 0
        def c1, 2, 0, -1, 1
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2
        mad r0.xy, v0, c0.yzzw, c0.wyzw
        mov r1.x, c0.x
        mad o1.xy, c208.zwzw, -r1.x, r0
        add r0.xy, c0.x, v0
        add r0.xy, r0, r0
        mul r0.xy, r0, c209
        mul r0.yzw, -r0.y, c13.xxyz
        mad r0.xyz, -r0.x, c12, r0.yzww
        add o2.xyz, r0, c14
        mad o0, v0.xyxx, c1.xxyy, c1.zzyw
        mov o2.w, c0.y
    
    // approximately 11 instruction slots used
};

VertexShader VS_VolumeTransformPS0
<
    string gDeferredLightConeAngle    = "parameter register(215)";
    string gDeferredLightConeAngleI   = "parameter register(214)";
    string gDeferredLightDirection    = "parameter register(210)";
    string gDeferredLightPosition     = "parameter register(209)";
    string gDeferredLightRadius       = "parameter register(212)";
    string gDeferredLightTangent      = "parameter register(211)";
    string gDeferredLightType         = "parameter register(208)";
    string gDeferredVolumeRadiusScale = "parameter register(213)";
    string gWorldViewProj             = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float gDeferredLightConeAngle;
    //   float gDeferredLightConeAngleI;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
    //   float gDeferredVolumeRadiusScale;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gWorldViewProj             c8       4
    //   gDeferredLightType         c208     1
    //   gDeferredLightPosition     c209     1
    //   gDeferredLightDirection    c210     1
    //   gDeferredLightTangent      c211     1
    //   gDeferredLightRadius       c212     1
    //   gDeferredVolumeRadiusScale c213     1
    //   gDeferredLightConeAngleI   c214     1
    //   gDeferredLightConeAngle    c215     1
    //
    
        vs_3_0
        def c0, -4, 0.159154937, 0.5, 1
        def c1, 6.28318548, -3.14159274, -1.57079637, 1.57079637
        def c2, 9.99999975e-005, -2, 9.99999975e-006, 0.662
        dcl_position v0
        dcl_position o0
        mov r0.xyz, c210
        mul r1.xyz, r0.yzxw, c211.zxyw
        mad r0.xyz, c211.yzxw, r0.zxyw, -r1
        mov r1.xyz, c0
        add r0.w, r1.x, c208.x
        if_ge -r0_abs.w, r0_abs.w
          mad r0.w, c215.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r2.x, r0.w
          mad r0.w, c214.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r1.x, r0.w
          mad r0.w, v0.z, -c1.z, c1.w
          mad r0.w, r0.w, c0.y, c0.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r3.x, r0.w
          mad r0.w, r3.x, -r3.x, c0.w
          mul r1.yz, v0.xxyw, v0.xxyw
          add r1.y, r1.z, r1.y
          add r1.y, r1.y, c2.x
          rcp r1.y, r1.y
          mul r0.w, r0.w, r1.y
          rsq r0.w, r0.w
          rcp r0.w, r0.w
          sge r1.y, r2.x, r3.x
          mul r1.z, r0.w, c213.x
          mul r1.zw, r1.z, v0.xyxy
          mul r2.yzw, r0.xxyz, r1.w
          mad r2.yzw, c211.xxyz, r1.z, r2
          mad r3.yzw, c210.xxyz, r2.x, r2
          sge r1.z, r3.x, r1.x
          mad r2.xyz, c210, r1.x, r2.yzww
          mul r1.xw, r0.w, v0.xyzy
          mul r4.xyz, r0, r1.w
          mad r4.xyz, c211, r1.x, r4
          mad r4.xyz, c210, r3.x, r4
          lrp r5.xyz, r1.z, r2, r4
          lrp r2.xyz, r1.y, r3.yzww, r5
        else
          mov r1.y, c2.y
          add r0.w, r1.y, c208.x
          sge r0.w, -r0_abs.w, r0_abs.w
          mul r1.xy, v0, v0
          add r1.x, r1.y, r1.x
          sge r1.y, r1.x, c2.x
          mov_sat r1.z, -v0.z
          add r1.z, -r1.z, c0.w
          mul r1.z, r1.z, c215.x
          mad r1.z, r1.z, c0.y, c0.z
          frc r1.z, r1.z
          mad r1.z, r1.z, c1.x, c1.y
          sincos r3.x, r1.z
          mad r1.z, r3.x, -r3.x, c0.w
          add r1.x, r1.x, c2.x
          rcp r1.x, r1.x
          mul r1.x, r1.z, r1.x
          rsq r1.x, r1.x
          rcp r1.x, r1.x
          mul r1.x, r1.x, c213.x
          mul r1.xz, r1.x, v0.xyyw
          mul r0.xyz, r0, r1.z
          mad r0.xyz, c211, r1.x, r0
          mad r0.xyz, c210, r3.x, r0
          sge r1.x, v0_abs.z, c2.x
          mul r3.xyz, r1.x, c210
          mad r0.xyz, c210, -r1.x, r0
          mad r0.xyz, r1.y, r0, r3
          add r1.xyz, c2.z, v0
          dp3 r1.w, r1, r1
          rsq r1.w, r1.w
          mul r3.xyz, r1, r1.w
          mad r0.xyz, r1, -r1.w, r0
          mad r2.xyz, r0.w, r0, r3
        endif
        mov r0.x, c213.x
        mul r0.x, r0.x, c212.x
        mul r0.x, r0.x, c2.w
        mad r0.xyz, r2, r0.x, c209
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r0, r0.z, c10, r1
        add o0, r0, c11
    
    // approximately 115 instruction slots used
};

VertexShader VS_VolumeShadowTransformPS0
<
    string gDeferredLightConeAngle    = "parameter register(215)";
    string gDeferredLightConeAngleI   = "parameter register(214)";
    string gDeferredLightDirection    = "parameter register(210)";
    string gDeferredLightPosition     = "parameter register(209)";
    string gDeferredLightRadius       = "parameter register(212)";
    string gDeferredLightTangent      = "parameter register(211)";
    string gDeferredLightType         = "parameter register(208)";
    string gDeferredVolumeRadiusScale = "parameter register(213)";
    string gWorldViewProj             = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float gDeferredLightConeAngle;
    //   float gDeferredLightConeAngleI;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
    //   float gDeferredVolumeRadiusScale;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gWorldViewProj             c8       4
    //   gDeferredLightType         c208     1
    //   gDeferredLightPosition     c209     1
    //   gDeferredLightDirection    c210     1
    //   gDeferredLightTangent      c211     1
    //   gDeferredLightRadius       c212     1
    //   gDeferredVolumeRadiusScale c213     1
    //   gDeferredLightConeAngleI   c214     1
    //   gDeferredLightConeAngle    c215     1
    //
    
        vs_3_0
        def c0, -4, 0.159154937, 0.5, 1
        def c1, 6.28318548, -3.14159274, -1.57079637, 1.57079637
        def c2, 9.99999975e-005, -2, 9.99999975e-006, 0.662
        dcl_position v0
        dcl_position o0
        mov r0.xyz, c210
        mul r1.xyz, r0.yzxw, c211.zxyw
        mad r0.xyz, c211.yzxw, r0.zxyw, -r1
        mov r1.xyz, c0
        add r0.w, r1.x, c208.x
        if_ge -r0_abs.w, r0_abs.w
          mad r0.w, c215.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r2.x, r0.w
          mad r0.w, c214.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r1.x, r0.w
          mad r0.w, v0.z, -c1.z, c1.w
          mad r0.w, r0.w, c0.y, c0.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r3.x, r0.w
          mad r0.w, r3.x, -r3.x, c0.w
          mul r1.yz, v0.xxyw, v0.xxyw
          add r1.y, r1.z, r1.y
          add r1.y, r1.y, c2.x
          rcp r1.y, r1.y
          mul r0.w, r0.w, r1.y
          rsq r0.w, r0.w
          rcp r0.w, r0.w
          sge r1.y, r2.x, r3.x
          mul r1.z, r0.w, c213.x
          mul r1.zw, r1.z, v0.xyxy
          mul r2.yzw, r0.xxyz, r1.w
          mad r2.yzw, c211.xxyz, r1.z, r2
          mad r3.yzw, c210.xxyz, r2.x, r2
          sge r1.z, r3.x, r1.x
          mad r2.xyz, c210, r1.x, r2.yzww
          mul r1.xw, r0.w, v0.xyzy
          mul r4.xyz, r0, r1.w
          mad r4.xyz, c211, r1.x, r4
          mad r4.xyz, c210, r3.x, r4
          lrp r5.xyz, r1.z, r2, r4
          lrp r2.xyz, r1.y, r3.yzww, r5
        else
          mov r1.y, c2.y
          add r0.w, r1.y, c208.x
          sge r0.w, -r0_abs.w, r0_abs.w
          mul r1.xy, v0, v0
          add r1.x, r1.y, r1.x
          sge r1.y, r1.x, c2.x
          mov_sat r1.z, -v0.z
          add r1.z, -r1.z, c0.w
          mul r1.z, r1.z, c215.x
          mad r1.z, r1.z, c0.y, c0.z
          frc r1.z, r1.z
          mad r1.z, r1.z, c1.x, c1.y
          sincos r3.x, r1.z
          mad r1.z, r3.x, -r3.x, c0.w
          add r1.x, r1.x, c2.x
          rcp r1.x, r1.x
          mul r1.x, r1.z, r1.x
          rsq r1.x, r1.x
          rcp r1.x, r1.x
          mul r1.x, r1.x, c213.x
          mul r1.xz, r1.x, v0.xyyw
          mul r0.xyz, r0, r1.z
          mad r0.xyz, c211, r1.x, r0
          mad r0.xyz, c210, r3.x, r0
          sge r1.x, v0_abs.z, c2.x
          mul r3.xyz, r1.x, c210
          mad r0.xyz, c210, -r1.x, r0
          mad r0.xyz, r1.y, r0, r3
          add r1.xyz, c2.z, v0
          dp3 r1.w, r1, r1
          rsq r1.w, r1.w
          mul r3.xyz, r1, r1.w
          mad r0.xyz, r1, -r1.w, r0
          mad r2.xyz, r0.w, r0, r3
        endif
        mov r0.x, c213.x
        mul r0.x, r0.x, c212.x
        mul r0.x, r0.x, c2.w
        mad r0.xyz, r2, r0.x, c209
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r0, r0.z, c10, r1
        add o0, r0, c11
    
    // approximately 115 instruction slots used
};

struct VS_OutputVolumePS
{
    float4 Position                    : POSITION;
    float4 FragToViewDirAndDepth : TEXCOORD0;
};

VertexShader VS_VolumeTransformPS
<
    string gDeferredLightConeAngle    = "parameter register(215)";
    string gDeferredLightConeAngleI   = "parameter register(214)";
    string gDeferredLightDirection    = "parameter register(210)";
    string gDeferredLightPosition     = "parameter register(209)";
    string gDeferredLightRadius       = "parameter register(212)";
    string gDeferredLightTangent      = "parameter register(211)";
    string gDeferredLightType         = "parameter register(208)";
    string gDeferredVolumeRadiusScale = "parameter register(213)";
    string gViewInverse               = "parameter register(12)";
    string gWorldViewProj             = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float gDeferredLightConeAngle;
    //   float gDeferredLightConeAngleI;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
    //   float gDeferredVolumeRadiusScale;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gWorldViewProj             c8       4
    //   gViewInverse               c12      4
    //   gDeferredLightType         c208     1
    //   gDeferredLightPosition     c209     1
    //   gDeferredLightDirection    c210     1
    //   gDeferredLightTangent      c211     1
    //   gDeferredLightRadius       c212     1
    //   gDeferredVolumeRadiusScale c213     1
    //   gDeferredLightConeAngleI   c214     1
    //   gDeferredLightConeAngle    c215     1
    //
    
        vs_3_0
        def c0, -4, 0.159154937, 0.5, 1
        def c1, 6.28318548, -3.14159274, -1.57079637, 1.57079637
        def c2, 9.99999975e-005, -2, 9.99999975e-006, 0.662
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1
        mov r0.xyz, c210
        mul r1.xyz, r0.yzxw, c211.zxyw
        mad r0.xyz, c211.yzxw, r0.zxyw, -r1
        mov r1.xyz, c0
        add r0.w, r1.x, c208.x
        if_ge -r0_abs.w, r0_abs.w
          mad r0.w, c215.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r2.x, r0.w
          mad r0.w, c214.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r1.x, r0.w
          mad r0.w, v0.z, -c1.z, c1.w
          mad r0.w, r0.w, c0.y, c0.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r3.x, r0.w
          mad r0.w, r3.x, -r3.x, c0.w
          mul r1.yz, v0.xxyw, v0.xxyw
          add r1.y, r1.z, r1.y
          add r1.y, r1.y, c2.x
          rcp r1.y, r1.y
          mul r0.w, r0.w, r1.y
          rsq r0.w, r0.w
          rcp r0.w, r0.w
          sge r1.y, r2.x, r3.x
          mul r1.z, r0.w, c213.x
          mul r1.zw, r1.z, v0.xyxy
          mul r2.yzw, r0.xxyz, r1.w
          mad r2.yzw, c211.xxyz, r1.z, r2
          mad r3.yzw, c210.xxyz, r2.x, r2
          sge r1.z, r3.x, r1.x
          mad r2.xyz, c210, r1.x, r2.yzww
          mul r1.xw, r0.w, v0.xyzy
          mul r4.xyz, r0, r1.w
          mad r4.xyz, c211, r1.x, r4
          mad r4.xyz, c210, r3.x, r4
          lrp r5.xyz, r1.z, r2, r4
          lrp r2.xyz, r1.y, r3.yzww, r5
        else
          mov r1.y, c2.y
          add r0.w, r1.y, c208.x
          sge r0.w, -r0_abs.w, r0_abs.w
          mul r1.xy, v0, v0
          add r1.x, r1.y, r1.x
          sge r1.y, r1.x, c2.x
          mov_sat r1.z, -v0.z
          add r1.z, -r1.z, c0.w
          mul r1.z, r1.z, c215.x
          mad r1.z, r1.z, c0.y, c0.z
          frc r1.z, r1.z
          mad r1.z, r1.z, c1.x, c1.y
          sincos r3.x, r1.z
          mad r1.z, r3.x, -r3.x, c0.w
          add r1.x, r1.x, c2.x
          rcp r1.x, r1.x
          mul r1.x, r1.z, r1.x
          rsq r1.x, r1.x
          rcp r1.x, r1.x
          mul r1.x, r1.x, c213.x
          mul r1.xz, r1.x, v0.xyyw
          mul r0.xyz, r0, r1.z
          mad r0.xyz, c211, r1.x, r0
          mad r0.xyz, c210, r3.x, r0
          sge r1.x, v0_abs.z, c2.x
          mul r3.xyz, r1.x, c210
          mad r0.xyz, c210, -r1.x, r0
          mad r0.xyz, r1.y, r0, r3
          add r1.xyz, c2.z, v0
          dp3 r1.w, r1, r1
          rsq r1.w, r1.w
          mul r3.xyz, r1, r1.w
          mad r0.xyz, r1, -r1.w, r0
          mad r2.xyz, r0.w, r0, r3
        endif
        mov r0.x, c213.x
        mul r0.x, r0.x, c212.x
        mul r0.x, r0.x, c2.w
        mad r0.xyz, r2, r0.x, c209
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r1, r0.z, c10, r1
        add r1, r1, c11
        add r0.xyz, r0, -c15
        mov o1.xyz, -r0
        mov o0, r1
        mov o1.w, r1.w
    
    // approximately 119 instruction slots used
};

VertexShader VS_VolumeTransformPSC
<
    string gDeferredLightConeAngle    = "parameter register(215)";
    string gDeferredLightConeAngleI   = "parameter register(214)";
    string gDeferredLightDirection    = "parameter register(210)";
    string gDeferredLightPosition     = "parameter register(209)";
    string gDeferredLightRadius       = "parameter register(212)";
    string gDeferredLightTangent      = "parameter register(211)";
    string gDeferredLightType         = "parameter register(208)";
    string gDeferredVolumeRadiusScale = "parameter register(213)";
    string gWorldViewProj             = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float gDeferredLightConeAngle;
    //   float gDeferredLightConeAngleI;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
    //   float gDeferredVolumeRadiusScale;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gWorldViewProj             c8       4
    //   gDeferredLightType         c208     1
    //   gDeferredLightPosition     c209     1
    //   gDeferredLightDirection    c210     1
    //   gDeferredLightTangent      c211     1
    //   gDeferredLightRadius       c212     1
    //   gDeferredVolumeRadiusScale c213     1
    //   gDeferredLightConeAngleI   c214     1
    //   gDeferredLightConeAngle    c215     1
    //
    
        vs_3_0
        def c0, -4, 0.159154937, 0.5, 1
        def c1, 6.28318548, -3.14159274, -1.57079637, 1.57079637
        def c2, 9.99999975e-005, -2, 9.99999975e-006, 0.662
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1
        mov r0.xyz, c210
        mul r1.xyz, r0.yzxw, c211.zxyw
        mad r0.xyz, c211.yzxw, r0.zxyw, -r1
        mov r1.xyz, c0
        add r0.w, r1.x, c208.x
        if_ge -r0_abs.w, r0_abs.w
          mad r0.w, c215.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r2.x, r0.w
          mad r0.w, c214.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r1.x, r0.w
          mad r0.w, v0.z, -c1.z, c1.w
          mad r0.w, r0.w, c0.y, c0.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r3.x, r0.w
          mad r0.w, r3.x, -r3.x, c0.w
          mul r1.yz, v0.xxyw, v0.xxyw
          add r1.y, r1.z, r1.y
          add r1.y, r1.y, c2.x
          rcp r1.y, r1.y
          mul r0.w, r0.w, r1.y
          rsq r0.w, r0.w
          rcp r0.w, r0.w
          sge r1.y, r2.x, r3.x
          mul r1.z, r0.w, c213.x
          mul r1.zw, r1.z, v0.xyxy
          mul r2.yzw, r0.xxyz, r1.w
          mad r2.yzw, c211.xxyz, r1.z, r2
          mad r3.yzw, c210.xxyz, r2.x, r2
          sge r1.z, r3.x, r1.x
          mad r2.xyz, c210, r1.x, r2.yzww
          mul r1.xw, r0.w, v0.xyzy
          mul r4.xyz, r0, r1.w
          mad r4.xyz, c211, r1.x, r4
          mad r4.xyz, c210, r3.x, r4
          lrp r5.xyz, r1.z, r2, r4
          lrp r2.xyz, r1.y, r3.yzww, r5
        else
          mov r1.y, c2.y
          add r0.w, r1.y, c208.x
          sge r0.w, -r0_abs.w, r0_abs.w
          mul r1.xy, v0, v0
          add r1.x, r1.y, r1.x
          sge r1.y, r1.x, c2.x
          mov_sat r1.z, -v0.z
          add r1.z, -r1.z, c0.w
          mul r1.z, r1.z, c215.x
          mad r1.z, r1.z, c0.y, c0.z
          frc r1.z, r1.z
          mad r1.z, r1.z, c1.x, c1.y
          sincos r3.x, r1.z
          mad r1.z, r3.x, -r3.x, c0.w
          add r1.x, r1.x, c2.x
          rcp r1.x, r1.x
          mul r1.x, r1.z, r1.x
          rsq r1.x, r1.x
          rcp r1.x, r1.x
          mul r1.x, r1.x, c213.x
          mul r1.xz, r1.x, v0.xyyw
          mul r0.xyz, r0, r1.z
          mad r0.xyz, c211, r1.x, r0
          mad r0.xyz, c210, r3.x, r0
          sge r1.x, v0_abs.z, c2.x
          mul r3.xyz, r1.x, c210
          mad r0.xyz, c210, -r1.x, r0
          mad r0.xyz, r1.y, r0, r3
          add r1.xyz, c2.z, v0
          dp3 r1.w, r1, r1
          rsq r1.w, r1.w
          mul r3.xyz, r1, r1.w
          mad r0.xyz, r1, -r1.w, r0
          mad r2.xyz, r0.w, r0, r3
        endif
        mov r0.x, c213.x
        mul r0.x, r0.x, c212.x
        mul r0.x, r0.x, c2.w
        mad r0.xyz, r2, r0.x, c209
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r0, r0.z, c10, r1
        add o0, r0, c11
        mov o1, c0.w
    
    // approximately 116 instruction slots used
};

VertexShader VS_VolumeShadowTransformPSC
<
    string gDeferredLightConeAngle    = "parameter register(215)";
    string gDeferredLightConeAngleI   = "parameter register(214)";
    string gDeferredLightDirection    = "parameter register(210)";
    string gDeferredLightPosition     = "parameter register(209)";
    string gDeferredLightRadius       = "parameter register(212)";
    string gDeferredLightTangent      = "parameter register(211)";
    string gDeferredLightType         = "parameter register(208)";
    string gDeferredVolumeRadiusScale = "parameter register(213)";
    string gWorldViewProj             = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float gDeferredLightConeAngle;
    //   float gDeferredLightConeAngleI;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
    //   float gDeferredVolumeRadiusScale;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gWorldViewProj             c8       4
    //   gDeferredLightType         c208     1
    //   gDeferredLightPosition     c209     1
    //   gDeferredLightDirection    c210     1
    //   gDeferredLightTangent      c211     1
    //   gDeferredLightRadius       c212     1
    //   gDeferredVolumeRadiusScale c213     1
    //   gDeferredLightConeAngleI   c214     1
    //   gDeferredLightConeAngle    c215     1
    //
    
        vs_3_0
        def c0, -4, 0.159154937, 0.5, 1
        def c1, 6.28318548, -3.14159274, -1.57079637, 1.57079637
        def c2, 9.99999975e-005, -2, 9.99999975e-006, 0.662
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1
        mov r0.xyz, c210
        mul r1.xyz, r0.yzxw, c211.zxyw
        mad r0.xyz, c211.yzxw, r0.zxyw, -r1
        mov r1.xyz, c0
        add r0.w, r1.x, c208.x
        if_ge -r0_abs.w, r0_abs.w
          mad r0.w, c215.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r2.x, r0.w
          mad r0.w, c214.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r1.x, r0.w
          mad r0.w, v0.z, -c1.z, c1.w
          mad r0.w, r0.w, c0.y, c0.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r3.x, r0.w
          mad r0.w, r3.x, -r3.x, c0.w
          mul r1.yz, v0.xxyw, v0.xxyw
          add r1.y, r1.z, r1.y
          add r1.y, r1.y, c2.x
          rcp r1.y, r1.y
          mul r0.w, r0.w, r1.y
          rsq r0.w, r0.w
          rcp r0.w, r0.w
          sge r1.y, r2.x, r3.x
          mul r1.z, r0.w, c213.x
          mul r1.zw, r1.z, v0.xyxy
          mul r2.yzw, r0.xxyz, r1.w
          mad r2.yzw, c211.xxyz, r1.z, r2
          mad r3.yzw, c210.xxyz, r2.x, r2
          sge r1.z, r3.x, r1.x
          mad r2.xyz, c210, r1.x, r2.yzww
          mul r1.xw, r0.w, v0.xyzy
          mul r4.xyz, r0, r1.w
          mad r4.xyz, c211, r1.x, r4
          mad r4.xyz, c210, r3.x, r4
          lrp r5.xyz, r1.z, r2, r4
          lrp r2.xyz, r1.y, r3.yzww, r5
        else
          mov r1.y, c2.y
          add r0.w, r1.y, c208.x
          sge r0.w, -r0_abs.w, r0_abs.w
          mul r1.xy, v0, v0
          add r1.x, r1.y, r1.x
          sge r1.y, r1.x, c2.x
          mov_sat r1.z, -v0.z
          add r1.z, -r1.z, c0.w
          mul r1.z, r1.z, c215.x
          mad r1.z, r1.z, c0.y, c0.z
          frc r1.z, r1.z
          mad r1.z, r1.z, c1.x, c1.y
          sincos r3.x, r1.z
          mad r1.z, r3.x, -r3.x, c0.w
          add r1.x, r1.x, c2.x
          rcp r1.x, r1.x
          mul r1.x, r1.z, r1.x
          rsq r1.x, r1.x
          rcp r1.x, r1.x
          mul r1.x, r1.x, c213.x
          mul r1.xz, r1.x, v0.xyyw
          mul r0.xyz, r0, r1.z
          mad r0.xyz, c211, r1.x, r0
          mad r0.xyz, c210, r3.x, r0
          sge r1.x, v0_abs.z, c2.x
          mul r3.xyz, r1.x, c210
          mad r0.xyz, c210, -r1.x, r0
          mad r0.xyz, r1.y, r0, r3
          add r1.xyz, c2.z, v0
          dp3 r1.w, r1, r1
          rsq r1.w, r1.w
          mul r3.xyz, r1, r1.w
          mad r0.xyz, r1, -r1.w, r0
          mad r2.xyz, r0.w, r0, r3
        endif
        mov r0.x, c213.x
        mul r0.x, r0.x, c212.x
        mul r0.x, r0.x, c2.w
        mad r0.xyz, r2, r0.x, c209
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r0, r0.z, c10, r1
        add o0, r0, c11
        mov o1, c0.w
    
    // approximately 116 instruction slots used
};

VertexShader VS_VolumeShadowTransformPS
<
    string gDeferredLightConeAngle    = "parameter register(215)";
    string gDeferredLightConeAngleI   = "parameter register(214)";
    string gDeferredLightDirection    = "parameter register(210)";
    string gDeferredLightPosition     = "parameter register(209)";
    string gDeferredLightRadius       = "parameter register(212)";
    string gDeferredLightTangent      = "parameter register(211)";
    string gDeferredLightType         = "parameter register(208)";
    string gDeferredVolumeRadiusScale = "parameter register(213)";
    string gViewInverse               = "parameter register(12)";
    string gWorldViewProj             = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float gDeferredLightConeAngle;
    //   float gDeferredLightConeAngleI;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
    //   float gDeferredVolumeRadiusScale;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gWorldViewProj             c8       4
    //   gViewInverse               c12      4
    //   gDeferredLightType         c208     1
    //   gDeferredLightPosition     c209     1
    //   gDeferredLightDirection    c210     1
    //   gDeferredLightTangent      c211     1
    //   gDeferredLightRadius       c212     1
    //   gDeferredVolumeRadiusScale c213     1
    //   gDeferredLightConeAngleI   c214     1
    //   gDeferredLightConeAngle    c215     1
    //
    
        vs_3_0
        def c0, -4, 0.159154937, 0.5, 1
        def c1, 6.28318548, -3.14159274, -1.57079637, 1.57079637
        def c2, 9.99999975e-005, -2, 9.99999975e-006, 0.662
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1
        mov r0.xyz, c210
        mul r1.xyz, r0.yzxw, c211.zxyw
        mad r0.xyz, c211.yzxw, r0.zxyw, -r1
        mov r1.xyz, c0
        add r0.w, r1.x, c208.x
        if_ge -r0_abs.w, r0_abs.w
          mad r0.w, c215.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r2.x, r0.w
          mad r0.w, c214.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r1.x, r0.w
          mad r0.w, v0.z, -c1.z, c1.w
          mad r0.w, r0.w, c0.y, c0.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r3.x, r0.w
          mad r0.w, r3.x, -r3.x, c0.w
          mul r1.yz, v0.xxyw, v0.xxyw
          add r1.y, r1.z, r1.y
          add r1.y, r1.y, c2.x
          rcp r1.y, r1.y
          mul r0.w, r0.w, r1.y
          rsq r0.w, r0.w
          rcp r0.w, r0.w
          sge r1.y, r2.x, r3.x
          mul r1.z, r0.w, c213.x
          mul r1.zw, r1.z, v0.xyxy
          mul r2.yzw, r0.xxyz, r1.w
          mad r2.yzw, c211.xxyz, r1.z, r2
          mad r3.yzw, c210.xxyz, r2.x, r2
          sge r1.z, r3.x, r1.x
          mad r2.xyz, c210, r1.x, r2.yzww
          mul r1.xw, r0.w, v0.xyzy
          mul r4.xyz, r0, r1.w
          mad r4.xyz, c211, r1.x, r4
          mad r4.xyz, c210, r3.x, r4
          lrp r5.xyz, r1.z, r2, r4
          lrp r2.xyz, r1.y, r3.yzww, r5
        else
          mov r1.y, c2.y
          add r0.w, r1.y, c208.x
          sge r0.w, -r0_abs.w, r0_abs.w
          mul r1.xy, v0, v0
          add r1.x, r1.y, r1.x
          sge r1.y, r1.x, c2.x
          mov_sat r1.z, -v0.z
          add r1.z, -r1.z, c0.w
          mul r1.z, r1.z, c215.x
          mad r1.z, r1.z, c0.y, c0.z
          frc r1.z, r1.z
          mad r1.z, r1.z, c1.x, c1.y
          sincos r3.x, r1.z
          mad r1.z, r3.x, -r3.x, c0.w
          add r1.x, r1.x, c2.x
          rcp r1.x, r1.x
          mul r1.x, r1.z, r1.x
          rsq r1.x, r1.x
          rcp r1.x, r1.x
          mul r1.x, r1.x, c213.x
          mul r1.xz, r1.x, v0.xyyw
          mul r0.xyz, r0, r1.z
          mad r0.xyz, c211, r1.x, r0
          mad r0.xyz, c210, r3.x, r0
          sge r1.x, v0_abs.z, c2.x
          mul r3.xyz, r1.x, c210
          mad r0.xyz, c210, -r1.x, r0
          mad r0.xyz, r1.y, r0, r3
          add r1.xyz, c2.z, v0
          dp3 r1.w, r1, r1
          rsq r1.w, r1.w
          mul r3.xyz, r1, r1.w
          mad r0.xyz, r1, -r1.w, r0
          mad r2.xyz, r0.w, r0, r3
        endif
        mov r0.x, c213.x
        mul r0.x, r0.x, c212.x
        mul r0.x, r0.x, c2.w
        mad r0.xyz, r2, r0.x, c209
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r1, r0.z, c10, r1
        add r1, r1, c11
        add r0.xyz, r0, -c15
        mov o1.xyz, -r0
        mov o0, r1
        mov o1.w, r1.w
    
    // approximately 119 instruction slots used
};

VertexShader VS_ShaftTransformPointSpot
<
    string gDeferredLightColourAndIntensity = "parameter register(216)";
    string gDeferredLightConeAngle          = "parameter register(215)";
    string gDeferredLightConeAngleI         = "parameter register(214)";
    string gDeferredLightDirection          = "parameter register(210)";
    string gDeferredLightPosition           = "parameter register(209)";
    string gDeferredLightRadius             = "parameter register(212)";
    string gDeferredLightTangent            = "parameter register(211)";
    string gDeferredLightType               = "parameter register(208)";
    string gDeferredLightVolumeParams       = "parameter register(217)";
    string gDeferredVolumeRadiusScale       = "parameter register(213)";
    string gViewInverse                     = "parameter register(12)";
    string gWorldViewProj                   = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeAngle;
    //   float gDeferredLightConeAngleI;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
    //   float4 gDeferredLightVolumeParams;
    //   float gDeferredVolumeRadiusScale;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gWorldViewProj                   c8       4
    //   gViewInverse                     c12      4
    //   gDeferredLightType               c208     1
    //   gDeferredLightPosition           c209     1
    //   gDeferredLightDirection          c210     1
    //   gDeferredLightTangent            c211     1
    //   gDeferredLightRadius             c212     1
    //   gDeferredVolumeRadiusScale       c213     1
    //   gDeferredLightConeAngleI         c214     1
    //   gDeferredLightConeAngle          c215     1
    //   gDeferredLightColourAndIntensity c216     1
    //   gDeferredLightVolumeParams       c217     1
    //
    
        vs_3_0
        def c0, -4, 0.159154937, 0.5, 1
        def c1, 6.28318548, -3.14159274, -1.57079637, 1.57079637
        def c2, 9.99999975e-005, -2, 9.99999975e-006, 0.662
        def c3, 0.25, 0, 0, 0
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1
        dcl_texcoord1 o2.xyz
        dcl_texcoord2 o3.xyz
        mov r0.xyz, c210
        mul r1.xyz, r0.yzxw, c211.zxyw
        mad r0.xyz, c211.yzxw, r0.zxyw, -r1
        mov r1.xyz, c0
        add r0.w, r1.x, c208.x
        if_ge -r0_abs.w, r0_abs.w
          mad r0.w, c215.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r2.x, r0.w
          mad r0.w, c214.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r1.x, r0.w
          mad r0.w, v0.z, -c1.z, c1.w
          mad r0.w, r0.w, c0.y, c0.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r3.x, r0.w
          mad r0.w, r3.x, -r3.x, c0.w
          mul r1.yz, v0.xxyw, v0.xxyw
          add r1.y, r1.z, r1.y
          add r1.y, r1.y, c2.x
          rcp r1.y, r1.y
          mul r0.w, r0.w, r1.y
          rsq r0.w, r0.w
          rcp r0.w, r0.w
          sge r1.y, r2.x, r3.x
          mul r1.z, r0.w, c213.x
          mul r1.zw, r1.z, v0.xyxy
          mul r2.yzw, r0.xxyz, r1.w
          mad r2.yzw, c211.xxyz, r1.z, r2
          mad r3.yzw, c210.xxyz, r2.x, r2
          sge r1.z, r3.x, r1.x
          mad r2.xyz, c210, r1.x, r2.yzww
          mul r1.xw, r0.w, v0.xyzy
          mul r4.xyz, r0, r1.w
          mad r4.xyz, c211, r1.x, r4
          mad r4.xyz, c210, r3.x, r4
          lrp r5.xyz, r1.z, r2, r4
          lrp r2.xyz, r1.y, r3.yzww, r5
        else
          mov r1.y, c2.y
          add r0.w, r1.y, c208.x
          sge r0.w, -r0_abs.w, r0_abs.w
          mul r1.xy, v0, v0
          add r1.x, r1.y, r1.x
          sge r1.y, r1.x, c2.x
          mov_sat r1.z, -v0.z
          add r1.z, -r1.z, c0.w
          mul r1.z, r1.z, c215.x
          mad r1.z, r1.z, c0.y, c0.z
          frc r1.z, r1.z
          mad r1.z, r1.z, c1.x, c1.y
          sincos r3.x, r1.z
          mad r1.z, r3.x, -r3.x, c0.w
          add r1.x, r1.x, c2.x
          rcp r1.x, r1.x
          mul r1.x, r1.z, r1.x
          rsq r1.x, r1.x
          rcp r1.x, r1.x
          mul r1.x, r1.x, c213.x
          mul r1.xz, r1.x, v0.xyyw
          mul r0.xyz, r0, r1.z
          mad r0.xyz, c211, r1.x, r0
          mad r0.xyz, c210, r3.x, r0
          sge r1.x, v0_abs.z, c2.x
          mul r3.xyz, r1.x, c210
          mad r0.xyz, c210, -r1.x, r0
          mad r0.xyz, r1.y, r0, r3
          add r1.xyz, c2.z, v0
          dp3 r1.w, r1, r1
          rsq r1.w, r1.w
          mul r3.xyz, r1, r1.w
          mad r0.xyz, r1, -r1.w, r0
          mad r2.xyz, r0.w, r0, r3
        endif
        mov r0.x, c213.x
        mul r0.x, r0.x, c212.x
        mul r0.x, r0.x, c2.w
        mad r0.xyz, r2, r0.x, c209
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r1, r0.z, c10, r1
        add r1, r1, c11
        add o2.xyz, r0, -c15
        mov r0.xyz, c15
        add o1.xyz, r0, -c209
        mov r0.w, c216.w
        mul r0.x, r0.w, c217.x
        mul r0.x, r0.x, c3.x
        mul o3.xyz, r0.x, c216
        mov o0, r1
        mov o1.w, r1.w
    
    // approximately 124 instruction slots used
};

VertexShader VS_ShaftShadowTransformPointSpot
<
    string dShadowMatrix                    = "parameter register(208)";
    string dShadowOffsetScale               = "parameter register(214)";
    string dShadowParam0123                 = "parameter register(212)";
    string dShadowParam891113               = "parameter register(213)";
    string gDeferredLightColourAndIntensity = "parameter register(223)";
    string gDeferredLightConeAngle          = "parameter register(222)";
    string gDeferredLightConeAngleI         = "parameter register(221)";
    string gDeferredLightDirection          = "parameter register(217)";
    string gDeferredLightPosition           = "parameter register(216)";
    string gDeferredLightRadius             = "parameter register(219)";
    string gDeferredLightSampler2           = "parameter register(0)";
    string gDeferredLightTangent            = "parameter register(218)";
    string gDeferredLightType               = "parameter register(215)";
    string gDeferredLightVolumeParams       = "parameter register(224)";
    string gDeferredVolumeRadiusScale       = "parameter register(220)";
    string gViewInverse                     = "parameter register(12)";
    string gWorldViewProj                   = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   row_major float4x4 dShadowMatrix;
    //   float4 dShadowOffsetScale;
    //   float4 dShadowParam0123;
    //   float4 dShadowParam891113;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeAngle;
    //   float gDeferredLightConeAngleI;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   sampler2D gDeferredLightSampler2;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
    //   float4 gDeferredLightVolumeParams;
    //   float gDeferredVolumeRadiusScale;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gWorldViewProj                   c8       4
    //   gViewInverse                     c12      4
    //   dShadowMatrix                    c208     4
    //   dShadowParam0123                 c212     1
    //   dShadowParam891113               c213     1
    //   dShadowOffsetScale               c214     1
    //   gDeferredLightType               c215     1
    //   gDeferredLightPosition           c216     1
    //   gDeferredLightDirection          c217     1
    //   gDeferredLightTangent            c218     1
    //   gDeferredLightRadius             c219     1
    //   gDeferredVolumeRadiusScale       c220     1
    //   gDeferredLightConeAngleI         c221     1
    //   gDeferredLightConeAngle          c222     1
    //   gDeferredLightColourAndIntensity c223     1
    //   gDeferredLightVolumeParams       c224     1
    //   gDeferredLightSampler2           s0       1
    //
    
        vs_3_0
        def c0, -4, 0.159154937, 0.5, 1
        def c1, 6.28318548, -3.14159274, -1.57079637, 1.57079637
        def c2, 9.99999975e-005, -2, 9.99999975e-006, 0.662
        def c3, 0, -1, 1, 0.000244140625
        def c4, 0.5, -0.5, 0.25, 0
        dcl_position v0
        dcl_2d s0
        dcl_position o0
        dcl_texcoord o1
        dcl_texcoord1 o2.xyz
        dcl_texcoord2 o3.xyz
        mov r0.xyz, c217
        mul r1.xyz, r0.yzxw, c218.zxyw
        mad r0.xyz, c218.yzxw, r0.zxyw, -r1
        mov r1.xyz, c0
        add r0.w, r1.x, c215.x
        if_ge -r0_abs.w, r0_abs.w
          mad r0.w, c222.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r2.x, r0.w
          mad r0.w, c221.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r1.x, r0.w
          mad r0.w, v0.z, -c1.z, c1.w
          mad r0.w, r0.w, c0.y, c0.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r3.x, r0.w
          mad r0.w, r3.x, -r3.x, c0.w
          mul r1.yz, v0.xxyw, v0.xxyw
          add r1.y, r1.z, r1.y
          add r1.y, r1.y, c2.x
          rcp r1.y, r1.y
          mul r0.w, r0.w, r1.y
          rsq r0.w, r0.w
          rcp r0.w, r0.w
          sge r1.y, r2.x, r3.x
          mul r1.z, r0.w, c220.x
          mul r1.zw, r1.z, v0.xyxy
          mul r2.yzw, r0.xxyz, r1.w
          mad r2.yzw, c218.xxyz, r1.z, r2
          mad r3.yzw, c217.xxyz, r2.x, r2
          sge r1.z, r3.x, r1.x
          mad r2.xyz, c217, r1.x, r2.yzww
          mul r1.xw, r0.w, v0.xyzy
          mul r4.xyz, r0, r1.w
          mad r4.xyz, c218, r1.x, r4
          mad r4.xyz, c217, r3.x, r4
          lrp r5.xyz, r1.z, r2, r4
          lrp r2.xyz, r1.y, r3.yzww, r5
        else
          mov r1.y, c2.y
          add r0.w, r1.y, c215.x
          sge r0.w, -r0_abs.w, r0_abs.w
          mul r1.xy, v0, v0
          add r1.x, r1.y, r1.x
          sge r1.y, r1.x, c2.x
          mov_sat r1.z, -v0.z
          add r1.z, -r1.z, c0.w
          mul r1.z, r1.z, c222.x
          mad r1.z, r1.z, c0.y, c0.z
          frc r1.z, r1.z
          mad r1.z, r1.z, c1.x, c1.y
          sincos r3.x, r1.z
          mad r1.z, r3.x, -r3.x, c0.w
          add r1.x, r1.x, c2.x
          rcp r1.x, r1.x
          mul r1.x, r1.z, r1.x
          rsq r1.x, r1.x
          rcp r1.x, r1.x
          mul r1.x, r1.x, c220.x
          mul r1.xz, r1.x, v0.xyyw
          mul r0.xyz, r0, r1.z
          mad r0.xyz, c218, r1.x, r0
          mad r0.xyz, c217, r3.x, r0
          sge r1.x, v0_abs.z, c2.x
          mul r3.xyz, r1.x, c217
          mad r0.xyz, c217, -r1.x, r0
          mad r0.xyz, r1.y, r0, r3
          add r1.xyz, c2.z, v0
          dp3 r1.w, r1, r1
          rsq r1.w, r1.w
          mul r3.xyz, r1, r1.w
          mad r0.xyz, r1, -r1.w, r0
          mad r2.xyz, r0.w, r0, r3
        endif
        mov r0.x, c220.x
        mul r0.x, r0.x, c219.x
        mul r0.x, r0.x, c2.w
        mul r0.yzw, r2.xxyz, r0.x
        mad r1.xyz, r2, r0.x, c216
        mul r2.xyz, r1.y, c209
        mad r1.xyw, r1.x, c208.xyzz, r2.xyzz
        mad r1.xyz, r1.z, c210, r1.xyww
        add r1.xyz, r1, c211
        add r0.x, r1.z, c213.z
        slt r1.z, c3.x, r0.x
        mad r2.xy, r1.z, c3.yzzw, c3.zxzw
        mov r1.w, -r0_abs.x
        dp3 r1.z, r1.xyww, r1.xyww
        rsq r1.z, r1.z
        rcp r1.z, r1.z
        add r0.x, r0_abs.x, r1.z
        rcp r0.x, r0.x
        mul r1.xy, r1, r0.x
        mad_sat r1.xy, r1, c4, c4.x
        mad r1.xy, r1, c214.w, c214
        add r1.xy, r1, c3.w
        mov r1.zw, c3.x
        texldl r1, r1, s0
        mul r1.xy, r2, r1
        add r0.x, r1.y, r1.x
        rcp r1.x, -c212.w
        mul r0.x, r0.x, r1.x
        dp3 r1.x, r0.yzww, r0.yzww
        rsq r1.x, r1.x
        mul r0.x, r0_abs.x, r1.x
        min r0.x, r0.x, c0.w
        mad r0.xyz, r0.yzww, r0.x, c216
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r1, r0.z, c10, r1
        add r1, r1, c11
        add o2.xyz, r0, -c15
        mov r0.xyz, c216
        add o1.xyz, -r0, c15
        mov r0.w, c223.w
        mul r0.x, r0.w, c224.x
        mul r0.x, r0.x, c4.z
        mul o3.xyz, r0.x, c223
        mov o0, r1
        mov o1.w, r1.w
    
    // approximately 154 instruction slots used (2 texture, 152 arithmetic)
};

VertexShader VS_ShaftTransformDir
<
    string gDeferredLightColourAndIntensity = "parameter register(212)";
    string gDeferredLightDirection          = "parameter register(209)";
    string gDeferredLightPosition           = "parameter register(208)";
    string gDeferredLightRadius             = "parameter register(211)";
    string gDeferredLightShaftParams        = "parameter register(213)";
    string gDeferredLightTangent            = "parameter register(210)";
    string gDirectionalLight                = "parameter register(17)";
    string gViewInverse                     = "parameter register(12)";
    string gWorldViewProj                   = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDeferredLightColourAndIntensity;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   float4 gDeferredLightShaftParams;
    //   float3 gDeferredLightTangent;
    //   float4 gDirectionalLight;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gWorldViewProj                   c8       4
    //   gViewInverse                     c12      4
    //   gDirectionalLight                c17      1
    //   gDeferredLightPosition           c208     1
    //   gDeferredLightDirection          c209     1
    //   gDeferredLightTangent            c210     1
    //   gDeferredLightRadius             c211     1
    //   gDeferredLightColourAndIntensity c212     1
    //   gDeferredLightShaftParams        c213     1
    //
    
        vs_3_0
        def c0, -0.5, 0.25, 0, 0
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1
        dcl_texcoord1 o2.xyz
        dcl_texcoord2 o3.xyz
        mov r0.xyz, c209
        add r1.xyz, -r0, c210
        add r2.xy, c0.x, v0
        mad r0.xyz, r0, r2.x, c208
        mad r0.xyz, r1, r2.y, r0
        mul r0.w, c211.x, v0.z
        mad r0.xyz, c17, r0.w, r0
        add o2.xyz, r0, -c15
        mov r1.xyz, c15
        add o1.xyz, r1, -c208
        mov r0.w, c212.w
        mul r0.w, r0.w, c0.y
        mul r1.xyz, r0.w, c212
        mul o3.xyz, r1, c213.x
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r0, r0.z, c10, r1
        add r0, r0, c11
        mov o0, r0
        mov o1.w, r0.w
    
    // approximately 20 instruction slots used
};

VertexShader VS_ShaftShadowTransformDir
<
    string gDeferredLightColourAndIntensity = "parameter register(212)";
    string gDeferredLightDirection          = "parameter register(209)";
    string gDeferredLightPosition           = "parameter register(208)";
    string gDeferredLightRadius             = "parameter register(211)";
    string gDeferredLightShaftParams        = "parameter register(213)";
    string gDeferredLightTangent            = "parameter register(210)";
    string gDirectionalLight                = "parameter register(17)";
    string gViewInverse                     = "parameter register(12)";
    string gWorldViewProj                   = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDeferredLightColourAndIntensity;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   float4 gDeferredLightShaftParams;
    //   float3 gDeferredLightTangent;
    //   float4 gDirectionalLight;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gWorldViewProj                   c8       4
    //   gViewInverse                     c12      4
    //   gDirectionalLight                c17      1
    //   gDeferredLightPosition           c208     1
    //   gDeferredLightDirection          c209     1
    //   gDeferredLightTangent            c210     1
    //   gDeferredLightRadius             c211     1
    //   gDeferredLightColourAndIntensity c212     1
    //   gDeferredLightShaftParams        c213     1
    //
    
        vs_3_0
        def c0, -0.5, 0.25, 0, 0
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1
        dcl_texcoord1 o2.xyz
        dcl_texcoord2 o3.xyz
        mov r0.xyz, c209
        add r1.xyz, -r0, c210
        add r2.xy, c0.x, v0
        mad r0.xyz, r0, r2.x, c208
        mad r0.xyz, r1, r2.y, r0
        mul r0.w, c211.x, v0.z
        mad r0.xyz, c17, r0.w, r0
        add o2.xyz, r0, -c15
        mov r1.xyz, c15
        add o1.xyz, r1, -c208
        mov r0.w, c212.w
        mul r0.w, r0.w, c0.y
        mul r1.xyz, r0.w, c212
        mul o3.xyz, r1, c213.x
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r0, r0.z, c10, r1
        add r0, r0, c11
        mov o0, r0
        mov o1.w, r0.w
    
    // approximately 20 instruction slots used
};

VertexShader VS_Corona
<
    string GBufferTextureSampler3 = "parameter register(0)";
    string gViewInverse           = "parameter register(12)";
    string gWorldView             = "parameter register(4)";
    string gWorldViewProj         = "parameter register(8)";
    string globalScreenSize       = "parameter register(44)";
    string poisson12              = "parameter register(208)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler3;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldView;
    //   row_major float4x4 gWorldViewProj;
    //   float4 globalScreenSize;
    //   float2 poisson12[12];
    //
    //
    // Registers:
    //
    //   Name                   Reg   Size
    //   ---------------------- ----- ----
    //   gWorldView             c4       3
    //   gWorldViewProj         c8       4
    //   gViewInverse           c12      4
    //   globalScreenSize       c44      1
    //   poisson12              c208    12
    //   GBufferTextureSampler3 s0       1
    //
    
        vs_3_0
        def c0, 0.707106769, 1, 0.5, 0.100000001
        def c1, 1, 0, 2, -0.996999979
        def c2, 0.5, -0.5, 0.0833333358, 0.00999999978
        dcl_position v0
        dcl_color v1
        dcl_texcoord v2
        dcl_normal v3
        dcl_2d s0
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2.xyz
        mov r0.xyz, v3
        add r0.xyz, -r0, v0
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        rcp r0.w, r0.w
        mul r0.w, r0.w, c0.x
        add r1.xyz, -c15, v3
        dp3 r1.w, r1, r1
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        if_lt r1.w, r0.w
          mov r2.x, c4.z
          mov r2.y, c5.z
          mov r2.z, c6.z
          dp3 r1.x, r2, r1
          slt r1.y, -r1.x, r0.w
          rcp r0.w, r0.w
          mad r0.w, -r1.x, r0.w, c0.y
          mul_sat r3.w, r0.w, c0.z
          slt r0.w, -r1.x, c0.w
          add r1.x, r1.x, c0.w
          mul r1.xzw, r2.xyyz, r1.x
          mad r3.xyz, r0.w, -r1.xzww, v0
          mad r2, v0.xyzx, c1.xxxy, c1.yyyx
          lrp r4, r1.y, r3, r2
        else
          mul r1, c9, v3.y
          mad r1, v3.x, c8, r1
          mad r1, v3.z, c10, r1
          add r1, r1, c11
          rcp r0.w, r1.w
          mul r1.xyz, r1, r0.w
          mov r2.zw, c44
          mul r2.xy, r2.zwzw, c208
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r0.w, r1.z, r3.x
          mul r2.xy, r2.zwzw, c209
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r1.w, r1.z, r3.x
          mul r1.w, r1.w, c2.z
          mad r0.w, r0.w, c2.z, r1.w
          mul r2.xy, r2.zwzw, c210
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r1.w, r1.z, r3.x
          mad r0.w, r1.w, c2.z, r0.w
          mul r2.xy, r2.zwzw, c211
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r1.w, r1.z, r3.x
          mad r0.w, r1.w, c2.z, r0.w
          mul r2.xy, r2.zwzw, c212
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r1.w, r1.z, r3.x
          mad r0.w, r1.w, c2.z, r0.w
          mul r2.xy, r2.zwzw, c213
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r1.w, r1.z, r3.x
          mad r0.w, r1.w, c2.z, r0.w
          mul r2.xy, r2.zwzw, c214
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r1.w, r1.z, r3.x
          mad r0.w, r1.w, c2.z, r0.w
          mul r2.xy, r2.zwzw, c215
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r1.w, r1.z, r3.x
          mad r0.w, r1.w, c2.z, r0.w
          mul r2.xy, r2.zwzw, c216
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r1.w, r1.z, r3.x
          mad r0.w, r1.w, c2.z, r0.w
          mul r2.xy, r2.zwzw, c217
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r1.w, r1.z, r3.x
          mad r0.w, r1.w, c2.z, r0.w
          mul r2.xy, r2.zwzw, c218
          mad r2.xy, r2, c1.z, r1
          max r2.xy, r2, c1.w
          min r2.xy, r2, -c1.w
          mad r3.xy, r2, c2, c2.x
          mov r3.zw, c1.y
          texldl r3, r3, s0
          slt r1.w, r1.z, r3.x
          mad r0.w, r1.w, c2.z, r0.w
          mul r2.xy, r2.zwzw, c219
          mad r1.xy, r2, c1.z, r1
          max r1.xy, r1, c1.w
          min r1.xy, r1, -c1.w
          mad r2.xy, r1, c2, c2.x
          mov r2.zw, c1.y
          texldl r2, r2, s0
          slt r1.x, r1.z, r2.x
          mad r4.w, r1.x, c2.z, r0.w
          slt r0.w, c2.w, r4.w
          mad r4.xyz, r0.w, r0, v3
        endif
        mul r0, r4.y, c9
        mad r0, r4.x, c8, r0
        mad r0, r4.z, c10, r0
        add o0, r0, c11
        mul r0.xyz, r4.w, v1
        mul o2.xyz, r0, v2.y
        mov o1.x, v2.x
        mov o1.y, v1.w
    
    // approximately 166 instruction slots used (24 texture, 142 arithmetic)
};

VertexShader VS_Corona_R
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
        dcl_color v1
        dcl_texcoord v2
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2.xyz
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add o0, r0, c11
        mov r0.xyz, v1
        mul o2.xyz, r0, v2.y
        mov o1.x, v2.x
        mov o1.y, v1.w
    
    // approximately 8 instruction slots used
};

VertexShader VS_Corona_PB
<
    string gViewInverse = "parameter register(12)";
    string gWorldView   = "parameter register(4)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldView;
    //
    //
    // Registers:
    //
    //   Name         Reg   Size
    //   ------------ ----- ----
    //   gWorldView   c4       4
    //   gViewInverse c12      4
    //
    
        vs_3_0
        def c0, 512, 0, 1, 9.99999975e-006
        def c1, 0.353553385, 0, 0, 0
        dcl_position v0
        dcl_color v1
        dcl_texcoord v2
        dcl_normal v3
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2.xyz
        mov r0.x, c0.x
        add r0.x, r0.x, c15.z
        mov r0.x, -r0.x
        mov r0.yz, -c15.xxyw
        add r0.xyz, r0, v3.zxyw
        mul r1.xyz, r0, c0.yzyw
        mad r1.xyz, r0.zxyw, c0.zyyw, -r1
        add r1.xyz, r1, c0.w
        nrm r2.xyz, r1
        slt r0.w, c0.y, r0.x
        mul r1.xyz, r2, r0.w
        mul r2.xyz, r0, r1.yzxw
        mad r2.xyz, r0.zxyw, r1.zxyw, -r2
        add r2.xyz, r2, c0.w
        nrm r3.xyz, r2
        mul r0.yzw, r0.w, r3.xxyz
        mov r2.xyz, v3
        add r2.xyz, -r2, v0
        mad r1.xyz, r1, r2.x, v3
        mad r0.yzw, r0, r2.y, r1.xxyz
        dp3 r1.x, r2, r2
        rsq r1.x, r1.x
        rcp r1.x, r1.x
        mul r1.x, r1.x, c1.x
        rcp r1.x, r1.x
        mul_sat r0.x, r0.x, r1.x
        mul r1.xyz, r0.z, c5
        mad r1.xyz, r0.y, c4, r1
        mad r0.yzw, r0.w, c6.xxyz, r1.xxyz
        add r1.xyz, r0.yzww, c7
        add r1.w, r1.z, c0.x
        dp3 r0.y, r1.xyww, r1.xyww
        rsq r0.y, r0.y
        add r0.z, r1.z, c0.x
        mad r0.z, r0.z, -r0.y, c0.z
        rcp r0.y, r0.y
        mul r0.z, r0.z, r0.y
        add r0.y, r0.y, c0.z
        rcp r0.y, r0.y
        add o0.z, -r0.y, c0.z
        rcp r0.y, r0.z
        mul o0.xy, r1, r0.y
        mov r1.xyz, v1
        mul r0.yzw, r1.xxyz, v2.y
        mul o2.xyz, r0.x, r0.yzww
        mov o0.w, c0.z
        mov o1.x, v2.x
        mov o1.y, v1.w
    
    // approximately 52 instruction slots used
};

VertexShader VS_Brightlight
<
    string gDepthFxParams  = "parameter register(16)";
    string gWorldViewProj  = "parameter register(8)";
    string globalFogColor  = "parameter register(42)";
    string globalFogColorN = "parameter register(43)";
    string globalFogParams = "parameter register(41)";
    string globalScalars   = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDepthFxParams;
    //   row_major float4x4 gWorldViewProj;
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name            Reg   Size
    //   --------------- ----- ----
    //   gWorldViewProj  c8       4
    //   gDepthFxParams  c16      1
    //   globalScalars   c39      1
    //   globalFogParams c41      1
    //   globalFogColor  c42      1
    //   globalFogColorN c43      1
    //
    
        vs_3_0
        def c0, 0.212500006, 0.715399981, 0.0720999986, 0
        def c1, 1, -1, 1.00000001e-007, 0
        dcl_position v0
        dcl_color v1
        dcl_position o0
        dcl_texcoord o1.xyz
        mov r0.xyz, c43
        add r0.xyz, -r0, c42
        add r0.w, -c41.x, c41.y
        rcp r0.w, r0.w
        mul r1, c9, v0.y
        mad r1, v0.x, c8, r1
        mad r1, v0.z, c10, r1
        add r1, r1, c11
        add r2.x, r1.w, -c41.x
        mul_sat r0.w, r0.w, r2.x
        mad r0.xyz, r0.w, r0, c43
        add r2.x, -r1.w, c16.w
        add r2.y, -c16.z, c16.w
        rcp r2.y, r2.y
        mul_sat r2.x, r2.x, r2.y
        add r2.x, -r2.x, c1.x
        mov r3.xy, c16
        add r2.yz, r3.xxyw, c1.y
        mad r2.y, r2.x, r2.y, c1.x
        mul r2.x, r2.x, r2.z
        mul r3.xyz, c39.y, v1
        dp3 r2.z, r3, c0
        mad r3.xyz, v1, c39.y, -r2.z
        mad r3.xyz, r2.y, r3, r2.z
        add r2.y, r2.z, c1.z
        pow r3.w, r2_abs.y, r2.x
        mad r0.xyz, r3, -r3.w, r0
        mul r2.xyz, r3, r3.w
        rcp r2.w, c41.x
        mul_sat r2.w, r1.w, r2.w
        mov o0, r1
        lrp r1.x, c41.w, r2.w, r0.w
        add r0.w, r1.x, c41.z
        mad o1.xyz, r0.w, r0, r2
    
    // approximately 36 instruction slots used
};

VertexShader VS_SmokeBoard
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
        dcl_texcoord v1
        dcl_color v2
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_color o2
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add o0, r0, c11
        mov o1.xy, v1
        mov o2, v2
    
    // approximately 6 instruction slots used
};

VertexShader VS_VolumeTransformWaterFx
<
    string gDirectionalColour   = "parameter register(18)";
    string gDirectionalLight    = "parameter register(17)";
    string gFacetCentre         = "parameter register(54)";
    string gInvColorExpBias     = "parameter register(46)";
    string gLightAmbient0       = "parameter register(37)";
    string gShadowMatrix        = "parameter register(60)";
    string gShadowParam0123     = "parameter register(57)";
    string gShadowParam14151617 = "parameter register(56)";
    string gShadowParam4567     = "parameter register(58)";
    string gShadowParam891113   = "parameter register(59)";
    string gShadowZSamplerDirVS = "parameter register(3)";
    string gViewInverse         = "parameter register(12)";
    string gWorldViewProj       = "parameter register(8)";
    string poisson12            = "parameter register(208)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float4 gFacetCentre;
    //   float gInvColorExpBias;
    //   float4 gLightAmbient0;
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam4567;
    //   float4 gShadowParam891113;
    //   sampler2D gShadowZSamplerDirVS;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //   float2 poisson12[12];
    //
    //
    // Registers:
    //
    //   Name                 Reg   Size
    //   -------------------- ----- ----
    //   gWorldViewProj       c8       4
    //   gViewInverse         c12      4
    //   gDirectionalLight    c17      1
    //   gDirectionalColour   c18      1
    //   gLightAmbient0       c37      1
    //   gInvColorExpBias     c46      1
    //   gFacetCentre         c54      1
    //   gShadowParam14151617 c56      1
    //   gShadowParam0123     c57      1
    //   gShadowParam4567     c58      1
    //   gShadowParam891113   c59      1
    //   gShadowMatrix        c60      4
    //   poisson12            c208    12
    //   gShadowZSamplerDirVS s3       1
    //
    
        vs_3_0
        def c0, 0, 1, -0.0833333358, 0
        def c1, -2, 2, 1, -1
        dcl_position v0
        dcl_normal v1
        dcl_texcoord v2
        dcl_color v3
        dcl_2d s3
        dcl_position o0
        dcl_color o1
        dcl_texcoord o2
        dcl_texcoord1 o3
        dcl_texcoord2 o4
        mov r0.zw, c0.x
        mov r1.z, c0.x
        mul r2.xy, v2, v2
        add r1.w, r2.y, r2.x
        rsq r1.w, r1.w
        rcp r2.x, r1.w
        mul r1.xy, r2.x, c208
        add r1.xyz, r1, v1
        mul r2.yzw, r1.y, c61.xxyw
        mad r2.yzw, r1.x, c60.xxyw, r2
        mad r2.yzw, r1.z, c62.xxyw, r2
        dp3 r1.x, c14, r1
        sge r3.yzw, -r1.x, c54.xxyz
        add r1.xyz, r2.yzww, c63.xyww
        mov r3.x, c0.y
        dp4 r4.x, r3, c57
        dp4 r4.y, r3, c58
        dp4 r5.x, r3, c59
        dp4 r5.y, r3, c56
        mad r0.xy, r1, r4, r5
        texldl r0, r0, s3
        add r0.x, -r1.z, r0.x
        slt r0.x, c0.x, r0.x
        mad r0.x, r0.x, c0.z, c0.y
        mov r3.zw, c0.x
        mov r1.z, c0.x
        mul r1.xy, r2.x, c209
        add r0.yzw, r1.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r4.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r4.x, c0.y
        dp4 r1.x, r4, c57
        dp4 r1.y, r4, c58
        dp4 r5.x, r4, c59
        dp4 r5.y, r4, c56
        mad r3.xy, r0.yzzw, r1, r5
        texldl r3, r3, s3
        add r0.y, -r0.w, r3.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        mov r3.zw, c0.x
        mov r1.z, c0.x
        mul r1.xy, r2.x, c210
        add r0.yzw, r1.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r4.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r4.x, c0.y
        dp4 r1.x, r4, c57
        dp4 r1.y, r4, c58
        dp4 r5.x, r4, c59
        dp4 r5.y, r4, c56
        mad r3.xy, r0.yzzw, r1, r5
        texldl r3, r3, s3
        add r0.y, -r0.w, r3.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        mov r3.zw, c0.x
        mov r1.z, c0.x
        mul r1.xy, r2.x, c211
        add r0.yzw, r1.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r4.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r4.x, c0.y
        dp4 r1.x, r4, c57
        dp4 r1.y, r4, c58
        dp4 r5.x, r4, c59
        dp4 r5.y, r4, c56
        mad r3.xy, r0.yzzw, r1, r5
        texldl r3, r3, s3
        add r0.y, -r0.w, r3.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        mov r3.zw, c0.x
        mov r1.z, c0.x
        mul r1.xy, r2.x, c212
        add r0.yzw, r1.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r4.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r4.x, c0.y
        dp4 r1.x, r4, c57
        dp4 r1.y, r4, c58
        dp4 r5.x, r4, c59
        dp4 r5.y, r4, c56
        mad r3.xy, r0.yzzw, r1, r5
        texldl r3, r3, s3
        add r0.y, -r0.w, r3.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        mov r1.z, c0.x
        mul r1.xy, r2.x, c213
        add r0.yzw, r1.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r3.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r3.x, c0.y
        dp4 r1.x, r3, c57
        dp4 r1.y, r3, c58
        dp4 r4.x, r3, c59
        dp4 r4.y, r3, c56
        mad r3.xy, r0.yzzw, r1, r4
        mov r3.zw, c0.x
        texldl r3, r3, s3
        add r0.y, -r0.w, r3.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        mov r1.z, c0.x
        mul r1.xy, r2.x, c214
        add r0.yzw, r1.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r3.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r3.x, c0.y
        dp4 r1.x, r3, c57
        dp4 r1.y, r3, c58
        dp4 r4.x, r3, c59
        dp4 r4.y, r3, c56
        mad r3.xy, r0.yzzw, r1, r4
        mov r3.zw, c0.x
        texldl r3, r3, s3
        add r0.y, -r0.w, r3.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        mov r1.z, c0.x
        mul r1.xy, r2.x, c215
        add r0.yzw, r1.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r3.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r3.x, c0.y
        dp4 r1.x, r3, c57
        dp4 r1.y, r3, c58
        dp4 r4.x, r3, c59
        dp4 r4.y, r3, c56
        mad r3.xy, r0.yzzw, r1, r4
        mov r3.zw, c0.x
        texldl r3, r3, s3
        add r0.y, -r0.w, r3.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        mov r1.z, c0.x
        mul r1.xy, r2.x, c216
        add r0.yzw, r1.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r3.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r3.x, c0.y
        dp4 r1.x, r3, c57
        dp4 r1.y, r3, c58
        dp4 r4.x, r3, c59
        dp4 r4.y, r3, c56
        mad r3.xy, r0.yzzw, r1, r4
        mov r3.zw, c0.x
        texldl r3, r3, s3
        add r0.y, -r0.w, r3.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        mov r1.z, c0.x
        mul r1.xy, r2.x, c217
        add r0.yzw, r1.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r3.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r3.x, c0.y
        dp4 r1.x, r3, c57
        dp4 r1.y, r3, c58
        dp4 r4.x, r3, c59
        dp4 r4.y, r3, c56
        mad r3.xy, r0.yzzw, r1, r4
        mov r3.zw, c0.x
        texldl r3, r3, s3
        add r0.y, -r0.w, r3.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        mov r1.z, c0.x
        mul r1.xy, r2.x, c218
        mul r2.xy, r2.x, c219
        add r0.yzw, r1.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r3.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r3.x, c0.y
        dp4 r1.x, r3, c57
        dp4 r1.y, r3, c58
        dp4 r4.x, r3, c59
        dp4 r4.y, r3, c56
        mad r3.xy, r0.yzzw, r1, r4
        mov r3.zw, c0.x
        texldl r3, r3, s3
        add r0.y, -r0.w, r3.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        mov r2.z, c0.x
        add r0.yzw, r2.xxyz, v1.xxyz
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        dp3 r0.y, c14, r0.yzww
        sge r2.yzw, -r0.y, c54.xxyz
        add r0.yzw, r1.xxyz, c63.xxyw
        mov r2.x, c0.y
        dp4 r1.x, r2, c57
        dp4 r1.y, r2, c58
        dp4 r3.x, r2, c59
        dp4 r3.y, r2, c56
        mad r2.xy, r0.yzzw, r1, r3
        mov r2.zw, c0.x
        texldl r2, r2, s3
        add r0.y, -r0.w, r2.x
        slt r0.y, c0.x, r0.y
        mad r0.x, r0.y, c0.z, r0.x
        abs r0.y, c17.z
        mul r0.y, r0.y, c18.w
        mul r0.x, r0.x, r0.y
        mov r1.xyz, c18
        mad o1.xyz, r1, r0.x, c37
        mul o1.w, c46.x, v3.w
        mul o3.xy, r1.w, v2
        mad r0.xy, v3.x, c1, c1.zwzw
        mul r0.xy, r0, v2.yxzw
        mul o3.zw, r1.w, r0.xyxy
        mov o4.w, r1.w
        add r0.xyz, -c15, v0
        mov o2.xyz, -r0
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add r0, r0, c11
        mov o0, r0
        mov o2.w, r0.w
        mov o4.xyz, v1
    
    // approximately 276 instruction slots used (24 texture, 252 arithmetic)
};

VertexShader VS_VolumeTransformP
<
    string gViewInverse   = "parameter register(12)";
    string gWorldViewProj = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   gWorldViewProj c8       4
    //   gViewInverse   c12      4
    //
    
        vs_3_0
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1
        add r0.xyz, -c15, v0
        mov o1.xyz, -r0
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add r0, r0, c11
        mov o0, r0
        mov o1.w, r0.w
    
    // approximately 8 instruction slots used
};

VertexShader VS_VolumeTransformPSP
<
    string gDeferredLightConeAngle    = "parameter register(215)";
    string gDeferredLightConeAngleI   = "parameter register(214)";
    string gDeferredLightDirection    = "parameter register(210)";
    string gDeferredLightPosition     = "parameter register(209)";
    string gDeferredLightRadius       = "parameter register(212)";
    string gDeferredLightTangent      = "parameter register(211)";
    string gDeferredLightType         = "parameter register(208)";
    string gDeferredVolumeRadiusScale = "parameter register(213)";
    string gViewInverse               = "parameter register(12)";
    string gWorldViewProj             = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float gDeferredLightConeAngle;
    //   float gDeferredLightConeAngleI;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
    //   float gDeferredVolumeRadiusScale;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gWorldViewProj             c8       4
    //   gViewInverse               c12      4
    //   gDeferredLightType         c208     1
    //   gDeferredLightPosition     c209     1
    //   gDeferredLightDirection    c210     1
    //   gDeferredLightTangent      c211     1
    //   gDeferredLightRadius       c212     1
    //   gDeferredVolumeRadiusScale c213     1
    //   gDeferredLightConeAngleI   c214     1
    //   gDeferredLightConeAngle    c215     1
    //
    
        vs_3_0
        def c0, -4, 0.159154937, 0.5, 1
        def c1, 6.28318548, -3.14159274, -1.57079637, 1.57079637
        def c2, 9.99999975e-005, -2, 9.99999975e-006, 0.662
        dcl_position v0
        dcl_position o0
        dcl_texcoord o1
        mov r0.xyz, c210
        mul r1.xyz, r0.yzxw, c211.zxyw
        mad r0.xyz, c211.yzxw, r0.zxyw, -r1
        mov r1.xyz, c0
        add r0.w, r1.x, c208.x
        if_ge -r0_abs.w, r0_abs.w
          mad r0.w, c215.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r2.x, r0.w
          mad r0.w, c214.x, r1.y, r1.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r1.x, r0.w
          mad r0.w, v0.z, -c1.z, c1.w
          mad r0.w, r0.w, c0.y, c0.z
          frc r0.w, r0.w
          mad r0.w, r0.w, c1.x, c1.y
          sincos r3.x, r0.w
          mad r0.w, r3.x, -r3.x, c0.w
          mul r1.yz, v0.xxyw, v0.xxyw
          add r1.y, r1.z, r1.y
          add r1.y, r1.y, c2.x
          rcp r1.y, r1.y
          mul r0.w, r0.w, r1.y
          rsq r0.w, r0.w
          rcp r0.w, r0.w
          sge r1.y, r2.x, r3.x
          mul r1.z, r0.w, c213.x
          mul r1.zw, r1.z, v0.xyxy
          mul r2.yzw, r0.xxyz, r1.w
          mad r2.yzw, c211.xxyz, r1.z, r2
          mad r3.yzw, c210.xxyz, r2.x, r2
          sge r1.z, r3.x, r1.x
          mad r2.xyz, c210, r1.x, r2.yzww
          mul r1.xw, r0.w, v0.xyzy
          mul r4.xyz, r0, r1.w
          mad r4.xyz, c211, r1.x, r4
          mad r4.xyz, c210, r3.x, r4
          lrp r5.xyz, r1.z, r2, r4
          lrp r2.xyz, r1.y, r3.yzww, r5
        else
          mov r1.y, c2.y
          add r0.w, r1.y, c208.x
          sge r0.w, -r0_abs.w, r0_abs.w
          mul r1.xy, v0, v0
          add r1.x, r1.y, r1.x
          sge r1.y, r1.x, c2.x
          mov_sat r1.z, -v0.z
          add r1.z, -r1.z, c0.w
          mul r1.z, r1.z, c215.x
          mad r1.z, r1.z, c0.y, c0.z
          frc r1.z, r1.z
          mad r1.z, r1.z, c1.x, c1.y
          sincos r3.x, r1.z
          mad r1.z, r3.x, -r3.x, c0.w
          add r1.x, r1.x, c2.x
          rcp r1.x, r1.x
          mul r1.x, r1.z, r1.x
          rsq r1.x, r1.x
          rcp r1.x, r1.x
          mul r1.x, r1.x, c213.x
          mul r1.xz, r1.x, v0.xyyw
          mul r0.xyz, r0, r1.z
          mad r0.xyz, c211, r1.x, r0
          mad r0.xyz, c210, r3.x, r0
          sge r1.x, v0_abs.z, c2.x
          mul r3.xyz, r1.x, c210
          mad r0.xyz, c210, -r1.x, r0
          mad r0.xyz, r1.y, r0, r3
          add r1.xyz, c2.z, v0
          dp3 r1.w, r1, r1
          rsq r1.w, r1.w
          mul r3.xyz, r1, r1.w
          mad r0.xyz, r1, -r1.w, r0
          mad r2.xyz, r0.w, r0, r3
        endif
        mov r0.x, c213.x
        mul r0.x, r0.x, c212.x
        mul r0.x, r0.x, c2.w
        mad r0.xyz, r2, r0.x, c209
        mul r1, r0.y, c9
        mad r1, r0.x, c8, r1
        mad r1, r0.z, c10, r1
        add r1, r1, c11
        add r0.xyz, r0, -c15
        mov o1.xyz, -r0
        mov o0, r1
        mov o1.w, r1.w
    
    // approximately 119 instruction slots used
};

struct VS_InputScreen
{
    float3 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
};

float4 VS_ScreenTransform(VS_InputScreen IN) : POSITION
{
    return float4(IN.Position.xy * 2.0 - 1.0, 0.0, 1.0);
}

struct VS_OutputScreen
{
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
};

float4 VS_ScreenTransformT(VS_InputScreen IN)
{
    VS_OutputScreen OUT;
    OUT.Position = float4(IN.Position.xy * 2.0 - 1.0, 0.0, 1.0);
    OUT.TexCoord = IN.TexCoord;

    return OUT;
}

//Pixel shaders
PixelShader PixelShader0 = NULL;

float3 DecodeGBufferNormal(float2 texCoord)
{
    float4 normal = tex2D(GBufferTextureSampler1, texCoord);
    float3 v1 = frac(normal.w * float3(0.99609375, 7.96875, 63.75));
    float3 v2 = v1.xyz * 2;
    v2.xy += (v1.yz * -0.25);
    normal.xyz = normal.xyz * 256 + v2;
    return normalize(normal.xyz - 127.999992);
}

float4 PS_LightShadowDirectionalAmbientReflectionDry(float2 texCoord : TEXCOORD0, float4 texCoord1 : TEXCOORD1) : COLOR
{
    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= texCoord1.w;
    float3 posView = (texCoord1.xyz / -linearDepth) + gViewInverse[3].xyz;
    float3 viewDir = normalize(texCoord1.xyz / -linearDepth + 0.00001);

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = DecodeGBufferNormal(texCoord);
    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;
    surfProperties.SpecularIntensity = specAoBuffer.x * 2;
    surfProperties.SpecularPower = specAoBuffer.y * specAoBuffer.y * 512;
    surfProperties.AmbientOcclusion = specAoBuffer.z;

    return float4(ComputeLighting(0, true, posView, viewDir, surfProperties), 1);
}

float4 PS_LightShadowDirectionalAmbientReflectionWet(float2 texCoord : TEXCOORD0, float4 texCoord1 : TEXCOORD1) : COLOR
{
    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= texCoord1.w;
    float3 posView = (texCoord1.xyz / -linearDepth) + gViewInverse[3].xyz;
    float3 viewDir = normalize(texCoord1.xyz / -linearDepth + 0.00001);

    float3 normal = DecodeGBufferNormal(texCoord);

    float wetMask = tex2D(GBufferStencilTextureSampler, texCoord).x;
    wetMask = wetMask == 0.0 ? saturate(normal.z * 1) * dReflectionParams.y : 0.0;
    
    SurfaceProperties surfProperties;
    float diffuseDarkening = 1.0 - (wetMask * 0.5);
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz * diffuseDarkening;
    surfProperties.Normal = normal;

    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;
    
    float specPower = specAoBuffer.y * specAoBuffer.y * 512;
    float wetspecPower = min(specAoBuffer.y * specAoBuffer.y * 4096, 256);
    wetspecPower = wetMask * (wetspecPower - specPower) + specPower;
    surfProperties.SpecularPower = max(specPower, wetspecPower);

    float specIntensity = specAoBuffer.x * 2;
    float v5 = min(specPower / 50, 0.25) - specIntensity;
    float wetSpecIntensity = wetMask * v5 + specIntensity;
    surfProperties.SpecularIntensity = max(specIntensity, wetSpecIntensity);

    surfProperties.AmbientOcclusion = specAoBuffer.z;

    return float4(ComputeLighting(0, true, posView, viewDir, surfProperties), 1);
}

float4 PS_LightAmbientReflectionDry(float2 texCoord : TEXCOORD0, float4 texCoord1 : TEXCOORD1) : COLOR
{
    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= texCoord1.w;
    float3 posView = (texCoord1.xyz / -linearDepth) + gViewInverse[3].xyz;
    float3 viewDir = normalize(texCoord1.xyz / -linearDepth + 0.00001);

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = DecodeGBufferNormal(texCoord);
    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;
    surfProperties.SpecularIntensity = specAoBuffer.x * 2;
    surfProperties.SpecularPower = specAoBuffer.y * specAoBuffer.y * 512;
    surfProperties.AmbientOcclusion = specAoBuffer.z;

    return float4(ComputeLighting(0, false, posView, viewDir, surfProperties), 1);
}

float4 PS_LightAmbientReflectionWet(float2 texCoord : TEXCOORD0, float4 texCoord1 : TEXCOORD1) : COLOR
{
    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= texCoord1.w;
    float3 posView = (texCoord1.xyz / -linearDepth) + gViewInverse[3].xyz;
    float3 viewDir = normalize(texCoord1.xyz / -linearDepth + 0.00001);

    float3 normal = DecodeGBufferNormal(texCoord);

    float wetMask = tex2D(GBufferStencilTextureSampler, texCoord).x;
    wetMask = wetMask == 0.0 ? saturate(normal.z * 1) * dReflectionParams.y : 0.0;
    
    SurfaceProperties surfProperties;
    float diffuseDarkening = 1.0 - (wetMask * 0.5);
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz * diffuseDarkening;
    surfProperties.Normal = normal;

    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;
    
    float specPower = specAoBuffer.y * specAoBuffer.y * 512;
    float wetspecPower = min(specAoBuffer.y * specAoBuffer.y * 4096, 256);
    wetspecPower = wetMask * (wetspecPower - specPower) + specPower;
    surfProperties.SpecularPower = max(specPower, wetspecPower);

    float specIntensity = specAoBuffer.x * 2;
    float v5 = min(specPower / 50, 0.25) - specIntensity;
    float wetSpecIntensity = wetMask * v5 + specIntensity;
    surfProperties.SpecularIntensity = max(specIntensity, wetSpecIntensity);

    surfProperties.AmbientOcclusion = specAoBuffer.z;

    return float4(ComputeLighting(0, false, posView, viewDir, surfProperties), 1);
}


float4 PS_StencilVolume() : COLOR
{
    return float4(0, 0, 0, 0);
}

float ComputeShadow(in float3 posWorld, in float3 normal, in float2 screenCoords)
{
    float3 posShadow = normal * 0.1 + posWorld;
    posShadow = mul(float4(posShadow, 1), dShadowMatrix).xyz;
    posShadow.z += dShadowParam891113.z;
    
    float shadowDist = length(float3(posShadow.xy, -abs(posShadow.z)));
    float v0 = abs(posShadow.z) + shadowDist;
    float2 channelMask = -posShadow.z >= 0 ? float2(1, 0) : float2(0, 1);
    
    posShadow.xy = (posShadow.xy / v0) * float2(0.5, -0.5) + 0.5;

    float angle = dot(screenCoords, float2(3, 4.27199984));
    float2 discPos = float2(cos(angle), sin(angle));

    float4 shadowSamples;
    float2 shadowSample;
    float2 shadowCoords;

    shadowCoords = discPos.xy * float2(1, -1) * dShadowOffsetScale.z;
    shadowCoords = saturate(shadowCoords + posShadow.xy);
    shadowCoords = shadowCoords * dShadowOffsetScale.w + dShadowOffsetScale.xy;
    shadowSample = tex2D(gShadowZSamplerCache, shadowCoords).xy;
    shadowSamples.x = dot(shadowSample, channelMask);
    
    shadowCoords = discPos.yx * dShadowOffsetScale.z;
    shadowCoords = saturate(shadowCoords * 0.75 + posShadow.xy);
    shadowCoords = shadowCoords * dShadowOffsetScale.w + dShadowOffsetScale.xy;
    shadowSample = tex2D(gShadowZSamplerCache, shadowCoords).xy;
    shadowSamples.y = dot(shadowSample, channelMask);

    shadowCoords = discPos.xy * float2(-1, 1) * dShadowOffsetScale.z;
    shadowCoords = saturate(shadowCoords * 0.5 + posShadow.xy);
    shadowCoords = shadowCoords * dShadowOffsetScale.w + dShadowOffsetScale.xy;
    shadowSample = tex2D(gShadowZSamplerCache, shadowCoords).xy;
    shadowSamples.z = dot(shadowSample, channelMask);

    shadowCoords = -discPos.yx * dShadowOffsetScale.z;
    shadowCoords = saturate(shadowCoords * 0.25 + posShadow.xy);
    shadowCoords = shadowCoords * dShadowOffsetScale.w + dShadowOffsetScale.xy;
    shadowSample = tex2D(gShadowZSamplerCache, shadowCoords).xy;
    shadowSamples.w = dot(shadowSample, channelMask);
    
    shadowSamples += shadowDist * dShadowParam0123.w;
    shadowSamples = shadowSamples >= 0.0 ? 1.0 : 0.0;
    return dot(shadowSamples, float4(0.25, 0.25, 0.25, 0.25));
}

float3 ComputeDeferredLocalLighting(in bool shadowed, in bool fillerLight, in float3 posWorld, in float3 viewToFragDir, float2 screenCoords, in SurfaceProperties surfProperties)
{
    float3 fragToLightDir = gDeferredLightPosition - posWorld;
    
    float distAttenuation = saturate(1.0 - (dot(fragToLightDir, fragToLightDir) * gDeferredLightInvSqrRadius));
    if(fillerLight)
        distAttenuation = distAttenuation * distAttenuation - 0.33;
    else
        distAttenuation = pow(distAttenuation, 4) - 0.1;

    fragToLightDir = normalize(fragToLightDir + 0.00001);

    float shadow = ComputeShadow(posWorld, surfProperties.Normal, screenCoords);

    float3 R = reflect(viewToFragDir, surfProperties.Normal);
    float3 specularLight = saturate(dot(fragToLightDir, R).xxx);
    specularLight = pow(specularLight, surfProperties.SpecularPower) * surfProperties.SpecularIntensity;

    float nDotL = dot(fragToLightDir, surfProperties.Normal);
    if(fillerLight && shadowed)
        nDotL = saturate((nDotL - 0.33) * 1.5);
    else if(fillerLight && !shadowed)
        nDotL = saturate((nDotL - 0.2) * 1.25);
    else
        nDotL = saturate(nDotL);

    float coneAttenuation = dot(fragToLightDir, -gDeferredLightDirection);
    coneAttenuation -= gDeferredLightConeOffset;
    coneAttenuation = saturate(coneAttenuation * gDeferredLightConeScale);
    float attenuation;
    if(fillerLight)
        attenuation = distAttenuation * 1.5 * coneAttenuation;
    else
        attenuation = distAttenuation * 1.11111116 * coneAttenuation;

    if(shadowed)
        attenuation *= shadow;
        
    float3 lightColor = gDeferredLightColourAndIntensity.xyz * gDeferredLightColourAndIntensity.w * attenuation;
    lightColor = distAttenuation >= 0.0 ? lightColor : float3(0, 0, 0);

    specularLight *= lightColor;
    float3 diffuseLight = nDotL * lightColor * surfProperties.Diffuse;

    float3 lighting;
    if(fillerLight)
        lighting = diffuseLight;
    else
        lighting = (diffuseLight + specularLight) * surfProperties.AmbientOcclusion;
    
    return lighting;
}

float3 GetLightTexture(in float3 posWorld)
{
    float3 fragToLightDir = gDeferredLightPosition - posWorld;
    float3 lightBitangent = cross(gDeferredLightTangent, gDeferredLightDirection);
    float3 fragToLightDirTangent;
    fragToLightDirTangent.x = dot(lightBitangent, fragToLightDir);
    fragToLightDirTangent.y = dot(gDeferredLightTangent, fragToLightDir);
    fragToLightDirTangent.z = dot(-gDeferredLightDirection, fragToLightDir);

    float3 lightTexture;
    //spot
    if(gDeferredLightType >= 2)
    {
        float v0 = 1.0 - (gDeferredLightConeOffset * gDeferredLightConeOffset);
        v0 = gDeferredLightConeOffset / sqrt(v0);
        v0 /= fragToLightDirTangent.z;
        float4 lightTexCoord;
        lightTexCoord.xy = (fragToLightDirTangent.xy * v0) * 0.5 + 0.5;
        lightTexCoord.zw = float2(0, 0);
        lightTexture = tex2Dlod(gDeferredLightSampler, lightTexCoord).xyz;
    }
    //point
    else
    {
        float fragPosToLightPosDirLength = length(fragToLightDir);
        float v0 = 1.0 - (fragToLightDirTangent.z / fragPosToLightPosDirLength);
        v0 *= fragPosToLightPosDirLength;
        float4 lightTexCoord;
        lightTexCoord.xy = (fragToLightDirTangent.xy / v0) * 0.5 + 0.5;
        lightTexCoord.zw = float2(0, 0);
        lightTexture = tex2Dlod(gDeferredLightSampler, lightTexCoord).xyz;
    }

    return lightTexture;
}

float4 PS_LightPointOrSpot0(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);
    
    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = DecodeGBufferNormal(texCoord);
    surfProperties.SpecularIntensity = specAoBuffer.x * 2;
    surfProperties.SpecularPower = specAoBuffer.y * specAoBuffer.y * 512;
    surfProperties.AmbientOcclusion = saturate(specAoBuffer.z * specAoBuffer.z + 0.5);
    float4 lighting = float4(ComputeDeferredLocalLighting(false, false, posWorld, viewToFragDir, screenCoords, surfProperties), 1);
    
    return lighting;
}

float4 PS_LightPointOrSpot1(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);
    
    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = DecodeGBufferNormal(texCoord);
    surfProperties.SpecularIntensity = specAoBuffer.x * 2;
    surfProperties.SpecularPower = specAoBuffer.y * specAoBuffer.y * 512;
    surfProperties.AmbientOcclusion = 1.0;
    float4 lighting = float4(ComputeDeferredLocalLighting(false, false, posWorld, viewToFragDir, screenCoords, surfProperties), 1);

    float stencil = tex2D(GBufferStencilTextureSampler, texCoord).x * 255;
    float entityAndInteriorMask = stencil >= 128 ? 128 : 0;
    entityAndInteriorMask = stencil - entityAndInteriorMask >= 7.9 ? 1 : 0;

    lighting *= entityAndInteriorMask;

    return lighting;
}

float4 PS_LightPointOrSpot2(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);
    
    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = DecodeGBufferNormal(texCoord);
    surfProperties.SpecularIntensity = specAoBuffer.x * 2;
    surfProperties.SpecularPower = specAoBuffer.y * specAoBuffer.y * 512;
    surfProperties.AmbientOcclusion = saturate(specAoBuffer.z * specAoBuffer.z + 0.5);
    float4 lighting = float4(ComputeDeferredLocalLighting(false, false, posWorld, viewToFragDir, screenCoords, surfProperties), 1);
    
    float stencil = tex2D(GBufferStencilTextureSampler, texCoord).x * 255;
    float entityAndInteriorMask = stencil >= 128 ? 128 : 0;
    entityAndInteriorMask = stencil - entityAndInteriorMask >= 7.9 ? 0 : 1;

    lighting *= entityAndInteriorMask;

    return lighting;
}

float4 PS_LightPointOrSpot3(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);
    
    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = DecodeGBufferNormal(texCoord);
    surfProperties.SpecularIntensity = specAoBuffer.x * 2;
    surfProperties.SpecularPower = specAoBuffer.y * specAoBuffer.y * 512;
    surfProperties.AmbientOcclusion = 1.0;
    float4 lighting = float4(ComputeDeferredLocalLighting(false, false, posWorld, viewToFragDir, screenCoords, surfProperties), 1);
    
    float stencil = tex2D(GBufferStencilTextureSampler, texCoord).x * 255;
    float interiorMask = stencil >= 128 ? 128 : 0;
    float v0 = stencil - interiorMask;
    float entityMask = v0 >= 7.9 ? -8 : -0;
    float v1 = abs(v0 + entityMask - 1);
    v1 = v1 <= 0.1 ? 1 : 0;

    lighting *= v1;

    return lighting;
}


float4 PS_FillerPointOrSpot0(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = normalize(tex2D(GBufferTextureSampler1, texCoord).xyz * 2 - 1);;
    surfProperties.SpecularIntensity = 1;
    surfProperties.SpecularPower = 1;
    surfProperties.AmbientOcclusion = 1;
    float4 lighting = float4(ComputeDeferredLocalLighting(false, true, posWorld, viewToFragDir, screenCoords, surfProperties), 1);
    
    return lighting;
}

float4 PS_FillerPointOrSpot1(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = normalize(tex2D(GBufferTextureSampler1, texCoord).xyz * 2 - 1);;
    surfProperties.SpecularIntensity = 1;
    surfProperties.SpecularPower = 1;
    surfProperties.AmbientOcclusion = 1;
    float4 lighting = float4(ComputeDeferredLocalLighting(false, true, posWorld, viewToFragDir, screenCoords, surfProperties), 1);

    float stencil = tex2D(GBufferStencilTextureSampler, texCoord).x * 255;
    float entityAndInteriorMask = stencil >= 128 ? 128 : 0;
    entityAndInteriorMask = stencil - entityAndInteriorMask >= 7.9 ? 1 : 0;

    lighting *= entityAndInteriorMask;
    
    return lighting;
}

float4 PS_FillerPointOrSpot2(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = normalize(tex2D(GBufferTextureSampler1, texCoord).xyz * 2 - 1);;
    surfProperties.SpecularIntensity = 1;
    surfProperties.SpecularPower = 1;
    surfProperties.AmbientOcclusion = 1;
    float4 lighting = float4(ComputeDeferredLocalLighting(false, true, posWorld, viewToFragDir, screenCoords, surfProperties), 1);

    float stencil = tex2D(GBufferStencilTextureSampler, texCoord).x * 255;
    float entityAndInteriorMask = stencil >= 128 ? 128 : 0;
    entityAndInteriorMask = stencil - entityAndInteriorMask >= 7.9 ? 0 : 1;

    lighting *= entityAndInteriorMask;
    
    return lighting;
}


float4 PS_DebugLightColorC(float4 color : TEXCOORD0) : COLOR
{
    return color * debugLightColour;
}

float4 PS_LightShadowPointOrSpot(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);
    
    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = DecodeGBufferNormal(texCoord);
    surfProperties.SpecularIntensity = specAoBuffer.x * 2;
    surfProperties.SpecularPower = specAoBuffer.y * specAoBuffer.y * 512;

    float ambientOcclusion = specAoBuffer.z * specAoBuffer.z;
    ambientOcclusion = saturate((ambientOcclusion * ambientOcclusion * 0.5) + ambientOcclusion);
    float stencil = tex2D(GBufferStencilTextureSampler, texCoord).x * 255;
    float entityAndInteriorMask = stencil >= 128 ? 128 : 0;
    surfProperties.AmbientOcclusion = stencil - entityAndInteriorMask >= 7.9 ? 1 : ambientOcclusion;
    
    float4 lighting = float4(ComputeDeferredLocalLighting(true, false, posWorld, viewToFragDir, screenCoords, surfProperties), 2);

    return lighting;
}

float4 PS_FillerShadowPointOrSpot(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz;
    surfProperties.Normal = normalize(tex2D(GBufferTextureSampler1, texCoord).xyz * 2 - 1);;
    surfProperties.SpecularIntensity = 1;
    surfProperties.SpecularPower = 1;
    surfProperties.AmbientOcclusion = 1;
    float4 lighting = float4(ComputeDeferredLocalLighting(true, true, posWorld, viewToFragDir, screenCoords, surfProperties), 1);
    
    return lighting;
}

float4 PS_LightTexPointOrSpot(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);
    
    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz * GetLightTexture(posWorld);
    surfProperties.Normal = normalize(tex2D(GBufferTextureSampler1, texCoord).xyz * 2 - 1);
    surfProperties.SpecularIntensity = specAoBuffer.x * 2;
    surfProperties.SpecularPower = specAoBuffer.y * specAoBuffer.y * 512;
    surfProperties.AmbientOcclusion = saturate(specAoBuffer.z * specAoBuffer.z + 0.5);
    float4 lighting = float4(ComputeDeferredLocalLighting(false, false, posWorld, viewToFragDir, screenCoords, surfProperties), 1);
    
    return lighting;
}

float4 PS_LightShadowTexPointOrSpot(VS_OutputVolumePS IN, float2 screenCoords : VPOS) : COLOR
{
    float2 texCoord = (screenCoords.xy + 0.50999999) * gooDeferredLightScreenSize.zw;

    float linearDepth = tex2D(GBufferTextureSampler3, texCoord).x * gDeferredProjParams.z - gDeferredProjParams.w;
    linearDepth *= IN.FragToViewDirAndDepth.w;
    float3 viewToFragDir = normalize(0.00001 - (IN.FragToViewDirAndDepth.xyz / linearDepth));
    float3 posWorld = gViewInverse[3].xyz - (IN.FragToViewDirAndDepth.xyz / linearDepth);
    
    float3 specAoBuffer = tex2D(GBufferTextureSampler2, texCoord).xyz;

    SurfaceProperties surfProperties;
    surfProperties.Diffuse = tex2D(GBufferTextureSampler0, texCoord).xyz * GetLightTexture(posWorld);
    surfProperties.Normal = normalize(tex2D(GBufferTextureSampler1, texCoord).xyz * 2 - 1);
    surfProperties.SpecularIntensity = specAoBuffer.x * 2;
    surfProperties.SpecularPower = specAoBuffer.y * specAoBuffer.y * 512;
    surfProperties.AmbientOcclusion = 1.0;
    float4 lighting = float4(ComputeDeferredLocalLighting(true, false, posWorld, viewToFragDir, screenCoords, surfProperties), 1);
    
    return lighting;
}

PixelShader PS_ShaftBack
<
    string GBufferTextureSampler3     = "parameter register(1)";
    string gDeferredLightRadius       = "parameter register(66)";
    string gDeferredLightSampler2     = "parameter register(0)";
    string gDeferredProjParams        = "parameter register(73)";
    string gooDeferredLightScreenSize = "parameter register(72)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler3;
    //   float gDeferredLightRadius;
    //   sampler2D gDeferredLightSampler2;
    //   float4 gDeferredProjParams;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gDeferredLightRadius       c66      1
    //   gooDeferredLightScreenSize c72      1
    //   gDeferredProjParams        c73      1
    //   gDeferredLightSampler2     s0       1
    //   GBufferTextureSampler3     s1       1
    //
    
        ps_3_0
        def c0, 0.50999999, 9.99999975e-006, 16, 1
        def c1, 0, 0, 0, 0
        def c2, 0.5, 0.125, 3.14159274, 1.5
        dcl_texcoord v0
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2.xyz
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c72.zwzw
        texld r0, r0, s1
        mad r0.x, r0.x, -c73.z, c73.w
        mul r0.x, r0.x, v0.w
        rcp r0.x, r0.x
        mov_sat r0.x, -r0.x
        mov r1.xyz, v0
        mad r0.xyz, v1, r0.x, r1
        mul r2.xyz, r1, v1.zxyw
        mad r1.xyz, r1.zxyw, v1, -r2
        mul r2.xyz, r1, v1.zxyw
        mad r1.xyz, v1.yzxw, r1.yzxw, -r2
        add r1.xyz, r1, c0.y
        nrm r2.xyz, r1
        dp3 r0.w, r2, v0
        mul r0.w, r0.w, r0.w
        mul r1.x, c66.x, c66.x
        rcp r1.x, r1.x
        mul r1.x, r1.x, c0.z
        min r2.x, r1.x, c0.z
        mad r0.w, r0.w, r2.x, c0.w
        rsq r0.w, r0.w
        rsq r1.x, r2.x
        rcp r1.x, r1.x
        mul r1.x, r0.w, r1.x
        rcp r0.w, r0.w
        mul r0.xyz, r0, r1.x
        mul r1.xyz, r1.x, v0
        dp3 r1.w, r0, r0
        dp3 r0.x, r0, r1
        dp3 r0.y, r1, r1
        add r0.y, r0.y, c0.y
        rsq r0.y, r0.y
        add r0.z, r1.w, c0.y
        rsq r0.z, r0.z
        mul r0.y, r0.y, r0.z
        mul r0.x, r0.x, r0.y
        mad r0.y, r0.x, c2.x, c2.x
        mov r0.x, c2.y
        texld r1, r0, s0
        mul r0.x, r2.x, r1.x
        mul r0.y, r2.x, c2.w
        mul r0.y, r0.w, r0.y
        rcp r0.y, r0.y
        mul r0.x, r0.x, c2.z
        mul r0.x, r0.y, r0.x
        mul oC0.xyz, r0.x, v2
        mov oC0.w, c1.x
    
    // approximately 51 instruction slots used (2 texture, 49 arithmetic)
};

PixelShader PS_ShaftFront
<
    string GBufferTextureSampler3     = "parameter register(1)";
    string gDeferredLightRadius       = "parameter register(66)";
    string gDeferredLightSampler2     = "parameter register(0)";
    string gDeferredProjParams        = "parameter register(73)";
    string gooDeferredLightScreenSize = "parameter register(72)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler3;
    //   float gDeferredLightRadius;
    //   sampler2D gDeferredLightSampler2;
    //   float4 gDeferredProjParams;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gDeferredLightRadius       c66      1
    //   gooDeferredLightScreenSize c72      1
    //   gDeferredProjParams        c73      1
    //   gDeferredLightSampler2     s0       1
    //   GBufferTextureSampler3     s1       1
    //
    
        ps_3_0
        def c0, 0.50999999, 9.99999975e-006, 16, 1
        def c1, 0, 0, 0, 0
        def c2, 0.5, 0.125, 3.14159274, 1.5
        dcl_texcoord v0
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2.xyz
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c72.zwzw
        texld r0, r0, s1
        mad r0.x, r0.x, -c73.z, c73.w
        mul r0.x, r0.x, v0.w
        rcp r0.x, r0.x
        mov_sat r0.x, -r0.x
        mov r1.xyz, v0
        mad r0.xyz, v1, r0.x, r1
        mul r2.xyz, r1, v1.zxyw
        mad r1.xyz, r1.zxyw, v1, -r2
        mul r2.xyz, r1, v1.zxyw
        mad r1.xyz, v1.yzxw, r1.yzxw, -r2
        add r1.xyz, r1, c0.y
        nrm r2.xyz, r1
        dp3 r0.w, r2, v0
        mul r0.w, r0.w, r0.w
        mul r1.x, c66.x, c66.x
        rcp r1.x, r1.x
        mul r1.x, r1.x, c0.z
        min r2.x, r1.x, c0.z
        mad r0.w, r0.w, r2.x, c0.w
        rsq r0.w, r0.w
        rsq r1.x, r2.x
        rcp r1.x, r1.x
        mul r1.x, r0.w, r1.x
        rcp r0.w, r0.w
        mul r0.xyz, r0, r1.x
        mul r1.xyz, r1.x, v0
        dp3 r1.w, r0, r0
        dp3 r0.x, r0, r1
        dp3 r0.y, r1, r1
        add r0.y, r0.y, c0.y
        rsq r0.y, r0.y
        add r0.z, r1.w, c0.y
        rsq r0.z, r0.z
        mul r0.y, r0.y, r0.z
        mul r0.x, r0.x, r0.y
        mad r0.y, r0.x, c2.x, c2.x
        mov r0.x, c2.y
        texld r1, r0, s0
        mul r0.x, r2.x, r1.x
        mul r0.y, r2.x, c2.w
        mul r0.y, r0.w, r0.y
        rcp r0.y, r0.y
        mul r0.x, r0.x, c2.z
        mul r0.x, r0.y, r0.x
        mul oC0.xyz, -r0.x, v2
        mov oC0.w, c1.x
    
    // approximately 51 instruction slots used (2 texture, 49 arithmetic)
};

PixelShader PS_ShaftBackLinear
<
    string GBufferTextureSampler3     = "parameter register(0)";
    string gDeferredLightRadius       = "parameter register(66)";
    string gDeferredProjParams        = "parameter register(73)";
    string gooDeferredLightScreenSize = "parameter register(72)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler3;
    //   float gDeferredLightRadius;
    //   float4 gDeferredProjParams;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gDeferredLightRadius       c66      1
    //   gooDeferredLightScreenSize c72      1
    //   gDeferredProjParams        c73      1
    //   GBufferTextureSampler3     s0       1
    //
    
        ps_3_0
        def c0, 0.50999999, 9.99999975e-006, 0.660000026, 0.333330005
        def c1, 0, 1, 0, 0
        dcl_texcoord v0
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2.xyz
        dcl vPos.xy
        dcl_2d s0
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c72.zwzw
        texld r0, r0, s0
        mad r0.x, r0.x, -c73.z, c73.w
        mul r0.x, r0.x, v0.w
        rcp r0.x, r0.x
        mov_sat r0.x, -r0.x
        add r0.yzw, c0.y, v1.xxyz
        nrm r1.xyz, r0.yzww
        dp3 r0.y, r1, v1
        dp3 r0.z, r1, v0
        mad r0.x, r0.y, r0.x, r0.z
        mov r1.xyz, v1
        mul r2.xyz, r1.zxyw, v0
        mad r1.xyz, v0.zxyw, r1, -r2
        mul r2.xyz, r1, v1.zxyw
        mad r1.xyz, v1.yzxw, r1.yzxw, -r2
        add r1.xyz, r1, c0.y
        nrm r2.xyz, r1
        dp3 r0.y, r2, v0
        mov r1.z, c0.z
        mad r0.w, c66.x, -r1.z, r0.y
        cmp r0.w, r0.w, c1.x, c1.y
        mul r1.x, r1.z, c66.x
        mul r1.x, r1.x, r1.x
        mad r0.y, r0.y, -r0.y, r1.x
        rcp r1.x, r1.x
        rsq r0.y, r0.y
        rcp r0.y, r0.y
        mul r0.y, r0.w, r0.y
        max r1.y, r0.x, -r0.y
        min r2.x, r0.y, r1.y
        max r1.y, r0.z, -r0.y
        min r2.y, r0.y, r1.y
        add r0.x, r2.x, -r2.y
        mul r0.x, r0.x, r0.x
        mul r0.x, r0.x, c0.w
        mul r0.x, r1.x, r0.x
        mul oC0.xyz, r0.x, v2
        mov oC0.w, c1.x
    
    // approximately 44 instruction slots used (1 texture, 43 arithmetic)
};

PixelShader PS_ShaftFrontLinear
<
    string GBufferTextureSampler3     = "parameter register(0)";
    string gDeferredLightRadius       = "parameter register(66)";
    string gDeferredProjParams        = "parameter register(73)";
    string gooDeferredLightScreenSize = "parameter register(72)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler3;
    //   float gDeferredLightRadius;
    //   float4 gDeferredProjParams;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gDeferredLightRadius       c66      1
    //   gooDeferredLightScreenSize c72      1
    //   gDeferredProjParams        c73      1
    //   GBufferTextureSampler3     s0       1
    //
    
        ps_3_0
        def c0, 0.50999999, 9.99999975e-006, 0.660000026, 0.333330005
        def c1, 0, 1, 0, 0
        dcl_texcoord v0
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2.xyz
        dcl vPos.xy
        dcl_2d s0
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c72.zwzw
        texld r0, r0, s0
        mad r0.x, r0.x, -c73.z, c73.w
        mul r0.x, r0.x, v0.w
        rcp r0.x, r0.x
        mov_sat r0.x, -r0.x
        add r0.yzw, c0.y, v1.xxyz
        nrm r1.xyz, r0.yzww
        dp3 r0.y, r1, v1
        dp3 r0.z, r1, v0
        mad r0.x, r0.y, r0.x, r0.z
        mov r1.xyz, v1
        mul r2.xyz, r1.zxyw, v0
        mad r1.xyz, v0.zxyw, r1, -r2
        mul r2.xyz, r1, v1.zxyw
        mad r1.xyz, v1.yzxw, r1.yzxw, -r2
        add r1.xyz, r1, c0.y
        nrm r2.xyz, r1
        dp3 r0.y, r2, v0
        mov r1.z, c0.z
        mad r0.w, c66.x, -r1.z, r0.y
        cmp r0.w, r0.w, c1.x, c1.y
        mul r1.x, r1.z, c66.x
        mul r1.x, r1.x, r1.x
        mad r0.y, r0.y, -r0.y, r1.x
        rcp r1.x, r1.x
        rsq r0.y, r0.y
        rcp r0.y, r0.y
        mul r0.y, r0.w, r0.y
        max r1.y, r0.x, -r0.y
        min r2.x, r0.y, r1.y
        max r1.y, r0.z, -r0.y
        min r2.y, r0.y, r1.y
        add r0.x, r2.x, -r2.y
        mul r0.x, r0.x, r0.x
        mul r0.x, r0.x, c0.w
        mul r0.x, r1.x, r0.x
        mul oC0.xyz, -r0.x, v2
        mov oC0.w, c1.x
    
    // approximately 44 instruction slots used (1 texture, 43 arithmetic)
};

PixelShader PS_ShaftBackDir
<
    string GBufferTextureSampler3     = "parameter register(0)";
    string gDeferredLightRadius       = "parameter register(66)";
    string gDeferredProjParams        = "parameter register(73)";
    string gooDeferredLightScreenSize = "parameter register(72)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler3;
    //   float gDeferredLightRadius;
    //   float4 gDeferredProjParams;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gDeferredLightRadius       c66      1
    //   gooDeferredLightScreenSize c72      1
    //   gDeferredProjParams        c73      1
    //   GBufferTextureSampler3     s0       1
    //
    
        ps_3_0
        def c0, 0, 1, 3, 0
        def c1, 0.50999999, 9.99999975e-006, 0.660000026, 0.333330005
        dcl_texcoord v0
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2.xyz
        dcl vPos.xy
        dcl_2d s0
        add r0.xy, c1.x, vPos
        mul r0.xy, r0, c72.zwzw
        texld r0, r0, s0
        mad r0.x, r0.x, -c73.z, c73.w
        mul r0.x, r0.x, v0.w
        rcp r0.x, r0.x
        mov_sat r0.x, -r0.x
        add r0.yzw, c1.y, v1.xxyz
        nrm r1.xyz, r0.yzww
        dp3 r0.y, r1, v1
        dp3 r0.z, r1, v0
        mad r0.x, r0.y, r0.x, r0.z
        mov r1.xyz, v1
        mul r2.xyz, r1.zxyw, v0
        mad r1.xyz, v0.zxyw, r1, -r2
        mul r2.xyz, r1, v1.zxyw
        mad r1.xyz, v1.yzxw, r1.yzxw, -r2
        add r1.xyz, r1, c1.y
        nrm r2.xyz, r1
        dp3 r0.y, r2, v0
        mov r1.z, c1.z
        mad r0.w, c66.x, -r1.z, r0.y
        cmp r0.w, r0.w, c0.x, c0.y
        mul r1.x, r1.z, c66.x
        mul r1.x, r1.x, r1.x
        mad r0.y, r0.y, -r0.y, r1.x
        rcp r1.x, r1.x
        rsq r0.y, r0.y
        rcp r0.y, r0.y
        mul r0.y, r0.w, r0.y
        max r1.y, r0.x, -r0.y
        min r2.x, r0.y, r1.y
        max r1.y, r0.z, -r0.y
        min r2.y, r0.y, r1.y
        add r0.x, r2.x, -r2.y
        mul r0.x, r0.x, r0.x
        mul r0.x, r0.x, c1.w
        mul r0.x, r1.x, r0.x
        mul r0.xyz, r0.x, v2
        mul oC0.xyz, r0, c0.z
        mov oC0.w, c0.x
    
    // approximately 45 instruction slots used (1 texture, 44 arithmetic)
};

PixelShader PS_ShaftFrontDir
<
    string GBufferTextureSampler3     = "parameter register(0)";
    string gDeferredLightRadius       = "parameter register(66)";
    string gDeferredProjParams        = "parameter register(73)";
    string gooDeferredLightScreenSize = "parameter register(72)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler3;
    //   float gDeferredLightRadius;
    //   float4 gDeferredProjParams;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gDeferredLightRadius       c66      1
    //   gooDeferredLightScreenSize c72      1
    //   gDeferredProjParams        c73      1
    //   GBufferTextureSampler3     s0       1
    //
    
        ps_3_0
        def c0, 0, 1, 3, 0
        def c1, 0.50999999, 9.99999975e-006, 0.660000026, 0.333330005
        dcl_texcoord v0
        dcl_texcoord1 v1.xyz
        dcl_texcoord2 v2.xyz
        dcl vPos.xy
        dcl_2d s0
        add r0.xy, c1.x, vPos
        mul r0.xy, r0, c72.zwzw
        texld r0, r0, s0
        mad r0.x, r0.x, -c73.z, c73.w
        mul r0.x, r0.x, v0.w
        rcp r0.x, r0.x
        mov_sat r0.x, -r0.x
        add r0.yzw, c1.y, v1.xxyz
        nrm r1.xyz, r0.yzww
        dp3 r0.y, r1, v1
        dp3 r0.z, r1, v0
        mad r0.x, r0.y, r0.x, r0.z
        mov r1.xyz, v1
        mul r2.xyz, r1.zxyw, v0
        mad r1.xyz, v0.zxyw, r1, -r2
        mul r2.xyz, r1, v1.zxyw
        mad r1.xyz, v1.yzxw, r1.yzxw, -r2
        add r1.xyz, r1, c1.y
        nrm r2.xyz, r1
        dp3 r0.y, r2, v0
        mov r1.z, c1.z
        mad r0.w, c66.x, -r1.z, r0.y
        cmp r0.w, r0.w, c0.x, c0.y
        mul r1.x, r1.z, c66.x
        mul r1.x, r1.x, r1.x
        mad r0.y, r0.y, -r0.y, r1.x
        rcp r1.x, r1.x
        rsq r0.y, r0.y
        rcp r0.y, r0.y
        mul r0.y, r0.w, r0.y
        max r1.y, r0.x, -r0.y
        min r2.x, r0.y, r1.y
        max r1.y, r0.z, -r0.y
        min r2.y, r0.y, r1.y
        add r0.x, r2.x, -r2.y
        mul r0.x, r0.x, r0.x
        mul r0.x, r0.x, c1.w
        mul r0.x, r1.x, r0.x
        mul r0.xyz, -r0.x, v2
        mul oC0.xyz, r0, c0.z
        mov oC0.w, c0.x
    
    // approximately 45 instruction slots used (1 texture, 44 arithmetic)
};

PixelShader PS_Corona
<
    string gDeferredLightSampler = "parameter register(0)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D gDeferredLightSampler;
    //
    //
    // Registers:
    //
    //   Name                  Reg   Size
    //   --------------------- ----- ----
    //   gDeferredLightSampler s0       1
    //
    
        ps_3_0
        def c0, 1, 0, 0, 0
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl_2d s0
        texld r0, v0, s0
        mul oC0.xyz, r0, v1
        mov oC0.w, c0.x
    
    // approximately 3 instruction slots used (1 texture, 2 arithmetic)
};

PixelShader PS_Corona_PB
<
    string gDeferredLightSampler = "parameter register(0)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D gDeferredLightSampler;
    //
    //
    // Registers:
    //
    //   Name                  Reg   Size
    //   --------------------- ----- ----
    //   gDeferredLightSampler s0       1
    //
    
        ps_3_0
        def c0, 1, 0, 0, 0
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl_2d s0
        texld r0, v0, s0
        mul oC0.xyz, r0, v1
        mov oC0.w, c0.x
    
    // approximately 3 instruction slots used (1 texture, 2 arithmetic)
};

PixelShader PS_Brightlight
<
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        ps_3_0
        def c0, 1, 0, 0, 0
        dcl_texcoord v0.xyz
        mad oC0, v0.xyzx, c0.xxxy, c0.yyyx
    
    // approximately 1 instruction slot used
};

PixelShader PS_SmokeBoard
<
    string gDeferredLightSampler = "parameter register(0)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D gDeferredLightSampler;
    //
    //
    // Registers:
    //
    //   Name                  Reg   Size
    //   --------------------- ----- ----
    //   gDeferredLightSampler s0       1
    //
    
        ps_3_0
        def c0, 0.333332986, 1, 0, 0
        dcl_texcoord v0.xy
        dcl_color v1.w
        dcl_2d s0
        texld r0, v0, s0
        dp3 r0.x, r0, c0.x
        mul oC0.w, r0.x, v1.w
        mov oC0.xyz, c0.y
    
    // approximately 4 instruction slots used (1 texture, 3 arithmetic)
};

PixelShader PS_WaterFx
<
    string GBufferTextureSampler3     = "parameter register(1)";
    string gDeferredLightSampler      = "parameter register(0)";
    string gDeferredProjParams        = "parameter register(72)";
    string gViewInverse               = "parameter register(12)";
    string gooDeferredLightScreenSize = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler3;
    //   sampler2D gDeferredLightSampler;
    //   float4 gDeferredProjParams;
    //   row_major float4x4 gViewInverse;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gViewInverse               c12      4
    //   gooDeferredLightScreenSize c66      1
    //   gDeferredProjParams        c72      1
    //   gDeferredLightSampler      s0       1
    //   GBufferTextureSampler3     s1       1
    //
    
        ps_3_0
        def c0, 0.50999999, 0, 0.5, 0
        dcl_color v0
        dcl_texcoord v1.xyw
        dcl_texcoord1 v2
        dcl_texcoord2 v3.xyw
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c66.zwzw
        texld r0, r0, s1
        mad r0.x, r0.x, c72.z, -c72.w
        mul r0.x, r0.x, v1.w
        rcp r0.x, r0.x
        mad r0.xy, v1, -r0.x, c15
        add r0.xy, r0, -v3
        dp2add r1.x, v2, r0, c0.y
        dp2add r1.y, v2.zwzw, r0, c0.y
        mul r0.x, c0.z, v3.w
        mad r0.xy, r1, r0.x, c0.z
        texld r0, r0, s0
        mul oC0, r0, v0
    
    // approximately 16 instruction slots used (2 texture, 14 arithmetic)
};

PixelShader PS_AmbientScaleTexture
<
    string GBufferTextureSampler1           = "parameter register(1)";
    string GBufferTextureSampler3           = "parameter register(2)";
    string gDeferredLightColourAndIntensity = "parameter register(77)";
    string gDeferredLightConeOffset         = "parameter register(75)";
    string gDeferredLightConeScale          = "parameter register(76)";
    string gDeferredLightDirection          = "parameter register(72)";
    string gDeferredLightPosition           = "parameter register(66)";
    string gDeferredLightRadius             = "parameter register(74)";
    string gDeferredLightSampler            = "parameter register(0)";
    string gDeferredLightTangent            = "parameter register(73)";
    string gDeferredProjParams              = "parameter register(79)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(78)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightPosition;
    //   float gDeferredLightRadius;
    //   sampler2D gDeferredLightSampler;
    //   float3 gDeferredLightTangent;
    //   float4 gDeferredProjParams;
    //   row_major float4x4 gViewInverse;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gViewInverse                     c12      4
    //   gDeferredLightPosition           c66      1
    //   gDeferredLightDirection          c72      1
    //   gDeferredLightTangent            c73      1
    //   gDeferredLightRadius             c74      1
    //   gDeferredLightConeOffset         c75      1
    //   gDeferredLightConeScale          c76      1
    //   gDeferredLightColourAndIntensity c77      1
    //   gooDeferredLightScreenSize       c78      1
    //   gDeferredProjParams              c79      1
    //   gDeferredLightSampler            s0       1
    //   GBufferTextureSampler1           s1       1
    //   GBufferTextureSampler3           s2       1
    //
    
        ps_3_0
        def c0, 0.50999999, 2, -0.999989986, 2.20000005
        def c1, 1.79999995, 0.5, 0, 1
        def c2, 3, 0, 0, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        mov r0.xyz, c72
        mul r1.xyz, r0.zxyw, c73.yzxw
        mad r0.xyz, r0.yzxw, c73.zxyw, -r1
        add r1.xy, c0.x, vPos
        mul r1.xy, r1, c78.zwzw
        texld r2, r1, s2
        texld r1, r1, s1
        mad r1.xyz, r1, c0.y, c0.z
        nrm r3.xyz, r1
        dp3 r0.w, c72, r3
        mad r1.x, r2.x, c79.z, -c79.w
        mul r1.x, r1.x, v0.w
        rcp r1.x, r1.x
        mad r1.xyz, v0, -r1.x, c15
        add r1.xyz, -r1, c66
        dp3 r0.x, r0, r1
        mov r1.w, c0.w
        mul r0.y, r1.w, c75.x
        rcp r0.y, r0.y
        mul r0.x, r0.x, r0.y
        dp3 r0.z, c73, r1
        dp3 r1.x, -c72, r1
        mov r2.x, c1.x
        mul r1.y, r2.x, c76.x
        rcp r1.y, r1.y
        mul r0.y, r0.z, r1.y
        mad r2.xy, r0, c1.y, c1.y
        mov r2.zw, c1.z
        texldl r2, r2, s0
        cmp r0.x, r1.x, c1.z, c1.w
        cmp r0.y, -r1.x, -c1.z, -c1.w
        add r0.z, r1.x, -c74.x
        add r0.x, r0.x, r0.y
        mul_sat r0.x, r0.w, r0.x
        mul r0.x, r0.x, r0.x
        mul r0.x, r2.x, r0.x
        add r0.y, c74.x, c74.x
        rcp r0.y, r0.y
        mad_sat r0.y, r0.z, -r0.y, c1.w
        mul r0.y, r0.y, r0.y
        mul r0.x, r0.x, r0.y
        mul r0.x, r0.x, c77.w
        mul oC0.w, r0.x, c2.x
        mov oC0.xyz, c1.z
    
    // approximately 47 instruction slots used (4 texture, 43 arithmetic)
};

PixelShader PS_AmbientScaleEllipsoid
<
    string GBufferTextureSampler1           = "parameter register(0)";
    string GBufferTextureSampler3           = "parameter register(1)";
    string gDeferredLightColourAndIntensity = "parameter register(74)";
    string gDeferredLightConeOffset         = "parameter register(73)";
    string gDeferredLightDirection          = "parameter register(66)";
    string gDeferredLightTangent            = "parameter register(72)";
    string gDeferredProjParams              = "parameter register(76)";
    string gViewInverse                     = "parameter register(12)";
    string globalScalars2                   = "parameter register(40)";
    string gooDeferredLightScreenSize       = "parameter register(75)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float3 gDeferredLightDirection;
    //   float3 gDeferredLightTangent;
    //   float4 gDeferredProjParams;
    //   row_major float4x4 gViewInverse;
    //   float4 globalScalars2;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gViewInverse                     c12      4
    //   globalScalars2                   c40      1
    //   gDeferredLightDirection          c66      1
    //   gDeferredLightTangent            c72      1
    //   gDeferredLightConeOffset         c73      1
    //   gDeferredLightColourAndIntensity c74      1
    //   gooDeferredLightScreenSize       c75      1
    //   gDeferredProjParams              c76      1
    //   GBufferTextureSampler1           s0       1
    //   GBufferTextureSampler3           s1       1
    //
    
        ps_3_0
        def c0, 0.50999999, 2, -0.999989986, 9.99999975e-006
        def c1, 0.5, 1, 4, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        mov r0.xyz, c72
        add r1.xyz, r0, c66
        mad r2.xyz, r1, -c1.x, r0
        dp3 r0.w, r2, r2
        rsq r0.w, r0.w
        rcp r0.w, r0.w
        add r0.w, r0.w, c73.x
        rcp r0.w, r0.w
        mul r0.w, r0.w, c73.x
        add r2.xy, c0.x, vPos
        mul r2.xy, r2, c75.zwzw
        texld r3, r2, s1
        texld r2, r2, s0
        mad r2.xyz, r2, c0.y, c0.z
        nrm r4.xyz, r2
        mad r1.w, r3.x, c76.z, -c76.w
        mul r1.w, r1.w, v0.w
        rcp r1.w, r1.w
        mad r2.xyz, v0, -r1.w, c15
        mad r1.xyz, r1, -c1.x, r2
        add r0.xyz, r0, -c66
        add r0.xyz, r0, c0.w
        nrm r2.xyz, r0
        dp3 r0.x, r1, r2
        mad r0.x, r0.x, r0.w, -r0.x
        mad r0.xyz, r2, r0.x, r1
        dp3 r0.w, r4, -r0
        dp3 r0.x, -r0, -r0
        rsq r0.x, r0.x
        mul_sat r0.y, r4.z, c1.z
        mul_sat r0.z, r0.w, r0.x
        rcp r0.x, r0.x
        mul r0.z, r0.z, r0.z
        rcp r0.w, c73.x
        mad_sat r0.x, r0.x, -r0.w, c1.y
        mul r0.x, r0.z, r0.x
        mul r0.x, r0.x, c74.w
        mul r0.x, r0.y, r0.x
        mul oC0.w, r0.x, c40.z
        mov oC0.xyz, c1.w
    
    // approximately 44 instruction slots used (2 texture, 42 arithmetic)
};

PixelShader PS_GBufferCopy0
<
    string GBufferTextureSampler0     = "parameter register(0)";
    string gooDeferredLightScreenSize = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler0;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gooDeferredLightScreenSize c66      1
    //   GBufferTextureSampler0     s0       1
    //
    
        ps_3_0
        def c0, 0.50999999, 0, 0, 0
        dcl vPos.xy
        dcl_2d s0
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c66.zwzw
        texld oC0, r0, s0
    
    // approximately 3 instruction slots used (1 texture, 2 arithmetic)
};

PixelShader PS_GBufferCopy1
<
    string GBufferTextureSampler1     = "parameter register(0)";
    string gooDeferredLightScreenSize = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler1;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gooDeferredLightScreenSize c66      1
    //   GBufferTextureSampler1     s0       1
    //
    
        ps_3_0
        def c0, 0.50999999, 0, 0, 0
        dcl vPos.xy
        dcl_2d s0
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c66.zwzw
        texld oC0, r0, s0
    
    // approximately 3 instruction slots used (1 texture, 2 arithmetic)
};

PixelShader PS_GBufferCopy2
<
    string GBufferTextureSampler2     = "parameter register(0)";
    string gooDeferredLightScreenSize = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler2;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gooDeferredLightScreenSize c66      1
    //   GBufferTextureSampler2     s0       1
    //
    
        ps_3_0
        def c0, 0.50999999, 0, 0, 0
        dcl vPos.xy
        dcl_2d s0
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c66.zwzw
        texld oC0, r0, s0
    
    // approximately 3 instruction slots used (1 texture, 2 arithmetic)
};

PixelShader PS_DepthCopy0
<
    string depthSourceSampler         = "parameter register(0)";
    string gooDeferredLightScreenSize = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D depthSourceSampler;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gooDeferredLightScreenSize c66      1
    //   depthSourceSampler         s0       1
    //
    
        ps_3_0
        def c0, 0.50999999, 0, 1, 0
        dcl vPos.xy
        dcl_2d s0
        mov oC0, c0.yyyz
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c66.zwzw
        texld r0, r0, s0
        mov oDepth, r0.x
    
    // approximately 5 instruction slots used (1 texture, 4 arithmetic)
};

PixelShader PS_DebugAlphaDepth
<
    string GBufferTextureSampler3     = "parameter register(1)";
    string gDeferredLightSampler      = "parameter register(0)";
    string gooDeferredLightScreenSize = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler3;
    //   sampler2D gDeferredLightSampler;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gooDeferredLightScreenSize c66      1
    //   gDeferredLightSampler      s0       1
    //   GBufferTextureSampler3     s1       1
    //
    
        ps_3_0
        def c0, 0.50999999, 1, 1199.94995, -1200
        def c1, -60, 5, 1, -0.00100000005
        def c2, 1, 0, 0, 0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c66.zwzw
        texld r1, r0, s0
        texld r0, r0, s1
        add r0.x, -r0.x, c0.y
        mad r0.x, r0.x, c0.z, c0.w
        rcp r0.x, r0.x
        add r0.y, -r1.x, c0.y
        mad r0.y, r0.y, c0.z, c0.w
        rcp r0.y, r0.y
        mul r0.y, r0.y, c1.x
        mad r0.x, r0.x, c1.x, -r0.y
        add r0.y, r0_abs.x, c1.w
        mad r0.x, r0_abs.x, -c1.y, c1.z
        cmp r0.y, r0.y, c2.x, c2.y
        mul r0.y, r0.x, r0.y
        cmp oC0.w, r0.x, r0.y, c2.y
        mov oC0.xyz, c2.xyyw
    
    // approximately 18 instruction slots used (2 texture, 16 arithmetic)
};

PixelShader PS_DebugShadowCasters
<
    string GBufferTextureSampler3     = "parameter register(0)";
    string gDeferredProjParams        = "parameter register(72)";
    string gFacetCentre               = "parameter register(54)";
    string gShadowMatrix              = "parameter register(60)";
    string gShadowParam0123           = "parameter register(57)";
    string gShadowParam14151617       = "parameter register(56)";
    string gShadowParam4567           = "parameter register(58)";
    string gShadowParam891113         = "parameter register(59)";
    string gShadowZSamplerDir         = "parameter register(15)";
    string gViewInverse               = "parameter register(12)";
    string gooDeferredLightScreenSize = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredProjParams;
    //   float4 gFacetCentre;
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam4567;
    //   float4 gShadowParam891113;
    //   sampler2D gShadowZSamplerDir;
    //   row_major float4x4 gViewInverse;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gViewInverse               c12      4
    //   gFacetCentre               c54      1
    //   gShadowParam14151617       c56      1
    //   gShadowParam0123           c57      1
    //   gShadowParam4567           c58      1
    //   gShadowParam891113         c59      1
    //   gShadowMatrix              c60      4
    //   gooDeferredLightScreenSize c66      1
    //   gDeferredProjParams        c72      1
    //   GBufferTextureSampler3     s0       1
    //   gShadowZSamplerDir         s15      1
    //
    
        ps_3_0
        def c0, 0.50999999, 2, -1, -0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s15
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c66.zwzw
        texld r1, r0, s0
        mad r0.xy, r0, c0.y, c0.z
        mad r0.z, r1.x, c72.z, -c72.w
        mul r1, r0.y, c13
        mad r1, r0.x, c12, r1
        add r1, r1, c14
        mul r0.x, r0.z, r1.w
        rcp r0.x, r0.x
        mad r0.xyz, r1, -r0.x, c15
        mul r1.xyz, r0.y, c61.xyww
        mad r1.xyz, r0.x, c60.xyww, r1
        mad r1.xyz, r0.z, c62.xyww, r1
        dp3 r0.x, c14, r0
        add r0.xyz, -r0.x, -c54
        cmp r0.yzw, r0.xxyz, -c0.z, -c0.w
        add r1.xyz, r1, c63.xyww
        mov r0.x, -c0.z
        dp4 r2.x, r0, c57
        dp4 r2.y, r0, c58
        dp4 r3.x, r0, c59
        dp4 r3.y, r0, c56
        mad r0.xy, r1, r2, r3
        texld r0, r0, s15
        add r0.x, r1.z, -r0.x
        cmp oC0.w, r0.x, -c0.z, -c0.w
        mov oC0.xyz, -c0.wwzw
    
    // approximately 28 instruction slots used (2 texture, 26 arithmetic)
};

PixelShader PS_DebugNoDiffTex
<
    string gDeferredLightColourAndIntensity = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDeferredLightColourAndIntensity;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gDeferredLightColourAndIntensity c66      1
    //
    
        ps_3_0
        def c0, 1, 0, 0, 0
        mov r0.xy, c0
        mad oC0, c66.xyzx, r0.xxxy, r0.yyyx
    
    // approximately 2 instruction slots used
};

PixelShader PS_DebugShowOverdraw
<
    string gDeferredLightColourAndIntensity = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDeferredLightColourAndIntensity;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gDeferredLightColourAndIntensity c66      1
    //
    
        ps_3_0
        def c0, 1, 0, 0, 0
        mov r0.xy, c0
        mad oC0, c66.xyzx, r0.xxxy, r0.yyyx
    
    // approximately 2 instruction slots used
};

PixelShader PS_DebugShowNormals
<
    string gDeferredLightSampler      = "parameter register(0)";
    string gooDeferredLightScreenSize = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D gDeferredLightSampler;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                       Reg   Size
    //   -------------------------- ----- ----
    //   gooDeferredLightScreenSize c66      1
    //   gDeferredLightSampler      s0       1
    //
    
        ps_3_0
        def c0, 1, 0, 0, 0
        dcl vPos.xy
        dcl_2d s0
        mul r0.x, c66.z, vPos.x
        mov r0.w, c66.w
        mad r0.y, vPos.y, -r0.w, c0.x
        texld oC0, r0, s0
    
    // approximately 4 instruction slots used (1 texture, 3 arithmetic)
};

PixelShader PS_RefMipBlur
<
    string gDeferredLightColourAndIntensity = "parameter register(66)";
    string gDeferredLightSampler            = "parameter register(0)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDeferredLightColourAndIntensity;
    //   sampler2D gDeferredLightSampler;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gDeferredLightColourAndIntensity c66      1
    //   gDeferredLightSampler            s0       1
    //
    
        ps_3_0
        def c0, 1, 0, 0.25, 0
        dcl_texcoord v0.xy
        dcl_2d s0
        //float3 color = tex2Dlod(float3(gDeferredLightSampler, IN.TexCoord, 0, gDeferredLightColourAndIntensity.w));
        mul r0.xyz, c0.xxyw, v0.xyxw
        mov r0.w, c66.z
        texldl r0, r0, s0
        //color.xyz *= pow(gDeferredLightColourAndIntensity.w, 0.25);
        abs r0.w, c66.w
        pow r1.x, r0.w, c0.z
        mul oC0.xyz, r0, r1.x
        //1
        mov oC0.w, c0.x
    
    // approximately 10 instruction slots used (2 texture, 8 arithmetic)
};

PixelShader PS_RefBlend
<
    string gDeferredLightColourAndIntensity = "parameter register(66)";
    string gDeferredLightSampler            = "parameter register(0)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDeferredLightColourAndIntensity;
    //   sampler2D gDeferredLightSampler;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gDeferredLightColourAndIntensity c66      1
    //   gDeferredLightSampler            s0       1
    //
    
        ps_3_0
        def c0, 1, 0, 0, 0
        dcl_texcoord v0.xy
        dcl_2d s0
        //float3 color = tex2Dlod(float3(gDeferredLightSampler, IN.TexCoord, 0, gDeferredLightColourAndIntensity.w));
        mul r0.xyz, c0.xxyw, v0.xyxw
        mov r0.w, c66.z
        texldl r0, r0, s0
        //color.xyz;
        mov oC0.xyz, r0
        //gDeferredLightColourAndIntensity
        mov oC0.w, c66.w
    
    // approximately 6 instruction slots used (2 texture, 4 arithmetic)
};

technique lightShadowDirectional
{
    pass p0
    {
        ZEnable = false;
        ZWriteEnable = false;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransformS;
        PixelShader = compile ps_3_0 PS_LightShadowDirectionalAmbientReflectionDry();
    }
    pass p1
    {
        ZEnable = false;
        ZWriteEnable = false;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransformS;
        PixelShader = compile ps_3_0 PS_LightShadowDirectionalAmbientReflectionWet();
    }
}

technique lightNoDirectional
{
    pass p0
    {
        ZEnable = false;
        ZWriteEnable = false;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransformS;
        PixelShader = compile ps_3_0 PS_LightAmbientReflectionDry();
    }
    pass p1
    {
        ZEnable = false;
        ZWriteEnable = false;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransformS;
        PixelShader = compile ps_3_0 PS_LightAmbientReflectionWet();
    }
}

technique stencilVolumePoint
{
    pass p0
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;

        VertexShader = VS_VolumeTransformPS0;
        PixelShader = compile ps_3_0 PS_StencilVolume();
    }
    pass p1
    {
        CullMode = NONE;
        ZEnable = true;
        ZWriteEnable = false;

        VertexShader = VS_VolumeTransformPS0;
        PixelShader = compile ps_3_0 PS_StencilVolume();
    }
    pass p2
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;

        VertexShader = VS_VolumeShadowTransformPS0;
        PixelShader = compile ps_3_0 PS_StencilVolume();
    }
    pass p3
    {
        CullMode = NONE;
        ZEnable = true;
        ZWriteEnable = false;

        VertexShader = VS_VolumeShadowTransformPS0;
        PixelShader = compile ps_3_0 PS_StencilVolume();
    }
}

technique lightVolumePoint
{
    pass p0
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_LightPointOrSpot0();
    }
    pass p1
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_LightPointOrSpot1();
    }
    pass p2
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_LightPointOrSpot2();
    }
    pass p3
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_LightPointOrSpot3();
    }
}

technique fillerVolumePoint
{
    pass p0
    {
        CullMode = CCW;
        ZWriteEnable = false;
        ZEnable = true;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_FillerPointOrSpot0();
    }
    //interior and player only
    pass p1
    {
        CullMode = CCW;
        ZWriteEnable = false;
        ZEnable = true;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_FillerPointOrSpot1();
    }
    //everything but interior and player
    pass p2
    {
        CullMode = CCW;
        ZWriteEnable = false;
        ZEnable = true;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_FillerPointOrSpot2();
    }
}

technique debugVolumePoint
{
    pass p0
    {
        CullMode = CCW;
        ZWriteEnable = false;
        ZEnable = true;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPSC;
        PixelShader = compile ps_3_0 PS_DebugLightColorC();
    }
    pass p1
    {
        CullMode = CCW;
        ZWriteEnable = false;
        ZEnable = true;
        ZFunc = GREATER;

        VertexShader = VS_VolumeShadowTransformPSC;
        PixelShader = compile ps_3_0 PS_DebugLightColorC();
    }
}

technique lightVolumeShadowPoint
{
    pass p0
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_LightShadowPointOrSpot();
    }
    pass p1
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeShadowTransformPS;
        PixelShader = compile ps_3_0 PS_LightShadowPointOrSpot();
    }
}

technique fillerVolumeShadowPoint
{
    pass p0
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_FillerShadowPointOrSpot();
    }
    pass p1
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeShadowTransformPS;
        PixelShader = compile ps_3_0 PS_FillerShadowPointOrSpot();
    }
}

technique lightVolumeTexPoint
{
    pass p0
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_LightTexPointOrSpot();
    }
}

technique lightVolumeShadowTexPoint
{
    pass p0
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = compile ps_3_0 PS_LightShadowTexPointOrSpot();
    }
    pass p1
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeShadowTransformPS;
        PixelShader = compile ps_3_0 PS_LightShadowTexPointOrSpot();
    }
}

technique lightShafts
{
    pass p0
    {
        CullMode = CCW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftTransformPointSpot;
        PixelShader = PS_ShaftBack;
    }
    pass p1
    {
        CullMode = CW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftTransformPointSpot;
        PixelShader = PS_ShaftFront;
    }
    pass p2
    {
        CullMode = CCW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftShadowTransformPointSpot;
        PixelShader = PS_ShaftBack;
    }
    pass p3
    {
        CullMode = CW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftShadowTransformPointSpot;
        PixelShader = PS_ShaftFront;
    }
    pass p4
    {
        CullMode = CCW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftTransformPointSpot;
        PixelShader = PS_ShaftBackLinear;
    }
    pass p5
    {
        CullMode = CW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftTransformPointSpot;
        PixelShader = PS_ShaftFrontLinear;
    }
    pass p6
    {
        CullMode = CCW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftShadowTransformPointSpot;
        PixelShader = PS_ShaftBackLinear;
    }
    pass p7
    {
        CullMode = CW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftShadowTransformPointSpot;
        PixelShader = PS_ShaftFrontLinear;
    }
    pass p8
    {
        CullMode = CCW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftTransformDir;
        PixelShader = PS_ShaftBackDir;
    }
    pass p9
    {
        CullMode = CW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftTransformDir;
        PixelShader = PS_ShaftFrontDir;
    }
    pass p10
    {
        CullMode = CCW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftShadowTransformDir;
        PixelShader = PS_ShaftBackDir;
    }
    pass p11
    {
        CullMode = CW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_ShaftShadowTransformDir;
        PixelShader = PS_ShaftFrontDir;
    }
}

technique corona
{
    pass p0
    {
        CullMode = CW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_Corona;
        PixelShader = PS_Corona;
    }
    pass p1
    {
        CullMode = CW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_Corona_R;
        PixelShader = PS_Corona;
    }
}

technique paraboloid_corona
{
    pass p0
    {
        CullMode = CW;
        ZEnable = true;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = ONE;
        DestBlend = ONE;

        VertexShader = VS_Corona_PB;
        PixelShader = PS_Corona_PB;
    }
}

technique brightlight
{
    pass p0
    {
        CullMode = CW;
        StencilEnable = false;
        ZEnable = true;
        ZWriteEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = false;

        VertexShader = VS_Brightlight;
        PixelShader = PS_Brightlight;
    }
}

technique smokeBoard
{
    pass p0
    {
        CullMode = CW;
        ZEnable = false;
        ZWriteEnable = false;
        StencilEnable = false;
        AlphaTestEnable = false;
        AlphaBlendEnable = true;
        BlendOp = ADD;
        SrcBlend = SRCALPHA;
        DestBlend = INVSRCALPHA;

        VertexShader = VS_SmokeBoard;
        PixelShader = PS_SmokeBoard;
    }
}

technique waterFx
{
    pass p0
    {
        ZEnable = true;
        ZWriteEnable = false;

        VertexShader = VS_VolumeTransformWaterFx;
        PixelShader = PS_WaterFx;
    }
}

technique ambientScaleVolume
{
    pass p0
    {
        ZEnable = true;
        ZWriteEnable = false;
        CullMode = CCW;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformP;
        PixelShader = PS_AmbientScaleTexture;
    }
    pass p1
    {
        ZEnable = true;
        ZWriteEnable = false;
        CullMode = CCW;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPSP;
        PixelShader = PS_AmbientScaleEllipsoid;
    }
}

technique gbufferDepthCopy
{
    pass p0
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransform();
        PixelShader = PS_GBufferCopy0;
    }
    pass p1
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransform();
        PixelShader = PS_GBufferCopy1;
    }
    pass p2
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransform();
        PixelShader = PS_GBufferCopy2;
    }
    pass p3
    {
        CullMode = NONE;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransform();
        PixelShader = PS_DepthCopy0;
    }
    pass p4
    {
        CullMode = NONE;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransform();
        PixelShader = PS_DepthCopy0;
    }
    pass p5
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransform();
        PixelShader = PS_DebugAlphaDepth;
    }
    pass p6
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransform();
        PixelShader = PS_DebugShadowCasters;
    }
    pass p7
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransform();
        PixelShader = PS_DebugNoDiffTex;
    }
    pass p8
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransform();
        PixelShader = PS_DebugShowOverdraw;
    }
    pass p9
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransform();
        PixelShader = PS_DebugShowNormals;
    }
}

technique refMipBlur
{
    pass p0
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ScreenTransformT();
        PixelShader = PS_RefMipBlur;
    }
    pass p1
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaBlendEnable = true;
        AlphaTestEnable = false;
        SrcBlend = SRCALPHA;
        DestBlend = INVSRCALPHA;

        VertexShader = compile vs_3_0 VS_ScreenTransformT();
        PixelShader = PS_RefBlend;
    }
}


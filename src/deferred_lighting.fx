#include "common_globals.fxh"

float shadowmap_res : ShadowMapResolution = 1280.0;
float4 dShadowParam0123 : dShadowParam0123;
float4 dShadowParam4567 : dShadowParam4567;
float4 dShadowParam891113 : dShadowParam891113;
float4 dShadowOffsetScale : dShadowOffsetScale;
float4x4 dShadowMatrix : dShadowMatrix;
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

VertexShader VS_ScreenTransform
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
        mad o0, v0.xyxx, c0.xxyy, c0.zzyw
    
    // approximately 1 instruction slot used
};

VertexShader VS_ScreenTransformT
<
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        vs_3_0
        def c0, 2, 0, -1, 1
        dcl_position v0
        dcl_texcoord v1
        dcl_position o0
        dcl_texcoord o1
        mad o0, v0.xyxx, c0.xxyy, c0.zzyw
        mov o1, v1
    
    // approximately 2 instruction slots used
};

//Pixel shaders
PixelShader PixelShader0 = NULL;

PixelShader PS_LightShadowDirectionalAmbientReflectionDry
<
    string GBufferTextureSampler0 = "parameter register(0)";
    string GBufferTextureSampler1 = "parameter register(1)";
    string GBufferTextureSampler2 = "parameter register(2)";
    string GBufferTextureSampler3 = "parameter register(4)";
    string ParabSampler           = "parameter register(5)";
    string dReflectionParams      = "parameter register(72)";
    string gDeferredProjParams    = "parameter register(66)";
    string gDirectionalColour     = "parameter register(18)";
    string gDirectionalLight      = "parameter register(17)";
    string gFacetCentre           = "parameter register(54)";
    string gLightAmbient0         = "parameter register(37)";
    string gLightAmbient1         = "parameter register(38)";
    string gShadowMatrix          = "parameter register(60)";
    string gShadowParam0123       = "parameter register(57)";
    string gShadowParam14151617   = "parameter register(56)";
    string gShadowParam18192021   = "parameter register(53)";
    string gShadowParam4567       = "parameter register(58)";
    string gShadowParam891113     = "parameter register(59)";
    string gShadowZSamplerDir     = "parameter register(15)";
    string gViewInverse           = "parameter register(12)";
    string globalScalars          = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   sampler2D ParabSampler;
    //   float4 dReflectionParams;
    //   float4 gDeferredProjParams;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float4 gFacetCentre;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam18192021;
    //   float4 gShadowParam4567;
    //   float4 gShadowParam891113;
    //   sampler2D gShadowZSamplerDir;
    //   row_major float4x4 gViewInverse;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name                   Reg   Size
    //   ---------------------- ----- ----
    //   gViewInverse           c12      4
    //   gDirectionalLight      c17      1
    //   gDirectionalColour     c18      1
    //   gLightAmbient0         c37      1
    //   gLightAmbient1         c38      1
    //   globalScalars          c39      1
    //   gShadowParam18192021   c53      1
    //   gFacetCentre           c54      1
    //   gShadowParam14151617   c56      1
    //   gShadowParam0123       c57      1
    //   gShadowParam4567       c58      1
    //   gShadowParam891113     c59      1
    //   gShadowMatrix          c60      4
    //   gDeferredProjParams    c66      1
    //   dReflectionParams      c72      1
    //   GBufferTextureSampler0 s0       1
    //   GBufferTextureSampler1 s1       1
    //   GBufferTextureSampler2 s2       1
    //   GBufferTextureSampler3 s4       1
    //   ParabSampler           s5       1
    //   gShadowZSamplerDir     s15      1
    //
    
        ps_3_0
        def c0, 512, 0.99609375, 7.96875, 63.75
        def c1, 0.25, 256, -127.999992, 9.99999975e-006
        def c2, 1.33333337, 9.99999975e-005, 512, 1
        def c3, 1, 0, 1.5, 0.0833333358
        def c4, -0.5, 0.5, 0.0199999996, 0.00999999978
        def c5, 4, 0.75, 0.25, 5
        def c6, 10, 0, 0, 0
        def c7, 1, -1, 0, -0
        def c8, -0.321940005, -0.932614982, -0.791558981, -0.597710013
        def c9, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
        def c10, 0.519456029, 0.767022014, 0.185461, -0.893123984
        def c11, 0.962339997, -0.194983006, 0.473434001, -0.480026007
        def c12, -0.69591397, 0.457136989, -0.203345001, 0.620715976
        def c13, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
        dcl_texcoord v0.xy
        dcl_texcoord1 v1
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        dcl_2d s5
        dcl_2d s15
        texld r0, v0, s4
        mad r0.x, r0.x, c66.z, -c66.w
        mul r0.x, r0.x, v1.w
        rcp r0.x, r0.x
        mad r0.yzw, v1.xxyz, -r0.x, c15.xxyz
        dp3 r1.x, c14, r0.yzww
        add r1.xyz, -r1.x, -c54
        cmp r1.yzw, r1.xxyz, c3.x, c3.y
        mov r1.x, c2.w
        dp4 r2.x, r1, c57
        dp4 r2.y, r1, c58
        dp4 r3.x, r1, c59
        dp4 r3.y, r1, c56
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        add r0.yzw, -r0, c15.xxyz
        dp3 r0.y, r0.yzww, r0.yzww
        rsq r0.y, r0.y
        rcp r0.y, r0.y
        add r1.xyz, r1, c63.xyww
        mad r0.zw, r1.xyxy, r2.xyxy, r3.xyxy
        mov r1.y, c53.y
        mad r1.xw, r1.y, c13.xyzy, r0.zyzw
        texld r2, r1.xwzw, s15
        add r1.x, r1.z, -r2.x
        cmp r1.x, r1.x, c3.x, c3.y
        mad r2.xy, r1.y, c13.zwzw, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c3.x, c3.y
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c12, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c3.x, c3.y
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c12.zwzw, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c3.x, c3.y
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c11, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c3.x, c3.y
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c11.zwzw, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c3.x, c3.y
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c10, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c3.x, c3.y
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c10.zwzw, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c3.x, c3.y
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c9, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c3.x, c3.y
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c9.zwzw, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c3.x, c3.y
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c8, r0.zwzw
        mad r0.zw, r1.y, c8, r0
        texld r3, r0.zwzw, s15
        add r0.z, r1.z, -r3.x
        cmp r0.z, r0.z, c3.x, c3.y
        texld r2, r2, s15
        add r0.w, r1.z, -r2.x
        cmp r0.w, r0.w, c3.x, c3.y
        add r0.w, r1.x, r0.w
        add r0.z, r0.z, r0.w
        rcp r0.w, c53.w
        mul r0.w, r0.y, r0.w
        add r0.y, r0.y, -c53.w
        cmp r1.xy, r0.y, c7, c7.zwzw
        mul r0.y, r0.w, r0.w
        mul r0.y, r0.y, c3.z
        mad r0.y, r0.z, c3.w, r0.y
        add r0.z, r1.y, r0.y
        cmp_sat r0.y, r0.z, r0.y, r1.x
        texld r1, v0, s1
        mul r2.xyz, r1.w, c0.yzww
        frc r2.xyz, r2
        add r3.xyz, r2, r2
        mad r3.xy, r2.yzzw, -c1.x, r3
        mad r1.xyz, r1, c1.y, r3
        add r1.xyz, r1, c1.z
        nrm r2.xyz, r1
        mad r1.xyz, v1, -r0.x, c1.w
        mul r0.xzw, r0.x, v1.xyyz
        nrm r3.xyz, r1
        dp3 r1.x, r3, r2
        add r1.y, r1.x, r1.x
        add r1.x, -r1_abs.x, c2.w
        mul r1.x, r1.x, r1.x
        mul r1.x, r1.x, r1.x
        mad r1.x, r1.x, c5.y, c5.z
        mad r1.yzw, r2.xxyz, -r1.y, r3.xxyz
        dp3_sat r2.w, -c17, r1.yzww
        add r2.w, r2.w, c2.y
        texld r4, v0, s2
        mul r3.w, r4.y, r4.y
        mad r4.y, r3.w, c2.z, c2.y
        mul r3.w, r3.w, c0.x
        mul_sat r3.w, r3.w, c72.x
        mad r5.w, r3.w, -c5.x, c5.x
        pow r3.w, r2.w, r4.y
        mul r6.xyz, c18.w, c18
        mul r7.xyz, r3.w, r6
        mul r7.xyz, r0.y, r7
        dp3 r0.x, r3, -r0.xzww
        mul_sat r0.xz, r0.x, c4.zyww
        mad r1.yzw, r3.xxyz, r0.x, r1
        add r0.x, -r0.z, c2.w
        add r1.yzw, r1, c1.w
        nrm r3.xyz, r1.yzww
        mul_sat r0.z, r3.z, c5.w
        mov_sat r0.w, r3.z
        add r0.w, r0.w, c2.w
        add r0.w, r0.w, r0.w
        rcp r0.w, r0.w
        mad r1.yz, r3.xxyw, r0.w, c4.y
        add r5.xy, -r1.yzzw, c2.w
        mov r5.z, c3.y
        texldl r3, r5, s5
        mul r1.yzw, r0.z, r3.xxyz
        mul r0.xzw, r0.x, r1.yyzw
        mul r0.xzw, r4.z, r0
        mul r0.xzw, r0, c39.w
        mul r0.xzw, r1.x, r0
        mul r0.xzw, r0, c6.x
        add r1.x, c17.w, c17.w
        mad r0.xzw, r7.xyyz, r1.x, r0
        add r1.x, r4.x, r4.x
        mul r0.xzw, r0, r1.x
        dp3 r1.x, r2, -c17
        mad_sat r1.y, r2.z, c4.x, c4.y
        mov r2.xyz, c38
        mad r1.yzw, r2.xxyz, r1.y, c37.xxyz
        mul r1.yzw, r4.z, r1
        add r1.x, r1.x, -c1.x
        mul_sat r1.x, r1.x, c2.x
        mul r2.xyz, r6, r1.x
        mad r1.xyz, r2, r0.y, r1.yzww
        texld r2, v0, s0
        mad oC0.xyz, r2, r1, r0.xzww
        mov oC0.w, c2.w
    
    // approximately 167 instruction slots used (18 texture, 149 arithmetic)
};

PixelShader PS_LightShadowDirectionalAmbientReflectionWet
<
    string GBufferStencilTextureSampler = "parameter register(5)";
    string GBufferTextureSampler0       = "parameter register(0)";
    string GBufferTextureSampler1       = "parameter register(1)";
    string GBufferTextureSampler2       = "parameter register(2)";
    string GBufferTextureSampler3       = "parameter register(4)";
    string ParabSampler                 = "parameter register(6)";
    string dReflectionParams            = "parameter register(72)";
    string gDeferredProjParams          = "parameter register(66)";
    string gDirectionalColour           = "parameter register(18)";
    string gDirectionalLight            = "parameter register(17)";
    string gFacetCentre                 = "parameter register(54)";
    string gLightAmbient0               = "parameter register(37)";
    string gLightAmbient1               = "parameter register(38)";
    string gShadowMatrix                = "parameter register(60)";
    string gShadowParam0123             = "parameter register(57)";
    string gShadowParam14151617         = "parameter register(56)";
    string gShadowParam18192021         = "parameter register(53)";
    string gShadowParam4567             = "parameter register(58)";
    string gShadowParam891113           = "parameter register(59)";
    string gShadowZSamplerDir           = "parameter register(15)";
    string gViewInverse                 = "parameter register(12)";
    string globalScalars                = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferStencilTextureSampler;
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   sampler2D ParabSampler;
    //   float4 dReflectionParams;
    //   float4 gDeferredProjParams;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float4 gFacetCentre;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam18192021;
    //   float4 gShadowParam4567;
    //   float4 gShadowParam891113;
    //   sampler2D gShadowZSamplerDir;
    //   row_major float4x4 gViewInverse;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name                         Reg   Size
    //   ---------------------------- ----- ----
    //   gViewInverse                 c12      4
    //   gDirectionalLight            c17      1
    //   gDirectionalColour           c18      1
    //   gLightAmbient0               c37      1
    //   gLightAmbient1               c38      1
    //   globalScalars                c39      1
    //   gShadowParam18192021         c53      1
    //   gFacetCentre                 c54      1
    //   gShadowParam14151617         c56      1
    //   gShadowParam0123             c57      1
    //   gShadowParam4567             c58      1
    //   gShadowParam891113           c59      1
    //   gShadowMatrix                c60      4
    //   gDeferredProjParams          c66      1
    //   dReflectionParams            c72      1
    //   GBufferTextureSampler0       s0       1
    //   GBufferTextureSampler1       s1       1
    //   GBufferTextureSampler2       s2       1
    //   GBufferTextureSampler3       s4       1
    //   GBufferStencilTextureSampler s5       1
    //   ParabSampler                 s6       1
    //   gShadowZSamplerDir           s15      1
    //
    
        ps_3_0
        def c0, 0, 512, 4096, 0.00200000009
        def c1, 0.99609375, 7.96875, 63.75, 0.25
        def c2, 256, -127.999992, 0.000392156857, 4
        def c3, 2, 0.5, 1, 9.99999975e-006
        def c4, 1.33333337, 9.99999975e-005, 1, 0
        def c5, 1.5, -0.326211989, -0.405809999, 0.0833333358
        def c6, -0.791558981, -0.597710013, -0.5, 0.5
        def c7, 0.0199999996, 0.00999999978, 0.75, 0.25
        def c8, 5, 10, 0, 0
        def c9, 1, -1, 0, -0
        def c10, 0.896420002, 0.412458003, -0.321940005, -0.932614982
        def c11, 0.185461, -0.893123984, 0.507430971, 0.0644249991
        def c12, 0.473434001, -0.480026007, 0.519456029, 0.767022014
        def c13, -0.203345001, 0.620715976, 0.962339997, -0.194983006
        def c16, -0.840143979, -0.0735799968, -0.69591397, 0.457136989
        dcl_texcoord v0.xy
        dcl_texcoord1 v1
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        dcl_2d s5
        dcl_2d s6
        dcl_2d s15
        texld r0, v0, s4
        mad r0.x, r0.x, c66.z, -c66.w
        mul r0.x, r0.x, v1.w
        rcp r0.x, r0.x
        mad r0.yzw, v1.xxyz, -r0.x, c15.xxyz
        dp3 r1.x, c14, r0.yzww
        add r1.xyz, -r1.x, -c54
        cmp r1.yzw, r1.xxyz, c4.z, c4.w
        mov r1.x, c3.z
        dp4 r2.x, r1, c57
        dp4 r2.y, r1, c58
        dp4 r3.x, r1, c59
        dp4 r3.y, r1, c56
        mul r1.xyz, r0.z, c61.xyww
        mad r1.xyz, r0.y, c60.xyww, r1
        mad r1.xyz, r0.w, c62.xyww, r1
        add r0.yzw, -r0, c15.xxyz
        dp3 r0.y, r0.yzww, r0.yzww
        rsq r0.y, r0.y
        rcp r0.y, r0.y
        add r1.xyz, r1, c63.xyww
        mad r0.zw, r1.xyxy, r2.xyxy, r3.xyxy
        mov r1.y, c53.y
        mad r1.xw, r1.y, c5.yyzz, r0.zyzw
        texld r2, r1.xwzw, s15
        add r1.x, r1.z, -r2.x
        cmp r1.x, r1.x, c4.z, c4.w
        mad r2.xy, r1.y, c16, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c4.z, c4.w
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c16.zwzw, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c4.z, c4.w
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c13, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c4.z, c4.w
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c13.zwzw, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c4.z, c4.w
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c12, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c4.z, c4.w
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c12.zwzw, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c4.z, c4.w
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c11, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c4.z, c4.w
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c11.zwzw, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c4.z, c4.w
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c10, r0.zwzw
        texld r2, r2, s15
        add r1.w, r1.z, -r2.x
        cmp r1.w, r1.w, c4.z, c4.w
        add r1.x, r1.x, r1.w
        mad r2.xy, r1.y, c10.zwzw, r0.zwzw
        mad r0.zw, r1.y, c6.xyxy, r0
        texld r3, r0.zwzw, s15
        add r0.z, r1.z, -r3.x
        cmp r0.z, r0.z, c4.z, c4.w
        texld r2, r2, s15
        add r0.w, r1.z, -r2.x
        cmp r0.w, r0.w, c4.z, c4.w
        add r0.w, r1.x, r0.w
        add r0.z, r0.z, r0.w
        rcp r0.w, c53.w
        mul r0.w, r0.y, r0.w
        add r0.y, r0.y, -c53.w
        cmp r1.xy, r0.y, c9, c9.zwzw
        mul r0.y, r0.w, r0.w
        mul r0.y, r0.y, c5.x
        mad r0.y, r0.z, c5.w, r0.y
        add r0.z, r1.y, r0.y
        cmp_sat r0.y, r0.z, r0.y, r1.x
        texld r1, v0, s1
        mul r2.xyz, r1.w, c1
        frc r2.xyz, r2
        add r3.xyz, r2, r2
        mad r3.xy, r2.yzzw, -c1.w, r3
        mad r1.xyz, r1, c2.x, r3
        add r1.xyz, r1, c2.y
        nrm r2.xyz, r1
        mad r1.xyz, v1, -r0.x, c3.w
        mul r0.xzw, r0.x, v1.xyyz
        nrm r3.xyz, r1
        dp3 r1.x, r3, r2
        add r1.y, r1.x, r1.x
        add r1.x, -r1_abs.x, c3.z
        mul r1.x, r1.x, r1.x
        mul r1.x, r1.x, r1.x
        mad r1.x, r1.x, c7.z, c7.w
        mad r1.yzw, r2.xxyz, -r1.y, r3.xxyz
        dp3_sat r2.w, -c17, r1.yzww
        add r2.w, r2.w, c4.y
        mul r3.w, r2.z, c2.w
        mov_sat r3.w, r3.w
        mul r3.w, r3.w, c72.y
        texld r4, v0, s5
        add r4.x, -r4.x, c2.z
        cmp r3.w, r4.x, r3.w, c0.x
        texld r4, v0, s2
        mul r4.y, r4.y, r4.y
        mul r5.xy, r4.y, c0.yzzw
        min r4.w, r5.y, c2.x
        mad r4.y, r4.y, -c0.y, r4.w
        mad r4.y, r3.w, r4.y, r5.x
        max r6.x, r5.x, r4.y
        add r4.y, r6.x, c4.y
        pow r5.x, r2.w, r4.y
        mul r5.yzw, c18.w, c18.xxyz
        mul r6.yzw, r5.x, r5
        mul r6.yzw, r0.y, r6
        dp3 r0.x, r3, -r0.xzww
        mul_sat r0.xz, r0.x, c7.xyyw
        add r0.z, -r0.z, c3.z
        mad r1.yzw, r3.xxyz, r0.x, r1
        add r1.yzw, r1, c3.w
        nrm r3.xyz, r1.yzww
        mul_sat r0.x, r3.z, c8.x
        mov_sat r0.w, r3.z
        add r0.w, r0.w, c3.z
        add r0.w, r0.w, r0.w
        rcp r0.w, r0.w
        mad r1.yz, r3.xxyw, r0.w, c3.y
        add r7.xy, -r1.yzzw, c3.z
        mul_sat r0.w, r6.x, c72.x
        mul r1.y, r6.x, c0.w
        min r2.w, r1.y, c1.w
        mad r1.y, r4.x, -c3.x, r2.w
        mad r7.w, r0.w, -c2.w, c2.w
        mov r7.z, c0.x
        texldl r7, r7, s6
        mul r3.xyz, r0.x, r7
        mul r0.xzw, r0.z, r3.xyyz
        mul r0.xzw, r4.z, r0
        mul r0.xzw, r0, c39.w
        mul r0.xzw, r1.x, r0
        mul r0.xzw, r0, c8.y
        add r1.x, c17.w, c17.w
        mad r0.xzw, r6.yyzw, r1.x, r0
        add r1.x, r4.x, r4.x
        mad r1.y, r3.w, r1.y, r1.x
        mad r1.z, r3.w, -c3.y, c3.z
        max r2.w, r1.x, r1.y
        mul r0.xzw, r0, r2.w
        dp3 r1.x, r2, -c17
        mad_sat r1.y, r2.z, c6.z, c6.w
        mov r2.xyz, c38
        mad r2.xyz, r2, r1.y, c37
        mul r2.xyz, r4.z, r2
        add r1.x, r1.x, -c1.w
        mul_sat r1.x, r1.x, c4.x
        mul r1.xyw, r5.yzzw, r1.x
        mad r1.xyw, r1, r0.y, r2.xyzz
        texld r2, v0, s0
        mul r2.xyz, r1.z, r2
        mad oC0.xyz, r2, r1.xyww, r0.xzww
        mov oC0.w, c3.z
    
    // approximately 184 instruction slots used (19 texture, 165 arithmetic)
};

PixelShader PS_LightAmbientReflectionDry
<
    string GBufferTextureSampler0 = "parameter register(0)";
    string GBufferTextureSampler1 = "parameter register(1)";
    string GBufferTextureSampler2 = "parameter register(2)";
    string GBufferTextureSampler3 = "parameter register(4)";
    string ParabSampler           = "parameter register(5)";
    string dReflectionParams      = "parameter register(72)";
    string gDeferredProjParams    = "parameter register(66)";
    string gDirectionalColour     = "parameter register(18)";
    string gDirectionalLight      = "parameter register(17)";
    string gLightAmbient0         = "parameter register(37)";
    string gLightAmbient1         = "parameter register(38)";
    string globalScalars          = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   sampler2D ParabSampler;
    //   float4 dReflectionParams;
    //   float4 gDeferredProjParams;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name                   Reg   Size
    //   ---------------------- ----- ----
    //   gDirectionalLight      c17      1
    //   gDirectionalColour     c18      1
    //   gLightAmbient0         c37      1
    //   gLightAmbient1         c38      1
    //   globalScalars          c39      1
    //   gDeferredProjParams    c66      1
    //   dReflectionParams      c72      1
    //   GBufferTextureSampler0 s0       1
    //   GBufferTextureSampler1 s1       1
    //   GBufferTextureSampler2 s2       1
    //   GBufferTextureSampler3 s4       1
    //   ParabSampler           s5       1
    //
    
        ps_3_0
        def c0, 512, 4, 1, 0
        def c1, 0.99609375, 7.96875, 63.75, 0.25
        def c2, 256, -127.999992, 9.99999975e-006, 1.33333337
        def c3, -0.5, 0.5, 0.0199999996, 0.00999999978
        def c4, 0.75, 0.25, 5, 10
        dcl_texcoord v0.xy
        dcl_texcoord1 v1
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        dcl_2d s5
        texld r0, v0, s1
        mul r1.xyz, r0.w, c1
        frc r1.xyz, r1
        add r2.xyz, r1, r1
        mad r2.xy, r1.yzzw, -c1.w, r2
        mad r0.xyz, r0, c2.x, r2
        add r0.xyz, r0, c2.y
        nrm r1.xyz, r0
        texld r0, v0, s4
        mad r0.x, r0.x, c66.z, -c66.w
        mul r0.x, r0.x, v1.w
        rcp r0.x, r0.x
        mad r0.yzw, v1.xxyz, -r0.x, c2.z
        mul r2.xyz, r0.x, v1
        nrm r3.xyz, r0.yzww
        dp3 r0.x, r3, r1
        add r0.y, r0.x, r0.x
        add r0.x, -r0_abs.x, c0.z
        mul r0.x, r0.x, r0.x
        mul r0.x, r0.x, r0.x
        mad r0.x, r0.x, c4.x, c4.y
        mad r0.yzw, r1.xxyz, -r0.y, r3.xxyz
        dp3 r1.w, r3, -r2
        mul_sat r2.xy, r1.w, c3.zwzw
        mad r0.yzw, r3.xxyz, r2.x, r0
        add r1.w, -r2.y, c0.z
        add r0.yzw, r0, c2.z
        nrm r2.xyz, r0.yzww
        mov_sat r0.y, r2.z
        add r0.y, r0.y, c0.z
        add r0.y, r0.y, r0.y
        rcp r0.y, r0.y
        mad r0.yz, r2.xxyw, r0.y, c3.y
        mul_sat r0.w, r2.z, c4.z
        add r2.xy, -r0.yzzw, c0.z
        mov r2.z, c0.w
        texld r3, v0, s2
        mul r0.y, r3.y, r3.y
        mul r0.y, r0.y, c72.x
        mul_sat r0.y, r0.y, c0.x
        mad r2.w, r0.y, -c0.y, c0.y
        texldl r2, r2, s5
        mul r0.yzw, r0.w, r2.xxyz
        mul r0.yzw, r1.w, r0
        mul r0.yzw, r3.z, r0
        mul r0.yzw, r0, c39.w
        mul r0.xyz, r0.x, r0.yzww
        add r0.w, r3.x, r3.x
        mul r0.xyz, r0, r0.w
        mul r0.xyz, r0, c4.w
        mad_sat r0.w, r1.z, c3.x, c3.y
        dp3 r1.x, r1, -c17
        add r1.x, r1.x, -c1.w
        mul_sat r1.x, r1.x, c2.w
        mov r2.xyz, c38
        mad r1.yzw, r2.xxyz, r0.w, c37.xxyz
        mul r1.yzw, r3.z, r1
        mul r2.xyz, c18.w, c18
        mad r1.xyz, r2, r1.x, r1.yzww
        texld r2, v0, s0
        mad oC0.xyz, r2, r1, r0
        mov oC0.w, c0.z
    
    // approximately 69 instruction slots used (6 texture, 63 arithmetic)
};

PixelShader PS_LightAmbientReflectionWet
<
    string GBufferStencilTextureSampler = "parameter register(5)";
    string GBufferTextureSampler0       = "parameter register(0)";
    string GBufferTextureSampler1       = "parameter register(1)";
    string GBufferTextureSampler2       = "parameter register(2)";
    string GBufferTextureSampler3       = "parameter register(4)";
    string ParabSampler                 = "parameter register(6)";
    string dReflectionParams            = "parameter register(72)";
    string gDeferredProjParams          = "parameter register(66)";
    string gDirectionalColour           = "parameter register(18)";
    string gDirectionalLight            = "parameter register(17)";
    string gLightAmbient0               = "parameter register(37)";
    string gLightAmbient1               = "parameter register(38)";
    string globalScalars                = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferStencilTextureSampler;
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   sampler2D ParabSampler;
    //   float4 dReflectionParams;
    //   float4 gDeferredProjParams;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name                         Reg   Size
    //   ---------------------------- ----- ----
    //   gDirectionalLight            c17      1
    //   gDirectionalColour           c18      1
    //   gLightAmbient0               c37      1
    //   gLightAmbient1               c38      1
    //   globalScalars                c39      1
    //   gDeferredProjParams          c66      1
    //   dReflectionParams            c72      1
    //   GBufferTextureSampler0       s0       1
    //   GBufferTextureSampler1       s1       1
    //   GBufferTextureSampler2       s2       1
    //   GBufferTextureSampler3       s4       1
    //   GBufferStencilTextureSampler s5       1
    //   ParabSampler                 s6       1
    //
    
        ps_3_0
        def c0, 0, 512, 4096, 0.00200000009
        def c1, 0.99609375, 7.96875, 63.75, 0.25
        def c2, 256, -127.999992, 0.000392156857, 4
        def c3, 2, 0.5, 1, 9.99999975e-006
        def c4, 1.33333337, -0.5, 0.5, 5
        def c5, 0.0199999996, 0.00999999978, 0.75, 0.25
        def c6, 10, 0, 0, 0
        dcl_texcoord v0.xy
        dcl_texcoord1 v1
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        dcl_2d s5
        dcl_2d s6
        texld r0, v0, s1
        mul r1.xyz, r0.w, c1
        frc r1.xyz, r1
        add r2.xyz, r1, r1
        mad r2.xy, r1.yzzw, -c1.w, r2
        mad r0.xyz, r0, c2.x, r2
        add r0.xyz, r0, c2.y
        nrm r1.xyz, r0
        texld r0, v0, s4
        mad r0.x, r0.x, c66.z, -c66.w
        mul r0.x, r0.x, v1.w
        rcp r0.x, r0.x
        mad r0.yzw, v1.xxyz, -r0.x, c3.w
        mul r2.xyz, r0.x, v1
        nrm r3.xyz, r0.yzww
        dp3 r0.x, r3, r1
        add r0.y, r0.x, r0.x
        add r0.x, -r0_abs.x, c3.z
        mul r0.x, r0.x, r0.x
        mul r0.x, r0.x, r0.x
        mad r0.x, r0.x, c5.z, c5.w
        mad r0.yzw, r1.xxyz, -r0.y, r3.xxyz
        dp3 r1.w, r3, -r2
        mul_sat r2.xy, r1.w, c5
        mad r0.yzw, r3.xxyz, r2.x, r0
        add r1.w, -r2.y, c3.z
        add r0.yzw, r0, c3.w
        nrm r2.xyz, r0.yzww
        mov_sat r0.y, r2.z
        add r0.y, r0.y, c3.z
        add r0.y, r0.y, r0.y
        rcp r0.y, r0.y
        mad r0.yz, r2.xxyw, r0.y, c3.y
        mul_sat r0.w, r2.z, c4.w
        add r2.xy, -r0.yzzw, c3.z
        mul r0.y, r1.z, c2.w
        mov_sat r0.y, r0.y
        mul r0.y, r0.y, c72.y
        texld r3, v0, s5
        add r0.z, -r3.x, c2.z
        cmp r0.y, r0.z, r0.y, c0.x
        texld r3, v0, s2
        mul r0.z, r3.y, r3.y
        mul r3.yw, r0.z, c0.xyzz
        min r4.x, r3.w, c2.x
        mad r0.z, r0.z, -c0.y, r4.x
        mad r0.z, r0.y, r0.z, r3.y
        max r4.x, r3.y, r0.z
        mul_sat r0.z, r4.x, c72.x
        mul r3.y, r4.x, c0.w
        min r4.x, r3.y, c1.w
        mad r3.y, r3.x, -c3.x, r4.x
        mad r2.w, r0.z, -c2.w, c2.w
        mov r2.z, c0.x
        texldl r2, r2, s6
        mul r2.xyz, r0.w, r2
        mul r2.xyz, r1.w, r2
        mul r2.xyz, r3.z, r2
        mul r2.xyz, r2, c39.w
        mul r0.xzw, r0.x, r2.xyyz
        add r1.w, r3.x, r3.x
        mad r2.x, r0.y, r3.y, r1.w
        mad r0.y, r0.y, -c3.y, c3.z
        max r3.x, r1.w, r2.x
        mul r0.xzw, r0, r3.x
        mul r0.xzw, r0, c6.x
        texld r2, v0, s0
        mul r2.xyz, r0.y, r2
        mad_sat r0.y, r1.z, c4.y, c4.z
        dp3 r1.x, r1, -c17
        add r1.x, r1.x, -c1.w
        mul_sat r1.x, r1.x, c4.x
        mov r4.xyz, c38
        mad r1.yzw, r4.xxyz, r0.y, c37.xxyz
        mul r1.yzw, r3.z, r1
        mul r3.xyz, c18.w, c18
        mad r1.xyz, r3, r1.x, r1.yzww
        mad oC0.xyz, r2, r1, r0.xzww
        mov oC0.w, c3.z
    
    // approximately 86 instruction slots used (7 texture, 79 arithmetic)
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

PixelShader PS_LightPointOrSpot0
<
    string GBufferTextureSampler0           = "parameter register(0)";
    string GBufferTextureSampler1           = "parameter register(1)";
    string GBufferTextureSampler2           = "parameter register(2)";
    string GBufferTextureSampler3           = "parameter register(4)";
    string gDeferredLightColourAndIntensity = "parameter register(76)";
    string gDeferredLightConeOffset         = "parameter register(74)";
    string gDeferredLightConeScale          = "parameter register(75)";
    string gDeferredLightDirection          = "parameter register(72)";
    string gDeferredLightInvSqrRadius       = "parameter register(73)";
    string gDeferredLightPosition           = "parameter register(66)";
    string gDeferredProjParams              = "parameter register(78)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(77)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
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
    //   gDeferredLightInvSqrRadius       c73      1
    //   gDeferredLightConeOffset         c74      1
    //   gDeferredLightConeScale          c75      1
    //   gDeferredLightColourAndIntensity c76      1
    //   gooDeferredLightScreenSize       c77      1
    //   gDeferredProjParams              c78      1
    //   GBufferTextureSampler0           s0       1
    //   GBufferTextureSampler1           s1       1
    //   GBufferTextureSampler2           s2       1
    //   GBufferTextureSampler3           s4       1
    //
    
        ps_3_0
        def c0, 0.50999999, 512, 0.25, 256
        def c1, 0.99609375, 7.96875, 63.75, -127.999992
        def c2, 0.5, 9.99999975e-006, 1, -0.100000001
        def c3, 1.11111116, 0, 0, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c77.zwzw
        texld r1, r0, s1
        mul r2.xyz, r1.w, c1
        frc r2.xyz, r2
        add r3.xyz, r2, r2
        mad r3.xy, r2.yzzw, -c0.z, r3
        mad r1.xyz, r1, c0.w, r3
        add r1.xyz, r1, c1.w
        nrm r2.xyz, r1
        texld r1, r0, s4
        mad r0.z, r1.x, c78.z, -c78.w
        mul r0.z, r0.z, v0.w
        rcp r0.z, r0.z
        mad r1.xyz, v0, -r0.z, c2.y
        mad r3.xyz, v0, -r0.z, c15
        add r3.xyz, -r3, c66
        nrm r4.xyz, r1
        dp3 r0.z, r4, r2
        add r0.z, r0.z, r0.z
        mad r1.xyz, r2, -r0.z, r4
        add r4.xyz, r3, c2.y
        dp3 r0.z, r3, r3
        mov r3.z, c2.z
        mad_sat r0.z, r0.z, -c73.x, r3.z
        mul r0.z, r0.z, r0.z
        mad r0.z, r0.z, r0.z, c2.w
        nrm r3.xyz, r4
        dp3_sat r0.w, r3, r1
        texld r1, r0, s2
        texld r4, r0, s0
        mul r0.x, r1.y, r1.y
        mul r0.x, r0.x, c0.y
        pow r1.y, r0.w, r0.x
        mul r0.x, r0.z, c3.x
        dp3 r0.y, r3, -c72
        dp3_sat r0.w, r3, r2
        add r0.y, r0.y, -c74.x
        mul_sat r0.y, r0.y, c75.x
        mul r0.x, r0.x, r0.y
        mul r2.xyz, c76.w, c76
        mul r2.xyz, r0.x, r2
        cmp r0.xyz, r0.z, r2, c3.y
        mul r2.xyz, r1.y, r0
        mul r0.xyz, r0.w, r0
        mul r0.xyz, r4, r0
        add r0.w, r1.x, r1.x
        mad_sat r1.x, r1.z, r1.z, c2.x
        mad r0.xyz, r0.w, r2, r0
        mov r0.w, c2.z
        mul oC0, r1.x, r0
    
    // approximately 59 instruction slots used (4 texture, 55 arithmetic)
};

PixelShader PS_LightPointOrSpot1
<
    string GBufferStencilTextureSampler     = "parameter register(5)";
    string GBufferTextureSampler0           = "parameter register(0)";
    string GBufferTextureSampler1           = "parameter register(1)";
    string GBufferTextureSampler2           = "parameter register(2)";
    string GBufferTextureSampler3           = "parameter register(4)";
    string gDeferredLightColourAndIntensity = "parameter register(76)";
    string gDeferredLightConeOffset         = "parameter register(74)";
    string gDeferredLightConeScale          = "parameter register(75)";
    string gDeferredLightDirection          = "parameter register(72)";
    string gDeferredLightInvSqrRadius       = "parameter register(73)";
    string gDeferredLightPosition           = "parameter register(66)";
    string gDeferredProjParams              = "parameter register(78)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(77)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferStencilTextureSampler;
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
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
    //   gDeferredLightInvSqrRadius       c73      1
    //   gDeferredLightConeOffset         c74      1
    //   gDeferredLightConeScale          c75      1
    //   gDeferredLightColourAndIntensity c76      1
    //   gooDeferredLightScreenSize       c77      1
    //   gDeferredProjParams              c78      1
    //   GBufferTextureSampler0           s0       1
    //   GBufferTextureSampler1           s1       1
    //   GBufferTextureSampler2           s2       1
    //   GBufferTextureSampler3           s4       1
    //   GBufferStencilTextureSampler     s5       1
    //
    
        ps_3_0
        def c0, 0.50999999, 512, 0.25, 256
        def c1, 0.99609375, 7.96875, 63.75, -127.999992
        def c2, 255, -128, -0, -7.9000001
        def c3, 1, 0, 9.99999975e-006, -0.100000001
        def c4, 1.11111116, 0, 0, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        dcl_2d s5
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c77.zwzw
        texld r1, r0, s1
        mul r2.xyz, r1.w, c1
        frc r2.xyz, r2
        add r3.xyz, r2, r2
        mad r3.xy, r2.yzzw, -c0.z, r3
        mad r1.xyz, r1, c0.w, r3
        add r1.xyz, r1, c1.w
        nrm r2.xyz, r1
        texld r1, r0, s4
        mad r0.z, r1.x, c78.z, -c78.w
        mul r0.z, r0.z, v0.w
        rcp r0.z, r0.z
        mad r1.xyz, v0, -r0.z, c3.z
        mad r3.xyz, v0, -r0.z, c15
        add r3.xyz, -r3, c66
        nrm r4.xyz, r1
        dp3 r0.z, r4, r2
        add r0.z, r0.z, r0.z
        mad r1.xyz, r2, -r0.z, r4
        add r4.xyz, r3, c3.z
        dp3 r0.z, r3, r3
        mov r3.x, c3.x
        mad_sat r0.z, r0.z, -c73.x, r3.x
        mul r0.z, r0.z, r0.z
        mad r0.z, r0.z, r0.z, c3.w
        nrm r3.xyz, r4
        dp3_sat r0.w, r3, r1
        texld r1, r0, s2
        mul r1.y, r1.y, r1.y
        add r1.x, r1.x, r1.x
        mul r1.y, r1.y, c0.y
        pow r2.w, r0.w, r1.y
        mul r0.w, r0.z, c4.x
        dp3 r1.y, r3, -c72
        dp3_sat r1.z, r3, r2
        add r1.y, r1.y, -c74.x
        mul_sat r1.y, r1.y, c75.x
        mul r0.w, r0.w, r1.y
        mul r2.xyz, c76.w, c76
        mul r2.xyz, r0.w, r2
        cmp r2.xyz, r0.z, r2, -c2.z
        mul r3.xyz, r2.w, r2
        mul r1.yzw, r1.z, r2.xxyz
        texld r2, r0, s0
        texld r0, r0, s5
        mul r0.yzw, r1, r2.xxyz
        mad r1.xyz, r1.x, r3, r0.yzww
        mov r1.w, c3.x
        mad r0.y, r0.x, c2.x, c2.y
        cmp r0.y, r0.y, c2.y, c2.z
        mad r0.x, r0.x, c2.x, r0.y
        add r0.x, r0.x, c2.w
        cmp r0.x, r0.x, c3.x, c3.y
        mul oC0, r1, r0.x
    
    // approximately 64 instruction slots used (5 texture, 59 arithmetic)
};

PixelShader PS_LightPointOrSpot2
<
    string GBufferStencilTextureSampler     = "parameter register(5)";
    string GBufferTextureSampler0           = "parameter register(0)";
    string GBufferTextureSampler1           = "parameter register(1)";
    string GBufferTextureSampler2           = "parameter register(2)";
    string GBufferTextureSampler3           = "parameter register(4)";
    string gDeferredLightColourAndIntensity = "parameter register(76)";
    string gDeferredLightConeOffset         = "parameter register(74)";
    string gDeferredLightConeScale          = "parameter register(75)";
    string gDeferredLightDirection          = "parameter register(72)";
    string gDeferredLightInvSqrRadius       = "parameter register(73)";
    string gDeferredLightPosition           = "parameter register(66)";
    string gDeferredProjParams              = "parameter register(78)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(77)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferStencilTextureSampler;
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
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
    //   gDeferredLightInvSqrRadius       c73      1
    //   gDeferredLightConeOffset         c74      1
    //   gDeferredLightConeScale          c75      1
    //   gDeferredLightColourAndIntensity c76      1
    //   gooDeferredLightScreenSize       c77      1
    //   gDeferredProjParams              c78      1
    //   GBufferTextureSampler0           s0       1
    //   GBufferTextureSampler1           s1       1
    //   GBufferTextureSampler2           s2       1
    //   GBufferTextureSampler3           s4       1
    //   GBufferStencilTextureSampler     s5       1
    //
    
        ps_3_0
        def c0, 0, 1, 0.5, 9.99999975e-006
        def c1, 0.50999999, 512, 0.25, 256
        def c2, 0.99609375, 7.96875, 63.75, -127.999992
        def c3, 255, -128, -0, -7.9000001
        def c4, -0.100000001, 1.11111116, 0, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        dcl_2d s5
        add r0.xy, c1.x, vPos
        mul r0.xy, r0, c77.zwzw
        texld r1, r0, s1
        mul r2.xyz, r1.w, c2
        frc r2.xyz, r2
        add r3.xyz, r2, r2
        mad r3.xy, r2.yzzw, -c1.z, r3
        mad r1.xyz, r1, c1.w, r3
        add r1.xyz, r1, c2.w
        nrm r2.xyz, r1
        texld r1, r0, s4
        mad r0.z, r1.x, c78.z, -c78.w
        mul r0.z, r0.z, v0.w
        rcp r0.z, r0.z
        mad r1.xyz, v0, -r0.z, c0.w
        mad r3.xyz, v0, -r0.z, c15
        add r3.xyz, -r3, c66
        nrm r4.xyz, r1
        dp3 r0.z, r4, r2
        add r0.z, r0.z, r0.z
        mad r1.xyz, r2, -r0.z, r4
        add r4.xyz, r3, c0.w
        dp3 r0.z, r3, r3
        mov r3.y, c0.y
        mad_sat r0.z, r0.z, -c73.x, r3.y
        mul r0.z, r0.z, r0.z
        mad r0.z, r0.z, r0.z, c4.x
        nrm r3.xyz, r4
        dp3_sat r0.w, r3, r1
        texld r1, r0, s2
        mul r1.y, r1.y, r1.y
        mul r1.y, r1.y, c1.y
        pow r2.w, r0.w, r1.y
        mul r0.w, r0.z, c4.y
        dp3 r1.y, r3, -c72
        dp3_sat r1.w, r3, r2
        add r1.y, r1.y, -c74.x
        mul_sat r1.y, r1.y, c75.x
        mul r0.w, r0.w, r1.y
        mul r2.xyz, c76.w, c76
        mul r2.xyz, r0.w, r2
        cmp r2.xyz, r0.z, r2, -c3.z
        mul r3.xyz, r2.w, r2
        mul r2.xyz, r1.w, r2
        texld r4, r0, s0
        texld r0, r0, s5
        mul r0.yzw, r2.xxyz, r4.xxyz
        add r1.x, r1.x, r1.x
        mad_sat r1.y, r1.z, r1.z, c0.z
        mad r2.xyz, r1.x, r3, r0.yzww
        mov r2.w, c0.y
        mad r0.y, r0.x, c3.x, c3.y
        cmp r0.y, r0.y, c3.y, c3.z
        mad r0.x, r0.x, c3.x, r0.y
        add r0.x, r0.x, c3.w
        cmp r0.x, r0.x, c0.x, c0.y
        mul r0, r2, r0.x
        mul oC0, r1.y, r0
    
    // approximately 66 instruction slots used (5 texture, 61 arithmetic)
};

PixelShader PS_LightPointOrSpot3
<
    string GBufferStencilTextureSampler     = "parameter register(5)";
    string GBufferTextureSampler0           = "parameter register(0)";
    string GBufferTextureSampler1           = "parameter register(1)";
    string GBufferTextureSampler2           = "parameter register(2)";
    string GBufferTextureSampler3           = "parameter register(4)";
    string gDeferredLightColourAndIntensity = "parameter register(76)";
    string gDeferredLightConeOffset         = "parameter register(74)";
    string gDeferredLightConeScale          = "parameter register(75)";
    string gDeferredLightDirection          = "parameter register(72)";
    string gDeferredLightInvSqrRadius       = "parameter register(73)";
    string gDeferredLightPosition           = "parameter register(66)";
    string gDeferredProjParams              = "parameter register(78)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(77)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferStencilTextureSampler;
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
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
    //   gDeferredLightInvSqrRadius       c73      1
    //   gDeferredLightConeOffset         c74      1
    //   gDeferredLightConeScale          c75      1
    //   gDeferredLightColourAndIntensity c76      1
    //   gooDeferredLightScreenSize       c77      1
    //   gDeferredProjParams              c78      1
    //   GBufferTextureSampler0           s0       1
    //   GBufferTextureSampler1           s1       1
    //   GBufferTextureSampler2           s2       1
    //   GBufferTextureSampler3           s4       1
    //   GBufferStencilTextureSampler     s5       1
    //
    
        ps_3_0
        def c0, 0.50999999, 512, 0.25, 256
        def c1, 0.99609375, 7.96875, 63.75, -127.999992
        def c2, 255, -128, -0, -7.9000001
        def c3, -8, -0, -1, 0.100000001
        def c4, 9.99999975e-006, 1.11111116, 0, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        dcl_2d s5
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c77.zwzw
        texld r1, r0, s1
        mul r2.xyz, r1.w, c1
        frc r2.xyz, r2
        add r3.xyz, r2, r2
        mad r3.xy, r2.yzzw, -c0.z, r3
        mad r1.xyz, r1, c0.w, r3
        add r1.xyz, r1, c1.w
        nrm r2.xyz, r1
        texld r1, r0, s4
        mad r0.z, r1.x, c78.z, -c78.w
        mul r0.z, r0.z, v0.w
        rcp r0.z, r0.z
        mad r1.xyz, v0, -r0.z, c4.x
        mad r3.xyz, v0, -r0.z, c15
        add r3.xyz, -r3, c66
        nrm r4.xyz, r1
        dp3 r0.z, r4, r2
        add r0.z, r0.z, r0.z
        mad r1.xyz, r2, -r0.z, r4
        add r4.xyz, r3, c4.x
        dp3 r0.z, r3, r3
        mov r3.z, c3.z
        mad_sat r0.z, r0.z, -c73.x, -r3.z
        mul r0.z, r0.z, r0.z
        mad r0.z, r0.z, r0.z, -c3.w
        nrm r3.xyz, r4
        dp3_sat r0.w, r3, r1
        texld r1, r0, s2
        mul r1.y, r1.y, r1.y
        add r1.x, r1.x, r1.x
        mul r1.y, r1.y, c0.y
        pow r2.w, r0.w, r1.y
        mul r0.w, r0.z, c4.y
        dp3 r1.y, r3, -c72
        dp3_sat r1.z, r3, r2
        add r1.y, r1.y, -c74.x
        mul_sat r1.y, r1.y, c75.x
        mul r0.w, r0.w, r1.y
        mul r2.xyz, c76.w, c76
        mul r2.xyz, r0.w, r2
        cmp r2.xyz, r0.z, r2, -c2.z
        mul r3.xyz, r2.w, r2
        mul r1.yzw, r1.z, r2.xxyz
        texld r2, r0, s0
        texld r0, r0, s5
        mul r0.yzw, r1, r2.xxyz
        mad r1.xyz, r1.x, r3, r0.yzww
        mad r0.y, r0.x, c2.x, c2.y
        cmp r0.y, r0.y, c2.y, c2.z
        mad r0.x, r0.x, c2.x, r0.y
        add r0.y, r0.x, c2.w
        cmp r0.y, r0.y, c3.x, c3.y
        add r0.x, r0.x, r0.y
        add r0.x, r0.x, c3.z
        add r0.x, -r0_abs.x, c3.w
        cmp r0.x, r0.x, -c3.z, -c3.y
        mov r1.w, -c3.z
        mul oC0, r1, r0.x
    
    // approximately 68 instruction slots used (5 texture, 63 arithmetic)
};

PixelShader PS_FillerPointOrSpot0
<
    string GBufferTextureSampler0           = "parameter register(0)";
    string GBufferTextureSampler1           = "parameter register(1)";
    string GBufferTextureSampler3           = "parameter register(2)";
    string gDeferredLightColourAndIntensity = "parameter register(76)";
    string gDeferredLightConeOffset         = "parameter register(74)";
    string gDeferredLightConeScale          = "parameter register(75)";
    string gDeferredLightDirection          = "parameter register(72)";
    string gDeferredLightInvSqrRadius       = "parameter register(73)";
    string gDeferredLightPosition           = "parameter register(66)";
    string gDeferredProjParams              = "parameter register(78)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(77)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
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
    //   gDeferredLightInvSqrRadius       c73      1
    //   gDeferredLightConeOffset         c74      1
    //   gDeferredLightConeScale          c75      1
    //   gDeferredLightColourAndIntensity c76      1
    //   gooDeferredLightScreenSize       c77      1
    //   gDeferredProjParams              c78      1
    //   GBufferTextureSampler0           s0       1
    //   GBufferTextureSampler1           s1       1
    //   GBufferTextureSampler3           s2       1
    //
    
        ps_3_0
        def c0, 0.50999999, 2, -0.999989986, 9.99999975e-006
        def c1, 1, -0.333333343, 1.5, -0.200000003
        def c2, 1.25, 0, 0, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c77.zwzw
        texld r1, r0, s2
        mad r0.z, r1.x, c78.z, -c78.w
        mul r0.z, r0.z, v0.w
        rcp r0.z, r0.z
        mad r1.xyz, v0, -r0.z, c15
        add r1.xyz, -r1, c66
        add r2.xyz, r1, c0.w
        dp3 r0.z, r1, r1
        mov r1.x, c1.x
        mad_sat r0.z, r0.z, -c73.x, r1.x
        mad r0.z, r0.z, r0.z, c1.y
        nrm r1.xyz, r2
        texld r2, r0, s1
        texld r3, r0, s0
        mad r0.xyw, r2.xyzz, c0.y, c0.z
        nrm r2.xyz, r0.xyww
        dp3 r0.x, r2, r1
        dp3 r0.y, r1, -c72
        add r0.y, r0.y, -c74.x
        mul_sat r0.y, r0.y, c75.x
        add r0.x, r0.x, c1.w
        mul_sat r0.x, r0.x, c2.x
        mul r0.w, r0.z, c1.z
        mul r0.y, r0.y, r0.w
        mul r0.x, r0.x, r0.y
        mul r1.xyz, c76.w, c76
        mul r0.xyw, r0.x, r1.xyzz
        mul r0.xyw, r3.xyzz, r0
        cmp oC0.xyz, r0.z, r0.xyww, c2.y
        mov oC0.w, c1.x
    
    // approximately 36 instruction slots used (3 texture, 33 arithmetic)
};

PixelShader PS_FillerPointOrSpot1
<
    string GBufferStencilTextureSampler     = "parameter register(4)";
    string GBufferTextureSampler0           = "parameter register(0)";
    string GBufferTextureSampler1           = "parameter register(1)";
    string GBufferTextureSampler3           = "parameter register(2)";
    string gDeferredLightColourAndIntensity = "parameter register(76)";
    string gDeferredLightConeOffset         = "parameter register(74)";
    string gDeferredLightConeScale          = "parameter register(75)";
    string gDeferredLightDirection          = "parameter register(72)";
    string gDeferredLightInvSqrRadius       = "parameter register(73)";
    string gDeferredLightPosition           = "parameter register(66)";
    string gDeferredProjParams              = "parameter register(78)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(77)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferStencilTextureSampler;
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
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
    //   gDeferredLightInvSqrRadius       c73      1
    //   gDeferredLightConeOffset         c74      1
    //   gDeferredLightConeScale          c75      1
    //   gDeferredLightColourAndIntensity c76      1
    //   gooDeferredLightScreenSize       c77      1
    //   gDeferredProjParams              c78      1
    //   GBufferTextureSampler0           s0       1
    //   GBufferTextureSampler1           s1       1
    //   GBufferTextureSampler3           s2       1
    //   GBufferStencilTextureSampler     s4       1
    //
    
        ps_3_0
        def c0, 0.50999999, 2, -0.999989986, 255
        def c1, 255, -128, -0, -7.9000001
        def c2, 9.99999975e-006, 1, -0.333333343, 1.5
        def c3, -0.200000003, 1.25, 0, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c77.zwzw
        texld r1, r0, s2
        mad r0.z, r1.x, c78.z, -c78.w
        mul r0.z, r0.z, v0.w
        rcp r0.z, r0.z
        mad r1.xyz, v0, -r0.z, c15
        add r1.xyz, -r1, c66
        add r2.xyz, r1, c2.x
        dp3 r0.z, r1, r1
        mov r1.y, c2.y
        mad_sat r0.z, r0.z, -c73.x, r1.y
        mad r0.z, r0.z, r0.z, c2.z
        nrm r1.xyz, r2
        texld r2, r0, s1
        mad r2.xyz, r2, c0.y, c0.z
        nrm r3.xyz, r2
        dp3 r0.w, r3, r1
        dp3 r1.x, r1, -c72
        add r1.x, r1.x, -c74.x
        mul_sat r1.x, r1.x, c75.x
        add r0.w, r0.w, c3.x
        mul_sat r0.w, r0.w, c3.y
        mul r1.y, r0.z, c2.w
        mul r1.x, r1.x, r1.y
        mul r0.w, r0.w, r1.x
        mul r1.xyz, c76.w, c76
        mul r1.xyz, r0.w, r1
        texld r2, r0, s0
        texld r3, r0, s4
        mul r0.xyw, r1.xyzz, r2.xyzz
        cmp r0.xyz, r0.z, r0.xyww, -c1.z
        mad r1.x, r3.x, c1.x, c1.y
        cmp r1.x, r1.x, c1.y, c1.z
        mad r1.x, r3.x, c0.w, r1.x
        add r1.x, r1.x, c1.w
        mov r0.w, c2.y
        cmp oC0, r1.x, r0, -c1.z
    
    // approximately 42 instruction slots used (4 texture, 38 arithmetic)
};

PixelShader PS_FillerPointOrSpot2
<
    string GBufferStencilTextureSampler     = "parameter register(4)";
    string GBufferTextureSampler0           = "parameter register(0)";
    string GBufferTextureSampler1           = "parameter register(1)";
    string GBufferTextureSampler3           = "parameter register(2)";
    string gDeferredLightColourAndIntensity = "parameter register(76)";
    string gDeferredLightConeOffset         = "parameter register(74)";
    string gDeferredLightConeScale          = "parameter register(75)";
    string gDeferredLightDirection          = "parameter register(72)";
    string gDeferredLightInvSqrRadius       = "parameter register(73)";
    string gDeferredLightPosition           = "parameter register(66)";
    string gDeferredProjParams              = "parameter register(78)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(77)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferStencilTextureSampler;
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
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
    //   gDeferredLightInvSqrRadius       c73      1
    //   gDeferredLightConeOffset         c74      1
    //   gDeferredLightConeScale          c75      1
    //   gDeferredLightColourAndIntensity c76      1
    //   gooDeferredLightScreenSize       c77      1
    //   gDeferredProjParams              c78      1
    //   GBufferTextureSampler0           s0       1
    //   GBufferTextureSampler1           s1       1
    //   GBufferTextureSampler3           s2       1
    //   GBufferStencilTextureSampler     s4       1
    //
    
        ps_3_0
        def c0, 0.50999999, 2, -0.999989986, 255
        def c1, 255, -128, -0, -7.9000001
        def c2, 9.99999975e-006, 1, -0.333333343, 1.5
        def c3, -0.200000003, 1.25, 0, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c77.zwzw
        texld r1, r0, s2
        mad r0.z, r1.x, c78.z, -c78.w
        mul r0.z, r0.z, v0.w
        rcp r0.z, r0.z
        mad r1.xyz, v0, -r0.z, c15
        add r1.xyz, -r1, c66
        add r2.xyz, r1, c2.x
        dp3 r0.z, r1, r1
        mov r1.y, c2.y
        mad_sat r0.z, r0.z, -c73.x, r1.y
        mad r0.z, r0.z, r0.z, c2.z
        nrm r1.xyz, r2
        texld r2, r0, s1
        mad r2.xyz, r2, c0.y, c0.z
        nrm r3.xyz, r2
        dp3 r0.w, r3, r1
        dp3 r1.x, r1, -c72
        add r1.x, r1.x, -c74.x
        mul_sat r1.x, r1.x, c75.x
        add r0.w, r0.w, c3.x
        mul_sat r0.w, r0.w, c3.y
        mul r1.y, r0.z, c2.w
        mul r1.x, r1.x, r1.y
        mul r0.w, r0.w, r1.x
        mul r1.xyz, c76.w, c76
        mul r1.xyz, r0.w, r1
        texld r2, r0, s0
        texld r3, r0, s4
        mul r0.xyw, r1.xyzz, r2.xyzz
        cmp r0.xyz, r0.z, r0.xyww, -c1.z
        mad r1.x, r3.x, c1.x, c1.y
        cmp r1.x, r1.x, c1.y, c1.z
        mad r1.x, r3.x, c0.w, r1.x
        add r1.x, r1.x, c1.w
        mov r0.w, c2.y
        cmp oC0, r1.x, -c1.z, r0
    
    // approximately 42 instruction slots used (4 texture, 38 arithmetic)
};

PixelShader PS_DebugLightColorC
<
    string debugLightColour = "parameter register(66)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 debugLightColour;
    //
    //
    // Registers:
    //
    //   Name             Reg   Size
    //   ---------------- ----- ----
    //   debugLightColour c66      1
    //
    
        ps_3_0
        dcl_texcoord v0
        mul oC0, c66, v0
    
    // approximately 1 instruction slot used
};

PixelShader PS_LightShadowPointOrSpot
<
    string GBufferStencilTextureSampler     = "parameter register(5)";
    string GBufferTextureSampler0           = "parameter register(0)";
    string GBufferTextureSampler1           = "parameter register(1)";
    string GBufferTextureSampler2           = "parameter register(2)";
    string GBufferTextureSampler3           = "parameter register(4)";
    string dShadowMatrix                    = "parameter register(72)";
    string dShadowOffsetScale               = "parameter register(77)";
    string dShadowParam0123                 = "parameter register(66)";
    string dShadowParam891113               = "parameter register(76)";
    string gDeferredLightColourAndIntensity = "parameter register(83)";
    string gDeferredLightConeOffset         = "parameter register(81)";
    string gDeferredLightConeScale          = "parameter register(82)";
    string gDeferredLightDirection          = "parameter register(79)";
    string gDeferredLightInvSqrRadius       = "parameter register(80)";
    string gDeferredLightPosition           = "parameter register(78)";
    string gDeferredProjParams              = "parameter register(85)";
    string gShadowZSamplerCache             = "parameter register(14)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(84)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferStencilTextureSampler;
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   row_major float4x4 dShadowMatrix;
    //   float4 dShadowOffsetScale;
    //   float4 dShadowParam0123;
    //   float4 dShadowParam891113;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
    //   float4 gDeferredProjParams;
    //   sampler2D gShadowZSamplerCache;
    //   row_major float4x4 gViewInverse;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gViewInverse                     c12      4
    //   dShadowParam0123                 c66      1
    //   dShadowMatrix                    c72      4
    //   dShadowParam891113               c76      1
    //   dShadowOffsetScale               c77      1
    //   gDeferredLightPosition           c78      1
    //   gDeferredLightDirection          c79      1
    //   gDeferredLightInvSqrRadius       c80      1
    //   gDeferredLightConeOffset         c81      1
    //   gDeferredLightConeScale          c82      1
    //   gDeferredLightColourAndIntensity c83      1
    //   gooDeferredLightScreenSize       c84      1
    //   gDeferredProjParams              c85      1
    //   GBufferTextureSampler0           s0       1
    //   GBufferTextureSampler1           s1       1
    //   GBufferTextureSampler2           s2       1
    //   GBufferTextureSampler3           s4       1
    //   GBufferStencilTextureSampler     s5       1
    //   gShadowZSamplerCache             s14      1
    //
    
        ps_3_0
        def c0, 0.50999999, 512, 0.25, 256
        def c1, 0.99609375, 7.96875, 63.75, -127.999992
        def c2, 9.99999975e-006, 1, -0.100000001, 1.11111116
        def c3, 1, 0, 0.5, -0.5
        def c4, 3, 4.27199984, 0, 0.75
        def c5, 0.159154937, 0.5, 6.28318548, -3.14159274
        def c6, -1, 1, 255, -128
        def c7, -128, -0, -7.9000001, 2
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        dcl_2d s5
        dcl_2d s14
        dp2add r0.x, vPos, c4, c4.z
        mad r0.x, r0.x, c5.x, c5.y
        frc r0.x, r0.x
        mad r0.x, r0.x, c5.z, c5.w
        sincos r1.xy, r0.x
        mul r0.xy, r1.yxzw, c77.z
        add r0.zw, c0.x, vPos.xyxy
        mul r0.zw, r0, c84
        texld r2, r0.zwzw, s1
        mul r3.xyz, r2.w, c1
        frc r3.xyz, r3
        add r4.xyz, r3, r3
        mad r4.xy, r3.yzzw, -c0.z, r4
        mad r2.xyz, r2, c0.w, r4
        add r2.xyz, r2, c1.w
        nrm r3.xyz, r2
        texld r2, r0.zwzw, s4
        mad r1.z, r2.x, c85.z, -c85.w
        mul r1.z, r1.z, v0.w
        rcp r1.z, r1.z
        mad r2.xyz, v0, -r1.z, c15
        mad r4.xyz, v0, -r1.z, c2.x
        nrm r5.xyz, r4
        mad r4.xyz, r3, -c2.z, r2
        add r2.xyz, -r2, c78
        mul r6.xyz, r4.y, c73
        mad r4.xyw, r4.x, c72.xyzz, r6.xyzz
        mad r4.xyz, r4.z, c74, r4.xyww
        add r4.xyz, r4, c75
        add r1.z, r4.z, c76.z
        mov r4.w, -r1_abs.z
        dp3 r1.w, r4.xyww, r4.xyww
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        add r2.w, r1_abs.z, r1.w
        cmp r4.zw, -r1.z, c3.xyxy, c3.xyyx
        rcp r1.z, r2.w
        mul r4.xy, r4, r1.z
        mad r4.xy, r4, c3.zwzw, c3.z
        mad_sat r0.xy, r0, c4.w, r4
        mad r0.xy, r0, c77.w, c77
        texld r6, r0, s14
        dp2add r6.y, r6, r4.zwzw, c3.y
        mul r0.xy, -r1.yxzw, c77.z
        mul r7, r1.xyxy, c6.xyyx
        mad_sat r0.xy, r0, c0.z, r4
        mad r0.xy, r0, c77.w, c77
        texld r8, r0, s14
        dp2add r6.w, r8, r4.zwzw, c3.y
        mul r0.xy, r7, c77.z
        mad_sat r1.xy, r7.zwzw, c77.z, r4
        mad_sat r0.xy, r0, c3.z, r4
        mad r0.xy, r0, c77.w, c77
        texld r7, r0, s14
        dp2add r6.z, r7, r4.zwzw, c3.y
        mad r0.xy, r1, c77.w, c77
        texld r7, r0, s14
        dp2add r6.x, r7, r4.zwzw, c3.y
        mad r1, r1.w, c66.w, r6
        cmp r1, r1, c3.x, c3.y
        dp4 r0.x, r1, c0.z
        dp3 r0.y, r2, r2
        add r1.xyz, r2, c2.x
        nrm r2.xyz, r1
        mov r1.y, c2.y
        mad_sat r0.y, r0.y, -c80.x, r1.y
        mul r0.y, r0.y, r0.y
        mad r0.y, r0.y, r0.y, c2.z
        mul r1.x, r0.y, c2.w
        mul r1.yzw, c83.w, c83.xxyz
        mul r1.xyz, r1.x, r1.yzww
        dp3 r1.w, r2, -c79
        add r1.w, r1.w, -c81.x
        mul_sat r1.w, r1.w, c82.x
        mul r1.xyz, r1, r1.w
        mul r1.xyz, r0.x, r1
        cmp r1.xyz, r0.y, r1, c3.y
        dp3 r0.x, r5, r3
        add r0.x, r0.x, r0.x
        mad r4.xyz, r3, -r0.x, r5
        dp3_sat r0.x, r2, r3
        dp3_sat r0.y, r2, r4
        mul r2.xyz, r1, r0.x
        texld r3, r0.zwzw, s2
        mul r3.yz, r3, r3
        add r0.x, r3.x, r3.x
        mul r1.w, r3.y, c0.y
        pow r2.w, r0.y, r1.w
        mul r1.xyz, r1, r2.w
        mul r1.xyz, r0.x, r1
        texld r4, r0.zwzw, s0
        texld r0, r0.zwzw, s5
        mad r1.xyz, r4, r2, r1
        mul r0.y, r3.z, r3.z
        mad_sat r0.y, r0.y, c3.z, r3.z
        mad r0.z, r0.x, c6.z, c6.w
        cmp r0.z, r0.z, c7.x, c7.y
        mad r0.x, r0.x, c6.z, r0.z
        add r0.x, r0.x, c7.z
        cmp r0.x, r0.x, c2.y, r0.y
        mov r1.w, c7.w
        mul oC0, r1, r0.x
    
    // approximately 122 instruction slots used (9 texture, 113 arithmetic)
};

PixelShader PS_FillerShadowPointOrSpot
<
    string GBufferTextureSampler0           = "parameter register(0)";
    string GBufferTextureSampler1           = "parameter register(1)";
    string GBufferTextureSampler3           = "parameter register(2)";
    string dShadowMatrix                    = "parameter register(72)";
    string dShadowOffsetScale               = "parameter register(77)";
    string dShadowParam0123                 = "parameter register(66)";
    string dShadowParam891113               = "parameter register(76)";
    string gDeferredLightColourAndIntensity = "parameter register(83)";
    string gDeferredLightConeOffset         = "parameter register(81)";
    string gDeferredLightConeScale          = "parameter register(82)";
    string gDeferredLightDirection          = "parameter register(79)";
    string gDeferredLightInvSqrRadius       = "parameter register(80)";
    string gDeferredLightPosition           = "parameter register(78)";
    string gDeferredProjParams              = "parameter register(85)";
    string gShadowZSamplerCache             = "parameter register(14)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(84)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler3;
    //   row_major float4x4 dShadowMatrix;
    //   float4 dShadowOffsetScale;
    //   float4 dShadowParam0123;
    //   float4 dShadowParam891113;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
    //   float4 gDeferredProjParams;
    //   sampler2D gShadowZSamplerCache;
    //   row_major float4x4 gViewInverse;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gViewInverse                     c12      4
    //   dShadowParam0123                 c66      1
    //   dShadowMatrix                    c72      4
    //   dShadowParam891113               c76      1
    //   dShadowOffsetScale               c77      1
    //   gDeferredLightPosition           c78      1
    //   gDeferredLightDirection          c79      1
    //   gDeferredLightInvSqrRadius       c80      1
    //   gDeferredLightConeOffset         c81      1
    //   gDeferredLightConeScale          c82      1
    //   gDeferredLightColourAndIntensity c83      1
    //   gooDeferredLightScreenSize       c84      1
    //   gDeferredProjParams              c85      1
    //   GBufferTextureSampler0           s0       1
    //   GBufferTextureSampler1           s1       1
    //   GBufferTextureSampler3           s2       1
    //   gShadowZSamplerCache             s14      1
    //
    
        ps_3_0
        def c0, 0.50999999, 2, -0.999989986, 9.99999975e-006
        def c1, 1, -0.333333343, 1.5, 0.100000001
        def c2, 1, 0, 0.5, -0.5
        def c3, 3, 4.27199984, 0, 0.75
        def c4, 0.159154937, 0.5, 6.28318548, -3.14159274
        def c5, -1, 1, 0.25, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s14
        add r0.xy, c0.x, vPos
        mul r0.xy, r0, c84.zwzw
        texld r1, r0, s2
        mad r0.z, r1.x, c85.z, -c85.w
        mul r0.z, r0.z, v0.w
        rcp r0.z, r0.z
        mad r1.xyz, v0, -r0.z, c15
        texld r2, r0, s1
        texld r0, r0, s0
        mad r2.xyz, r2, c0.y, c0.z
        nrm r3.xyz, r2
        mad r2.xyz, r3, c1.w, r1
        add r1.xyz, -r1, c78
        mul r4.xyz, r2.y, c73
        mad r2.xyw, r2.x, c72.xyzz, r4.xyzz
        mad r2.xyz, r2.z, c74, r2.xyww
        add r2.xyz, r2, c75
        add r0.w, r2.z, c76.z
        mov r2.w, -r0_abs.w
        dp3 r1.w, r2.xyww, r2.xyww
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        add r2.z, r0_abs.w, r1.w
        cmp r4.xy, -r0.w, c2, c2.yxzw
        rcp r0.w, r2.z
        mul r2.xy, r2, r0.w
        mad r2.xy, r2, c2.zwzw, c2.z
        dp2add r0.w, vPos, c3, c3.z
        mad r0.w, r0.w, c4.x, c4.y
        frc r0.w, r0.w
        mad r0.w, r0.w, c4.z, c4.w
        sincos r5.xy, r0.w
        mul r2.zw, r5.xyyx, c77.z
        mad_sat r2.zw, r2, c3.w, r2.xyxy
        mad r2.zw, r2, c77.w, c77.xyxy
        texld r6, r2.zwzw, s14
        dp2add r6.y, r6, r4, c2.y
        mul r2.zw, -r5.xyyx, c77.z
        mul r5, r5.xyxy, c5.xyyx
        mad_sat r2.zw, r2, c5.z, r2.xyxy
        mad r2.zw, r2, c77.w, c77.xyxy
        texld r7, r2.zwzw, s14
        dp2add r6.w, r7, r4, c2.y
        mul r2.zw, r5.xyxy, c77.z
        mad_sat r4.zw, r5, c77.z, r2.xyxy
        mad_sat r2.xy, r2.zwzw, c2.z, r2
        mad r2.xy, r2, c77.w, c77
        texld r2, r2, s14
        dp2add r6.z, r2, r4, c2.y
        mad r2.xy, r4.zwzw, c77.w, c77
        texld r2, r2, s14
        dp2add r6.x, r2, r4, c2.y
        mad r2, r1.w, c66.w, r6
        cmp r2, r2, c2.x, c2.y
        dp4 r0.w, r2, c5.z
        add r2.xyz, r1, c0.w
        dp3 r1.x, r1, r1
        mov r4.x, c1.x
        mad_sat r1.x, r1.x, -c80.x, r4.x
        mad r1.x, r1.x, r1.x, c1.y
        nrm r4.xyz, r2
        dp3 r1.y, r4, -c79
        dp3 r1.z, r3, r4
        add r1.z, r1.z, c1.y
        mul_sat r1.z, r1.z, c1.z
        add r1.y, r1.y, -c81.x
        mul_sat r1.y, r1.y, c82.x
        mul r1.w, r1.x, c1.z
        mul r1.y, r1.y, r1.w
        mul r1.y, r1.z, r1.y
        mul r0.w, r0.w, r1.y
        mul r1.yzw, c83.w, c83.xxyz
        mul r1.yzw, r0.w, r1
        mul r0.xyz, r0, r1.yzww
        cmp oC0.xyz, r1.x, r0, c2.y
        mov oC0.w, c1.x
    
    // approximately 92 instruction slots used (7 texture, 85 arithmetic)
};

PixelShader PS_LightTexPointOrSpot
<
    string GBufferTextureSampler0           = "parameter register(1)";
    string GBufferTextureSampler1           = "parameter register(2)";
    string GBufferTextureSampler2           = "parameter register(4)";
    string GBufferTextureSampler3           = "parameter register(5)";
    string gDeferredLightColourAndIntensity = "parameter register(78)";
    string gDeferredLightConeOffset         = "parameter register(76)";
    string gDeferredLightConeScale          = "parameter register(77)";
    string gDeferredLightDirection          = "parameter register(73)";
    string gDeferredLightInvSqrRadius       = "parameter register(75)";
    string gDeferredLightPosition           = "parameter register(72)";
    string gDeferredLightSampler            = "parameter register(0)";
    string gDeferredLightTangent            = "parameter register(74)";
    string gDeferredLightType               = "parameter register(66)";
    string gDeferredProjParams              = "parameter register(80)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(79)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
    //   sampler2D gDeferredLightSampler;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
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
    //   gDeferredLightType               c66      1
    //   gDeferredLightPosition           c72      1
    //   gDeferredLightDirection          c73      1
    //   gDeferredLightTangent            c74      1
    //   gDeferredLightInvSqrRadius       c75      1
    //   gDeferredLightConeOffset         c76      1
    //   gDeferredLightConeScale          c77      1
    //   gDeferredLightColourAndIntensity c78      1
    //   gooDeferredLightScreenSize       c79      1
    //   gDeferredProjParams              c80      1
    //   gDeferredLightSampler            s0       1
    //   GBufferTextureSampler0           s1       1
    //   GBufferTextureSampler1           s2       1
    //   GBufferTextureSampler2           s4       1
    //   GBufferTextureSampler3           s5       1
    //
    
        ps_3_0
        def c0, 0.50999999, 512, 2, -0.999989986
        def c1, 1, 0.5, 0, 9.99999975e-006
        def c2, -0.100000001, 1.11111116, 0, 0
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        dcl_2d s5
        mul r0.xyz, c78.w, c78
        add r1.xy, c0.x, vPos
        mul r1.xy, r1, c79.zwzw
        texld r2, r1, s5
        texld r3, r1, s1
        mad r0.w, r2.x, c80.z, -c80.w
        mul r0.w, r0.w, v0.w
        rcp r0.w, r0.w
        mad r2.xyz, v0, -r0.w, c15
        texld r4, r1, s4
        add r1.z, r4.x, r4.x
        mul r1.w, r4.y, r4.y
        mul r1.w, r1.w, c0.y
        texld r5, r1, s2
        mad r4.xyw, r5.xyzz, c0.z, c0.w
        nrm r5.xyz, r4.xyww
        add r4.xyw, r2.xyzz, -c72.xyzz
        mov r6.xyz, c73
        mul r7.xyz, -r6.zxyw, c74.yzxw
        mad r6.xyz, -r6.yzxw, c74.zxyw, -r7
        dp3 r1.x, r6, r4.xyww
        dp3 r1.y, c74, r4.xyww
        dp3 r2.w, -c73, r4.xyww
        mov r6.z, c0.z
        if_ge c66.x, r6.z
          mov r6.x, c1.x
          mad r3.w, c76.x, -c76.x, r6.x
          rsq r3.w, r3.w
          mul r3.w, r3.w, c76.x
          rcp r5.w, r2.w
          mul r3.w, r3.w, r5.w
          mul r6.xy, r1, r3.w
          mad r6.xy, r6, c1.y, c1.y
          mov r6.zw, c1.z
          texldl r6, r6, s0
        else
          dp3 r3.w, r4.xyww, r4.xyww
          rsq r3.w, r3.w
          rcp r4.x, r3.w
          mad r2.w, r2.w, -r3.w, c1.x
          mul r2.w, r4.x, r2.w
          rcp r2.w, r2.w
          mul r1.xy, r1, r2.w
          mad r7.xy, r1, c1.y, c1.y
          mov r7.zw, c1.z
          texldl r6, r7, s0
        endif
        mad r4.xyw, v0.xyzz, -r0.w, c1.w
        nrm r7.xyz, r4.xyww
        add r2.xyz, -r2, c72
        dp3 r0.w, r2, r2
        add r2.xyz, r2, c1.w
        nrm r8.xyz, r2
        mov r1.x, c1.x
        mad_sat r0.w, r0.w, -c75.x, r1.x
        mul r0.w, r0.w, r0.w
        mad r0.w, r0.w, r0.w, c2.x
        mul r1.x, r0.w, c2.y
        dp3 r1.y, r8, -c73
        add r1.y, r1.y, -c76.x
        mul_sat r1.y, r1.y, c77.x
        mul r1.x, r1.x, r1.y
        dp3 r1.y, r7, r5
        add r1.y, r1.y, r1.y
        mad r2.xyz, r5, -r1.y, r7
        dp3_sat r1.y, r8, r2
        dp3_sat r2.x, r8, r5
        mul r0.xyz, r0, r1.x
        cmp r0.xyz, r0.w, r0, c1.z
        pow r0.w, r1.y, r1.w
        mul r1.xyw, r0.xyzz, r0.w
        mul r0.xyz, r2.x, r0
        mul r2.xyz, r3, r6
        mul r1.xyz, r1.z, r1.xyww
        mad r0.xyz, r2, r0, r1
        mad_sat r1.x, r4.z, r4.z, c1.y
        mov r0.w, c1.x
        mul oC0, r0, r1.x
    
    // approximately 90 instruction slots used (8 texture, 82 arithmetic)
};

PixelShader PS_LightShadowTexPointOrSpot
<
    string GBufferTextureSampler0           = "parameter register(1)";
    string GBufferTextureSampler1           = "parameter register(2)";
    string GBufferTextureSampler2           = "parameter register(4)";
    string GBufferTextureSampler3           = "parameter register(5)";
    string dShadowMatrix                    = "parameter register(72)";
    string dShadowOffsetScale               = "parameter register(77)";
    string dShadowParam0123                 = "parameter register(66)";
    string dShadowParam891113               = "parameter register(76)";
    string gDeferredLightColourAndIntensity = "parameter register(85)";
    string gDeferredLightConeOffset         = "parameter register(83)";
    string gDeferredLightConeScale          = "parameter register(84)";
    string gDeferredLightDirection          = "parameter register(80)";
    string gDeferredLightInvSqrRadius       = "parameter register(82)";
    string gDeferredLightPosition           = "parameter register(79)";
    string gDeferredLightSampler            = "parameter register(0)";
    string gDeferredLightTangent            = "parameter register(81)";
    string gDeferredLightType               = "parameter register(78)";
    string gDeferredProjParams              = "parameter register(87)";
    string gShadowZSamplerCache             = "parameter register(14)";
    string gViewInverse                     = "parameter register(12)";
    string gooDeferredLightScreenSize       = "parameter register(86)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D GBufferTextureSampler0;
    //   sampler2D GBufferTextureSampler1;
    //   sampler2D GBufferTextureSampler2;
    //   sampler2D GBufferTextureSampler3;
    //   row_major float4x4 dShadowMatrix;
    //   float4 dShadowOffsetScale;
    //   float4 dShadowParam0123;
    //   float4 dShadowParam891113;
    //   float4 gDeferredLightColourAndIntensity;
    //   float gDeferredLightConeOffset;
    //   float gDeferredLightConeScale;
    //   float3 gDeferredLightDirection;
    //   float gDeferredLightInvSqrRadius;
    //   float3 gDeferredLightPosition;
    //   sampler2D gDeferredLightSampler;
    //   float3 gDeferredLightTangent;
    //   float gDeferredLightType;
    //   float4 gDeferredProjParams;
    //   sampler2D gShadowZSamplerCache;
    //   row_major float4x4 gViewInverse;
    //   float4 gooDeferredLightScreenSize;
    //
    //
    // Registers:
    //
    //   Name                             Reg   Size
    //   -------------------------------- ----- ----
    //   gViewInverse                     c12      4
    //   dShadowParam0123                 c66      1
    //   dShadowMatrix                    c72      4
    //   dShadowParam891113               c76      1
    //   dShadowOffsetScale               c77      1
    //   gDeferredLightType               c78      1
    //   gDeferredLightPosition           c79      1
    //   gDeferredLightDirection          c80      1
    //   gDeferredLightTangent            c81      1
    //   gDeferredLightInvSqrRadius       c82      1
    //   gDeferredLightConeOffset         c83      1
    //   gDeferredLightConeScale          c84      1
    //   gDeferredLightColourAndIntensity c85      1
    //   gooDeferredLightScreenSize       c86      1
    //   gDeferredProjParams              c87      1
    //   gDeferredLightSampler            s0       1
    //   GBufferTextureSampler0           s1       1
    //   GBufferTextureSampler1           s2       1
    //   GBufferTextureSampler2           s4       1
    //   GBufferTextureSampler3           s5       1
    //   gShadowZSamplerCache             s14      1
    //
    
        ps_3_0
        def c0, 0.50999999, 512, 2, -0.999989986
        def c1, 1, 0.5, 0, 9.99999975e-006
        def c2, -0.100000001, 1.11111116, 0.100000001, 0.75
        def c3, 0.5, -0.5, 0.159154937, 0.25
        def c4, 3, 4.27199984, 0, 0
        def c5, 6.28318548, -3.14159274, -1, 1
        dcl_texcoord v0
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s1
        dcl_2d s2
        dcl_2d s4
        dcl_2d s5
        dcl_2d s14
        mul r0.xyz, c85.w, c85
        add r1.xy, c0.x, vPos
        mul r1.xy, r1, c86.zwzw
        texld r2, r1, s5
        texld r3, r1, s1
        mad r0.w, r2.x, c87.z, -c87.w
        mul r0.w, r0.w, v0.w
        rcp r0.w, r0.w
        mad r2.xyz, v0, -r0.w, c15
        texld r4, r1, s4
        add r1.z, r4.x, r4.x
        mul r1.w, r4.y, r4.y
        mul r1.w, r1.w, c0.y
        texld r4, r1, s2
        mad r4.xyz, r4, c0.z, c0.w
        nrm r5.xyz, r4
        add r4.xyz, r2, -c79
        mov r6.xyz, c80
        mul r7.xyz, -r6.zxyw, c81.yzxw
        mad r6.xyz, -r6.yzxw, c81.zxyw, -r7
        dp3 r1.x, r6, r4
        dp3 r1.y, c81, r4
        dp3 r2.w, -c80, r4
        mov r6.z, c0.z
        if_ge c78.x, r6.z
          mov r6.x, c1.x
          mad r3.w, c83.x, -c83.x, r6.x
          rsq r3.w, r3.w
          mul r3.w, r3.w, c83.x
          rcp r4.w, r2.w
          mul r3.w, r3.w, r4.w
          mul r6.xy, r1, r3.w
          mad r6.xy, r6, c1.y, c1.y
          mov r6.zw, c1.z
          texldl r6, r6, s0
        else
          dp3 r3.w, r4, r4
          rsq r3.w, r3.w
          rcp r4.x, r3.w
          mad r2.w, r2.w, -r3.w, c1.x
          mul r2.w, r4.x, r2.w
          rcp r2.w, r2.w
          mul r1.xy, r1, r2.w
          mad r4.xy, r1, c1.y, c1.y
          mov r4.zw, c1.z
          texldl r6, r4, s0
        endif
        mad r4.xyz, v0, -r0.w, c1.w
        nrm r7.xyz, r4
        add r4.xyz, -r2, c79
        dp3 r0.w, r4, r4
        add r4.xyz, r4, c1.w
        nrm r8.xyz, r4
        mov r1.x, c1.x
        mad_sat r0.w, r0.w, -c82.x, r1.x
        mul r0.w, r0.w, r0.w
        mad r0.w, r0.w, r0.w, c2.x
        mul r1.x, r0.w, c2.y
        mul r0.xyz, r0, r1.x
        dp3 r1.x, r8, -c80
        add r1.x, r1.x, -c83.x
        mul_sat r1.x, r1.x, c84.x
        mul r0.xyz, r0, r1.x
        mad r2.xyz, r5, c2.z, r2
        mul r4.xyz, r2.y, c73
        mad r2.xyw, r2.x, c72.xyzz, r4.xyzz
        mad r2.xyz, r2.z, c74, r2.xyww
        add r2.xyz, r2, c75
        add r1.x, r2.z, c76.z
        cmp r4.xy, -r1.x, c1.xzzw, c1.zxzw
        mov r2.w, -r1_abs.x
        dp3 r1.y, r2.xyww, r2.xyww
        rsq r1.y, r1.y
        rcp r1.y, r1.y
        add r1.x, r1_abs.x, r1.y
        rcp r1.x, r1.x
        mul r2.xy, r2, r1.x
        mad r2.xy, r2, c3, c3.x
        dp2add r1.x, vPos, c4, c4.z
        mad r1.x, r1.x, c3.z, c3.x
        frc r1.x, r1.x
        mad r1.x, r1.x, c5.x, c5.y
        sincos r9.xy, r1.x
        mul r2.zw, r9.xyyx, c77.z
        mul r10, r9.xyxy, c5.zwwz
        mul r4.zw, -r9.xyyx, c77.z
        mul r9.xy, r10, c77.z
        mad_sat r9.zw, r10, c77.z, r2.xyxy
        mad_sat r2.zw, r2, c2.w, r2.xyxy
        mad_sat r9.xy, r9, c1.y, r2
        mad_sat r2.xy, r4.zwzw, c3.w, r2
        mad r4.zw, r9, c77.w, c77.xyxy
        mad r2.zw, r2, c77.w, c77.xyxy
        mad r9.xy, r9, c77.w, c77
        mad r2.xy, r2, c77.w, c77
        texld r10, r4.zwzw, s14
        dp2add r10.x, r10, r4, c1.z
        texld r11, r2.zwzw, s14
        dp2add r10.y, r11, r4, c1.z
        texld r9, r9, s14
        dp2add r10.z, r9, r4, c1.z
        texld r2, r2, s14
        dp2add r10.w, r2, r4, c1.z
        mad r2, r1.y, c66.w, r10
        cmp r2, r2, c1.x, c1.z
        dp4 r1.x, r2, c3.w
        mul r0.xyz, r0, r1.x
        cmp r0.xyz, r0.w, r0, c1.z
        dp3 r0.w, r7, r5
        add r0.w, r0.w, r0.w
        mad r2.xyz, r5, -r0.w, r7
        dp3_sat r0.w, r8, r2
        pow r2.x, r0.w, r1.w
        dp3_sat r0.w, r8, r5
        mul r1.xyw, r0.xyzz, r2.x
        mul r0.xyz, r0, r0.w
        mul r2.xyz, r3, r6
        mul r1.xyz, r1.z, r1.xyww
        mad oC0.xyz, r2, r0, r1
        mov oC0.w, c1.x
    
    // approximately 144 instruction slots used (12 texture, 132 arithmetic)
};

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
        mul r0.xyz, c0.xxyw, v0.xyxw
        mov r0.w, c66.z
        texldl r0, r0, s0
        abs r0.w, c66.w
        pow r1.x, r0.w, c0.z
        mul oC0.xyz, r0, r1.x
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
        mul r0.xyz, c0.xxyw, v0.xyxw
        mov r0.w, c66.z
        texldl r0, r0, s0
        mov oC0.xyz, r0
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
        PixelShader = PS_LightShadowDirectionalAmbientReflectionDry;
    }
    pass p1
    {
        ZEnable = false;
        ZWriteEnable = false;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransformS;
        PixelShader = PS_LightShadowDirectionalAmbientReflectionWet;
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
        PixelShader = PS_LightAmbientReflectionDry;
    }
    pass p1
    {
        ZEnable = false;
        ZWriteEnable = false;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransformS;
        PixelShader = PS_LightAmbientReflectionWet;
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
        PixelShader = PS_Black;
    }
    pass p1
    {
        CullMode = NONE;
        ZEnable = true;
        ZWriteEnable = false;

        VertexShader = VS_VolumeTransformPS0;
        PixelShader = PS_Black;
    }
    pass p2
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;

        VertexShader = VS_VolumeShadowTransformPS0;
        PixelShader = PS_Black;
    }
    pass p3
    {
        CullMode = NONE;
        ZEnable = true;
        ZWriteEnable = false;

        VertexShader = VS_VolumeShadowTransformPS0;
        PixelShader = PS_Black;
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
        PixelShader = PS_LightPointOrSpot0;
    }
    pass p1
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = PS_LightPointOrSpot1;
    }
    pass p2
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = PS_LightPointOrSpot2;
    }
    pass p3
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = PS_LightPointOrSpot3;
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
        PixelShader = PS_FillerPointOrSpot0;
    }
    pass p1
    {
        CullMode = CCW;
        ZWriteEnable = false;
        ZEnable = true;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = PS_FillerPointOrSpot1;
    }
    pass p2
    {
        CullMode = CCW;
        ZWriteEnable = false;
        ZEnable = true;
        ZFunc = GREATER;

        VertexShader = VS_VolumeTransformPS;
        PixelShader = PS_FillerPointOrSpot2;
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
        PixelShader = PS_DebugLightColorC;
    }
    pass p1
    {
        CullMode = CCW;
        ZWriteEnable = false;
        ZEnable = true;
        ZFunc = GREATER;

        VertexShader = VS_VolumeShadowTransformPSC;
        PixelShader = PS_DebugLightColorC;
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
        PixelShader = PS_LightShadowPointOrSpot;
    }
    pass p1
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeShadowTransformPS;
        PixelShader = PS_LightShadowPointOrSpot;
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
        PixelShader = PS_FillerShadowPointOrSpot;
    }
    pass p1
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeShadowTransformPS;
        PixelShader = PS_FillerShadowPointOrSpot;
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
        PixelShader = PS_LightTexPointOrSpot;
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
        PixelShader = PS_LightShadowTexPointOrSpot;
    }
    pass p1
    {
        CullMode = CCW;
        ZEnable = true;
        ZWriteEnable = false;
        ZFunc = GREATER;

        VertexShader = VS_VolumeShadowTransformPS;
        PixelShader = PS_LightShadowTexPointOrSpot;
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

        VertexShader = VS_ScreenTransform;
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

        VertexShader = VS_ScreenTransform;
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

        VertexShader = VS_ScreenTransform;
        PixelShader = PS_GBufferCopy2;
    }
    pass p3
    {
        CullMode = NONE;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransform;
        PixelShader = PS_DepthCopy0;
    }
    pass p4
    {
        CullMode = NONE;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransform;
        PixelShader = PS_DepthCopy0;
    }
    pass p5
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransform;
        PixelShader = PS_DebugAlphaDepth;
    }
    pass p6
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransform;
        PixelShader = PS_DebugShadowCasters;
    }
    pass p7
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransform;
        PixelShader = PS_DebugNoDiffTex;
    }
    pass p8
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransform;
        PixelShader = PS_DebugShowOverdraw;
    }
    pass p9
    {
        CullMode = NONE;
        ZEnable = false;
        ZWriteEnable = false;
        ZFunc = ALWAYS;
        AlphaTestEnable = false;

        VertexShader = VS_ScreenTransform;
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

        VertexShader = VS_ScreenTransformT;
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

        VertexShader = VS_ScreenTransformT;
        PixelShader = PS_RefBlend;
    }
}


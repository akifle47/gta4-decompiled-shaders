//Globals
shared float4 gAllGlobals[64] : AllGlobals;
shared float4x3 gBoneMtx[48] : WorldMatrixArray;
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

//Locals
float3 globalAnimUV0 : globalAnimUV0 = float3(1.000000, 0.000000, 0.000000);
float3 globalAnimUV1 : globalAnimUV1 = float3(0.000000, 1.000000, 0.000000);
int drawBucket : __rage_drawbucket<int Bucket = 1;> = 1;
texture DiffuseTex;
sampler TextureSampler<string UIName = "Diffuse Texture";> = 
sampler_state
{
    Texture = <DiffuseTex>;
    AddressU = WRAP;
    AddressV = WRAP;
    AddressW = WRAP;
    MipFilter = LINEAR;
    MinFilter = ANISOTROPIC;
    MagFilter = LINEAR;
};
float shadowmap_res : ShadowMapResolution = 1280.000000;
float2 facetMask[4] : facetMask = 
{
    float2(-1.000000, 0.000000), 
    float2(1.000000, 0.000000), 
    float2(0.000000, -1.000000), 
    float2(0.000000, 1.000000)
};
float Fade_Thickness : FadeThickness<string UIName = "Thickness of object in metres"; string UIHelp = "Amount of thickness of object"; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.010000;> = 0.070000;
float3 LuminanceConstants : LuminanceConstants = float3(0.212500, 0.715400, 0.072100);

//Vertex shaders
VertexShader VS_Transform
<
    string Fade_Thickness   = "parameter register(210)";
    string gDayNightEffects = "parameter register(45)";
    string gViewInverse     = "parameter register(12)";
    string gWorld           = "parameter register(0)";
    string gWorldViewProj   = "parameter register(8)";
    string globalAnimUV0    = "parameter register(208)";
    string globalAnimUV1    = "parameter register(209)";
    string globalScalars    = "parameter register(39)";
    string globalScalars2   = "parameter register(40)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float Fade_Thickness;
    //   float4 gDayNightEffects;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldViewProj;
    //   float3 globalAnimUV0;
    //   float3 globalAnimUV1;
    //   float4 globalScalars;
    //   float4 globalScalars2;
    //
    //
    // Registers:
    //
    //   Name             Reg   Size
    //   ---------------- ----- ----
    //   gWorld           c0       4
    //   gWorldViewProj   c8       4
    //   gViewInverse     c12      4
    //   globalScalars    c39      1
    //   globalScalars2   c40      1
    //   gDayNightEffects c45      1
    //   globalAnimUV0    c208     1
    //   globalAnimUV1    c209     1
    //   Fade_Thickness   c210     1
    //
    
        vs_3_0
        def c4, 9.99999975e-006, 1, 0, -0.00200000009
        def c5, 320, 0, 0, 0
        dcl_position v0
        dcl_color v1
        dcl_texcoord v2
        dcl_normal v3
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2
        dcl_color o3
        dcl_texcoord6 o4
        dcl_texcoord8 o5
        dcl_texcoord7 o6
        mul r0.xyz, c1, v3.y
        mad r0.xyz, v3.x, c0, r0
        mad r0.xyz, v3.z, c2, r0
        add r0.xyz, r0, c4.x
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul o2.xyz, r0, r0.w
        mad r0.xyz, v2.xyxw, c4.yyzw, c4.zzyw
        dp3 o1.x, c208, r0
        dp3 o1.y, c209, r0
        mov r0.xyz, c12
        mul r0.xyz, r0, c210.x
        dp3 r1.x, r0, c0
        dp3 r1.y, r0, c1
        dp3 r1.z, r0, c2
        add r0.xyz, r1, v0
        mul r0.yw, r0.y, c9.xxzw
        mad r0.xy, r0.x, c8.xwzw, r0.ywzw
        mad r0.xy, r0.z, c10.xwzw, r0
        add r0.xy, r0, c11.xwzw
        rcp r0.y, r0.y
        mul r1, c9, v0.y
        mad r1, v0.x, c8, r1
        mad r1, v0.z, c10, r1
        add r1, r1, c11
        rcp r0.z, r1.w
        mul r0.z, r1.x, r0.z
        mad r0.x, r0.x, r0.y, -r0.z
        mul_sat o6.z, r0.x, c5.x
        mul r0.xy, c45, v1
        add r0.x, r0.y, r0.x
        mov r0.y, c4.y
        mad r0.x, r0.x, c39.z, -r0.y
        mad o3.xy, c40.z, r0.x, r0.y
        mul r0.xyz, c1, v0.y
        mad r0.xyz, v0.x, c0, r0
        mad r0.xyz, v0.z, c2, r0
        add r0.xyz, r0, c3
        add r2.xyz, r0, -c15
        mov o4.xyz, r0
        dp3 r0.x, r2, r2
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        mov r2.xyz, v0
        add r0.yzw, r2.xxyz, v3.xxyz
        mul r2.xy, r0.z, c9
        mad r0.yz, r0.y, c8.xxyw, r2.xxyw
        mad r0.yz, r0.w, c10.xxyw, r0
        add r0.yz, r0, c11.xxyw
        add r0.yz, r1.xxyw, -r0
        mul r0.yz, r0, c4.w
        mad r0.xy, r0.yzzw, r0.x, r1
        mov r0.zw, r1
        mov o6.xyw, r1
        mov o0, r0
        mov o5, r0
        mov o2.w, r0.w
        mov o3.zw, v1
        mov o4.w, c4.y
    
    // approximately 59 instruction slots used
};

VertexShader VS_TransformSkin
<
    string gBoneMtx         = "parameter register(64)";
    string gDayNightEffects = "parameter register(45)";
    string gViewInverse     = "parameter register(12)";
    string gWorld           = "parameter register(0)";
    string gWorldViewProj   = "parameter register(8)";
    string globalAnimUV0    = "parameter register(208)";
    string globalAnimUV1    = "parameter register(209)";
    string globalScalars    = "parameter register(39)";
    string globalScalars2   = "parameter register(40)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4x3 gBoneMtx[48];
    //   float4 gDayNightEffects;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldViewProj;
    //   float3 globalAnimUV0;
    //   float3 globalAnimUV1;
    //   float4 globalScalars;
    //   float4 globalScalars2;
    //
    //
    // Registers:
    //
    //   Name             Reg   Size
    //   ---------------- ----- ----
    //   gWorld           c0       4
    //   gWorldViewProj   c8       4
    //   gViewInverse     c12      4
    //   globalScalars    c39      1
    //   globalScalars2   c40      1
    //   gDayNightEffects c45      1
    //   gBoneMtx         c64    144
    //   globalAnimUV0    c208     1
    //   globalAnimUV1    c209     1
    //
    
        vs_3_0
        def c0, 765.005859, 1, 0, -0.00200000009
        dcl_position v0
        dcl_blendweight v1
        dcl_blendindices v2
        dcl_texcoord v3
        dcl_normal v4
        dcl_color v5
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2
        dcl_color o3
        dcl_texcoord6 o4
        dcl_texcoord8 o5
        dcl_texcoord7 o6
        mul r0, c0.x, v2
        mova a0, r0
        mul r0, v1.y, c64[a0.y]
        mad r0, c64[a0.x], v1.x, r0
        mad r0, c64[a0.z], v1.z, r0
        mad r0, c64[a0.w], v1.w, r0
        dp3 o2.x, v4, r0
        mul r1, v1.y, c65[a0.y]
        mad r1, c65[a0.x], v1.x, r1
        mad r1, c65[a0.z], v1.z, r1
        mad r1, c65[a0.w], v1.w, r1
        dp3 o2.y, v4, r1
        mul r2, v1.y, c66[a0.y]
        mad r2, c66[a0.x], v1.x, r2
        mad r2, c66[a0.z], v1.z, r2
        mad r2, c66[a0.w], v1.w, r2
        dp3 o2.z, v4, r2
        mad r3.xyz, v3.xyxw, c0.yyzw, c0.zzyw
        dp3 o1.x, c208, r3
        dp3 o1.y, c209, r3
        mad r3, v0.xyzx, c0.yyyz, c0.zzzy
        dp4 r0.x, r3, r0
        dp4 r0.y, r3, r1
        dp4 r0.z, r3, r2
        add o4.xyz, r0, c3
        add r1.xyz, r0, -c15
        mul r2, r0.y, c9
        mad r2, r0.x, c8, r2
        mad r0, r0.z, c10, r2
        add r0, r0, c11
        dp3 r1.x, r1, r1
        rsq r1.x, r1.x
        rcp r1.x, r1.x
        mov r2.xyz, v4
        add r1.yzw, r2.xxyz, v0.xxyz
        mul r2.xy, r1.z, c9
        mad r1.yz, r1.y, c8.xxyw, r2.xxyw
        mad r1.yz, r1.w, c10.xxyw, r1
        add r1.yz, r1, c11.xxyw
        add r1.yz, r0.xxyw, -r1
        mul r1.yz, r1, c0.w
        mad o0.xy, r1.yzzw, r1.x, r0
        mul r0.xy, c45, v5
        add r0.x, r0.y, r0.x
        mov r0.y, c0.y
        mad r0.x, r0.x, c39.z, -r0.y
        mad o3.xy, c40.z, r0.x, r0.y
        mov o0.zw, r0
        mov o2.w, r0.w
        mov o3.zw, v5
        mov o4.w, c0.y
        mov o5, c0.z
        mov o6, c0.z
    
    // approximately 53 instruction slots used
};

VertexShader VS_TransformUnlit
<
    string gWorldViewProj = "parameter register(8)";
    string globalAnimUV0  = "parameter register(208)";
    string globalAnimUV1  = "parameter register(209)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   row_major float4x4 gWorldViewProj;
    //   float3 globalAnimUV0;
    //   float3 globalAnimUV1;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   gWorldViewProj c8       4
    //   globalAnimUV0  c208     1
    //   globalAnimUV1  c209     1
    //
    
        vs_3_0
        def c0, 1, 0, 0, 0
        dcl_position v0
        dcl_color v1
        dcl_texcoord v2
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_color o2
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add o0, r0, c11
        mad r0.xyz, v2.xyxw, c0.xxyw, c0.yyxw
        dp3 o1.x, c208, r0
        dp3 o1.y, c209, r0
        mov o2, v1
    
    // approximately 8 instruction slots used
};

VertexShader VS_TransformSkinUnlit
<
    string gBoneMtx       = "parameter register(64)";
    string gWorldViewProj = "parameter register(8)";
    string globalAnimUV0  = "parameter register(208)";
    string globalAnimUV1  = "parameter register(209)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4x3 gBoneMtx[48];
    //   row_major float4x4 gWorldViewProj;
    //   float3 globalAnimUV0;
    //   float3 globalAnimUV1;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   gWorldViewProj c8       4
    //   gBoneMtx       c64    144
    //   globalAnimUV0  c208     1
    //   globalAnimUV1  c209     1
    //
    
        vs_3_0
        def c0, 765.005859, 1, 0, 0
        dcl_position v0
        dcl_blendweight v1
        dcl_blendindices v2
        dcl_texcoord v3
        dcl_color v4
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_color o2
        mul r0, c0.x, v2
        mova a0, r0
        mul r0, v1.y, c65[a0.y]
        mad r0, c65[a0.x], v1.x, r0
        mad r0, c65[a0.z], v1.z, r0
        mad r0, c65[a0.w], v1.w, r0
        mad r1, v0.xyzx, c0.yyyz, c0.zzzy
        dp4 r0.x, r1, r0
        mul r0, r0.x, c9
        mul r2, v1.y, c64[a0.y]
        mad r2, c64[a0.x], v1.x, r2
        mad r2, c64[a0.z], v1.z, r2
        mad r2, c64[a0.w], v1.w, r2
        dp4 r2.x, r1, r2
        mad r0, r2.x, c8, r0
        mul r2, v1.y, c66[a0.y]
        mad r2, c66[a0.x], v1.x, r2
        mad r2, c66[a0.z], v1.z, r2
        mad r2, c66[a0.w], v1.w, r2
        dp4 r1.x, r1, r2
        mad r0, r1.x, c10, r0
        add o0, r0, c11
        mad r0.xyz, v3.xyxw, c0.yyzw, c0.zzyw
        dp3 o1.x, c208, r0
        dp3 o1.y, c209, r0
        mov o2, v4
    
    // approximately 26 instruction slots used
};

VertexShader VS_TransformD
<
    string gDayNightEffects = "parameter register(45)";
    string gWorld           = "parameter register(0)";
    string gWorldViewProj   = "parameter register(8)";
    string globalAnimUV0    = "parameter register(208)";
    string globalAnimUV1    = "parameter register(209)";
    string globalScalars    = "parameter register(39)";
    string globalScalars2   = "parameter register(40)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDayNightEffects;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldViewProj;
    //   float3 globalAnimUV0;
    //   float3 globalAnimUV1;
    //   float4 globalScalars;
    //   float4 globalScalars2;
    //
    //
    // Registers:
    //
    //   Name             Reg   Size
    //   ---------------- ----- ----
    //   gWorld           c0       4
    //   gWorldViewProj   c8       4
    //   globalScalars    c39      1
    //   globalScalars2   c40      1
    //   gDayNightEffects c45      1
    //   globalAnimUV0    c208     1
    //   globalAnimUV1    c209     1
    //
    
        vs_3_0
        def c4, 9.99999975e-006, 1, 0, -1
        dcl_position v0
        dcl_color v1
        dcl_texcoord v2
        dcl_normal v3
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2
        dcl_color o3
        dcl_texcoord6 o4
        mul r0.xyz, c1, v0.y
        mad r0.xyz, v0.x, c0, r0
        mad r0.xyz, v0.z, c2, r0
        add o4.xyz, r0, c3
        mul r0.xyz, c1, v3.y
        mad r0.xyz, v3.x, c0, r0
        mad r0.xyz, v3.z, c2, r0
        add r0.xyz, r0, c4.x
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul o2.xyz, r0, r0.w
        mad r0.xyz, v2.xyxw, c4.yyzw, c4.zzyw
        dp3 o1.x, c208, r0
        dp3 o1.y, c209, r0
        mul r0.xy, c45, v1
        add r0.x, r0.y, r0.x
        mov r0.yw, c4
        mad r0.x, r0.x, c39.z, r0.w
        mad o3.xy, c40.z, r0.x, r0.y
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add r0, r0, c11
        mov o0, r0
        mov o2.w, r0.w
        mov o3.zw, v1
        mov o4.w, c4.y
    
    // approximately 27 instruction slots used
};

VertexShader VS_TransformAlphaClipD
<
    string gDayNightEffects = "parameter register(45)";
    string gWorld           = "parameter register(0)";
    string gWorldViewProj   = "parameter register(8)";
    string globalAnimUV0    = "parameter register(208)";
    string globalAnimUV1    = "parameter register(209)";
    string globalScalars    = "parameter register(39)";
    string globalScalars2   = "parameter register(40)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDayNightEffects;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldViewProj;
    //   float3 globalAnimUV0;
    //   float3 globalAnimUV1;
    //   float4 globalScalars;
    //   float4 globalScalars2;
    //
    //
    // Registers:
    //
    //   Name             Reg   Size
    //   ---------------- ----- ----
    //   gWorld           c0       4
    //   gWorldViewProj   c8       4
    //   globalScalars    c39      1
    //   globalScalars2   c40      1
    //   gDayNightEffects c45      1
    //   globalAnimUV0    c208     1
    //   globalAnimUV1    c209     1
    //
    
        vs_3_0
        def c4, 9.99999975e-006, 1, 0, -1
        dcl_position v0
        dcl_color v1
        dcl_texcoord v2
        dcl_normal v3
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2
        dcl_color o3
        dcl_texcoord6 o4
        mul r0.xyz, c1, v0.y
        mad r0.xyz, v0.x, c0, r0
        mad r0.xyz, v0.z, c2, r0
        add o4.xyz, r0, c3
        mul r0.xyz, c1, v3.y
        mad r0.xyz, v3.x, c0, r0
        mad r0.xyz, v3.z, c2, r0
        add r0.xyz, r0, c4.x
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul o2.xyz, r0, r0.w
        mad r0.xyz, v2.xyxw, c4.yyzw, c4.zzyw
        dp3 o1.x, c208, r0
        dp3 o1.y, c209, r0
        mul r0.xy, c45, v1
        add r0.x, r0.y, r0.x
        mov r0.yw, c4
        mad r0.x, r0.x, c39.z, r0.w
        mad o3.xy, c40.z, r0.x, r0.y
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add r0, r0, c11
        mov o0, r0
        mov o2.w, r0.w
        mov o3.zw, v1
        mov o4.w, c4.y
    
    // approximately 27 instruction slots used
};

VertexShader VS_TransformSkinD
<
    string gBoneMtx         = "parameter register(64)";
    string gDayNightEffects = "parameter register(45)";
    string gWorldViewProj   = "parameter register(8)";
    string globalAnimUV0    = "parameter register(208)";
    string globalAnimUV1    = "parameter register(209)";
    string globalScalars    = "parameter register(39)";
    string globalScalars2   = "parameter register(40)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4x3 gBoneMtx[48];
    //   float4 gDayNightEffects;
    //   row_major float4x4 gWorldViewProj;
    //   float3 globalAnimUV0;
    //   float3 globalAnimUV1;
    //   float4 globalScalars;
    //   float4 globalScalars2;
    //
    //
    // Registers:
    //
    //   Name             Reg   Size
    //   ---------------- ----- ----
    //   gWorldViewProj   c8       4
    //   globalScalars    c39      1
    //   globalScalars2   c40      1
    //   gDayNightEffects c45      1
    //   gBoneMtx         c64    144
    //   globalAnimUV0    c208     1
    //   globalAnimUV1    c209     1
    //
    
        vs_3_0
        def c0, 765.005859, 1, 0, -1
        dcl_position v0
        dcl_blendweight v1
        dcl_blendindices v2
        dcl_texcoord v3
        dcl_normal v4
        dcl_color v5
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2
        dcl_color o3
        dcl_texcoord6 o4
        mul r0, c0.x, v2
        mova a0, r0
        mul r0, v1.y, c64[a0.y]
        mad r0, c64[a0.x], v1.x, r0
        mad r0, c64[a0.z], v1.z, r0
        mad r0, c64[a0.w], v1.w, r0
        dp3 o2.x, v4, r0
        mul r1, v1.y, c65[a0.y]
        mad r1, c65[a0.x], v1.x, r1
        mad r1, c65[a0.z], v1.z, r1
        mad r1, c65[a0.w], v1.w, r1
        dp3 o2.y, v4, r1
        mul r2, v1.y, c66[a0.y]
        mad r2, c66[a0.x], v1.x, r2
        mad r2, c66[a0.z], v1.z, r2
        mad r2, c66[a0.w], v1.w, r2
        dp3 o2.z, v4, r2
        mad r3.xyz, v3.xyxw, c0.yyzw, c0.zzyw
        dp3 o1.x, c208, r3
        dp3 o1.y, c209, r3
        mul r3.xy, c45, v5
        add r3.x, r3.y, r3.x
        mov r3.yw, c0
        mad r3.x, r3.x, c39.z, r3.w
        mad o3.xy, c40.z, r3.x, r3.y
        mad r3, v0.xyzx, c0.yyyz, c0.zzzy
        dp4 r1.y, r3, r1
        mul r4, r1.y, c9
        dp4 r1.x, r3, r0
        dp4 r1.z, r3, r2
        mad r0, r1.x, c8, r4
        mov o4.xyz, r1
        mad r0, r1.z, c10, r0
        add r0, r0, c11
        mov o0, r0
        mov o2.w, r0.w
        mov o3.zw, v5
        mov o4.w, c0.y
    
    // approximately 38 instruction slots used
};

VertexShader VS_ShadowDepth
<
    string gShadowMatrix = "parameter register(60)";
    string gWorld        = "parameter register(0)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   row_major float4x4 gShadowMatrix;
    //   row_major float4x4 gWorld;
    //
    //
    // Registers:
    //
    //   Name          Reg   Size
    //   ------------- ----- ----
    //   gWorld        c0       4
    //   gShadowMatrix c60      4
    //
    
        vs_3_0
        def c4, 1, 0, 0, 0
        dcl_position v0
        dcl_texcoord v1
        dcl_position o0
        dcl_texcoord o1.xyz
        mul r0.xyz, c1, v0.y
        mad r0.xyz, v0.x, c0, r0
        mad r0.xyz, v0.z, c2, r0
        add r0.xyz, r0, c3
        mul r1, r0.y, c61
        mad r1, r0.x, c60, r1
        mad r0, r0.z, c62, r1
        add r0, r0, c63
        min r0.z, r0.z, c4.x
        add o0.z, -r0.z, c4.x
        mad o0.xyw, r0.xyzx, c4.xxzy, c4.yyzx
        mov o1.x, r0.w
        mov o1.yz, v1.xxyw
    
    // approximately 13 instruction slots used
};

VertexShader VS_ShadowDepthSkin
<
    string facetMask            = "parameter register(208)";
    string gBoneMtx             = "parameter register(64)";
    string gShadowMatrix        = "parameter register(60)";
    string gShadowParam0123     = "parameter register(57)";
    string gShadowParam14151617 = "parameter register(56)";
    string gShadowParam891113   = "parameter register(59)";
    string gWorld               = "parameter register(0)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float2 facetMask[4];
    //   float4x3 gBoneMtx[48];
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam891113;
    //   row_major float4x4 gWorld;
    //
    //
    // Registers:
    //
    //   Name                 Reg   Size
    //   -------------------- ----- ----
    //   gWorld               c0       4
    //   gShadowParam14151617 c56      1
    //   gShadowParam0123     c57      1
    //   gShadowParam891113   c59      1
    //   gShadowMatrix        c60      4
    //   gBoneMtx             c64    144
    //   facetMask            c208     4
    //
    
        vs_3_0
        def c0, 765.005859, 1, 0, -0.5
        def c1, 2, 9.99999994e-009, 0, 0
        dcl_position v0
        dcl_blendweight v1
        dcl_blendindices v2
        dcl_texcoord v3
        dcl_position o0
        dcl_texcoord o1.xyz
        mul r0, c0.x, v2
        mova a0, r0
        mul r0, v1.y, c64[a0.y]
        mul r1, v1.y, c65[a0.y]
        mul r2, v1.y, c66[a0.y]
        mad r0, c64[a0.x], v1.x, r0
        mad r1, c65[a0.x], v1.x, r1
        mad r2, c66[a0.x], v1.x, r2
        mad r0, c64[a0.z], v1.z, r0
        mad r1, c65[a0.z], v1.z, r1
        mad r2, c66[a0.z], v1.z, r2
        mad r0, c64[a0.w], v1.w, r0
        mad r1, c65[a0.w], v1.w, r1
        mad r2, c66[a0.w], v1.w, r2
        mad r3, v0.xyzx, c0.yyyz, c0.zzzy
        dp4 r0.x, r3, r0
        dp4 r0.y, r3, r1
        dp4 r0.z, r3, r2
        add r0.xyz, r0, c3
        mul r1, r0.y, c61
        mad r1, r0.x, c60, r1
        mad r1, r0.z, c62, r1
        add r1, r1, c63
        min r0.w, r1.z, c0.y
        add o0.z, -r0.w, c0.y
        abs r0.w, c56.x
        if_ge -r0.w, r0.w
          mul r2.xyz, r0.y, c61
          mad r2.xyz, r0.x, c60, r2
          mad r2.xyz, r0.z, c62, r2
          add r2.xyz, r2, c63
          add r0.w, r2.z, c59.z
          abs r1.z, c56.y
          sge r1.z, -r1.z, r1.z
          add r1.z, r1.z, c0.w
          mul r0.w, r0.w, r1.z
          add r2.w, r0.w, r0.w
          dp3 r1.z, r2.xyww, r2.xyww
          rsq r1.z, r1.z
          rcp r1.z, r1.z
          mad r0.w, r0.w, -c1.x, r1.z
          rcp r0.w, r0.w
          mul r3.xy, r2, r0.w
          mul r3.w, r2.w, -c57.w
          mul r3.z, r1.z, -c57.w
        else
          mov r2.y, c0.y
          add r0.w, -r2.y, c56.x
          if_ge -r0_abs.w, r0_abs.w
            mul r2.xyz, r0.y, c61
            mad r2.xyz, r0.x, c60, r2
            mad r2.xyz, r0.z, c62, r2
            add r2.xyz, r2, c63
            mul r4.z, r2.z, c57.w
            mov r2.w, -c0.w
            mov r4.xy, c57.z
            mul r3.xyz, r2.xyww, r4
            frc r0.w, c56.y
            add r0.w, -r0.w, c56.y
            mova a0.x, r0.w
            mul r2.xy, r3, c208[a0.x]
            add r0.w, r2.y, r2.x
            add r3.w, r0.w, c1.x
            max r3.z, r3.z, c0.z
          else
            mul r2.xyz, r0.y, c61
            mad r0.xyw, r0.x, c60.xyzz, r2.xyzz
            mad r0.xyz, r0.z, c62, r0.xyww
            add r0.xyz, r0, c63
            mul r3.xy, r0, c57.z
            mov r3.w, -r0.z
            mov r0.x, c57.x
            add r0.y, r0.x, -c59.w
            rcp r0.y, r0.y
            mul r0.w, r0.y, c59.w
            mul r0.x, r0.x, c59.w
            mul r0.x, r0.y, r0.x
            mad r3.z, r0.z, r0.w, r0.x
          endif
        endif
        dp4 r0.x, r3, c0.y
        mad o0.x, r0.x, c1.y, r1.x
        mad o0.yw, r1.y, c0.xyzz, c0.xzzy
        mov o1.x, r1.w
        mov o1.yz, v3.xxyw
    
    // approximately 89 instruction slots used
};

VertexShader VS_TransformParaboloid
<
    string gDayNightEffects = "parameter register(45)";
    string gViewInverse     = "parameter register(12)";
    string gWorld           = "parameter register(0)";
    string gWorldView       = "parameter register(4)";
    string globalAnimUV0    = "parameter register(208)";
    string globalAnimUV1    = "parameter register(209)";
    string globalScalars    = "parameter register(39)";
    string globalScalars2   = "parameter register(40)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gDayNightEffects;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldView;
    //   float3 globalAnimUV0;
    //   float3 globalAnimUV1;
    //   float4 globalScalars;
    //   float4 globalScalars2;
    //
    //
    // Registers:
    //
    //   Name             Reg   Size
    //   ---------------- ----- ----
    //   gWorld           c0       4
    //   gWorldView       c4       4
    //   gViewInverse     c12      4
    //   globalScalars    c39      1
    //   globalScalars2   c40      1
    //   gDayNightEffects c45      1
    //   globalAnimUV0    c208     1
    //   globalAnimUV1    c209     1
    //
    
        vs_3_0
        def c8, 9.99999975e-006, 512, 1, 0
        dcl_position v0
        dcl_color v1
        dcl_texcoord v2
        dcl_normal v3
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2
        dcl_texcoord3 o3.xyz
        dcl_color o4
        mul r0.xyz, c1, v3.y
        mad r0.xyz, v3.x, c0, r0
        mad r0.xyz, v3.z, c2, r0
        add r0.xyz, r0, c8.x
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul o2.xyz, r0, r0.w
        mul r0.xyz, c1, v0.y
        mad r0.xyz, v0.x, c0, r0
        mad r0.xyz, v0.z, c2, r0
        add r0.xyz, r0, c3
        add r0.xyz, -r0, c15
        mov o3.xyz, -r0
        mul r0.xyz, c5, v0.y
        mad r0.xyz, v0.x, c4, r0
        mad r0.xyz, v0.z, c6, r0
        add r0.xyz, r0, c7
        add r0.w, r0.z, c8.y
        dp3 r0.w, r0.xyww, r0.xyww
        rsq r0.w, r0.w
        add r0.z, r0.z, c8.y
        mad r0.z, r0.z, -r0.w, c8.z
        rcp r0.w, r0.w
        mul r0.z, r0.z, r0.w
        rcp r0.z, r0.z
        mul o0.xy, r0, r0.z
        add r0.x, r0.w, c8.z
        mov o2.w, r0.w
        rcp r0.x, r0.x
        add o0.z, -r0.x, c8.z
        mad r0.xyz, v2.xyxw, c8.zzww, c8.wwzw
        dp3 o1.x, c208, r0
        dp3 o1.y, c209, r0
        mul r0.xy, c45, v1
        add r0.x, r0.y, r0.x
        mov r0.z, c8.z
        mad r0.x, r0.x, c39.z, -r0.z
        mad o4.xy, c40.z, r0.x, r0.z
        mov o0.w, c8.z
        mov o4.zw, v1
    
    // approximately 40 instruction slots used
};

VertexShader VS_TransformInst
<
    string Fade_Thickness   = "parameter register(210)";
    string gDayNightEffects = "parameter register(45)";
    string gViewInverse     = "parameter register(12)";
    string gWorld           = "parameter register(0)";
    string gWorldViewProj   = "parameter register(8)";
    string globalAnimUV0    = "parameter register(208)";
    string globalAnimUV1    = "parameter register(209)";
    string globalScalars    = "parameter register(39)";
    string globalScalars2   = "parameter register(40)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float Fade_Thickness;
    //   float4 gDayNightEffects;
    //   row_major float4x4 gViewInverse;
    //   row_major float4x4 gWorld;
    //   row_major float4x4 gWorldViewProj;
    //   float3 globalAnimUV0;
    //   float3 globalAnimUV1;
    //   float4 globalScalars;
    //   float4 globalScalars2;
    //
    //
    // Registers:
    //
    //   Name             Reg   Size
    //   ---------------- ----- ----
    //   gWorld           c0       4
    //   gWorldViewProj   c8       4
    //   gViewInverse     c12      4
    //   globalScalars    c39      1
    //   globalScalars2   c40      1
    //   gDayNightEffects c45      1
    //   globalAnimUV0    c208     1
    //   globalAnimUV1    c209     1
    //   Fade_Thickness   c210     1
    //
    
        vs_3_0
        def c4, 9.99999975e-006, 1, 0, -0.00200000009
        def c5, 320, 0, 0, 0
        dcl_position v0
        dcl_texcoord v1
        dcl_normal v2
        dcl_texcoord1 v3
        dcl_texcoord2 v4
        dcl_texcoord3 v5
        dcl_texcoord4 v6
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_texcoord1 o2
        dcl_color o3
        dcl_texcoord6 o4
        dcl_texcoord8 o5
        dcl_texcoord7 o6
        mul r0.xyz, c1, v2.y
        mad r0.xyz, v2.x, c0, r0
        mad r0.xyz, v2.z, c2, r0
        add r0.xyz, r0, c4.x
        dp3 r0.w, r0, r0
        rsq r0.w, r0.w
        mul o2.xyz, r0, r0.w
        mad r0.xyz, v1.xyxw, c4.yyzw, c4.zzyw
        dp3 o1.x, c208, r0
        dp3 o1.y, c209, r0
        mov r0.xyz, c12
        mul r0.xyz, r0, c210.x
        dp3 r1.x, r0, c0
        dp3 r1.y, r0, c1
        dp3 r1.z, r0, c2
        mov r0.xyz, v0
        mul r2.xyz, r0.y, v4
        mad r0.xyw, r0.x, v3.xyzz, r2.xyzz
        mad r0.xyz, r0.z, v5, r0.xyww
        add r0.xyz, r0, v6
        add r1.xyz, r1, r0
        mul r1.yw, r1.y, c9.xxzw
        mad r1.xy, r1.x, c8.xwzw, r1.ywzw
        mad r1.xy, r1.z, c10.xwzw, r1
        add r1.xy, r1, c11.xwzw
        rcp r0.w, r1.y
        mul r2, r0.y, c9
        mad r2, r0.x, c8, r2
        mad r2, r0.z, c10, r2
        add r2, r2, c11
        rcp r1.y, r2.w
        mul r1.y, r2.x, r1.y
        mad r0.w, r1.x, r0.w, -r1.y
        mul_sat o6.z, r0.w, c5.x
        mul r0.w, c45.y, v4.w
        mad r0.w, v3.w, c45.x, r0.w
        mov r1.y, c4.y
        mad r0.w, r0.w, c39.z, -r1.y
        mad o3.xy, c40.z, r0.w, r1.y
        mul r1.xyz, r0.y, c1
        mad r1.xyz, r0.x, c0, r1
        mad r1.xyz, r0.z, c2, r1
        add r0.xyz, r0, v2
        add r1.xyz, r1, c3
        add r3.xyz, r1, -c15
        mov o4.xyz, r1
        dp3 r0.w, r3, r3
        rsq r0.w, r0.w
        rcp r0.w, r0.w
        mul r1.xy, r0.y, c9
        mad r0.xy, r0.x, c8, r1
        mad r0.xy, r0.z, c10, r0
        add r0.xy, r0, c11
        add r0.xy, r2, -r0
        mul r0.xy, r0, c4.w
        mad r0.xy, r0, r0.w, r2
        mov r0.zw, r2
        mov o6.xyw, r2
        mov o0, r0
        mov o5, r0
        mov o2.w, r0.w
        mov o3.z, v5.w
        mov o3.w, v6.w
        mov o4.w, c4.y
    
    // approximately 64 instruction slots used
};

VertexShader VS_TransformSkinInst
<
    string gWorldViewProj = "parameter register(8)";
    string globalAnimUV0  = "parameter register(208)";
    string globalAnimUV1  = "parameter register(209)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   row_major float4x4 gWorldViewProj;
    //   float3 globalAnimUV0;
    //   float3 globalAnimUV1;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   gWorldViewProj c8       4
    //   globalAnimUV0  c208     1
    //   globalAnimUV1  c209     1
    //
    
        vs_3_0
        def c0, 1, 0, 0, 0
        dcl_position v0
        dcl_texcoord v1
        dcl_texcoord1 v3
        dcl_texcoord2 v4
        dcl_texcoord3 v5
        dcl_texcoord4 v6
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_color o2
        mov r0.xyz, v0
        mul r1.xyz, r0.y, v4
        mad r0.yw, r0.x, v3.xxzy, r1.xxzy
        mad r0.x, r0.x, v3.z, r1.z
        mad r0.x, r0.z, v5.z, r0.x
        add r0.x, r0.x, v6.z
        mad r0.yz, r0.z, v5.xxyw, r0.xyww
        add r0.yz, r0, v6.xxyw
        mul r1, r0.z, c9
        mad r1, r0.y, c8, r1
        mad r0, r0.x, c10, r1
        add o0, r0, c11
        mad r0.xyz, v1.xyxw, c0.xxyw, c0.yyxw
        dp3 o1.x, c208, r0
        dp3 o1.y, c209, r0
        mov o2.x, v3.w
        mov o2.y, v4.w
        mov o2.z, v5.w
        mov o2.w, v6.w
    
    // approximately 19 instruction slots used
};

//Pixel shaders
PixelShader PixelShader0 = NULL;

PixelShader PS_TexturedEight
<
    string StippleTexture       = "parameter register(10)";
    string TextureSampler       = "parameter register(0)";
    string gDepthFxParams       = "parameter register(16)";
    string gDirectionalColour   = "parameter register(18)";
    string gDirectionalLight    = "parameter register(17)";
    string gFacetCentre         = "parameter register(54)";
    string gLightAmbient0       = "parameter register(37)";
    string gLightAmbient1       = "parameter register(38)";
    string gLightColB           = "parameter register(31)";
    string gLightColG           = "parameter register(30)";
    string gLightColR           = "parameter register(29)";
    string gLightConeOffset     = "parameter register(27)";
    string gLightConeOffset2    = "parameter register(71)";
    string gLightConeScale      = "parameter register(26)";
    string gLightConeScale2     = "parameter register(70)";
    string gLightDir2X          = "parameter register(67)";
    string gLightDir2Y          = "parameter register(68)";
    string gLightDir2Z          = "parameter register(69)";
    string gLightDirX           = "parameter register(22)";
    string gLightDirY           = "parameter register(23)";
    string gLightDirZ           = "parameter register(24)";
    string gLightFallOff        = "parameter register(25)";
    string gLightPointColB      = "parameter register(65)";
    string gLightPointColG      = "parameter register(64)";
    string gLightPointColR      = "parameter register(35)";
    string gLightPointFallOff   = "parameter register(36)";
    string gLightPointPosX      = "parameter register(32)";
    string gLightPointPosY      = "parameter register(33)";
    string gLightPointPosZ      = "parameter register(34)";
    string gLightPosX           = "parameter register(19)";
    string gLightPosY           = "parameter register(20)";
    string gLightPosZ           = "parameter register(21)";
    string gShadowMatrix        = "parameter register(60)";
    string gShadowParam0123     = "parameter register(57)";
    string gShadowParam14151617 = "parameter register(56)";
    string gShadowParam18192021 = "parameter register(53)";
    string gShadowParam4567     = "parameter register(58)";
    string gShadowParam891113   = "parameter register(59)";
    string gShadowZSamplerDir   = "parameter register(15)";
    string gViewInverse         = "parameter register(12)";
    string globalFogColor       = "parameter register(42)";
    string globalFogColorN      = "parameter register(43)";
    string globalFogParams      = "parameter register(41)";
    string globalScalars        = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 gDepthFxParams;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float4 gFacetCentre;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   float4 gLightColB;
    //   float4 gLightColG;
    //   float4 gLightColR;
    //   float4 gLightConeOffset;
    //   float4 gLightConeOffset2;
    //   float4 gLightConeScale;
    //   float4 gLightConeScale2;
    //   float4 gLightDir2X;
    //   float4 gLightDir2Y;
    //   float4 gLightDir2Z;
    //   float4 gLightDirX;
    //   float4 gLightDirY;
    //   float4 gLightDirZ;
    //   float4 gLightFallOff;
    //   float4 gLightPointColB;
    //   float4 gLightPointColG;
    //   float4 gLightPointColR;
    //   float4 gLightPointFallOff;
    //   float4 gLightPointPosX;
    //   float4 gLightPointPosY;
    //   float4 gLightPointPosZ;
    //   float4 gLightPosX;
    //   float4 gLightPosY;
    //   float4 gLightPosZ;
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam18192021;
    //   float4 gShadowParam4567;
    //   float4 gShadowParam891113;
    //   sampler2D gShadowZSamplerDir;
    //   row_major float4x4 gViewInverse;
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name                 Reg   Size
    //   -------------------- ----- ----
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
    //   gLightPointPosX      c32      1
    //   gLightPointPosY      c33      1
    //   gLightPointPosZ      c34      1
    //   gLightPointColR      c35      1
    //   gLightPointFallOff   c36      1
    //   gLightAmbient0       c37      1
    //   gLightAmbient1       c38      1
    //   globalScalars        c39      1
    //   globalFogParams      c41      1
    //   globalFogColor       c42      1
    //   globalFogColorN      c43      1
    //   gShadowParam18192021 c53      1
    //   gFacetCentre         c54      1
    //   gShadowParam14151617 c56      1
    //   gShadowParam0123     c57      1
    //   gShadowParam4567     c58      1
    //   gShadowParam891113   c59      1
    //   gShadowMatrix        c60      4
    //   gLightPointColG      c64      1
    //   gLightPointColB      c65      1
    //   gLightDir2X          c67      1
    //   gLightDir2Y          c68      1
    //   gLightDir2Z          c69      1
    //   gLightConeScale2     c70      1
    //   gLightConeOffset2    c71      1
    //   TextureSampler       s0       1
    //   StippleTexture       s10      1
    //   gShadowZSamplerDir   s15      1
    //
    
        ps_3_0
        def c0, -0.5, 0.5, 1.33333337, 1.5
        def c1, 0.0833333358, -0.100000001, 1.11111116, 1.00000001e-007
        def c2, 0, -1, -0, 9.99999975e-006
        def c3, 640, 576, 0.349999994, 1
        def c4, 3.99600005, 4, 0.125, 0.25
        def c5, 0.212500006, 0.715399981, 0.0720999986, 0
        def c6, 1, -1, 0, -0
        def c7, -0.321940005, -0.932614982, -0.791558981, -0.597710013
        def c8, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
        def c9, 0.519456029, 0.767022014, 0.185461, -0.893123984
        def c10, 0.962339997, -0.194983006, 0.473434001, -0.480026007
        def c11, -0.69591397, 0.457136989, -0.203345001, 0.620715976
        def c12, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
        dcl_texcoord v0.xy
        dcl_texcoord1 v1
        dcl_color v2.x
        dcl_texcoord6 v3.xyz
        dcl_texcoord8 v4.xyw
        dcl_texcoord7 v5
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        dcl_2d s15
        mov_sat r0.x, c39.x
        mul r0.x, r0.x, c4.x
        frc r0.y, r0.x
        mul r0.z, r0.y, c4.y
        frc r0.w, r0.z
        add r1.xy, r0.zxzw, -r0.wyzw
        mul r0.xy, c4.z, vPos
        frc r0.xy, r0_abs
        cmp r0.xy, vPos, r0, -r0
        mul r0.xy, r0, c4.w
        mad r0.xy, r1, c4.w, r0
        mov r0.zw, c2.x
        texldl r0, r0, s10
        cmp r0, -r0.y, c2.y, c2.z
        texkill r0
        texld r0, v0, s0
        add r1.xyz, c2.w, v1
        nrm r2.xyz, r1
        mad_sat r0.w, r2.z, c0.x, c0.y
        mov r1.xyz, c38
        mad r1.xyz, r1, r0.w, c37
        mul r3.xyz, c18.w, c18
        dp3 r0.w, r2, -c17
        add r0.w, r0.w, -c4.w
        mul_sat r0.w, r0.w, c0.z
        mul r4.xyz, c61.xyww, v3.y
        mad r4.xyz, v3.x, c60.xyww, r4
        mad r4.xyz, v3.z, c62.xyww, r4
        add r4.xyz, r4, c63.xyww
        dp3 r1.w, c14, v3
        add r5.xyz, -r1.w, -c54
        cmp r5.yzw, r5.xxyz, -c2.y, -c2.z
        mov r5.x, -c2.y
        dp4 r6.x, r5, c57
        dp4 r6.y, r5, c58
        dp4 r7.x, r5, c59
        dp4 r7.y, r5, c56
        mad r4.xy, r4, r6, r7
        add r5.xyz, c15, -v3
        dp3 r1.w, r5, r5
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        rcp r2.w, c53.w
        mul r2.w, r1.w, r2.w
        mul r2.w, r2.w, r2.w
        mul r2.w, r2.w, c0.w
        mov r5.y, c53.y
        mad r5.xz, r5.y, c12.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r3.w, r4.z, -r6.x
        cmp r3.w, r3.w, -c2.y, -c2.z
        mad r5.xz, r5.y, c12.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c11.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c11.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c10.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c10.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c9.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c9.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c8.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c8.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c7.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r4.xy, r5.y, c7.zwzw, r4
        texld r5, r4, s15
        add r4.x, r4.z, -r5.x
        cmp r4.x, r4.x, -c2.y, -c2.z
        add r3.w, r3.w, r4.x
        mad r2.w, r3.w, c1.x, r2.w
        add r1.w, r1.w, -c53.w
        cmp r4.xy, r1.w, c6, c6.zwzw
        add r1.w, r2.w, r4.y
        cmp_sat r1.w, r1.w, r2.w, r4.x
        mul r3.xyz, r3, r0.w
        mul r3.xyz, r1.w, r3
        mad r1.xyz, r1, v2.x, r3
        add r3, c19, -v3.x
        add r4, c20, -v3.y
        add r5, c21, -v3.z
        mul r6, r3, r3
        mad r6, r4, r4, r6
        mad r6, r5, r5, r6
        add r7, r6, c2.w
        rsq r8.x, r7.x
        rsq r8.y, r7.y
        rsq r8.z, r7.z
        rsq r8.w, r7.w
        mov r7.y, c2.y
        mad r6, r6, -c25, -r7.y
        max r9, r6, c2.x
        mul r6, r9, r9
        mad r6, r6, r6, c1.y
        mul r9, r6, c1.z
        cmp r6, r6, r9, c2.x
        mul r9, r2.x, r3
        mad r9, r4, r2.y, r9
        mad r9, r5, r2.z, r9
        mul r6, r6, r9
        mul_sat r6, r8, r6
        mul r3, r3, -c22
        mad r3, r4, -c23, r3
        mad r3, r5, -c24, r3
        mul r3, r8, r3
        mov r4, c26
        mad_sat r3, r3, r4, c27
        mul r3, r6, r3
        dp4 r4.x, c29, r3
        dp4 r4.y, c30, r3
        dp4 r4.z, c31, r3
        add r1.xyz, r1, r4
        add r3, c32, -v3.x
        add r4, c33, -v3.y
        add r5, c34, -v3.z
        mul r6, r3, r3
        mad r6, r4, r4, r6
        mad r6, r5, r5, r6
        add r8, r6, c2.w
        rsq r9.x, r8.x
        rsq r9.y, r8.y
        rsq r9.z, r8.z
        rsq r9.w, r8.w
        mad r6, r6, -c36, -r7.y
        max r8, r6, c2.x
        mul r6, r8, r8
        mad r6, r6, r6, c1.y
        mul r8, r6, c1.z
        cmp r6, r6, r8, c2.x
        mul r8, r2.x, r3
        mad r8, r4, r2.y, r8
        mad r2, r5, r2.z, r8
        mul r2, r6, r2
        mul_sat r2, r9, r2
        mul r3, r3, -c67
        mad r3, r4, -c68, r3
        mad r3, r5, -c69, r3
        mul r3, r9, r3
        mov r4, c70
        mad_sat r3, r3, r4, c71
        mul r2, r2, r3
        dp4 r3.x, c35, r2
        dp4 r3.y, c64, r2
        dp4 r3.z, c65, r2
        add r1.xyz, r1, r3
        mul r2.xyz, r0, r1
        rcp r0.w, v5.w
        mul r3.xy, r0.w, v5
        rcp r0.w, v4.w
        mul r3.zw, r0.w, v4.xyxy
        mul r3.zw, r3, c3.xyxy
        mad r3.xy, r3, c3, -r3.zwzw
        dp2add r0.w, r3, r3, c2.x
        rsq r0.w, r0.w
        rcp r0.w, r0.w
        mad r0.w, r0.w, -c3.z, c3.w
        mul r1.w, r0.w, v5.z
        mul r1.w, r1.w, c39.x
        cmp oC0.w, r0.w, r1.w, c2.x
        add r0.w, c16.w, -v1.w
        add r1.w, -c16.z, c16.w
        rcp r1.w, r1.w
        mul_sat r0.w, r0.w, r1.w
        add r0.w, -r0.w, -c2.y
        add r3.xy, r7.y, c16
        mul r1.w, r0.w, r3.y
        mad r0.w, r0.w, r3.x, -c2.y
        dp3 r2.x, r2, c5
        mad r0.xyz, r0, r1, -r2.x
        mad r0.xyz, r0.w, r0, r2.x
        add r0.w, r2.x, c1.w
        pow r2.x, r0_abs.w, r1.w
        mul r1.xyz, r0, r2.x
        rcp r0.w, c41.x
        mul_sat r0.w, r0.w, v1.w
        add r1.w, -c41.x, v1.w
        add r2.y, -c41.x, c41.y
        rcp r2.y, r2.y
        mul_sat r1.w, r1.w, r2.y
        lrp r2.y, c41.w, r0.w, r1.w
        add r0.w, r2.y, c41.z
        mov r3.xyz, c43
        add r2.yzw, -r3.xxyz, c42.xxyz
        mad r2.yzw, r1.w, r2, c43.xxyz
        mad r0.xyz, r0, -r2.x, r2.yzww
        mad oC0.xyz, r0.w, r0, r1
    
    // approximately 228 instruction slots used (15 texture, 213 arithmetic)
};

PixelShader PS_TexturedUnlit
<
    string StippleTexture = "parameter register(10)";
    string TextureSampler = "parameter register(0)";
    string globalScalars  = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   globalScalars  c39      1
    //   TextureSampler s0       1
    //   StippleTexture s10      1
    //
    
        ps_3_0
        def c0, 3.99600005, 4, 0.125, 0.25
        def c1, 0, -1, -0, 0
        dcl_texcoord v0.xy
        dcl_color v1
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        mov_sat r0.x, c39.x
        mul r0.x, r0.x, c0.x
        frc r0.y, r0.x
        mul r0.z, r0.y, c0.y
        frc r0.w, r0.z
        add r1.xy, r0.zxzw, -r0.wyzw
        mul r0.xy, c0.z, vPos
        frc r0.xy, r0_abs
        cmp r0.xy, vPos, r0, -r0
        mul r0.xy, r0, c0.w
        mad r0.xy, r1, c0.w, r0
        mov r0.zw, c1.x
        texldl r0, r0, s10
        cmp r0, -r0.y, c1.y, c1.z
        texkill r0
        texld r0, v0, s0
        mul r0, r0, v1
        mul oC0.w, r0.w, c39.x
        mov oC0.xyz, r0
    
    // approximately 20 instruction slots used (3 texture, 17 arithmetic)
};

PixelShader PS_DeferredTextured
<
    string StippleTexture = "parameter register(10)";
    string TextureSampler = "parameter register(0)";
    string globalScalars  = "parameter register(39)";
    string stencil        = "parameter register(52)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 globalScalars;
    //   float4 stencil;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   globalScalars  c39      1
    //   stencil        c52      1
    //   TextureSampler s0       1
    //   StippleTexture s10      1
    //
    
        ps_3_0
        def c0, 0, -1, -0, 9.99999975e-006
        def c1, 3.99600005, 4, 0.125, 0.25
        def c2, 0.5, 0, 1, 0.25
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl_color v2.xw
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        mov_sat r0.x, c39.x
        mul r0.x, r0.x, c1.x
        frc r0.y, r0.x
        mul r0.z, r0.y, c1.y
        frc r0.w, r0.z
        add r1.xy, r0.zxzw, -r0.wyzw
        mul r0.xy, c1.z, vPos
        frc r0.xy, r0_abs
        cmp r0.xy, vPos, r0, -r0
        mul r0.xy, r0, c1.w
        mad r0.xy, r1, c1.w, r0
        mov r0.zw, c0.x
        texldl r0, r0, s10
        cmp r0, -r0.y, c0.y, c0.z
        texkill r0
        texld r0, v0, s0
        add r1.xyz, c0.w, v1
        dp3 r1.w, r1, r1
        rsq r1.w, r1.w
        mul r0.w, r0.w, v2.w
        mad r1.xyz, r1, r1.w, -c0.y
        mul oC1.xyz, r1, c2.x
        mul r0.w, r0.w, c39.x
        mov oC0, r0
        mov oC1.w, r0.w
        mad oC2.xyz, v2.x, c2.yyzw, c2.ywyw
        mov oC2.w, r0.w
        mov r0.yz, c0
        mul oC3, -r0.yzzz, c52.x
    
    // approximately 30 instruction slots used (3 texture, 27 arithmetic)
};

PixelShader PS_DeferredTexturedAlphaClip
<
    string StippleTexture = "parameter register(10)";
    string TextureSampler = "parameter register(0)";
    string globalScalars  = "parameter register(39)";
    string stencil        = "parameter register(52)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 globalScalars;
    //   float4 stencil;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   globalScalars  c39      1
    //   stencil        c52      1
    //   TextureSampler s0       1
    //   StippleTexture s10      1
    //
    
        ps_3_0
        def c0, 0, -1, -0, 9.99999975e-006
        def c1, 3.99600005, 4, 0.125, 0.25
        def c2, 0.5, 0, 1, 0.25
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl_color v2.xw
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        mov_sat r0.x, c39.x
        mul r0.x, r0.x, c1.x
        frc r0.y, r0.x
        mul r0.z, r0.y, c1.y
        frc r0.w, r0.z
        add r1.xy, r0.zxzw, -r0.wyzw
        mul r0.xy, c1.z, vPos
        frc r0.xy, r0_abs
        cmp r0.xy, vPos, r0, -r0
        mul r0.xy, r0, c1.w
        mad r0.xy, r1, c1.w, r0
        mov r0.zw, c0.x
        texldl r0, r0, s10
        cmp r0, -r0.y, c0.y, c0.z
        texkill r0
        texld r0, v0, s0
        add r1.xyz, c0.w, v1
        dp3 r1.w, r1, r1
        rsq r1.w, r1.w
        mul r0.w, r0.w, v2.w
        mad r1.xyz, r1, r1.w, -c0.y
        mul oC1.xyz, r1, c2.x
        mul r0.w, r0.w, c39.x
        mov oC0, r0
        mov oC1.w, r0.w
        mad oC2.xyz, v2.x, c2.yyzw, c2.ywyw
        mov oC2.w, r0.w
        mov r0.yz, c0
        mul oC3, -r0.yzzz, c52.x
    
    // approximately 30 instruction slots used (3 texture, 27 arithmetic)
};

PixelShader PS_ShadowDepth
<
    string StippleTexture = "parameter register(10)";
    string TextureSampler = "parameter register(0)";
    string globalScalars  = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   globalScalars  c39      1
    //   TextureSampler s0       1
    //   StippleTexture s10      1
    //
    
        ps_3_0
        def c0, 3.99600005, 4, 0.125, 0.25
        def c1, 0, -1, -0, 0
        dcl_texcoord v0.xyz
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        texld r0, v0.yzzw, s0
        mul r0.x, r0.w, c39.x
        mov_sat r0.y, r0.x
        mul r0.y, r0.y, c0.x
        frc r0.z, r0.y
        mul r0.w, r0.z, c0.y
        frc r1.x, r0.w
        add r1.x, r0.w, -r1.x
        add r1.y, r0.y, -r0.z
        mul r0.yz, c0.z, vPos.xxyw
        frc r0.yz, r0_abs
        cmp r0.yz, vPos.xxyw, r0, -r0
        mul r0.yz, r0, c0.w
        mad r1.xy, r1, c0.w, r0.yzzw
        mov r1.zw, c1.x
        texldl r1, r1, s10
        cmp r1, -r1.y, c1.y, c1.z
        texkill r1
        mov oC0.xyz, v0.x
        mov oC0.w, r0.x
    
    // approximately 21 instruction slots used (3 texture, 18 arithmetic)
};

PixelShader PS_ShadowDepthMasked
<
    string StippleTexture = "parameter register(10)";
    string TextureSampler = "parameter register(0)";
    string globalScalars  = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   globalScalars  c39      1
    //   TextureSampler s0       1
    //   StippleTexture s10      1
    //
    
        ps_3_0
        def c0, 3.99600005, 4, 0.125, 0.25
        def c1, 0, -1, -0, 0
        dcl_texcoord v0.xyz
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        texld r0, v0.yzzw, s0
        mul r0.x, r0.w, c39.x
        mov_sat r0.y, r0.x
        mul r0.y, r0.y, c0.x
        frc r0.z, r0.y
        mul r0.w, r0.z, c0.y
        frc r1.x, r0.w
        add r1.x, r0.w, -r1.x
        add r1.y, r0.y, -r0.z
        mul r0.yz, c0.z, vPos.xxyw
        frc r0.yz, r0_abs
        cmp r0.yz, vPos.xxyw, r0, -r0
        mul r0.yz, r0, c0.w
        mad r1.xy, r1, c0.w, r0.yzzw
        mov r1.zw, c1.x
        texldl r1, r1, s10
        cmp r1, -r1.y, c1.y, c1.z
        texkill r1
        mov oC0.xyz, v0.x
        mov oC0.w, r0.x
    
    // approximately 21 instruction slots used (3 texture, 18 arithmetic)
};

PixelShader PS_TexturedBasicParaboloid
<
    string StippleTexture     = "parameter register(10)";
    string TextureSampler     = "parameter register(0)";
    string gDirectionalColour = "parameter register(18)";
    string gDirectionalLight  = "parameter register(17)";
    string gLightAmbient0     = "parameter register(37)";
    string gLightAmbient1     = "parameter register(38)";
    string globalFogColor     = "parameter register(42)";
    string globalFogParams    = "parameter register(41)";
    string globalScalars      = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   float4 globalFogColor;
    //   float4 globalFogParams;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name               Reg   Size
    //   ------------------ ----- ----
    //   gDirectionalLight  c17      1
    //   gDirectionalColour c18      1
    //   gLightAmbient0     c37      1
    //   gLightAmbient1     c38      1
    //   globalScalars      c39      1
    //   globalFogParams    c41      1
    //   globalFogColor     c42      1
    //   TextureSampler     s0       1
    //   StippleTexture     s10      1
    //
    
        ps_3_0
        def c0, -512, 3.99600005, 4, 0.125
        def c1, 9.99999975e-006, -0.5, 0.5, 1.33333337
        def c2, 64, 0, 0, 0
        def c3, 0.25, 0, -1, -0
        dcl_texcoord v0.xy
        dcl_texcoord1 v1
        dcl_texcoord3 v2.z
        dcl_color v3.xw
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        add r0, c0.x, v2.z
        texkill r0
        mov_sat r0.x, c39.x
        mul r0.x, r0.x, c0.y
        frc r0.y, r0.x
        mul r0.z, r0.y, c0.z
        frc r0.w, r0.z
        add r1.xy, r0.zxzw, -r0.wyzw
        mul r0.xy, c0.w, vPos
        frc r0.xy, r0_abs
        cmp r0.xy, vPos, r0, -r0
        mul r0.xy, r0, c3.x
        mad r0.xy, r1, c3.x, r0
        mov r0.zw, c3.y
        texldl r0, r0, s10
        cmp r0, -r0.y, c3.z, c3.w
        texkill r0
        texld r0, v0, s0
        add r1.xyz, c1.x, v1
        nrm r2.xyz, r1
        mul r0.w, r0.w, v3.w
        mad_sat r1.x, r2.z, c1.y, c1.z
        mov r3.xyz, c38
        mad r1.xyz, r3, r1.x, c37
        mul r3.xyz, c18.w, c18
        dp3 r1.w, r2, -c17
        add r1.w, r1.w, -c3.x
        mul_sat r1.w, r1.w, c1.w
        mul r2.xyz, r3, r1.w
        mad r1.xyz, r1, v3.x, r2
        mov r1.w, -c3.z
        mul r2, r0, r1
        mul r0.w, r2.w, c39.x
        add r1.w, -c41.x, v1.w
        add r2.w, -c41.x, c41.y
        rcp r2.w, r2.w
        mul_sat r1.w, r1.w, r2.w
        mad r0.xyz, r0, -r1, c42
        mad r0.xyz, r1.w, r0, r2
        add r1.x, c2.x, -v1.w
        mul_sat r1.x, r1.x, c3.x
        mul oC0.w, r0.w, r1.x
        mov oC0.xyz, r0
    
    // approximately 46 instruction slots used (3 texture, 43 arithmetic)
};

PixelShader PS_TexturedBasic
<
    string StippleTexture     = "parameter register(10)";
    string TextureSampler     = "parameter register(0)";
    string gDirectionalColour = "parameter register(18)";
    string gDirectionalLight  = "parameter register(17)";
    string gLightAmbient0     = "parameter register(37)";
    string gLightAmbient1     = "parameter register(38)";
    string globalFogColor     = "parameter register(42)";
    string globalFogParams    = "parameter register(41)";
    string globalScalars      = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   float4 globalFogColor;
    //   float4 globalFogParams;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name               Reg   Size
    //   ------------------ ----- ----
    //   gDirectionalLight  c17      1
    //   gDirectionalColour c18      1
    //   gLightAmbient0     c37      1
    //   gLightAmbient1     c38      1
    //   globalScalars      c39      1
    //   globalFogParams    c41      1
    //   globalFogColor     c42      1
    //   TextureSampler     s0       1
    //   StippleTexture     s10      1
    //
    
        ps_3_0
        def c0, 0, -1, -0, 9.99999975e-006
        def c1, -0.5, 0.5, 1.33333337, 0
        def c2, 3.99600005, 4, 0.125, 0.25
        dcl_texcoord v0.xy
        dcl_texcoord1 v1
        dcl_color v2.xw
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        mov_sat r0.x, c39.x
        mul r0.x, r0.x, c2.x
        frc r0.y, r0.x
        mul r0.z, r0.y, c2.y
        frc r0.w, r0.z
        add r1.xy, r0.zxzw, -r0.wyzw
        mul r0.xy, c2.z, vPos
        frc r0.xy, r0_abs
        cmp r0.xy, vPos, r0, -r0
        mul r0.xy, r0, c2.w
        mad r0.xy, r1, c2.w, r0
        mov r0.zw, c0.x
        texldl r0, r0, s10
        cmp r0, -r0.y, c0.y, c0.z
        texkill r0
        texld r0, v0, s0
        add r1.xyz, c0.w, v1
        nrm r2.xyz, r1
        mul r0.w, r0.w, v2.w
        mad_sat r1.x, r2.z, c1.x, c1.y
        mov r3.xyz, c38
        mad r1.xyz, r3, r1.x, c37
        mul r3.xyz, c18.w, c18
        dp3 r1.w, r2, -c17
        add r1.w, r1.w, -c2.w
        mul_sat r1.w, r1.w, c1.z
        mul r2.xyz, r3, r1.w
        mad r1.xyz, r1, v2.x, r2
        mov r1.w, -c0.y
        mul r2, r0, r1
        mul oC0.w, r2.w, c39.x
        add r0.w, -c41.x, v1.w
        add r1.w, -c41.x, c41.y
        rcp r1.w, r1.w
        mul_sat r0.w, r0.w, r1.w
        mad r0.xyz, r0, -r1, c42
        mad oC0.xyz, r0.w, r0, r2
    
    // approximately 40 instruction slots used (3 texture, 37 arithmetic)
};

PixelShader PS_DeferredImposter
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

PixelShader PS_TexturedZero
<
    string StippleTexture       = "parameter register(10)";
    string TextureSampler       = "parameter register(0)";
    string gDepthFxParams       = "parameter register(16)";
    string gDirectionalColour   = "parameter register(18)";
    string gDirectionalLight    = "parameter register(17)";
    string gFacetCentre         = "parameter register(54)";
    string gLightAmbient0       = "parameter register(37)";
    string gLightAmbient1       = "parameter register(38)";
    string gShadowMatrix        = "parameter register(60)";
    string gShadowParam0123     = "parameter register(57)";
    string gShadowParam14151617 = "parameter register(56)";
    string gShadowParam18192021 = "parameter register(53)";
    string gShadowParam4567     = "parameter register(58)";
    string gShadowParam891113   = "parameter register(59)";
    string gShadowZSamplerDir   = "parameter register(15)";
    string gViewInverse         = "parameter register(12)";
    string globalFogColor       = "parameter register(42)";
    string globalFogColorN      = "parameter register(43)";
    string globalFogParams      = "parameter register(41)";
    string globalScalars        = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 gDepthFxParams;
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
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name                 Reg   Size
    //   -------------------- ----- ----
    //   gViewInverse         c12      4
    //   gDepthFxParams       c16      1
    //   gDirectionalLight    c17      1
    //   gDirectionalColour   c18      1
    //   gLightAmbient0       c37      1
    //   gLightAmbient1       c38      1
    //   globalScalars        c39      1
    //   globalFogParams      c41      1
    //   globalFogColor       c42      1
    //   globalFogColorN      c43      1
    //   gShadowParam18192021 c53      1
    //   gFacetCentre         c54      1
    //   gShadowParam14151617 c56      1
    //   gShadowParam0123     c57      1
    //   gShadowParam4567     c58      1
    //   gShadowParam891113   c59      1
    //   gShadowMatrix        c60      4
    //   TextureSampler       s0       1
    //   StippleTexture       s10      1
    //   gShadowZSamplerDir   s15      1
    //
    
        ps_3_0
        def c0, 0, -1, -0, 9.99999975e-006
        def c1, -0.5, 0.5, 1.33333337, 1.5
        def c2, 0.0833333358, 640, 576, 1.00000001e-007
        def c3, 0.349999994, 1, 0, 0
        def c4, 3.99600005, 4, 0.125, 0.25
        def c5, 0.212500006, 0.715399981, 0.0720999986, 0
        def c6, 1, -1, 0, -0
        def c7, -0.321940005, -0.932614982, -0.791558981, -0.597710013
        def c8, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
        def c9, 0.519456029, 0.767022014, 0.185461, -0.893123984
        def c10, 0.962339997, -0.194983006, 0.473434001, -0.480026007
        def c11, -0.69591397, 0.457136989, -0.203345001, 0.620715976
        def c12, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
        dcl_texcoord v0.xy
        dcl_texcoord1 v1
        dcl_color v2.x
        dcl_texcoord6 v3.xyz
        dcl_texcoord8 v4.xyw
        dcl_texcoord7 v5
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        dcl_2d s15
        mov_sat r0.x, c39.x
        mul r0.x, r0.x, c4.x
        frc r0.y, r0.x
        mul r0.z, r0.y, c4.y
        frc r0.w, r0.z
        add r1.xy, r0.zxzw, -r0.wyzw
        mul r0.xy, c4.z, vPos
        frc r0.xy, r0_abs
        cmp r0.xy, vPos, r0, -r0
        mul r0.xy, r0, c4.w
        mad r0.xy, r1, c4.w, r0
        mov r0.zw, c0.x
        texldl r0, r0, s10
        cmp r0, -r0.y, c0.y, c0.z
        texkill r0
        texld r0, v0, s0
        add r1.xyz, c0.w, v1
        nrm r2.xyz, r1
        mad_sat r0.w, r2.z, c1.x, c1.y
        mov r1.xyz, c38
        mad r1.xyz, r1, r0.w, c37
        mul r3.xyz, c18.w, c18
        dp3 r0.w, r2, -c17
        add r0.w, r0.w, -c4.w
        mul_sat r0.w, r0.w, c1.z
        mul r2.xyz, c61.xyww, v3.y
        mad r2.xyz, v3.x, c60.xyww, r2
        mad r2.xyz, v3.z, c62.xyww, r2
        add r2.xyz, r2, c63.xyww
        dp3 r1.w, c14, v3
        add r4.xyz, -r1.w, -c54
        cmp r4.yzw, r4.xxyz, -c0.y, -c0.z
        mov r4.x, -c0.y
        dp4 r5.x, r4, c57
        dp4 r5.y, r4, c58
        dp4 r6.x, r4, c59
        dp4 r6.y, r4, c56
        mad r2.xy, r2, r5, r6
        add r4.xyz, c15, -v3
        dp3 r1.w, r4, r4
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        rcp r2.w, c53.w
        mul r2.w, r1.w, r2.w
        mul r2.w, r2.w, r2.w
        mul r2.w, r2.w, c1.w
        mov r4.y, c53.y
        mad r4.xz, r4.y, c12.xyyw, r2.xyyw
        texld r5, r4.xzzw, s15
        add r3.w, r2.z, -r5.x
        cmp r3.w, r3.w, -c0.y, -c0.z
        mad r4.xz, r4.y, c12.zyww, r2.xyyw
        texld r5, r4.xzzw, s15
        add r4.x, r2.z, -r5.x
        cmp r4.x, r4.x, -c0.y, -c0.z
        add r3.w, r3.w, r4.x
        mad r4.xz, r4.y, c11.xyyw, r2.xyyw
        texld r5, r4.xzzw, s15
        add r4.x, r2.z, -r5.x
        cmp r4.x, r4.x, -c0.y, -c0.z
        add r3.w, r3.w, r4.x
        mad r4.xz, r4.y, c11.zyww, r2.xyyw
        texld r5, r4.xzzw, s15
        add r4.x, r2.z, -r5.x
        cmp r4.x, r4.x, -c0.y, -c0.z
        add r3.w, r3.w, r4.x
        mad r4.xz, r4.y, c10.xyyw, r2.xyyw
        texld r5, r4.xzzw, s15
        add r4.x, r2.z, -r5.x
        cmp r4.x, r4.x, -c0.y, -c0.z
        add r3.w, r3.w, r4.x
        mad r4.xz, r4.y, c10.zyww, r2.xyyw
        texld r5, r4.xzzw, s15
        add r4.x, r2.z, -r5.x
        cmp r4.x, r4.x, -c0.y, -c0.z
        add r3.w, r3.w, r4.x
        mad r4.xz, r4.y, c9.xyyw, r2.xyyw
        texld r5, r4.xzzw, s15
        add r4.x, r2.z, -r5.x
        cmp r4.x, r4.x, -c0.y, -c0.z
        add r3.w, r3.w, r4.x
        mad r4.xz, r4.y, c9.zyww, r2.xyyw
        texld r5, r4.xzzw, s15
        add r4.x, r2.z, -r5.x
        cmp r4.x, r4.x, -c0.y, -c0.z
        add r3.w, r3.w, r4.x
        mad r4.xz, r4.y, c8.xyyw, r2.xyyw
        texld r5, r4.xzzw, s15
        add r4.x, r2.z, -r5.x
        cmp r4.x, r4.x, -c0.y, -c0.z
        add r3.w, r3.w, r4.x
        mad r4.xz, r4.y, c8.zyww, r2.xyyw
        texld r5, r4.xzzw, s15
        add r4.x, r2.z, -r5.x
        cmp r4.x, r4.x, -c0.y, -c0.z
        add r3.w, r3.w, r4.x
        mad r4.xz, r4.y, c7.xyyw, r2.xyyw
        texld r5, r4.xzzw, s15
        add r4.x, r2.z, -r5.x
        cmp r4.x, r4.x, -c0.y, -c0.z
        add r3.w, r3.w, r4.x
        mad r2.xy, r4.y, c7.zwzw, r2
        texld r4, r2, s15
        add r2.x, r2.z, -r4.x
        cmp r2.x, r2.x, -c0.y, -c0.z
        add r2.x, r3.w, r2.x
        mad r2.x, r2.x, c2.x, r2.w
        add r1.w, r1.w, -c53.w
        cmp r2.yz, r1.w, c6.xxyw, c6.xzww
        add r1.w, r2.x, r2.z
        cmp_sat r1.w, r1.w, r2.x, r2.y
        mul r2.xyz, r3, r0.w
        mul r2.xyz, r1.w, r2
        mad r1.xyz, r1, v2.x, r2
        mul r2.xyz, r0, r1
        rcp r0.w, v5.w
        mul r3.xy, r0.w, v5
        rcp r0.w, v4.w
        mul r3.zw, r0.w, v4.xyxy
        mul r3.zw, r3, c2.xyyz
        mad r3.xy, r3, c2.yzzw, -r3.zwzw
        dp2add r0.w, r3, r3, c0.x
        rsq r0.w, r0.w
        rcp r0.w, r0.w
        mad r0.w, r0.w, -c3.x, c3.y
        mul r1.w, r0.w, v5.z
        mul r1.w, r1.w, c39.x
        cmp oC0.w, r0.w, r1.w, c0.x
        add r0.w, c16.w, -v1.w
        add r1.w, -c16.z, c16.w
        rcp r1.w, r1.w
        mul_sat r0.w, r0.w, r1.w
        add r0.w, -r0.w, -c0.y
        mov r3.y, c0.y
        add r3.xy, r3.y, c16
        mul r1.w, r0.w, r3.y
        mad r0.w, r0.w, r3.x, -c0.y
        dp3 r2.x, r2, c5
        mad r0.xyz, r0, r1, -r2.x
        mad r0.xyz, r0.w, r0, r2.x
        add r0.w, r2.x, c2.w
        pow r2.x, r0_abs.w, r1.w
        mul r1.xyz, r0, r2.x
        rcp r0.w, c41.x
        mul_sat r0.w, r0.w, v1.w
        add r1.w, -c41.x, v1.w
        add r2.y, -c41.x, c41.y
        rcp r2.y, r2.y
        mul_sat r1.w, r1.w, r2.y
        lrp r2.y, c41.w, r0.w, r1.w
        add r0.w, r2.y, c41.z
        mov r3.xyz, c43
        add r2.yzw, -r3.xxyz, c42.xxyz
        mad r2.yzw, r1.w, r2, c43.xxyz
        mad r0.xyz, r0, -r2.x, r2.yzww
        mad oC0.xyz, r0.w, r0, r1
    
    // approximately 162 instruction slots used (15 texture, 147 arithmetic)
};

PixelShader PS_TexturedFour
<
    string StippleTexture       = "parameter register(10)";
    string TextureSampler       = "parameter register(0)";
    string gDepthFxParams       = "parameter register(16)";
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
    string gShadowMatrix        = "parameter register(60)";
    string gShadowParam0123     = "parameter register(57)";
    string gShadowParam14151617 = "parameter register(56)";
    string gShadowParam18192021 = "parameter register(53)";
    string gShadowParam4567     = "parameter register(58)";
    string gShadowParam891113   = "parameter register(59)";
    string gShadowZSamplerDir   = "parameter register(15)";
    string gViewInverse         = "parameter register(12)";
    string globalFogColor       = "parameter register(42)";
    string globalFogColorN      = "parameter register(43)";
    string globalFogParams      = "parameter register(41)";
    string globalScalars        = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 gDepthFxParams;
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
    //   row_major float4x4 gShadowMatrix;
    //   float4 gShadowParam0123;
    //   float4 gShadowParam14151617;
    //   float4 gShadowParam18192021;
    //   float4 gShadowParam4567;
    //   float4 gShadowParam891113;
    //   sampler2D gShadowZSamplerDir;
    //   row_major float4x4 gViewInverse;
    //   float4 globalFogColor;
    //   float4 globalFogColorN;
    //   float4 globalFogParams;
    //   float4 globalScalars;
    //
    //
    // Registers:
    //
    //   Name                 Reg   Size
    //   -------------------- ----- ----
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
    //   globalScalars        c39      1
    //   globalFogParams      c41      1
    //   globalFogColor       c42      1
    //   globalFogColorN      c43      1
    //   gShadowParam18192021 c53      1
    //   gFacetCentre         c54      1
    //   gShadowParam14151617 c56      1
    //   gShadowParam0123     c57      1
    //   gShadowParam4567     c58      1
    //   gShadowParam891113   c59      1
    //   gShadowMatrix        c60      4
    //   TextureSampler       s0       1
    //   StippleTexture       s10      1
    //   gShadowZSamplerDir   s15      1
    //
    
        ps_3_0
        def c0, -0.5, 0.5, 1.33333337, 1.5
        def c1, 0.0833333358, -0.100000001, 1.11111116, 1.00000001e-007
        def c2, 0, -1, -0, 9.99999975e-006
        def c3, 640, 576, 0.349999994, 1
        def c4, 3.99600005, 4, 0.125, 0.25
        def c5, 0.212500006, 0.715399981, 0.0720999986, 0
        def c6, 1, -1, 0, -0
        def c7, -0.321940005, -0.932614982, -0.791558981, -0.597710013
        def c8, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
        def c9, 0.519456029, 0.767022014, 0.185461, -0.893123984
        def c10, 0.962339997, -0.194983006, 0.473434001, -0.480026007
        def c11, -0.69591397, 0.457136989, -0.203345001, 0.620715976
        def c12, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
        dcl_texcoord v0.xy
        dcl_texcoord1 v1
        dcl_color v2.x
        dcl_texcoord6 v3.xyz
        dcl_texcoord8 v4.xyw
        dcl_texcoord7 v5
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        dcl_2d s15
        mov_sat r0.x, c39.x
        mul r0.x, r0.x, c4.x
        frc r0.y, r0.x
        mul r0.z, r0.y, c4.y
        frc r0.w, r0.z
        add r1.xy, r0.zxzw, -r0.wyzw
        mul r0.xy, c4.z, vPos
        frc r0.xy, r0_abs
        cmp r0.xy, vPos, r0, -r0
        mul r0.xy, r0, c4.w
        mad r0.xy, r1, c4.w, r0
        mov r0.zw, c2.x
        texldl r0, r0, s10
        cmp r0, -r0.y, c2.y, c2.z
        texkill r0
        texld r0, v0, s0
        add r1.xyz, c2.w, v1
        nrm r2.xyz, r1
        mad_sat r0.w, r2.z, c0.x, c0.y
        mov r1.xyz, c38
        mad r1.xyz, r1, r0.w, c37
        mul r3.xyz, c18.w, c18
        dp3 r0.w, r2, -c17
        add r0.w, r0.w, -c4.w
        mul_sat r0.w, r0.w, c0.z
        mul r4.xyz, c61.xyww, v3.y
        mad r4.xyz, v3.x, c60.xyww, r4
        mad r4.xyz, v3.z, c62.xyww, r4
        add r4.xyz, r4, c63.xyww
        dp3 r1.w, c14, v3
        add r5.xyz, -r1.w, -c54
        cmp r5.yzw, r5.xxyz, -c2.y, -c2.z
        mov r5.x, -c2.y
        dp4 r6.x, r5, c57
        dp4 r6.y, r5, c58
        dp4 r7.x, r5, c59
        dp4 r7.y, r5, c56
        mad r4.xy, r4, r6, r7
        add r5.xyz, c15, -v3
        dp3 r1.w, r5, r5
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        rcp r2.w, c53.w
        mul r2.w, r1.w, r2.w
        mul r2.w, r2.w, r2.w
        mul r2.w, r2.w, c0.w
        mov r5.y, c53.y
        mad r5.xz, r5.y, c12.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r3.w, r4.z, -r6.x
        cmp r3.w, r3.w, -c2.y, -c2.z
        mad r5.xz, r5.y, c12.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c11.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c11.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c10.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c10.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c9.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c9.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c8.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c8.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c7.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r4.xy, r5.y, c7.zwzw, r4
        texld r5, r4, s15
        add r4.x, r4.z, -r5.x
        cmp r4.x, r4.x, -c2.y, -c2.z
        add r3.w, r3.w, r4.x
        mad r2.w, r3.w, c1.x, r2.w
        add r1.w, r1.w, -c53.w
        cmp r4.xy, r1.w, c6, c6.zwzw
        add r1.w, r2.w, r4.y
        cmp_sat r1.w, r1.w, r2.w, r4.x
        mul r3.xyz, r3, r0.w
        mul r3.xyz, r1.w, r3
        mad r1.xyz, r1, v2.x, r3
        add r3, c19, -v3.x
        add r4, c20, -v3.y
        add r5, c21, -v3.z
        mul r6, r3, r3
        mad r6, r4, r4, r6
        mad r6, r5, r5, r6
        add r7, r6, c2.w
        rsq r8.x, r7.x
        rsq r8.y, r7.y
        rsq r8.z, r7.z
        rsq r8.w, r7.w
        mov r7.y, c2.y
        mad r6, r6, -c25, -r7.y
        max r9, r6, c2.x
        mul r6, r9, r9
        mad r6, r6, r6, c1.y
        mul r9, r6, c1.z
        cmp r6, r6, r9, c2.x
        mul r9, r2.x, r3
        mad r9, r4, r2.y, r9
        mad r2, r5, r2.z, r9
        mul r2, r6, r2
        mul_sat r2, r8, r2
        mul r3, r3, -c22
        mad r3, r4, -c23, r3
        mad r3, r5, -c24, r3
        mul r3, r8, r3
        mov r4, c26
        mad_sat r3, r3, r4, c27
        mul r2, r2, r3
        dp4 r3.x, c29, r2
        dp4 r3.y, c30, r2
        dp4 r3.z, c31, r2
        add r1.xyz, r1, r3
        mul r2.xyz, r0, r1
        rcp r0.w, v5.w
        mul r3.xy, r0.w, v5
        rcp r0.w, v4.w
        mul r3.zw, r0.w, v4.xyxy
        mul r3.zw, r3, c3.xyxy
        mad r3.xy, r3, c3, -r3.zwzw
        dp2add r0.w, r3, r3, c2.x
        rsq r0.w, r0.w
        rcp r0.w, r0.w
        mad r0.w, r0.w, -c3.z, c3.w
        mul r1.w, r0.w, v5.z
        mul r1.w, r1.w, c39.x
        cmp oC0.w, r0.w, r1.w, c2.x
        add r0.w, c16.w, -v1.w
        add r1.w, -c16.z, c16.w
        rcp r1.w, r1.w
        mul_sat r0.w, r0.w, r1.w
        add r0.w, -r0.w, -c2.y
        add r3.xy, r7.y, c16
        mul r1.w, r0.w, r3.y
        mad r0.w, r0.w, r3.x, -c2.y
        dp3 r2.x, r2, c5
        mad r0.xyz, r0, r1, -r2.x
        mad r0.xyz, r0.w, r0, r2.x
        add r0.w, r2.x, c1.w
        pow r2.x, r0_abs.w, r1.w
        mul r1.xyz, r0, r2.x
        rcp r0.w, c41.x
        mul_sat r0.w, r0.w, v1.w
        add r1.w, -c41.x, v1.w
        add r2.y, -c41.x, c41.y
        rcp r2.y, r2.y
        mul_sat r1.w, r1.w, r2.y
        lrp r2.y, c41.w, r0.w, r1.w
        add r0.w, r2.y, c41.z
        mov r3.xyz, c43
        add r2.yzw, -r3.xxyz, c42.xxyz
        mad r2.yzw, r1.w, r2, c43.xxyz
        mad r0.xyz, r0, -r2.x, r2.yzww
        mad oC0.xyz, r0.w, r0, r1
    
    // approximately 195 instruction slots used (15 texture, 180 arithmetic)
};

PixelShader PS_TexturedEightInst
<
    string StippleTexture       = "parameter register(10)";
    string TextureSampler       = "parameter register(0)";
    string gDirectionalColour   = "parameter register(18)";
    string gDirectionalLight    = "parameter register(17)";
    string gFacetCentre         = "parameter register(54)";
    string gLightAmbient0       = "parameter register(37)";
    string gLightAmbient1       = "parameter register(38)";
    string gLightColB           = "parameter register(31)";
    string gLightColG           = "parameter register(30)";
    string gLightColR           = "parameter register(29)";
    string gLightConeOffset     = "parameter register(27)";
    string gLightConeOffset2    = "parameter register(71)";
    string gLightConeScale      = "parameter register(26)";
    string gLightConeScale2     = "parameter register(70)";
    string gLightDir2X          = "parameter register(67)";
    string gLightDir2Y          = "parameter register(68)";
    string gLightDir2Z          = "parameter register(69)";
    string gLightDirX           = "parameter register(22)";
    string gLightDirY           = "parameter register(23)";
    string gLightDirZ           = "parameter register(24)";
    string gLightFallOff        = "parameter register(25)";
    string gLightPointColB      = "parameter register(65)";
    string gLightPointColG      = "parameter register(64)";
    string gLightPointColR      = "parameter register(35)";
    string gLightPointFallOff   = "parameter register(36)";
    string gLightPointPosX      = "parameter register(32)";
    string gLightPointPosY      = "parameter register(33)";
    string gLightPointPosZ      = "parameter register(34)";
    string gLightPosX           = "parameter register(19)";
    string gLightPosY           = "parameter register(20)";
    string gLightPosZ           = "parameter register(21)";
    string gShadowMatrix        = "parameter register(60)";
    string gShadowParam0123     = "parameter register(57)";
    string gShadowParam14151617 = "parameter register(56)";
    string gShadowParam18192021 = "parameter register(53)";
    string gShadowParam4567     = "parameter register(58)";
    string gShadowParam891113   = "parameter register(59)";
    string gShadowZSamplerDir   = "parameter register(15)";
    string gViewInverse         = "parameter register(12)";
    string globalScalars        = "parameter register(39)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   sampler2D StippleTexture;
    //   sampler2D TextureSampler;
    //   float4 gDirectionalColour;
    //   float4 gDirectionalLight;
    //   float4 gFacetCentre;
    //   float4 gLightAmbient0;
    //   float4 gLightAmbient1;
    //   float4 gLightColB;
    //   float4 gLightColG;
    //   float4 gLightColR;
    //   float4 gLightConeOffset;
    //   float4 gLightConeOffset2;
    //   float4 gLightConeScale;
    //   float4 gLightConeScale2;
    //   float4 gLightDir2X;
    //   float4 gLightDir2Y;
    //   float4 gLightDir2Z;
    //   float4 gLightDirX;
    //   float4 gLightDirY;
    //   float4 gLightDirZ;
    //   float4 gLightFallOff;
    //   float4 gLightPointColB;
    //   float4 gLightPointColG;
    //   float4 gLightPointColR;
    //   float4 gLightPointFallOff;
    //   float4 gLightPointPosX;
    //   float4 gLightPointPosY;
    //   float4 gLightPointPosZ;
    //   float4 gLightPosX;
    //   float4 gLightPosY;
    //   float4 gLightPosZ;
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
    //   Name                 Reg   Size
    //   -------------------- ----- ----
    //   gViewInverse         c12      4
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
    //   gLightPointPosX      c32      1
    //   gLightPointPosY      c33      1
    //   gLightPointPosZ      c34      1
    //   gLightPointColR      c35      1
    //   gLightPointFallOff   c36      1
    //   gLightAmbient0       c37      1
    //   gLightAmbient1       c38      1
    //   globalScalars        c39      1
    //   gShadowParam18192021 c53      1
    //   gFacetCentre         c54      1
    //   gShadowParam14151617 c56      1
    //   gShadowParam0123     c57      1
    //   gShadowParam4567     c58      1
    //   gShadowParam891113   c59      1
    //   gShadowMatrix        c60      4
    //   gLightPointColG      c64      1
    //   gLightPointColB      c65      1
    //   gLightDir2X          c67      1
    //   gLightDir2Y          c68      1
    //   gLightDir2Z          c69      1
    //   gLightConeScale2     c70      1
    //   gLightConeOffset2    c71      1
    //   TextureSampler       s0       1
    //   StippleTexture       s10      1
    //   gShadowZSamplerDir   s15      1
    //
    
        ps_3_0
        def c0, -0.5, 0.5, 1.33333337, 1.5
        def c1, 0.0833333358, -0.100000001, 1.11111116, 0
        def c2, 0, -1, -0, 9.99999975e-006
        def c3, 640, 576, 0.349999994, 1
        def c4, 3.99600005, 4, 0.125, 0.25
        def c5, 1, -1, 0, -0
        def c6, -0.321940005, -0.932614982, -0.791558981, -0.597710013
        def c7, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
        def c8, 0.519456029, 0.767022014, 0.185461, -0.893123984
        def c9, 0.962339997, -0.194983006, 0.473434001, -0.480026007
        def c10, -0.69591397, 0.457136989, -0.203345001, 0.620715976
        def c11, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl_color v2.xyz
        dcl_texcoord6 v3.xyz
        dcl_texcoord8 v4.xyw
        dcl_texcoord7 v5
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        dcl_2d s15
        mov_sat r0.x, c39.x
        mul r0.x, r0.x, c4.x
        frc r0.y, r0.x
        mul r0.z, r0.y, c4.y
        frc r0.w, r0.z
        add r1.xy, r0.zxzw, -r0.wyzw
        mul r0.xy, c4.z, vPos
        frc r0.xy, r0_abs
        cmp r0.xy, vPos, r0, -r0
        mul r0.xy, r0, c4.w
        mad r0.xy, r1, c4.w, r0
        mov r0.zw, c2.x
        texldl r0, r0, s10
        cmp r0, -r0.y, c2.y, c2.z
        texkill r0
        texld r0, v0, s0
        add r1.xyz, c2.w, v1
        nrm r2.xyz, r1
        mul r0.xyz, r0, v2
        mad_sat r0.w, r2.z, c0.x, c0.y
        mov r1.xyz, c38
        mad r1.xyz, r1, r0.w, c37
        mul r3.xyz, c18.w, c18
        dp3 r0.w, r2, -c17
        add r0.w, r0.w, -c4.w
        mul_sat r0.w, r0.w, c0.z
        mul r4.xyz, c61.xyww, v3.y
        mad r4.xyz, v3.x, c60.xyww, r4
        mad r4.xyz, v3.z, c62.xyww, r4
        add r4.xyz, r4, c63.xyww
        dp3 r1.w, c14, v3
        add r5.xyz, -r1.w, -c54
        cmp r5.yzw, r5.xxyz, -c2.y, -c2.z
        mov r5.x, -c2.y
        dp4 r6.x, r5, c57
        dp4 r6.y, r5, c58
        dp4 r7.x, r5, c59
        dp4 r7.y, r5, c56
        mad r4.xy, r4, r6, r7
        add r5.xyz, c15, -v3
        dp3 r1.w, r5, r5
        rsq r1.w, r1.w
        rcp r1.w, r1.w
        rcp r2.w, c53.w
        mul r2.w, r1.w, r2.w
        mul r2.w, r2.w, r2.w
        mul r2.w, r2.w, c0.w
        mov r5.y, c53.y
        mad r5.xz, r5.y, c11.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r3.w, r4.z, -r6.x
        cmp r3.w, r3.w, -c2.y, -c2.z
        mad r5.xz, r5.y, c11.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c10.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c10.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c9.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c9.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c8.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c8.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c7.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c7.zyww, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r5.xz, r5.y, c6.xyyw, r4.xyyw
        texld r6, r5.xzzw, s15
        add r4.w, r4.z, -r6.x
        cmp r4.w, r4.w, -c2.y, -c2.z
        add r3.w, r3.w, r4.w
        mad r4.xy, r5.y, c6.zwzw, r4
        texld r5, r4, s15
        add r4.x, r4.z, -r5.x
        cmp r4.x, r4.x, -c2.y, -c2.z
        add r3.w, r3.w, r4.x
        mad r2.w, r3.w, c1.x, r2.w
        add r1.w, r1.w, -c53.w
        cmp r4.xy, r1.w, c5, c5.zwzw
        add r1.w, r2.w, r4.y
        cmp_sat r1.w, r1.w, r2.w, r4.x
        mul r3.xyz, r3, r0.w
        mul r3.xyz, r1.w, r3
        mad r1.xyz, r1, v2.x, r3
        add r3, c19, -v3.x
        add r4, c20, -v3.y
        add r5, c21, -v3.z
        mul r6, r3, r3
        mad r6, r4, r4, r6
        mad r6, r5, r5, r6
        add r7, r6, c2.w
        rsq r8.x, r7.x
        rsq r8.y, r7.y
        rsq r8.z, r7.z
        rsq r8.w, r7.w
        mov r7.y, c2.y
        mad r6, r6, -c25, -r7.y
        max r9, r6, c2.x
        mul r6, r9, r9
        mad r6, r6, r6, c1.y
        mul r9, r6, c1.z
        cmp r6, r6, r9, c2.x
        mul r9, r2.x, r3
        mad r9, r4, r2.y, r9
        mad r9, r5, r2.z, r9
        mul r6, r6, r9
        mul_sat r6, r8, r6
        mul r3, r3, -c22
        mad r3, r4, -c23, r3
        mad r3, r5, -c24, r3
        mul r3, r8, r3
        mov r4, c26
        mad_sat r3, r3, r4, c27
        mul r3, r6, r3
        dp4 r4.x, c29, r3
        dp4 r4.y, c30, r3
        dp4 r4.z, c31, r3
        add r1.xyz, r1, r4
        add r3, c32, -v3.x
        add r4, c33, -v3.y
        add r5, c34, -v3.z
        mul r6, r3, r3
        mad r6, r4, r4, r6
        mad r6, r5, r5, r6
        add r8, r6, c2.w
        rsq r9.x, r8.x
        rsq r9.y, r8.y
        rsq r9.z, r8.z
        rsq r9.w, r8.w
        mad r6, r6, -c36, -r7.y
        max r7, r6, c2.x
        mul r6, r7, r7
        mad r6, r6, r6, c1.y
        mul r7, r6, c1.z
        cmp r6, r6, r7, c2.x
        mul r7, r2.x, r3
        mad r7, r4, r2.y, r7
        mad r2, r5, r2.z, r7
        mul r2, r6, r2
        mul_sat r2, r9, r2
        mul r3, r3, -c67
        mad r3, r4, -c68, r3
        mad r3, r5, -c69, r3
        mul r3, r9, r3
        mov r4, c70
        mad_sat r3, r3, r4, c71
        mul r2, r2, r3
        dp4 r3.x, c35, r2
        dp4 r3.y, c64, r2
        dp4 r3.z, c65, r2
        add r1.xyz, r1, r3
        mul oC0.xyz, r0, r1
        rcp r0.x, v5.w
        mul r0.xy, r0.x, v5
        rcp r0.z, v4.w
        mul r0.zw, r0.z, v4.xyxy
        mul r0.zw, r0, c3.xyxy
        mad r0.xy, r0, c3, -r0.zwzw
        dp2add r0.x, r0, r0, c2.x
        rsq r0.x, r0.x
        rcp r0.x, r0.x
        mad r0.x, r0.x, -c3.z, c3.w
        mul r0.y, r0.x, v5.z
        mul r0.y, r0.y, c39.x
        cmp oC0.w, r0.x, r0.y, c2.x
    
    // approximately 200 instruction slots used (15 texture, 185 arithmetic)
};

technique draw
{
    pass p0
    {
        ZWriteEnable = false;

        VertexShader = VS_Transform;
        PixelShader = PS_TexturedEight;
    }
}

technique drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkin;
        PixelShader = PS_TexturedEight;
    }
}

technique unlit_draw
{
    pass p0
    {
        ZWriteEnable = false;

        VertexShader = VS_TransformUnlit;
        PixelShader = PS_TexturedUnlit;
    }
}

technique unlit_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkinUnlit;
        PixelShader = PS_TexturedUnlit;
    }
}

technique deferred_draw
{
    pass p0
    {
        VertexShader = VS_TransformD;
        PixelShader = PS_DeferredTextured;
    }
}

technique deferredalphaclip_draw
{
    pass p0
    {
        VertexShader = VS_TransformAlphaClipD;
        PixelShader = PS_DeferredTexturedAlphaClip;
    }
}

technique deferred_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkinD;
        PixelShader = PS_DeferredTextured;
    }
}

technique deferredalphaclip_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkinD;
        PixelShader = PS_DeferredTexturedAlphaClip;
    }
}

technique wd_draw
{
    pass p0
    {
        VertexShader = VS_ShadowDepth;
        PixelShader = PS_ShadowDepth;
    }
}

technique wd_drawskinned
{
    pass p0
    {
        VertexShader = VS_ShadowDepthSkin;
        PixelShader = PS_ShadowDepth;
    }
}

technique wd_masked_draw
{
    pass p0
    {
        VertexShader = VS_ShadowDepth;
        PixelShader = PS_ShadowDepthMasked;
    }
}

technique wd_masked_drawskinned
{
    pass p0
    {
        VertexShader = VS_ShadowDepthSkin;
        PixelShader = PS_ShadowDepthMasked;
    }
}

technique paraboloid_draw
{
    pass p0
    {
        VertexShader = VS_TransformParaboloid;
        PixelShader = PS_TexturedBasicParaboloid;
    }
}

technique paraboloid_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformParaboloid;
        PixelShader = PS_TexturedBasicParaboloid;
    }
}

technique reflection_draw
{
    pass p0
    {
        VertexShader = VS_Transform;
        PixelShader = PS_TexturedBasic;
    }
}

technique reflection_drawskinned
{
    pass p0
    {
        VertexShader = VS_Transform;
        PixelShader = PS_TexturedBasic;
    }
}

technique imposterdeferred_draw
{
    pass p0
    {
        VertexShader = VS_TransformD;
        PixelShader = PS_DeferredImposter;
    }
}

technique imposterdeferred_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkinD;
        PixelShader = PS_DeferredImposter;
    }
}

technique lightweight0_draw
{
    pass p0
    {
        ZWriteEnable = false;

        VertexShader = VS_Transform;
        PixelShader = PS_TexturedZero;
    }
}

technique lightweight0_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkin;
        PixelShader = PS_TexturedZero;
    }
}

technique lightweight4_draw
{
    pass p0
    {
        ZWriteEnable = false;

        VertexShader = VS_Transform;
        PixelShader = PS_TexturedFour;
    }
}

technique lightweight4_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkin;
        PixelShader = PS_TexturedFour;
    }
}

technique draw_inst
{
    pass p0
    {
        ZWriteEnable = false;
        CullMode = CW;

        VertexShader = VS_TransformInst;
        PixelShader = PS_TexturedEightInst;
    }
}

technique unlit_draw_inst
{
    pass p0
    {
        ZWriteEnable = false;
        SrcBlend = SRCALPHA;
        DestBlend = INVSRCALPHA;
        CullMode = CW;

        VertexShader = VS_TransformSkinInst;
        PixelShader = PS_TexturedUnlit;
    }
}


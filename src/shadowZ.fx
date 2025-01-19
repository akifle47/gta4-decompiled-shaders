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
float shadowmap_res : ShadowMapResolution = 1280.000000;
float2 facetMask[4] : facetMask = 
{
    float2(-1.000000, 0.000000), 
    float2(1.000000, 0.000000), 
    float2(0.000000, -1.000000), 
    float2(0.000000, 1.000000)
};

//Vertex shaders
VertexShader VS_WarpDepth
<
    string facetMask            = "parameter register(208)";
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
    //   facetMask            c208     4
    //
    
        vs_3_0
        def c4, -0.5, 2, -1, 0.5
        def c5, 0, -3, 1, 0
        dcl_position v0
        dcl_position o0
        dcl_texcoord1 o1
        mul r0.xyz, c1, v0.y
        mad r0.xyz, v0.x, c0, r0
        mad r0.xyz, v0.z, c2, r0
        add r0.xyz, r0, c3
        abs r0.w, c56.x
        sge r1.x, -r0.w, r0.w
        if_ge -r0.w, r0.w
          mul r1.yzw, r0.y, c61.xxyz
          mad r1.yzw, r0.x, c60.xxyz, r1
          mad r1.yzw, r0.z, c62.xxyz, r1
          add r2.xyz, r1.yzww, c63
          add r0.w, r2.z, c59.z
          abs r1.y, c56.y
          sge r1.y, -r1.y, r1.y
          add r1.y, r1.y, c4.x
          mul r0.w, r0.w, r1.y
          add r2.w, r0.w, r0.w
          dp3 r1.y, r2.xyww, r2.xyww
          rsq r1.y, r1.y
          rcp r1.y, r1.y
          mad r0.w, r0.w, -c4.y, r1.y
          rcp r0.w, r0.w
          mul r3.xy, r2, r0.w
          mul r3.w, r2.w, -c57.w
          mul r3.z, r1.y, -c57.w
        else
          mov r2.x, c56.x
          add r0.w, r2.x, c4.z
          if_ge -r0_abs.w, r0_abs.w
            mul r1.yzw, r0.y, c61.xxyz
            mad r1.yzw, r0.x, c60.xxyz, r1
            mad r1.yzw, r0.z, c62.xxyz, r1
            add r2.xyz, r1.yzww, c63
            mul r4.z, r2.z, c57.w
            mov r2.w, c4.w
            mov r4.xy, c57.z
            mul r3.xyz, r2.xyww, r4
            frc r0.w, c56.y
            add r0.w, -r0.w, c56.y
            mova a0.x, r0.w
            mul r1.yz, r3.xxyw, c208[a0.x].xxyw
            add r0.w, r1.z, r1.y
            add r3.w, r0.w, c4.y
            max r3.z, r3.z, c5.x
          else
            mul r1.yzw, r0.y, c61.xxyz
            mad r1.yzw, r0.x, c60.xxyz, r1
            mad r1.yzw, r0.z, c62.xxyz, r1
            add r1.yzw, r1, c63.xxyz
            mul r3.xy, r1.yzzw, c57.z
            mov r3.w, -r1.w
            mov r2.x, c57.x
            add r0.w, r2.x, -c59.w
            rcp r0.w, r0.w
            mul r1.y, r0.w, c59.w
            mul r1.z, r2.x, c59.w
            mul r0.w, r0.w, r1.z
            mad r3.z, r1.w, r1.y, r0.w
          endif
        endif
        mov r1.y, c5.y
        add r0.w, r1.y, c56.x
        sge r0.w, -r0_abs.w, r0_abs.w
        mad r1.y, r3.w, -c57.w, -r3.w
        mad r2.z, r0.w, r1.y, r3.w
        mov r2.x, r3.w
        mov r2.y, r0.z
        mad r1.yzw, r3.xwwz, c5.xxzz, c5.xzxx
        lrp r4.xyz, r1.x, r1.yzww, r2
        mov o0.xyz, r3
        mov o0.w, r4.x
        mov o1.xy, r0
        mov o1.zw, r4.xyyz
    
    // approximately 77 instruction slots used
};

VertexShader VS_WarpDepthSkin
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
        def c1, 2, -3, 0, 0
        dcl_position v0
        dcl_blendweight v1
        dcl_blendindices v2
        dcl_position o0
        dcl_texcoord1 o1
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
        abs r0.w, c56.x
        sge r1.x, -r0.w, r0.w
        if_ge -r0.w, r0.w
          mul r1.yzw, r0.y, c61.xxyz
          mad r1.yzw, r0.x, c60.xxyz, r1
          mad r1.yzw, r0.z, c62.xxyz, r1
          add r2.xyz, r1.yzww, c63
          add r0.w, r2.z, c59.z
          abs r1.y, c56.y
          sge r1.y, -r1.y, r1.y
          add r1.y, r1.y, c0.w
          mul r0.w, r0.w, r1.y
          add r2.w, r0.w, r0.w
          dp3 r1.y, r2.xyww, r2.xyww
          rsq r1.y, r1.y
          rcp r1.y, r1.y
          mad r0.w, r0.w, -c1.x, r1.y
          rcp r0.w, r0.w
          mul r3.xy, r2, r0.w
          mul r3.w, r2.w, -c57.w
          mul r3.z, r1.y, -c57.w
        else
          mov r1.y, c0.y
          add r0.w, -r1.y, c56.x
          if_ge -r0_abs.w, r0_abs.w
            mul r1.yzw, r0.y, c61.xxyz
            mad r1.yzw, r0.x, c60.xxyz, r1
            mad r1.yzw, r0.z, c62.xxyz, r1
            add r2.xyz, r1.yzww, c63
            mul r4.z, r2.z, c57.w
            mov r2.w, -c0.w
            mov r4.xy, c57.z
            mul r3.xyz, r2.xyww, r4
            frc r0.w, c56.y
            add r0.w, -r0.w, c56.y
            mova a0.x, r0.w
            mul r1.yz, r3.xxyw, c208[a0.x].xxyw
            add r0.w, r1.z, r1.y
            add r3.w, r0.w, c1.x
            max r3.z, r3.z, c0.z
          else
            mul r1.yzw, r0.y, c61.xxyz
            mad r1.yzw, r0.x, c60.xxyz, r1
            mad r1.yzw, r0.z, c62.xxyz, r1
            add r1.yzw, r1, c63.xxyz
            mul r3.xy, r1.yzzw, c57.z
            mov r3.w, -r1.w
            mov r2.x, c57.x
            add r0.w, r2.x, -c59.w
            rcp r0.w, r0.w
            mul r1.y, r0.w, c59.w
            mul r1.z, r2.x, c59.w
            mul r0.w, r0.w, r1.z
            mad r3.z, r1.w, r1.y, r0.w
          endif
        endif
        mov r2.x, c56.x
        add r0.w, r2.x, c1.y
        sge r0.w, -r0_abs.w, r0_abs.w
        mad r1.y, r3.w, -c57.w, -r3.w
        mad r2.z, r0.w, r1.y, r3.w
        mov r2.x, r3.w
        mov r2.y, r0.z
        mad r1.yzw, r3.xwwz, c0.xzyy, c0.xyzz
        lrp r4.xyz, r1.x, r1.yzww, r2
        mov o0.xyz, r3
        mov o0.w, r4.x
        mov o1.xy, r0
        mov o1.zw, r4.xyyz
    
    // approximately 92 instruction slots used
};

//Pixel shaders
PixelShader PixelShader0 = NULL;

PixelShader PS_WarpDepth
<
    string gShadowParam14151617 = "parameter register(56)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   float4 gShadowParam14151617;
    //
    //
    // Registers:
    //
    //   Name                 Reg   Size
    //   -------------------- ----- ----
    //   gShadowParam14151617 c56      1
    //
    
        ps_3_0
        def c0, 0.00999999978, 0, 0, 0
        dcl_texcoord1 v0.zw
        add r0.x, c0.x, -v0.z
        abs r0.y, c56.x
        cmp r0, -r0.y, r0.x, c0.y
        texkill r0
        mov oC0, v0.w
    
    // approximately 5 instruction slots used
};

technique wd_draw
{
    pass p0
    {
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_WarpDepth;
        PixelShader = PS_WarpDepth;
    }
}

technique wd_drawskinned
{
    pass p0
    {
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_WarpDepthSkin;
        PixelShader = PS_WarpDepth;
    }
}

technique unlit_draw
{
    pass p0
    {
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_WarpDepth;
        PixelShader = PS_WarpDepth;
    }
}

technique unlit_drawskinned
{
    pass p0
    {
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = VS_WarpDepthSkin;
        PixelShader = PS_WarpDepth;
    }
}


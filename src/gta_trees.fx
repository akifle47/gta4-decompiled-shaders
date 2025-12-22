#define NO_SKINNING
#define DIFFUSE_TEXTURE
#define ALPHA_SHADOW
#define NO_GENERATED_TECHNIQUES

#include "common.fxh"
#include "megashader.fxh"

float3 imposterDir[8] : imposterDir = 
{
    float3(1.0, 0.0, 0.0), 
    float3(0.577350259, 0.577350259, -0.577350259), 
    float3(0.0, 1.0, 0.0), 
    float3(-0.577350259, 0.577350259, -0.577350259), 
    float3(-1.0, 0.0, 0.0), 
    float3(-0.577350259, -0.577350259, -0.577350259), 
    float3(0.0, -1.0, 0.0), 
    float3(0.577350259, -0.577350259, -0.577350259)
};

float3 normTable[16] : normTable = 
{
    float3(0.0, 0.0, 0.0), 
    float3(0.0, 0.0, -1.0), 
    float3(0.0, 0.5, -0.866025388), 
    float3(0.433012694, -0.25, -0.866025388), 
    float3(-0.433012694, -0.25, -0.866025388), 
    float3(0.0, 0.939692616, 0.342020154), 
    float3(0.813797653, 0.469846308, -0.342020154), 
    float3(0.813797653, -0.469846308, 0.342020154), 
    float3(0.0, -0.939692616, -0.342020154), 
    float3(-0.813797653, -0.469846308, 0.342020154), 
    float3(-0.813797653, 0.469846308, -0.342020154), 
    float3(-0.433012694, 0.25, 0.866025388), 
    float3(0.433012694, 0.25, 0.866025388), 
    float3(0.0, -0.5, -0.866025388), 
    float3(0.0, 0.0, 1.0), 
    float3(0.0, 0.0, 0.0)
};

float altRemap[16] : altRemap = 
{
    0.0, 
    2.0, 
    6.0, 
    8.0, 
    10.0, 
    11.0, 
    7.0, 
    12.0, 
    9.0, 
    13.0, 
    5.0, 
    14.0, 
    14.0, 
    14.0, 
    13.0, 
    15.0
};


struct VS_InputTree
{
    float3 Position : POSITION;
    float3 Normal   : NORMAL;
    float4 Color    : COLOR;
    float2 TexCoord : TEXCOORD0;
};


struct VS_OutputTree
{
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
};

VS_OutputTree VSPropFoliage0(VS_InputTree IN)
{
    VS_OutputTree OUT;

    OUT.Position.xy = float2(0, 0);
    OUT.Position.zw = mul(float4(IN.Position, 1.0), gWorldViewProj).zw;
    OUT.TexCoord = IN.TexCoord;

    return OUT;
}

float4 PSPropFoliage(VS_InputTree IN) : COLOR
{
    return tex2D(TextureSampler, IN.TexCoord).wwww;
}


struct VS_OutputTreeDeferred
{
    float4 Position      : POSITION;
    float2 TexCoord      : TEXCOORD0;
    float3 NormalWorld   : TEXCOORD1;
    float2 AoAndAlpha    : TEXCOORD2;
    float3 PositionWorld : TEXCOORD3;
};

VS_OutputTreeDeferred VSPropFoliageDeferred(VS_InputTree IN)
{
    VS_OutputTreeDeferred OUT;

    const float4 windDirAndStrength = colorize;

    OUT.NormalWorld = mul(IN.Normal, (float3x3)gWorld);

    float dist = length(IN.Position);
    float distScalar = dist / 200 + 0.01;

    float3 windDir = normalize((float3(IN.Position.y, -IN.Position.x, 0) + 0.000001)) * distScalar;
    float3 windDir2 = normalize(cross(windDir, IN.Position) + 0.000001) * distScalar;
        
    float angle = dist * windDirAndStrength.w * 0.2;
    float2 anglePos;
    sincos(angle, anglePos.x, anglePos.y);

    float3 position = IN.Position;
    position += (windDir * anglePos.x);
    position += (windDir2 * 0.5 * anglePos.y);

    OUT.Position = mul(float4(position, 1.0), gWorldViewProj);
    OUT.PositionWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;

    OUT.AoAndAlpha.x = ComputeDayNightEffects(IN.Color.xy).x;
    OUT.AoAndAlpha.y = IN.Color.w * globalScalars.x;

    OUT.TexCoord = IN.TexCoord;

    return OUT;
}

PS_OutputDeferred PSPropFoliageDeferred(VS_OutputTreeDeferred IN, float2 screenCoords : VPOS)
{
    PS_OutputDeferred OUT;
    
    float4 diffuse = tex2D(TextureSampler, IN.TexCoord);
    AlphaClip(diffuse.w, screenCoords);

    OUT.Diffuse.xyz = diffuse.xyz;
    OUT.Diffuse.w = diffuse.w * globalScalars.x;
    OUT.Normal = float4(IN.NormalWorld * 0.5 + 0.5, 0);
    OUT.SpecularAndAO = float4(0, 0.5, 0.5, 0);
    OUT.Stencil = float4(0, 0, 0, 0);

    return OUT;
}


VS_OutputTree VSPropFoliage(VS_InputTree IN)
{
    VS_OutputTree OUT;

    OUT.Position = mul(float4(IN.Position, 1.0), gWorldViewProj);
    OUT.TexCoord = IN.TexCoord;

    return OUT;
}

float4 PSPropFoliageImposterShadow(VS_OutputTree IN) : COLOR
{
    float alpha = tex2D(TextureSampler, IN.TexCoord).w;
    if(alpha < 0.125)
        discard;

    return alpha * 2;
}


VS_OutputTreeDeferred VSPropFoliageImposter(VS_InputTree IN)
{
    VS_OutputTreeDeferred OUT;

    OUT.Position = mul(float4(IN.Position, 1.0), gWorldViewProj);
    OUT.PositionWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;

    OUT.NormalWorld = mul(IN.Normal, (float3x3)gWorld);

    OUT.AoAndAlpha.x = ComputeDayNightEffects(IN.Color.xy).x;
    OUT.AoAndAlpha.y = IN.Color.w * globalScalars.x;

    OUT.TexCoord = IN.TexCoord;

    return OUT;
}

float4 PSPropFoliageImposter(VS_OutputTreeDeferred IN) : COLOR
{
    float4 diffuse = tex2Dlod(TextureSampler, float4(IN.TexCoord, 0, 0));
    if(diffuse.w < 0.125)
        discard;

    return diffuse;
}

PixelShader PSPropFoliageDeferredImposter
<
    string StippleTexture = "parameter register(10)";
    string TextureSampler = "parameter register(0)";
    string altRemap       = "parameter register(88)";
    string colorize       = "parameter register(51)";
    string normTable      = "parameter register(72)";
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
    //   float altRemap[16];
    //   float4 colorize;
    //   float3 normTable[16];
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   colorize       c51      1
    //   normTable      c72     16
    //   altRemap       c88     16
    //   TextureSampler s0       1
    //   StippleTexture s10      1
    //
    
        ps_3_0
        def c0, 7, 8, 9, 10
        def c1, 3.99600005, 4, 0.125, 0.25
        def c2, 0, -1, -0, 9.99999975e-006
        def c3, 2, 3, 5, 6
        def c4, 11, 12, 13, 14
        def c5, 15, 12, 13, 14
        def c6, -0, -1, -2, -3
        def c7, -4, -5, -6, -7
        def c8, -8, -9, -10, -11
        def c9, -0.5, 16, 0.00392156886, 0
        def c10, -1, -2, -3, -4
        dcl_texcoord v0.xy
        dcl_texcoord1 v1.xyz
        dcl vPos.xy
        dcl_2d s0
        dcl_2d s10
        texld r0, v0, s0
        mov_sat r0.x, r0.w
        mul r0.x, r0.x, c1.x
        frc r0.y, r0.x
        mul r0.z, r0.y, c1.y
        frc r1.x, r0.z
        add r1.x, r0.z, -r1.x
        add r1.y, r0.x, -r0.y
        mul r0.xy, c1.z, vPos
        frc r0.xy, r0_abs
        cmp r0.xy, vPos, r0, -r0
        mul r0.xy, r0, c1.w
        mad r1.xy, r1, c1.w, r0
        mov r1.zw, c2.x
        texldl r1, r1, s10
        cmp r1, -r1.y, c2.y, c2.z
        texkill r1
        add r0.xyz, c2.w, v1
        nrm r1.xyz, r0
        dp3 r0.x, r1, c73
        add r0.y, -r0.x, c2.y
        cmp r0.y, r0.y, -c2.z, -c2.y
        max r1.w, c2.y, r0.x
        dp3 r0.x, r1, c74
        add r0.z, r1.w, -r0.x
        cmp r0.y, r0.z, r0.y, c3.x
        max r2.x, r1.w, r0.x
        dp3 r0.x, r1, c75
        add r0.z, r2.x, -r0.x
        cmp r0.y, r0.z, r0.y, c3.y
        max r1.w, r2.x, r0.x
        dp3 r0.x, r1, c76
        add r0.z, r1.w, -r0.x
        cmp r0.y, r0.z, r0.y, c1.y
        max r2.x, r1.w, r0.x
        dp3 r0.x, r1, c77
        add r0.z, r2.x, -r0.x
        cmp r0.y, r0.z, r0.y, c3.z
        max r1.w, r2.x, r0.x
        dp3 r0.x, r1, c78
        add r0.z, r1.w, -r0.x
        cmp r0.y, r0.z, r0.y, c3.w
        max r2.x, r1.w, r0.x
        dp3 r0.x, r1, c79
        add r0.z, r2.x, -r0.x
        cmp r0.y, r0.z, r0.y, c0.x
        max r1.w, r2.x, r0.x
        dp3 r0.x, r1, c80
        add r0.z, r1.w, -r0.x
        cmp r0.y, r0.z, r0.y, c0.y
        max r2.x, r1.w, r0.x
        dp3 r0.x, r1, c81
        add r0.z, r2.x, -r0.x
        cmp r0.y, r0.z, r0.y, c0.z
        max r1.w, r2.x, r0.x
        dp3 r0.x, r1, c82
        add r0.z, r1.w, -r0.x
        cmp r0.y, r0.z, r0.y, c0.w
        max r2.x, r1.w, r0.x
        dp3 r0.x, r1, c83
        add r0.z, r2.x, -r0.x
        cmp r0.y, r0.z, r0.y, c4.x
        max r1.w, r2.x, r0.x
        dp3 r0.x, r1, c84
        add r0.z, r1.w, -r0.x
        cmp r0.y, r0.z, r0.y, c4.y
        max r2.x, r1.w, r0.x
        dp3 r0.x, r1, c85
        add r0.z, r2.x, -r0.x
        cmp r0.y, r0.z, r0.y, c4.z
        max r1.w, r2.x, r0.x
        dp3 r0.x, r1, c86
        add r0.z, r1.w, -r0.x
        cmp r0.y, r0.z, r0.y, c4.w
        max r2.x, r1.w, r0.x
        dp3 r0.x, r1, c87
        add r0.x, r2.x, -r0.x
        cmp r0.x, r0.x, r0.y, c5.x
        add r1, r0.x, c6
        add r2, r0.x, c7
        add r3, r0.x, c8
        add r4, r0.x, -c5.yzwx
        mov r5.x, c2.x
        cmp r0.y, -r1_abs.x, c88.x, r5.x
        cmp r0.y, -r1_abs.y, c89.x, r0.y
        cmp r0.y, -r1_abs.z, c90.x, r0.y
        cmp r0.y, -r1_abs.w, c91.x, r0.y
        cmp r0.y, -r2_abs.x, c92.x, r0.y
        cmp r0.y, -r2_abs.y, c93.x, r0.y
        cmp r0.y, -r2_abs.z, c94.x, r0.y
        cmp r0.y, -r2_abs.w, c95.x, r0.y
        cmp r0.y, -r3_abs.x, c96.x, r0.y
        cmp r0.y, -r3_abs.y, c97.x, r0.y
        cmp r0.y, -r3_abs.z, c98.x, r0.y
        cmp r0.y, -r3_abs.w, c99.x, r0.y
        cmp r0.y, -r4_abs.x, c100.x, r0.y
        cmp r0.y, -r4_abs.y, c101.x, r0.y
        cmp r0.y, -r4_abs.z, c102.x, r0.y
        cmp r0.y, -r4_abs.w, c103.x, r0.y
        add r0.z, r0.w, c9.x
        cmp r0.x, r0.z, r0.x, r0.y
        abs r0.y, c51.x
        cmp r0.y, -r0.y, r0.x, c2.x
        mov r1.x, c51.x
        add r2, r1.x, c10
        cmp r0.zw, -r2_abs.xyyw, r0.x, c2.x
        add r1.xyz, r1.x, c7.yzww
        cmp r1.y, -r1_abs.y, r0.x, c2.x
        mul r0.x, r0.x, c9.y
        cmp r2.xy, -r2_abs.xzzw, r0.x, c2.x
        add r0.y, r0.y, r2.x
        mul oC0.x, r0.y, c9.z
        add r0.y, r0.z, r2.y
        mul oC0.y, r0.y, c9.z
        cmp r0.xy, -r1_abs.xzzw, r0.x, c2.x
        add r0.x, r0.w, r0.x
        mul oC0.z, r0.x, c9.z
        add r0.x, r1.y, r0.y
        mul oC0.w, r0.x, c9.z
    
    // approximately 122 instruction slots used (3 texture, 119 arithmetic)
};


float4 PS_ShadowDepthFoliage(VS_ShadowDepthOutput IN, float2 screenCoords : VPOS) : COLOR
{
    return PS_ShadowDepth(IN, screenCoords);
}



technique deferred_draw
{
    pass p0
    {
        StencilRef = 3;
        CullMode = CCW;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;
        ColorWriteEnable = RED | GREEN | BLUE;
        ColorWriteEnable1 = RED | GREEN | BLUE;
        ColorWriteEnable2 = RED | GREEN | BLUE;
        ColorWriteEnable3 = RED | GREEN | BLUE | ALPHA;

        VertexShader = compile vs_3_0 VSPropFoliageDeferred();
        PixelShader = compile ps_3_0 PSPropFoliageDeferred();
    }
    pass p1
    {
        StencilRef = 3;
        CullMode = CW;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;
        ColorWriteEnable = RED | GREEN | BLUE;
        ColorWriteEnable1 = RED | GREEN | BLUE;
        ColorWriteEnable2 = RED | GREEN | BLUE;
        ColorWriteEnable3 = RED | GREEN | BLUE | ALPHA;

        VertexShader = compile vs_3_0 VSPropFoliageDeferred();
        PixelShader = compile ps_3_0 PSPropFoliageDeferred();
    }
}

technique deferredalphaclip_draw
{
    pass p0
    {
        CullMode = NONE;
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VSPropFoliageDeferred();
        PixelShader = compile ps_3_0 PSPropFoliageDeferred();
    }
}

technique draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VSPropFoliage0();
        PixelShader = compile ps_3_0 PSPropFoliage();
    }
}

technique imposter_draw
{
    pass p0
    {
        AlphaTestEnable = false;
        AlphaBlendEnable = false;
        CullMode = NONE;

        VertexShader = compile vs_3_0 VSPropFoliageImposter();
        PixelShader = compile ps_3_0 PSPropFoliageImposter();
    }
}

technique imposterdeferred_draw
{
    pass p0
    {
        AlphaTestEnable = false;
        CullMode = NONE;

        VertexShader = compile vs_3_0 VSPropFoliageImposter();
        PixelShader = PSPropFoliageDeferredImposter;
    }
}

technique wd_draw
{
    pass p0
    {
        CullMode = NONE;
        AlphaTestEnable = false;
        AlphaBlendEnable = false;

        VertexShader = compile vs_3_0 VS_ShadowDepth();
        PixelShader = compile ps_3_0 PS_ShadowDepthFoliage();
    }
}

technique wd_masked_draw
{
    pass p0
    {
        CullMode = NONE;
        AlphaTestEnable = false;
        AlphaBlendEnable = false;

        VertexShader = compile vs_3_0 VS_ShadowDepth();
        PixelShader = compile ps_3_0 PS_ShadowDepthFoliage();
    }
}

technique impostershadow_draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VSPropFoliage();
        PixelShader = compile ps_3_0 PSPropFoliageImposterShadow();
    }
}


#define DRAWBUCKET_DECAL
#define DIFFUSE_TEXTURE
#define VEHICLE_DAMAGE
#define DEPTH_SHIFT_SCALE
#define SPECULAR
#define PARALLAX
#define ALPHA_SHADOW
#define DIFFUSE_ALPHA
//TODO: temporary until projtex functions are translated
#define NO_GENERATED_TECHNIQUES

#include "common.fxh"
#include "megashader.fxh"

//Pixel shaders
PixelShader PixelShader0 = NULL;

technique draw
{
    pass p0
    {
        VertexShader = VS_TransformProjTex;
        PixelShader = compile ps_3_0 PS_TexturedEight();
    }
}

technique drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkinProjTex;
        PixelShader = compile ps_3_0 PS_TexturedEight();
    }
}

technique unlit_draw
{
    pass p0
    {
        VertexShader = VS_TransformUnlitVehicleDamage;
        PixelShader = compile ps_3_0 PS_TexturedUnlit();
    }
}

technique unlit_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkinUnlitProjTex;
        PixelShader = compile ps_3_0 PS_TexturedUnlit();
    }
}

technique deferred_draw
{
    pass p0
    {
        ColorWriteEnable = RED | GREEN | BLUE;
        ColorWriteEnable1 = RED | GREEN | BLUE;
        ColorWriteEnable2 = RED | GREEN;
        ColorWriteEnable3 = RED | GREEN | BLUE | ALPHA;

        VertexShader = VS_TransformDProjTex;
        PixelShader = compile ps_3_0 PS_DeferredTextured();
    }
}

technique deferredalphaclip_draw
{
    pass p0
    {
        ColorWriteEnable = RED | GREEN | BLUE;
        ColorWriteEnable1 = RED | GREEN | BLUE;
        ColorWriteEnable2 = RED | GREEN;
        ColorWriteEnable3 = RED | GREEN | BLUE | ALPHA;

        VertexShader = VS_TransformAlphaClipDProjTex;
        PixelShader = compile ps_3_0 PS_DeferredTexturedAlphaClip();
    }
}

technique deferred_drawskinned
{
    pass p0
    {
        ColorWriteEnable = RED | GREEN | BLUE;
        ColorWriteEnable1 = RED | GREEN | BLUE;
        ColorWriteEnable2 = RED | GREEN;
        ColorWriteEnable3 = RED | GREEN | BLUE | ALPHA;

        VertexShader = compile vs_3_0 VS_TransformSkinD();
        PixelShader = compile ps_3_0 PS_DeferredTextured();
    }
}

technique deferredalphaclip_drawskinned
{
    pass p0
    {
        ColorWriteEnable = RED | GREEN | BLUE;
        ColorWriteEnable1 = RED | GREEN | BLUE;
        ColorWriteEnable2 = RED | GREEN;
        ColorWriteEnable3 = RED | GREEN | BLUE | ALPHA;

        VertexShader = compile vs_3_0 VS_TransformSkinD();
        PixelShader = compile ps_3_0 PS_DeferredTexturedAlphaClip();
    }
}

technique wd_draw
{
    pass p0
    {
        VertexShader = VS_ShadowDepthProjTex;
        PixelShader = compile ps_3_0 PS_ShadowDepth();
    }
}

technique wd_drawskinned
{
    pass p0
    {
        VertexShader = VS_ShadowDepthSkinProjTex;
        PixelShader = compile ps_3_0 PS_ShadowDepth();
    }
}

technique wd_masked_draw
{
    pass p0
    {
        VertexShader = VS_ShadowDepthProjTex;
        PixelShader = compile ps_3_0 PS_ShadowDepthMasked();
    }
}

technique wd_masked_drawskinned
{
    pass p0
    {
        VertexShader = VS_ShadowDepthSkinProjTex;
        PixelShader = compile ps_3_0 PS_ShadowDepthMasked();
    }
}

technique paraboloid_draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformParaboloid();
        PixelShader = compile ps_3_0 PS_TexturedBasicParaboloid();
    }
}

technique paraboloid_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformParaboloid();
        PixelShader = compile ps_3_0 PS_TexturedBasicParaboloid();
    }
}

technique reflection_draw
{
    pass p0
    {
        VertexShader = VS_TransformProjTex;
        PixelShader = compile ps_3_0 PS_TexturedBasic();
    }
}

technique reflection_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformProjTex;
        PixelShader = compile ps_3_0 PS_TexturedBasic();
    }
}

technique lightweight0_draw
{
    pass p0
    {
        VertexShader = VS_TransformProjTex;
        PixelShader = compile ps_3_0 PS_TexturedZero();
    }
}

technique lightweight0_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformProjTex;
        PixelShader = compile ps_3_0 PS_TexturedZero();
    }
}

technique lightweight4_draw
{
    pass p0
    {
        VertexShader = VS_TransformProjTex;
        PixelShader = compile ps_3_0 PS_TexturedFour();
    }
}

technique lightweight4_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformProjTex;
        PixelShader = compile ps_3_0 PS_TexturedFour();
    }
}

technique draw_inst
{
    pass p0
    {
        CullMode = CW;

        VertexShader = VS_TransformInstProjTex;
        PixelShader = compile ps_3_0 PS_TexturedEightInst();
    }
}

technique unlit_draw_inst
{
    pass p0
    {
        SrcBlend = SRCALPHA;
        DestBlend = INVSRCALPHA;
        CullMode = CW;

        VertexShader =  compile vs_3_0 VS_TransformUnlitInst();
        PixelShader = compile ps_3_0 PS_TexturedUnlit();
    }
}


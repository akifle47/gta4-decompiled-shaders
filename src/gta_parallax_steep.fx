#define DIFFUSE_TEXTURE
#define PARALLAX
#define PARALLAX_STEEP
#define SPECULAR
#define DAY_NIGHT_EFFECTS
#define ALPHA_SHADOW
#define NO_DEFERRED_ALPHA_DITHER
#define DIFFUSE_ALPHA

#include "common.fxh"
#include "megashader.fxh"

technique draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_Transform();
        PixelShader = compile ps_3_0 PS_TexturedEight();
    }
}

technique drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformSkin();
        PixelShader = compile ps_3_0 PS_TexturedEight();
    }
}

technique unlit_draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformUnlit();
        PixelShader = compile ps_3_0 PS_TexturedUnlit();
    }
}

technique unlit_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformSkinUnlit();
        PixelShader = compile ps_3_0 PS_TexturedUnlit();
    }
}

technique deferred_draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformD();
        PixelShader = compile ps_3_0 PS_DeferredTextured();
    }
}

technique deferredalphaclip_draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformAlphaClipD();
        PixelShader = compile ps_3_0 PS_DeferredTexturedAlphaClip();
    }
}

technique deferred_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformSkinD();
        PixelShader = compile ps_3_0 PS_DeferredTextured();
    }
}

technique deferredalphaclip_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformSkinD();
        PixelShader = compile ps_3_0 PS_DeferredTexturedAlphaClip();
    }
}

technique wd_draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_ShadowDepth();
        PixelShader = compile ps_3_0 PS_ShadowDepth();
    }
}

technique wd_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_ShadowDepthSkin();
        PixelShader = compile ps_3_0 PS_ShadowDepth();
    }
}

technique wd_masked_draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_ShadowDepth();
        PixelShader = compile ps_3_0 PS_ShadowDepthMasked();
    }
}

technique wd_masked_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_ShadowDepthSkin();
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
        VertexShader = compile vs_3_0 VS_Transform();
        PixelShader = compile ps_3_0 PS_TexturedBasic();
    }
}

technique reflection_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_Transform();
        PixelShader = compile ps_3_0 PS_TexturedBasic();
    }
}

technique lightweight0_draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_Transform();
        PixelShader = compile ps_3_0 PS_TexturedZero();
    }
}

technique lightweight0_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformSkin();
        PixelShader = compile ps_3_0 PS_TexturedZero();
    }
}

technique lightweight4_draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_Transform();
        PixelShader = compile ps_3_0 PS_TexturedFour();
    }
}

technique lightweight4_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformSkin();
        PixelShader = compile ps_3_0 PS_TexturedFour();
    }
}

technique draw_inst
{
    pass p0
    {
        CullMode = CW;

        VertexShader = compile vs_3_0 VS_TransformInst();
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

        VertexShader = compile vs_3_0 VS_TransformSkinInst();
        PixelShader = compile ps_3_0 PS_TexturedUnlit();
    }
}


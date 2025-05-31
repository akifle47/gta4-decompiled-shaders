#define DRAWBUCKET_ALPHA
#define NO_LUMINANCE_CONSTANTS
#define ANIMATED
#define DIFFUSE_TEXTURE
#define WIRE
#define ALPHA_SHADOW

#include "common.fxh"
#include "megashader.fxh"

float Fade_Thickness : FadeThickness<string UIName = "Thickness of object in metres"; string UIHelp = "Amount of thickness of object"; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.010000;> = 0.070000;
float3 LuminanceConstants : LuminanceConstants = float3(0.212500006, 0.715399981, 0.0720999986);

technique draw
{
    pass p0
    {
        ZWriteEnable = false;

        VertexShader = VS_TransformWire;
        PixelShader = PS_TexturedEightWire;
    }
}

technique drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkinWire;
        PixelShader = PS_TexturedEightWire;
    }
}

technique unlit_draw
{
    pass p0
    {
        ZWriteEnable = false;

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
        VertexShader = VS_TransformDWire;
        PixelShader = compile ps_3_0 PS_DeferredTextured();
    }
}

technique deferredalphaclip_draw
{
    pass p0
    {
        VertexShader = VS_TransformAlphaClipDWire;
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
        VertexShader = VS_TransformWire;
        PixelShader = compile ps_3_0 PS_TexturedBasic();
    }
}

technique reflection_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformWire;
        PixelShader = compile ps_3_0 PS_TexturedBasic();
    }
}

technique imposterdeferred_draw
{
    pass p0
    {
        VertexShader = VS_TransformDWire;
        PixelShader = compile ps_3_0 PS_DeferredImposter();
    }
}

technique imposterdeferred_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_TransformSkinD();
        PixelShader = compile ps_3_0 PS_DeferredImposter();
    }
}

technique lightweight0_draw
{
    pass p0
    {
        ZWriteEnable = false;

        VertexShader = VS_TransformWire;
        PixelShader = PS_TexturedZeroWire;
    }
}

technique lightweight0_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkinWire;
        PixelShader = PS_TexturedZeroWire;
    }
}

technique lightweight4_draw
{
    pass p0
    {
        ZWriteEnable = false;

        VertexShader = VS_TransformWire;
        PixelShader = PS_TexturedFourWire;
    }
}

technique lightweight4_drawskinned
{
    pass p0
    {
        VertexShader = VS_TransformSkinWire;
        PixelShader = PS_TexturedFourWire;
    }
}

technique draw_inst
{
    pass p0
    {
        ZWriteEnable = false;
        CullMode = CW;

        VertexShader = compile vs_3_0 VS_TransformInst();
        PixelShader = PS_TexturedEightInstWire;
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

        VertexShader = compile vs_3_0 VS_TransformSkinInst();
        PixelShader = compile ps_3_0 PS_TexturedUnlit();
    }
}


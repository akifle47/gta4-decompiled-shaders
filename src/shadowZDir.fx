#define NO_LUMINANCE_CONSTANTS
#include "common.fxh"
#include "megashader.fxh"

//Pixel shaders
PixelShader PixelShader0 = NULL;

technique wd_draw
{
    pass p0
    {
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ShadowDepth();
        PixelShader = compile ps_3_0 PS_ShadowDepth();
    }
}

technique wd_drawskinned
{
    pass p0
    {
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ShadowDepthSkin();
        PixelShader = compile ps_3_0 PS_ShadowDepth();
    }
}

technique wd_masked_draw
{
    pass p0
    {
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ShadowDepth();
        PixelShader = compile ps_3_0 PS_ShadowDepthMasked();
    }
}

technique wd_masked_drawskinned
{
    pass p0
    {
        AlphaBlendEnable = false;
        AlphaTestEnable = false;

        VertexShader = compile vs_3_0 VS_ShadowDepthSkin();
        PixelShader = compile ps_3_0 PS_ShadowDepthMasked();
    }
}


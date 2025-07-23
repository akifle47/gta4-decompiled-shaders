#define DRAWBUCKET_DECAL
#define DIFFUSE_TEXTURE
#define SPECULAR
#define SPECULAR_MAP
#define NORMAL_MAP
#define HAIR_SORTED
#include "common_ped.fxh"
#include "megashader_ped.fxh"

//Pixel shaders
PixelShader PixelShader0 = NULL;

technique wd_draw
{
    pass p0
    {
        CullMode = CW;

        VertexShader = compile vs_3_0 VS_ShadowDepthPed();
        PixelShader = compile ps_3_0 PS_ShadowDepthPed();
    }
}

technique wd_drawskinned
{
    pass p0
    {
        CullMode = CW;

        VertexShader =  compile vs_3_0 VS_ShadowDepthSkinPed();
        PixelShader = compile ps_3_0 PS_ShadowDepthPed();
    }
}

technique draw
{
    pass p0
    {
        AlphaBlendEnable = false;
        AlphaTestEnable = false;
        ZWriteEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransform();
        PixelShader = compile ps_3_0 PS_PedTexturedEight();
    }
}

technique unlit_draw
{
    pass p0
    {
        AlphaRef = 0x64;
        AlphaBlendEnable = true;
        AlphaTestEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransform();
        PixelShader = compile ps_3_0 PS_PedTexturedZero();
    }
}

technique lightweight0_draw
{
    pass p0
    {
        AlphaRef = 0x64;
        AlphaBlendEnable = true;
        AlphaTestEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransform();
        PixelShader = compile ps_3_0 PS_PedTexturedZero();
    }
}

technique lightweight4_draw
{
    pass p0
    {
        AlphaRef = 0x64;
        AlphaBlendEnable = true;
        AlphaTestEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransform();
        PixelShader = compile ps_3_0 PS_PedTexturedFour();
    }
}

technique drawskinned
{
    pass p0
    {
        AlphaBlendEnable = false;
        AlphaTestEnable = false;
        ZWriteEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransformSkin();
        PixelShader = compile ps_3_0 PS_PedTexturedEight();
    }
}

technique unlit_drawskinned
{
    pass p0
    {
        AlphaTestEnable = true;
        AlphaRef = 0x64;
        AlphaBlendEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransformSkin();
        PixelShader = compile ps_3_0 PS_PedTexturedZero();
    }
}

technique lightweight0_drawskinned
{
    pass p0
    {
        AlphaTestEnable = true;
        AlphaRef = 0x64;
        AlphaBlendEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransformSkin();
        PixelShader = compile ps_3_0 PS_PedTexturedZero();
    }
}

technique lightweight4_drawskinned
{
    pass p0
    {
        AlphaTestEnable = true;
        AlphaRef = 0x64;
        AlphaBlendEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransformSkin();
        PixelShader = compile ps_3_0 PS_PedTexturedFour();
    }
}

technique deferred_draw
{
    pass p0
    {
        ZWriteEnable = true;
        ColorWriteEnable = RED | GREEN | BLUE;
        ColorWriteEnable1 = RED | GREEN | BLUE;
        ColorWriteEnable2 = RED | GREEN | BLUE;
        ColorWriteEnable3 = RED | GREEN | BLUE | ALPHA;

        VertexShader = compile vs_3_0 VS_PedTransformD();
        PixelShader = compile ps_3_0 PS_DeferredPedTextured();
    }
}

technique deferred_drawskinned
{
    pass p0
    {
        CullMode = NONE;
        ZWriteEnable = true;
        ColorWriteEnable = RED | GREEN | BLUE;
        ColorWriteEnable1 = RED | GREEN | BLUE;
        ColorWriteEnable2 = RED | GREEN | BLUE;
        ColorWriteEnable3 = RED | GREEN | BLUE | ALPHA;

        VertexShader = compile vs_3_0 VS_PedTransformSkinD();
        PixelShader = compile ps_3_0 PS_DeferredPedTextured();
    }
}


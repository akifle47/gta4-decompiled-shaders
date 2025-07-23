#define DIFFUSE_TEXTURE
#define NORMAL_MAP
#define SPECULAR_MAP
#define SPECULAR
#define PED_BONE_DAMAGE
#define SUBSURFACE_SCATTERING
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
        AlphaRef = 0x64;
        AlphaBlendEnable = true;
        AlphaTestEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransform();
        PixelShader = compile ps_3_0 PS_PedTexturedEight();
    }
}

technique drawskinned
{
    pass p0
    {
        AlphaRef = 0x64;
        AlphaBlendEnable = true;
        AlphaTestEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransformSkin();
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

technique unlit_drawskinned
{
    pass p0
    {
        AlphaRef = 0x64;
        AlphaBlendEnable = true;
        AlphaTestEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransformSkin();
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

technique lightweight0_drawskinned
{
    pass p0
    {
        AlphaRef = 0x64;
        AlphaBlendEnable = true;
        AlphaTestEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransformSkin();
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

technique lightweight4_drawskinned
{
    pass p0
    {
        AlphaRef = 0x64;
        AlphaBlendEnable = true;
        AlphaTestEnable = true;

        VertexShader = compile vs_3_0 VS_PedTransformSkin();
        PixelShader = compile ps_3_0 PS_PedTexturedFour();
    }
}

technique deferred_draw
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_PedTransformD();
        PixelShader = compile ps_3_0 PS_DeferredPedTextured();
    }
}

technique deferred_drawskinned
{
    pass p0
    {
        VertexShader = compile vs_3_0 VS_PedTransformSkinD();
        PixelShader = compile ps_3_0 PS_DeferredPedTextured();
    }
}


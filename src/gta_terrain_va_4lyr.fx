#define NO_SHADOW_CASTING
#define TERRAIN_4LYR
#include "megashader_terrain.fxh"

//Pixel shaders
PixelShader PixelShader0 = NULL;

technique draw
{
    pass p0
    {
        AlphaBlendEnable = true;

        VertexShader = compile vs_3_0 VS_TransformPass0();
        PixelShader = compile ps_3_0 PS_TexturedPass0();
    }
    pass p1
    {
        AlphaBlendEnable = true;

        VertexShader = compile vs_3_0 VS_TransformPass1();
        PixelShader = compile ps_3_0 PS_TexturedPass1();
    }
    pass p2
    {
        AlphaBlendEnable = true;

        VertexShader = compile vs_3_0 VS_TransformPass2();
        PixelShader = compile ps_3_0 PS_TexturedPass2();
    }
    pass p3
    {
        AlphaBlendEnable = true;

        VertexShader = compile vs_3_0 VS_TransformPass3();
        PixelShader = compile ps_3_0 PS_TexturedPass3();
    }
}

technique deferred_draw
{
    pass p0
    {
        StencilRef = 4;

        VertexShader = compile vs_3_0 VS_TransformDeferredC();
        PixelShader = compile ps_3_0 PS_TexturedDeferredC();
    }
}


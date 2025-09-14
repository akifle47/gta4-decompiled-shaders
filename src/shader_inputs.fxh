//todo put every shader struct here?

struct VS_InputSkin
{
    float3 Position     : POSITION;
    float4 BlendWeights : BLENDWEIGHT;
    float4 BlendIndices : BLENDINDICES;
    float2 TexCoord     : TEXCOORD0;
    float3 Normal       : NORMAL;
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float4 Tangent      : TANGENT; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color        : COLOR0;
};

struct PS_OutputDeferred
{
    float4 Diffuse       : COLOR0;
    float4 Normal        : COLOR1;
    //intensity and power/glossiness
    float4 SpecularAndAO : COLOR2;
    float4 Stencil       : COLOR3;
};
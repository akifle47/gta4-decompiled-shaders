#include "megashader_todo.fxh"
#include "common_functions.fxh"
#include "common_shadow.fxh"

struct VS_InputUnlitVehicle
{
    float3 Position : POSITION;
    float4 Color    : COLOR;
    float2 TexCoord : TEXCOORD0;
};

struct VS_OutputUnlitVehicle
{
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
    float4 Color    : COLOR;
};

VS_OutputUnlitVehicle VS_VehicleTransformUnlit(VS_InputUnlitVehicle IN)
{
    VS_OutputUnlitVehicle OUT;

    OUT.Position = mul(float4(IN.Position, 1.0), gWorldViewProj);
    OUT.TexCoord = IN.TexCoord;
    OUT.Color = IN.Color;
    return OUT;
}
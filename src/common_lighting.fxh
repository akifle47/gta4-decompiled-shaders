//by ParallelLines
float3 ComputeDepthEffects(in float noSkyMask, in float3 color, in float linearDepth)
{
    float colorFactor = 1.0 - saturate((gDepthFxParams.w - linearDepth) / (gDepthFxParams.w - gDepthFxParams.z));
    colorFactor *= noSkyMask;

    float saturation = colorFactor * (gDepthFxParams.x - 1.0) + 1.0;
    float gamma = colorFactor * (gDepthFxParams.y - 1.0);
    float luminance = dot(color, float3(0.2125, 0.7154, 0.0721));

    color = lerp(luminance, color, saturation) * pow(abs(luminance + 0.0000001), gamma);

    float fogCameraToStartFactor = saturate(linearDepth / globalFogParams.x);
    float fogStartToEndFactor = saturate((linearDepth - globalFogParams.x) / (globalFogParams.y - globalFogParams.x));
    float fogFactor = lerp(fogStartToEndFactor, fogCameraToStartFactor, globalFogParams.w) + globalFogParams.z;
    fogFactor *= noSkyMask;

    float3 fogColor = lerp(globalFogColorN.xyz, globalFogColor.xyz, fogStartToEndFactor);

    float skyFogFactor = (1.0 - noSkyMask) * globalFogParams.w;
    color = lerp(color, globalFogColorN.xyz, skyFogFactor); // sky pixels are affected when "fog density" > 0.0
    return lerp(color, fogColor, fogFactor);
}

#ifndef NO_LIGHTING
    struct SurfaceProperties
    {
        float3 Diffuse;
        float3 Normal;
        float  SpecularIntensity;
        float  SpecularPower;
        float  AmbientOcclusion;
    };

    struct ForwardLights
    {
        float4 PositionsX; 
        float4 PositionsY; 
        float4 PositionsZ;
        float4 DirectionsX; 
        float4 DirectionsY; 
        float4 DirectionsZ;
        float4 ColorsR; 
        float4 ColorsG; 
        float4 ColorsB;
        float4 InvSqrRadiuses;
        float4 ConeScales;
        float4 ConeOffsets;
    };

    void ComputeForwardLocalLighting(in ForwardLights lights, in SurfaceProperties surfProperties, in float3 posWorld, in float3 reflectDir, out float3 diffuseLight, out float3 specularLight)
    {
        float4 fragToLightDirsX = lights.PositionsX - posWorld.x;
        float4 fragToLightDirsY = lights.PositionsY - posWorld.y;
        float4 fragToLightDirsZ = lights.PositionsZ - posWorld.z;

        float4 fragToLightDirsLengths = (fragToLightDirsX * fragToLightDirsX) +
                                              (fragToLightDirsY * fragToLightDirsY) +
                                              (fragToLightDirsZ * fragToLightDirsZ) + 0.00001;
        
        float4 distAttenuations = max(0.0, 1.0 - (fragToLightDirsLengths * lights.InvSqrRadiuses));
        distAttenuations = pow(distAttenuations, 4) - 0.1;
        distAttenuations = distAttenuations >= 0.0 ? distAttenuations * 1.11111116 : 0;
        
        fragToLightDirsLengths = rsqrt(fragToLightDirsLengths);

        float4 nDotLs = (fragToLightDirsX * surfProperties.Normal.x) +
                        (fragToLightDirsY * surfProperties.Normal.y) +
                        (fragToLightDirsZ * surfProperties.Normal.z);
        distAttenuations = saturate(nDotLs * distAttenuations * fragToLightDirsLengths);

        float4 coneAttenuations = (fragToLightDirsX * -lights.DirectionsX) +
                                  (fragToLightDirsY * -lights.DirectionsY) +
                                  (fragToLightDirsZ * -lights.DirectionsZ);
        coneAttenuations *= fragToLightDirsLengths;
        coneAttenuations = saturate(coneAttenuations * lights.ConeScales + lights.ConeOffsets);

        float4 attenuations = distAttenuations * coneAttenuations;
        
        #ifdef SPECULAR
            float specPower = surfProperties.SpecularPower * 0.25;

            float4 lightDirsDotR = (reflectDir.x * fragToLightDirsX) + 
                                   (reflectDir.y * fragToLightDirsY) + 
                                   (reflectDir.z * fragToLightDirsZ);
            lightDirsDotR *= fragToLightDirsLengths;

            float4 specularLights = log(abs(lightDirsDotR)) * specPower;
            specularLights = exp(specularLights) * attenuations;

            specularLight = float3(dot(lights.ColorsR, specularLights), dot(lights.ColorsG, specularLights), dot(lights.ColorsB, specularLights));
        #else
            specularLight = float3(0, 0, 0);
        #endif //SPECULAR

        diffuseLight = float3(dot(lights.ColorsR, attenuations), dot(lights.ColorsG, attenuations), dot(lights.ColorsB, attenuations));
    }

    float3 ComputeLighting(in int numLights, in bool shadowed, in float3 posWorld, in float3 fragToViewDir, in SurfaceProperties surfProperties)
    {
        #if numLights != 0 && numLights != 4 && numLights != 8
            #error numLights must be 0, 4 or 8.
        #endif

        float shadow = 1;
        if(shadowed)
            shadow = ComputeDirectionalShadow(posWorld);

        float3 normal = surfProperties.Normal;
        float3 directionalColor = gDirectionalColour.xyz * gDirectionalColour.w;

        bool enableSpecular = shadowed;
        #if defined(SPECULAR) && !defined(DEFERRED_LIGHTING)
            enableSpecular = true;
        #endif //SPECULAR && !DEFERRED_LIGHTING

        float3 R = reflect(fragToViewDir, normal);
        float3 specularLight = 0;
        if(enableSpecular)
        {
            #if defined(SPECULAR) || defined(DEFERRED_LIGHTING)
                specularLight = saturate(dot(-gDirectionalLight.xyz, R)).xxx + 0.00001;
                specularLight = pow(specularLight, surfProperties.SpecularPower + 0.00001);
                specularLight *= directionalColor * shadow;
                #ifdef DEFERRED_LIGHTING
                    specularLight *= (gDirectionalLight.w * 2);
                #else
                    specularLight *= gDirectionalLight.w;
                #endif //DEFERRED_LIGHTING
            #endif //SPECULAR
        }

        #ifdef DEFERRED_LIGHTING
            float rimLighting = pow(1.0 - abs(dot(-fragToViewDir, normal)), 4) * 0.75 + 0.25;

            float dist = distance(posWorld, gViewInverse[3].xyz);
            float3 v3 = fragToViewDir * saturate(dist / 50) + R;
            v3 = normalize(v3 + 0.00001);
            float parabReflDistanceFade = 1.0 - saturate(dist / 100);
            float parabReflVerticalFade = saturate(v3.z * 5);

            float v4 = (saturate(v3.z) + 1) * 2;
            float2 parabReflCoords = (v3.xy / v4) + 0.5;
            float parabReflMip = surfProperties.SpecularPower * dReflectionParams.x;
            parabReflMip = parabReflMip * -4 + 4;
            float3 parabRefl = tex2Dlod(ParabSampler, float4(1 - parabReflCoords, 0, parabReflMip)).xyz;
            parabRefl = parabRefl * parabReflDistanceFade * parabReflVerticalFade * surfProperties.AmbientOcclusion * globalScalars.w * rimLighting * 10;
            
            specularLight += parabRefl;
        #endif //DEFERRED_LIGHTING
        
        float3 ambientLight = gLightAmbient1.xyz * saturate(normal.z * -0.5 + 0.5) + gLightAmbient0.xyz;
        #ifndef DIRT_DECAL_MASK
            ambientLight *= surfProperties.AmbientOcclusion;
        #endif //!DIRT_DECAL_MASK

        float nDotL = dot(-gDirectionalLight.xyz, normal);
        nDotL = saturate((nDotL - 0.25) * 1.33333337);
        float3 diffuseLight = (directionalColor * nDotL * shadow) + ambientLight;

        if(numLights > 0)
        {
            ForwardLights lights;
            lights.PositionsX = gLightPosX;
            lights.PositionsY = gLightPosY;
            lights.PositionsZ = gLightPosZ;
            lights.DirectionsX = gLightDirX;
            lights.DirectionsY = gLightDirY;
            lights.DirectionsZ = gLightDirZ;
            lights.ColorsR = gLightColR;
            lights.ColorsG = gLightColG;
            lights.ColorsB = gLightColB;
            lights.InvSqrRadiuses = gLightFallOff;
            lights.ConeScales = gLightConeScale;
            lights.ConeOffsets = gLightConeOffset;
            float3 lightsDiffuse;
            float3 lightsSpecular;
            ComputeForwardLocalLighting(lights, surfProperties, posWorld, R, lightsDiffuse, lightsSpecular);

            diffuseLight += lightsDiffuse;
            specularLight += lightsSpecular;

            if(numLights == 8)
            {
                lights.PositionsX = gLightPointPosX;
                lights.PositionsY = gLightPointPosY;
                lights.PositionsZ = gLightPointPosZ;
                lights.DirectionsX = gLightDir2X;
                lights.DirectionsY = gLightDir2Y;
                lights.DirectionsZ = gLightDir2Z;
                lights.ColorsR = gLightPointColR;
                lights.ColorsG = gLightPointColG;
                lights.ColorsB = gLightPointColB;
                lights.InvSqrRadiuses = gLightPointFallOff;
                lights.ConeScales = gLightConeScale2;
                lights.ConeOffsets = gLightConeOffset2;
                ComputeForwardLocalLighting(lights, surfProperties, posWorld, R, lightsDiffuse, lightsSpecular);

                diffuseLight += lightsDiffuse;
                specularLight += lightsSpecular;
            }
        }

        specularLight *= surfProperties.SpecularIntensity;

        return surfProperties.Diffuse * diffuseLight + specularLight;
    }
#endif //NO_LIGHTING
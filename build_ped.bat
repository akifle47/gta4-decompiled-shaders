::builds the ped shaders
@echo off

fxdc /Out src/gta_ped.fx bin/
fxdc /Out src/gta_ped_reflect.fx bin/
fxdc /Out src/gta_ped_skin_blendshape.fx bin/
fxdc /Out src/gta_ped_skin.fx bin/
fxdc /Out src/gta_hair_sorted_alpha.fx bin/
fxdc /Out src/gta_hair_sorted_alpha_exp.fx bin/

pause
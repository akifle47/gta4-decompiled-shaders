::builds the vehicle shaders
@echo off

fxdc /Out src/gta_vehicle_vehglass.fx bin/
fxdc /Out src/gta_vehicle_lightsemissive.fx bin/
fxdc /Out src/gta_vehicle_tire.fx bin/
fxdc /Out src/gta_vehicle_badges.fx bin/
fxdc /Out src/gta_vehicle_paint1.fx bin/
fxdc /Out src/gta_vehicle_paint2.fx bin/
fxdc /Out src/gta_vehicle_paint3.fx bin/
fxdc /Out src/gta_vehicle_basic.fx bin/
fxdc /Out src/gta_vehicle_chrome.fx bin/
fxdc /Out src/gta_vehicle_disc.fx bin/
fxdc /Out src/gta_vehicle_generic.fx bin/
fxdc /Out src/gta_vehicle_interior.fx bin/
fxdc /Out src/gta_vehicle_interior2.fx bin/
fxdc /Out src/gta_vehicle_mesh.fx bin/
fxdc /Out src/gta_vehicle_rims1.fx bin/
fxdc /Out src/gta_vehicle_rims2.fx bin/
fxdc /Out src/gta_vehicle_rubber.fx bin/
fxdc /Out src/gta_vehicle_shuts.fx bin/

pause
::builds all shaders
@echo off

    for /R "src\" %%f in (*.fx) do (
        fxdc /Out %%f bin/
    )
    
pause
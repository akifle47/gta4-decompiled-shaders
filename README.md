This is a project with the goal of translating every shader in GTA4 to HLSL.\
Ideally it would compile to the exact same instructions as the original shaders. However 1) that is impossible due to the original shaders being compiled on a version of fxc that is no longer available and 2) it would be incredibly tedious and annoying. So we opt instead for eyeballing if the screen output looks the same.

Currently about 86% of all shaders are translated, with the most notable ones remaining being:
- Quite a few of the deferred_lighting shaders.
- Most of the rage_postfx shaders.
- All of the:
  - sky shaders,
  - particle shaders,
  - water shaders,
  - and some immediate mode shaders.

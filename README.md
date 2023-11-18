# SceneChanger-PhantomCamera2d
Background loading and pCamera in action


Well this repo runs without any crashes. 

In my main project im still debugging, but im on the right direction. 
Something is wrong within the tutorial scene.. i have 3 more nodes to add and ill find what is causing the crash.

Finally i found the bug, it was an extra camera inside one of my old systems that was interfering with the rest of the phantom Cameras on the game causing a crash that was not giving enough debuggin information when exporting the game without debug.

# Hydrix-Laptop
```Practice Laptop For QBCore! This Is NP Inspired NOW VERSION 2! ```

# Dependencies 
 ``` [hacking] ``` 
 
 # Version 1 Includes
 ```If laptop in inventory and uses /practicelaptop can practice the hack according to the settings in the config!```
 
  # Version 2 Includes
 ```Complete Rework Of Code And fixed Create Usable Item function to no longer utilize a command to use practice laptop. Also added qb-menu and qb-input support for player in city to set their own custom hack times to fit thier progression and experience difficulty. also cleaned all the code,  optimized callbacks , removed unused functions, replaced with operable and proper calls / net events.```
 
 # WIP
 ``` Make item usable to do the what the commands initialises. ```

# QBCore Shared Items.Lua
```
    ["practicelaptop"] = {
        ["name"] = "practicelaptop",
        ["label"] = "Practice Laptop",
        ["weight"] = 2500,
        ["type"] = "item",
        ["image"] = "practicelaptop.png",
        ["unique"] = true,
        ["useable"] = true,
        ["shouldClose"] = true,
        ["combinable"] = nil,
        ["description"] = "Nice Gold Laptop?"
    },
```

# Drag And Drop
``` Hacking And Laptop should be drag and drop after you put in the shared item! Enjoy and Happy Hacking! ```
 
 # Preview
``` Fail: ```
 https://streamable.com/te5hlc
``` Success: ```
 https://streamable.com/z2fjh1 
 
 # Snippet Example for Implementation in QB-Bank Robbery
    exports['hacking']:OpenHackingGame(Config.FleecaTime, Config.FleecaBlocks, Config.FleecaRepeat, 
         function(Success)
              if Success then
                  TriggerServerEvent('qb-bankrobbery:server:setBankState', closestBank, true)
              else
                  QBCore.Functions.Notify("You Failed To Hack The Bank!", "error")
             end
       end) 

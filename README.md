# Hydrix-Laptop
```Practice Laptop For QBCore! This Is NP Inspired and only version 1.0 , So More to Come. Alot of Configs for difficulty and Qb Menu exports / looking to utilize maybe input for a custom option that will let the person pick a number 1 - 20 on three prompts from custom time , blocks and success hacks in a row.. and soon OX-Core hybrid! ```

# Dependencies 
 ``` [hacking] ``` 
 
 # Version 1 Includes
 ```If laptop in inventory and uses /practicelaptop can practice the hack according to the settings in the config!```
 
 # WIP
 ``` Make item usable to do the what the commands initialises. ```

# QBCore Shared Items.Lua
``` ["practicelaptop"] 		  = {["name"] = "practicelaptop",   	["label"] = "Practice Laptop",	 		["weight"] = 2500, 		["type"] = "item", 		["image"] = "practicelaptop.png", 		["unique"] = true, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "Nice Gold Laptop?"}, ```

# Drag And Drop
``` Hacking And Laptop should be drag and drop after you put in the shared item! Enjoy and Happy Hacking! ```
 
 # Preview
``` Fail: ```
 https://streamable.com/te5hlc
``` Pass: ```
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

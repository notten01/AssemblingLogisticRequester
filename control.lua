-- storage
global.assembling_machines_recipes = {}
global.assembling_machines_chests = {}
global.assembling_machine_active_requests = {}


-- functions
local function createBuilder( entity )
    local ins20 = entity.surface.create_entity{name="assembling-provider", position={(entity.position.x)+1,(entity.position.y)-0.8}, force=entity.force}
    ins20.destructible = false

    local ins21 = entity.surface.create_entity{name="assembling-requester", position={(entity.position.x)-0.8,(entity.position.y)-0.8}, force=entity.force}
    ins21.destructible = false

    local ins22 = entity.surface.create_entity{name="invisible-inserter", position={(entity.position.x)-1.5,(entity.position.y)}, force=entity.force}
    ins22.destructible = false
    ins22.minable = false

    local ins23 = entity.surface.create_entity{name="invisible-inserter-2", position={(entity.position.x)+0.5,(entity.position.y)}, force=entity.force}
    ins23.destructible = false
    ins23.minable = false

    local ins24 = entity.surface.create_entity{name="invisible-substation", position={(entity.position.x),(entity.position.y)}, force=entity.force}
    ins24.destructible = false
    ins24.minable = false

    chestContext = {inChest = ins21, outChest = ins20}
    global.assembling_machines_chests[entity.unit_number] = chestContext
    return true
end

local function cleanup(entity)
    if (entity.name == "logistic-assembling-machine" or entity.name == "logistic-chemical-plant") then
        center = entity.position
        entities = entity.surface.find_entities_filtered{area = {{center.x-1.2, center.y-1.2}, {center.x+1.2, center.y+1.2}}}
        for _, ent in pairs(entities) do
            if ent.name == "invisible-inserter" or ent.name == "invisible-inserter-2" or ent.name == "invisible-substation" then
                -- just a 'normal' cheat entity we can remove
                ent.destroy()
            elseif ent.name == "assembling-provider" or ent.name == "assembling-requester" then
                -- a cheat entity with a inventory, spill all the possible content and then delete it
                local inventory = ent.get_inventory(defines.inventory.chest)
                for itemName, itemCount in pairs(inventory.get_contents()) do
                    ent.surface.spill_item_stack(center, {name = itemName, count = itemCount}, false, ent.force, false)
                end
                ent.destroy()
            end
        end
        global.assembling_machines_chests[entity.unit_number] = nil
        global.assembling_machines_recipes[entity.unit_number] = nil
        global.assembling_machine_active_requests[entity.unit_number] = nil
    end
end

local function setRequester(entity, recipe)
    local chestContext = global.assembling_machines_chests[entity.unit_number]
    local currentRequest = global.assembling_machine_active_requests[entity.unit_number]
    local inChest = chestContext["inChest"]
    local outChest = chestContext["outChest"]

    if (currentRequest ~= nil) then
        --chest is currently handing a request, we need to clean that out
        for i=currentRequest,1,-1 do
            inChest.clear_request_slot(i)
        end
        --move whatever is in the in chest to the out chest
        local inInventory = inChest.get_inventory(defines.inventory.chest)
        local outInventory = outChest.get_inventory(defines.inventory.chest)
        for itemName, itemCount in pairs(inInventory.get_contents()) do
            outInventory.insert({name = itemName, count = itemCount})
        end
        inInventory.clear()
    end

    local index = 1
    for _, ingredient in pairs(recipe.ingredients) do
        if ingredient.type == "item" then
            inChest.set_request_slot({name = ingredient.name, count = ingredient.amount}, index)
            index = index + 1
        end
    end
    global.assembling_machine_active_requests[entity.unit_number] = index
end

--events

script.on_event(defines.events.on_built_entity, function(event)
    if (event.created_entity.name == "logistic-assembling-machine" or event.created_entity.name == "logistic-chemical-plant" or event.created_entity.name == "logistic-workshop") then
        createBuilder( event.created_entity ) 
    end	  
end)

script.on_event(defines.events.on_robot_built_entity, function(event)
    if (event.created_entity.name == "logistic-assembling-machine" or event.created_entity.name == "logistic-chemical-plant" or event.created_entity.name == "logistic-workshop") then
        createBuilder( event.created_entity ) 
    end	  
end)

script.on_event(defines.events.script_raised_revive, function(event)
  local entity = event.entity or event.created_entity
  if (entity.name == "logistic-assembling-machine" or entity.name == "logistic-chemical-plant" or entity.name == "logistic-workshop") then
    createBuilder(entity)
  end
end)

script.on_event(defines.events.script_raised_built, function(event)
  local entity = event.entity or event.created_entity
  if (entity.name == "logistic-assembling-machine" or entity.name == "logistic-chemical-plant" or entity.name == "logistic-workshop") then
    createBuilder(entity)
  end
end)

script.on_event(defines.events.on_player_mined_entity, function(event)
    cleanup(event.entity)
end)

script.on_event(defines.events.on_robot_mined_entity, function(event)
    cleanup(event.entity)
end)
  
script.on_event(defines.events.on_entity_died, function(event)
    cleanup(event.entity)
end)

script.on_event(defines.events.on_player_created, function(event)
    if game.active_mods["BraveNewWorkshop"] then
        local player = game.players[event.player_index]
        local player_inventory = player.get_main_inventory()
        player_inventory.insert{name = "logistic-workshop", count = 1}
    end

    if game.active_mods["brave-new-world"] then
        local player = game.players[event.player_index]
        local player_inventory = player.get_main_inventory()
        player_inventory.insert{name = "logistic-assembling-machine", count = 2}
    end
end)

script.on_event(defines.events.on_gui_closed, function(event)
    local player = game.players[event.player_index]
    local entity = event.entity
    if (entity ~= nil) then
        if (entity.name == "logistic-assembling-machine" or entity.name == "logistic-chemical-plant" or entity.name == "logistic-workshop") then
            game.print("running requester logic" .. entity.name)
            local recipe = entity.get_recipe()
            local cachedRecipe = global.assembling_machines_recipes[entity.unit_number]
            if recipe == nil then
                if cachedRecipe ~= nil then
                    global.assembling_machines_recipes[entity.unit_number] = nil
                end
                return
            end

            if cachedRecipe == nil then
                global.assembling_machines_recipes[entity.unit_number] = recipe
                setRequester(entity, recipe)
            else
                if cachedRecipe ~= recipe then
                    setRequester(entity, recipe)
                    global.assembling_machines_recipes[entity.unit_number] = recipe
                end
            end
        end
    end
end)
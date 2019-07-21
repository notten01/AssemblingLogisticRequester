require("prototypes.item")

data:extend(
{
--- technology
{
    type = "technology",
    name = "logistic-assembling-machine",
    icon_size = 128,
    icon = "__base__/graphics/technology/automation.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "logistic-assembling-machine"
      },
	  {
        type = "unlock-recipe",
        recipe = "logistic-chemical-plant"
      }
    },
    prerequisites = {"automation-3"},
    unit =
    {
      count = 75,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 60
    },
    order = "a-b-c"
  },
--- logistic-assembling-machine
{
    type = "assembling-machine",
    name = "logistic-assembling-machine",
    icon = "__base__/graphics/icons/assembling-machine-3.png",
    icon_size = 32,
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "logistic-assembling-machine"},
    max_health = 400,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(-3, -12),
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 2} }},
        secondary_draw_orders = { north = -1 }
      },
      off_when_no_fluid_recipe = true
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t3-1.ogg",
          volume = 0.8
        },
        {
          filename = "__base__/sound/assembling-machine-t3-2.ogg",
          volume = 0.8
        },
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 1.5,
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, 0	}, {1.5, 1.5}},
    drawing_box = {{-1.5, -1.7}, {1.5, 1.5}},
    fast_replaceable_group = "assembling-machine",
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3.png",
          priority = "high",
          width = 108,
          height = 119,
          frame_count = 32,
          line_length = 8,
          shift = util.by_pixel(0, -0.5),
          hr_version = {
            filename = "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3.png",
            priority = "high",
            width = 214,
            height = 237,
            frame_count = 32,
            line_length = 8,
            shift = util.by_pixel(0, -0.75),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-shadow.png",
          priority = "high",
          width = 130,
          height = 82,
          frame_count = 32,
          line_length = 8,
          draw_as_shadow = true,
          shift = util.by_pixel(28, 4),
          hr_version = {
            filename = "__base__/graphics/entity/assembling-machine-3/hr-assembling-machine-3-shadow.png",
            priority = "high",
            width = 260,
            height = 162,
            frame_count = 32,
            line_length = 8,
            draw_as_shadow = true,
            shift = util.by_pixel(28, 4),
            scale = 0.5
          }
        },
      },
    },
    crafting_categories = {"crafting", "advanced-crafting", "crafting-with-fluid"},
    crafting_speed = 1.25,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions = 0.03 / 3.5
    },
    energy_usage = "210kW",
    ingredient_count = 6,
    module_specification =
    {
      module_slots = 4
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"}
  },

  --- invisible-inserter
{
    type = "inserter",
    name = "invisible-inserter",
    icon = "__base__/graphics/icons/stack-inserter.png",
    icon_size = 32,
    stack = true,
    minable =
    {
      hardness = 0.2,
      mining_time = 0.5,
      result = "invisible-inserter"
    },
    max_health = 160,
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
    selection_box = {{0,0}, {0,0}},
    pickup_position = {0, -1},
    insert_position = {0, 1.2},
    energy_per_movement = "20KW",
    energy_per_rotation = "20KW",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      drain = "0.1kW"
    },
    extension_speed = 0.5,
    rotation_speed = 0.5,
    hand_base_picture =
    {
      filename = "__base__/graphics/entity/stack-inserter/stack-inserter-hand-base.png",
      priority = "extra-high",
      width = 1,
      height = 1,
     
    },
    hand_closed_picture =
    {
      filename = "__base__/graphics/entity/stack-inserter/stack-inserter-hand-closed.png",
      priority = "extra-high",
      width = 1,
      height = 1,
      
    },
    hand_open_picture =
    {
      filename = "__base__/graphics/entity/stack-inserter/stack-inserter-hand-open.png",
      priority = "extra-high",
      width = 1,
      height = 1,
     
    },
    hand_base_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-base-shadow.png",
      priority = "extra-high",
      width = 1,
      height = 1,
      
    },
    hand_closed_shadow =
    {
      filename = "__base__/graphics/entity/stack-inserter/stack-inserter-hand-closed-shadow.png",
      priority = "extra-high",
      width = 1,
      height = 1,
      
    },
    hand_open_shadow =
    {
      filename = "__base__/graphics/entity/stack-inserter/stack-inserter-hand-open-shadow.png",
      priority = "extra-high",
      width = 1,
      height = 1,
      
    },
    platform_picture =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/stack-inserter/stack-inserter-platform.png",
        priority = "extra-high",
        width = 1,
        height = 1,        
      }
    },
  },
  {
    type = "inserter",
    name = "invisible-inserter-2",
    icon = "__base__/graphics/icons/stack-inserter.png",
    icon_size = 32,
    stack = true,
    minable =
    {
      hardness = 0.2,
      mining_time = 0.5,
      result = "invisible-inserter"
    },
    max_health = 160,
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
    selection_box = {{0,0}, {0,0}},
    pickup_position = {0, 1.2},
    insert_position = {0, -1},
    energy_per_movement = "20KW",
    energy_per_rotation = "20KW",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      drain = "0.1kW"
    },
    extension_speed = 0.5,
    rotation_speed = 0.5,
    hand_base_picture =
    {
      filename = "__base__/graphics/entity/stack-inserter/stack-inserter-hand-base.png",
      priority = "extra-high",
      width = 1,
      height = 1,
     
    },
    hand_closed_picture =
    {
      filename = "__base__/graphics/entity/stack-inserter/stack-inserter-hand-closed.png",
      priority = "extra-high",
      width = 1,
      height =1,
      
    },
    hand_open_picture =
    {
      filename = "__base__/graphics/entity/stack-inserter/stack-inserter-hand-open.png",
      priority = "extra-high",
      width = 1,
      height = 1,
     
    },
    hand_base_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-base-shadow.png",
      priority = "extra-high",
      width = 1,
      height = 1,
      
    },
    hand_closed_shadow =
    {
      filename = "__base__/graphics/entity/stack-inserter/stack-inserter-hand-closed-shadow.png",
      priority = "extra-high",
      width = 1,
      height = 1,
      
    },
    hand_open_shadow =
    {
      filename = "__base__/graphics/entity/stack-inserter/stack-inserter-hand-open-shadow.png",
      priority = "extra-high",
      width = 1,
      height =1,
      
    },
    platform_picture =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/stack-inserter/stack-inserter-platform.png",
        priority = "extra-high",
        width = 1,
        height = 1,        
      }
    },
  },
  --- invisible-substation
  {
    type = "electric-pole",
    name = "invisible-substation",
    icon = "__base__/graphics/icons/substation.png",
    icon_size = 32,
    minable = {hardness = 0.2, mining_time = 0.5, result = "invisible-substation"},
    max_health = 200,
    corpse = "medium-remnants",
    track_coverage_during_build_by_moving = true,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-0, -0}, {0, 0}},
    selection_box = {{0, 0}, {0, 0}},
    drawing_box = {{-1, -3}, {1, 1}},
    maximum_wire_distance = 18,
    supply_area_distance = 9,
    pictures =
    {
      filename = "__base__/graphics/entity/substation/substation.png",
      priority = "high",
      width = 1,
      height = 1,
      direction_count = 1,
      shift = {0.9, -1}
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    connection_points =
    {
      {
        shadow =
        {
          copper = {1.9, -0.6},
          green = {1.3, -0.6},
          red = {2.65, -0.6}
        },
        wire =
        {
          copper = {-0.25, -2.71875},
          green = {-0.84375, -2.71875},
          red = {0.34375, -2.71875}
        }
      },
 
   
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      width = 1,
      height = 1,
      priority = "extra-high-no-scale"
    },
  },
  })
  
  
  
--- assembling-provider
local assprov = util.table.deepcopy(data.raw["logistic-container"]["logistic-chest-active-provider"]);
assprov.name = "assembling-provider";
assprov.minable = {mining_time = 0.001, result = nil};
assprov.flags = nil;
data:extend({assprov})

local assprovitem = util.table.deepcopy(data.raw["item"]["logistic-chest-active-provider"])
assprovitem.name = "assembling-provider";
assprovitem.place_result = "assembling-provider";
data:extend({assprovitem})




--- assembling-requester
local assreq = util.table.deepcopy(data.raw["logistic-container"]["logistic-chest-requester"]);
assreq.name = "assembling-requester";
assreq.minable = {mining_time = 0.001, result = nil};
assreq.flags = nil;
data:extend({assreq})

local assreqitem = util.table.deepcopy(data.raw["item"]["logistic-chest-requester"])
assreqitem.name = "assembling-requester";
assreqitem.place_result = "assembling-requester";
data:extend({assreqitem})




local logchem = util.table.deepcopy(data.raw["assembling-machine"]["chemical-plant"]);
logchem.name = "logistic-chemical-plant";
logchem.minable = {hardness = 0.2, mining_time = 0.5, result = "logistic-chemical-plant"};
logchem.icon = "__base__/graphics/icons/chemical-plant.png";
logchem.selection_box = {{-1.5, 0}, {1.5, 1.5}};
data:extend({logchem})

local logchemi = util.table.deepcopy(data.raw["item"]["chemical-plant"])
logchemi.name = "logistic-chemical-plant";
logchemi.icon = "__base__/graphics/icons/chemical-plant.png";
logchemi.place_result = "logistic-chemical-plant";
data:extend({logchemi})

if mods["BraveNewWorkshop"] then
  local workshopDef = util.table.deepcopy(data.raw["assembling-machine"]["workshop"])
  workshopDef.name = "logistic-workshop"
  workshopDef.minable = {hardness = 0.2, mining_time = 0.5, result = "logistic-workshop"}
  workshopDef.selection_box = {{-1.5, 0	}, {1.5, 1.5}}
  data:extend({workshopDef})

  local workshopItem = util.table.deepcopy(data.raw["item"]["workshop"])
  workshopItem.name = "logistic-workshop"
  workshopItem.place_result = "logistic-workshop"
  data:extend({workshopItem})
end









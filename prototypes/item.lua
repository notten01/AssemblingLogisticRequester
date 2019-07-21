
data:extend(
{

--- logistic-assembling-machine
 {
    type = "item",
    name = "logistic-assembling-machine",
    icon = "__base__/graphics/icons/assembling-machine-3.png",
    icon_size = 32,
    subgroup = "production-machine",
    order = "d[logistic-assembling-machine]",
    place_result = "logistic-assembling-machine",
    stack_size = 50
  },
  
  {
    type = "recipe",
    name = "logistic-assembling-machine",
    enabled = false,
    ingredients =
    {
      {"assembling-machine-3", 1},
	  {"logistic-chest-passive-provider", 1},
	  {"logistic-chest-requester", 1},
	  {"stack-inserter", 2},
    },
    result = "logistic-assembling-machine"
  },

 {
    type = "recipe",
    name = "logistic-chemical-plant",
    enabled = false,
    ingredients =
    {
      {"chemical-plant", 1},
	  {"logistic-chest-passive-provider", 1},
	  {"logistic-chest-requester", 1},
	  {"stack-inserter", 2},
    },
    result = "logistic-chemical-plant"
  },


--- assembling-provider




--- assembling-requester
  
  
  
  
  
--- invisible-inserter

{
    type = "item",
    name = "invisible-inserter",
    icon = "__base__/graphics/icons/stack-inserter.png",
    icon_size = 32,
    subgroup = "inserter",
    order = "f[stack-inserter]",
    place_result = "invisible-inserter",
    stack_size = 50
  },

  {
    type = "item",
    name = "invisible-inserter-2",
    icon = "__base__/graphics/icons/stack-inserter.png",
    icon_size = 32,
    subgroup = "inserter",
    order = "f[stack-inserter]",
    place_result = "invisible-inserter-2",
    stack_size = 50
  },

  --- invisible-substation
  
  {
    type = "item",
    name = "invisible-substation",
    icon = "__base__/graphics/icons/substation.png",
    icon_size = 32,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-d[substation]",
    place_result = "invisible-substation",
    stack_size = 50
  },
  

  })
INSERT INTO areas(
  -- Basic Information
  landowner_id,
  name,
  acres,
  goals,

  -- Site Characteristics
  elevation,
  aspect,
  slope_percentage,
  slope_position,
  soil_information,

  -- Vegetative Conditions
  cover_type,
  stand_structure,
  overstory_stand_density,
  overstory_species_composition,
  understory_stand_density,
  understory_species_composition,
  history,

  -- Damages
  insects,
  diseases,
  invasives,
  wildlife_damage,

  -- Mistletoe
  mistletoe_uniformity,
  mistletoe_location,
  hawksworth,
  mistletoe_tree_species,

  -- Free responses
  road_issues,
  other_issues,
  water_issues,
  fire_risk,
  diagnosis
) VALUES
 (
   -- Basic Information
   ?,
   ?,
   ?,
   ?,
   -- Site Characteristics
   ?,
   ?,
   ?,
   ?,
   ?,

   -- Vegetative Conditions
   ?,
   ?,
   ?,
   ?,
   ?,
   ?,
   ?,

   -- Damages
   ?,
   ?,
   ?,
   ?,

   -- Mistletoe
   ?,
   ?,
   ?,
   ?,

   -- Free responses
   ?,
   ?,
   ?,
   ?,
   ?
);

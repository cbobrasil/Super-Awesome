{{
  config(
    materialized = 'table'
    )
}}


select 
    name as character_name,
    real_name,
    full_name,
    overall_score,
    history_text,
    powers_text,
    intelligence_score,
    strength_score,
    speed_score,
    durability_score,
    power_score,
    combat_score,
    superpowers,
    alter_egos,
    aliases,
    place_of_birth,
    first_appearance,
    occupation,
    base,
    teams,
    relatives,
    gender,
    type_race,
    height,
    weight,
    eye_color,
    hair_color,
    skin_color,
    id,
    prompt
from
    
  {{ source('superhero', 'hero_abilities') }}     

{% if is_incremental() %}

  where 
    lower(name) not in (select character_name from {{ this }})

{% endif %}
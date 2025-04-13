{{
  config(
    materialized = 'table'
  )
}}

select 
  c.caracther_key,
  c.page_id,
  c.publisher,
  c.character_name,
  coalesce(cast(info.eye_color as text),cast(abi.eye_color as text),cast(c.eye as text)) as eye,
  coalesce(cast(info.hair_color as text),cast(abi.hair_color as text),cast(c.hair as text)) as hair,
  coalesce(cast(info.gender as text),cast(abi.gender as text),cast(c.sex as text)) as gender,
  coalesce(cast(info.race as text),cast(abi.type_race as text)) as race,
  coalesce(cast(info.skin_color as text),cast(abi.skin_color as text)) as skin_color,
  coalesce(cast(info.height as text),cast(abi.height as text)) as height,
  coalesce(cast(info.weight as text),cast(abi.weight as text)) as weight,
  c.gsm,
  c.alive,
  c.first_appearance,
  c.year,
  info.aligment
from
    {{ ref('trn_caracthers') }} as c 
full outer join 
    {{ ref('stg_comic_characters_info') }} as info on c.caracther_key = info.caracther_key
full outer join
    {{ ref('stg_hero_abilities') }} as abi on c.character_name = abi.character_name
    

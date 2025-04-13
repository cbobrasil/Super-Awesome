{{
  config(
    materialized = 'table'
    )
}}


select 
    md5(concat(name, Publisher)) as caracther_key,
    md5(Publisher) as publisher_key,
    Publisher as publisher,  
    ID as id,
    Name as character_name,
    Alignment as aligment, 
    Gender as gender,    
    EyeColor as eye_color,   
    Race as race,       
    HairColor as hair_color,  
    SkinColor as skin_color,  
    Height as height,  
    Weight as weight
from
    
  {{ source('superhero','comic_characters_info') }}     

{% if is_incremental() %}

  where 
    id > (select max(id) from {{ this }})

{% endif %}
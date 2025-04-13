{{
  config(
    materialized = 'incremental',
    unique_key = 'caracther_appearances_key'
    )
}}

select
    c.caracther_appearances_key,
    coalesce(c.caracther_key,info.caracther_key,md5(concat(abi.character_name,'Other'))) as caracther_key,
    md5(coalesce(info.publisher, c.publisher, md5('Other'))) as publisher_key,
    c.appearances,
    abi.overall_score,
    abi.superpowers,
    now() as created_at
from
    {{ ref('trn_caracthers') }} as c 
full outer join 
    {{ ref('stg_comic_characters_info') }} as info on c.caracther_key = info.caracther_key
full outer join
    {{ ref('stg_hero_abilities') }} as abi on upper(trim(c.character_name)) =  upper(trim(abi.character_name))  
    
{% if is_incremental() %}

where caracther_appearances_key not in (select caracther_appearances_key from {{ this }})

{% endif %}

{{
  config(
    materialized = 'table'
    )
}}


select
    md5(concat(name, 'DC', appearances)) as caracther_appearances_key,
    md5(concat(name, 'DC')) as caracther_key,
    'DC' as publisher,
    page_id,
    name as character_name,
    real_name,
    urlslug,
    id,
    eye,
    hair,
    sex,
    gsm,
    alive,
    appearances,
    first_appearance,
    year
from
    {{ ref('stg_dc_data') }}

union

select
    md5(concat(name, 'Marvel', appearances)) as caracther_appearances_key,
    md5(concat(name, 'Marvel')) as caracther_key,
    'Marvel' as publisher,
    page_id,
    name as character_name,
    real_name,
    urlslug,
    id,
    eye,
    hair,
    sex,
    gsm,
    alive,
    appearances,
    first_appearance,
    year
from
    {{ ref('stg_marvel_data') }}
    
{% if is_incremental() %}

where 
    caracther_appearances_key not in (select caracther_appearances_key from {{ this }})

{% endif %}

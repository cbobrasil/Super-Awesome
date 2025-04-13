{{
  config(
    materialized = 'table'
    )
}}


select 
    page_id,
    name,
    regexp_replace(name, '\s*\(.*?\)', '', 'g') as real_name,
    urlslug,
    id,
    eye,
    hair,
    sex,
    gsm,
    alive,
    appearances,
    'first appearance' as first_appearance,
    year
from
  {{ source('superhero',  'marvel_data') }}     

{% if is_incremental() %}

where  
  page_id > (select max(page_id) from {{ this }})

{% endif %}
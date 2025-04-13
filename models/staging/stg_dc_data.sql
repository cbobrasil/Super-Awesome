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
    ID as id,
    EYE as eye,
    HAIR as hair,
    SEX as sex,
    GSM as gsm,
    ALIVE as alive,
    APPEARANCES as appearances,
    'FIRST APPEARANCE' as first_appearance,
    YEAR as year
from
  {{ source('superhero', 'dc_data') }}     

{% if is_incremental() %}

where  
	page_id > (select max(page_id) from {{ this }})

{% endif %}
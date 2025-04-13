{{
  config(
    materialized = 'table'
  )
}}

select distinct
  md5(publisher) as publisher_key,
  publisher
from (
  select
    coalesce(info.publisher, t.publisher) as publisher
  from 
    {{ ref('trn_caracthers') }} as t
  full outer join 
    {{ ref('stg_comic_characters_info') }} as info on t.caracther_key = info.caracther_key
)
where 
  publisher is not null
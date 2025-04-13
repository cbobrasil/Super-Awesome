{{ config(
    materialized='table'
) }}

with split_superpowers as (

select
    caracther_key,
    regexp_split_to_table(superpowers, ',') as superpower
from 
    {{ ref('fact_heros') }}
),

superpower_frequency as (

    select
        superpower,
        count(*) as frequency
    from split_superpowers
    group by superpower
)

select 
    superpower
from 
    superpower_frequency
order by 
    frequency desc
limit 
    5


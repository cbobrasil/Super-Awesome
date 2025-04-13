{{ config(
    materialized='table'
) }}

with cte_fact as (
    select
        f.*,
        row_number() over (partition by f.caracther_key order by f.appearances desc) as rn
    from 
        {{ ref('fact_heros') }} f
),

cte_fact_filtered as (
    select
        *
    from    
        cte_fact
    where 
        rn=1

),

split_superpowers as (

    select
        caracther_key,
        regexp_split_to_table(superpowers, ',') as superpower
    from 
        cte_fact_filtered
),

superpower_frequency as (

    select
        superpowers,
        count(*) as frequency
    from 
        split_superpowers
    group by 
        publisher_key,
        superpowers
)

select 
    f.caracther_key,
    f.superpowers
from 
    {{ ref('fact_heros') }} as f
inner join 
    superpower_frequency as top5 on top5.superpowers = f.superpowers
order by 
    f.caracther_key, f.superpowers


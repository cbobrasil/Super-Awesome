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
        publisher_key,
        regexp_split_to_table(superpowers, ',') as superpower
    from 
        cte_fact_filtered
),

superpower_frequency as (

    select
        publisher_key,   
        superpower,
        count(*) as frequency
    from 
        split_superpowers
    group by 
        publisher_key,
        superpower
)

select 
    publisher,   
    superpower,
from 
    superpower_frequency as s
left join 
    {{ ref('dim_publisher') }} as p on p.publisher_key = s.publisher_key

order by 
    frequency desc
limit 
    10
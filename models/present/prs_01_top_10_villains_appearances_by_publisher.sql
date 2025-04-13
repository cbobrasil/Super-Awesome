{{
  config(
    materialized = 'table'
    )
}}

with cte_apperances as (
    
    select
        f.caracther_key,
        c.character_name,
        p.publisher,
        f.appearances,
        c.aligment,
        f.overall_score,
        row_number() over (partition by f.caracther_key order by f.appearances desc) as rn
    from 
        {{ ref('fact_heros') }} f
    left join 
        {{ ref('dim_carachteristic') }} c on c.caracther_key = f.caracther_key
    left join 
        {{ ref('dim_publisher') }} as p on p.publisher_key = f.publisher_key
    
    where
        c.aligment = 'bad'
)

select *
from
    (
        select
            caracther_key,
            character_name,
            aligment,
            publisher,
            appearances,
            overall_score,
            row_number() over (partition by publisher order by appearances desc) as rn
        from 
            cte_apperances
        where
            rn = 1 
    ) ranked
where rn <= 10
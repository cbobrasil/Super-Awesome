{{
  config(
    materialized = 'table'
    )
}}

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

cte_fact_carachteristic as (
    
    select
        f.caracther_key,
        c.character_name,
        p.publisher,
        f.appearances,
        c.aligment,
        f.overall_score
    from 
        cte_fact_filtered as f
    left join 
        {{ ref('dim_carachteristic') }} c on c.caracther_key = f.caracther_key
    left join 
        {{ ref('dim_publisher') }} as p on p.publisher_key = f.publisher_key
),

top_characters as (
    select 
        caracther_key
    from 
        cte_fact
    where 
        caracther_key in 
            (
                select 
                    caracther_key
                from 
                    {{ ref('prs_01_top_10_villains_appearances_by_publisher') }}
                
                union

                select
                    caracther_key
                from 
                    {{ ref('prs_02_top_10_hereos_appearances_by_publisher') }}
            )
)
    select 
        f.character_name,
        f.aligment,
        rank() over (order by f.overall_score desc) as final_rank
    from 
        cte_fact_carachteristic as f
    inner join 
        top_characters as top_c on f.caracther_key = top_c.caracther_key
    order by aligment, overall_score desc 

{{ config(
        materialized='table',
        transient=true
    )
}}

{{ dbt_utils.date_spine(
    "day",
    "to_date('01/01/2016', 'mm/dd/yyyy')",
    "dateadd(week, 1, current_date)"
) }}
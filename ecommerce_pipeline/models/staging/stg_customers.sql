with source as (
    select * from {{ ref('olist_customers_dataset') }}
),

staged as (
    select
        customer_id,
        customer_unique_id,
        customer_city,
        customer_state
    from source
)

select * from staged
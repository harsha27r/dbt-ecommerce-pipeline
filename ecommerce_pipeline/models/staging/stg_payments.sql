with source as (
    select * from {{ ref('olist_order_payments_dataset') }}
),

staged as (
    select
        order_id,
        payment_sequential,
        payment_type,
        payment_installments,
        cast(payment_value as double) as payment_value
    from source
)

select * from staged
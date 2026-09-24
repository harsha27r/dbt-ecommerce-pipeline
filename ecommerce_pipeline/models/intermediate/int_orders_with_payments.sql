{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select
        order_id,
        sum(payment_value) as total_payment_value,
        count(distinct payment_type) as payment_methods_used
    from {{ ref('stg_payments') }}
    group by order_id
),

joined as (
    select
        o.order_id,
        o.customer_id,
        o.order_status,
        o.order_purchased_at,
        o.order_delivered_at,
        o.order_estimated_delivery_at,
        p.total_payment_value,
        p.payment_methods_used
    from orders o
    left join payments p on o.order_id = p.order_id
)

select * from joined

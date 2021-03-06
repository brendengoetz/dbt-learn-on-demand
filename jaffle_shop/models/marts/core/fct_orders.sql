with payments as (
    
    select *
    from {{ ref('stg_payments') }}
),

orders as (

    select *
    from {{ ref('stg_orders') }}
),

order_payments as (
    
    select
        order_id,
        sum(case when payment_status = 'success' then amount end) as amount

    from payments
    group by 1
),

final as (

    select
        orders.customer_id,
        orders.order_id,
        orders.order_date,
        coalesce(order_payments.amount, 0) as amount
    
    from orders
    inner join order_payments
        on order_payments.order_id = orders.order_id
)

select * from final
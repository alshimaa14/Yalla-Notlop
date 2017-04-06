json.extract! item, :id, :item, :amount, :price, :comment, :order_id, :user_id, :created_at, :updated_at
json.url item_url(item, format: :json)

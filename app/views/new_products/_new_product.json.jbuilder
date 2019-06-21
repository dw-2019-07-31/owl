json.extract! new_product, :id, :created_at, :updated_at
json.url new_product_url(new_product, format: :json)

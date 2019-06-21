#json.extract! product, :id, :code, :catchcopy, :weight_g, :created_at, :updated_at
json.extract! product, :id, :code,:maker_code,:genre_code,:change_note,:sch_release_date,:size,:package_size,:weight_g,:package_weight,:size_note,:battery,:catchcopy,:catchcopy_long,:catchcopy_sub1,:catchcopy_sub2,:catchcopy_sub3,:discription,:usage,:care,:detailed_description,:caution,:description_path1,:description_path2,:target_age,:accessories,:manufacture,:material,:country_origin,:inner_carton,:outer_carton,:outer_size,:outer_weight,:cataloged,:catalog_copy,:created_at, :updated_at
# json.url product_url(product, format: :json)
json.url product_url(product.code, format: :json)

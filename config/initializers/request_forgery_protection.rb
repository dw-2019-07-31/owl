# Disable origin-checking CSRF mitigation. 
# インターネットからHTTPS⇒nginx(https終端)⇒nginx(LB)⇒WEB と通信されると、http origin headerの検証に失敗するのでその対策。
Rails.application.config.action_controller.forgery_protection_origin_check = false
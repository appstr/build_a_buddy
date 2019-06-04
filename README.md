# BUILD-A-BUDDY

* console: git clone https://github.com/appstr/slingshot_build_a_buddy.git

* console: bundle

* console: rails db:create db:migrate

* console: rake import_csv:inventory

* console: rake import_csv:product_prices

* console: rake import_csv:compatibility

* console: rake import_csv:purchase_orders

* console: rails s

* browser: localhost:3000

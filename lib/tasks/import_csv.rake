require 'csv'

namespace :import_csv do
  desc "Import inventory data from inventory.csv"
  task inventory: :environment do
    csv_text = File.read('./csv/inventory.csv')
    csv = CSV.parse(csv_text, :headers => true)
    product_images = {
      'bear'=>'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fmedia.buzzle.com%2Fmedia%2Fimages-en%2Fgallery%2Futilities%2F1200-525900055-teddy-bear.jpg&f=1',
      'elephant'=>'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fimages-na.ssl-images-amazon.com%2Fimages%2FI%2F81-80FPGX0L.jpg&f=1',
      'tiger'=>'https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.toysandco.com%2Fmedia%2Fproducts%2Flarge%2FDEP00083-L.jpg&f=1',
      'gorilla'=>'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fi5.walmartimages.com%2Fasr%2F4438eb48-f7c0-4806-998c-3e8094be9eb3_1.ddf2924cf674277f1b6b2e9f28d1b2da.jpeg&f=1',
      'shoes'=>'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.pajamasbuy.com%2Fimage%2Fcache%2Fcatalog%2Fs-4pnxa%2Fproducts%2F2178%2Fimages%2F13360%2Fanimal-panda-winter-warm-plush-stuffed-household-slipper-shoes-1200x1200.jpg&f=1',
      't_shirt'=>'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fimages-na.ssl-images-amazon.com%2Fimages%2FI%2F81DYEpAfJ-L._UL1500_.jpg%3Ffifu&f=1',
      'tiara'=>'https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fpartycity6.scene7.com%2Fis%2Fimage%2FPartyCity%2F_pdp_sq_%3F%24_1000x1000_%24%26%24product%3DPartyCity%2F175762&f=1',
      'glasses'=>'https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Fm1.image009.com%2Fproductimage%2FG%2FGG%2FGG0111%2FGG0111093.jpg&f=1'
    }
    csv.each do |row|
      if !row[0].nil? and row[0] != "Description"
        animal = StuffedAnimal.new
        animal.description = StuffedAnimal.descriptions[row[0].downcase]
        animal.quantity = row[1]
        animal.product_image = product_images[row[0].downcase]
        animal.save
      end
      if row[0] != "Description"
        accessory = Accessory.new
        row[3] = "t_shirt" if row[3] == "T-Shirt"
        accessory.description = Accessory.descriptions[row[3].downcase]
        row[4] = "all_sizes" if row[4] == "All"
        accessory.size = Accessory.sizes[row[4]]
        accessory.quantity = row[5]
        accessory.product_image = product_images[row[3].downcase]
        accessory.save
      end
    end
  end

  desc "Import product prices data from product_prices.csv"
  task product_prices: :environment do
    csv_text = File.read('./csv/product_prices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      if !row[0].nil? and row[0] != "Description"
        animal = StuffedAnimal.where(description: row[0].downcase).first
        animal.cost = row[1]
        animal.sale_price = row[2]
        animal.profit = get_profit(row[1].to_f, row[2].to_f)
        animal.save
      end
      if row[0] != "Description"
        row[4] = "t_shirt" if row[4] == "T-Shirt"
        row[5] = "all_sizes" if row[5] == "All"
        accessory = Accessory.where(description: row[4].downcase, size: row[5]).first
        accessory.cost = row[6]
        accessory.sale_price = row[7]
        accessory.profit = get_profit(row[6].to_f, row[7].to_f)
        accessory.save
      end
    end
  end

  desc "Import product compatibility data from compatibility.csv"
  task compatibility: :environment do
    csv_text = File.read('./csv/compatibility.csv')
    csv = CSV.parse(csv_text, :headers => true)
    sizes = %w(Small Medium Large)
    csv.each do |row|
      if row[0] != nil
        sizes.each do |size|
          if row[size]
            animal = StuffedAnimal.where(description: row[0].downcase).first
            shoes = Accessory.where(description: "shoes", size: size.downcase).first
            t_shirt = Accessory.where(description: "t_shirt", size: size.downcase).first
            tiara = Accessory.where(description: "tiara").first
            glasses = Accessory.where(description: "glasses").first
            animal.compatibilities.create(accessory: shoes)
            animal.compatibilities.create(accessory: t_shirt)
            animal.compatibilities.create(accessory: tiara)
            animal.compatibilities.create(accessory: glasses)
            break
          end
        end
      end
    end
  end

  desc "Import purchase orders data from purchase_orders.csv"
  task purchase_orders: :environment do
    csv_text = File.read('./csv/purchase_orders.csv')
    csv = CSV.parse(csv_text, :headers => true)
    product_map = {2=>'bear', 3=>'elephant', 4=>'tiger', 5=>'gorilla', 6=>'shoes small', 7=>'t_shirt small', 8=>'shoes medium', 9=>'t_shirt medium', 10=>'shoes large', 11=>'t_shirt large', 12=>'tiara', 13=>'glasses'}
    csv.each do |row|
      if row[0] != "Date"
        purchase = PurchaseOrder.new
        purchase.purchase_datetime = purchase_order_datetime(row[0], row[1])
        purchase.save
        (2..13).each do |indx|
          if row[indx] == "1"
            if indx <= 5
              # Stuffed Animal
              animal = StuffedAnimal.where(description: product_map[indx]).first
              purchase.stuffed_animal_purchases.create(stuffed_animal: animal)
            else
              # Accessory
              if (6..11).include? indx
                desc, size = product_map[indx].split(" ")
                accessory = Accessory.where(description: desc, size: size).first
                purchase.accessory_purchases.create(accessory: accessory)
              else
                accessory = Accessory.where(description: product_map[indx]).first
                purchase.accessory_purchases.create(accessory: accessory)
              end
            end
          end
        end
      end
    end
  end

end


def get_profit(cost, sale_price)
  sale_price - cost
end

def purchase_order_datetime(date, time)
  Time.strptime("#{date} #{time}", "%m/%d/%Y %H:%M:%S %P")
end

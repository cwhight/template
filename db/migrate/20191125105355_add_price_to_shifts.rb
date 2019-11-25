class AddPriceToShifts < ActiveRecord::Migration[5.2]
  def change
    add_monetize :shifts, :price, currency: { present: false }
  end
end

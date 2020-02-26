class AddShiftToOffer < ActiveRecord::Migration[5.2]
  def change
    add_reference :offers, :shift, foreign_key: true
  end
end

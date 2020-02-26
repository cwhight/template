class AddUserToOffer < ActiveRecord::Migration[5.2]
  def change
    add_reference :offers, :user, foreign_key: true
  end
end

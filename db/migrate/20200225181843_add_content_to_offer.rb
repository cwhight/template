class AddContentToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :content, :text
  end
end

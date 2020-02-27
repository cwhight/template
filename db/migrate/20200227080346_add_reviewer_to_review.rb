class AddReviewerToReview < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :reviewer, foreign_key: {to_table: :users}
  end
end

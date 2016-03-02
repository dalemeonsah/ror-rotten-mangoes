class ChangeRatingDefault < ActiveRecord::Migration
  def change
    change_column_default :reviews, :rating_out_of_ten, 5
  end
end

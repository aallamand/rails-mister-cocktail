class AddSortToCocktails < ActiveRecord::Migration[5.0]
  def change
    add_column :cocktails, :sort, :integer
  end
end

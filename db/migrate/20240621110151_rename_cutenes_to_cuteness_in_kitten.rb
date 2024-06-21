class RenameCutenesToCutenessInKitten < ActiveRecord::Migration[7.1]
  def change
    rename_column :kittens, :cutenes, :cuteness
  end
end

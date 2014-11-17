class CreateRewardLevels < ActiveRecord::Migration
  def change
    create_table :reward_levels do |t|
      t.string :name
      t.text :description
      t.integer :limit
      t.references :campaign, index: true
      t.integer :price

      t.timestamps
    end
  end
end

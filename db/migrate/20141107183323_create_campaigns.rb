class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.string :description
      t.float :goal
      t.datetime :deadline
      t.references :user, index: true

      t.timestamps
    end
  end
end
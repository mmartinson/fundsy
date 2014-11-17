class AddAasmToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :aasm, :string
  end
end

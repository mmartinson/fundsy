class ChangeAasmOnCampaign < ActiveRecord::Migration
  def change
    rename_column :campaigns, :aasm, :aasm_state
  end
end

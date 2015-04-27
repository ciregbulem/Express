class AddCodeToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :access_code, :string
  end
end

class AddVariablesToEmployers < ActiveRecord::Migration
  def change
    add_column :employers, :first_name, :string
    add_column :employers, :last_name, :string
    add_column :employers, :company, :string
    add_column :employers, :position, :string
    add_column :employers, :grad_year, :string
  end
end

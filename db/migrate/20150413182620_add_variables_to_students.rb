class AddVariablesToStudents < ActiveRecord::Migration
  def change
    add_column :students, :last_name, :string
    add_column :students, :street_address, :string
    add_column :students, :city, :string
    add_column :students, :state, :string
    add_column :students, :zip, :string
    add_column :students, :cell_number, :string
    add_column :students, :home_number, :string
    add_column :students, :gpa, :string
    add_column :students, :skill, :text
    add_column :students, :experience, :text
    add_column :students, :major, :string
    add_column :students, :minor, :string
    add_column :students, :grad_year, :string
    add_column :students, :leadership, :string
    add_column :students, :sport, :string
    add_column :students, :birthday, :date
  end
end

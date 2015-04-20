class AddTempEmailToStudents < ActiveRecord::Migration
  def change
    add_column :students, :temp_email, :string
  end
end

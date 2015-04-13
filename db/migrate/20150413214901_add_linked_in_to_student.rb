class AddLinkedInToStudent < ActiveRecord::Migration
  def change
    add_column :students, :linkedin_link, :string
  end
end

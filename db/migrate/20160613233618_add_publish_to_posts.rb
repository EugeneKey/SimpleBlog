class AddPublishToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :publish, :boolean, null: false, default: true
  end
end

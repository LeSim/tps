class AddLoginTokenColumnToGestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_column :gestionnaires, :login_token, :text
    add_column :gestionnaires, :login_token_created_at, :datetime
  end
end

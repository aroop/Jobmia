class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|      
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :first_name,                :string
      t.column :last_name,                 :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :last_login,                :datetime      
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      t.column :activation_code,           :string, :limit => 40
      t.column :activated_at,              :datetime
      t.column :state,                     :string, :null => :no, :default => 'passive'
      t.column :deleted_at,                :datetime
      t.column :password_reset_code,       :string, :limit => 40
      t.column :is_admin,                  :boolean, :default => false
      t.column :time_zone,                 :string
      t.column :avatar_file_name,          :string 
      t.column :avatar_content_type,       :string 
      t.column :avatar_file_size,          :integer
    end      
  end

  def self.down
    drop_table :users
  end

end
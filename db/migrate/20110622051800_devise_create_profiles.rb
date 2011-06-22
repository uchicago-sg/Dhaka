class DeviseCreateProfiles < ActiveRecord::Migration
  def self.up
    create_table(:profiles) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.confirmable
      # t.encryptable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.timestamps
    end

    add_index :profiles, :email,                :unique => true
    add_index :profiles, :reset_password_token, :unique => true
    add_index :profiles, :confirmation_token,   :unique => true
    # add_index :profiles, :unlock_token,         :unique => true
    # add_index :profiles, :authentication_token, :unique => true
  end

  def self.down
    drop_table :profiles
  end
end
Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id

      column :name, String, null: false, unique: true, size: 64
      column :email, String, null: false, unique: true, size: 255
      column :encrypted_password, String, size: 128

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :email, unique: true
    end
  end
end

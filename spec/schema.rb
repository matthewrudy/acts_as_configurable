ActiveRecord::Schema.define(:version => 1) do
  create_table :configured_properties, :force => true do |t|
    t.string  :property
    t.string  :value
    t.integer :configured_id
    t.string  :configured_type

    t.timestamps
  end
  add_index :configured_properties, :configured_id
  
  create_table :organisations, :force => true do |t|
    t.string :name
  end
end
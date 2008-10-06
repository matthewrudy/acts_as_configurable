class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
      t.string  :property
      t.string  :value
      t.integer :configured_id
      t.string  :configured_type
<% unless options[:skip_timestamps] %>
      t.timestamps
<% end -%>
    end
    # add_index :<%= table_name %>, :property # consider adding this if you have multiple properties
    add_index :<%= table_name %>, :configured_id
  end

  def self.down
    drop_table :<%= table_name %>
  end
end
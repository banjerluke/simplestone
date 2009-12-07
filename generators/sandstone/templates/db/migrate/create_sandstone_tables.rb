# I've consolidated these migrations in line with the advice here:
# http://rails.lighthouseapp.com/projects/8994/tickets/487-migration-timestamp-clash-problems-with-generators

# Jason Cale (25/03/2009) 
# http://github.com/jasoncale/sandstone/tree/master

class CreateSandstoneTables < ActiveRecord::Migration
  def self.up
    
    # AUDIT TABLES
    
    create_table :audits do |audits_table|
      audits_table.with_options :null => false do |t|
        t.integer  :editor_id
        t.integer  :record_id,   :null => true
        t.string   :record_type, :null => true
        t.string   :event
        t.string   :details,     :null => true
        t.datetime :created_at
        t.datetime :deleted_at,  :null => true
      end
    end
    
    add_index :audits, [:record_id, :record_type]
    add_index :audits, :event
    add_index :audits, :editor_id
    add_index :audits, :created_at
    
    
    # EDITORS
    
    create_table :editors do |editors_table|
      editors_table.with_options :null => false do |t|
        t.integer  :user_id
        t.string   :role, :limit => 32
        t.datetime :created_at, :updated_at
        t.datetime :deleted_at, :null => true
      end
    end
    
    add_index :editors, :user_id, :unique => true
    add_index :editors, :role
    
    
    # PAGE TEMPLATES
    
    create_table :page_templates do |page_templates_table|
      page_templates_table.with_options :null => false do |t|
        t.string :name
        t.text :content
        t.datetime :created_at, :updated_at
        t.datetime :deleted_at, :null => true
      end
    end
    
    PageTemplate.create_versioned_table
    
    
    # PAGE VARIABLES
    
    create_table :page_variables do |page_variables_table|
      page_variables_table.with_options  :null => false do |t|
        t.integer  :page_id
        t.string   :name,       :limit => 32
        t.text     :content
        t.datetime :created_at, :updated_at
        t.datetime :deleted_at, :null => true
      end
    end
    
    add_index :page_variables, :page_id
    
    # version this? PageVariable.create_versioned_table
    
    
    # PAGES
    
    create_table :pages do |pages_table|
      pages_table.with_options  :null => false do |t|
        t.integer  :parent_id, :page_template_id, :editor_id, :null => true
        t.string   :status,  :limit => 32, :default => 'new'
        t.string   :path,    :limit => 255
        t.string   :title,   :limit => 255, :null => true
        t.text     :content, :summary, :meta_description, :meta_keywords, :null => true
        t.datetime :created_at, :updated_at
        t.datetime :active_at, :expires_at, :deleted_at, :null => true
      end
    end
    
    add_index :pages, :path, :unique => true
    add_index :pages, :parent_id
    add_index :pages, :editor_id
    add_index :pages, :status
    
    Page.create_versioned_table
  end

  def self.down
    # AUDIT TABLES
    drop_table :audits
    
    # EDITORS
    drop_table :editors
    
    # PAGE TEMPLATES
    PageTemplate.drop_versioned_table
    drop_table :page_templates
    
    # PAGE VARIABLES
    # PageVariable.drop_versioned_table
    drop_table :page_variables
    
    # PAGES
    Page.drop_versioned_table
    drop_table :pages
  end
end

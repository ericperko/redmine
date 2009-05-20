class AddWikiPagesCategories < ActiveRecord::Migration
  def self.up
    add_column :wiki_pages, :categories, :string
  end

  def self.down
    remove_column :wiki_pages, :categories
  end
end
class CreateShortUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :short_urls do |t|
      t.string :short_path
      t.string :original_url

      t.timestamps
    end
  end
end

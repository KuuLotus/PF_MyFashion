class RenamePostColumnToVisionTags < ActiveRecord::Migration[6.1]
  def change
    rename_column :vision_tags, :post_, :post_id
  end
end

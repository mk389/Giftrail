class DropActiveStorageTables < ActiveRecord::Migration[7.2]
  def change
    # 外部キーを削除
    remove_foreign_key :active_storage_attachments, column: :blob_id if foreign_key_exists?(:active_storage_attachments, :blob_id)
    remove_foreign_key :active_storage_variant_records, column: :blob_id if foreign_key_exists?(:active_storage_variant_records, :blob_id)

    # テーブルを削除
    drop_table :active_storage_variant_records, if_exists: true
    drop_table :active_storage_attachments, if_exists: true
    drop_table :active_storage_blobs, if_exists: true
  end
end
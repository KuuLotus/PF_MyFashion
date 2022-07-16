class CreateSnsCredentials < ActiveRecord::Migration[6.1]
  def change
    create_table :sns_credentials do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.references :member, forign_key: true
      t.timestamps
    end
  end
end

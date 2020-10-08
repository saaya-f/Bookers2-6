class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :follower, foreign_key: { to_table: :users}
      t.references :followed, foreign_key: { to_table: :users}

      t.timestamps
    end
    add_index :relationships, [:follower_id, :followed_id], unique:true
    #複合キーインデックス：両者の組み合わせが必ずユニーク
  end
end

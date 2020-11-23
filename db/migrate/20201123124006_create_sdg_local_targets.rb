class CreateSDGLocalTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :sdg_local_targets do |t|
      t.references :target
      t.string :code
      t.timestamps

      t.index :code, unique: true
    end

    reversible do |dir|
      dir.up do
        SDG::LocalTarget.create_translation_table! title: :string, description: :text
      end

      dir.down do
        SDG::LocalTarget.drop_translation_table!
      end
    end
  end
end

class CreateCorrectionlikes < ActiveRecord::Migration[5.2]
  def change
    create_table :correctionlikes do |t|
      t.references :correction, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

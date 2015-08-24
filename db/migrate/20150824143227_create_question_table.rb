class CreateQuestionTable < ActiveRecord::Migration
  def change
    create_table :question_tables do |t|
      t.string :city
      t.string :state
    end
  end
end

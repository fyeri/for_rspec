require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "バリデーション" do
    it "タイトルが未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: nil, description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Title can't be blank"]
    end

    it "ステータスが未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Status can't be blank"]
    end

    it "完了期限が未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: nil)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline can't be blank"]
    end

    it "完了期限が過去の日付の場合、タスクのバリデーションが無効であること" do
      past_date = Date.yesterday
      task = Task.new(title: "test", description: "test", status: :todo, deadline: past_date)
      
   
      expect(task).to be_invalid
      expect(task.errors.full_messages).not_to eq ["Deadline must start from today"]
    end
    
    end

    it "完了期限が今日の日付の場合、タスクのバリデーションが有効であること" do
      today_date = Date.today
      task = Task.new(title: "test", description: "test", status: :done, deadline: today_date)
      expect(task).to be_valid
  end
end
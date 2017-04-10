namespace :db do
  desc "Import Word"
  task words: [:environment] do
    20.times do |n|
      answers = Array.new
      answer_correct = {title: Faker::Lorem.word, is_correct: true}
      answers.push answer_correct
      3.times do |t|
        answer_incorrect = {title: Faker::Lorem.word, is_correct: false}
        answers.push answer_incorrect
      end
      word = Word.create! title: Faker::Name.name, category_id: 1,
        answers_attributes: answers
    end
  end
end

FactoryBot.define do
  factory :todo_item do
    description { "Sample description" }
    done { false }
    association :todo_list
  end
end
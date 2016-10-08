FactoryGirl.define do
  factory :gem_category do
    name "Category 1"
    description "My category created via factory"
    parent_id nil
  end

  factory :gem_subcategory, class: GemCategory do
    name "Subcategory 1"
    description "My subcategory created via factory"
    association :parent, factory: :gem_category
  end


end

FactoryGirl.define do
  factory :gem_version do
    gem_object nil
    authors "Firstname Lastname"
    built_at DateTime.now
    created_at DateTime.now
    description "Any description of this version"
    downloads_count 0
    number "1.0.0"
    summary "Any summary of this version"
    platfrom nil
    rubygems_version ">= 0"
    ruby_version ">= 0"
    prerelease false
    licenses ['MIT']
    sha "1234567890"
  end
end

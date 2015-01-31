FactoryGirl.define do
  factory :version do
    version '1.0.0'

    association :tool
  end
end

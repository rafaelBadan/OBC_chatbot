FactoryGirl.define do
  factory :url do
    pathurl FFaker::Internet.http_url
    company
  end
end

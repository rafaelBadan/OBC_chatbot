FactoryGirl.define do
  factory :url do
    url FFaker::Internet.http_url
    hashtag
  end
end

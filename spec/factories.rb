FactoryGirl.define do

  factory :role do
    sequence(:name) { |n| "Role #{ n }"}
  end

  factory :story do
    author
    body   'The best post evah!'

    sequence(:title) { |n| "Story #{ n }" }
  end

  factory :unconfirmed_user, class: User do
    sequence(:email)    { |n| "user#{ n }@testing.com" }
    sequence(:username) { |n| "User #{ n }" }

    password              'password'
    password_confirmation 'password'

    factory :user, aliases: [:author] do
      after(:create) { |user, proxy| user.confirm! }

      factory :admin do
        after(:create) { |user| user.update_attribute :admin, true }
      end
    end

  end

end

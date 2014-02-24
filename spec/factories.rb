FactoryGirl.define do
	factory :user do
		sequence(:name)	{ |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		password				"24601alewiss"
		password_confirmation	"24601alewiss" 

		factory :admin do
			admin true
		end
	end
end
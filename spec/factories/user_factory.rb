FactoryGirl.define do 

	factory :user do
		sequence(:name) do |n|
			"foo#{n}"
		end
		
		email {"#{name}@bar.com"} 

		password "123456"

	end
	

end
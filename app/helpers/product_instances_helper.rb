module ProductInstancesHelper

def product_instance_users
	number_of_users = @product_instance.client.users.count
	return number_of_users
end



end

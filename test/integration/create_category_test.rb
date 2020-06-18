require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
    sign_in_as(@admin_user, 'password')
  end

  test 'get new category form and create category' do
    get new_category_path
    assert_response :success
    assert_difference('Category.count', 1) do
      post categories_path, params: { category: { name: 'Sports' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Sports', response.body
  end
end

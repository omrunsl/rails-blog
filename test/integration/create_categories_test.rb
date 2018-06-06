require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    post "/categories", params: { category: { name: "sports" }}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "sports", response.body
  end

  test "invalid category submission results in failure" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post "/categories", params: { category: { name: " " }}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
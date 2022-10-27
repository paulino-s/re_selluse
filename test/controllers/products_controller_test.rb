require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product', 4
  end

  test 'render a detailed product page' do
    get product_path(products(:macbook))
    
    assert_response :success
    assert_select '.title', 'Macbook Pro'
    assert_select '.description', 'MacBook 2022, nueva!'
    assert_select '.price', '2500'

  end
end
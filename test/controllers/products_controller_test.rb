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
    assert_select '.description', 'MacBook 2022, nueva'
    assert_select '.price', '$2500'
  end  
  
  test 'render a new product form' do
    get new_product_path

    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'Huawei',
        description: 'Telefono nuevo, con todos sus accesorios',
        price: 299
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Producto creado correctamente!'
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: 'Telefono nuevo, con todos sus accesorios',
        price: 299
      }
    }
    assert_response :unprocessable_entity
  end

  test 'render a edit product form' do
    get edit_product_path(products(:macbook))

    assert_response :success
    assert_select 'form'
  end

  test 'allows to update a new product' do
    patch product_path(products(:macbook)), params: {
      product: {
        price: 250
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Producto Actualizado'
  end

  test 'does not allow to update a new product with an invalid field' do
    patch product_path(products(:macbook)), params: {
      product: {
        price: nil
      }
    }
    assert_response :unprocessable_entity
  end

  # test 'can delete products' do
  #   assert_difference('Product.count', -1) do
  #     delete product_path(products(:macbook))
  #   end

  #   assert_redirected_to products_path
  #   assert_equal flash[:notice], 'Producto eliminado'
  # end
  test 'can delete products' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:macbook))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Producto eliminado'
  end
end
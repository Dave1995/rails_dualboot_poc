# frozen_string_literal: true

require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup do
    @customer = customers(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create customer' do
    assert_difference('Customer.count') do
      post :create, params: { customer: {} }
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  test 'should show customer' do
    if Rails::VERSION::MAJOR < 5
      get :show, id: @customer
    else
      get :show, params: { id: @customer }
    end
    assert_response :success
  end

  test 'should get edit' do
    if Rails::VERSION::MAJOR < 5
      get :edit, id: @customer
    else
      get :edit, params: { id: @customer }
    end
    assert_response :success
  end

  test 'should update customer' do
    if Rails::VERSION::MAJOR < 5
      patch :update, id: @customer, customer: {}
    else
      patch :update, params: { id: @customer, customer: {} }
    end
    assert_redirected_to customer_path(assigns(:customer))
  end

  test 'should destroy customer' do
    assert_difference('Customer.count', -1) do
      if Rails::VERSION::MAJOR < 5
        delete :destroy, id: @customer
      else
        delete :destroy, params: { id: @customer }
      end
    end

    assert_redirected_to customers_path
  end
end

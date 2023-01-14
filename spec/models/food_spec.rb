require 'rails_helper'

RSpec.describe Food, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before :all do
    @user = User.new(name: 'test', username: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456')
    @food = Food.new(name: 'test', measurement_unit: 'test', qty: 1, price: 10, user_id: @user.id)
  end

  it 'name should be present' do
    @food.name = nil
    expect(@food).to_not be_valid
  end

  it 'measurement_unit should be present' do
    @food.measurement_unit = nil
    expect(@food).to_not be_valid
  end

  it 'qty should be present' do
    @food.qty = nil
    expect(@food).to_not be_valid
  end

  it 'price should be present' do
    @food.price = nil
    expect(@food).to_not be_valid
  end
end

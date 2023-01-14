require 'rails_helper'

RSpec.describe 'Food', type: :system do
  user = User.create(name: 'Zika Ali', username: 'zika', email: 'zika@gmail.com', password: '123456',
                     password_confirmation: '123456')

  subject do
    Food.new(name: 'Saltah', measurement_unit: 'kg', price: 10, qty: 10, user_id: user.id)
  end
  before { subject.save }

  describe 'index page' do
    it 'I can see the button.' do
      visit foods_path
      page.has_button?('Add Food')
    end
  end
end

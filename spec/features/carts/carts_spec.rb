require 'rspec'

describe 'Shopping Cart' do

  it 'should add a #product to the #cart' do
    user = create(:user)
    sign_in(user.email, user.password)
    # product = create(:product)
    # visit product_path(1)
    # click_button "Add to Cart"
    save_and_open_page
  end
end
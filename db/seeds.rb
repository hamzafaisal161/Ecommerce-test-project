# frozen_string_literal: true

[
  { email: 'hamza@devsinc.com', password: '123456', name: 'Hamza', contact_no: '4343434', gender: 'Male',
    address: '100 New York', new_user: true, created_at: 2.weeks.ago, updated_at: 1.week.ago },
  { email: 'test@devsinc.com', password: '123456', name: 'Test', contact_no: '434343434', gender: 'Male',
    address: '100 California', new_user: true, created_at: 2.weeks.ago, updated_at: 1.week.ago }
].each do |attributes|
  User.create(attributes)
end

[
  { name: 'Macbook', serial_no: '224352343', price: 1000, description: 'Macbook pro', user_id: 1,
    created_at: 2.weeks.ago, updated_at: 1.week.ago },
  { name: 'Sample 1', serial_no: '224342343', price: 500, description: 'Test ', user_id: 2, created_at: 2.weeks.ago,
    updated_at: 1.week.ago },
  { name: 'Test', serial_no: '224992343', price: 200, description: 'Another test', user_id: 2, created_at: 2.weeks.ago,
    updated_at: 1.week.ago },
  { name: 'Sample 2', serial_no: '2258892343', price: 250, description: 'Random', user_id: 1, created_at: 2.weeks.ago,
    updated_at: 1.week.ago }
].each do |attributes|
  Product.find_or_create_by(attributes)
end

[
  { description: 'Very good', user_id: 2, product_id: 1, created_at: 2.weeks.ago, updated_at: 1.week.ago },
  { description: 'Good', user_id: 2, product_id: 1, created_at: 2.weeks.ago, updated_at: 1.week.ago },
  { description: 'Nice', user_id: 1, product_id: 2, created_at: 2.weeks.ago, updated_at: 1.week.ago }
].each do |attributes|
  Comment.find_or_create_by(attributes)
end

10.times { |i| User.create(email: "user#{i}@example.com", password: 'password', password_confirmation: 'password') }

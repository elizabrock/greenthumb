def login_as(user)
  page.driver.follow(:post, user_session_url, { user: { email: user.email, password: "password1"} })
end

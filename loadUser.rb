#!/bin/ruby
u = User.new({email:':user', password:':pass', password_confirmation:':pass'});
u.agent=true;
u.save!

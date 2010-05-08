# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
puts "Clear current data ..."
puts "   Remove all typus users ..."
TypusUser.destroy_all
puts "   Remove all educatees ..."
Educatee.destroy_all
puts "   Remove all educators ..."
Educator.destroy_all
puts "   Remove all accounts ..."
Account.destroy_all
puts "   Remove all pages ..."
Page.destroy_all


puts "Generate data ..."
puts "   Generate typus users ..."
admin = TypusUser.create(:email => "admin@wxtengu.net", :password => "wxteng808", :password_confirmation => "wxtengu808", :role => "admin", :status => true)
puts "   Generate sample educatees ..."
%w(joe andy mary danny aaron jack).each do |name|
  account = Account.create(:login => name, :password => "000000", :password_confirmation => "000000", :email => "#{name.downcase}@wxtengu.net")
  educatee = Educatee.create
  account.loginable = educatee
  educatee.save!
  account.save!
end
puts "   Generate sample educators ..."
%w(Jeff Ben Lucas).each do |name|
  account = Account.create(:login => name, :password => "000000", :password_confirmation => "000000", :email => "#{name.downcase}@wxtengu.net")
  educator = Educator.create(:is_operator => false)
  account.loginable = educator
  educator.save!
  account.save!
end
puts "   Generate sample operators ..."
  account = Account.create(:login => "JAMES", :password => "000000", :password_confirmation => "000000", :email => "james@wxtengu.net")
  operator = Educator.create(:is_operator => true)
  account.loginable = operator
  operator.save!
  account.save!
  
puts "   Generate sample pages ..."
  pages = Page.create!([{:title => "Basic Info"}, {:title => "Education"}, {:title => "Passport"}])

puts "Over."
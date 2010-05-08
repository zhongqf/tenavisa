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
puts "   Remove all elements ..."
Element.destroy_all


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
  account.activate!
end
puts "   Generate sample educators ..."
%w(Jeff Ben Lucas).each do |name|
  account = Account.create(:login => name, :password => "000000", :password_confirmation => "000000", :email => "#{name.downcase}@wxtengu.net")
  educator = Educator.create(:is_operator => false)
  account.loginable = educator
  educator.save!
  account.save!
  account.activate!
end
puts "   Generate sample operators ..."
  account = Account.create(:login => "JAMES", :password => "000000", :password_confirmation => "000000", :email => "james@wxtengu.net")
  operator = Educator.create(:is_operator => true)
  account.loginable = operator
  operator.save!
  account.save!
  account.activate!
  
puts "   Generate sample pages ..."
  pages = Page.create!([{:title => "Basic Info"}, {:title => "Education"}, {:title => "Passport"}])

puts "   Generate sample elements ..."
e11 = Element.create!(:key => "nationality", :kind => "string", :title_cn => "国籍", :title_jp => "国籍", :page => pages.first)
e12 = Element.create!(:key => "birthday", :kind => "date", :title_cn => "出生年月", :title_jp => "生年月日", :page => pages.first)
e13 = Element.create!(:key => "name_in_chinese", :kind => "string", :title_cn => "中文姓名", :title_jp => "中国語名前", :page => pages.first)
e14 = Element.create!(:key => "name_in_english", :kind => "string", :title_cn => "英文姓名", :title_jp => "英語名前", :page => pages.first)
e15 = Element.create!(:key => "sex", :kind => "selector", :params => "{:values => ['男','女']}":title_cn => "性别", :title_jp => "性別", :page => pages.first)
e16 = Element.create!(:key => "place_of_birth", :kind => "string", :title_cn => "出生地", :title_jp => "出生地", :page => pages.first)
e17 = Element.create!(:key => "photo", :kind => "file", :title_cn => "照片", :title_jp => "写真", :page => pages.first)
e21 = Element.create!(:key => "address_in_japan", :kind => "string", :title_cn => "在日居住地", :title_jp => "連絡先", :page => pages.second)
e22 = Element.create!(:key => "tel", :kind => "date", :title_cn => "电话号码", :title_jp => "電話番号", :page => pages.second)
e23 = Element.create!(:key => "cellular", :kind => "string", :title_cn => "携带电话号码", :title_jp => "携帯番号", :page => pages.second)
e24 = Element.create!(:key => "passport_no", :kind => "string", :title_cn => "护照号码", :title_jp => "旅券番号", :page => pages.last)
e25 = Element.create!(:key => "passport_expiration", :kind => "selector", :title_cn => "护照有效期", :title_jp => "旅券有効期限", :page => pages.last)

puts "Over."
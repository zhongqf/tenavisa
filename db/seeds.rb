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
  pages = Page.create!([{:title => "Basic Info"}, {:title => "Education"}, {:title => "Passport"}, {:title => "Sample"}])

puts "   Generate sample elements ..."
e11 = Element.create!(:key => "nationality", :kind => "string", :title_cn => "国籍", :title_jp => "国籍", :page => pages.first, :position => 1, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e12 = Element.create!(:key => "birthday", :kind => "date", :title_cn => "出生年月", :title_jp => "生年月日", :page => pages.first, :position => 2, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e13 = Element.create!(:key => "name_in_chinese", :kind => "string", :title_cn => "中文姓名", :title_jp => "中国語名前", :page => pages.first, :position => 3, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e14 = Element.create!(:key => "name_in_english", :kind => "string", :title_cn => "英文姓名", :title_jp => "英語名前", :page => pages.first, :position => 4, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e15 = Element.create!(:key => "sex", :kind => "selector", :params => "{:values => ['男','女']}", :title_cn => "性别", :title_jp => "性別", :page => pages.first, :position => 5, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e16 = Element.create!(:key => "place_of_birth", :kind => "string", :title_cn => "出生地", :title_jp => "出生地", :page => pages.first, :position => 6, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e17 = Element.create!(:key => "photo", :kind => "file", :title_cn => "照片", :title_jp => "写真", :page => pages.first, :position => 7, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e21 = Element.create!(:key => "address_in_japan", :kind => "string", :title_cn => "在日居住地", :title_jp => "連絡先", :page => pages.second, :position => 1, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e22 = Element.create!(:key => "tel", :kind => "string", :title_cn => "电话号码", :title_jp => "電話番号", :page => pages.second, :position => 2, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e23 = Element.create!(:key => "cellular", :kind => "string", :title_cn => "携带电话号码", :title_jp => "携帯番号", :page => pages.second, :position => 3, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e31 = Element.create!(:key => "passport_no", :kind => "string", :title_cn => "护照号码", :title_jp => "旅券番号", :page => pages[2], :position => 1, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e32 = Element.create!(:key => "passport_expiration", :kind => "date", :title_cn => "护照有效期", :title_jp => "旅券有効期限", :page => pages[2], :position => 2, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)

e41 = Element.create!(:key => "boolean_sample", :kind => "boolean", :title_cn => "Boolean", :title_jp => "Boolean", :page => pages[3], :position => 1, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e41 = Element.create!(:key => "date_sample", :kind => "date", :title_cn => "Date", :title_jp => "Date", :page => pages[3], :position => 2, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e41 = Element.create!(:key => "file_sample", :kind => "file", :title_cn => "File", :title_jp => "File", :page => pages[3], :position => 3, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e41 = Element.create!(:key => "radio_sample", :kind => "radio", :title_cn => "Radio", :title_jp => "Radio", :page => pages[3], :params => "{:values => ['Option 1', 'Option 2', 'Option 3']}" , :position => 4, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e41 = Element.create!(:key => "selector_sample", :kind => "selector", :title_cn => "Selector", :title_jp => "Selector", :page => pages[3], :params => "{:values => ['Value A', 'Value B', 'Value C']}" , :position => 5, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e41 = Element.create!(:key => "string_sample", :kind => "string", :title_cn => "String", :title_jp => "String", :page => pages[3], :position => 6, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)
e41 = Element.create!(:key => "text_sample", :kind => "text", :title_cn => "Text", :title_jp => "Text", :page => pages[3], :position => 7, :description => "", :enabled => true, :validation_script => "", :prawn_output_script => "", :created_at => Time.now, :updated_at => Time.now)

puts "Over."
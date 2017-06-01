#Then /^I swiggity-swipe left on the cell with name "([^\"]*)"$/ do |arg|
#    swipe :left, :query => "RecipeTableViewCell marked:'#{arg}'", :offset => {:x => 0, :y => 0},
#    :"swipe-delta" => {:vertical => {:dx=> 200, :dy=> 0} }
#end
Then /^I swiggity-swipe left on the cell with name "([^\"]*)"$/ do |arg|
    swipe :left, :query => "RecipeTableViewCell marked:'#{arg}'", :offset => {:x => 0, :y => 0},
    :"swipe-delta" => {:vertical => {:dx=> 200, :dy=> 0} }
end

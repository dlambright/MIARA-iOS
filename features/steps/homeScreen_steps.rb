Given(/^the app has launched$/) do
    wait_for do
        !query("*").empty?
    end
end

And (/^I am on the home screen$/) do
    element_exists("textBox")
end


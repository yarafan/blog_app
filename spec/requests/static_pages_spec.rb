require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
        it "should have the content 'Blog App'" do
          visit '/static_pages/home'
          expect(page).to have_content('Blog App')
        end
        it "should have title" do
         visit '/static_pages/home'
         expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
       end
  end
  describe "Help" do
        it "should have the content 'Help'" do
          visit '/static_pages/help'
          expect(page).to have_content("Help")
        end
        it "should have title" do
          visit '/static_pages/help'
          expect(page).to have_title('Help')
        end
    end
  describe "About us" do
        it "should have the content 'About Us'" do
          visit '/static_pages/about'
          expect(page).to have_content('About Us')
        end
       it "should have title" do
        visit '/static_pages/about'
        expect(page).to have_title("About Us")
        end
    end
end

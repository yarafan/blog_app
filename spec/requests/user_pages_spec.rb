require 'spec_helper'

describe "User pages" do

  subject { page }
  
  describe "index" do
     let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in(user)
      visit users_path
    end
 it { should have_title('All users') }
    it { should have_content('All users') }


describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end
    

    describe "profile page" do
      let(:user) { FactoryGirl.create(:user) } 
      before { visit user_path(user) }
      it { should have_content(user.name) }
      it { should have_title(user.name) }
    end


	
  describe "signup page" do

  before { visit signup_path }
  let(:submit) { "Create my account" }
  describe "with invalid information" do
  it "should not create a user" do
  expect { click_button submit }.not_to change(User, :count)
  end
  end
  describe "with valid information" do
  let(:user) { FactoryGirl.create(:user) }
  before { valid_sign(user) }       
    it "should create a user" do
  expect { click_button submit }.to change(User, :count).by(1)
  end
          
    describe "after saving the user" do
    before { click_button submit }
    let(:user) { User.find_by(email: 'user@example.com') }

    it { should have_link('Sign out') }
    it { should have_selector('div.alert.alert-success', text: 'Welcome') }
    end
  end
end
describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
  describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
              
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first).to change(User, :count).by(-1)
          end
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
    describe "as admin user" do
      let(:admin) { FactoryGirl.create(:user) }

      before { sign_in admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(admin) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
    describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
  end
end




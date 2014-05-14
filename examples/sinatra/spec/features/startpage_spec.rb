require "spec_helper"

describe "Simple Usecase(:ping,'pong')" do
  Given { visit "/" }
  Then  { page.should have_content(/pong/)}
end

describe "Usecase GetTimeUsecase" do
  Given { visit "/date" }
  Then  { page.should have_content(/#{Time.now.to_s[0..10]}/) }
end

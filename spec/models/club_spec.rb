RSpec.describe Club, :type => :model do
# subject is implicitly defined (XYZ.new)
	describe "ActiveRecord associations" do
		it "has many players" do
			expect(subject).to have_many(:players)
		end
	end
end
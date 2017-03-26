RSpec.describe Player, :type => :model do
# subject is implicitly defined (XYZ.new)
	describe "ActiveRecord associations" do
		it "belongs to a club" do
			expect(subject).to belong_to(:club)
		end
	end
end
RSpec.describe Player, :type => :model do
# subject is implicitly defined (XYZ.new)
	describe 'ActiveRecord associations' do
		it 'belongs to a club' do
			expect(subject).to belong_to(:club)
		end
	end

	describe 'instance methods' do
		describe '#return_plus_string' do
			let(:subject)  { FactoryGirl.create(:player, :place_of_birth => 'hoo haa') }
			let(:attribute_to_examine) { subject['place_of_birth'] }

			context 'when place of birth has a space in its name' do
				it 'returns player pob with plus where there were spaces' do
					result = subject.return_plus_string(attribute_to_examine)
					expect(result).to eq('hoo+haa')
				end
			end

			context 'when place of birth does not have a space in its name' do
				let(:attribute_to_examine) { 'zoozaa' }

				it 'returns the player pob' do
					result = subject.return_plus_string(attribute_to_examine)
					expect(result).to eq('zoozaa')
				end
			end
		end
	end
end
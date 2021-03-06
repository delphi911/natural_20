# typed: false
RSpec.describe Natural20::DieRoll do
  before do
    String.disable_colorization true
    srand(1000)
  end

  context 'die rolls' do
    specify '.roll' do
      expect(Natural20::DieRoll.roll('1').result).to be 1
      100.times do
        expect(Natural20::DieRoll.roll('1d6').result).to be_between 1, 6
      end

      100.times do
        expect(Natural20::DieRoll.roll('2d6').result).to be_between 2, 12
      end

      100.times do
        expect(Natural20::DieRoll.roll('2d6+2').result).to be_between 4, 14
      end

      100.times do
        expect(Natural20::DieRoll.roll('2d6-1').result).to be_between 1, 14
      end

      100.times do
        expect(Natural20::DieRoll.roll('2d20').result).to be_between 2, 40
      end
    end

    specify 'addition operator' do
      sum_of_rolls = Natural20::DieRoll.roll('2d8') + Natural20::DieRoll.roll('1d6')
      expect(sum_of_rolls.result).to eq(13)
      expect(sum_of_rolls.to_s).to eq('(4 + 8) + (1)')
    end

    specify 'no die rolls' do
      expect(Natural20::DieRoll.roll('1+1').result).to eq(2)
    end

    specify 'die roll comparison' do
      rolls = 100.times.map do
        Natural20::DieRoll.roll('1d8')
      end
      sorted_rolls = rolls.map(&:result).sort
      rolls_sorted = rolls.sort.map(&:result)
      expect(sorted_rolls).to eq(rolls_sorted)
    end

    specify 'critical rolls' do
      100.times do
        expect(Natural20::DieRoll.roll('1d6', crit: true).result).to be_between 2, 12
      end
    end

    specify 'roll with disadvantage' do
      roll = Natural20::DieRoll.roll('1d20', disadvantage: true)
      expect(roll.to_s).to eq('(20 | 8)')
      expect(roll.result).to eq 8
    end

    specify 'roll with advantage' do
      roll = Natural20::DieRoll.roll('1d20', advantage: true)
      expect(roll.to_s).to eq('(20 | 8)')
      expect(roll.result).to eq 20
      expect(roll.nat_20?).to be
    end
  end
end

# typed: true
class MultiattackAction < Natural20::Action
  attr_accessor :as_bonus_action

  def self.can?(entity, battle)
    battle && entity.total_actions(battle).positive?
  end

  def build_map
    OpenStruct.new({
                     param: nil,
                     next: -> { self }
                   })
  end

  def self.build(session, source)
    action = MultiattackAction.new(session, source, :multiattack)
    action.build_map
  end

  def resolve(_session, _map, opts = {})
    @result = [{
      source: @source,
      type: :multiattack,
      battle: opts[:battle]
    }]
    self
  end

  # @param battle [Natural20::Battle]
  def self.apply!(battle, item)
    case (item[:type])
    when :multiattack
      @total_attacks += 2
      battle.consume!(:action, 1)
    end


  end
end

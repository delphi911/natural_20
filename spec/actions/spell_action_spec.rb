# typed: false
RSpec.describe SpellAction do
  let(:session) { Natural20::Session.new }
  let(:entity) { Natural20::PlayerCharacter.load(session, File.join("fixtures", "high_elf_mage.yml")) }

  before do
    srand(1000)
    @battle_map = Natural20::BattleMap.new(session, "fixtures/battle_sim_objects")
    @battle = Natural20::Battle.new(session, @battle_map)
    @npc = @battle_map.entity_at(5, 5)
    @battle.add(entity, :a, position: [0, 5])
    entity.reset_turn!(@battle)
  end

  context "firebolt" do
    specify "resolve and apply" do
      expect(@npc.hp).to eq(8)
      puts Natural20::MapRenderer.new(@battle_map).render
      action = SpellAction.build(session, entity).next.call('firebolt').next.call(@npc).next.call()
      action.resolve(session, @battle_map)
      @battle.commit(action)
      expect(@npc.hp.to eq(0))
    end
  end
end

# typed: false
RSpec.describe Natural20::BattleMap do
  let(:session) { Natural20::Session.new }
  context "map 1" do
    before do
      String.disable_colorization true
      @battle_map = Natural20::BattleMap.new(session, "fixtures/battle_sim")
      @fighter = Natural20::PlayerCharacter.load(session, File.join("fixtures", "high_elf_fighter.yml"))
      @npc = session.npc( :goblin, name: "grok")
      @battle_map.place(0, 1, @fighter, "G")
    end

    specify "#size" do
      expect(@battle_map.size).to eq [6, 6]
    end

    specify "#render" do
      expect(@battle_map.render).to eq "g···#·\n" +
                                      "G··##·\n" +
                                      "····#·\n" +
                                      "······\n" +
                                      "·##···\n" +
                                      "······\n"

      @battle_map.place(2, 3, @npc, "X")
      expect(@battle_map.render(line_of_sight: @npc)).to eq "g··   \n" +
                                                            "G··## \n" +
                                                            "····# \n" +
                                                            "··g···\n" +
                                                            " ##···\n" +
                                                            "   ···\n"
    end

    context "#place" do
      specify "place tokens in the batlefield" do
        @battle_map.place(3, 3, @npc, "g")
        expect(@battle_map.render).to eq "g···#·\n" +
                                        "G··##·\n" +
                                        "····#·\n" +
                                        "···g··\n" +
                                        "·##···\n" +
                                        "······\n"
      end
    end

    # distance in squares
    specify "#distance" do
      @battle_map.place(3, 3, @npc, "g")
      expect(@battle_map.distance(@npc, @fighter)).to eq(3)
    end

    specify "#valid_position?" do
      expect(@battle_map.valid_position?(6, 6)).to_not be
      expect(@battle_map.valid_position?(-1, 4)).to_not be
      expect(@battle_map.valid_position?(1, 4)).to_not be
      expect(@battle_map.valid_position?(1, 0)).to be
    end

    specify "#line_of_sight?" do
      expect(@battle_map.line_of_sight?(0, 0, 0, 1)).to be
      expect(@battle_map.line_of_sight?(0, 1, 0, 0)).to be
      expect(@battle_map.line_of_sight?(3, 0, 3, 2)).to_not be
      expect(@battle_map.line_of_sight?(3, 2, 3, 0)).to_not be
      expect(@battle_map.line_of_sight?(0, 0, 3, 0)).to be
      expect(@battle_map.line_of_sight?(0, 0, 5, 0)).to_not be
      expect(@battle_map.line_of_sight?(5, 0, 0, 0)).to_not be
      expect(@battle_map.line_of_sight?(0, 0, 2, 2)).to be
      expect(@battle_map.line_of_sight?(2, 0, 4, 2)).to_not be
      expect(@battle_map.line_of_sight?(4, 2, 2, 0)).to_not be
      expect(@battle_map.line_of_sight?(1, 5, 3, 0)).to_not be
      expect(@battle_map.line_of_sight?(0, 0, 5, 5)).to be
      expect(@battle_map.line_of_sight?(2, 3, 2, 4)).to be
      expect(@battle_map.line_of_sight?(2, 3, 1, 4)).to be
      expect(@battle_map.line_of_sight?(3, 2, 3, 1)).to be
      expect(@battle_map.line_of_sight?(2, 3, 5, 1)).to_not be
    end

    specify "#spawn_points" do
      expect(@battle_map.spawn_points).to eq({
        "spawn_point_1" => { :location => [2, 3] },
        "spawn_point_2" => { :location => [1, 5] },
        "spawn_point_3" => { :location => [5, 0] },
      })
    end
  end

  context "other sizes test" do
    before do
      @battle_map = Natural20::BattleMap.new(session, "fixtures/battle_sim_3")
      @battle = Natural20::Battle.new(session, @battle_map)
      @fighter = Natural20::PlayerCharacter.load(session, File.join("fixtures", "high_elf_fighter.yml"))
      @npc = session.npc( :ogre, name: "grok")
      @goblin = session.npc( :goblin, name: "dave")
      @battle_map.place(0, 5, @fighter, "G")
      @battle_map.place(0, 1, @npc)
      @battle.add(@fighter, :a)
      @battle.add(@npc, :b)
    end

    it "renders token sizes correctly" do
      expect(@battle_map.render).to eq(
        "#######\n" +
        "O┐····#\n" +
        "└┘····#\n" +
        "####··#\n" +
        "······#\n" +
        "G·····#\n" +
        "·······\n")
    end

    specify "#placeable?" do
      @battle.add(@goblin, :b)
      @battle_map.place(1, 5, @goblin, "g")
      puts @battle_map.render
      expect(@battle_map.placeable?(@npc, 1, 4)).to_not be
    end
  end

  context "other objects" do
    before do
      @battle_map = Natural20::BattleMap.new(session, "fixtures/battle_sim_objects")
      @fighter = Natural20::PlayerCharacter.load(session, File.join("fixtures", "high_elf_fighter.yml"))
      @battle_map.place(0, 5, @fighter, "G")
    end

    it "renders door objects correctly" do
      expect(@battle_map.render(line_of_sight: @fighter)).to eq("       \n" +
        "       \n" +
        "       \n" +
        "       \n" +
        "#=#    \n" +
        "G`····#\n" +
        "##     \n")

        door = @battle_map.object_at(1, 4)
        door.open!

        expect(@battle_map.render(line_of_sight: @fighter)).to eq("       \n" +
          "       \n" +
          "  o    \n" +
          " ·#    \n" +
          "#-#    \n" +
          "G`····#\n" +
          "##     \n")
    end

    specify "#passable?" do
      door = @battle_map.object_at(1, 4)
      door.close!
      expect(@battle_map.passable?(@fighter, 1,4)).to_not be
    end

    specify "#objects_near" do
      door = @battle_map.object_at(1, 4)
      goblin = @battle_map.entity_at(1, 5)
      expect(goblin.dead?).to be
      expect(@battle_map.objects_near(@fighter).size).to eq(2)
      expect(@battle_map.objects_near(@fighter)).to eq([door, goblin])
    end
  end
end
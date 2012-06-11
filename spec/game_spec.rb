require './lib/game.rb'

describe Game do
  let(:board) { double("Board") }
  let(:player1) { double("Player", token: "X") }
  let(:player2) { double("Player", token: "O") }
  let(:game) do
    Board.stub(:new).and_return(board)
    Player.stub(:new).and_return(player1, player2)
    Game.new
  end
  
  describe "#new" do
    it "creates a new board" do
      Board.should_receive(:new).and_return(board)
      game.instance_variable_get(:@board).should == board
    end
    
    it "assigns two players" do
      Player.should_receive(:new).ordered.with("X", board).and_return(player1)
      Player.should_receive(:new).ordered.with("O", board).and_return(player2)
      game.instance_variable_get(:@player1).should == player1
      game.instance_variable_get(:@player2).should == player2
    end
    
    it "sets turn to 0" do
      game.instance_variable_get(:@turn).should == 0
    end
  end
  
  describe ".take_turn" do
    it "increments turn" do
      player1.stub(:move)
      game.take_turn
      game.instance_variable_get(:@turn).should == 1
    end
    
    context "odd turns" do
      it "player 1 moves" do
        game.instance_variable_set(:@turn, 0)
        player1.should_receive(:move)
        game.take_turn
      end
    end
    
    context "even turns" do
      it "player 2 moves" do
        game.instance_variable_set(:@turn, 1)
        player2.should_receive(:move)
        game.take_turn
      end
    end
  end
  
  describe ".winner" do
    it "calls .winner on board" do
      board.should_receive(:winner)
      game.winner
    end
  end
end
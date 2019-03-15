require_relative '00_tree_node'

class KnightPathFinder

  def self.valid_moves(pos)
    possible_moves = [[-1, 2], [-2, -1], [2, 1], [-2, 1], [1,2], [1,-2], [2, -1], [-1, -2]] 
    possible_moves.map!{|el| [pos[0] + el[0], pos[1] + el[1]]}
    possible_moves.select do |move|
      move.all?{|el| el < 8 && el >=0}
    end
  end

  def initialize(start_pos)
    @root_node = PolyTreeNode.new(start_pos)
    @considered_positions = [start_pos]
  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).select{|move| !@considered_positions.include? move}
    @considered_positions += new_moves
    return new_moves
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      first = queue.shift
      new_moves = new_move_positions(first.value).map{|move| PolyTreeNode.new(move)}
      new_moves.each{|el| first.add_child(el)}
      queue += new_moves
    end
  end
end
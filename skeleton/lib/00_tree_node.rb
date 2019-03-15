require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent, :children
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    @parent.children.delete(self) if @parent != nil
    @parent = parent
    @parent.children << self if parent!= nil
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    @children.include?(node) ? @children.delete(node) : raise("That is not a child of this node")
    node.parent = nil
  end

  def inspect
    @value
  end

  def dfs(target)
    return self if @value == target

    @children.each do |child|
      result = child.dfs(target)

      return result if result != nil
    end

    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      first = queue.shift
      if first.value == target
        return first
      end
      queue += first.children

    end
    nil
  end


end
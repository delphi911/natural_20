module AiController
  MAX_DISTANCE = 4_000_000
  # Path finding algorithm
  class PathCompute
    # Creates a path finder
    # @param battle [Natural20::Battle]
    # @param map [Natural20::BattleMap]
    # @param entity [Natural20::Entity]
    def initialize(battle, map, entity)
      @entity = entity
      @map = map
      @battle = battle
      @max_x, @max_y = @map.size
    end

    def build_structures(source_x, source_y)
      @pq = PriorityQueue.new
      @visited_nodes = Set.new

      @distances = @max_x.times.map do
        @max_y.times.map do
          MAX_DISTANCE
        end
      end

      @current_node = [source_x, source_y]
      @distances[source_x][source_y] = 0
      @visited_nodes.add(@current_node)
    end

    def backtrace(source_x, source_y, destination_x, destination_y, show_cost: false)
      path = []
      current_node = [destination_x, destination_y]
      return nil if @distances[destination_x][destination_y] == MAX_DISTANCE # no route!

      path << current_node
      cost = @distances[destination_x][destination_y]
      visited_nodes = Set.new
      visited_nodes.add(current_node)
      Kernel.loop do
        adjacent_squares = get_adjacent_from(*current_node)
        adjacent_squares += get_adjacent_from(*current_node, squeeze: true)

        min_node = nil
        min_distance = nil

        adjacent_squares.reject { |n| visited_nodes.include?(n) }.each do |node|
          line_distance = Math.sqrt((destination_x - node[0])**2 + (destination_y - node[1])**2)
          current_distance = @distances[node[0]][node[1]].to_f + line_distance / MAX_DISTANCE.to_f
          if min_node.nil? || current_distance < min_distance
            min_distance = current_distance
            min_node = node
          end
        end

        return nil if min_node.nil?

        path << min_node
        current_node = min_node
        visited_nodes.add(current_node)
        break if current_node == [source_x, source_y]
      end

      show_cost ? [path.reverse, cost] : path.reverse
    end

    def path(destination = nil)
      Kernel.loop do
        distance = @distances[@current_node[0]][@current_node[1]]

        adjacent_squares = get_adjacent_from(*@current_node)
        visit_squares(@pq, adjacent_squares, @visited_nodes, @distances, distance)

        # with squeezing into terrain
        squeeze_adjacent_squares = get_adjacent_from(*@current_node, squeeze: true)

        squeeze_adjacent_squares -= adjacent_squares

        unless squeeze_adjacent_squares.empty?
          visit_squares(@pq, squeeze_adjacent_squares, @visited_nodes, @distances, distance,
                        2)
        end

        break if destination && @current_node == destination

        @visited_nodes.add(@current_node)

        @current_node, node_d = @pq.pop
        break if @current_node.nil?

        return nil if node_d == MAX_DISTANCE
      end
    end

    # compute path using Djikstras shortest path
    def compute_path(source_x, source_y, destination_x, destination_y)
      build_structures(source_x, source_y)
      path([destination_x, destination_y])
      backtrace(source_x, source_y, destination_x, destination_y)
    end

    def incremental_path(source_x, source_y, destination_x, destination_y)
      rpath = backtrace(source_x, source_y, destination_x, destination_y, show_cost: true)
      return rpath if rpath && rpath.size > 1

      nil
    end

    # @param pq [PQueue]
    # @param adjacent_squares [Array<Array<Integer,Integer>>]
    def visit_squares(pq, adjacent_squares, visited_nodes, distances, distance, override_move_cost = nil)
      adjacent_squares.reject { |n| visited_nodes.include?(n) }.each do |node|
        move_cost = override_move_cost || @map.difficult_terrain?(@entity, node[0], node[1], @battle) ? 2 : 1
        current_distance = distance + move_cost
        distances[node[0]][node[1]] = current_distance if distances[node[0]][node[1]] > current_distance
        pq.add_node node, distances[node[0]][node[1]]
      end
    end

    def get_adjacent_from(pos_x, pos_y, squeeze: false)
      valid_paths = Set.new
      [-1, 0, 1].each do |x_op|
        [-1, 0, 1].each do |y_op|
          cur_x = pos_x + x_op
          cur_y = pos_y + y_op

          next if cur_x < 0 || cur_y < 0 || cur_x >= @max_x || cur_y >= @max_y
          next if x_op.zero? && y_op.zero?
          next unless @map.passable?(@entity, cur_x, cur_y, @battle, squeeze)

          valid_paths.add([cur_x, cur_y])
        end
      end

      valid_paths
    end
  end
end

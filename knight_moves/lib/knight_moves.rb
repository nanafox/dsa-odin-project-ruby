# frozen_string_literal: true

# Checks if a move is valid
#
# @param pos [Array<Integer>] The position to check
# @param visited [Array<Array<Boolean>>] The visited positions
# @return [Boolean] True if the move is valid, false otherwise
def valid_move?(pos, visited)
  x, y = pos
  x.between?(0, 7) && y.between?(0, 7) && !visited[x][y]
end

# Generate all possible moves for a knight from a given position
#
# @param position [Array<Integer>] The current position of the knight
# @return [Array<Array<Integer>>] The list of valid moves
def generate_possible_moves(position)
  moves = [
    [2, 1], [1, 2], [-1, 2], [-2, 1],
    [-2, -1], [-1, -2], [1, -2], [2, -1]
  ]
  x, y = position
  moves.map { |dx, dy| [x + dx, y + dy] }.select do |new_pos|
    new_pos.first&.between?(0, 7) && new_pos.last&.between?(0, 7)
  end
end

# Finds the shortest path a knight can take
#
# @param start [Array<Integer>] The starting position of the knight
# @param finish [Array<Integer>] The target position of the knight
# @return [Array<Array<Integer>>] The shortest path from start to finish
def knight_moves(start, finish)
  queue = [[start]]
  visited = Array.new(8) { Array.new(8, false) }
  visited[start[0]][start[1]] = true

  until queue.empty?
    path = queue.shift
    current_pos = path&.last

    return path if current_pos == finish

    generate_possible_moves(current_pos).each do |next_pos|
      if valid_move?(next_pos, visited)
        visited[next_pos[0]][next_pos[1]] = true
        queue << (path + [next_pos])
      end
    end
  end
end

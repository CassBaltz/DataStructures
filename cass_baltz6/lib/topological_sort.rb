require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  ordering = []
  explored = Set.new

  vertices.each do |vertex| # O(|v|)
    dfs!(vertex, explored, ordering) unless explored.include?(vertex)
  end

  ordering
end

def dfs!(vertex, explored, ordering)
  explored.add(vertex)

  vertex.out_edges.each do |edge| # O(|e|)
    new_vertex = edge.to_vertex
    dfs!(new_vertex, explored, ordering) unless explored.include?(new_vertex)
  end

  ordering.unshift(vertex)
end

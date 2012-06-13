require './grafo'

def create_brute_permutations grafo, subgrafo
  nodos_subgrafo = (0...subgrafo.size).to_a
  nodos_subgrafo = nodos_subgrafo + Array.new(grafo.size - subgrafo.size) { nil }
  nodos_subgrafo.permutation.to_a
end

# @param [Grafo] graph
# @param [Grafo] subgraph
# @return [Array]
def isomorphic_maps graph, subgraph, stop_on_first = false
  hypotetic_maps = create_brute_permutations graph, subgraph
  valid_maps = Array.new
  print "Total de hipoteses: "+hypotetic_maps.size.to_s
  hypotetic_maps.each do |hypotesis|
    garbage = false
    hypotesis.each_with_index do |y,x|
      next if y.nil?
      (0...graph.size).to_a.each do |i|
        next if hypotesis[i].nil?
        graph_value = graph.adjacencyTable[x][i]
        subgraph_value = subgraph.adjacencyTable[y][hypotesis[i]]
        garbage = true if graph_value != subgraph_value
        break if garbage
      end
      break if garbage
    end
    valid_maps << hypotesis if !garbage
    break if stop_on_first and !garbage
  end
  valid_maps
end

graph1 = Grafo.from_file ARGV[0]
graph2 = Grafo.from_file ARGV[1]
print "\nGrafos lidos com sucesso!\n"

stop_on_first = ARGV[2] == "all" ? false : true

grafo = (graph1.size >= graph2.size) ? graph1 : graph2
subgrafo = (graph1.size < graph2.size) ? graph1 : graph2
mapas = isomorphic_maps grafo, subgrafo, stop_on_first
if mapas.size > 0
  print "\nOs grafos sao isomorficos com o(s) seguinte(s) mapeamento(s): \n"
  mapas.uniq.each { |mapa|
    mapa.each_with_index { |y,x|
      y1 = y.nil? ? nil : y+1
      print "#{x+1} - #{y1}\n"
    }
    print "\n"
  }
  print "Total de mapeamentos #{mapas.size}, mapeamentos unicos: #{mapas.uniq.size}\n"

  File.open "saida.txt","w" do |buffer|
    mapas.first.each_with_index do |y,x|
      y1 = y.nil? ? "-" : y+1
      buffer.puts "#{x+1} #{y1}\n"
    end
  end

else
  print "\nOs grafos nao sao isomorficos\n"
end

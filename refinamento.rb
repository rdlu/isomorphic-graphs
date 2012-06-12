#cria as combinacoes que usarei como hipotese
# @param [Object] grafoMaior
# @param [Object] grafoMenor
def criaCombinacoes(grafo, subgrafo)
  combinationHash = Hash.new
  0.upto(grafoMaior.maxGrade) do |grau|
    #se nenhum dos dois possui vertice de determinado grau, entao pode pular
    if !grafoMaior.gradeSet.has_key? grau and !grafoMenor.gradeSet.has_key? grau
      next
    end
    if grafoMaior.gradeSet.has_key? grau and grafoMenor.gradeSet.has_key? grau
      #se o determinado grau existe nos dois grafos, entao cria o produto cartesiano
      combinationHash[grau] = grafoMaior.gradeSet[grau].to_a.product grafoMenor.gradeSet[grau].to_a
    else
      throw new Exception "Grafo nao tem chance de ser isomorfico, um deles nao possui vertices de grau "+x
    end
  end
  combinationHash
end

def cria_permutacoes_grau_n grafo, subgrafo, grau
  nodos_grafo = grafo.gradeSet[grau].to_a
  nodos_subgrafo = subgrafo.gradeSet[grau].to_a

  if nodos_grafo.size >= nodos_subgrafo.size
    nulos_a_inserir = Array.new(nodos_grafo.size - nodos_subgrafo.size) { nil }
    nodos_subgrafo = nodos_subgrafo + nulos_a_inserir
  else
    throw new Exception "Subgrafo tem mais vertices de determinado grau que o Grafo, nao eh isomorfico"
  end
  nodos_subgrafo.permutation.to_a
end

class Grafo
  attr_accessor :nodeGrades, :adjacencyTable, :gradeSet, :size, :maxGrade
  def initialize nodeGrades, adjacencyTable, gradeSet, matrixSize, maxGrade
    @nodeGrades = nodeGrades
    @adjacencyTable = adjacencyTable
    @gradeSet = gradeSet
    @size = matrixSize.to_i
    @maxGrade = maxGrade
  end

  # function readFileToGraph
  # le o arquivo texto em questao para o formato que irei usar no resto do codigo
  def self.from_file(filename)
    digraph = false
    file = File.new filename, "r"
    #le a primeira linha somente
    matrixSize = file.gets
    #todos os nodos recebem grau zero
    gradeArr = Array.new(matrixSize.to_i) { 0 }
    #cria uma array multidimensional do tamanho definido na primeira linha preenchido de zeros
    zeroLine = Array.new(matrixSize.to_i) { 0 }
    adjacencyMultiArray = Array.new(matrixSize.to_i) { zeroLine.clone }

    while line = file.gets
      lineArr = line.to_s.split(' ')
      nodeSource = lineArr[0].to_i - 1
      nodeDestination = lineArr[1].to_i - 1
      gradeArr[nodeSource] += 1
      adjacencyMultiArray[nodeSource][nodeDestination] = 1
      if !digraph
        gradeArr[nodeDestination] += 1
        adjacencyMultiArray[nodeDestination][nodeSource] = 1
      end
    end
    file.close

    #uma nova hash com os graus organizados por (grau -> conjunto de vertices)
    gradeSet = Hash[]
    maxGrade = 0
    gradeArr.each do |grade|
      gradeSet[grade] = Set.new
      maxGrade = (grade > maxGrade) ? grade : maxGrade
    end
    gradeArr.each_with_index do |grade,node|
      gradeSet[grade] << node
    end
    #retorno abaixo com graus dos vertices, tabela de adjacencia, conjuntos de vertices de um determinado grau e o maior grau
    self.new gradeArr, adjacencyMultiArray, gradeSet, matrixSize, maxGrade
  end

end
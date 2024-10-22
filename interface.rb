# Os presentes estão em uma array gifts no formato:
# gifts = [
#   {name: 'iPhone', bought: false, price: '$ 60'},
#   {name: 'Meia', bought: true, price: '$ 80'},
# ]

require 'csv'
require 'open-uri'
require 'nokogiri'

FILEPATH = 'gifts.csv'

def mark(gifts)
  # show ther list of gifts
  list(gifts)
  # Perguntar qual o número do presente a ser deletado da lista
  puts "Qual o numero a ser marcado como comprado? "
  index_gift = gets.chomp.to_i - 1
  if index_gift >= 0 && index_gift < gifts.count
    # mark if bought
    gift = gifts[index_gift] # => gift é um hash como {name: 'iPhone', bought: false}
    gift[:bought] = true # gift[:bought] é o value da chave :bought e atribuindo `true`

    save_csv(gifts)
  else
    puts "Número inválido!"
  end

end

def list(gifts)
  gifts.each_with_index do |gift,index|
    box = gift[:bought] ? "[X]" : "[ ]"
    puts "#{index+1} - #{box} #{gift[:name]} - Preço: #{gift[:price]}"
  end
end

def add(gifts)
  # Perguntar qual nome o presente a ser adicionado a lista
  puts "Qual o presente você quer adicionar a lista?"
  name = gets.chomp

  # Perguntar o preço do presente
  puts "Informe o valor do presente:"
  price = gets.chomp

  # adicionar o presente no array de gifts
  gifts << {name: name, bought: false, price: price}
  save_csv(gifts)
end

def delete(gifts)
  # Listar (exibir) todos os presentes
  list(gifts)
  # Perguntar qual o número do presente a ser deletado da lista
  puts "Qual o número do presente você quer remover da lista?"
  index_gift = gets.chomp.to_i - 1
  if index_gift >= 0 && index_gift < gifts.count
    # Remover do nosso array de gifts pelo index
    gifts.delete_at(index_gift)
    save_csv(gifts)
  else
    puts "Número inválido!"
  end
end

def import(gifts)
  # Perguntar o que está procurando
  puts "Qual produto está procurando?"
  product = gets.chomp

  # Fazer um scrape pelo produto está procurando
  url = "https://letsy.lewagon.com/products?search=#{product}"
  str = URI.parse(url).read
  doc = Nokogiri::HTML.parse(str)

  # Mostrar uma lista de produtos que podem ser importados
  products = []
  doc.search('li').each_with_index do |li, index|
    name = li.search('h2').text
    price = li.search('.price').text
    products << {name: name, price: price}

    puts "#{index + 1} - #{name} - #{price}"
  end

  # Perguntar qual o número do produto para importar
  puts "Qual o número do produto para importar?"
  index = gets.chomp.to_i - 1
  product = products[index]

  puts "Importando o produto #{product[:name]}"

  # Adicionar o produto no array de gifts
  gifts << {name: product[:name], bought: false, price: product[:price]}

end

def load_csv
  gifts = []
  if File.exist?(FILEPATH)
    CSV.foreach(FILEPATH) do |row|
      gifts << {name: row[0], bought: row[1] == "true", price: row[2]}
    end
  end
  gifts
end


def save_csv(gifts)
  CSV.open(FILEPATH, "wb") do |csv|
    gifts.each do |gift|
      # gift é um hash do tipo {name: 'meia', bought: false}
      csv << [gift[:name], gift[:bought], gift[:price]]
    end
  end
end

gifts = load_csv

# Mensagem de boas vindas
puts "Bem vindo a nossa lista de Natal!"

# LOOP
loop do
  # Perguntar qual opção deseja
  puts "Qual opção voce deseja executar?[list|add|delete|mark|import|quit]"
  action = gets.chomp
  # Executar de acordo com o escolhido
  case action
  when "list" then list(gifts)
  when "add" then add(gifts)
  when "delete" then delete(gifts)
  when "mark" then mark(gifts)
  when "import" then import(gifts)
  when "quit"
    # Sair se for quit
    break
  else
    puts "ação inválida"
  end

# FIM DO LOOP
end

# Mensagem de goodbye
puts "Obrigado por realizar a sua lista de natal!"

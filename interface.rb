require 'csv'
FILEPATH = 'gifts.csv'



def list(gifts)
  gifts.each_with_index do |gift,index|
    box = gift[:bought] ? "[X]" : "[ ]"
    puts "#{index+1} - #{box} #{gift[:name]}"
  end
end

def add(gifts)
  # Perguntar qual o presente a ser adicionado a lista
  puts "Qual o presente você quer adicionar a lista?"
  name = gets.chomp
  # adicionar o presente no array de gifts
  gifts << {name: name, bought: false}
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

def load_csv
  gifts = []
  if File.exist?(FILEPATH)
    CSV.foreach(FILEPATH) do |row|
      gifts << {name: row[0], bought: row[1] == "true"}
    end
  end
  gifts
end


def save_csv(gifts)
  CSV.open(FILEPATH, "wb") do |csv|
    gifts.each do |gift|
      # gift é um hash do tipo {name: 'meia', bought: false}
      csv << [gift[:name], gift[:bought]]
    end
  end
end

gifts = load_csv

# Mensagem de boas vindas
puts "Bem vindo a nossa lista de Natal!"

# LOOP
loop do
  # Perguntar qual opção deseja [list|add|delete|quit]
  puts "Qual opção voce deseja executar?[list|add|delete|quit]"
  action = gets.chomp
  # Executar de acordo com o escolhido
  case action
  when "list" then list(gifts)
  when "add" then add(gifts)
  when "delete" then delete(gifts)
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

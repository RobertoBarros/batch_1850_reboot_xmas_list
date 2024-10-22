gifts = []

def list(gifts)
  gifts.each_with_index do |gift,index|
    puts "#{index+1} - #{gift}"
  end
end

def add(gifts)
  # Perguntar qual o presente a ser adicionado a lista
  puts "Qual o presente você quer adicionar a lista?"
  add_gift = gets.chomp
  # adicionar o presente no array de gifts
  gifts << add_gift
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
  else
    puts "Número inválido!"
  end
end

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

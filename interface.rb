def list(gifts)
  gifts.each_with_index do |gift,index|
    puts "#{index+1} - #{gift}"
  end
end

# Mensagem de boas vindas
puts "Bem vindo a nossa lista de Natal!"
gifts = ["bike", "t-shirt", "doll", "ted bear", "iphone 16", "chocolate"]
# LOOP
loop do
  # Perguntar qual opção deseja [list|add|delete|quit]
  puts "Qual opção voce deseja executar?[list|add|delete|quit]"
  action = gets.chomp
  # Executar (fake) de acordo com o escolhido
  case action
  when "list"
    list(gifts)
  when "add"
    puts "Adcionando um presente na lista"
  when "delete"
    puts "deletando presente da lista"
  when "quit"
    break
  else
    puts "ação inválida"
  end
  # Sair se for quit

end
# END

# Mensagem de goodbye
puts "Obrigado por realizar a sua lista de natal!"

require 'titulo_eleitoral/version'
require 'titulo_eleitoral/numero_inscricao'

module TituloEleitoral
  def self.valido?(numero)
    numero_inscricao(numero).valido?
  end

  def self.numero_inscricao(numero)
    NumeroInscricao.new(numero)
  end

  def self.uf(numero)
    numero_inscricao(numero).uf
  end
end
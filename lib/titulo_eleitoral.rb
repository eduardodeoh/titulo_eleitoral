require 'titulo_eleitoral/version'
require 'titulo_eleitoral/numero_inscricao'

module TituloEleitoral
  def self.valido?(numero)
    numero_inscricao(numero).valido?
  end

  def self.numero_inscricao(numero)
    NumeroInscricao.new(numero)
  end

  def self.codigo_uf(numero)
    numero_inscricao(numero).codigo_uf
  end

  def self.sigla_uf(numero)
    numero_inscricao(numero).sigla_uf
  end
end
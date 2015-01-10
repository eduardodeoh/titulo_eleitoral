require_relative 'test_helper'

describe TituloEleitoral::NumeroInscricao do

  describe 'dado o número de inscrição válido - 316820550159' do
    before do
      @valor = 316820550159
      @numero = TituloEleitoral::NumeroInscricao.new(@valor)
    end

    it 'deve ser válido' do
      @numero.valido?.must_equal true
    end

    it 'deve retornar DV1 == 5' do
      @numero.dv1.must_equal 5
    end

    it 'deve retornar DV2 == 9' do
      @numero.dv2.must_equal 9
    end

    it 'deve retornar código UF == 01' do
      @numero.codigo_uf.must_equal '01'
    end

    it 'deve retornar sigla UF == SP' do
      @numero.sigla_uf.must_equal 'SP'
    end

    it 'deve retornar número original como array de strings' do
      @numero.numero_original.must_be_instance_of Array
    end

    it 'deve retornar número como array de strings sem preenchimento de zeros à esquerda' do
      teste = @valor.to_s.split('')
      @numero.numero.must_equal teste
    end
  end

  describe 'dada uma string válida com 12 dígitos' do
    before do
      @valor2 = '316820550159'
      @numero2 = TituloEleitoral::NumeroInscricao.new(@valor2)
    end

    it 'deve ser válido' do
      @numero2.valido?.must_equal true
    end
  end

  describe 'dado o número - 67735700132 - com menos de 12 dígitos' do
    before do
      @valor3 = 67735700132
      @numero3 = TituloEleitoral::NumeroInscricao.new(@valor3)
    end

    it 'deve retornar número como array de strings com preenchimento de zeros à esquerda' do
      teste = @valor3.to_s.split('').unshift('0')
      @numero3.numero.must_equal teste
    end
  end

  describe 'dada a string "0677357001321" com mais de 12 dígitos' do
    before do
      @valor4 = '0677357001321'
      @numero4 = TituloEleitoral::NumeroInscricao.new(@valor4)
    end

    it 'número de inscrição deve ser inválido' do
      @numero4.valido?.must_equal false
    end
  end

  describe 'dada a string "6773570013AB" com dígitos e letras' do
    before do
      @valor5 = '6773570013AB'
      @somente_numeros = '6773570013'
      @numero5 = TituloEleitoral::NumeroInscricao.new(@valor5)
    end

    it 'número inscrição deve ser inválido' do
      @numero5.valido?.must_equal false
    end

    it 'número original deve ser uma array contendo apenas número' do
      @numero5.numero_original.must_equal @somente_numeros.to_s.split('')
    end

     it 'número deve ser um array de 12 elementos preenchido com zeros à esquerda quando necessário' do
       @numero5.numero.must_equal @somente_numeros.rjust(12, '0').split('')
     end
  end

  describe 'dada uma string válida de 12 dígitos e dígitos da UF menores que 01 ou maiores que 28' do
    it 'dígitos da UF menor que 01 retorna nil' do
      numero = TituloEleitoral::NumeroInscricao.new('067735700032')
      numero.codigo_uf.must_be_nil
    end

    it 'dígitos da UF maior que 28 retorna nil' do
      numero = TituloEleitoral::NumeroInscricao.new('067735702932')
      numero.codigo_uf.must_be_nil
    end
  end

  describe 'dada a string formatada "3168.2055.0159"' do
    before do
      @valor6 = '3168.2055.0159'
      @numero6 = TituloEleitoral::NumeroInscricao.new(@valor6)
    end

    it 'deve ser válido' do
      @numero6.valido?.must_equal true
    end
  end

  describe 'dado um número de inscrição com UF SP ou MG e resto 0 durante cálculo do DV1 ou DV2' do
    it 'deve retornar como resultado o valor 1 e não 0' do
      numero = TituloEleitoral::NumeroInscricao.new(113382030116)
      numero.dv1.must_equal 1
    end
  end

  describe 'dado um número de inscrição com UF diferente de SP ou MG e resto 0 durante cálculo do DV1 ou DV2' do
    it 'deve retornar como resultado o valor igual ao resto da divisão e não 1' do
      numero = TituloEleitoral::NumeroInscricao.new(113382030308)
      numero.dv1.must_equal 0
    end
  end
end
class ImcController < ApplicationController
  skip_before_action :verify_authenticity_token

  def calcular
    nome = params[:nome]
    peso = params[:peso].to_f
    altura = params[:altura].to_f
    idade = params[:idade].to_i

    imc = peso / (altura * altura)
    peso_ideal_min = 18.5 * (altura * altura)
    peso_ideal_max = 24.9 * (altura * altura)

    message = if imc < 18.5
                "Atenção #{nome}, você está abaixo do peso."
    elsif imc >= 18.5 && imc < 24.9
                "Parabéns #{nome}, você está com peso normal."
    elsif imc >= 25 && imc < 29.9
                "Puxa vida #{nome}, você está com sobrepeso."
    else
                "#{nome}, infelizmente você está com obesidade. Procure um médico."
    end

    render json: {
      imc: imc.round(2),
      peso_ideal_min: peso_ideal_min.round(2),
      peso_ideal_max: peso_ideal_max.round(2),
      message: message
    }
  end
end

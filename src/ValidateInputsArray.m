function [inputValue] = ValidateInputsArray(inputFieldValue, inputName, engine)
% Function that validate the inputs that can be either a single number or an
% array of numbers
%   The function checks if the input is valid and if the input is Mach it
%   populates an array from the starting value to the ending value

inputNumber = str2num(inputFieldValue);

if (~isnumeric(inputNumber) || isempty(inputNumber))
    errordlg(['Digite um valor válido para ' ...
        inputName ...
        ': valor ou [valor_inicial, valor_final] ou [valor1, valor2, valor3,...]'],...
        ['Erro em ' inputName 'do motor ' engine])
elseif (length(inputNumber) == 2 && (strcmpi(inputName, 'mach') || strcmpi(inputName, 'FlightRegimeValue')))
    inputValue = linspace(inputNumber(1), inputNumber(2), 50);
else
    inputValue = inputNumber;
end


end


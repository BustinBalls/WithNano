function InitiateArduino()
global arduinoUno 
try
    readDigitalPin(arduinoUno,'D10');
catch
    try
        arduinoUno = arduino('COM8','uno');
    catch
        try
            arduinoUno=arduino('COM6','uno');
        catch
            try
                arduinoUno=arduino('COM7','uno');
            catch
                try
                    arduinoUno=arduino('COM5','uno');
                catch
                    try
                        arduinoUno=arduino('COM4','uno');
                    catch
                        disp('No Arduino found')
                    end
                end
            end
        end
    end
end
configurePin(arduinoUno,'D8','pullup')
end
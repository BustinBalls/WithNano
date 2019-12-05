function Stepper2Back()

global arduinoUno ballScrewBack 
try
    readDigitalPin(arduinoUno,'D8');
catch
    InitiateArduino()
end

for i=1:ballScrewBack
    %% Move Reverse
    writeDigitalPin(arduinoUno,'D4',1);
    writePWMDutyCycle(arduinoUno,'D3',0.7);
end
writeDigitalPin(arduinoUno,'D3',0);
end

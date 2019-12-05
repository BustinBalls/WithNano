function Stepper2Front()
global  arduinoUno 
%ESTOP WILL BE ADDED to cut all motor power set to pin 2 as NO set LOW
try
    readDigitalPin(arduinoUno,'D8');
catch
    InitiateArduino()
end


atHome=readDigitalPin(arduinoUno,'D8');
while atHome==1
    %reads until limit switch is Low, used on a normally open switch with a internal Pullup Resistor
    writeDigitalPin(arduinoUno,'D4',0);
    writePWMDutyCycle(arduinoUno,'D3',0.7);
    atHome=readDigitalPin(arduinoUno,'D8');
end
writeDigitalPin(arduinoUno,'D3',0);
end

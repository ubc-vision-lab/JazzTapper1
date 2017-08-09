function funDigGrabber()
%analogin.h - polls interface kit for analog data on given sensor number
    
    
    global handle;
    global matBeat;
    global x;
    global current_half;

    %global iPlaying;
  
        
      dataptr = libpointer('int32Ptr',0);
      %get the value, make sure it's valid
      m=7;
      
      if calllib('phidget21', 'CPhidgetInterfaceKit_getSensorValue', handle, m, dataptr) == 0;
         %disp(get(dataptr, 'Value'));
         vvv = get(dataptr, 'Value');
         %fprintf('i: %d, v: %d\n', m, vvv)
         %matBeat(1,x)=iPlaying;

         matBeat(1,x)=vvv;
         matBeat(2,x)=current_half;
      end
      
      x=x+1;
      
      
%       if(mod(x,1000))
%            disp(vvv)
%       end
           
end



     
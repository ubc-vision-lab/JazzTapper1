function funLoadPhifget()

 global handle;

   loadlibrary('/Library/frameworks/Phidget21.framework/Versions/Current/Phidget21', 'phidget21matlab_unix.h', 'alias', 'phidget21');

   %ptr = libpointer('int32Ptr',0);
 
   %calllib('phidget21', 'CPhidgetInterfaceKit_create', ptr);

   %handle = get(ptr, 'Value');

   %calllib('phidget21', 'CPhidget_open', handle, -1);

   handle = libpointer('int32Ptr'); 
    calllib('phidget21', 'CPhidgetInterfaceKit_create', handle);
    calllib('phidget21', 'CPhidget_open', handle, -1);

end
function mytimmer() {
   var mydate = new Date();
   y = mydate.getFullYear();
   z = mydate.getMonth();
   w = mydate.getDay();
   d = mydate.getDate();
   h = mydate.getHours();
   m = mydate.getMinutes();
   s = mydate.getSeconds();
  
  all = h +":"+ m +":"+s 
 document.getElementById("logo").innerHTML = all ;
 setTimeout("mytimmer()", 100);
 }
mytimmer();
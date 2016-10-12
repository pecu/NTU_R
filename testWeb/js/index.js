function timer(){
  var date= new Date();
  
  y= date.getFullYear();
  m= date.getMonth();
  w= date.getDay();
  d= date.getDate();
  h= date.getHours();
  mi= date.getMinutes();

  
  day= y+ "/"+ m+ "/"+ d+" "+ h+ ":"+ mi
  
  document.getElementById("clock").innerHTML= day;
  
  setTimeout("timer()", 1000); 
}
timer();
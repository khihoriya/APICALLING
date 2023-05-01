var http=require('http');
http.createServer(function(req,res){
   res.write('Hello\n');
   res.end('World');
}).listen(8080);

var http=require('http');
var fs=require('fs');
http.createServer(function(req,res){
   fs.readFile('ajax_info.txt',function(err,data){
     if(err)
        throw err;
     res.write(data);
     res.end();
   });
}).listen(8080);
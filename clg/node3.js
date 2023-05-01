var fs=require('fs');
fs.open('f1.txt','w',function(err,file){
    if(err)
         throw err;
    console.log('File is created\n');
});
   fs.writeFile('f1.txt','Good Morning',function(err){
     if(err)
        throw err;
     console.log('Saved');
   });
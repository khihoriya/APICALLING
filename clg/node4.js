var fs=require('fs');
fs.rename('f1.txt','f2.txt',function(err){
    if(err)
         throw err;
    console.log('File is Renamed');
});
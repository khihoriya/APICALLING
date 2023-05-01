var fs=require('fs');
fs.unlink('f2.txt',function(err){
    
    console.log('File is Deleted');
});
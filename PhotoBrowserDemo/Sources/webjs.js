function setImage(){
    var imgs = document.getElementsByTagName("img");
    for (var i=0;i<imgs.length;i++){
    	imgs[i].setAttribute("onClick","imageClick("+i+")");
    }
}
function imageClick(i){
    var rect = getImageRect(i);
    var url="clickgirl::"+i+"::"+rect;
    document.location = url;
}
function getImageRect(i){
    var imgs = document.getElementsByTagName("img");
    var rect;
    rect = imgs[i].getBoundingClientRect().left+"::";
    rect = rect+imgs[i].getBoundingClientRect().top+"::";
    rect = rect+imgs[i].width+"::";
    rect = rect+imgs[i].height;
    return rect;
}
function getAllImageUrl(){
    var imgs = document.getElementsByTagName("img");
    var urlArray = [];
    for (var i=0;i<imgs.length;i++){
    	var src = imgs[i].src;
    	urlArray.push(src);
    }
    return urlArray.toString();
}
function getImageData(i){
    var imgs = document.getElementsByTagName("img");
    var img=imgs[i]; 
    return img.src; 
}
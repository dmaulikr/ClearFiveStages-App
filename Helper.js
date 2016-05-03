Array.prototype.clear=function(){
    this.length=0;
}
Array.prototype.insertAt=function(index,obj){
    this.splice(index,0,obj);
}
Array.prototype.removeAt=function(index){
    this.splice(index,1);
}
Array.prototype.remove=function(obj){
    var index=this.indexOf(obj);
    if (index>=0){
        this.removeAt(index);
    }
}

Array.prototype.contains = function(obj) {
    var i = this.length;
    while (i--) {
        if (this[i] === obj) {
            return true;
        }
    }
    return false;
}

String.prototype.format = function() {
    var formatted = this;
    for (var i = 0; i < arguments.length; i++) {
        var regexp = new RegExp('\\{'+i+'\\}', 'gi');
        formatted = formatted.replace(regexp, arguments[i]);
    }
    return formatted;
};

Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    } return size;
};

function newFilledArray(length, val) {
    var array = [];
    for (var i = 0; i < length; i++) {
        array[i] = val;
    }
    return array;
}
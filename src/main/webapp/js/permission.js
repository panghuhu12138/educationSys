Vue.directive('has',{
    bind : function(el,binding){

        //须要在DOM更新完成之后再执行如下代码，否则经过 el.parentNode 获取不到父节点，由于此时尚未绑定到

        Vue.nextTick(function(){
            var value = binding.value
            if(!Vue.prototype.$_has(value)){
                el.parentNode.removeChild(el);
            }
        })
    }
})

Vue.prototype.$_has = function(key){
    if (sessionStorage.getItem('permission') != null) {
        //当前角色能够从cookie中获取
        var permission = sessionStorage.getItem('permission');
        if(Array.isArray(key)){
            return permission.some(function(ele){
                return key.indexOf(ele) >= 0;
            })
        }else{
            return permission.indexOf(key) >= 0;
        }
    } else {
        return false;
    }
}
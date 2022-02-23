/**
 * 通用验证方法 修改请谨慎
 */
String.prototype.checkInput = function (data) { 
	var val=$.trim(this);
	var msg="";
	var name=data["name"];
	if(data["emp"]){//验证是否为空                         如   "string".checkInput({name:"姓名",emp:{msg:"姓名不能为空"}})   //有msg属性 会优先显示
       var option= data["emp"];
       if(val==undefined || val.length<=0){
    	   //当前验证字符串的 显示名
           	msg=name+"不能为空！"
    	   if(option["msg"]){//完整提示语   优先提示此项
        	msg=option["msg"];
           }
    	   alert(msg);
    	   return false;
       }
     }
	
	if(data["len"]){//验证字符长度				   如   "string".checkInput({name:"姓名",len:{msg:"姓名只能为10-20个字符",max:20,min:10}})   //有msg属性 会优先显示
	       var option= data["len"];
	       var varlen=val.length;
	       var errornum=0;//验证错误标识数    大于1则验证不通过
	       if(option["min"]){
	    	   if(option["min"]>varlen){
	    		   msg=name+"不能小于"+option["min"]+"个字符!";
	    		   errornum++;
	    	   }
	       }
	       if(option["max"]){
	    	   if(option["max"]<varlen){
	    		   msg=name+"不能大于"+option["max"]+"个字符!";
	    		   errornum++;
	    	   }
	       }
	       if(option["max"]&&option["min"]){
	    	   if(option["max"]<varlen){
	    		   msg=name+"必须为"+option["min"]+"-"+option["max"]+"个字符!";
	    		   errornum++;
	    	   }
	       }
	       
	       if(errornum>0){
	    	   if(option["msg"]){//完整提示语   优先提示此项
	        	msg=option["msg"];
	           }
	    	   alert(msg);
	    	   return false;
	       }
	     }
	
		if(data["num"]){  //验证数字     如   "string".checkInput({name:"年龄",num:{msg:"年龄必须为数字"}})
			var option= data["num"];
			var reg = /^\d+(\.\d+)?$/;
			if (!reg.test(val)) {
				msg=name+"必须为数字！"
				if(option["msg"]){//完整提示语   优先提示此项
		        	msg=option["msg"];
		           }
				 alert(msg);
		    	 return false;
			}
		
		}
		
		return true;
	
	//      /^\d+(\.\d+)?$/    0  正整数与小数 
	 
};
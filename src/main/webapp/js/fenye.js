function jumpto(){
	var jumpno=$("#jumpno").val();
	var r=/^\+?[1-9][0-9]*$/; 
	if(r.test(jumpno)){
		if(jumpno>=1&&jumpno<=param.pageCount){
		loadData(jumpno)
		}
	}
}
function goPage(pno){
	if(pno>=1&&pno<=param.pageCount){
	loadData(pno);
	}
	}


//模板处理
function heredoc(fn) {
  return fn.toString().split('\n').slice(1,-1).join('\n') + '\n'
}
//模板数据  非注释


//模板数据  非注释
var tmpl = heredoc(function(){/*
 <td class="fy_menu" height="40" align="right" style="padding-right: 5px; line-height: 40px;">
                  <p class="gjts" style="text-align: left; float: left; padding-left:5px; height: 40px;">共计<span>[num]</span>条</p>
                  <button onClick="goPage([currentPage]-1)" >上一页</button>
                  <a href="#" onClick="goPage(1)" class="active">1</a> <a href="#"  onClick="goPage(2)>2</a> <a href="#" onClick="goPage(3)>3</a> <a href="#"  onClick="goPage(4)>4</a> <a
                    href="#">5</a> <button <a href="#" onClick="goPage([currentPage]+1)">下一页</a> >下一页</button> 共  <span>[totalPage]</span> 页 &nbsp;&nbsp;&nbsp;跳转到
                </td>
                <td width="40" align="center"><input id="jumpno" name="textfield8" type="text" class="inp_w4" id="textfield8" />
                </td>
                <td width="35" align="left"><a href="#" id="go">GO</a></td>
                */});





function pagerow(cpage,totalpage,totalitem){
	alert(1)
	 var pageStr=tmpl.replace(new RegExp("\\[currentPage\\]","g"),cpage).replace(new RegExp("\\[totalPage\\]","g"),totalpage).replace(new RegExp("\\[num\\]","g"),totalitem).replace(new RegExp("\\[pageSize\\]","g"),10);
	     $("#page").html("").html(pageStr);
	     $("#pageSize").val(10);
	
}
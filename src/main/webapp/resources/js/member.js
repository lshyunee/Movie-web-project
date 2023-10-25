//console.log("Member Module...");
var memberService = (function(){
	
	function remove(userid, callback, error){
		$.ajax({
				url : '/modifyM/'+ userid,
				data : JSON.stringify({
					userid : userid
				}),
				dataType : 'text',
				type : 'delete',
				success : function(result, status, xhr) {
					
					if(callback){
						callback(result);
					}
				},
				error:function(xhr, status,er){
					if(error){error(er)};
				}
			});//end Ajax
	}//remove
	
	function update(member, callback, error){
		$.ajax({
			type:'put',
			url:'/modifyM/' + member.userid,
			data:JSON.stringify(member),
			contentType:'application/json;charset=UTF-8',
			success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status,er){
				if(error){error(er)};
			}
		});	
	}
	
	function get(userid, callback, error){
		$.get("/modifyM/" + userid + ".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status,er){
			if(error){
				error(er);
			}
		});
	}
	
	function displayTime(timeValue){
	var today = new Date();
	var gap = today.getTime() - timeValue;
	var dateObj = new Date(timeValue);
	var str = "";
	if(gap < (1000 * 60 * 60 * 24)){
		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		var ss = dateObj.getSeconds();
		
		return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss ].join('');
	} else {
		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth() + 1;	//getMonth() is zero-based
		var dd = dateObj.getDate();
		
		return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
	}
}

return {
    remove:remove,
    update:update,
    get:get,
    displayTime:displayTime
};

})();
function addShopCar(goodsId, userId) {
	$.ajax({
		url : "${pageContext.request.contextPath}/addShopCar.action",
		type : "post",
		data : {
			'goodsId' : goodsId,
			'userId' : userId
		},
		success : function(data) {
			alert(data);
			window.location.reload();
			if (data == "ok") {
				layer.msg("已成功添加到购物车", {
					icon : 1,
					time : 1000
				});
			} else {
				layer.msg("添加失败", {
					icon : 2,
					time : 1000
				});
			}
		}
	})
}
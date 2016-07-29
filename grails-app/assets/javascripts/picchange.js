$(function(){
	// 入库与订单
	changepic('.i_order .view_l .l_storage','0 -30px','0 0');//入库
	changepic('.i_order .con_commodity','0 -90px','0 -60px');//商品入库
	changepic('.i_order .con_crowd','0 -150px','0 -120px');//众筹入库
	changepic('.i_order .view_r .r_top .top_order','0 -210px','0 -180px');//订单
	changepic('.i_order .view_r .l_top','0 -270px','0 -240px');//订单管理
	changepic('.i_order .view_r .b_ordermanagement','0 -330px','0 -300px');//众筹订单管理
	changepic('.i_order .view_r .b_npayment','0 -390px','0 -360px');//未付款
	changepic('.i_order .view_r .b_untreated','0 -450px','0 -420px');//未处理
	changepic('.i_order .view_r .b_delivery','0 -510px','0 -480px');//代发货
	changepic('.i_order .view_r .b_okgoods','0 -570px','0 -540px');//已发货
	changepic('.i_order .view_r .b_allgoods','0 -630px','0 -600px');//已发货
	// 运营工具
	changepic('.tools .o_tools_view .view_banner','0 -690px','0 -660px');//banner管理
	changepic('.tools .o_tools_view .view_activity','0 -750px','0 -720px');//活动管理
	changepic('.tools .o_tools_view .view_label','0 -810px','0 -780px');//标签管理
	changepic('.tools .o_tools_view .view_count','0 -870px','0 -840px');//运营统计
	changepic('.tools .o_tools_view .view_data','0 -930px','0 -900px');//站点数据
	// 进销存出入库
	changepic('.inventory .con_l .l_storage','0 -990px','0 -960px');//入库
	changepic('.inventory .con_l .b_supplier','0 -1050px','0 -1020px');//供应商管理
	changepic('.inventory .con_l .b_commodity','0 -1110px','0 -1080px');//商品管理
	changepic('.inventory .con_l .b_sauditing','0 -1170px','0 -1140px');//供应商审核
	changepic('.inventory .con_l .b_cauditing','0 -1230px','0 -1200px');//供应商品审核
	changepic('.inventory .con_c .c_order','0 -1290px','0 -1260px');//订单
	changepic('.inventory .con_c .b_ordermanage','0 -1350px','0 -1320px');//订单管理
	changepic('.inventory .con_c .b_successorder','0 -1410px','0 -1380px');//完成订单
	changepic('.inventory .con_r .r_top_t','0 -1470px','0 -1440px');//出库
	changepic('.inventory .con_r .r_b_left .l_top','0 -1530px','0 -1500px');//统计
	changepic('.inventory .con_r .r_b_left .b_purchase','0 -1590px','0 -1560px');//采购统计
	changepic('.inventory .con_r .r_b_left .b_finance','0 -1650px','0 -1620px');//财务统计
	changepic('.inventory .con_r .r_b_right .r_top','0 -1710px','0 -1680px');//退货退款
	changepic('.inventory .con_r .r_bottom .r_goodsmanage','0 -1770px','0 -1740px');//退货管理

	function changepic(selector,after,before){
		$(selector).mouseover(function(){
			$(selector+' i').css('background-position',after);
		}).mouseout(function(){
			$(selector+' i').css('background-position',before);
		});
	}
});
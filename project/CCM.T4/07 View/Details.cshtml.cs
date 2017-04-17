@{
    ViewBag.Title = "Details";
    Layout = "~/Views/Shared/_Form.cshtml";
}
<script>
    var keyValue = $.request("keyValue");
    $(function () {
        initControl();
        $.ajax({
            url: "/rtmManage/RTM01/GetFormJson",
            data: { keyValue: keyValue },
            dataType: "json",
            async: false,
            success: function (data) {
                $("#form1").formSerialize(data);
                $("#form1").find('.form-control,select,input').attr('disabled', 'disabled');
                $("#form1").find('div.ckbox label').attr('for', '');
            }
        });
    });
    function initControl() {
        $("#F_OrganizeId").bindSelect({
            url: "/SystemManage/Organize/GetTreeSelectJson",
        });
    }

	 $(function () {
        $('.wrapper').height($(window).height() - 11);
    })
</script>
<div class="wrapper">
    <ul class="nav nav-tabs">
        <li class="active"><a href="#a" data-toggle="tab">基本資訊</a></li>
        <li><a href="#b" data-toggle="tab">擴展資訊</a></li>
    </ul>
    <div class="tab-content" style="padding-top: 5px;">
        <div id="a" class="tab-pane active" style="padding: 5px;">
            <div style="padding-top: 5px; margin-right: 5px;">
			<form id="form1">
				<div style="padding-top: 20px; margin-right: 20px;">
					<table class="form">
					<tr>
							<th class="formTitle">COL_SAMPLE</th>
							<td class="formValue">
								<input id="COL_SAMPLE" name="COL_SAMPLE" type="text" class="form-control required" placeholder="請輸入值" />
								<select id="COL_SAMPLE" name="COL_SAMPLE" class="form-control required"></select>
								<input id="GUID" name="GUID" type="hidden" value="" />
							</td>
               
						</tr>
												<tr>
							<th class="formTitle">機台主鍵</th>
							<td class="formValue">
								<input id="F_Id" name="F_Id" type="text" class="form-control required" placeholder="請輸入值" />
							</td>
						</tr>
												<tr>
							<th class="formTitle">機台編號</th>
							<td class="formValue">
								<input id="F_Machine_ID" name="F_Machine_ID" type="text" class="form-control required" placeholder="請輸入值" />
							</td>
						</tr>
												<tr>
							<th class="formTitle">機型</th>
							<td class="formValue">
								<input id="F_Machine_Model" name="F_Machine_Model" type="text" class="form-control required" placeholder="請輸入值" />
							</td>
						</tr>
												<tr>
							<th class="formTitle">機種</th>
							<td class="formValue">
								<input id="F_Machine_Type" name="F_Machine_Type" type="text" class="form-control required" placeholder="請輸入值" />
							</td>
						</tr>
												<tr>
							<th class="formTitle">接收IP</th>
							<td class="formValue">
								<input id="F_ADC_IP_Address" name="F_ADC_IP_Address" type="text" class="form-control required" placeholder="請輸入值" />
							</td>
						</tr>
												<tr>
							<th class="formTitle">備註</th>
							<td class="formValue">
								<input id="F_Remark" name="F_Remark" type="text" class="form-control required" placeholder="請輸入值" />
							</td>
						</tr>
												<tr>
							<th class="formTitle">創建日期</th>
							<td class="formValue">
								<input id="F_CreatorTime" name="F_CreatorTime" type="text" class="form-control required" placeholder="請輸入值" />
							</td>
						</tr>
												<tr>
							<th class="formTitle">創建用戶主鍵</th>
							<td class="formValue">
								<input id="F_CreatorUserId" name="F_CreatorUserId" type="text" class="form-control required" placeholder="請輸入值" />
							</td>
						</tr>
												<tr>
							<th class="formTitle">最後修改時間</th>
							<td class="formValue">
								<input id="F_LastModifyTime" name="F_LastModifyTime" type="text" class="form-control required" placeholder="請輸入值" />
							</td>
						</tr>
												<tr>
							<th class="formTitle">最後修改用戶</th>
							<td class="formValue">
								<input id="F_LastModifyUserId" name="F_LastModifyUserId" type="text" class="form-control required" placeholder="請輸入值" />
							</td>
						</tr>
						           
					</table>
				</div>
			</form>
		</div>
</div>
<div id="b" class="tab-pane " style="padding: 5px;">
            <div style="padding-top: 5px; margin-right: 5px;">
                <form id="form2">
                    <table  class="form">
                        <tr>
                            <th class="formTitle">創建日期</th>
                            <td class="formValue">
                                <input id="F_CreatorTime" name="F_CreatorTime" type="text" class="form-control "  disabled="disabled" />
                            </td>
                            <th class="formTitle">創建用戶主鍵</th>
                            <td class="formValue">
                                <select id="F_CreatorUserId" name="F_CreatorUserId" class="form-control"  disabled="disabled">
                                    <option></option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="formTitle">最後修改時間</th>
                            <td class="formValue">
                                <input id="F_LastModifyTime" name="F_LastModifyTime" type="text" class="form-control "  disabled="disabled" />
                            </td>
                            <th class="formTitle">最後修改用戶</th>
                            <td class="formValue">
                                <select id="F_LastModifyUserId" name="F_LastModifyUserId" class="form-control" disabled="disabled">
                                    <option></option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>



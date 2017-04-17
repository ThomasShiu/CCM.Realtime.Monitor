﻿@{
    ViewBag.Title = "Index";
    Layout = "~/Views/Shared/_Index.cshtml";
}
<script>
    $(function () {
        gridList();
    })
    function gridList() {
        var $gridList = $("#gridList");
        $gridList.dataGrid({
            url: "/rtmManage/RTM01/GetGridJson",
            height: $(window).height() - 128,
            colModel: [
					{ label: "F_Id", name: "F_Id", hidden: true, key: true, width: 80, align: 'left' },
			       { label: "機台主鍵", name: "F_Id", width: 80, align: 'left' },
		            { label: "機台編號", name: "F_Machine_ID", width: 80, align: 'left' },
		            { label: "機型", name: "F_Machine_Model", width: 80, align: 'left' },
		            { label: "機種", name: "F_Machine_Type", width: 80, align: 'left' },
		            { label: "接收IP", name: "F_ADC_IP_Address", width: 80, align: 'left' },
		            { label: "備註", name: "F_Remark", width: 80, align: 'left' },
		            { label: "創建日期", name: "F_CreatorTime", width: 80, align: 'left' },
		            { label: "創建用戶主鍵", name: "F_CreatorUserId", width: 80, align: 'left' },
		            { label: "最後修改時間", name: "F_LastModifyTime", width: 80, align: 'left' },
		            { label: "最後修改用戶", name: "F_LastModifyUserId", width: 80, align: 'left' },
		     				
            ],
			pager: "#gridPager",
            sortname: 'SID asc,CreatorTime desc',
            viewrecords: true
        });
        $("#btn_search").click(function () {
            $gridList.jqGrid('setGridParam', {
                postData: { keyword: $("#txt_keyword").val() },
            }).trigger('reloadGrid');
        });
    }
    function btn_add() {
        $.modalOpen({
            id: "Form",
            title: "新增",
            url: "/rtmManage/RTM01/Form",
            width: "640px",
            height: "400px",
            callBack: function (iframeId) {
                top.frames[iframeId].submitForm();
            }
        });
    }
    function btn_edit() {
        var keyValue = $("#gridList").jqGridRowValue().F_Id;
        $.modalOpen({
            id: "Form",
            title: "修改",
            url: "/rtmManage/RTM01/Form?keyValue=" + keyValue,
            width: "640px",
            height: "400px",
            callBack: function (iframeId) {
                top.frames[iframeId].submitForm();
            }
        });
    }
    function btn_delete() {
        $.deleteForm({
            url: "/rtmManage/RTM01/DeleteForm",
            param: { keyValue: $("#gridList").jqGridRowValue().F_Id },
            success: function () {
                $.currentWindow().$("#gridList").trigger("reloadGrid");
            }
        })
    }
    function btn_details() {
        var keyValue = $("#gridList").jqGridRowValue().F_Id;
        $.modalOpen({
            id: "Details",
            title: "查看",
            url: "/rtmManage/RTM01/Details?keyValue=" + keyValue,
            width: "640px",
            height: "400px",
            btn: null,
        });
    }
</script>

<div class="topPanel">
    <div class="toolbar">
        <div class="btn-group">
            <a class="btn btn-info" onclick="$.reload()"><span class="glyphicon glyphicon-refresh"></span></a>
        </div>
        <div class="btn-group">
            <a id="NF-add" authorize="yes" class="btn btn-info dropdown-text" onclick="btn_add()"><i class="fa fa-plus"></i>新建</a>
        </div>
        <div class="operate">
            <ul class="nav nav-pills">
                <li class="first">已選中<span>1</span>項</li>
                <li><a id="NF-edit" authorize="yes" onclick="btn_edit()"><i class="fa fa-pencil-square-o"></i>修改</a></li>
                <li><a id="NF-delete" authorize="yes" onclick="btn_delete()"><i class="fa fa-trash-o"></i>刪除</a></li>
                <li><a id="NF-Details" authorize="yes" onclick="btn_details()"><i class="fa fa-search-plus"></i>查看</a></li>
            </ul>
            <a href="javascript:;" class="close"></a>
        </div>
        <script>$('.toolbar').authorizeButton()</script>
    </div>
    <div class="search">
        <table>
            <tr>
                <td>
                    <div class="input-group">
                        <input id="txt_keyword" type="text" class="form-control" placeholder="關鍵字" style="width: 200px;">
                        <span class="input-group-btn">
                            <button id="btn_search" type="button" class="btn  btn-info"><i class="fa fa-search"></i></button>
                        </span>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="gridPanel">
    <table id="gridList"></table>
	<div id="gridPager"></div>
</div>

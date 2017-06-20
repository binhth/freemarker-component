loop danh sách hiển thị
data.results: mảng json, list object
<#list data.results as doc>
    <!-- hiển thị dữ liệu -->
</#list>


// phân trang dữ liệu
<div class="text-right">

  //Tham số để lọc dữ liệu truyền vào API
	<#assign iteratorParamater = jsonFactoryUtil.looseSerialize({"groupId": groupId}) >
  
  //URL API
	<#assign iteratorAPIURL = "/o/backend-restful-api/v1/docfile/mDocFiles" >
  
  // các tham số truyền vào để phân trang
  //1..(data.total/5) số trang hiển thị từ 1 tới ...
  //cur trang hiện tại
  //"subject" order by cột subject
  //iteratorAPIURL link API URL
  //iteratorParamater tham số ( link API + tham số được sử dụng trong file pagination.ftl )
  //5 số lượng bản ghi hiển thị ( deltal )
  //"#mainDanhSachVB" ID của thẻ wrap nội dung danh sách + phân trang
  
    <@liferay_portlet.renderURL var="mainListURL" windowState="exclusive">
		<@liferay_portlet.param name="mvcPath" value="/templates/danhsach/ajax/viewContent.ftl" />
	</@liferay_portlet.renderURL>
	
	<@pagination.pages 1..(data.total/5) cur "subject" iteratorAPIURL iteratorParamater 5 "#mainDanhSachVB" mainListURL/>
</div>

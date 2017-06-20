<#function max x y>
    <#if (x<y)><#return y><#else><#return x></#if>
</#function>
<#function min x y>
    <#if (x<y)><#return x><#else><#return y></#if>
</#function>

<#macro pages totalPages p order apiURL jsonParamater delta containerId>

     <#assign size = totalPages?size>
    <ul class="pagination M0">
    
    <#if (p<4)> <#-- p among first 5 pages -->
        <#assign interval = 1..(min(5,size))>
    <#elseif ((size-p)<4)> <#-- p among last 5 pages -->
        <#assign interval = (max(1,(size-4)))..size >
    <#else>
        <#assign interval = (p-2)..(p+2)>
    </#if>
    <#if !(interval?seq_contains(1))>
     <li><a href="javascript:;" class="mobilink-pagination" cur="1">1</a> </li> <li><a href="javascript:;">...</a> </li> <#rt>
    </#if>

    <#list interval as page>
        <#if page=p>
         <li class="active"><a href="javascript:;" class="mobilink-pagination" cur="${page}">${page}</a> </li><#t>
        <#else>
         <li><a href="javascript:;" class="mobilink-pagination" cur="${page}">${page}</a> </li><#t>
        </#if>
        
    </#list>
    
    <#if !(interval?seq_contains(size))>
     <li><a href="javascript:;">...</a> </li> <li><a href="javascript:;" class="mobilink-pagination" cur="${size}">${size}</a> </li><#lt>
    </#if>
    
    </ul>
    
    <@liferay_portlet.renderURL var="mainListURL" windowState="exclusive">
		<@liferay_portlet.param name="mvcPath" value="/templates/danhsach/ajax/viewContent.ftl" />
	</@liferay_portlet.renderURL>

<script type="text/javascript">

	$(function() {
	
		var jsonParamater = ${jsonParamater};
	
		$(document).on('click', '.mobilink-pagination', function(event) {
		
			event.preventDefault();
			event.stopPropagation();
			event.stopImmediatePropagation();
			
			var curent = $(this).attr('cur');
			var start = (curent - 1)*${delta};
			var end = ((curent - 1)*${delta}) + ${delta};
			
			$.ajax({
				method: "GET",
				url: "${apiURL}",
				data: { 
					query: JSON.stringify(jsonParamater), 
					order: "${order}", start: start, end: end
				}
			})
			.done(function( data ) {
				$.ajax({
					method: "POST",
					url: "${mainListURL}",
					data: {
						data: JSON.stringify(data),
						cur: curent
					},
					dataType: 'html',
					contentType: "application/x-www-form-urlencoded;charset=utf-8"
				})
				.done(function( data ) {
					$("${containerId}").html(data);
				}); 
			});	
		});
		 
	});

</script>
</#macro>

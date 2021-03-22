<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="addressPolygonModal" class="modal" role="dialog" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">&nbsp;</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
			</div>
			<div class="modal-body">
 				<div class="address-search-option"><p><span class="my-location" ><fmt:message key='label.mapaddress.link.yourcurrentlocation' /></span><p></div>
				<div class="map-address-wrap">
					<input type="text" class="form-control" id="modaladdress" autocomplete="off">
					<div class="address-lists address-polygon-map-list-modal"></div>
				</div>
				<div id="mapSection" style="width:100%; height:320px;"></div>
				<div class="text-center mt-3"><button type="button" id="confirmLocation" class="btn btn-primary"><fmt:message key="label.button.confirmlocation" /></button></div>
			</div>
		</div>
	</div>
</div>
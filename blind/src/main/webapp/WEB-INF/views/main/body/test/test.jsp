<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>Swiper demo</title>
	<!-- Demo styles -->
	<style>
		html, body {
			position: relative;
			height: 100%;
		}

		body {
			font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
			font-size: 14px;
			color: #000;
			margin: 0;
			padding: 0;
		}

		::-webkit-scrollbar {
			display: none;
		}

		.swiper-container {
			width: 100%;
			height: 100%;
		}

		.swiper-slide {
			text-align: center;
			font-size: 18px;
			background: #fff;

			/* Center slide text vertically */
			display: -webkit-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-webkit-box-pack: center;
			-ms-flex-pack: center;
			-webkit-justify-content: center;
			justify-content: center;
			-webkit-box-align: center;
			-ms-flex-align: center;
			-webkit-align-items: center;
			align-items: center;
		}
	</style>
</head>
<body>
<!-- Swiper -->
<div class="swiper-container">
	<div class="swiper-wrapper">
		<div class="swiper-slide">
			<a href="#">Menu 1</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 2</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 3</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 4</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 5</a>&nbsp;&nbsp;&nbsp;
		</div>
		<div class="swiper-slide">
			<a href="#">Menu 6</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 7</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 8</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 9</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 10</a>&nbsp;&nbsp;&nbsp;
		</div>
		<div class="swiper-slide">
			<a href="#">Menu 11</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 12</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 13</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 14</a>&nbsp;&nbsp;&nbsp;
			<a href="#">Menu 15</a>&nbsp;&nbsp;&nbsp;
		</div>
	</div>
</div>

<!-- Initialize Swiper -->
<script>
	var swiper = new Swiper('.swiper-container', {
		scrollbar: {
			el: '.swiper-scrollbar',
			hide: true,
		},
	});
</script>
</body>
</html>
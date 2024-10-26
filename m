Return-Path: <linux-kernel+bounces-383220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8326B9B189A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28041C2127A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D554C182B4;
	Sat, 26 Oct 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="OZPmkcOp"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F391863E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729953005; cv=none; b=Yx3wJBWAnr6LDaQnTANSa7FrgmFkrtHm3wdhxBqPbAMoBZUxnd8aWLbC2s7eV4kFH0kyzGDAArihg9ScjklBNJUn6ciyqduqCu5/yQLsRjMoalHTxfkdSdoMWMemYlct7xCT+qAzaCgBWdyZrERXwyKmG1L9OfJ74KOswMJ4BRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729953005; c=relaxed/simple;
	bh=3Hz0FB8mphIPsVK/l2Coz4EpEE8fFacEh+OP9OSeJpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC7xYaYxDCNHDKYCdffVDUX2BOPKrsX5Qha5JH/nCE/2lRNQFqZGreEXbNL4iN7afZRXROSHcx6eL6Ul2/8Xv/41qYgooqtgBgHwZUam8sSY93IDEZvcQ0dATPPdUUqIsUJHv96XjIR6X5nlcIMq2A9cu6pVVGYyGrG4dU+Hf8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=OZPmkcOp; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XbMVx5PD7zDrQC;
	Sat, 26 Oct 2024 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1729953002; bh=3Hz0FB8mphIPsVK/l2Coz4EpEE8fFacEh+OP9OSeJpU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OZPmkcOpzIsMpbkRDJmsCcVzlHeBCZatanV1R1eusNxWt36nN6/vSA7X24mWUX78V
	 PhjCUa00PaxlwkHKuhSCpHGIHIh6fVuvtT4PWTHrnRY8L4JuhuCdESDDIBtyeVagGx
	 z83lxjRuzKK5x9Bp94UJQc9435Ty33fYFWvb/QrY=
X-Riseup-User-ID: 870E5745E7D4399F44F820B46552A04B3AD346E43B82681AF776AE7B88BCFD3C
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XbMVq2WnczJsbY;
	Sat, 26 Oct 2024 14:29:55 +0000 (UTC)
Message-ID: <0b595d86-dbb5-43ae-9eb4-5f611013f6e8@riseup.net>
Date: Sat, 26 Oct 2024 11:29:53 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v2 1/8] drm/vkms: Create helpers macro to avoid
 code duplication in format callbacks
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
 20241007-yuv-v12-0-01c1ada6fec8@bootlin.com
References: <20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com>
 <20241007-b4-new-color-formats-v2-1-d47da50d4674@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20241007-b4-new-color-formats-v2-1-d47da50d4674@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 07/10/24 13:46, Louis Chauvet wrote:
> The callback functions for line conversion are almost identical for
> some format. The generic READ_LINE macro generate all the required
> boilerplate to process a line.
> 
> Two overrides of this macro have been added to avoid duplication of
> the same arguments every time.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/vkms_formats.c | 163 +++++++++++++-----------------------
>   1 file changed, 58 insertions(+), 105 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index f9841b8000c4..8f1bcca38148 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -292,6 +292,58 @@ VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1,
>   }
>   EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
>   
> +/**
> + * READ_LINE() - Generic generator for a read_line function which can be used for format with one
> + * plane and a block_h == block_w == 1.
> + *
> + * @function_name: Function name to generate > + * @pixel_name: temporary pixel name used in the @__VA_ARGS__ parameters

s/temporary/Temporary

> + * @pixel_type: Used to specify the type you want to cast the pixel pointer
> + * @callback: Callback to call for each pixels. This fonction should take @__VA_ARGS__ as parameter
> + *            and return a pixel_argb_u16
> + * @__VA_ARGS__: Argument to pass inside the callback. You can use @pixel_name to access current
> + *  pixel.
> + */
> +#define READ_LINE(function_name, pixel_name, pixel_type, callback, ...)				\
> +static void function_name(const struct vkms_plane_state *plane, int x_start,			\
> +			      int y_start, enum pixel_read_direction direction, int count,	\
> +			      struct pixel_argb_u16 out_pixel[])				\
> +{												\
> +	struct pixel_argb_u16 *end = out_pixel + count;						\
> +	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);			\
> +	u8 *src_pixels;										\
> +												\
> +	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);		\
> +												\
> +	while (out_pixel < end) {								\
> +		pixel_type *(pixel_name) = (pixel_type *)src_pixels;				\
> +		*out_pixel = (callback)(__VA_ARGS__);						\
> +		out_pixel += 1;									\
> +		src_pixels += step;								\
> +	}											\
> +}
> +
> +/**
> + * READ_LINE_ARGB8888() - Generic generator for ARGB8888 formats.
> + * The pixel type used is u8, so pixel_name[0]..pixel_name[n] are the n components of the pixel.
> + *
> + * @function_name: Function name to generate
> + * @pixel_name: temporary pixel to use in @a, @r, @g and @b parameters
> + * @a, @r, @g, @b: value of each channel
> + */
> +#define READ_LINE_ARGB8888(function_name, pixel_name, a, r, g, b) \
> +	READ_LINE(function_name, pixel_name, u8, argb_u16_from_u8888, a, r, g, b)
> +/**
> + * READ_LINE_ARGB16161616() - Generic generator for ARGB16161616 formats.
> + * The pixel type used is u8, so pixel_name[0]..pixel_name[n] are the n components of the pixel.

s/u8/u16

Best Regard,
- Maíra

> + *
> + * @function_name: Function name to generate
> + * @pixel_name: temporary pixel to use in @a, @r, @g and @b parameters
> + * @a, @r, @g, @b: value of each channel
> + */
> +#define READ_LINE_16161616(function_name, pixel_name, a, r, g, b) \
> +	READ_LINE(function_name, pixel_name, u16, argb_u16_from_u16161616, a, r, g, b)
> +
>   /*
>    * The following functions are read_line function for each pixel format supported by VKMS.
>    *
> @@ -378,118 +430,19 @@ static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
>   	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel);
>   }
>   
> -static void R8_read_line(const struct vkms_plane_state *plane, int x_start,
> -			 int y_start, enum pixel_read_direction direction, int count,
> -			 struct pixel_argb_u16 out_pixel[])
> -{
> -	struct pixel_argb_u16 *end = out_pixel + count;
> -	u8 *src_pixels;
> -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> -
> -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> -
> -	while (out_pixel < end) {
> -		*out_pixel = argb_u16_from_gray8(*src_pixels);
> -		src_pixels += step;
> -		out_pixel += 1;
> -	}
> -}
> -
> -static void ARGB8888_read_line(const struct vkms_plane_state *plane, int x_start, int y_start,
> -			       enum pixel_read_direction direction, int count,
> -			       struct pixel_argb_u16 out_pixel[])
> -{
> -	struct pixel_argb_u16 *end = out_pixel + count;
> -	u8 *src_pixels;
> -
> -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> -
> -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> -
> -	while (out_pixel < end) {
> -		u8 *px = (u8 *)src_pixels;
> -		*out_pixel = argb_u16_from_u8888(px[3], px[2], px[1], px[0]);
> -		out_pixel += 1;
> -		src_pixels += step;
> -	}
> -}
> -
> -static void XRGB8888_read_line(const struct vkms_plane_state *plane, int x_start, int y_start,
> -			       enum pixel_read_direction direction, int count,
> -			       struct pixel_argb_u16 out_pixel[])
> -{
> -	struct pixel_argb_u16 *end = out_pixel + count;
> -	u8 *src_pixels;
> -
> -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> -
> -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> -
> -	while (out_pixel < end) {
> -		u8 *px = (u8 *)src_pixels;
> -		*out_pixel = argb_u16_from_u8888(255, px[2], px[1], px[0]);
> -		out_pixel += 1;
> -		src_pixels += step;
> -	}
> -}
> -
> -static void ARGB16161616_read_line(const struct vkms_plane_state *plane, int x_start,
> -				   int y_start, enum pixel_read_direction direction, int count,
> -				   struct pixel_argb_u16 out_pixel[])
> -{
> -	struct pixel_argb_u16 *end = out_pixel + count;
> -	u8 *src_pixels;
> -
> -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> -
> -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> -
> -	while (out_pixel < end) {
> -		u16 *px = (u16 *)src_pixels;
> -		*out_pixel = argb_u16_from_u16161616(px[3], px[2], px[1], px[0]);
> -		out_pixel += 1;
> -		src_pixels += step;
> -	}
> -}
> -
> -static void XRGB16161616_read_line(const struct vkms_plane_state *plane, int x_start,
> -				   int y_start, enum pixel_read_direction direction, int count,
> -				   struct pixel_argb_u16 out_pixel[])
> -{
> -	struct pixel_argb_u16 *end = out_pixel + count;
> -	u8 *src_pixels;
> -
> -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
>   
> -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> +READ_LINE_ARGB8888(XRGB8888_read_line, px, 255, px[2], px[1], px[0])
>   
> -	while (out_pixel < end) {
> -		__le16 *px = (__le16 *)src_pixels;
> -		*out_pixel = argb_u16_from_le16161616(cpu_to_le16(0xFFFF), px[2], px[1], px[0]);
> -		out_pixel += 1;
> -		src_pixels += step;
> -	}
> -}
> +READ_LINE_ARGB8888(ARGB8888_read_line, px, px[3], px[2], px[1], px[0])
>   
> -static void RGB565_read_line(const struct vkms_plane_state *plane, int x_start,
> -			     int y_start, enum pixel_read_direction direction, int count,
> -			     struct pixel_argb_u16 out_pixel[])
> -{
> -	struct pixel_argb_u16 *end = out_pixel + count;
> -	u8 *src_pixels;
>   
> -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> +READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
> +READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0]);
>   
> -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> +READ_LINE(RGB565_read_line, px, __le16, argb_u16_from_RGB565, px)
>   
> -	while (out_pixel < end) {
> -		__le16 *px = (__le16 *)src_pixels;
> +READ_LINE(R8_read_line, px, u8, argb_u16_from_gray8, *px)
>   
> -		*out_pixel = argb_u16_from_RGB565(px);
> -		out_pixel += 1;
> -		src_pixels += step;
> -	}
> -}
>   
>   /*
>    * This callback can be used for YUV formats where U and V values are
> 


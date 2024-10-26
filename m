Return-Path: <linux-kernel+bounces-383240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0279B18DA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0EF1C20E17
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F018D1F942;
	Sat, 26 Oct 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="aYK5wxJA"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0020175A5
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954733; cv=none; b=EMnVzIWFG1CXcx3ZOSG2Qxd7ZG77wZSvlonnVP8omy5WsMOL9VxjUiz+E/WBUm+3lKyT9vit/+HcedBp9xPINfNcpirmDLYMsnKLNBs/TFaCPEGQE210pqYy8Wdngfl4F12mr5h8yDZA8OleXbRH0bvms3ptAhkKfWR9qcPpHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954733; c=relaxed/simple;
	bh=IUVxvsxnEMs7MdrD7UvHmzkbNrwXMq86EVtgORqBmDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuYC52UY215dbHHWhnUkYkc51vAs5QOndB2HpfTxM1oj656GNywlsgO/fH57W7CDu55n06/YmE6reymTbux5gO3DuN8hnAEkiievdDjXRdGK14KIQ6RjDcYbzyfelhh9yaY5qdFeJXk/wKPzXDmm/lslfMgpMX6h46XMN/sY7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=aYK5wxJA; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XbN7y3C47zDqQL;
	Sat, 26 Oct 2024 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1729954730; bh=IUVxvsxnEMs7MdrD7UvHmzkbNrwXMq86EVtgORqBmDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aYK5wxJAFmoe69tkc19h+mr6Vwnjg1t3OqvFZKoescAL/GVpjAM8JgASha7fS28az
	 3DTVa48tPpWsxoez2tUlplibQV8BWYJETfy+GqMxKu238ik77EEK7T9pw+pOslt0rr
	 vo++H4SeAqpT04y3+NFoRzm/QL5qgy5FTmVk3lqw=
X-Riseup-User-ID: CAC7E42BF9E3390CD49EC53E92C255699ECAAB9CF1DB1672E6C93D9BAB633844
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4XbN7r3NT8zFv6C;
	Sat, 26 Oct 2024 14:58:32 +0000 (UTC)
Message-ID: <eaf964a9-e7ed-4851-a12e-0a23739b715e@riseup.net>
Date: Sat, 26 Oct 2024 11:58:30 -0300
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
> + * @function_name: Function name to generate
> + * @pixel_name: temporary pixel name used in the @__VA_ARGS__ parameters
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

I just compile the whole series and I saw the warning:

drivers/gpu/drm/vkms/vkms_formats.c:226:30: warning: unused function 
'argb_u16_from_le16161616' [-Wunused-function]
   226 | static struct pixel_argb_u16 argb_u16_from_le16161616(__le16 a, 
__le16 r, __le16 g, __le16 b)
       |                              ^~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.

Best Regards,
- Maíra

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


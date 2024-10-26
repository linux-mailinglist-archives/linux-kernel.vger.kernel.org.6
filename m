Return-Path: <linux-kernel+bounces-383248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C549B18F6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF171F22045
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D220314;
	Sat, 26 Oct 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="PsLNUCgL"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3A18C3E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955335; cv=none; b=tWtDF7BVyxVWogJOuW9E5kmERRSfAUaqFQXlqjqoSq1GBcHYx/KcpIKeLJ+yV4q6qC9nHiMKWPGkmS0vreIfejf3ZkfRqNV4brGwKtAvOJSFtFXaRIP+IfQpJB8zsxtw5ypcMzxa49UdBwnwL7SVsDwZp/K4vmwmye8hKc/zWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955335; c=relaxed/simple;
	bh=37ymUSLy/WZsWp4KgcCO90jZ08a6qeob/RoGfxbDwWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZsbJ0V4VnHzHbXa6CE+d2tPtGmFriY99cilcAW/BqG90KCNtPX8JmzRiUhlF7n2vQb5de7zqpWhc3aeT4jy2PgtFa9Xh3BUBAf1WCx3k8SGzpnxPU8+0he47kzYvHlCmDf/G2z4YEPH5/307qJBqwWwQ/egP6Fl0z1064Sg1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=PsLNUCgL; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XbNMm0xWMzDqFC;
	Sat, 26 Oct 2024 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1729955332; bh=37ymUSLy/WZsWp4KgcCO90jZ08a6qeob/RoGfxbDwWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PsLNUCgLjQW7+GiM1tn6xeXt3kbmo51SnYXqWTHL9FOyW2CpRFL7ii04uS3rx5A/y
	 FlvrNkeZIHMFmLY6Y1oGRGtLcJg05fySw6ttt2d6OoznwMnngj90unVMDNkYF/DcvL
	 KLLO9htx1lYPEdhtq+/5sFKDyOZkFgdKGiFOZ+io=
X-Riseup-User-ID: 32B0ED6C68EDD35F28DFBFFDC01B9FA8D5CD208960BF2E7AB0B435EE1D4F2A46
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4XbNMf214TzFqLF;
	Sat, 26 Oct 2024 15:08:45 +0000 (UTC)
Message-ID: <2af1f9b4-0bc8-4585-ba13-d3b97e25845f@riseup.net>
Date: Sat, 26 Oct 2024 12:08:44 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] drm/vkms: Add a macro for write_line functions
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, nicolejadeyee@google.com
References: <20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com>
 <20240814-writeback_line_by_line-v2-2-36541c717569@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20240814-writeback_line_by_line-v2-2-36541c717569@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 14/08/24 05:42, Louis Chauvet wrote:
> As stated in [2], the write_line functions are very similar and force code

Where is [2]?

> duplication. This patch add a macro to avoid code repetition.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/vkms_formats.c | 107 ++++++++++--------------------------
>   1 file changed, 30 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index d1309f6d307f..a25cdf656d8a 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -654,6 +654,31 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
>   	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
>   }
>   
> +/**
> + * WRITE_LINE() - Generic generator for write_line functions
> + *
> + * This generator can only be used for format with only one plane and block_w == block_h == 1
> + *
> + * @function_name: Name to use for the generated function
> + * @conversion_function: Fonction to use for the conversion from argb_u16 to the required format.

s/Fonction/Function

> + */
> +#define WRITE_LINE(function_name, conversion_function)					\
> +static void function_name(struct vkms_writeback_job *wb,				\
> +			  struct pixel_argb_u16 *src_pixels, int count, int x_start,	\
> +			  int y_start)							\
> +{											\
> +	u8 *dst_pixels;									\
> +											\
> +	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);	\
> +											\
> +	while (count) {									\
> +		(conversion_function)(dst_pixels, src_pixels);				\
> +		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];		\
> +		src_pixels += 1;							\
> +		count--;								\

Just a nit: What do you think about this loop?

for (; count > 0; src_pixels++, count--)

It doesn't really matter what option you pick.

Best Regards,
- Maíra

> +	}										\
> +}
> +
>   /*
>    * The following functions are write_line function for each pixel format supported by VKMS.
>    *
> @@ -667,85 +692,13 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
>    * [1]: https://lore.kernel.org/dri-devel/d258c8dc-78e9-4509-9037-a98f7f33b3a3@riseup.net/
>    */
>   
> -static void ARGB8888_write_line(struct vkms_writeback_job *wb,
> -				struct pixel_argb_u16 *src_pixels, int count, int x_start,
> -				int y_start)
> -{
> -	u8 *dst_pixels;
> +WRITE_LINE(ARGB8888_write_line, argb_u16_to_ARGB8888)
> +WRITE_LINE(XRGB8888_write_line, argb_u16_to_XRGB8888)
>   
> -	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
> +WRITE_LINE(ARGB16161616_write_line, argb_u16_to_ARGB16161616)
> +WRITE_LINE(XRGB16161616_write_line, argb_u16_to_XRGB16161616)
>   
> -	while (count) {
> -		argb_u16_to_ARGB8888(dst_pixels, src_pixels);
> -		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
> -		src_pixels += 1;
> -		count--;
> -	}
> -}
> -
> -static void XRGB8888_write_line(struct vkms_writeback_job *wb,
> -				struct pixel_argb_u16 *src_pixels, int count, int x_start,
> -				int y_start)
> -{
> -	u8 *dst_pixels;
> -
> -	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
> -
> -	while (count) {
> -		argb_u16_to_XRGB8888(dst_pixels, src_pixels);
> -		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
> -		src_pixels += 1;
> -		count--;
> -	}
> -}
> -
> -static void ARGB16161616_write_line(struct vkms_writeback_job *wb,
> -				    struct pixel_argb_u16 *src_pixels, int count, int x_start,
> -				    int y_start)
> -{
> -	u8 *dst_pixels;
> -
> -	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
> -
> -	while (count) {
> -		argb_u16_to_ARGB16161616(dst_pixels, src_pixels);
> -		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
> -		src_pixels += 1;
> -		count--;
> -	}
> -}
> -
> -static void XRGB16161616_write_line(struct vkms_writeback_job *wb,
> -				    struct pixel_argb_u16 *src_pixels, int count, int x_start,
> -				    int y_start)
> -{
> -	u8 *dst_pixels;
> -
> -	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
> -
> -	while (count) {
> -		argb_u16_to_XRGB16161616(dst_pixels, src_pixels);
> -		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
> -		src_pixels += 1;
> -		count--;
> -	}
> -}
> -
> -static void RGB565_write_line(struct vkms_writeback_job *wb,
> -			      struct pixel_argb_u16 *src_pixels, int count, int x_start,
> -			      int y_start)
> -{
> -	u8 *dst_pixels;
> -
> -	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
> -
> -	while (count) {
> -		argb_u16_to_RGB565(dst_pixels, src_pixels);
> -		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
> -		src_pixels += 1;
> -		count--;
> -	}
> -}
> +WRITE_LINE(RGB565_write_line, argb_u16_to_RGB565)
>   
>   /**
>    * get_pixel_read_function() - Retrieve the correct read_line function for a specific
> 


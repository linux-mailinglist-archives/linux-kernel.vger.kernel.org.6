Return-Path: <linux-kernel+bounces-383229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E1F9B18BA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C20C2828E9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6F1CD15;
	Sat, 26 Oct 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="OzCGMmVb"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D11C32;
	Sat, 26 Oct 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954203; cv=none; b=YqNxGktd8nPRkqVK6444HX8+ACN5CDPA3eokkKkOHp0KTtlcmJBMXrf5P+oi0bFtyU3San/j57qtAPYMkCnbm/nOhAgL+8mixY18O6EzGj3qm7cUZ+GVs4etHTORIOTZmBjcFr8ltJ2JKDPm6KhUEMyhj7lpSdO/tzOp7ODY1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954203; c=relaxed/simple;
	bh=VtaHuXi4ew3TMRqGIhm7JXU8YthOTsqrhboQ29L60Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auDT+BEeRcbGMBoBk6Zlt74rnSM5ny79BOxv1Me/RCUvmaesnLz8BdDXxXdKr8DiT5NerhGaxOmfAAcpL2+u3BD6lWqyD2N4AIwoP8Hpn82Vc5sT8KO65DKpo0ZSSjsvQEjSmvdR4laFb1NAJs0PLtEebzmeXoZYmdaFuM6E5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=OzCGMmVb; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XbMxy6vQNzDqJm;
	Sat, 26 Oct 2024 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1729954199; bh=VtaHuXi4ew3TMRqGIhm7JXU8YthOTsqrhboQ29L60Lo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OzCGMmVbMZ3BxmreyvO1z7YjAEmX4tfYHj8ZOGqMOuUW6ImJ8hjozDMJMwFuJ2w2+
	 T8FTra76WrBa8HmBiL3sNSlPct92zqGdgQ8jcDVGxvtGirq3clXQaMGKBGB6R3lFdo
	 a5ZHtcRnU7YOI4N3q1om5a+cG8/QKTgR/Gnc9cYk=
X-Riseup-User-ID: 722A6349C116B6809B884D36D25006E63B0DB3E558033A992A5C1E967AC8A5EA
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XbMxp2YvJzJsFN;
	Sat, 26 Oct 2024 14:49:50 +0000 (UTC)
Message-ID: <d33f982f-f4ca-4bb2-9454-9d01a927d8b5@riseup.net>
Date: Sat, 26 Oct 2024 11:49:48 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v12 13/15] drm/vkms: Create KUnit tests for YUV
 conversions
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
 arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
 Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
 <20241007-yuv-v12-13-01c1ada6fec8@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20241007-yuv-v12-13-01c1ada6fec8@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 07/10/24 13:10, Louis Chauvet wrote:
> From: Arthur Grillo <arthurgrillo@riseup.net>
> 
> Create KUnit tests to test the conversion between YUV and RGB. Test each
> conversion and range combination with some common colors.
> 
> The code used to compute the expected result can be found in comment.
> 
> [Louis Chauvet:
> - fix minor formating issues (whitespace, double line)
> - change expected alpha from 0x0000 to 0xffff
> - adapt to the new get_conversion_matrix usage
> - apply the changes from Arthur
> - move struct pixel_yuv_u8 to the test itself]
> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/Kconfig                  |  15 ++
>   drivers/gpu/drm/vkms/Makefile                 |   1 +
>   drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
>   drivers/gpu/drm/vkms/tests/Makefile           |   3 +
>   drivers/gpu/drm/vkms/tests/vkms_format_test.c | 232 ++++++++++++++++++++++++++
>   drivers/gpu/drm/vkms/vkms_formats.c           |   7 +-
>   drivers/gpu/drm/vkms/vkms_formats.h           |   5 +
>   7 files changed, 265 insertions(+), 2 deletions(-)
> 

[...]

> +
> +static void vkms_format_test_yuv_u8_to_argb_u16(struct kunit *test)
> +{
> +	const struct yuv_u8_to_argb_u16_case *param = test->param_value;
> +	struct pixel_argb_u16 argb;
> +
> +	for (size_t i = 0; i < param->n_colors; i++) {
> +		const struct format_pair *color = &param->colors[i];
> +		struct conversion_matrix matrix;
> +
> +		get_conversion_matrix_to_argb_u16
> +			(DRM_FORMAT_NV12, param->encoding, param->range, &matrix);
> +
> +		argb = argb_u16_from_yuv888(color->yuv.y, color->yuv.u, color->yuv.v, &matrix);

This should be `argb_u16_from_yuv161616` as you fixed in [1].

[1] 
https://lore.kernel.org/all/20241007-b4-new-color-formats-v2-5-d47da50d4674@bootlin.com/

Best Regards,
- Maíra

> +
> +		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.a, color->argb.a), 257,
> +				    "On the A channel of the color %s expected 0x%04x, got 0x%04x",
> +				    color->name, color->argb.a, argb.a);
> +		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.r, color->argb.r), 257,
> +				    "On the R channel of the color %s expected 0x%04x, got 0x%04x",
> +				    color->name, color->argb.r, argb.r);
> +		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.g, color->argb.g), 257,
> +				    "On the G channel of the color %s expected 0x%04x, got 0x%04x",
> +				    color->name, color->argb.g, argb.g);
> +		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.b, color->argb.b), 257,
> +				    "On the B channel of the color %s expected 0x%04x, got 0x%04x",
> +				    color->name, color->argb.b, argb.b);
> +	}
> +}
> +
> +static void vkms_format_test_yuv_u8_to_argb_u16_case_desc(struct yuv_u8_to_argb_u16_case *t,
> +							  char *desc)
> +{
> +	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s - %s",
> +		 drm_get_color_encoding_name(t->encoding), drm_get_color_range_name(t->range));
> +}
> +
> +KUNIT_ARRAY_PARAM(yuv_u8_to_argb_u16, yuv_u8_to_argb_u16_cases,
> +		  vkms_format_test_yuv_u8_to_argb_u16_case_desc
> +);
> +
> +static struct kunit_case vkms_format_test_cases[] = {
> +	KUNIT_CASE_PARAM(vkms_format_test_yuv_u8_to_argb_u16, yuv_u8_to_argb_u16_gen_params),
> +	{}
> +};
> +
> +static struct kunit_suite vkms_format_test_suite = {
> +	.name = "vkms-format",
> +	.test_cases = vkms_format_test_cases,
> +};
> +
> +kunit_test_suite(vkms_format_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Kunit test for vkms format conversion");
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index adb1228e5201..0b201185eae7 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -7,6 +7,8 @@
>   #include <drm/drm_rect.h>
>   #include <drm/drm_fixed.h>
>   
> +#include <kunit/visibility.h>
> +
>   #include "vkms_formats.h"
>   
>   /**
> @@ -247,8 +249,8 @@ static struct pixel_argb_u16 argb_u16_from_RGB565(const __le16 *pixel)
>   	return out_pixel;
>   }
>   
> -static struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
> -						  const struct conversion_matrix *matrix)
> +VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
> +							    const struct conversion_matrix *matrix)
>   {
>   	u16 r, g, b;
>   	s64 fp_y, fp_channel_1, fp_channel_2;
> @@ -278,6 +280,7 @@ static struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel
>   
>   	return argb_u16_from_u16161616(0xffff, r, g, b);
>   }
> +EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
>   
>   /*
>    * The following functions are read_line function for each pixel format supported by VKMS.
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
> index d583855cb320..b4fe62ab9c65 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.h
> +++ b/drivers/gpu/drm/vkms/vkms_formats.h
> @@ -13,4 +13,9 @@ void get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encod
>   				       enum drm_color_range range,
>   				       struct conversion_matrix *matrix);
>   
> +#if IS_ENABLED(CONFIG_KUNIT)
> +struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
> +					   const struct conversion_matrix *matrix);
> +#endif
> +
>   #endif /* _VKMS_FORMATS_H_ */
> 


Return-Path: <linux-kernel+bounces-386661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C89B468D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498101C226E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A62040AF;
	Tue, 29 Oct 2024 10:17:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2660204032
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197073; cv=none; b=rLJP0M9yGBtGTCTqo3ninQsp4gMmowDCnVZ8TxTcdZ4tl3D5RviRI6lC/wyp0JZJWIx0wfYidTjaGdkJ7GIh08+CAfTbzJMYcwZOaaxiDxIQcGb6NJKblpknetArT2m0bhROD3N1YNfflFDI5VMAudud4iTV3DqeOanCc1594Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197073; c=relaxed/simple;
	bh=xx3ROp2cdPygsDksJKc8u2Zj6zaZ1kgfvXMqOT2Z61M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNjClYvt8ieFax+Ds1QXBr5CotPkh68erCqYSi1pLQqM6xtUZfUdkrGCLb56JGhARRgrv/e7f18H83zntt2lf/lhr4PmRee8AuoJJXM+qcLDTvS7wN2OszVKT4U+K6brztV2lhgFHKLKPTfClNgFlLN+UjSMDa61oWZZrRELZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C41BF13D5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:18:18 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C88083F528
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:17:48 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:17:46 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Yulia Garbovich <yulia.garbovich@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	rosen.zhelev@arm.com
Subject: Re: [PATCH v2] drm: drm_fourcc: adding 10/12/14 bit formats
Message-ID: <ZyC2Sp52aqTEgKoa@e110455-lin.cambridge.arm.com>
References: <20240902142910.2716380-1-yulia.garbovich@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902142910.2716380-1-yulia.garbovich@arm.com>

On Mon, Sep 02, 2024 at 05:29:10PM +0300, Yulia Garbovich wrote:
> Adding the following formats
>      - DRM_FORMAT_RX106
>      - DRM_FORMAT_GXRX106106
>      - DRM_FORMAT_RX124
>      - DRM_FORMAT_GXRX124124
>      - DRM_FORMAT_AXBXGXRX124124124124
>      - DRM_FORMAT_RX142
>      - DRM_FORMAT_GXRX142142
>      - DRM_FORMAT_AXBXGXRX142142142142
> 
> They are useful for communicating Bayer data between ISPs and GPU by emulating GL_R16UI and GL_RG16UI formats
> 
> Signed-off-by: Yulia Garbovich <yulia.garbovich@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_fourcc.c  |  8 +++++
>  include/uapi/drm/drm_fourcc.h | 61 +++++++++++++++++++++++++++++++++--
>  2 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 193cf8ed7912..cd5f467edfeb 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -170,6 +170,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_R8,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_R10,		.depth = 10, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_R12,		.depth = 12, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> +		{ .format = DRM_FORMAT_RX106,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> +		{ .format = DRM_FORMAT_RX124,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> +		{ .format = DRM_FORMAT_RX142,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_RGB332,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_BGR233,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_XRGB4444,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> @@ -200,6 +203,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_XBGR8888,	.depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_RGBX8888,	.depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_BGRX8888,	.depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> +		{ .format = DRM_FORMAT_GXRX106106,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> +		{ .format = DRM_FORMAT_GXRX124124,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> +		{ .format = DRM_FORMAT_GXRX142142,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_RGB565_A8,	.depth = 24, .num_planes = 2, .cpp = { 2, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_BGR565_A8,	.depth = 24, .num_planes = 2, .cpp = { 2, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_XRGB2101010,	.depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
> @@ -219,6 +225,8 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_AXBXGXRX106106106106, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +		{ .format = DRM_FORMAT_AXBXGXRX124124124124, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +		{ .format = DRM_FORMAT_AXBXGXRX142142142142, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_XRGB16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_XBGR16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_ARGB16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 84d502e42961..7248b96ecf7e 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -146,6 +146,24 @@ extern "C" {
>  /* 12 bpp Red (direct relationship between channel value and brightness) */
>  #define DRM_FORMAT_R12		fourcc_code('R', '1', '2', ' ') /* [15:0] x:R 4:12 little endian */
>  
> +/*
> + * 1-component 16 bpp format that has a 10-bit R component in the top 10 bits of the word
> + * in bytes 0..1 with the bottom 6 bits of the word unused
> + */
> +#define DRM_FORMAT_RX106	fourcc_code('R', '0', '1', '0') /* [15:0] R:x 10:6 little endian */
> +
> +/*
> + * 1-component 16 bpp format that has a 12-bit R component in the top 12 bits of the word
> + * in bytes 0..1 with the bottom 4 bits of the word unused
> + */
> +#define DRM_FORMAT_RX124	fourcc_code('R', '0', '1', '2') /* [15:0] R:x 12:4 little endian */
> +
> +/*
> + * 1-component 16 bpp format that has a 14-bit R component in the top 14 bits of the word
> + * in bytes 0..1 with the bottom 2 bits of the word unused
> + */
> +#define DRM_FORMAT_RX142	fourcc_code('R', '0', '1', '4') /* [15:0] R:x 14:2 little endian */
> +
>  /* 16 bpp Red (direct relationship between channel value and brightness) */
>  #define DRM_FORMAT_R16		fourcc_code('R', '1', '6', ' ') /* [15:0] R little endian */
>  
> @@ -157,6 +175,27 @@ extern "C" {
>  #define DRM_FORMAT_RG1616	fourcc_code('R', 'G', '3', '2') /* [31:0] R:G 16:16 little endian */
>  #define DRM_FORMAT_GR1616	fourcc_code('G', 'R', '3', '2') /* [31:0] G:R 16:16 little endian */
>  
> + /*
> + * 2-component  32bpp  format that has a 10-bit R component in the top 10 bits of the word
> + * in bytes 0..1, and a 10-bit G component in the top 10 bits of the word in bytes 2..3,
> + * with the bottom 6 bits of each word unused.
> + */
> +#define DRM_FORMAT_GXRX106106	fourcc_code('G', 'R', '1', '0') /* [31:0] G:x:R:x 10:6:10:6 little endian */
> +
> +/*
> + * 2-component  32bpp  format that has a 12-bit R component in the top 12 bits of the word
> + * in bytes 0..1, and a 12-bit G component in the top 12 bits of the word in bytes 2..3,
> + * with the bottom 4 bits of each word unused.
> + */
> +#define DRM_FORMAT_GXRX124124	fourcc_code('G', 'R', '1', '2') /* [31:0] G:x:R:x 12:4:12:4 little endian */
> +
> +/*
> + * 2-component  32bpp  format that has a 14-bit R component in the top 14 bits of the word
> + * in bytes 0..1, and a 14-bit G component in the top 14 bits of the word in bytes 2..3,
> + * with the bottom 2 bits of each word unused.
> + */
> +#define DRM_FORMAT_GXRX142142	fourcc_code('G', 'R', '1', '4') /* [31:0] G:x:R:x 14:2:14:2 little endian */
> +
>  /* 8 bpp RGB */
>  #define DRM_FORMAT_RGB332	fourcc_code('R', 'G', 'B', '8') /* [7:0] R:G:B 3:3:2 */
>  #define DRM_FORMAT_BGR233	fourcc_code('B', 'G', 'R', '8') /* [7:0] B:G:R 2:3:3 */
> @@ -229,11 +268,29 @@ extern "C" {
>  #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
>  
>  /*
> - * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
> - * of unused padding per component:
> + * 4-component, 64bpp format that has a 10-bit R component in the top 10 bits of the word in bytes 0..1,
> + * a 10-bit G component in the top 10 bits of the word in bytes 2..3, a 10-bit B component in the top 10 bits of the word
> + * in bytes 4..5, and a 10-bit A component in the top 10 bits of the word in bytes 6..7,
> + * with the bottom 6 bits of each word unused.
>   */
>  #define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0') /* [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian */
>  
> +/*
> + * 4-component, 64bpp format that has a 12-bit R component in the top 12bits of the word in bytes 0..1,
> + * a 12-bit G component in the top 12 bits of the word in bytes 2..3, a 12-bit B component in the top 12 bits of the word
> + * in bytes 4..5, and a 12-bit A component in the top 12 bits of the word in bytes 6..7,
> + * with the bottom 4 bits of each word unused.
> + */
> +#define DRM_FORMAT_AXBXGXRX124124124124	fourcc_code('A', 'B', '1', '2') /* [63:0] A:x:B:x:G:x:R:x 12:4:12:4:12:4:12:4 little endian */
> +
> +/*
> + * 4-component, 64bpp format that has a 14-bit R component in the top 14 bits of the word in bytes 0..1,
> + * a 14-bit G component in the top 14 bits of the word in bytes 2..3, a 14-bit B component in the top 14 bits of the word
> + * in bytes 4..5, and a 14-bit A component in the top 14 bits of the word in bytes 6..7,
> + * with the bottom 2 bits of each word unused.
> + */
> +#define DRM_FORMAT_AXBXGXRX142142142142	fourcc_code('A', 'B', '1', '4') /* [63:0] A:x:B:x:G:x:R:x 14:2:14:2:14:2:14:2 little endian */
> +
>  /* packed YCbCr */
>  #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
>  #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
> -- 
> 2.34.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯


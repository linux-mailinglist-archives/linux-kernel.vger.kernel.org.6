Return-Path: <linux-kernel+bounces-383213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7519B1887
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEA41F2253E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D2D2231C;
	Sat, 26 Oct 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="iixkSaE1"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65E1F949
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729951927; cv=none; b=H2KE3fSJX0WIGO2majQQLkFEZFf/h18omqcjUAtogIpDTX7AOdfyktOGzF2XZbaKQBb0KElJtZ/E9dGvlgXwdVVRFmJYnLTKJbx1eBnfnxF4pnJcB0mUQI0zkeR80/2EsFyoATHEUl63yVr0EvWWQ+JYCpPIe0IoiIkWvxTQ7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729951927; c=relaxed/simple;
	bh=qEM30XYDrpDsUwIzFV4PL0EydYVRo+dUCtxVjeYNobs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LegXFCaV9cpzD4B0G1+W8BQr6vT8t3zmVjrtBmNK0MmWL5YjluBIcdYQyAPEkKzBTDO4SbRn2qIsaDd6vCo8X8+t0TtzhJbqUl28k8PtWpYdCHs4zv72dlsGfyhUTz9qzfPyLQFKbXHsd+Vl0vDSRC6pjsYZIC92XFw32pjQezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=iixkSaE1; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XbM6D1yWSzDqkZ;
	Sat, 26 Oct 2024 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1729951924; bh=qEM30XYDrpDsUwIzFV4PL0EydYVRo+dUCtxVjeYNobs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iixkSaE1nuh7avdj7nIFAe9H5kLOsW1keCHDaDj1uW5BWwQmdYrlJ6tsO663LM7qx
	 uOlHHFlpXpF/PKhV+snhaY/TSs4dDytRMpnNjGGO7EA9Y+0jlouq7p/kWtIkVNDzzm
	 ECLl+DlXcXlZlc0dNPQ2rVIwtYjJdL4IWexAHY8k=
X-Riseup-User-ID: D4E9C5EEE74691AC48D89A0F32EF5328569794BF9127D938F2125D02D026D240
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XbM655z4vzJstM;
	Sat, 26 Oct 2024 14:11:57 +0000 (UTC)
Message-ID: <40c85513-6c57-4b9c-87f6-2ca56c556462@riseup.net>
Date: Sat, 26 Oct 2024 11:11:55 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v2 2/8] drm/vkms: Add support for ARGB8888 formats
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
 <20241007-b4-new-color-formats-v2-2-d47da50d4674@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20241007-b4-new-color-formats-v2-2-d47da50d4674@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 07/10/24 13:46, Louis Chauvet wrote:
> The formats XRGB8888 and ARGB8888 were already supported.
> Add the support for:
> - XBGR8888
> - RGBX8888
> - BGRX8888
> - ABGR8888
> - RGBA8888
> - BGRA8888
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/vkms_formats.c | 18 ++++++++++++++++++
>   drivers/gpu/drm/vkms/vkms_plane.c   |  6 ++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 8f1bcca38148..b5a38f70c62b 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -432,8 +432,14 @@ static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
>   
>   
>   READ_LINE_ARGB8888(XRGB8888_read_line, px, 255, px[2], px[1], px[0])
> +READ_LINE_ARGB8888(XBGR8888_read_line, px, 255, px[0], px[1], px[2]) > +READ_LINE_ARGB8888(RGBX8888_read_line, px, 255, px[3], px[2], px[1])

I'm not expert in colors, but is this correct? From what I understand,
it should be:

READ_LINE_ARGB8888(RGBX8888_read_line, px, px[2], px[1], px[0], 255)
                                            ^R     ^G     ^B     ^X

> +READ_LINE_ARGB8888(BGRX8888_read_line, px, 255, px[1], px[2], px[3])

Again, is this correct?

Best Regards,
- Maíra

>   
>   READ_LINE_ARGB8888(ARGB8888_read_line, px, px[3], px[2], px[1], px[0])
> +READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
> +READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
> +READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
>   
>   
>   READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
> @@ -637,8 +643,20 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
>   	switch (format) {
>   	case DRM_FORMAT_ARGB8888:
>   		return &ARGB8888_read_line;
> +	case DRM_FORMAT_ABGR8888:
> +		return &ABGR8888_read_line;
> +	case DRM_FORMAT_BGRA8888:
> +		return &BGRA8888_read_line;
> +	case DRM_FORMAT_RGBA8888:
> +		return &RGBA8888_read_line;
>   	case DRM_FORMAT_XRGB8888:
>   		return &XRGB8888_read_line;
> +	case DRM_FORMAT_XBGR8888:
> +		return &XBGR8888_read_line;
> +	case DRM_FORMAT_RGBX8888:
> +		return &RGBX8888_read_line;
> +	case DRM_FORMAT_BGRX8888:
> +		return &BGRX8888_read_line;
>   	case DRM_FORMAT_ARGB16161616:
>   		return &ARGB16161616_read_line;
>   	case DRM_FORMAT_XRGB16161616:
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 67f891e7ac58..941a6e92a040 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -14,7 +14,13 @@
>   
>   static const u32 vkms_formats[] = {
>   	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_RGBA8888,
>   	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_RGBX8888,
> +	DRM_FORMAT_BGRX8888,
>   	DRM_FORMAT_XRGB16161616,
>   	DRM_FORMAT_ARGB16161616,
>   	DRM_FORMAT_RGB565,
> 


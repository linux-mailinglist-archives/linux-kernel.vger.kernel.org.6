Return-Path: <linux-kernel+bounces-383232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B6A9B18C9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A8828286B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508071DFF8;
	Sat, 26 Oct 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="tC7adDZq"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD840A947
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954282; cv=none; b=aETMbS8FOWcKPSASPbEWj8ondYGvDDH8Aa6/2WnzGmiiNRiaVDcUi3FwKDtVYKef5II1OJ1Y8FU91tx2g6+HepTWE00xPX5etANe4QTYJaIV5TAqC1/h50eD7xkd6HFzTdY+pKZ7J3eUP2g7YjEYsOyOp2D1XE9PptGJ7Zu/VJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954282; c=relaxed/simple;
	bh=AB0X7XPmyec16ojEbTL0j6BejCpTFT7VkqJyU93TSiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=an0dxwUHlaEQxonEXH3uDllbU331kqBUfn158UtxSas4+x3p5jiIIF8yoxICSBb8qsV2fDFXu333IZ/1l0jqVqIAyVmU2SWv0iF513kGD45hEhtZRfvOnwcL9ZcXPiDj1wAoUmfn2AYPljaBTTN74UZmM6YPL6dygqDe3ifwdU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=tC7adDZq; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XbMzJ6ZDkzDrQc;
	Sat, 26 Oct 2024 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1729954280; bh=AB0X7XPmyec16ojEbTL0j6BejCpTFT7VkqJyU93TSiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tC7adDZq77mHJSvAaZ9bVyVbbhJeXy5fYIiHj5+zVu7Ta+B6mwSr9Sn1s1QnRnd8g
	 OjjDDN4Ece9M0r7IUinlHC45exwnhdbFmjHg5vAzAa8dK7VnZdjC/fYjy1u+6XYMES
	 0plNh9oCjdlSowH9iyXLDVARvxDi/jwwqJg7RWO8=
X-Riseup-User-ID: 511F6C9D05B4BD43076242EBAF7E37819723CB799D561371F011EDECEA1C1194
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XbMzC2JMkzJsFN;
	Sat, 26 Oct 2024 14:51:03 +0000 (UTC)
Message-ID: <53d04022-7199-4880-9b41-1ee7abdad997@riseup.net>
Date: Sat, 26 Oct 2024 11:51:01 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v2 5/8] drm/vkms: Add support for RGB888 formats
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
 <20241007-b4-new-color-formats-v2-5-d47da50d4674@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20241007-b4-new-color-formats-v2-5-d47da50d4674@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 07/10/24 13:46, Louis Chauvet wrote:
> Add the support for:
> - RGB888
> - BGR888
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/vkms_formats.c | 7 +++++++
>   drivers/gpu/drm/vkms/vkms_plane.c   | 2 ++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index e34bea5da752..2376ea8661ac 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -461,6 +461,9 @@ READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
>   READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
>   READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
>   
> +READ_LINE_ARGB8888(RGB888_read_line, px, 255, px[2], px[1], px[0])
> +READ_LINE_ARGB8888(BGR888_read_line, px, 255, px[0], px[1], px[2])
> +
>   READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0])
>   READ_LINE_16161616(ABGR16161616_read_line, px, px[3], px[0], px[1], px[2])
>   READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0])
> @@ -679,6 +682,10 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
>   		return &RGBX8888_read_line;
>   	case DRM_FORMAT_BGRX8888:
>   		return &BGRX8888_read_line;
> +	case DRM_FORMAT_RGB888:
> +		return RGB888_read_line;

Shouldn't it be &RGB888_read_line?

> +	case DRM_FORMAT_BGR888:
> +		return BGR888_read_line;

Same.

Best Regards,
- Maíra

>   	case DRM_FORMAT_ARGB16161616:
>   		return &ARGB16161616_read_line;
>   	case DRM_FORMAT_ABGR16161616:
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index a243a706459f..0fa589abc53a 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -21,6 +21,8 @@ static const u32 vkms_formats[] = {
>   	DRM_FORMAT_XBGR8888,
>   	DRM_FORMAT_RGBX8888,
>   	DRM_FORMAT_BGRX8888,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_BGR888,
>   	DRM_FORMAT_XRGB16161616,
>   	DRM_FORMAT_XBGR16161616,
>   	DRM_FORMAT_ARGB16161616,
> 


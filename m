Return-Path: <linux-kernel+bounces-346985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D14498CBAA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF921C21F02
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F4168B1;
	Wed,  2 Oct 2024 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BcOTVKcW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391751F93E;
	Wed,  2 Oct 2024 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841013; cv=none; b=Xknv8nRuY/1SmhTfe6q+bGFNudJrx64TW3+6lwIUwXMa99HPx//f5XPxcNkEhGSeOAxh70c9kuH2UYuUF70KDBOlU6747SJ4efS9NSHo+f8jluEAxczPCpw8YkzuV+U4Uraz0xIHHhHcR7VdFHCSrn3yMGHY5CcLDJETf+mCsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841013; c=relaxed/simple;
	bh=VMOI8/7x+qtiOkamrg/w/xidHc8wrIhk0qSrhOYplqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtlbvwLwS5IGUb1qeeVEhw8jD5i8NQuiDUzS+pMetMVjIO2S7pjA8sPiF4gCvzmFNwOQNEU6E14HSNrcG377xu94iTym5IEYxxP6BgFB3MkSiM8bdmddzV3IcVyW6yXDx45hEbyeo+CZE9WaPi3P43O01JHKsWIjeWTvIucKRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BcOTVKcW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=MxZyhxHBXSs4Ge8O99PGuLdkeVv8FiE5M9ZZ5sgBuz0=; b=BcOTVKcWxhaCh5QTSOyE6RjpoK
	6oKIpz8fb5hPJ3IQ4xpNnHU2wW7yzE0XF5G6/HT2/maeacbq2PAGGKlsSWGJG5UMx2hf394EYQhYX
	jr3gTArEjDmo/OSVh0KCTawHjavcxE9sO4zjJ2X/SyFpwglgJpM/q0YgqivJRJLoaQLz+d/36rFWZ
	AE4f0D4uAdIyhCuMzowhZGJrmz6XJk9brnPXTfktf75bEoN+9uqZtjI26RN/sOePYD3p4SkItNoaC
	HSeX1wSwlcHKkQu9uallYJD4BImZF1Ghondn52/Nv2yKn9VH4gjN/eFUSAI+NnMA+lXWYSkvmyWgc
	hA6K8ElA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svqMi-00000003QPE-26AA;
	Wed, 02 Oct 2024 03:49:48 +0000
Message-ID: <d6d00186-e06c-4781-bec9-86a57c5f1576@infradead.org>
Date: Tue, 1 Oct 2024 20:49:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/15] drm/vkms: Add typedef and documentation for
 pixel_read and pixel_write functions
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Simona Vetter <simona@ffwll.ch>, arthurgrillo@riseup.net,
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
 Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20240930-yuv-v11-0-4b1a26bcfc96@bootlin.com>
 <20240930-yuv-v11-3-4b1a26bcfc96@bootlin.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240930-yuv-v11-3-4b1a26bcfc96@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/30/24 8:31 AM, Louis Chauvet wrote:
> Introduce two typedefs: pixel_read_t and pixel_write_t. It allows the
> compiler to check if the passed functions take the correct arguments.
> Such typedefs will help ensuring consistency across the code base in
> case of update of these prototypes.
> 
> Rename input/output variable in a consistent way between read_line and
> write_line.
> 
> A warn has been added in get_pixel_*_function to alert when an unsupported
> pixel format is requested. As those formats are checked before
> atomic_update callbacks, it should never happen.
> 
> Document for those typedefs.
> 
> Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.h     |  23 ++++++-
>  drivers/gpu/drm/vkms/vkms_formats.c | 124 ++++++++++++++++++++----------------
>  drivers/gpu/drm/vkms/vkms_formats.h |   4 +-
>  drivers/gpu/drm/vkms/vkms_plane.c   |   2 +-
>  4 files changed, 94 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index fcb5a5ff7df7..137348f4adb2 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -53,12 +53,31 @@ struct line_buffer {
>  	struct pixel_argb_u16 *pixels;
>  };
>  
> +/**
> + * typedef pixel_write_t - These functions are used to read a pixel from a
> + * &struct pixel_argb_u16, convert it in a specific format and write it in the @dst_pixels

Should @dst_pixels be @out_pixel?

> + * buffer.
> + *
> + * @out_pixel: destination address to write the pixel
> + * @in_pixel: pixel to write
> + */
> +typedef void (*pixel_write_t)(u8 *out_pixel, struct pixel_argb_u16 *in_pixel);


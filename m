Return-Path: <linux-kernel+bounces-531152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55616A43CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D16420D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1722690F1;
	Tue, 25 Feb 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H+qrDRLW"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B94267F54
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481330; cv=none; b=AprROwCFrUFzdpjSSBF9IuyS0x4U1Ud2j0aiSIAZSin1xCfwnM9xxvUvkOBVDi5DM+y/uStqpnvpq9iOgrZMOHv7v9mbr70pxQwR25gXq4sK+OMYN/Oqwd0Ro6Y22+w/yQKz08EUrk8Z3zB4QO7o59JOLMaeWD1xl5gpAh73shA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481330; c=relaxed/simple;
	bh=Y10VBZyJlbjqldx3bTihZn+GRzPG1yU5djUc3eTRRg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6mdSRojhox4baU+7Is1o3c4shJZ6U+jhPnEwfpXXNSKnXeDNarp7JgpAADYuYIsU0NNWRWC4BOtEst5SVRaCqQtce3cTzc1pLl90+GOqXJc4i0OM9igHL5G/NcFVXe24a5qPriD3pGnShrhayKUeCyIPbWsFSMjOGlA1EZUyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H+qrDRLW; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C959844413;
	Tue, 25 Feb 2025 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740481326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zp5u8yjrlnV7OlKda1v9pTddoJvZaVWNOC89IkO/Cc=;
	b=H+qrDRLWtRMvGbnh0t/d51NmDcWwviPNVNUAdottdhMbLdDhg7Y37rAX2PscIlM9bmzUv/
	6kdL7wx0oDhsf1sRQRqQadyBDhCoxXCCRc8Xa0FGtsBydA6hhUhiNTMoXPRqa8Rw28wyuE
	duYfBhVwxLu4Mhgl+scH8/JSp1U5rUlznswkgT6f2YIsdjBxY6J6/qyXMMZvIwctWwDDNk
	WiJUDT2wf+WKhFp+/+uDqBo3pe+7RH41za/TOK8E9i3AgxOcfpKr5RGypbomt15VaF3qOX
	MqYAxMF+TwB1jS0qmAfmQ+SzM8zAGQUsf8S2VK1twim0jkvkCnvoDpn6Ob7g5A==
Date: Tue, 25 Feb 2025 12:02:03 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] drm/vkms: Expose device creation and destruction
Message-ID: <Z72jKyYAamcd0d3s@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
 <20250218170808.9507-2-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218170808.9507-2-jose.exposito89@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfejveetkedvleetudeuudegfeejheeujeefkefgtdeugfetfeeutdevieekvdeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 18/02/25 - 18:07, José Expósito wrote:
> In preparation for configfs support, expose vkms_create() and
> vkms_destroy().
> 
> Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Hi José,

First, thanks a lot for this series! I am very happy to see this moving, I
hope we will merge it soon!

> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 4 ++--
>  drivers/gpu/drm/vkms/vkms_drv.h | 4 ++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index a24d1655f7b8..23817c7b997e 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -146,7 +146,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
>  	return vkms_output_init(vkmsdev);
>  }
>  
> -static int vkms_create(struct vkms_config *config)
> +int vkms_create(struct vkms_config *config)
>  {
>  	int ret;
>  	struct platform_device *pdev;
> @@ -229,7 +229,7 @@ static int __init vkms_init(void)
>  	return 0;
>  }
>  
> -static void vkms_destroy(struct vkms_config *config)
> +void vkms_destroy(struct vkms_config *config)
>  {
>  	struct platform_device *pdev;
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index a74a7fc3a056..0fe08cd0c461 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -223,6 +223,10 @@ struct vkms_device {
>  #define to_vkms_plane_state(target)\
>  	container_of(target, struct vkms_plane_state, base.base)
>  
> +/* VKMS device */
> +int vkms_create(struct vkms_config *config);
> +void vkms_destroy(struct vkms_config *config);

Can we add some documentation?

/**
 * vkms_create - Create a device from a configuration
 * @config: Config used to configure the new device
 *
 * A pointer to the created vkms_device is stored in @config
 * Returns 0 in case of success.
 */


/**
 * vkms_destroy - Destroy a device
 * @config: Config from which the device was created
 *
 * The device is completly removed, but the @config pointers remains valid 
 * and can be reused for new devices.
 */

With this kind of documentation:
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> +
>  /**
>   * vkms_crtc_init() - Initialize a CRTC for VKMS
>   * @dev: DRM device associated with the VKMS buffer
> -- 
> 2.48.1
> 


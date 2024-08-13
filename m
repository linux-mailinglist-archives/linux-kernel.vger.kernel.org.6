Return-Path: <linux-kernel+bounces-285299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2892950BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440B21F27376
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32951A4F02;
	Tue, 13 Aug 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AHVHvwJ0"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF71A2C1E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571950; cv=none; b=X+WOcQ8WVXjRYHOSXMGD9ZVcFtAtGfyrvTyms2FXIM8nPuBNiTrL0KNx564mf4vGPRmSOAt1W1l2AzRZ2sF/5vuD5Di7kHCYARcDSwMqx4FXBa0LYKHABygvNos1LdN63ouTRzdr6XE/diYYsedHSLuHmLakWW9tOE4JpKMZ1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571950; c=relaxed/simple;
	bh=3ZUGZsM4/btdZTYz6EUJUK6RNrKSMYaa9UBF98N/VL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EL8cFMrxsJHwCKmHXY6bg2RHa7oTYzKCgufHiAXonX537rbd+Pm7+A8cNavlQEaBARP06XQEXO5gKwW1BIpp4sFOh/K/X0X6YY8MmApGfxsiPt+YWIh9uGF5JQaVc2fqm0fM413QSzWQ91Icb52ReEHBU90+s/UZ54BcWesKBxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AHVHvwJ0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7387B1C0003;
	Tue, 13 Aug 2024 17:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723571944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQvAnLoB3dqiNmiLK/gxaUFy0NoW7VZ5gvH+QxJXzCw=;
	b=AHVHvwJ0cciz5zcQzUZlCOBDx87r215qDd/JVE4UE++OslvJ9JTqNe2NhaQQPKU2Tvx7vd
	+L7EsJXtTbm8vXLs1nKwq8J2iBMzjDsSEYJ8R7mDbOQcFKlOLIrboCOrqU3FjNZFA4GhZX
	l5ygzBiHLJC/oiuVwOjoPk2F3GkLs9yTva+ZDFvoPaD6F2rrWcfMt/a/XamsPDKTCkdq/x
	pcwe/lxpiKEhhR8iX5uH11ZAyXkvr2FCVHprktvcNkPgYax250Hka4pqXJOXy3FEQ/XEBN
	q0rT/dcAfTCi7jz88UNFP8DKeu7hg96OCQ6Jd7Xg0hMSrIX+I7QnhzVDKzYY+A==
Date: Tue, 13 Aug 2024 19:58:57 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/17] drm/vkms: Use managed memory to create encoders
Message-ID: <Zrue4dAQ_11w_FaW@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
 <20240813105134.17439-6-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813105134.17439-6-jose.exposito89@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 13/08/24 - 12:44, José Expósito a écrit :
> A future patch will allow to create multiple encoders. Use managed
> memory to simplify the code.
> 
> Refactor, no functional changes.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.h    |  1 -
>  drivers/gpu/drm/vkms/vkms_output.c | 45 ++++++++++++++++++++----------
>  2 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 3156ff896c33..2466e8b0231f 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -122,7 +122,6 @@ struct vkms_crtc {
>  struct vkms_config;
>  
>  struct vkms_output {
> -	struct drm_encoder encoder;
>  	struct drm_connector connector;
>  };
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index dcd32bc30e17..15f0b72af325 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -4,6 +4,7 @@
>  #include "vkms_drv.h"
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_edid.h>
> +#include <drm/drm_managed.h>
>  #include <drm/drm_probe_helper.h>
>  
>  static const struct drm_connector_funcs vkms_connector_funcs = {
> @@ -14,10 +15,6 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
> -static const struct drm_encoder_funcs vkms_encoder_funcs = {
> -	.destroy = drm_encoder_cleanup,
> -};
> -
>  static int vkms_conn_get_modes(struct drm_connector *connector)
>  {
>  	int count;
> @@ -32,6 +29,31 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
>  	.get_modes    = vkms_conn_get_modes,
>  };
>  
> +static struct drm_encoder *vkms_encoder_init(struct vkms_device *vkms_device,
> +					     uint32_t possible_crtcs)
> +{
> +	struct drm_encoder *encoder;
> +	int ret;
> +
> +	encoder = drmm_kzalloc(&vkms_device->drm, sizeof(*encoder), GFP_KERNEL);
> +	if (!encoder) {
> +		DRM_ERROR("Failed to allocate encoder\n");
> +		return ERR_PTR(-ENOMEM);
> +	}

Thanks, I forgot this error handling in my implementation!

And while checking, I also found the drmm_encoder_alloc macro, which do 
the kzalloc AND the _init. Maybe we should use this?

> +
> +	ret = drmm_encoder_init(&vkms_device->drm, encoder, NULL,
> +				DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	if (ret) {
> +		DRM_ERROR("Failed to init encoder\n");
> +		kfree(encoder);

Are you sure about this kfree? As the encoder was initialized by 
drmm_kzalloc, it should be freed by drm?

Or at least, drmm_kfree?

> +		return ERR_PTR(ret);
> +	}
> +
> +	encoder->possible_crtcs = possible_crtcs;
> +
> +	return encoder;
> +}
> +
>  static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index)
>  {
>  	struct vkms_plane *overlay;
> @@ -51,7 +73,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  	struct vkms_output *output = &vkmsdev->output;
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct drm_connector *connector = &output->connector;
> -	struct drm_encoder *encoder = &output->encoder;
> +	struct drm_encoder *encoder;
>  	struct vkms_crtc *vkms_crtc;
>  	struct vkms_config_crtc *crtc_cfg;
>  	struct vkms_plane *primary, *cursor = NULL;
> @@ -101,13 +123,9 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  
>  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
>  
> -	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
> -			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> -	if (ret) {
> -		DRM_ERROR("Failed to init encoder\n");
> -		goto err_encoder;
> -	}
> -	encoder->possible_crtcs = 1;
> +	encoder = vkms_encoder_init(vkmsdev, BIT(0));
> +	if (IS_ERR(encoder))
> +		return PTR_ERR(encoder);
>  
>  	ret = drm_connector_attach_encoder(connector, encoder);
>  	if (ret) {
> @@ -120,9 +138,6 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  	return 0;
>  
>  err_attach:
> -	drm_encoder_cleanup(encoder);
> -
> -err_encoder:
>  	drm_connector_cleanup(connector);
>  
>  	return ret;
> -- 
> 2.46.0
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-kernel+bounces-285298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F7950BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A12B23404
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C36D1A3BCE;
	Tue, 13 Aug 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HkexexWK"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352501A38FB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571949; cv=none; b=Q4otnOqdafnUUMW91PQEhWLqoQr3w1AZ1JWdy5RgIJCzc3qGmqGI/GWeszQHMIMtqlm8O9qZ/qv89vQ0hXK8GZlfqyZpTTsqgMSTB3dYuTQc1u5ZqQ18uksgT/YxPo+UURBxXh7GbKXHMjN9Anx9n4jg/mfZZIt9ZP3OeD1mS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571949; c=relaxed/simple;
	bh=e202C4+gzmqVzVEdk+jALHM0ynOcspb2W5gFAXC2WBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvDc03AfMhzqNQs/s69IEYJlyTJzD2CyXJRtRCwSh1a8b3CJMud8cK66Ul9n/jZwxDzY1us/NgFNSLWQrrp+8FeORp1QdkoaeqfqKtcyx4b5InYpm9VegRT4PEVABpamOSerVZaJlbV97nUvud0+AwWJwou/FcSekdwg46xjSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HkexexWK; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C6E440006;
	Tue, 13 Aug 2024 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723571945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoBpP89OgZFGywT54KB2Ssh40O1nk37JFkQwY/5K3qw=;
	b=HkexexWK49rn7SDKNfRK4QaF5rJb4YPkXFZIqBtHLq4glwWO3lHZq/7gIMkmvTAaRC9dcD
	K57oWAyl86+P2tZHAlo1zq755UEKzazt8HFz/4IVPX+UmRKpBP4Fi4v0kFfg+2Gw3nneN6
	Eombc6WnSiTWbw/txtsfSw36d1mQqfKHTbvSezuVcRLfua67Dx0telyhvseKOM1ivM6d+v
	0SbvNw/ASEDjnVCyQOEPlZ8nw2NsIsUFQIHwc6oXtZi8TBugvBcpuwIuW62GczyAdOch4p
	E/OmU+GFUKinF4LhQa9w9fvgNmapIR3CIvbVKnD/fML7bV7QGgwt/uQmIphFtQ==
Date: Tue, 13 Aug 2024 19:58:58 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/17] drm/vkms: Allow to configure multiple
 connectors
Message-ID: <Zrue4sXhXYs-XVxN@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
 <20240813105134.17439-9-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813105134.17439-9-jose.exposito89@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 13/08/24 - 12:44, José Expósito a écrit :
> Add a list of connector configurations to vkms_config and add as many
> connector as configured during output initialization.
> 
> For backwards compatibility, create a single connector in the default
> configuration.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 40 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_config.h | 12 +++++++++
>  drivers/gpu/drm/vkms/vkms_output.c | 11 +++++---
>  3 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 6a8dfebee24e..a456f9db3c66 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -19,6 +19,7 @@ struct vkms_config *vkms_config_create(char *dev_name)
>  	config->dev_name = dev_name;
>  	config->crtcs = (struct list_head)LIST_HEAD_INIT(config->crtcs);
>  	config->encoders = (struct list_head)LIST_HEAD_INIT(config->encoders);
> +	config->connectors = (struct list_head)LIST_HEAD_INIT(config->connectors);

Again, this cast seems useless
  
>  	return config;
>  }
> @@ -30,6 +31,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
>  	struct vkms_config *config;
>  	struct vkms_config_crtc *crtc_cfg;
>  	struct vkms_config_encoder *encoder_cfg;
> +	struct vkms_config_connector *connector_cfg;
>  
>  	config = vkms_config_create(DEFAULT_DEVICE_NAME);
>  	if (IS_ERR(config))
> @@ -46,6 +48,10 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
>  	if (IS_ERR(encoder_cfg))
>  		return ERR_CAST(encoder_cfg);
>  
> +	connector_cfg = vkms_config_add_connector(config, BIT(0));
> +	if (IS_ERR(connector_cfg))
> +		return ERR_CAST(connector_cfg);
> +

The config pointer is leaked here.

>  	return config;
>  }
>  
> @@ -53,6 +59,7 @@ void vkms_config_destroy(struct vkms_config *config)
>  {
>  	struct vkms_config_crtc *crtc_cfg, *crtc_tmp;
>  	struct vkms_config_encoder *encoder_cfg, *encoder_tmp;
> +	struct vkms_config_connector *connector_cfg, *connector_tmp;
>  
>  	list_for_each_entry_safe(crtc_cfg, crtc_tmp, &config->crtcs, list)
>  		vkms_config_destroy_crtc(config, crtc_cfg);
> @@ -60,6 +67,9 @@ void vkms_config_destroy(struct vkms_config *config)
>  	list_for_each_entry_safe(encoder_cfg, encoder_tmp, &config->encoders, list)
>  		vkms_config_destroy_encoder(config, encoder_cfg);
>  
> +	list_for_each_entry_safe(connector_cfg, connector_tmp, &config->connectors, list)
> +		vkms_config_destroy_connector(config, connector_cfg);
> +
>  	kfree(config);
>  }
>  
> @@ -70,6 +80,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
>  	struct vkms_config_crtc *crtc_cfg;
>  	struct vkms_config_encoder *encoder_cfg;
> +	struct vkms_config_connector *connector_cfg;
>  	int n;
>  
>  	seq_printf(m, "dev_name=%s\n", vkmsdev->config->dev_name);
> @@ -90,6 +101,13 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  		n++;
>  	}
>  
> +	n = 0;
> +	list_for_each_entry(connector_cfg, &vkmsdev->config->connectors, list) {
> +		seq_printf(m, "connector(%d).possible_encoders=%d\n", n,
> +			   connector_cfg->possible_encoders);
> +		n++;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -166,3 +184,25 @@ void vkms_config_destroy_encoder(struct vkms_config *config,
>  	list_del(&encoder_cfg->list);
>  	kfree(encoder_cfg);
>  }
> +
> +struct vkms_config_connector *vkms_config_add_connector(struct vkms_config *config,
> +							uint32_t possible_encoders)
> +{
> +	struct vkms_config_connector *connector_cfg;
> +
> +	connector_cfg = kzalloc(sizeof(*connector_cfg), GFP_KERNEL);
> +	if (!connector_cfg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	connector_cfg->possible_encoders = possible_encoders;

For config_encoder destruction you need to remove it from this 
possible_encoders list.

> +	list_add_tail(&connector_cfg->list, &config->connectors);
> +
> +	return connector_cfg;
> +}
> +
> +void vkms_config_destroy_connector(struct vkms_config *config,
> +				   struct vkms_config_connector *connector_cfg)
> +{
> +	list_del(&connector_cfg->list);
> +	kfree(connector_cfg);
> +}
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index b717b5c0d3d9..f1dd59fc6300 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -20,12 +20,18 @@ struct vkms_config_encoder {
>  	uint32_t possible_crtcs;
>  };
>  
> +struct vkms_config_connector {
> +	struct list_head list;
> +	uint32_t possible_encoders;
> +};
> +
>  struct vkms_config {
>  	char *dev_name;
>  	bool cursor;
>  	bool overlay;
>  	struct list_head crtcs;
>  	struct list_head encoders;
> +	struct list_head connectors;
>  	/* only set when instantiated */
>  	struct vkms_device *dev;
>  };
> @@ -52,4 +58,10 @@ struct vkms_config_encoder *vkms_config_add_encoder(struct vkms_config *config,
>  void vkms_config_destroy_encoder(struct vkms_config *config,
>  				 struct vkms_config_encoder *encoder_cfg);
>  
> +/* Connectors */
> +struct vkms_config_connector *vkms_config_add_connector(struct vkms_config *config,
> +							uint32_t possible_encoders);
> +void vkms_config_destroy_connector(struct vkms_config *config,
> +				   struct vkms_config_connector *connector_cfg);
> +
>  #endif /* _VKMS_CONFIG_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 4413cf88afc7..021a491de817 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -100,6 +100,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct drm_connector *connector;
> +	struct vkms_config_connector *connector_cfg;
>  	struct drm_encoder *encoder;
>  	struct vkms_config_encoder *encoder_cfg;
>  	struct vkms_crtc *vkms_crtc;
> @@ -142,10 +143,6 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  		}
>  	}
>  
> -	connector = vkms_connector_init(vkmsdev, BIT(index));
> -	if (IS_ERR(connector))
> -		return PTR_ERR(connector);
> -
>  	list_for_each_entry(encoder_cfg, &vkmsdev->config->encoders, list) {
>  		encoder = vkms_encoder_init(vkmsdev, encoder_cfg->possible_crtcs,
>  					    encoder_cfg->index);
> @@ -153,6 +150,12 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  			return PTR_ERR(encoder);
>  	}
>  
> +	list_for_each_entry(connector_cfg, &vkmsdev->config->connectors, list) {
> +		connector = vkms_connector_init(vkmsdev, connector_cfg->possible_encoders);
> +		if (IS_ERR(connector))
> +			return PTR_ERR(connector);
> +	}
> +
>  	drm_mode_config_reset(dev);
>  
>  	return 0;
> -- 
> 2.46.0
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


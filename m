Return-Path: <linux-kernel+bounces-285307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A9950BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CE01F27FED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA5F1AAE0A;
	Tue, 13 Aug 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C5wYz6nk"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429CC1A38FB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571956; cv=none; b=eE+0uS9W8qpPwRhNLWHI9+1JLuE5sX3ovNI3fEsH38h3fbW+4FPlcsCLzO58yQfyn0nPC+DN6F527XH6NTyAvvoQ2NOFguNdGsTFAWOzu14YlA+hS1gsqpi5wFn7e5J78LzDoxpFdBLSlhta35pBuP7I4It8+m5Ydyj8JGdOQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571956; c=relaxed/simple;
	bh=yrF3Os+CcjUzbcBP6umBU235mqihwirjqWEMxh86+GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3mchaM+lBvFLyaUhdK5BUf00vj1bBI0QqFSBzFuC3u7wefiNM5jK3YxnZE4lQdhY+nudrWo3osieYW60kPMUTSHPE7E0ZvpFG/8RBkfbR5WuPFoqd2DxrADiPVH1hGJhC1dgfdNNSztuKXEoyL2QJQb41UVkLvg7CG3pQJgy4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C5wYz6nk; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5423C60002;
	Tue, 13 Aug 2024 17:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723571946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orkyNgJ7hfzJF9A6fcHGj0g7FteeKore3Wf3uOpKhnE=;
	b=C5wYz6nkIETHQFlQD+L8RwGEUFE/6a0hDU6B/LLdFn5xvNZn38X3LzOIH4ibkrsDMmjBOj
	6w0MOaF8PkwGOWsD/J2kRrP3scsXW60nKLZmkT9a/62gzkjfxsE0fOo9Gb3Z0XnD5HBZKz
	IV9tdEWcYYgNPsw6ic3Wj0lrU7xe1qOx6ecsygV51O6aLs0UORPDOOmsgQGLpKkxjXedkL
	+3+/YQZ5cCsYoC+p+RhV4plHzCDwpik11DnthSyzmC44AyCzAky61v3DKKX0+F9/v1Hhb3
	1WsNrt/nU9YlknzIJTYTkvKLLomC7o6FyAOJtlyHV9z5+Xd3wfNMQbnl6ky5sg==
Date: Tue, 13 Aug 2024 19:59:00 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 14/17] drm/vkms: Allow to configure multiple encoders
Message-ID: <Zrue5DHONxSWDYEL@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
 <20240813105134.17439-15-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813105134.17439-15-jose.exposito89@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 13/08/24 - 12:44, José Expósito a écrit :
> Add a list of encoder configurations to vkms_config and add as many
> encoders as configured during output initialization.

Small mistake, this commit is about connector with configfs :)

> 
> For backwards compatibility, create a single encoder in the default
> configuration.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  Documentation/gpu/vkms.rst           |  16 +++
>  drivers/gpu/drm/vkms/vkms_config.h   |   3 +
>  drivers/gpu/drm/vkms/vkms_configfs.c | 184 ++++++++++++++++++++++++---
>  3 files changed, 188 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index c69be063d3b4..b6ceb8c48310 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -75,6 +75,7 @@ And directories are created for each configurable item of the display pipeline::
>  
>    tree /config/vkms/my-vkms
>      /config/vkms/my-vkms
> +    ├── connectors
>      ├── crtcs
>      ├── enabled
>      └── encoders
> @@ -100,16 +101,31 @@ Encoders can be linked to CRTCs by creating a symbolic link under
>  
>    sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/encoders/encoder0/possible_crtcs
>  
> +Next, create one or more connectors::
> +
> +  sudo mkdir /config/vkms/my-vkms/connectors/connector0
> +
> +The status of the connector can be changed writing ``1`` (connected), ``2``
> +(disconnected) or ``3`` (unknown) to the ``status`` attribute and they can be
> +linked to encoders by creating a symbolic link under ``possible_encoders``::
> +
> +  sudo ln -s /config/vkms/my-vkms/encoders/encoder0 /config/vkms/my-vkms/connectors/connector0/possible_encoders
> +
>  Once you are done configuring the VKMS instance, enable it::
>  
>    echo "1" | sudo tee /config/vkms/my-vkms/enabled
>  
> +Note that the connector ``status`` can be changed once the VKMS instance is
> +enabled to emulate hot-plug/unplug.
> +
>  Finally, you can remove the VKMS instance disabling it::
>  
>    echo "0" | sudo tee /config/vkms/my-vkms/enabled
>  
>  Or removing the top level directory and its subdirectories::
>  
> +  sudo rm /config/vkms/my-vkms/connectors/*/possible_encoders/*
> +  sudo rmdir /config/vkms/my-vkms/connectors/*
>    sudo rm /config/vkms/my-vkms/encoders/*/possible_crtcs/*
>    sudo rmdir /config/vkms/my-vkms/encoders/*
>    sudo rmdir /config/vkms/my-vkms/crtcs/*
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index f9423533a7f3..cf45e3f6ae92 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -40,6 +40,9 @@ struct vkms_config_connector {
>  	enum drm_connector_status status;
>  	/* only set when instantiated */
>  	struct drm_connector *connector;
> +	/* only used if created from configfs */
> +	struct config_group connector_group;
> +	struct config_group possible_encoders_group;
>  };
>  
>  struct vkms_config {
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index c0b62fb93dc0..d2369f53e2d8 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -21,6 +21,8 @@ static bool is_configfs_registered;
>   * Each of its items represent a CRTC
>   * @encoders_group: Default subgroup of @device_group at
>   * "/config/vkms/encoders". Each of its items represent a encoder
> + * @connectors_group: Default subgroup of @device_group at
> + * "/config/vkms/connectors". Each of its items represent a connector
>   * @lock: Lock used to project concurrent access to the configuration attributes
>   * @enabled: Protected by @lock. The device is created or destroyed when this
>   * option changes
> @@ -30,6 +32,7 @@ struct vkms_configfs {
>  	struct config_group device_group;
>  	struct config_group crtcs_group;
>  	struct config_group encoders_group;
> +	struct config_group connectors_group;
>  
>  	/* protected by @lock */
>  	struct mutex lock;
> @@ -57,6 +60,18 @@ struct vkms_configfs {
>  #define encoder_possible_crtcs_item_to_vkms_config_encoder(item) \
>  	container_of(to_config_group(item), struct vkms_config_encoder, possible_crtcs_group)
>  
> +#define connectors_group_to_vkms_configfs(group) \
> +	container_of(group, struct vkms_configfs, connectors_group)
> +
> +#define connectors_item_to_vkms_configfs(item) \
> +	container_of(to_config_group(item), struct vkms_configfs, connectors_group)
> +
> +#define connector_item_to_vkms_config_connector(item) \
> +	container_of(to_config_group(item), struct vkms_config_connector, connector_group)
> +
> +#define connector_possible_encoders_item_to_vkms_config_connector(item) \
> +	container_of(to_config_group(item), struct vkms_config_connector, possible_encoders_group)
> +
>  static ssize_t crtc_cursor_show(struct config_item *item, char *page)
>  {
>  	struct vkms_config_crtc *crtc_cfg = crtcs_item_to_vkms_config_crtc(item);
> @@ -287,6 +302,154 @@ static struct config_item_type encoders_group_type = {
>  	.ct_owner = THIS_MODULE,
>  };
>  
> +static int connector_possible_encoders_allow_link(struct config_item *src,
> +						  struct config_item *target)
> +{
> +	struct vkms_config_connector *connector_cfg;
> +	struct vkms_config_encoder *encoder_cfg;

I think I forgit it before, but once the device is enabled, no 
configuration should be possible (except connector status).

> +	if (target->ci_type != &encoder_group_type)
> +		return -EINVAL;
> +

Same as before, the type and the device must be checked.

> +	connector_cfg = connector_possible_encoders_item_to_vkms_config_connector(src);
> +	encoder_cfg = encoders_item_to_vkms_config_encoder(target);
> +
> +	if (connector_cfg->possible_encoders & BIT(encoder_cfg->index))
> +		return -EINVAL;
> +
> +	connector_cfg->possible_encoders |= BIT(encoder_cfg->index);
> +
> +	return 0;
> +}
> +
> +static void connector_possible_encoders_drop_link(struct config_item *src,
> +						  struct config_item *target)
> +{
> +	struct vkms_config_connector *connector_cfg;
> +	struct vkms_config_encoder *encoder_cfg;
> +
> +	connector_cfg = connector_possible_encoders_item_to_vkms_config_connector(src);
> +	encoder_cfg = encoders_item_to_vkms_config_encoder(target);
> +
> +	connector_cfg->possible_encoders &= ~BIT(encoder_cfg->index);
> +}
> +
> +static struct configfs_item_operations connector_possible_encoders_item_ops = {
> +	.allow_link = &connector_possible_encoders_allow_link,
> +	.drop_link = &connector_possible_encoders_drop_link,
> +};
> +
> +static struct config_item_type connector_possible_encoders_group_type = {
> +	.ct_item_ops = &connector_possible_encoders_item_ops,
> +	.ct_owner = THIS_MODULE,
> +};
> +
> +static ssize_t connector_status_show(struct config_item *item, char *page)
> +{
> +	struct vkms_config_connector *connector_cfg =
> +		connector_item_to_vkms_config_connector(item);
> +
> +	return sprintf(page, "%d\n", connector_cfg->status);
> +}
> +
> +static ssize_t connector_status_store(struct config_item *item, const char *page,
> +				      size_t count)
> +{
> +	struct vkms_configfs *configfs;
> +	struct vkms_config_connector *connector_cfg;
> +	int status;
> +
> +	if (kstrtoint(page, 10, &status))
> +		return -EINVAL;
> +
> +	switch (status) {
> +	case connector_status_connected:
> +	case connector_status_disconnected:
> +	case connector_status_unknown:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	configfs = connectors_item_to_vkms_configfs(item->ci_parent);
> +	connector_cfg = connector_item_to_vkms_config_connector(item);
> +
> +	vkms_update_connector_status(configfs->vkms_config, connector_cfg, status);
> +
> +	return (ssize_t)count;
> +}
> +
> +CONFIGFS_ATTR(connector_, status);
> +
> +static struct configfs_attribute *connector_group_attrs[] = {
> +	&connector_attr_status,
> +	NULL,
> +};
> +
> +static const struct config_item_type connector_group_type = {
> +	.ct_attrs = connector_group_attrs,
> +	.ct_owner = THIS_MODULE,
> +};
> +
> +static struct config_group *make_connectors_group(struct config_group *group,
> +						  const char *name)
> +{
> +	struct vkms_configfs *configfs = connectors_group_to_vkms_configfs(group);
> +	struct vkms_config_connector *connector_cfg;
> +	int ret;
> +
> +	mutex_lock(&configfs->lock);
> +
> +	if (configfs->enabled) {
> +		ret = -EINVAL;
> +		goto err_unlock;
> +	}
> +
> +	connector_cfg = vkms_config_add_connector(configfs->vkms_config, 0,
> +						  connector_status_connected);
> +	if (IS_ERR(connector_cfg)) {
> +		ret = PTR_ERR(connector_cfg);
> +		goto err_unlock;
> +	}
> +
> +	config_group_init_type_name(&connector_cfg->connector_group, name,
> +				    &connector_group_type);
> +
> +	config_group_init_type_name(&connector_cfg->possible_encoders_group,
> +				    "possible_encoders",
> +				    &connector_possible_encoders_group_type);
> +	configfs_add_default_group(&connector_cfg->possible_encoders_group,
> +				   &connector_cfg->connector_group);
> +
> +	mutex_unlock(&configfs->lock);
> +
> +	return &connector_cfg->connector_group;
> +
> +err_unlock:
> +	mutex_unlock(&configfs->lock);
> +	return ERR_PTR(ret);
> +}
> +
> +static void drop_connectors_group(struct config_group *group,
> +				  struct config_item *item)
> +{
> +	struct vkms_configfs *configfs = connectors_group_to_vkms_configfs(group);
> +	struct vkms_config_connector *connector_cfg =
> +		connector_item_to_vkms_config_connector(item);
> +
> +	vkms_config_destroy_connector(configfs->vkms_config, connector_cfg);
> +}

Again, I think drop should not free memory.

> +
> +static struct configfs_group_operations connectors_group_ops = {
> +	.make_group = &make_connectors_group,
> +	.drop_item = &drop_connectors_group,
> +};
> +
> +static struct config_item_type connectors_group_type = {
> +	.ct_group_ops = &connectors_group_ops,
> +	.ct_owner = THIS_MODULE,
> +};
> +
>  static ssize_t device_enabled_show(struct config_item *item, char *page)
>  {
>  	struct vkms_configfs *configfs = config_item_to_vkms_configfs(item);
> @@ -341,9 +504,7 @@ static struct config_group *make_device_group(struct config_group *group,
>  					      const char *name)
>  {
>  	struct vkms_configfs *configfs;
> -	struct vkms_config_connector *connector_cfg = NULL;
>  	char *config_name;
> -	int ret;
>  
>  	if (strcmp(name, DEFAULT_DEVICE_NAME) == 0)
>  		return ERR_PTR(-EINVAL);
> @@ -358,8 +519,8 @@ static struct config_group *make_device_group(struct config_group *group,
>  	config_name = config_item_name(&configfs->device_group.cg_item);
>  	configfs->vkms_config = vkms_config_create(config_name);
>  	if (IS_ERR(configfs->vkms_config)) {
> -		ret = PTR_ERR(configfs->vkms_config);
> -		goto err_kfree;
> +		kfree(configfs);
> +		return ERR_CAST(configfs->vkms_config);
>  	}
>  
>  	config_group_init_type_name(&configfs->crtcs_group, "crtcs",
> @@ -372,19 +533,12 @@ static struct config_group *make_device_group(struct config_group *group,
>  	configfs_add_default_group(&configfs->encoders_group,
>  				   &configfs->device_group);
>  
> -	connector_cfg = vkms_config_add_connector(configfs->vkms_config, BIT(0),
> -						  connector_status_connected);
> -	if (IS_ERR(connector_cfg)) {
> -		ret = PTR_ERR(connector_cfg);
> -		goto err_kfree;
> -	}
> +	config_group_init_type_name(&configfs->connectors_group, "connectors",
> +				    &connectors_group_type);
> +	configfs_add_default_group(&configfs->connectors_group,
> +				   &configfs->device_group);
>  
>  	return &configfs->device_group;
> -
> -err_kfree:
> -	kfree(configfs);
> -	kfree(connector_cfg);
> -	return ERR_PTR(ret);
>  }
>  
>  static void drop_device_group(struct config_group *group,
> -- 
> 2.46.0
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


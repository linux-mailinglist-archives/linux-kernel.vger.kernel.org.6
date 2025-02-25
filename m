Return-Path: <linux-kernel+bounces-531147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E0A43CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C28A177168
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8FC2686BC;
	Tue, 25 Feb 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AHm5mbge"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B7267B09
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481327; cv=none; b=Q5VGNoo7nLhVAMzYcWsK280fkQT3NlPgo85/Nx6cXL/wLIfHLzpn1bo7DvSvkmvt9J0vpfkQbFld/Qc+2Fvur+0nw+IBcaowF3XCUA/pyD/erBrboDdTrCVEFxV41Ls+ZUSMRAICnQA//ReosLl5hjgU/Xci6vLd4JbEr2Ylpfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481327; c=relaxed/simple;
	bh=ym5MPNkaJW8bzCep7gqhZe6twFcOawqCLFSjtuGi0Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9HRe4UmTrz5fXUwbKkQnjitRhm8YBjtM0h53ckZq3FpqDu0yplVJYeHQay0ECpc0d4J7VzngInW16XVao9yMA8mcl9jNgIvjmAK7MALDLTxK1FX5iMmNBn/bC3s63o5gUQ23MKsj9O8uJQSrxKvTDImpMlM+JZPqE6AT+twSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AHm5mbge; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6FB343418;
	Tue, 25 Feb 2025 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740481322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZM43GVkokiPZclxCTga88bz6ahzFAKsTpX9uETgur4=;
	b=AHm5mbgewTXOl4w8hDinTjTEZj6c613GCOIHfdMo06tnKkRMGCQfBOOHfl5CwKYyCMzHKl
	lquHcxtXYw0JbYCnbezKjGLvPNTUzpTeCTbzEYQ9Tx3oiZRr4w9N9wKsvQVIqjy1qFnQ2u
	s77O36KttLHwqceOp6shdJQ+4CS4F8EjGgEPxuUjaV1RCOk3+OiR9j/hqPUhoSFgT7xsnO
	lXqGwJuOtC/oCE9bNcwU+QEXuIaJqaGEnXNx91Mxlcw7zUrUqwYgdHmeaB66Iq1dbx8gmj
	tivP8HWKOjV2YJEiCv8/cfqryUDV8b88QNhy1Nb6MBTfURcX+EIUGqr+HtE6BA==
Date: Tue, 25 Feb 2025 12:02:00 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] drm/vkms: Allow to configure multiple connectors
 via configfs
Message-ID: <Z72jKDSV6A70fWs7@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
 <20250218170808.9507-11-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218170808.9507-11-jose.exposito89@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptedtkeeitdehvdeggfevvdevledvleevvdeggeeufeefgedtledujedtteeghfeinecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 18/02/25 - 18:08, José Expósito wrote:
> Create a default subgroup at
> /config/vkms/connectors to allow to create as many connectors as
> required.
> 
> Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  Documentation/gpu/vkms.rst           |   6 ++
>  drivers/gpu/drm/vkms/vkms_configfs.c | 100 +++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 6a15af0b7317..3dd55c3e8900 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -74,6 +74,7 @@ By default, the instance is disabled::
>  And directories are created for each configurable item of the display pipeline::
>  
>    tree /config/vkms/my-vkms
> +  ├── connectors
>    ├── crtcs
>    ├── enabled
>    ├── encoders
> @@ -102,6 +103,10 @@ Next, create one or more encoders::
>  
>    sudo mkdir /config/vkms/my-vkms/encoders/encoder0
>  
> +Last but not least, create one or more connectors::
> +
> +  sudo mkdir /config/vkms/my-vkms/connectors/connector0
> +
>  To finish the configuration, link the different pipeline items::
>  
>    sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
> @@ -126,6 +131,7 @@ And removing the top level directory and its subdirectories::
>    sudo rmdir /config/vkms/my-vkms/planes/*
>    sudo rmdir /config/vkms/my-vkms/crtcs/*
>    sudo rmdir /config/vkms/my-vkms/encoders/*
> +  sudo rmdir /config/vkms/my-vkms/connectors/*
>    sudo rmdir /config/vkms/my-vkms
>  
>  Testing With IGT
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 66c8a66f7b2b..cd8a164bda3d 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -18,6 +18,7 @@ static bool is_configfs_registered;
>   * @planes_group: Default subgroup of @group at "/config/vkms/planes"
>   * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
>   * @encoders_group: Default subgroup of @group at "/config/vkms/encoders"
> + * @connectors_group: Default subgroup of @group at "/config/vkms/connectors"
>   * @lock: Lock used to project concurrent access to the configuration attributes
>   * @config: Protected by @lock. Configuration of the VKMS device
>   * @enabled: Protected by @lock. The device is created or destroyed when this
> @@ -28,6 +29,7 @@ struct vkms_configfs_device {
>  	struct config_group planes_group;
>  	struct config_group crtcs_group;
>  	struct config_group encoders_group;
> +	struct config_group connectors_group;
>  
>  	struct mutex lock;
>  	struct vkms_config *config;
> @@ -80,6 +82,20 @@ struct vkms_configfs_encoder {
>  	struct vkms_config_encoder *config;
>  };
>  
> +/**
> + * struct vkms_configfs_connector - Configfs representation of a connector
> + *
> + * @group: Top level configuration group that represents a connector.
> + * Initialized when a new directory is created under "/config/vkms/connectors"
> + * @dev: The vkms_configfs_device this connector belongs to
> + * @config: Configuration of the VKMS connector
> + */
> +struct vkms_configfs_connector {
> +	struct config_group group;
> +	struct vkms_configfs_device *dev;
> +	struct vkms_config_connector *config;
> +};
> +
>  #define device_item_to_vkms_configfs_device(item) \
>  	container_of(to_config_group((item)), struct vkms_configfs_device, \
>  		     group)
> @@ -105,6 +121,10 @@ struct vkms_configfs_encoder {
>  	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
>  		     possible_crtcs_group)
>  
> +#define connector_item_to_vkms_configfs_connector(item) \
> +	container_of(to_config_group((item)), struct vkms_configfs_connector, \
> +		     group)
> +
>  static ssize_t crtc_writeback_show(struct config_item *item, char *page)
>  {
>  	struct vkms_configfs_crtc *crtc;
> @@ -540,6 +560,82 @@ static const struct config_item_type encoder_group_type = {
>  	.ct_owner	= THIS_MODULE,
>  };
>  
> +static void connector_release(struct config_item *item)
> +{
> +	struct vkms_configfs_connector *connector;
> +	struct mutex *lock;
> +
> +	connector = connector_item_to_vkms_configfs_connector(item);
> +	lock = &connector->dev->lock;
> +
> +	mutex_lock(lock);
> +	vkms_config_destroy_connector(connector->config);
> +	kfree(connector);
> +	mutex_unlock(lock);
> +}
> +
> +static struct configfs_item_operations connector_item_operations = {
> +	.release	= &connector_release,
> +};
> +
> +static const struct config_item_type connector_item_type = {
> +	.ct_item_ops	= &connector_item_operations,
> +	.ct_owner	= THIS_MODULE,
> +};
> +
> +static struct config_group *make_connector_group(struct config_group *group,
> +						 const char *name)
> +{
> +	struct vkms_configfs_device *dev;
> +	struct vkms_configfs_connector *connector;
> +	int ret;
> +
> +	dev = child_group_to_vkms_configfs_device(group);
> +
> +	mutex_lock(&dev->lock);
> +
> +	if (dev->enabled) {
> +		ret = -EINVAL;
> +		goto err_unlock;
> +	}
> +
> +	connector = kzalloc(sizeof(*connector), GFP_KERNEL);
> +	if (!connector) {
> +		ret = -ENOMEM;

-EPERM/-EBUSY?

> +		goto err_unlock;
> +	}
> +
> +	connector->dev = dev;
> +
> +	connector->config = vkms_config_create_connector(dev->config);
> +	if (IS_ERR(connector->config)) {
> +		ret = PTR_ERR(connector->config);
> +		goto err_free;
> +	}
> +
> +	config_group_init_type_name(&connector->group, name,
> +				    &connector_item_type);
> +
> +	mutex_unlock(&dev->lock);
> +
> +	return &connector->group;
> +
> +err_free:
> +	kfree(connector);
> +err_unlock:
> +	mutex_unlock(&dev->lock);
> +	return ERR_PTR(ret);
> +}
> +
> +static struct configfs_group_operations connectors_group_operations = {
> +	.make_group	= &make_connector_group,
> +};
> +
> +static const struct config_item_type connector_group_type = {
> +	.ct_group_ops	= &connectors_group_operations,
> +	.ct_owner	= THIS_MODULE,
> +};
> +
>  static ssize_t device_enabled_show(struct config_item *item, char *page)
>  {
>  	struct vkms_configfs_device *dev;
> @@ -657,6 +753,10 @@ static struct config_group *make_device_group(struct config_group *group,
>  				    &encoder_group_type);
>  	configfs_add_default_group(&dev->encoders_group, &dev->group);
>  
> +	config_group_init_type_name(&dev->connectors_group, "connectors",
> +				    &connector_group_type);
> +	configfs_add_default_group(&dev->connectors_group, &dev->group);
> +
>  	return &dev->group;
>  }
>  
> -- 
> 2.48.1
> 


Return-Path: <linux-kernel+bounces-531146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5632A43CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E09916F69E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC1826868B;
	Tue, 25 Feb 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DPyX+sBV"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8749267B07
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481327; cv=none; b=UKUzX1Rp+v5mdlOYpt+SCS/X/GA6TQNBrvv7WeBTXTJL96k7vOwnNiC1ZOUg+CKejRzvSWeEhjzhn2WkMAiMbrxPUNVH6UiQx4X2DZ5MTqWKiMzJP0kYe9WN1sWWB9QOJ7CFruw9QWuMIBpK23WGWfMjFIx6YpRaLd1V+lh7VOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481327; c=relaxed/simple;
	bh=kcpHhbyX53068tcctz+TfzYDFCIVWJ43CTM3szHZDZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewKIFmojcN0cJm6TyYj9GuWSGvlqKJyxAmKNPXOxquZ+GLjOYC+IZF47jwvEehCaY1T1PsP7l/br91igJW6pYzReulzMd/FVxzJvHFE9hBmRX+e7+MFv8ghfU+Nj0NqUcww0V5j4R+wKY0Lb4LSbo/6T2KJX5VGOP7yQUozT+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DPyX+sBV; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72FA943421;
	Tue, 25 Feb 2025 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740481321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXt3c9CVQvc7CzFxOrTxOQEN6Im/PPW6FaJxrF+m1AE=;
	b=DPyX+sBVMp+g9487x4P+sLGs5jxe8ouxsisTngx5NWK/Kt51jZ4XPLhTvxnHcoBtAALIM9
	rMoeBRytLVoIKbcSQbo+kCFeyNZ1maG53PpOCImCJcFyXRi6cNWpn7wH4vKbDIW49axvrr
	GATKPcH+k0wsnn6Bu3T02CiyIdn7gdDLYI4sZBaXBNHUTXMXu2YxP750iGWkxQxhz6rA1M
	VDZFnI8Mmq1020pDOfWDtuxe5A86S7rTUYDJrgxbCTPG93mpnjgI9RxgQ+srY7/I9+RxdB
	wQb2r4rpOZPGcwwb7O/VNKcJMUwCBtiGgFUAyqwCbQDn2kjeSm70RPhxkdqpTg==
Date: Tue, 25 Feb 2025 12:01:59 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] drm/vkms: Allow to configure multiple planes via
 configfs
Message-ID: <Z72jJxrUyegPhesH@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
 <20250218170808.9507-4-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218170808.9507-4-jose.exposito89@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptedtkeeitdehvdeggfevvdevledvleevvdeggeeufeefgedtledujedtteeghfeinecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 18/02/25 - 18:07, José Expósito wrote:
> Create a default subgroup at /config/vkms/planes to allow to create as
> many planes as required.
> 
> Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  Documentation/gpu/vkms.rst           |  16 ++++-
>  drivers/gpu/drm/vkms/vkms_configfs.c | 101 +++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 423bdf86b5b1..bf23d0da33fe 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -71,6 +71,19 @@ By default, the instance is disabled::
>    cat /config/vkms/my-vkms/enabled
>    0
>  
> +And directories are created for each configurable item of the display pipeline::
> +
> +  tree /config/vkms/my-vkms
> +  ├── enabled
> +  └── planes
> +
> +To add items to the display pipeline, create one or more directories under the
> +available paths.
> +
> +Start by creating one or more planes::
> +
> +  sudo mkdir /config/vkms/my-vkms/planes/plane0
> +
>  Once you are done configuring the VKMS instance, enable it::
>  
>    echo "1" | sudo tee /config/vkms/my-vkms/enabled
> @@ -79,8 +92,9 @@ Finally, you can remove the VKMS instance disabling it::
>  
>    echo "0" | sudo tee /config/vkms/my-vkms/enabled
>  
> -And removing the top level directory::
> +And removing the top level directory and its subdirectories::
>  
> +  sudo rmdir /config/vkms/my-vkms/planes/*
>    sudo rmdir /config/vkms/my-vkms
>  
>  Testing With IGT
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 306f571559b7..dd9dfe51eb3a 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -15,6 +15,7 @@ static bool is_configfs_registered;
>   *
>   * @group: Top level configuration group that represents a VKMS device.
>   * Initialized when a new directory is created under "/config/vkms/"
> + * @planes_group: Default subgroup of @group at "/config/vkms/planes"
>   * @lock: Lock used to project concurrent access to the configuration attributes
>   * @config: Protected by @lock. Configuration of the VKMS device
>   * @enabled: Protected by @lock. The device is created or destroyed when this
> @@ -22,16 +23,112 @@ static bool is_configfs_registered;
>   */
>  struct vkms_configfs_device {
>  	struct config_group group;
> +	struct config_group planes_group;
>  
>  	struct mutex lock;
>  	struct vkms_config *config;
>  	bool enabled;
>  };
>  
> +/**
> + * struct vkms_configfs_plane - Configfs representation of a plane
> + *
> + * @group: Top level configuration group that represents a plane.
> + * Initialized when a new directory is created under "/config/vkms/planes"
> + * @dev: The vkms_configfs_device this plane belongs to
> + * @config: Configuration of the VKMS plane
> + */
> +struct vkms_configfs_plane {
> +	struct config_group group;
> +	struct vkms_configfs_device *dev;
> +	struct vkms_config_plane *config;
> +};
> +
>  #define device_item_to_vkms_configfs_device(item) \
>  	container_of(to_config_group((item)), struct vkms_configfs_device, \
>  		     group)
>  
> +#define child_group_to_vkms_configfs_device(group) \
> +	device_item_to_vkms_configfs_device((&(group)->cg_item)->ci_parent)
> +
> +#define plane_item_to_vkms_configfs_plane(item) \
> +	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
> +
> +static void plane_release(struct config_item *item)
> +{
> +	struct vkms_configfs_plane *plane;
> +	struct mutex *lock;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +	lock = &plane->dev->lock;
> +
> +	mutex_lock(lock);
> +	vkms_config_destroy_plane(plane->config);
> +	kfree(plane);
> +	mutex_unlock(lock);

scoped_guard here?

> +}
> +
> +static struct configfs_item_operations plane_item_operations = {
> +	.release	= &plane_release,
> +};
> +
> +static const struct config_item_type plane_item_type = {
> +	.ct_item_ops	= &plane_item_operations,
> +	.ct_owner	= THIS_MODULE,
> +};
> +
> +static struct config_group *make_plane_group(struct config_group *group,
> +					     const char *name)
> +{
> +	struct vkms_configfs_device *dev;
> +	struct vkms_configfs_plane *plane;
> +	int ret;
> +
> +	dev = child_group_to_vkms_configfs_device(group);
> +
> +	mutex_lock(&dev->lock);
> +
> +	if (dev->enabled) {
> +		ret = -EINVAL;

Why not -EPERM/-EBUSY?

> +		goto err_unlock;
> +	}
> +
> +	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
> +	if (!plane) {
> +		ret = -ENOMEM;
> +		goto err_unlock;
> +	}
> +
> +	plane->dev = dev;
> +
> +	plane->config = vkms_config_create_plane(dev->config);
> +	if (IS_ERR(plane->config)) {
> +		ret = PTR_ERR(plane->config);
> +		goto err_free;
> +	}
> +
> +	config_group_init_type_name(&plane->group, name, &plane_item_type);
> +
> +	mutex_unlock(&dev->lock);
> +
> +	return &plane->group;
> +
> +err_free:
> +	kfree(plane);
> +err_unlock:
> +	mutex_unlock(&dev->lock);
> +	return ERR_PTR(ret);
> +}

scoped_guard?

> +
> +static struct configfs_group_operations planes_group_operations = {
> +	.make_group	= &make_plane_group,
> +};
> +
> +static const struct config_item_type plane_group_type = {
> +	.ct_group_ops	= &planes_group_operations,
> +	.ct_owner	= THIS_MODULE,
> +};
> +
>  static ssize_t device_enabled_show(struct config_item *item, char *page)
>  {
>  	struct vkms_configfs_device *dev;
> @@ -137,6 +234,10 @@ static struct config_group *make_device_group(struct config_group *group,
>  	config_group_init_type_name(&dev->group, name, &device_item_type);
>  	mutex_init(&dev->lock);
>  
> +	config_group_init_type_name(&dev->planes_group, "planes",
> +				    &plane_group_type);
> +	configfs_add_default_group(&dev->planes_group, &dev->group);
> +
>  	return &dev->group;
>  }
>  
> -- 
> 2.48.1
> 


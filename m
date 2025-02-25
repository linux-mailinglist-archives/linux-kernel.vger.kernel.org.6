Return-Path: <linux-kernel+bounces-531150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B770EA43CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE73BD145
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F85267AE2;
	Tue, 25 Feb 2025 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TmmuBrrr"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAA267B64
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481328; cv=none; b=lyWDH5C2t0PWO9irtMKuk0NzNqaWI77vBWmTehRPaC/JdYFprXH/suv2kPooWrQSTmfh5fMH4iGILlCSJOQtnqWxwFQSFC0sk/MHVr7QK54TWsrqdeI5ArKHXFJ0NyT0gcMk2ErYq2IoxLs+Z80Wi6qLYds052Y9l03gzUoZyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481328; c=relaxed/simple;
	bh=WDWTQqlNvhxTQt+dT2ZA18pCh67p7cVyIfvOjAz9jdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY59aMjDveyW/fO7/3gAFNj3IwOxgoLTGiv4io1F4EF+vsqyeJTd74admjDHVTop/hZbxMQXHEaoXWbkhklD7RcBbJ1MFEFrg49DANwNZQ1YFO5XT5+nXqZxi9UC+/tB38BbCtoJm7HWZMRqxvYMEDCcAHLRFX0wBX0t2Ley7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TmmuBrrr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4BD644262;
	Tue, 25 Feb 2025 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740481324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwkQodifsbp8qelrNMHNybjUrJbyDx/nGqheQ6oI/BQ=;
	b=TmmuBrrrcX3s+o/vIhNPZ3E8Ht+Zam00aYQTLXF3J9gv/tmc75ETypISSuIXB3jEzUp9K6
	ZogfoywcDewuDWivSPa2JSexeMHNuuojIMpE+/Q7+Md5YcjNMIunOg8N2JUDXHlz/tFUvd
	GjCnmwGXQJaLiOk4p+b68LcvATDaN9r6+rOD7zDR1Nrx7iZJVqC+xeng5ilSq96RyBL7Eo
	c0bKGBe5z15SSrs3BzNprU5jW5XXv4TE/3xhthEqFZumVCShS2xIfmKhSeJdxqNTPJsuTu
	dKgDJUybbKekAwcRYpWg89v224D8yG7xMU/fovQptPS7q2usMeY+T6MI/5YGbQ==
Date: Tue, 25 Feb 2025 12:02:02 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] drm/vkms: Allow to configure multiple planes via
 configfs
Message-ID: <Z72jKjrVU56IxqQk@louis-chauvet-laptop>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptedtkeeitdehvdeggfevvdevledvleevvdeggeeufeefgedtledujedtteeghfeinecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 18/02/25 - 18:07, José Expósito wrote:
> Create a default subgroup at /config/vkms/planes to allow to create as
> many planes as required.
> 
> Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

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


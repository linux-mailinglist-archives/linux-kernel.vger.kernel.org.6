Return-Path: <linux-kernel+bounces-531144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF3A43CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1239E3BB135
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B602B267F53;
	Tue, 25 Feb 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ljfj3zRG"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71316267AF2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481326; cv=none; b=H6lSaRodwPQ+3idKAAGQcg0jdEEv/wnaycRlSDdi7I3Kji8e9mIrp6n/7GYsUCLSBQIkto8YS92uMevnJBjafQmoVwk5UL+O33gy1D5PGkQR8PN477+9B+ixl6F0sBoXsY226fxcKsq1q9Tcp2qzYUHxI90XfjE81xcftHSCFGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481326; c=relaxed/simple;
	bh=nBFCZJjxECIupyFi/O/0rsWdT9WxWKaVWYg9yXKWd1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT/rctM0PsxzrQeikMgjJgqy6jXX1XzzIIr3VoO6H72w8fppCviexWXfjeY76Rg/+Zbxgv/bUhp8AMrJE2LsmhZU5UDBXGQ8it8Nx07atJxHd87gOGAfUEXp+SmxjN3vsBzKkoAXW1g9X36wNFkPPbrXhnTGl+osJeUYg29Q0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ljfj3zRG; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0ABE344256;
	Tue, 25 Feb 2025 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740481322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ptnzb/jCkB02FB0wXvfB09UOXYPZgUu65Co83JJQ1w=;
	b=Ljfj3zRGap+adDEyBDqBXIkTN6BhXq6+kX1/SA+9RfjB6WNKGl2FPV0Hihfk1Hq0ZBx3et
	aK1jDYJdeavJNXFOMr9K1Qi76S57qKesjhHlWmwZ6OEO9RoMzTKMXVsg2EYGD3lE8YUfog
	OBqaN8CWgxKAru/WT1/cjdinlbSvCI7f1ergjmwLTwXqw8kOjpHJHTSm0f9xoIgVTonNja
	6a1UHWf3F1dorzq7Jq7d34X6JwimuwTTzbOD7WG+4fX0hd1h0beZ+fY1gGmJKPMxFNZPRa
	PIKkOlpWBs1yQRvA9d7glfIZLBr5PHjBaF9/JomfI0m+DQUf1y21PASxtGHjXg==
Date: Tue, 25 Feb 2025 12:02:00 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] drm/vkms: Allow to configure multiple encoders via
 configfs
Message-ID: <Z72jKKZEoB7BI_xa@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
 <20250218170808.9507-9-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218170808.9507-9-jose.exposito89@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptedtkeeitdehvdeggfevvdevledvleevvdeggeeufeefgedtledujedtteeghfeinecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 18/02/25 - 18:08, José Expósito wrote:
> Create a default subgroup at /config/vkms/encoders to allow to create as
> many encoders as required.
> 
> Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  Documentation/gpu/vkms.rst           |  6 ++
>  drivers/gpu/drm/vkms/vkms_configfs.c | 99 ++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 3c9d72bdb65a..24f40128e8f3 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -76,6 +76,7 @@ And directories are created for each configurable item of the display pipeline::
>    tree /config/vkms/my-vkms
>    ├── crtcs
>    ├── enabled
> +  ├── encoders
>    └── planes
>  
>  To add items to the display pipeline, create one or more directories under the
> @@ -97,6 +98,10 @@ CRTCs have 1 configurable attribute:
>  
>  - writeback: Enable or disable writeback connector support
>  
> +Next, create one or more encoders::
> +
> +  sudo mkdir /config/vkms/my-vkms/encoders/encoder0
> +
>  To finish the configuration, link the different pipeline items::
>  
>    sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
> @@ -118,6 +123,7 @@ And removing the top level directory and its subdirectories::
>    sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
>    sudo rmdir /config/vkms/my-vkms/planes/*
>    sudo rmdir /config/vkms/my-vkms/crtcs/*
> +  sudo rmdir /config/vkms/my-vkms/encoders/*
>    sudo rmdir /config/vkms/my-vkms
>  
>  Testing With IGT
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 7d5ebdd45d53..d7efa50a3fba 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -17,6 +17,7 @@ static bool is_configfs_registered;
>   * Initialized when a new directory is created under "/config/vkms/"
>   * @planes_group: Default subgroup of @group at "/config/vkms/planes"
>   * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
> + * @encoders_group: Default subgroup of @group at "/config/vkms/encoders"
>   * @lock: Lock used to project concurrent access to the configuration attributes
>   * @config: Protected by @lock. Configuration of the VKMS device
>   * @enabled: Protected by @lock. The device is created or destroyed when this
> @@ -26,6 +27,7 @@ struct vkms_configfs_device {
>  	struct config_group group;
>  	struct config_group planes_group;
>  	struct config_group crtcs_group;
> +	struct config_group encoders_group;
>  
>  	struct mutex lock;
>  	struct vkms_config *config;
> @@ -62,6 +64,20 @@ struct vkms_configfs_crtc {
>  	struct vkms_config_crtc *config;
>  };
>  
> +/**
> + * struct vkms_configfs_encoder - Configfs representation of a encoder
> + *
> + * @group: Top level configuration group that represents a encoder.
> + * Initialized when a new directory is created under "/config/vkms/encoders"
> + * @dev: The vkms_configfs_device this encoder belongs to
> + * @config: Configuration of the VKMS encoder
> + */
> +struct vkms_configfs_encoder {
> +	struct config_group group;
> +	struct vkms_configfs_device *dev;
> +	struct vkms_config_encoder *config;
> +};
> +
>  #define device_item_to_vkms_configfs_device(item) \
>  	container_of(to_config_group((item)), struct vkms_configfs_device, \
>  		     group)
> @@ -79,6 +95,10 @@ struct vkms_configfs_crtc {
>  #define crtc_item_to_vkms_configfs_crtc(item) \
>  	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
>  
> +#define encoder_item_to_vkms_configfs_encoder(item) \
> +	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
> +		     group)
> +
>  static ssize_t crtc_writeback_show(struct config_item *item, char *page)
>  {
>  	struct vkms_configfs_crtc *crtc;
> @@ -382,6 +402,81 @@ static const struct config_item_type plane_group_type = {
>  	.ct_owner	= THIS_MODULE,
>  };
>  
> +static void encoder_release(struct config_item *item)
> +{
> +	struct vkms_configfs_encoder *encoder;
> +	struct mutex *lock;
> +
> +	encoder = encoder_item_to_vkms_configfs_encoder(item);
> +	lock = &encoder->dev->lock;
> +
> +	mutex_lock(lock);
> +	vkms_config_destroy_encoder(encoder->dev->config, encoder->config);
> +	kfree(encoder);
> +	mutex_unlock(lock);
> +}
> +
> +static struct configfs_item_operations encoder_item_operations = {
> +	.release	= &encoder_release,
> +};
> +
> +static const struct config_item_type encoder_item_type = {
> +	.ct_item_ops	= &encoder_item_operations,
> +	.ct_owner	= THIS_MODULE,
> +};
> +
> +static struct config_group *make_encoder_group(struct config_group *group,
> +					       const char *name)
> +{
> +	struct vkms_configfs_device *dev;
> +	struct vkms_configfs_encoder *encoder;
> +	int ret;
> +
> +	dev = child_group_to_vkms_configfs_device(group);
> +
> +	mutex_lock(&dev->lock);
> +
> +	if (dev->enabled) {
> +		ret = -EINVAL;

-EPERM/-EBUSY?

> +		goto err_unlock;
> +	}
> +
> +	encoder = kzalloc(sizeof(*encoder), GFP_KERNEL);
> +	if (!encoder) {
> +		ret = -ENOMEM;
> +		goto err_unlock;
> +	}
> +
> +	encoder->dev = dev;
> +
> +	encoder->config = vkms_config_create_encoder(dev->config);
> +	if (IS_ERR(encoder->config)) {
> +		ret = PTR_ERR(encoder->config);
> +		goto err_free;
> +	}
> +
> +	config_group_init_type_name(&encoder->group, name, &encoder_item_type);
> +
> +	mutex_unlock(&dev->lock);
> +
> +	return &encoder->group;
> +
> +err_free:
> +	kfree(encoder);
> +err_unlock:
> +	mutex_unlock(&dev->lock);
> +	return ERR_PTR(ret);
> +}
> +
> +static struct configfs_group_operations encoders_group_operations = {
> +	.make_group	= &make_encoder_group,
> +};
> +
> +static const struct config_item_type encoder_group_type = {
> +	.ct_group_ops	= &encoders_group_operations,
> +	.ct_owner	= THIS_MODULE,
> +};
> +
>  static ssize_t device_enabled_show(struct config_item *item, char *page)
>  {
>  	struct vkms_configfs_device *dev;
> @@ -495,6 +590,10 @@ static struct config_group *make_device_group(struct config_group *group,
>  				    &crtc_group_type);
>  	configfs_add_default_group(&dev->crtcs_group, &dev->group);
>  
> +	config_group_init_type_name(&dev->encoders_group, "encoders",
> +				    &encoder_group_type);
> +	configfs_add_default_group(&dev->encoders_group, &dev->group);
> +
>  	return &dev->group;
>  }
>  
> -- 
> 2.48.1
> 


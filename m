Return-Path: <linux-kernel+bounces-531145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8F2A43CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECCD3BB9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B8267B71;
	Tue, 25 Feb 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jgD6pvzD"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A50267AF7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481327; cv=none; b=G06QZygceWZ6+/Ze/3byge3j77NLj4Q2sE3tcmGpG4cDBLk1n3495Ya2XlA3a3kVWys/HicAPMoUzQugp0MDx3l5HuDhKsILq4NSjjH7bihxzdcWWj4WENV6Z7iZ1DR7um+5e3HXfLTirTqfmpTCEUMe4IUGgEezEU0LzduKDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481327; c=relaxed/simple;
	bh=4876vr2utHfIBHTY5q1rxAXaNsbHb5mXxBTiY7eF0Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkXQH8PYqE8N/ycULExTRFG1hlQYxeEmhBgFUVSh3aVkyM7pO29xcKTWdUWN3o7+JP5tQmWZznq5QrYLeA5ghvnqTVldbxJT3HY3oO8z110zLDznh0xzxQrY2Mr75208nV/41qO4Dq+BqvhCytuGlvEjoFkEfP2yIDFbKjecJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jgD6pvzD; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F86A4429D;
	Tue, 25 Feb 2025 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740481323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5TI9s/8JITyCqntz+W74RFEmqgjquDUzIpco5EoxFs=;
	b=jgD6pvzDiOOuRwmedCPoMhwDWvhp/fTY8m/Sq+9fItwjiiUVXpaggznJixyZR0KK+13yGE
	k7S9SOQHOSUkrYbvLx/2p7Ln7rLbqdQZYiIhZ6GyvpeT7F9n27e6ikTDS+inApLGlEy9H9
	JZXV2LU4aj+T4wb+Bfyq8yoYM85s3WaFyh2Qw8/vabFzbAcWaVejDHMj7gpSoxP3euees4
	CQTNVoGesMFs+VPpEOO3Ph9v9i1ssYsGK667/juNxucmdjbaZww8RESwg5+V26LhtFfxF2
	UI6s1Z24uzKlrvGrIoRZa+wyc27NJs1uOK+HvI1KTvg2Cyh3L9kGhb85CjwWmw==
Date: Tue, 25 Feb 2025 12:02:01 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/16] drm/vkms: Allow to configure CRTC writeback
 support via configfs
Message-ID: <Z72jKZ4SDJYmcFf2@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
 <20250218170808.9507-7-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218170808.9507-7-jose.exposito89@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfejveetkedvleetudeuudegfeejheeujeefkefgtdeugfetfeeutdevieekvdeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 18/02/25 - 18:07, José Expósito wrote:
> When a CRTC is created, add a `writeback` file to allow to enable or
> disable writeback connector support
> 
> Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  Documentation/gpu/vkms.rst           |  4 +++
>  drivers/gpu/drm/vkms/vkms_configfs.c | 47 ++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index da5157adfd79..4e87d8a81844 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -93,6 +93,10 @@ Continue by creating one or more CRTCs::
>  
>    sudo mkdir /config/vkms/my-vkms/crtcs/crtc0
>  
> +CRTCs have 1 configurable attribute:
> +
> +- writeback: Enable or disable writeback connector support

Can we add: "by writing 1 or 0"?

> +
>  Once you are done configuring the VKMS instance, enable it::
>  
>    echo "1" | sudo tee /config/vkms/my-vkms/enabled
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 52205a8a9cb4..88037a57a138 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -73,6 +73,52 @@ struct vkms_configfs_crtc {
>  #define crtc_item_to_vkms_configfs_crtc(item) \
>  	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
>  
> +static ssize_t crtc_writeback_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_crtc *crtc;
> +	bool writeback;
> +
> +	crtc = crtc_item_to_vkms_configfs_crtc(item);
> +
> +	mutex_lock(&crtc->dev->lock);
> +	writeback = vkms_config_crtc_get_writeback(crtc->config);
> +	mutex_unlock(&crtc->dev->lock);
> +
> +	return sprintf(page, "%d\n", writeback);
> +}
> +
> +static ssize_t crtc_writeback_store(struct config_item *item, const char *page,
> +				    size_t count)
> +{
> +	struct vkms_configfs_crtc *crtc;
> +	bool writeback;
> +
> +	crtc = crtc_item_to_vkms_configfs_crtc(item);
> +
> +	if (kstrtobool(page, &writeback))
> +		return -EINVAL;
> +
> +	mutex_lock(&crtc->dev->lock);
> +
> +	if (crtc->dev->enabled) {
> +		mutex_unlock(&crtc->dev->lock);
> +		return -EPERM;
> +	}
> +
> +	vkms_config_crtc_set_writeback(crtc->config, writeback);
> +
> +	mutex_unlock(&crtc->dev->lock);
> +
> +	return (ssize_t)count;
> +}
> +
> +CONFIGFS_ATTR(crtc_, writeback);
> +
> +static struct configfs_attribute *crtc_item_attrs[] = {
> +	&crtc_attr_writeback,
> +	NULL,
> +};
> +
>  static void crtc_release(struct config_item *item)
>  {
>  	struct vkms_configfs_crtc *crtc;
> @@ -92,6 +138,7 @@ static struct configfs_item_operations crtc_item_operations = {
>  };
>  
>  static const struct config_item_type crtc_item_type = {
> +	.ct_attrs	= crtc_item_attrs,
>  	.ct_item_ops	= &crtc_item_operations,
>  	.ct_owner	= THIS_MODULE,
>  };
> -- 
> 2.48.1
> 


Return-Path: <linux-kernel+bounces-513075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF2EA34164
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7750189205F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566B326EFE3;
	Thu, 13 Feb 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rl5N0Y21"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03622659EC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455197; cv=none; b=kJd+8erbIOfClfQLNr+aC5DKPxYE8RHLStZKcleW9lR4Y+RWexheydlhcJBz7tPhkzHNwJc/AvZwhBUzrKjD7KricuS08MujTACr/53XDZ9/w0K7P/081b5QfSdyP5cyHxr3EfSAeUfzpaK2wRhZ/TSGS9PLhFJQqtfk7z8ymWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455197; c=relaxed/simple;
	bh=CRl0rZ7s/TS5AjNh9r5QkXXi6raSeuZ3wzEKL15AXHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZGO5jm/XSHdGyakTOlBessK+M51f++iRJ+I/SfCZ6y/6mWCy8oPVMTTqMBxpfDUpafhrX6kJu2Xz8djiwN7R86PhR2F1Moopb81d7rN9XA5b3XflSYiaosh1ZQuDve5z/6HSfDb7kU//FpibBnZa7KvOfcnzuBR4UabD3Vpoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rl5N0Y21; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FDD8440EA;
	Thu, 13 Feb 2025 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739455194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlVVb4sEEANNWg8Lt7M92FFId1p0cgOCp4tdomNyQ5U=;
	b=Rl5N0Y211P3/RPmgtEoaGvpi7HixpV2hHemFOfjcqHiH27QYWgOiHz3gbosqIdYAEtQGWu
	2boZTLIxhciPKiczeC4SnDJgzq9M+VBaLN8RzYxLl7GxYbIwpsQrrvv+X2j9DEJhleNI/f
	rcgz2ul1wlVbx5PTq60xUqAQtq6nO+IM3caiFpez/84mPp9ONUFK3AJ2vgi8i5R4/ioDVe
	J+yDD++zJ2Fn2+bIcvCt181HN/oMlYcr+zjmFFzdRj3D/ZY4uEncwYTikYiPAqBil1CiD3
	m6VyxPZxsoi/RXu96h4FPIj0FG91ezlC3dsC/Hn04NJYf6bJuVZMENaRzqoK+Q==
Date: Thu, 13 Feb 2025 14:59:52 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] drm/vkms: Add a validation function for VKMS
 configuration
Message-ID: <Z6362KrzjLUL6Mj6@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250211110912.15409-1-jose.exposito89@gmail.com>
 <20250211110912.15409-9-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211110912.15409-9-jose.exposito89@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfejveetkedvleetudeuudegfeejheeujeefkefgtdeugfetfeeutdevieekvdeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 11/02/25 - 12:09, José Expósito wrote:
> From: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> As the configuration will be used by userspace, add a validator to avoid
> creating a broken DRM device.
> 
> For the moment, the function always returns true, but rules will be
> added in future patches.
> 
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Co-developed-by: José Expósito <jose.exposito89@gmail.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

The compilation is broken when building as module:


diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index b9267aef4804..82335006c94a 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -55,6 +55,7 @@ bool vkms_config_is_valid(struct vkms_config *config)
 {
        return true;
 }
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);

 static int vkms_config_show(struct seq_file *m, void *data)
 {


> ---
>  drivers/gpu/drm/vkms/tests/vkms_config_test.c |  2 ++
>  drivers/gpu/drm/vkms/vkms_config.c            |  5 +++++
>  drivers/gpu/drm/vkms/vkms_config.h            | 10 ++++++++++
>  drivers/gpu/drm/vkms/vkms_drv.h               |  2 +-
>  drivers/gpu/drm/vkms/vkms_output.c            |  3 +++
>  5 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> index 92798590051b..6e07139d261c 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> @@ -54,6 +54,8 @@ static void vkms_config_test_default_config(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, config->writeback, params->enable_writeback);
>  	KUNIT_EXPECT_EQ(test, config->overlay, params->enable_overlay);
>  
> +	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
> +
>  	vkms_config_destroy(config);
>  }
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 11b0e539920b..67f71d29596e 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -47,6 +47,11 @@ void vkms_config_destroy(struct vkms_config *config)
>  	kfree(config);
>  }
>  
> +bool vkms_config_is_valid(struct vkms_config *config)
> +{
> +	return true;
> +}
> +
>  static int vkms_config_show(struct seq_file *m, void *data)
>  {
>  	struct drm_debugfs_entry *entry = m->private;
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index fcaa909fb2e0..0376dceaf6be 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -67,6 +67,16 @@ vkms_config_get_device_name(struct vkms_config *config)
>  	return config->dev_name;
>  }
>  
> +/**
> + * vkms_config_is_valid() - Validate a configuration
> + * @config: Configuration to validate
> + *
> + * Returns:
> + * Whether the configuration is valid or not.
> + * For example, a configuration without primary planes is not valid.
> + */
> +bool vkms_config_is_valid(struct vkms_config *config);
> +

I think here we can take a const pointer.

>  /**
>   * vkms_config_register_debugfs() - Register a debugfs file to show the device's
>   * configuration
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index a74a7fc3a056..95afc39ce985 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -204,7 +204,7 @@ struct vkms_config;
>  struct vkms_device {
>  	struct drm_device drm;
>  	struct platform_device *platform;
> -	const struct vkms_config *config;
> +	struct vkms_config *config;

So we can keep a const pointer here (for me the device should never modify 
vkms_config)

>  };
>  
>  /*
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 068a7f87ecec..414cc933af41 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -16,6 +16,9 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  	int writeback;
>  	unsigned int n;
>  
> +	if (!vkms_config_is_valid(vkmsdev->config))
> +		return -EINVAL;
> +
>  	/*
>  	 * Initialize used plane. One primary plane is required to perform the composition.
>  	 *
> -- 
> 2.48.1
> 


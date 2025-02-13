Return-Path: <linux-kernel+bounces-513246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C63CA34621
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BBB188700D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B115826B0A5;
	Thu, 13 Feb 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nc+IkY7J"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945AF26B0A4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459493; cv=none; b=BsUK6uu5thwOxxkvtamvft/NeKTO236LZDt+Z4qfYI0q8399lb5EZ4+ww7aSu44q6/YAQS3CFDA4RbvLIbYXi8m5BZE0a2cZiIh/oa/wbIkmzqx9kzOg4FoX/be8GZnoLkUQmPwg1/yBRVY23a1mKn3tOdzDytw0yrnYa/KICbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459493; c=relaxed/simple;
	bh=AqBXwOJ6su5+R7DDKCHpSiNuK3rLjgWsLNY1DADcE0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9sAhyuTfRUKcddUjmQx7V3HeMaJZoPoSwVB+Rix7rni1e08+vEMCiNUBBJ8MKce4ZBmCy/TvRaqe+LCxbTeoyzaerPNoJIJ/J1bJTSU/Yl/m4r0dR+eluT+20pTvLI/twtIrIdpNvd9GMdhQIuKh3tzXf2r3rD1jq5qm4cbrvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nc+IkY7J; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17F70433EE;
	Thu, 13 Feb 2025 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739459482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRayKgFGXudSJ4OIucggX+voUO5jdIQTzRqQFBjhKeQ=;
	b=Nc+IkY7JJAAn/QX3kDv2jbdVXWqUg+uFI/KYylyqQNd82hMeTKckqYUNSKmcaHEhjnfeTY
	T7H8RVJwB8J40ghp0TE8bR5ytvCzr+TnmdegOhJb/Py/B+gG9Wg1rzFxxuyGSwQlbKfhqz
	DVSzfRdDCvuCdG/gGfiFOFGJkSt98sPzC51/bEAxjUBkkINpLyGg0+4wlmki4Rkbaq2K9A
	xh5HEKi/fyVhQhk/SBjdMqJiN/hyqe1ptD5A0gUNAaUhWnVbz2jfGZbGW3Qk27Kr4CxDTE
	LNx9qlPkr8Z6djELZetqBy+bff+3rXN4KZd0kFJjGFnscoFFWB35t9+wALrYUQ==
Date: Thu, 13 Feb 2025 16:11:20 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, sylphrenadin@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Fix use after free and double free on init
 error
Message-ID: <Z64LmAJlf-B6wQkL@louis-chauvet-laptop>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, sylphrenadin@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250212084912.3196-1-jose.exposito89@gmail.com>
 <bfc71d72-2f23-4c8c-b278-7e9aad3bf72d@suse.de>
 <3af06a6e-adb9-4e72-ab4d-23dbf37258b4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3af06a6e-adb9-4e72-ab4d-23dbf37258b4@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjedutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdetfeekgeevleeuheekudekffevkeetkeekjeekuddvhfdvudejjedtteeifedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpfhhrvggvuggvshhkthhophdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhouhhishdqtghhrghuvhgvthdqlhgrphhtohhppdhmrghilhhfrhhomheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdpr
 hgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomh
X-GND-Sasl: louis.chauvet@bootlin.com

On 12/02/25 - 15:06, Louis Chauvet wrote:
> 
> 
> Le 12/02/2025 à 09:53, Thomas Zimmermann a écrit :
> > 
> > 
> > Am 12.02.25 um 09:49 schrieb José Expósito:
> > > If the driver initialization fails, the vkms_exit() function might
> > > access an uninitialized or freed default_config pointer and it might
> > > double free it.
> > > 
> > > Fix both possible errors by initializing default_config only when the
> > > driver initialization succeeded.
> > > 
> > > Reported-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > Link: https://lore.kernel.org/all/Z5uDHcCmAwiTsGte@louis-chauvet-laptop/
> > > Fixes: 2df7af93fdad ("drm/vkms: Add vkms_config type")
> > > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > 
> > Reviewed-by: Thomas Zimmermann <tzimmremann@suse.de>
> 
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> lore.kernel.org is broken currently, to avoid doing mistakes, I will wait
> for it to be working again so I can apply your patch using dim+b4.
> 
> (I removed danvet.vetter@ffwl.ch from CC, the mail server rejected the mail)
> 
> Thanks!
> Louis Chauvet

Hello,

I tried to apply the commit, but I have a strange issue:

	$ dim push
	Enumerating objects: 13, done.
	Counting objects: 100% (13/13), done.
	Delta compression using up to 20 threads
	Compressing objects: 100% (7/7), done.
	Writing objects: 100% (7/7), 1.67 KiB | 113.00 KiB/s, done.
	Total 7 (delta 6), reused 0 (delta 0), pack-reused 0 (from 0)
	remote:
	remote: ========================================================================
	remote:
	remote:    Equinix is shutting down its operations with us on April 30, 2025.
	remote:    They have graciously supported us for almost 5 years, but all good
	remote:    things come to an end. Given the time frame, it's going to be hard
	remote:       to make a smooth transition of the cluster to somewhere else
	remote: ([TBD](https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/2011)).
	remote:     Please expect in the next months some hiccups in the service and
	remote:    probably at least a full week of downtime to transfer gitlab to a
	remote:                different place. All help is appreciated.
	remote:
	remote: ========================================================================
	remote:
	To gitlab.freedesktop.org:drm/misc/kernel.git
	   ff3881cc6a58..ed15511a773d  drm-misc-next -> drm-misc-next
	Pushing drm-misc-fixes to for-linux-next-fixes... Everything up-to-date
	Done.
	Out of merge window. Pushing drm-misc-next to for-linux-next... 
	remote:
	remote: ========================================================================
	remote:
	remote: ERROR: Internal API unreachable
	
	remote:
	remote: ========================================================================
	remote:
	fatal: Could not read from remote repository.
	
	Please make sure you have the correct access rights
	and the repository exists.

Is this expected?

Thanks,
Louis Chauvet

> > Thanks for posting this patch separately.
> > 
> > Best regards
> > Thomas
> > 
> > > ---
> > >    drivers/gpu/drm/vkms/vkms_drv.c | 15 +++++++++------
> > >    1 file changed, 9 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > > index 7c142bfc3bd9..b6de91134a22 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > @@ -235,17 +235,19 @@ static int __init vkms_init(void)
> > >    	if (!config)
> > >    		return -ENOMEM;
> > > -	default_config = config;
> > > -
> > >    	config->cursor = enable_cursor;
> > >    	config->writeback = enable_writeback;
> > >    	config->overlay = enable_overlay;
> > >    	ret = vkms_create(config);
> > > -	if (ret)
> > > +	if (ret) {
> > >    		kfree(config);
> > > +		return ret;
> > > +	}
> > > -	return ret;
> > > +	default_config = config;
> > > +
> > > +	return 0;
> > >    }
> > >    static void vkms_destroy(struct vkms_config *config)
> > > @@ -269,9 +271,10 @@ static void vkms_destroy(struct vkms_config *config)
> > >    static void __exit vkms_exit(void)
> > >    {
> > > -	if (default_config->dev)
> > > -		vkms_destroy(default_config);
> > > +	if (!default_config)
> > > +		return;
> > > +	vkms_destroy(default_config);
> > >    	kfree(default_config);
> > >    }
> > 
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


Return-Path: <linux-kernel+bounces-550978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF2A56698
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B2C177E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A462321ADCB;
	Fri,  7 Mar 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kaY9Rr8s"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781621ABD2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346546; cv=none; b=gOh2CNu3WSjYhm5pZCDfmdht5kC5EtzFNbsxj4YUNY4i2qQa9grZv56hYLQGQUMt7HEF3Bw9aGJpHtjMAbKUOb0VWQDzvuS0M/ci0/dDBpUZCxQIZrsRIs8/5UNCy3o2lT994nvA2xmQiF/KOUODezujIFn3YXFRC+w0BkglWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346546; c=relaxed/simple;
	bh=07Y53SvaN4HyareOuoHQiwP6ciMkkFkpWBEWCYPiweY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwVoXNW+VrIa6fNgFGvHSOxXjGOeJq+9TdORE2vprgTf+eLulSTbJUb1MTpyX3fIGUMnHz68DkE79X6WdXJDgxPrl2YFPTkd0sWL0IOfuve2v7HR9cwvyfWeTK0HGWBBOgqU1xqWPDBzUiLNvowdSjqTopzrhbc6yAaXLJqM4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kaY9Rr8s; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4A29432BF;
	Fri,  7 Mar 2025 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741346536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcuD7NlNDZd+xhVem/Y+o+z4MWg9gjtRsouOtv13Y6A=;
	b=kaY9Rr8s/iRCbvx0GX0icDjID8GQ0lANAxP8yEtn+4eQQIvzjVU+NSkHQOFUFzuzJOtfTL
	GAmi3h7PM7njnuuWRVxOpB7KVzL6ytdr1lVgbNkFB+HV9MKENMy7bO33KObvVOq97MXB3Y
	iDKjjRbqR4Zh2LBH/iNV8WdrViBm3wc9kOlXUVGQ2vn90LRQe3EwhqUs7/RJxQwMvWofon
	MLNahYoNEwETYmW8y4lpsAjsJz/1X0aoK8me0BW5Mzdl9kYHFF3YIUZADuuyYdDcvKIBci
	Wt6L0z0Ke9qm18BVKX7Ohjf/4YoajG/JoJBfD7qiU/zsO2WI+FGhainZs7xh3Q==
Date: Fri, 7 Mar 2025 12:22:12 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: fsl-ldb: make warning message more
 informative
Message-ID: <20250307122212.18252ca6@booty>
In-Reply-To: <f8df2b5e-b005-4ada-8108-159b2b94a72e@nxp.com>
References: <20250306-drm-two-ldb-improvements-v1-0-f139d768b92c@bootlin.com>
	<20250306-drm-two-ldb-improvements-v1-2-f139d768b92c@bootlin.com>
	<f8df2b5e-b005-4ada-8108-159b2b94a72e@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfeeltdeljeeftdetgeeuuedvheffffekleehkeevhfdttefgleeutdfhkeehkeeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopehvihgtthhorhdrlhhiuhesnhigphdrtghomhdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhms
 hhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Liu,

thanks for your reviews.

On Fri, 7 Mar 2025 14:33:37 +0800
Liu Ying <victor.liu@nxp.com> wrote:

> On 03/07/2025, Luca Ceresoli wrote:
> > This warning notifies a clock was set to an inaccurate value. Modify the
> > string to also show the clock name.
> > 
> > While doing that also rewrap the entire function call.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  drivers/gpu/drm/bridge/fsl-ldb.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> > index 0fc8a14fd80062248a43b8b93272101a7ca6158a..c7c899a9644bb827845fb3fe96a9695d79a91474 100644
> > --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> > +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> > @@ -181,9 +181,9 @@ static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
> >  
> >  	configured_link_freq = clk_get_rate(fsl_ldb->clk);
> >  	if (configured_link_freq != requested_link_freq)
> > -		dev_warn(fsl_ldb->dev, "Configured LDB clock (%lu Hz) does not match requested LVDS clock: %lu Hz\n",
> > -			 configured_link_freq,
> > -			 requested_link_freq);
> > +		dev_warn(fsl_ldb->dev,
> > +			 "Configured %pC clock (%lu Hz) does not match requested LVDS clock: %lu Hz\n",
> > +			 fsl_ldb->clk, configured_link_freq, requested_link_freq);  
> 
> Though this slightly changes the warning message userspace sees, I guess it is
> acceptable.
> 
> Does it make sense to s/%pC/%pCn/ so that the clock name is printed in lower
> case instead of upper case, since it seems that all i.MX specific clock names
> are in lower case?

%pC and %pCn print the same string, as I just discovered at
https://elixir.bootlin.com/linux/v6.14-rc5/source/lib/vsprintf.c#L1972

I've pondering for a moment about whether we should document %pC and
%pCn produce the same output or rather %pCn. I decided to try the
latter and just sent a patch to do it [0].

FYI in my case the printed value is (with both %pC and %pCn)
"32ec0000.blk-ctrl:bridge@5c".

[0] https://lore.kernel.org/20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-kernel+bounces-529457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06BA4268B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555EE3A83B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F65254858;
	Mon, 24 Feb 2025 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JE3OS9YN"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174723BCF5;
	Mon, 24 Feb 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411197; cv=none; b=CfRJRVs1/7Ayp2k5aW4BYEPreNwDbE6YqJqMVVVLm6HQeOOaFCa4gGDKjvaPn2lUv3a+UaOilMo+ehpSZyznZVHVuIcX5PirVT7MdB4SkCGrmmy55pG43H8dUuARl8Q4cIhhvb6nuHqUp+J79l+CQP26kfeyUWA9mmpkfaqJsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411197; c=relaxed/simple;
	bh=O2tJz2i0vD7hotp7+UD3YrNL14k8fLmcgvxxr3HFIFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLYeyd5PaZ12p+sUwDsiM01ZaELOELSLh7SMVsNTuBNeQ/SbWZzMBjfkIxebodETlJsy5Z+gPt19zitRdQgO9V3If8F+oad2UsO8neNI3Dgb+F/KvmOV/2V6PWzzLx8H/mscwZOXlDzBlSwjENm5srbsfI5dR/TUvHwUWBuaH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JE3OS9YN; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EB7D4430D;
	Mon, 24 Feb 2025 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740411193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nBcEB5ZqYv4lPSZ2d5hbWxLCG+9RTl08TMuDme7c2c=;
	b=JE3OS9YN7ghRFygCXouzH5Hykp/g+2H8PEbNXBASW39se3lPZvGwelkhojmFETkz2DK5Ak
	HMiwkmNZukMo8/YPFbm6t7qiCXZCZin5ZoaKjhR4AHkwfvKjMJFKdpA9R7Vo6sCddHRYGa
	KHjgeo93uRoZBJw9PXzFyOnHWKUNeCNeso0T8ITE7I8tWuU+Bz6IhKsbMGJUB9TUm4kWX/
	TG3J7R1z7KX+PtytluXEOMd6kmM0ZByl+pTVjidIc1jHXlh2iCkbc0QwIfRT8iy030AyVA
	xIZt0bWA2qSV7cbkXZ3zsAmj3P2O+XZH5LgRgdMNMWomuR4kH6V0rah5hHwXQQ==
Date: Mon, 24 Feb 2025 16:33:11 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm-graph: set fill colour of turned on nodes
Message-ID: <20250224163311.0611da3f@booty>
In-Reply-To: <20250221-dapm-graph-node-colour-v1-1-514ed0aa7069@collabora.com>
References: <20250221-dapm-graph-node-colour-v1-1-514ed0aa7069@collabora.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepnhhitgholhgrshdrfhhrrghtthgrrhholhhisegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqshhouhhnu
 gesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Nicolas,

+Cc: Mark Brown

On Fri, 21 Feb 2025 21:39:32 +0100
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> Some tools like KGraphViewer interpret the "ON" nodes not having an
> explicitly set fill colour as them being entirely black, which obscures
> the text on them and looks funny. In fact, I thought they were off for
> the longest time. Comparing to the output of the `dot` tool, I assume
> they are supposed to be white.
> 
> Instead of speclawyering over who's in the wrong and must immediately
> atone for their wickedness at the altar of RFC2119, just be explicit
> about it, set the fillcolor to white, and nobody gets confused.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> This is somewhat "just thrown out there"; I noticed that not setting the
> fill colour breaks KGraphViewer only *after* I thought this was just how
> they were for several days. With this change, both dot and KGraphViewer
> render it correctly, but I have no clue as to whether it's in the spirit
> of the file format at all. I figure that if this saves some other poor
> souls a bit of time and confusion, then it's worth it.

I confirm the issue with a plain installation of KGraphViewer (which I
didn't know at all before -- interesting tool).

So, let's have mercy on the poor souls:

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


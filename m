Return-Path: <linux-kernel+bounces-295236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339719598E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4968281D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8171AD5ED;
	Wed, 21 Aug 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QOQfuhlk"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB11AD5C6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232885; cv=none; b=YV16BSesKJJatsp8R7GUYX+sw4vIhhyrNXgffHk6Wu7l9XOS4URSCPoBS0mYLUzKJhGiFtCqF7dzFNdfnxPZySDv9lFhmPT/KIf415+umEp1CdhAgua5PU8usnoPryaQBerai52ypPnEYcIO7Izzmze93v3P6Ho0SjQOGMtRp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232885; c=relaxed/simple;
	bh=ShfB4E3ycp78jo/Z/BWluYVt/+uqMRayhUI2+wzfmUk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Cmkt3MgtxeNHhgukpjWV1y1+FAyPWwWkgeK4EGuftkkecNdm4KvaMp9C+ubZqkuBKwHo6doJ2Y8rlGadIqhtcyMK8lRuCcEcSe87/lOHjhZb7/oiyXwHLrEu2pQCtudBWp3CE9HlybPn5/TTv6VSqqH2+dPiApi4zsEOHLT25FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QOQfuhlk; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724232881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8e/e9QlFlV6uwCMmOmikTDXDk3xFAB5P6WHKtcf88s=;
	b=QOQfuhlkcimw9aAAxs1j94XFG7lGoAQDN7M5OECnYc3o68jxbxWmG8dOJFTncx6XHc1Ima
	r+6ob2LaILkY8fSymKEnNvM5jYRqEH41fE5xc9SWOx+465Fzt2rWMRmBTdrxdAHzfgN5NR
	dDLUHnpJSt9A2/HRjjs8O7rjt22TlQiZlltPAxjsc1WIh6GMCuXPBDRh+e1z7PGqK6+Ojd
	HM9FGGgyaArc+BQBHd3lF2tjdjGabBzVcemZMH+PDpxW40fzGdDOQ0jC9PK8EjlFsofMbd
	f17kDDn7AV+CZBGXmzH/Y98wgHteg3pPvSbcDX4xJLq5SWlJMfEVbJnvjZwzhg==
Date: Wed, 21 Aug 2024 11:34:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] phy: phy-rockchip-inno-usb2: Improve error
 handling while probing
In-Reply-To: <6073817.31tnzDBltd@diego>
References: <cover.1724225528.git.dsimic@manjaro.org>
 <12869965.VsHLxoZxqI@diego> <486bddb6aad14d05a3fb2d876d0d9d0d@manjaro.org>
 <6073817.31tnzDBltd@diego>
Message-ID: <8bb17c887eb9122d90e0887068b32da2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-21 11:17, Heiko Stübner wrote:
> Am Mittwoch, 21. August 2024, 11:09:03 CEST schrieb Dragan Simic:
>> On 2024-08-21 10:44, Heiko Stübner wrote:
>> > Am Mittwoch, 21. August 2024, 09:37:55 CEST schrieb Dragan Simic:
>> >> Improve error handling in the probe path by using function
>> >> dev_err_probe()
>> >> where appropriate, and by no longer using it rather pointlessly in one
>> >> place
>> >> that actually produces a single, hardcoded error code.
>> >>
>> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> >
>> >> @@ -1375,8 +1372,10 @@ static int rockchip_usb2phy_probe(struct
>> >> platform_device *pdev)
>> >>  	rphy->irq = platform_get_irq_optional(pdev, 0);
>> >>  	platform_set_drvdata(pdev, rphy);
>> >>
>> >> -	if (!phy_cfgs)
>> >> -		return dev_err_probe(dev, -EINVAL, "phy configs are not
>> >> assigned!\n");
>> >> +	if (!phy_cfgs) {
>> >> +		dev_err(dev, "phy configs are not assigned\n");
>> >> +		return -EINVAL;
>> >> +	}
>> >>
>> >>  	ret = rockchip_usb2phy_extcon_register(rphy);
>> >>  	if (ret)
>> >
>> > I really don't understand the rationale here. Using dev_err_probe here
>> > is just fine and with that change you just introduce more lines of code
>> > for exactly the same functionality?
>> 
>> As we know, dev_err_probe() decides how to log the received error
>> message
>> based on the error code it receives, but in this case the error code 
>> is
>> hardcoded as -EINVAL.  Thus, in this case it isn't about keeping the 
>> LoC
>> count a bit lower, but about using dev_err() where the resulting 
>> outcome
>> of error logging is aleady known, and where logging the error code
>> actually
>> isn't helpful, because it's hardcoded and the logged error message
>> already
>> tells everything about the error condition.
>> 
>> In other words, it's about being as precise as possible when deciding
>> between
>> dev_err() and dev_err_probe(), in both directions.  I hope it makes
>> sense.
> 
> I'd disagree a bit, using one format only creates a way nicer pattern 
> in the
> driver, by not mixing different styles.
> 
> dev_err_probe documentation seems to agree [0], by stating:
> 
> "Using this helper in your probe function is totally fine even if @err 
> is
>  known to never be -EPROBE_DEFER.
>  The benefit compared to a normal dev_err() is the standardized format
>  of the error code, it being emitted symbolically (i.e. you get 
> "EAGAIN"
>  instead of "-35") and the fact that the error code is returned which 
> allows
>  more compact error paths."

Yes, I saw that already in the documentation.  Though, it might be 
debatable
does hardcoding the passed error code to some value qualifies as knowing 
that
it can't be -EPROBE_DEFER.  The way I read that part of the 
documentation is
that using dev_err_probe() is fine without going into the implementation 
of
the previously invoked function that may fail, and researching can it 
actually
return -EPROBE_DEFER or not.  Also, the invoked function may change at 
some
point in future and start returning -EPROBE_DEFER, but a hardcoded error 
code
that's produced locally can't become changed that way.

In addition to that, we already have at least a couple of instances 
[1][2] in
the same function in which dev_err() is used when the error code is 
hardcoded,
so there's actually already another pattern to follow.

I know that replacing dev_err_probe() with dev_err() may look strange in 
a
patch that mostly performs the opposite replacement, but the patch just 
tries
to be strict and precise, and to follow other examples of how dev_err() 
is
already used in the same function when the error code is produced 
locally
instead of being received from another invoked function.

> [0] 
> https://elixir.bootlin.com/linux/v6.10.6/source/drivers/base/core.c#L5009
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/rockchip/phy-rockchip-inno-usb2.c?h=v6.11-rc4#n1361
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/rockchip/phy-rockchip-inno-usb2.c?h=v6.11-rc4#n1369


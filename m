Return-Path: <linux-kernel+bounces-325516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244D8975AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987721F23959
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1171B5ECC;
	Wed, 11 Sep 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="hU3LP7mz"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156218C344
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081404; cv=none; b=MlOjtl4Se36zpa75H3Zw7iZ73SlpwcsdUqeQcOvgtCoXkAy/C77mV1eBJz9WouY8xf0HyWA3JxV3u70CgkUEHVWbEaIPwdnlVB20oXQh7HnRpG/V8PD7iqVQnt8+1bEv/rTDA1t6BwDdX/Qm0cbqI70/F9qPUdM1mO3V1DFKzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081404; c=relaxed/simple;
	bh=TjCpf1buwZs3QvGyhB9mnoM9hwMCKnNvjYn2aPQJR9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQl5Wdb7ZBxAwk4QY8NLrzkBP2D7+bKsscrohGUuuI+5CUrCU7ARfPXCzQ+BkBeQTniC/aAdklQ1AiMsMAud8ffVAXJ9pClkWSCKH+3NpR7D3Pryp3jT37CHqpcCz5Pe9xHJkg7uQc3zZ3Qzp6zS6C1OQyKge3Kx+JaT1RYdwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=hU3LP7mz; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9A17BFB13;
	Wed, 11 Sep 2024 21:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1726081400; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8hAaQN3YdzDz72AB4om4zk8jibkIckar9alPg9YCTzs=;
	b=hU3LP7mz10nvzbwY93tL/RA9Jq0tcb/Ajh2jAidLVbd+9bpAQf5CY/QX7V5y1TaCufIErb
	497+js9gQg985AAvxqZNu+CSkSl28978NJwQmhK18Ar2cUGOnd5vT0xBmG5AlG9qBVOjP2
	CcaL5ZhCz4bqo1xllFsNnZOuq/2Jbo22l3RnjKzxLLSQlgr9bPB5t8g3NBt0izb8OLwrVX
	5KyDLTeHpz0gXtymQe/aImjT3sST1F2w0CENDkSkeO3Hq95gdY6Dha5P6cQBQ9bj7nd7JR
	arBB9w/FRBIg3sfxuRxET7Q95OkSh6+swWveU/EW58sQZ1bOZ5/to7+kms+wOw==
Message-ID: <eb648c15-6cb5-43c5-93d6-f91157e542e6@fris.de>
Date: Wed, 11 Sep 2024 21:03:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Extending PLL LUT for i.MX8MP Samsung HDMI PHY
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
 Adam Ford <aford173@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20240910181544.214797-1-frieder@fris.de>
 <ZuDjAwPxHeJTvXAp@atmark-techno.com> <ZuEzxw96vRlYJ321@atmark-techno.com>
Content-Language: en-GB, de-DE
From: Frieder Schrempf <frieder@fris.de>
In-Reply-To: <ZuEzxw96vRlYJ321@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11.09.24 08:08, Dominique Martinet wrote:
> Dominique Martinet wrote on Wed, Sep 11, 2024 at 09:23:31AM +0900:
>> so if I find some time I'll whip some loop to check all other values...
> 
> There were more differences than I thought there'd be (see diff below)
> 
> they're all minor enough to probably not care, but your script finds
> exact values for them so it might be worth updating the regs if we keep
> the table...
> (OTOH these seem to work, and "if it works don't touch it" -- I have no
> further opinion now I've checked, curiosity is sated)

Yeah, that's interesting. A lot of those values seem to be a little off. 
Or my calculation has some problem, but it's unlikely as everything else 
seems to add up so nicely.

The deviations seem very minor, only in the per mill ballpark or even 
lower. I wonder how they got these values initially.

It would still be nice to verify the clocks with some real measurements 
on the hardware level before we change the existing values.

On a side note, there is drivers/gpu/drm/exynos/exynos_hdmi.c which is 
basically for the same kind of PHY, probably an older version of the IP 
core. It also has some LUTs for the PLL registers. But I didn't compare 
them so far.

> 
> Might want to just check 154000000 though, reg6's 0x80 was not set so
> SDC was disabled? and it'd get the integer fraction (153600000) instead
> if I understand this correctly

I think there are two switches. The fractional-N part can be enabled but 
the sigma-delta-part can still be disabled. That's different than having 
the fractional-N completely turned off.

My script doesn't cover this case. It assumes the SDC is always enabled 
if the fractional-N is enabled.

The problem is that I don't know what part of the calculation is the SDC 
value exactly. The reference manual is confusing and probably defective 
in some way in regard to this. So I don't really know when to 
enable/disable the SDC part.

For the 154 MHz this means even with SDC turned off the fractional-N 
part will provide the 400 kHZ to be added to the integer part. At least 
that's how I understand it. I might be wrong.

> 
> ---------
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index a5ad51425ee3..72facc7bd045 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -73,7 +73,7 @@ static const struct phy_config phy_pll_cfg[] = {
>   		.pixclk = 24024000,
>   		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 25175000,
> +		.pixclk = 25177981,
>   		.pll_div_regs = { 0xd1, 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
>   	},  {
>   		.pixclk = 26750000,
> @@ -82,16 +82,16 @@ static const struct phy_config phy_pll_cfg[] = {
>   		.pixclk = 27027000,
>   		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 29500000,
> +		.pixclk = 29487500,
>   		.pll_div_regs = { 0xd1, 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 30750000,
> +		.pixclk = 30729661,
>   		.pll_div_regs = { 0xd1, 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
>   	}, {
> -		.pixclk = 30888000,
> +		.pixclk = 30848949,
>   		.pll_div_regs = { 0xd1, 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
>   	}, {
> -		.pixclk = 33750000,
> +		.pixclk = 33731250,
>   		.pll_div_regs = { 0xd1, 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
>   	}, {
>   		.pixclk = 35000000,
> @@ -106,13 +106,13 @@ static const struct phy_config phy_pll_cfg[] = {
>   		.pixclk = 44500000,
>   		.pll_div_regs = { 0xd1, 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
>   	}, {
> -		.pixclk = 47000000,
> +		.pixclk = 47005000,
>   		.pll_div_regs = { 0xd1, 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 47500000,
> +		.pixclk = 47502000,
>   		.pll_div_regs = { 0xd1, 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 50349650,
> +		.pixclk = 50355924,
>   		.pll_div_regs = { 0xd1, 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
>   	}, {
>   		.pixclk = 53250000,
> @@ -124,16 +124,16 @@ static const struct phy_config phy_pll_cfg[] = {
>   		.pixclk = 54054000,
>   		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 59000000,
> +		.pixclk = 58975000,
>   		.pll_div_regs = { 0xd1, 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 59340659,
> +		.pixclk = 59264777,
>   		.pll_div_regs = { 0xd1, 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
>   	},  {
> -		.pixclk = 61500000,
> +		.pixclk = 61459322,
>   		.pll_div_regs = { 0xd1, 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
>   	}, {
> -		.pixclk = 63500000,
> +		.pixclk = 63437500,
>   		.pll_div_regs = { 0xd1, 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
>   	}, {
>   		.pixclk = 67500000,
> @@ -145,25 +145,25 @@ static const struct phy_config phy_pll_cfg[] = {
>   		.pixclk = 72072000,
>   		.pll_div_regs = { 0xd1, 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 74176000,
> +		.pixclk = 74175824,
>   		.pll_div_regs = { 0xd1, 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
>   	}, {
>   		.pixclk = 74250000,
>   		.pll_div_regs = { 0xd1, 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
>   	}, {
> -		.pixclk = 78500000,
> +		.pixclk = 78487500,
>   		.pll_div_regs = { 0xd1, 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
>   	},  {
> -		.pixclk = 82000000,
> +		.pixclk = 81945763,
>   		.pll_div_regs = { 0xd1, 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
>   	}, {
> -		.pixclk = 82500000,
> +		.pixclk = 82486555,
>   		.pll_div_regs = { 0xd1, 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
>   	}, {
> -		.pixclk = 89000000,
> +		.pixclk = 89075000,
>   		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 90000000,
> +		.pixclk = 89950000,
>   		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
>   	}, {
>   		.pixclk = 94000000,
> @@ -178,7 +178,7 @@ static const struct phy_config phy_pll_cfg[] = {
>   		.pixclk = 99000000,
>   		.pll_div_regs = { 0xd1, 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
>   	}, {
> -		.pixclk = 100699300,
> +		.pixclk = 100711847,
>   		.pll_div_regs = { 0xd1, 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
>   	},  {
>   		.pixclk = 102500000,
> @@ -196,16 +196,16 @@ static const struct phy_config phy_pll_cfg[] = {
>   		.pixclk = 108108000,
>   		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 118000000,
> +		.pixclk = 117950000,
>   		.pll_div_regs = { 0xd1, 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
>   	},  {
> -		.pixclk = 123000000,
> +		.pixclk = 122918644,
>   		.pll_div_regs = { 0xd1, 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
>   	}, {
> -		.pixclk = 127000000,
> +		.pixclk = 126875000,
>   		.pll_div_regs = { 0xd1, 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 135000000,
> +		.pixclk = 134925000,
>   		.pll_div_regs = { 0xd1, 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
>   	}, {
>   		.pixclk = 135580000,
> @@ -214,20 +214,20 @@ static const struct phy_config phy_pll_cfg[] = {
>   		.pixclk = 137520000,
>   		.pll_div_regs = { 0xd1, 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
>   	}, {
> -		.pixclk = 138750000,
> +		.pixclk = 138658397,
>   		.pll_div_regs = { 0xd1, 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
>   	}, {
> -		.pixclk = 140000000,
> +		.pixclk = 140040000,
>   		.pll_div_regs = { 0xd1, 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
>   	},  {
> -		.pixclk = 148352000,
> +		.pixclk = 148265128,
>   		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
>   	}, {
> -		.pixclk = 148500000,
> +		.pixclk = 148396403,
>   		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
>   	}, {
>   		.pixclk = 154000000,
> -		.pll_div_regs = { 0xd1, 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x40, 0x18, 0x83, 0x01, 0x80, 0x40 },
>   	}, {
>   		.pixclk = 157000000,
>   		.pll_div_regs = { 0xd1, 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
> @@ -268,10 +268,10 @@ static const struct phy_config phy_pll_cfg[] = {
>   		.pixclk = 254000000,
>   		.pll_div_regs = { 0xd1, 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
>   	}, {
> -		.pixclk = 277500000,
> +		.pixclk = 277316794,
>   		.pll_div_regs = { 0xd1, 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
>   	},  {
> -		.pixclk = 297000000,
> +		.pixclk = 296792806,
>   		.pll_div_regs = { 0xd1, 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
>   	},
>   };
> -------------


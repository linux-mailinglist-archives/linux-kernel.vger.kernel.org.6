Return-Path: <linux-kernel+bounces-401759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC459C1ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5931F23361
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCB81EF093;
	Fri,  8 Nov 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="D1lJq6uU"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4C1E1C18
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074791; cv=none; b=RRwIBMDdNm0I+Q3+yjpQxBKXqWEHH8Nlp0NLZfmNPkXRLHvjcjDEP8+r9iehFcR2NRNoN4YI41q6GAR2ePbG599ZHRTNsqKoM78FEGn6V8usMRWOOmwM/972kcAgXSjIOfSWqIwT4Ey0iNhS/9HhZ7H8xjhfT1I7bWTsfA7GH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074791; c=relaxed/simple;
	bh=xD2RQj+JshaMb9oyvUwt+j+Ut4VAz6w9+T6vx8JazGI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NNXf2t3h0Y4nloltTwiCFqK9mqg3fuqh3IiEFQwEm9u5i+8OSm4tlbgcTWfgchzZigWAH/R3aVJAZDLy3ik8Mdsml9fAx6BNaEgrSWQ+bvS7b3tu6lpvDdM8NtX3n4BlCHMjFC1X2Kbgh0c1VSYklRMQEA13bYR132iDCpFdhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=D1lJq6uU; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id 9OZstlGwQqvuo9Pd4tShHr; Fri, 08 Nov 2024 14:06:26 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id 9Pd2tk8wIWvXp9Pd3tuH6y; Fri, 08 Nov 2024 14:06:25 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=672e1ae1
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=-pn6D5nKLtMA:10 a=VwQbUJbxAAAA:8
 a=N0_SVMCKczatFtdaR1UA:9 a=QEXdDO2ut3YA:10 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G0sUQjvOBk5B7kF86MBReNvaIgs7XdYt9a7X6u95KvI=; b=D1lJq6uUB2SbYrHNUsyv+lKoap
	tPXxNaSsKzycBkj8viPTPeuQzaW2EhEhocHzUx+kw5ShOtGEToD5zrtzAtnPgPAyJvO3EJOCY3Ys9
	C9Grhy7VZFJ2EWAAAjMwO8iFmLWwygp8FBgFyIFI2v4OZCeZs3OY4w3TBaVchSyO2hCYoOGETBvsh
	O/uJcRK84TBuP/s2oBKlhvP9lFNUfF6nwmitZ9jq1YnbHnXsocIhpDzeS3VNWZOPebThnK3zMui5+
	ivFDNY/bWMMhJS0Ijpp8xZl3+Qbk5zo6eqGElJf64EWJHO57KjEUPpjfwPAj6HS9AyRRsOAp5Pl66
	3o3FL5cw==;
Received: from [122.165.245.213] (port=41996 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1t9Pcx-001wS1-09;
	Fri, 08 Nov 2024 19:36:19 +0530
Message-ID: <b26b9d86-4ff9-4543-85ce-176dccfbfa05@linumiz.com>
Date: Fri, 8 Nov 2024 19:36:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Workaround TCON TOP conflict between DE0 and
 DE1
To: John Watts <contact@jookia.org>, Andre Przywara <andre.przywara@arm.com>
References: <20241108-tcon_fix-v1-1-616218cc0d5f@jookia.org>
 <20241108115357.691b77b0@donnerap.manchester.arm.com>
 <Zy4SKCBwce3q0yj5@titan>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <Zy4SKCBwce3q0yj5@titan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1t9Pcx-001wS1-09
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:41996
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF7p16a4twxBqVsiDG5jTz8CyHTHMCVsF3K7lYVuA9v11//POhLigJ7m0+DZt/Ldo6t6M/WDkOTnTIiLB1oXzQZce+36HX6vAK7Z8nKw7+XdkYGZqUon
 6erSK3bkXPQj/GMRdeNvX751gceSL5PbIQ0fSjdRMS/7Ryie7gWVBHCT+PyvBvrMw/6sCIzf1jfCdVhFVkkVwc5QvR1+X1Um48c=

On 11/8/24 6:59 PM, John Watts wrote:
> On Fri, Nov 08, 2024 at 11:53:57AM +0000, Andre Przywara wrote:
>> Hi John,
> 
> Hi Andre!
> 
>> Can you say *why* this patch is needed? Is there something broken that
>> needs fixing? Where does this show and why wasn't this a problem before?
> 
> Oops, that's a good point. There is currently a bug where the LCD output will
> be tinted. I have full context here which I should have probably linked in the
> patch description:
> 
> https://lore.kernel.org/linux-sunxi/Zn8GVkpwXwhaUFno@titan/T/#u
> 
>> To be honest, given the isolation on this patch, I'd rather wait for this
>> full fledged solution, especially if there is no pressing need (see above).
> 
> I'd be interested to hear if that's still the wanted solution given the link
> above. This currently blocks many people from having working LCD output.
> 
> Doing it the proper way might be overkill for now unless someone deliberately
> tries to run two DEs to the same output. I haven't seen this use case.
> 
> Allwinner kernel fork initially sets them up to values like these then makes
> sure both DEs can't be set to the same TCON.
> 
>>> -	writel(0, regs + TCON_TOP_PORT_SEL_REG);
>>> +	writel(0x20, regs + TCON_TOP_PORT_SEL_REG);
>>
>> Sorry, but that looks weird:
>> First, please explain the 0x20. Is it bit 5? If yes, what does that bit
>> mean? The commit message suggests you know that?
>>
>> And second: the comment above clearly states that those two writes just
>> *clear* some registers, to have some sane base line. So please adjust this
>> comment, and copy in some of the rationale from the commit message.
>> Explaining things in the commit message is good (so thanks for that!), but
>> having at least some terse technical explanations near the code, in a
>> comment, is better.
> 
> Bit 5 is value 3 of TCON_TOP_PORT_DE1_MSK. The R40 datasheet explains the
> values of both masks as follows:
> 
> 00: TCON_LCD0
> 01: TCON_LCD1
> 10: TCON_TV0
> 11: TCON_TV1
> 
> So this sets DE1's input to DE0.

To add, 0x20 will be DE0 <--> LCD0 and DE1 <--> TV0. Below note (copied from
R40) states the priority of the DE selection, which fails to work? Not sure,
may be disabling CORE1_SCLK_GATE and CORE1_HCLK_GATE in de2-clk helps.

With A133 following the same as T113 with single mixer without TV, still
sets 0x20 in vendor kernel.

copied from R40:
Note: The priority of DE0 is higher than DE1.
If TCON_LCD0 selects DE0 and DE1 as source at the same time, then
DE0 will be used for the source of TCON_LCD0.

Thanks,
Parthiban

> 
>>
>> Cheers,
>> Andre
> 
> Thanks,
> John Watts
> 



Return-Path: <linux-kernel+bounces-430442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CFD9E30E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86DC7B27C12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BF415E97;
	Wed,  4 Dec 2024 01:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OxiKsdGR"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB37EADA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276659; cv=none; b=VLhqspLbUoEJFRVwUlDLqQxRjhViwrKgcJyACeasYZjXdK6x5Y1AWW0291NImU6EdVO9HHTvXLzBydxXAhsi4IMolkefXukuBQPzs7ACNQUVTIwaXYM/O3ziAGElm1kTGNj26Z6s4KvNF22S/JGU037922ZoxKLbgQpmwUu3ClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276659; c=relaxed/simple;
	bh=9ATB26R3EPNus6n5U0BfNxhU4kzcdtkH64IP+0I3SsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ul+KqNuBjQEzObav0JkI5VPyo+57BZ1kFkfTOz4VKsTZmwxiVWQBObiqrbixI1lksBTo3+V28fgCqvHKZqkoEtDK6RiIJNP2jhEEmL83MTnCVKiJJJD+eXOfjbyr1Nzx2+NmOBSrqfZE3Ggo0k46Qo8Odg+coBzIajMWFCbwBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OxiKsdGR; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AED348940F;
	Wed,  4 Dec 2024 02:44:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733276654;
	bh=vY9kPGS0RdiXB0OHZCmI9kH/oWg2qyslJ/GlqgoS874=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OxiKsdGRxNS7Xdu0tMCPtS62mOtLM/7/zbKsln5bTnZxcCAxW4IyRydn6ckF5zToI
	 2knwzr4uqjZctkqgfqG2/XdrW4teL8Yd8c16CFXDRjf6t5PlX9oK9oAHAtdnexaJQJ
	 P1rpf4NgH6zDZom1Gkf0pI6G2PkzuU+SkJs/V7Zfflf7kY7yEAJQJf01Ed4FwjiNDU
	 vQYsUY8CHQIsDSULugkcFEBnAwsh2/6m1BKQT/OCg93ykB0j1nRGqlFyA89S3F4+GS
	 2rJieYBhNc99vWOLe01jqNFhSckRQyvWSwM1f9FBlKmGlJZy6n8MijvCDFehud213r
	 5ZfrvtJrc0mbg==
Message-ID: <b86666cc-da63-405d-9036-96cb4e69dafb@denx.de>
Date: Wed, 4 Dec 2024 00:40:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
To: Nikolaus Voss <nv@vosn.de>
Cc: Liu Ying <victor.liu@oss.nxp.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Fabio Estevam <festevam@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nikolaus.voss@haag-streit.com, miquel.raynal@bootlin.com
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
 <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
 <000b34cdd1591c82265ce1f9848828d1@vosn.de>
 <2c950130-84b4-4a81-84a2-b5e08af43616@oss.nxp.com>
 <12a1b86e-8f25-4875-8503-1de98f125a62@denx.de>
 <808d4092a9e97b95480d47c1bd84d930@vosn.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <808d4092a9e97b95480d47c1bd84d930@vosn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/3/24 8:20 AM, Nikolaus Voss wrote:
> On 03.12.2024 04:12, Marek Vasut wrote:
>> On 12/3/24 3:22 AM, Liu Ying wrote:
>>
>> [...]
>>
>>>>> I doubt that pixel clock tree cannot find appropriate division ratios
>>>>> for some pixel clock rates, especially for dual-link LVDS on i.MX8MP
>>>>> and i.MX93 platforms, because PLL clock rate should be 7x faster than
>>>>> pixel clock rate and 2x faster than "ldb" clock rate so that the 3.5
>>>>> folder between "ldb" clock and pixel clock can be met. That means the
>>>>> PLL clock rate needs to be explicitly set first for this case.
>>>>>
>>>>> Can you assign the PLL clock rate in DT to satisfy the "ldb" and pixel
>>>>> clock rates like the below commit does, if you use a LVDS panel?
>>>>>
>>>>> 4fbb73416b10 ("arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1
>>>>> frequency to 506.8 MHz")
>>>>
>>>> I probably could. The point of my patch is you don't have to know in
>>>> advance which LVDS panel is connected, and you don't have to calculate
>>>> the base PLL clock by hand and store it in the device tree.
>>>>
>>>> In my test system, I have three different LVDS panels with EDID EEPROM,
>>>> none of which worked with the stock driver, but all work with this
>>>> patch.
>>>> With slightly adapted pixel clocks though.
>>>
>>> If each of the three LVDS panels has only one display mode, you may
>>> assign the PLL clock rates in DT overlays for the panels.
>> I temporarily agree.
>>
>> I also currently use DTOs for various panels including their PLL
>> setting, but in the end, I think/hope the work of Miquel and co. is
>> going to make that PLL setting part unnecessary.
> 
> That is exactly what my patch is about. I want to use one DT for all
> panels

Right

> and store the panel's timing in EDID EEPROM.
Oh, that is a new one. Does the EDID EEPROM store the entirety of 
'struct display_timing {}' somehow , or is that a custom format ?


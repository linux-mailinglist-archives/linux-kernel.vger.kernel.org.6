Return-Path: <linux-kernel+bounces-419292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574809D6BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 23:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C960E281F70
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE651AB6CB;
	Sat, 23 Nov 2024 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="cYxJwfmT"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26851A724C;
	Sat, 23 Nov 2024 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732401281; cv=none; b=Uvve43jZu2qrp0CQTlBfFfkFItRa5Te6RQ5Tyr0VwnwgIn/scRudNBWdPAYjrsxiylMFx6qa8oPpcDSGPeYg5/P+s4d8ay3to5z81zeDQGfqtQ/uVss3n0/W6Ggd9+xdC5KnQ6AbvyQYpp6bYRGZ58gtKRttbhRYWnxa92ZrdwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732401281; c=relaxed/simple;
	bh=vIqWvHz/juZcLWbUqjLSwK38ndJaU0c4olpBuC7k//M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FW5y+SfyObleo+hMGZOh4mBXIEufehbzGxkk6FCjVPnA3wUCUwZnLmDvGfljKjuj+xJ/VdHW7Lrs8cqkxFqzrXNWocCnizhjE31ikVPbnRJtcVoCGWcpCzalTogk1w7w0ZthGZaY2kURXLS4U0qebi0I6IgXGXzbVXwtPr4ub2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=cYxJwfmT; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 944DD89401;
	Sat, 23 Nov 2024 23:34:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732401268;
	bh=UVI84fOke9gLRZ0suzoYkdmP/Z7GYELBjts2k6DzJl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cYxJwfmTaViuJOl0E6LpQm/Yli1C/FbRzss9eticyEKW0qVpN1ZSjg/mt+Jhflech
	 xZPDZK/2aDIWkoZCayi0JfCMpOWINUNWavA6h3p2lCt5sGaekQVrM1Rh3lMJzDDT9I
	 0P5uEXc/IOYzu8lRmA7IUMCIbDIOfeYVkTgl43z8X46shVEBMmRvaPIOo39o0Smn2y
	 MzUfd3fB98Nx4L29dvoE4Wub78AS+8by0lY2Ld8CUxGFA2OhGcx/7eFtjUcbUiFYI6
	 UDMn/y70IKCsE1VZzCaAq9TgOEH8XdQr2XrBNHm4cLfehwhtgt2Hdz4lEZNyzoctiu
	 1lij3zQXXUpgw==
Message-ID: <bd884164-3a38-446d-8a54-3d716a3e0360@denx.de>
Date: Sat, 23 Nov 2024 21:11:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] Revert "clk: imx: clk-imx8mp: Allow media_disp
 pixel clock reconfigure parent rate"
To: Ying Liu <victor.liu@nxp.com>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "abelvesa@kernel.org" <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "rfoss@kernel.org" <rfoss@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "nfraprado@collabora.com" <nfraprado@collabora.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <20241114065759.3341908-1-victor.liu@nxp.com>
 <20241114065759.3341908-3-victor.liu@nxp.com>
 <df6ebdde-65f8-4aad-93c7-b1df695bd2ef@denx.de>
 <AM7PR04MB7046546A882A8D48E135D84698272@AM7PR04MB7046.eurprd04.prod.outlook.com>
 <8a4fd234-4c7b-4a04-990d-3222aaa5172d@denx.de>
 <AM7PR04MB7046E282FD702ACE5E288F8998202@AM7PR04MB7046.eurprd04.prod.outlook.com>
 <83be0a27-6b6c-4ba6-b9dc-f914a10abace@denx.de>
 <AM7PR04MB7046587167BF790549B8560F98212@AM7PR04MB7046.eurprd04.prod.outlook.com>
 <c5ab63da-21ec-4c0d-8ecc-3745943d806f@denx.de>
 <AM7PR04MB7046D404841394382324DE7198232@AM7PR04MB7046.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <AM7PR04MB7046D404841394382324DE7198232@AM7PR04MB7046.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/22/24 4:39 AM, Ying Liu wrote:
> On 11/22/24, Marek Vasut wrote:
>> On 11/20/24 7:38 AM, Ying Liu wrote:
>>
>> [...]
>>
>>>>> If the DP monitors support typical video modes like 1080p60 with
>>>>> 148.5MHz pixel clock rate, I assume these typical video modes work
>>>>> still ok with this patch at least.  Please help confirm this, since if the
>>>>> alternative solution(*) doesn't stand, we would know those video
>>>>> modes still work ok with my solution(fixed PLL rate).
>>>>
>>>> They do not work with the fixed PLL setting.
>>>
>>> Why?  Did you assign a sensible fixed PLL rate in DT?
>>
>> Whatever was in imx8mp.dtsi does not really work for all the panels.
>> Please keep in mind that the use case I have does not include only
>> 1920x1080 "standard" panels, but also other resolutions.
> 
> It looks like you are still sticking to the idea of supporting all potentially
> valid video modes by trying to find an "alternative" solution, while
> neglecting that the solution *could be* never working.

Reconfiguring the PLL to achieve accurate pixel clock is working 
already, right now.

>>> Can you please compare clk_summary output for the failing cases
>>> before and after this patch is applied? I assume that if you use
>>> the fixed PLL rate same to the rate which works before this patch is
>>> applied, the typical video modes still just work after this patch is
>>> applied.
>>
>> I'm afraid I do not need to support only typical video modes, but also
>> the other "atypical" modes.
> 
> If the "alternative" solution doesn't work, we'll end up using the "fixed
> PLL rate" solution.  It that case, some video modes would be filtered
> out as a sacrifice.

Maybe it would be better to continue the discussion in

[PATCH 0/5] clk: Fix simple video pipelines on i.MX8

which seems close to the alternative solution I was looking for ?


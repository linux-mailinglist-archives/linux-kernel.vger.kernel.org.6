Return-Path: <linux-kernel+bounces-401768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A66B9C1EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29EA1F23FB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3380D1F1317;
	Fri,  8 Nov 2024 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGXrjtMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B081E1C18;
	Fri,  8 Nov 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075067; cv=none; b=uWVbbyk6OzlbfGBtcv+FLcMF4ytwNSIt2/decF9YFOlPjzRuVhSxedQ/xpjVNz3Oz1saUBOr80FMovf/prCEVBLy3Ol+CcfmJFn13zwRJkQc6ns5pIa6ZGCFWyLuSQLypV2CoYzKYk3XY3N80GeLa6AsJATCrWNmUH9tLYYTAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075067; c=relaxed/simple;
	bh=cn9NWvkG2FmD8kESo4BHxEQQZk2BWVmfGCHOfHfEjEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijtRzV1IZ5SP6xSghipp0BdMicfdp0IDquHzoX6rRc3IlYYqbNC/XlIEitG8FeXL5iO9I4o5J0VPq7E665bEEhm3jYccRxs+2rbyC3YLiCLxq0BWeZbRKv+Qs6MV6iKuOKOGxGVdUykcSqqzKyN1C35Lk1g5+vTreLSl0k59AFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGXrjtMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83A8C4CECD;
	Fri,  8 Nov 2024 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731075065;
	bh=cn9NWvkG2FmD8kESo4BHxEQQZk2BWVmfGCHOfHfEjEo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CGXrjtMOWgqtA0TJAwGpybZurfjTSpW+4Y7zhVTkrcxOi666w38LvT0n0bw5WjLkq
	 czYMxyfqDVdWVkHlLjRTwGavAIQAKP3mZXLw3t7dhxh5ZvlqBhw0Z1921RwSG1Yjht
	 96WuRZJkCv6WmSVw9JdeBJXIHO89DN6m1dchli/8d4FaviFfuEjAAiMqo0T+oTsdqy
	 GqeJtkx+WBXIaI0aHqwW6960y84OIhKpo6r/vpizu8X1Fmd2JeXM43mxU27GgbCBl5
	 y0TXzXiob/mqHxXJDPGWAj2lf5m1qtSuVHU1W4IhObYb6DqVDr/latoCggXQnWV3/a
	 JpHU8Tt/Ct9aA==
Message-ID: <8c310eca-d695-418c-82cb-a89351d83887@kernel.org>
Date: Fri, 8 Nov 2024 15:10:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock: support spread
 spectrum clocking
To: Peng Fan <peng.fan@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>,
 Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
 <20241106090549.3684963-2-dario.binacchi@amarulasolutions.com>
 <4bix7me5vaoyhcuffyp4btajmhy7no6ltczoesopaz2fqupyaw@fensx4nn472u>
 <b7c1499b-8337-421c-9734-6e518d678ff8@kernel.org>
 <CABGWkvrYJL9=zrPSFuEAgKO+9gDHD6RmCJM6Br6Le_eh578ETQ@mail.gmail.com>
 <54dd6ae6-b992-451e-b1c6-8a1968955f4a@kernel.org>
 <PAXPR04MB8459BE3474EFD4FCC28E0E82885D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <PAXPR04MB8459BE3474EFD4FCC28E0E82885D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 13:50, Peng Fan wrote:
>> Subject: Re: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock: support
>> spread spectrum clocking
>>
>> On 07/11/2024 15:57, Dario Binacchi wrote:
>>>     clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
>>>                   <&clk_ext3>, <&clk_ext4>;
>>>     clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
>>>                              "clk_ext3", "clk_ext4";
>>>     assigned-clocks = <&clk IMX8MN_CLK_A53_SRC>,
>>>                                   <&clk IMX8MN_CLK_A53_CORE>,
>>>                                   <&clk IMX8MN_CLK_NOC>,
>>>                                   <&clk IMX8MN_CLK_AUDIO_AHB>,
>>>                                   <&clk IMX8MN_CLK_IPG_AUDIO_ROOT>,
>>>                                   <&clk IMX8MN_SYS_PLL3>,
>>>                                   <&clk IMX8MN_AUDIO_PLL1>,
>>>                                   <&clk IMX8MN_AUDIO_PLL2>;
>>>     assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_800M>,
>>>                                              <&clk IMX8MN_ARM_PLL_OUT>,
>>>                                              <&clk IMX8MN_SYS_PLL3_OUT>,
>>>                                              <&clk IMX8MN_SYS_PLL1_800M>;
>>>     assigned-clock-rates = <0>, <0>, <0>,
>>>                                          <400000000>,
>>>                                          <400000000>,
>>>                                          <600000000>,
>>>                                          <393216000>,
>>>                                          <361267200>; };
>>>
>>> The spread spectrum is not configurable on these clocks or, more
>>> generally, may not be configurable (only 4 PLLs have this capability).
>>> Therefore, I need the "fsl,ssc-clocks"
>>
>> No. That's not true. You do not need it.
>>
> 
> i.MX8M clock hardware is similar as:
> 
> OSC->ANATOP->CCM
> 
> ANATOP will produce PLLs.
> CCM use PLLs as input source.
> 
> Currently there is no dedicated ANATOP driver in linux.
> The CCM linux driver will parse the ANATOP node and
> register clk_hw for the PLLs.

I do not know what is CCM and how does it fit here. What's more, I don't
get driver context here. We talk about bindings.


> 
> 
>> First, the clock inputs for this device are listed in clocks *only*.
>> What is no there, is not an input to the device. Including also Linux
>> aspect (missing devlinks etc). Therefore how can you configure spread
>> spectrum on clocks which are not connected to this device?
> 
> I not understand this well, you mean
> add clocks = <xx CLK_IMX8MM_VIDEO_PLL> in the ccm dtb node?

Yes. Let me re-iterate and please respond to this exactly comment
instead of ignoring it.

How a device can care about spread spectrum of a clock which is not
supplied to this device?

Why would you care about spread spectrum of some clock which is not
coming to this device?

Please address these precisely because we talk about this for weeks in
multiple places. I finish with this patchset if you do not provide such
context.

Best regards,
Krzysztof



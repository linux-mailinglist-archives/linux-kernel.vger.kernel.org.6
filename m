Return-Path: <linux-kernel+bounces-414417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE969D279E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436571F2195E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8E91CCB25;
	Tue, 19 Nov 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlZJQ3RH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFBD1798C;
	Tue, 19 Nov 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025234; cv=none; b=IfLhfBMWmcUfVI1PyHFjBoHehZKFZWmdU52BQEWYxo8vJlXEXyvDsrs5vziRzJYOud7OM3O+VS7HzUEDsuPGwwB/ySXadCLPz1lqM91zadqnxIMBC+Es913hA3BzaUZCxugN629bxx0n32zAFNlCIGDYaIpiqjLcTecQsOPahn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025234; c=relaxed/simple;
	bh=mebWzILOAfAKv58yaSkEWhm/2aEw4TVR9ZNMKA1P9ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3sO2aGrLyb1uXwYtlHh4T6cVqaFqDO347fitrLZXYotllx4SedzGJXvfIEK6dwhFrNOzd9jZVM/0MKpDBSxqQzkHVhKxEGFmhakU9AWncTpq1xZaKPuX6Tw9lsGEFPuQfsCNuOcSUuEFj3X8LCl6RcKOGu5aKJ43hltb0Dr2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlZJQ3RH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C68CC4CECF;
	Tue, 19 Nov 2024 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732025234;
	bh=mebWzILOAfAKv58yaSkEWhm/2aEw4TVR9ZNMKA1P9ic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BlZJQ3RHFY0useN/T0rRiAgdzcCHwJaiesCKlxjfCmpEO1VOcTkkwumKMonFWR2dq
	 ELg5RU6UHlnI55GtQjCuTB1IQw48/G6P/53QjW0bMgFMNLtzLJtolmMZ5a/Lpl6J0G
	 CYunRywsUYknOKVeFZtmy9h8+OPdi9WrMf8FCC67JL/FdVch5/9BRUEMNraV/7fp2+
	 H2MnyMHX0hPNwFLHUOVaLVdCupJPWJBrL8TL3RLnbY2KeyjcKTyCd9f/3TqxAhJE3O
	 RYKaw12ZkwPcd/h+GSczJaEe+ooGh4/yqAo5P2dCLq6sTat5mPUXCVx+k/2mHsbhic
	 cZhDf2tXchclg==
Message-ID: <d137cc7e-9b78-4cfb-ac50-023d1ea4c82b@kernel.org>
Date: Tue, 19 Nov 2024 15:07:08 +0100
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
 <8c310eca-d695-418c-82cb-a89351d83887@kernel.org>
 <PAXPR04MB8459B6F8D5C623D19CCF6B39885E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bc02327b-dea8-48c9-b036-4a0eda0c4cb9@kernel.org>
 <9f6b243b-0642-41db-85ed-d020bfa3e6e2@kernel.org>
 <PAXPR04MB845978F4D3C6E887E0DE8D5488582@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <PAXPR04MB845978F4D3C6E887E0DE8D5488582@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2024 02:49, Peng Fan wrote:
>>> I don't understand now even more. Or I understand even less now.
>> Why
>>> binding references its own clocks via phandle? This makes no sense
>> at
>>> all, except of course assigned clocks, but that's because we have one
>>> property for multiple cases.
>>
>> And BTW if that was the point then the example is confusing because
>> the &clk phandle is not the device node in the example but it should.
>> Neither description says which device's clocks are these.
>>
>> This is expressed very poorly in the binding, look:
>> "Phandles of the PLL" - it clearly suggests some other clocks, not its
>> own, that's so obvious I did not even think of asking. Patchset goes
>> slow also because of poor explanation, lack of diagrams and expecting
>> me to remember your clock hierarchy.
> 
> 
> Dario may improve the patchset in new version. But let me just try
> to explain a bit more about the hardware logic, I hope this could
> give you some knowledge on i.MX clock and we could get some
> suggestions on next:
> 
> 
> OSC will generate 24MHz clock to Anatop module.
> Anatop module takes 24MHz as input and produces various PLLs.
> Clock Control Module(CCM) takes PLLs as input, and outputs the final
> clocks to various IPs, saying video IPs.
> 
> The Anatop module could produce PLLs with spread spectrum enabled.
> The Clock Control module just divides the freq and output the end IPs.
> The end IPs cares about spread spectrum for high quality clock, the
> Clock Control modules does not care. Now back to binding,

All above makes sense. The previous message:
"Because in current design, ccm is taken as producer of
CLK_IMX8M_VIDEO_PLL, not consumer. "

confused me a lot because it suggests that these PLLs are provided by
CCM. It turns out not... so the answer is like I said long time ago: you
must take these clocks as inputs and this is done via clocks property.
Not fsl,clocks or fsc,i-want-more-properties-clocks.

> 
> There is a imx8m-anatop binding fsl,imx8m-anatop.yaml for anatop
> and a imx8m-clock.yaml binding for clock control module.
> 
> I think the patchset is to enable spread spectrum of a PLL globally,
> not for a specific device saying video IP here. So the patchset put
> the properties under the clock control module.

I understand. This looks however as misrepresentation. If you do not
have the video IP block enabled, why would you configure spread
spectrum? IOW, spread spectrum as you described is needed for the final
IP block and this final IP block should configure it. Properties belong
there.

It's kind of similar for some OPP/performance/bandwidth requests. Even
more similar to clock frequencies. Which device requests to configure
given clock frequencies? Final consumer, not clock controller.


> 
> For example, there are VPU_JPEG, VPU_DECODE, both will use
> video PLL with high quality. So the clock producer just produce
> PLLs with Spread Spectrum(SS) enabled, and put the SS properties
> under CCM or anatop node, not video IP nodes.
> 
> 
> We could have a talk on IRC if Dario, Abel and you are available to
> discuss on this topic.



Best regards,
Krzysztof


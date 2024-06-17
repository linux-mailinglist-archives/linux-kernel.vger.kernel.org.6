Return-Path: <linux-kernel+bounces-217277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC490ADB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004D2287A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBC8194C9B;
	Mon, 17 Jun 2024 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPLCzLpA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7F194C78;
	Mon, 17 Jun 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626287; cv=none; b=Cc7NN2yIBNR6+LzzPK8qB0csFEwN5/Noik1VtK96SqsJAkcDnWJZwUADwEXojtNfYz5sn3W8Ks2PZgaBENkShkZdBk1Ua27vBy0cfpt0r3qIeobV3MRsYS2QPfx6H/DN6uto8H8Nkd6H3SJfl933mKvw3TxqP9tzx/MiqdFmuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626287; c=relaxed/simple;
	bh=qPKRH/m+0WU62ekkJ5fsgl1vqOCrHGJhT9fzRyzgO6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxpuGC1WNttG2/yFCoki99Eo0UQpLM6mwin9dmY6LkQeU72nxcuXeO1w7cSXy5EP1JEjti9aWpe8GeweA1Q0bk2POcCjPgpV/kN58s0hzocYyJP1UtGthPeeWJWdncr7F4/d6oEi9VLtYGoJmZpL0NbfWrIWBA7V4txhmMIszVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPLCzLpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3E7C2BD10;
	Mon, 17 Jun 2024 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718626286;
	bh=qPKRH/m+0WU62ekkJ5fsgl1vqOCrHGJhT9fzRyzgO6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hPLCzLpAOJkge6FvgefvE1OipNdVhLalb3LtuSsmbfbAXxBL3wsMj77hhG3sgSkA7
	 pkD6S2QKrdQJt4uGxgoWA7IA07lE1RNBmVdz3fnrrN/0vs4mOJRwHrl85wIN4JypHQ
	 XLYz2gwNkhUGTRxCrF0Cj06E8CQUYw6iOng8QdgLWmZkVmay/GOJPniNV44khsh1Yr
	 wKkMCZb/kGj4+J/Fa06f0322YZT/m+K5/C4YIZZapPG/Lv3C8hBWkl+UxlQugM5Grc
	 HBEsddfw38nQ7VxaQ8cgEv/bAv5kmaHXGOIPFhEfl4sr9RZ4FvyMlq1xN0whhcXuW3
	 3gMgYkqui5dxg==
Message-ID: <1f8dd436-1f01-48f5-b2f5-2ba9d998be3b@kernel.org>
Date: Mon, 17 Jun 2024 14:11:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
 bindings
To: Aisheng Dong <aisheng.dong@nxp.com>, Vabhav Sharma
 <vabhav.sharma@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Franck Lenormand <franck.lenormand@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Varun Sethi <V.Sethi@nxp.com>,
 Silvano Di Ninno <silvano.dininno@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Frank Li <frank.li@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
 <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
 <750f5388-20f9-45a3-a1e6-ceac4b91329f@kernel.org>
 <AS1PR04MB9358A2457AF05553457DE9B0F3FB2@AS1PR04MB9358.eurprd04.prod.outlook.com>
 <1486a1b6-4119-4121-b6df-3da21d06add7@kernel.org>
 <DU0PR04MB929983AB361DB081B44E7AFE80C02@DU0PR04MB9299.eurprd04.prod.outlook.com>
 <a752a912-a328-49c8-b887-fa95512785cb@kernel.org>
 <DU0PR04MB9299FB3B70920CF85CA2FB6B80C12@DU0PR04MB9299.eurprd04.prod.outlook.com>
 <f6515498-ffc4-45b0-a19c-82204e4c83c0@kernel.org>
 <DU0PR04MB92994DFA6AA23B7521B20B2680CD2@DU0PR04MB9299.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <DU0PR04MB92994DFA6AA23B7521B20B2680CD2@DU0PR04MB9299.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/06/2024 12:11, Aisheng Dong wrote:
> Hi Krzystof,
> 
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: 2024年6月16日 15:34
>> On 13/06/2024 10:48, Aisheng Dong wrote:
>>> Hi Krzysztof,
>>>
>>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>>> Sent: 2024年6月13日 14:14
>>>>
>>>> On 12/06/2024 09:20, Aisheng Dong wrote:
>>>>> Hi Krzysztof
>>>>>
>>>>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>>>>> Sent: 2024年6月7日 15:08
>>>>>>
>>>>>> On 07/06/2024 06:58, Vabhav Sharma wrote:
>>>>>>>>
>>>>>>>> Missing SoC compatibles.
>>>>>>> Ok, I will use fsl,imx8dxl-sc-secvio
>>>>>>>>
>>>>>>>> So no, that's just abuse of DT to instantiate driver.
>>>>>>>>
>>>>>>>> NAK. Drop the binding.
>>>>>>> I will detail the dt binding to describe the real hardware
>>>>>>
>>>>>> Still looks like way just to instantiate driver. Why it cannot be
>>>>>> part of existing firmware SCU node?
>>>>>>
>>>>>
>>>>> Technically yes. But SCU case is a little bit complicated as
>>>>> there're many functions and all of them are already added as sub
>>>>> nodes in SCU node for consistency and handling platform difference.
>>>>>
>>>>> I guess some of them, e.g. rtc, could be part of SCU node (reuse)
>>>>> while some couldn't. e.g. pinctrl Do you want us to only make secvio
>>>>> reuse existing SCU node?
>>>>
>>>> Yes
>>>>
>>>
>>> Digging a bit more on the implementation. It seems there will be a
>>> 'parent depends on child' issue when reusing the parent SCU node for secvio.
>>> Considering the defer probe support and ocotop could be modules, I'm
>>> still thinking If any solution. Do you have a good suggestion?
>>
>> I don't see any problem there. You will have even worse if making it children
>> and using populate - unpredictable order.
> 
> Sorry I didn't find a good solution without making OCOTP node to be party of SCU
> node too which we can't due to extra required properties of nvmem properties. 
> E.g. #addr/size-cells.
> 
> I think the key problem is OCOTP is already a child node and there's a mismatch issue
> If only making secvio, which depends on OCOTP, re-use their parent SCU node.
> Maybe you have a good idea. Would you mind share a bit more?
> 
> BTW, I don't understand the order problem if making secvio a children as all
> child nodes are Individual function devices and supports defer probe well.

You keep talking about drivers but what does it have to do with bindings
at all?

You can order your probe however you wish regardless of bindings. You
can handle or not handle deferred probe. You can create circular
dependencies or break them. All regardless of the bindings.

Best regards,
Krzysztof



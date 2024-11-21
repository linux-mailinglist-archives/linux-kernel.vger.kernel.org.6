Return-Path: <linux-kernel+bounces-417002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F70A9D4D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AA428206F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BCE1D89FE;
	Thu, 21 Nov 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHsc4yE6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28571D0DF7;
	Thu, 21 Nov 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194538; cv=none; b=CmVzKnUMY6+MTNLJiw7sGrMCIvsKe1PaIEONvPgYIiyZQZyHTE1i2BoXu6PhiRMRGV2EKUHMX1ctGDm6ny/6C2cQIflftn9P1gnTuFBZOxPF6OyzjhQCGJQ04aUWqLI4nTsSIgymtDznZG5Ew7C7koEd/3VLkHaPUQD06jsVbLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194538; c=relaxed/simple;
	bh=TI71bCsHyJmW5bcuA/G5CsKR520eaTS3Cnh8kMl95EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSoDiCi88+DqiS1Hreke+om7ltS41nIYA1qMr0L3xwpkXHzIqnM50urb/iwMO+xV10btxXkwoap909RcGhD3HQQ/h31Bg/hMceXT0+uQ+zIzriBPm9AEU3yNAvA8kvLTzNG76Em9zLBX0AUn+bw425OKK6T8bpiDshAo6JRqj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHsc4yE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D211C4CECD;
	Thu, 21 Nov 2024 13:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732194537;
	bh=TI71bCsHyJmW5bcuA/G5CsKR520eaTS3Cnh8kMl95EI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mHsc4yE66AWoqGwLyIYDx4pCZeLC6SXGuQbRNgI+rz7aPWcqtwhI7oecMFXcnlQ6J
	 +OZX5PJs285R1aaGbpxE6fQv0dgaHNMjk6aFoOXJSIT5RUI1MXAp87A4sMtndNOnkt
	 o6OJCkhyHXoGO7++jeIBiDkigElDCifTX30DaVaAMnbr9SJeYQAcRbrqy5vTRrmDZ3
	 qKV4FB3NWy3LcusQsgmS+TlfRtmwrk+4CPsyl9neqmYcrMEUupFte9ZFWL9qbQ7qOZ
	 FwfDfKNyRN2x+ZbRFJzTcjePL8Cdast4SGArGNNN9oPPACePpCce2Wes6OAySp2OX6
	 aBqMbwNEVbO2g==
Message-ID: <dbdfc894-2a63-460a-a10e-e290385ea2e6@kernel.org>
Date: Thu, 21 Nov 2024 15:08:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
To: "Anwar, Md Danish" <a0501179@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 ssantosh@kernel.org, nm@ti.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, s-anna@ti.com, kristo@kernel.org, srk@ti.com
References: <20241113110955.3876045-1-danishanwar@ti.com>
 <20241113110955.3876045-2-danishanwar@ti.com>
 <adcc5aa5-0f51-4c69-b684-a1e0844c5e3f@kernel.org>
 <6e11c85a-5883-4a28-b5bd-98da28f20425@kernel.org>
 <d738bb00-e295-4d74-8ba2-efd82b6df2ea@ti.com>
 <e633232e-f0ad-43f7-9897-39836e6b98b4@kernel.org>
 <96ea0c11-e6e7-4801-9c06-2dc80b21b1ab@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <96ea0c11-e6e7-4801-9c06-2dc80b21b1ab@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/11/2024 15:23, Anwar, Md Danish wrote:
> Hi Roger,
> 
> On 11/19/2024 4:15 PM, Roger Quadros wrote:
>>
>>
>> On 19/11/2024 08:12, Vignesh Raghavendra wrote:
>>>
>>>
>>> On 18/11/24 19:22, Roger Quadros wrote:
>>>>
>>>>
>>>> On 18/11/2024 15:33, Roger Quadros wrote:
>>>>> Hi,
>>>>>
>>>>> On 13/11/2024 13:09, MD Danish Anwar wrote:
>>>>>> The ICSSG module has 7 clocks for each instance.
>>>>>>
>>>>>> These clocks are ICSSG0_CORE_CLK, ICSSG0_IEP_CLK, ICSSG0_ICLK,
>>>>>> ICSSG0_UART_CLK, RGMII_MHZ_250_CLK, RGMII_MHZ_50_CLK and RGMII_MHZ_5_CLK
>>>>>> These clocks are described in AM64x TRM Section 6.4.3 Table 6-398.
>>>>>>
>>>>>> Add these clocks to the dt binding of ICSSG.
>>>>>>
>>>>>> Link: https://www.ti.com/lit/pdf/spruim2 (AM64x TRM)
>>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 10 ++++++++++
>>>>>>  1 file changed, 10 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>>> index 3cb1471cc6b6..927b3200e29e 100644
>>>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>>> @@ -92,6 +92,16 @@ properties:
>>>>>>      description: |
>>>>>>        This property is as per sci-pm-domain.txt.
>>>>>>  
>>>>>> +  clocks:
>>>>>> +    items:
>>>>>> +      - description: ICSSG_CORE Clock
>>>>>> +      - description: ICSSG_IEP Clock
>>>>>> +      - description: ICSSG_RGMII_MHZ_250 Clock
>>>>>> +      - description: ICSSG_RGMII_MHZ_50 Clock
>>>>>> +      - description: ICSSG_RGMII_MHZ_5 Clock
>>>>>> +      - description: ICSSG_UART Clock
>>>>>> +      - description: ICSSG_ICLK Clock
>>>>>> +
>>>>>
>>>>> There are actually many more clocks [1]
>>>>> What is the purpose of adding all these clocks in the DT if driver doesn't
>>>>> use them?
>>>>>
>>>
>>> DT should completely describe the HW and not based on what Linux driver
>>> needs. So its valid to describe all clock inputs to a module
>>> irrespective of what driver does with it.
>>
>> Fair point. But there are a total 11 clocks instead of 7 in [1]
>>
> 
> I took the list of clocks from AM64x TRM [1] Section 6.4.3 Table 6-398.
> In the TRM only 7 clocks are mentioned per ICSSG instance which I have
> mentioned in the binding.
> 
> [1] https://www.ti.com/lit/ug/spruim2h/spruim2h.pdf?ts=1732108738816

OK thanks for the clarification. It looks like the same in AM65 and J721e TRMs as well.
So it is fine.

> 
>>>
>>>>> Only CORE and IEP clocks parent can be configured via clock muxes.
>>>>> Those are already defined in the icssg?_cfg nodes.
>>>>
>>>> Actually those clock muxes are internal to ICSSG.
>>>> We still need to be able to set clock parents of CORE and IEP clock.
>>>>
>>>> So pruss block needs at most 2 clocks like you had in v2 of this patch?
>>>>
>>>>>
>>>>> [1] - https://software-dl.ti.com/tisci/esd/22_01_02/5_soc_doc/am64x/clocks.html
>>>>>
>>>>>>  patternProperties:
>>>>>>  
>>>>>>    memories@[a-f0-9]+$:
>>>>>
>>>>
>>>
>>
> 

-- 
cheers,
-roger



Return-Path: <linux-kernel+bounces-519614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBEA39F02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F231896947
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544D126A0C6;
	Tue, 18 Feb 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T0PM7SUX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892F269D1B;
	Tue, 18 Feb 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888704; cv=none; b=uYoerA+FZiJgPCmoq2ckaaR428vWXo0mqTYZfl2uj0V33utSP+PfsSReRroy7KqkU1mNt5l2TWr5QZkB0MN/7wIDyW3BumykIT5qbVfoO0WLO3EY3lNIMavyvBiY4+R1Lom6Hr+PUsEv9EnGSUgdCanr3Q9EfCHxm/0GlkV7vcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888704; c=relaxed/simple;
	bh=J2eO9J9+mwdPHssF4xChq4+/7PjWA0b/HAjHIFjPlDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgRDLrUfzXaSomwbbQy47OPql25/vfZ7jF1hS+30FnaGBdYwvAkqt1uGXOmvVtKIiaHMw4IkajlaUwpg+RrnC1YY81J0MPxCbwnA5u2dccRU6Yc3EWC/bwyLNww7kyqbZfYejxm9irRBgOWAIjpohpxvd85BFKmVi1CaojSZXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T0PM7SUX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739888700;
	bh=J2eO9J9+mwdPHssF4xChq4+/7PjWA0b/HAjHIFjPlDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T0PM7SUXm0tzDEgb3p7/B4sIX18u9xqr1zsMb31gron78SXny/pUQb6dWPugS+zHK
	 zoRxMEOJH5ELNcNoNXjLsff5yFYH9vXdMnovMKc7AMmN62b2pQNnov79IbV0FQLk3B
	 PXFsY/eKKaFsJH2puzbVSOdMjnxVVnDaIFcUftyxAvwpHK/X54+h5zn/KiNHU+9j/5
	 VucuGlCZG1/a1HhI92k+VT46yqGIAsFt0VVpaC6SkCDd4pHOvCciFMzuexi8zTfCIk
	 2vVJ3A3uIonc1hKstWUjrHX7JeMqNSLFHvAZzL7rTzLm+7LB+UPa04mp/oKg3+4mxU
	 hhbiJDpHVNpUw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 636C717E0391;
	Tue, 18 Feb 2025 15:24:59 +0100 (CET)
Message-ID: <ddd1d62e-b1d2-4271-99a3-74bb0a48fb48@collabora.com>
Date: Tue, 18 Feb 2025 15:24:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: mediatek: Add SMI LARBs reset
 for MT8188
To: =?UTF-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?R2FybWluIENoYW5nICjlvLXlrrbpipgp?= <Garmin.Chang@mediatek.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>, =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
 <Yong.Wu@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor@kernel.org" <conor@kernel.org>
References: <20250121065045.13514-1-friday.yang@mediatek.com>
 <20250121065045.13514-2-friday.yang@mediatek.com>
 <20250121-violet-widely-df3567b085a4@spud>
 <2bfb6c05a3471e54f51c06895709853661e82c9a.camel@mediatek.com>
 <20250124-aide-feisty-821cf9cf1382@spud>
 <85c616dd195da26313cab552b24f514b539193c1.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <85c616dd195da26313cab552b24f514b539193c1.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/02/25 13:44, Friday Yang (杨阳) ha scritto:
> On Fri, 2025-01-24 at 17:31 +0000, Conor Dooley wrote:
>> On Wed, Jan 22, 2025 at 07:40:12AM +0000, Friday Yang (杨阳) wrote:
>>> On Tue, 2025-01-21 at 17:30 +0000, Conor Dooley wrote:
>>>> On Tue, Jan 21, 2025 at 02:50:40PM +0800, Friday Yang wrote:
>>>>> SMI LARBs require reset functions when applying clamp
>>>>> operations.
>>>>> Add '#reset-cells' for the clock controller located in image,
>>>>> camera
>>>>> and IPE subsystems.
>>>>
>>>> A new required property is an abi break, please explain why this
>>>> is
>>>> required.
>>
>> You never answered this part. From a quick check, looks like the
>> change
>> you made will cause probe failures if the resets are not present?
>> Maybe
>> I misread the driver code in my quick skim - but that is the
>> implication
>> of a new required property, so I didn't dig super far.
>>
>> Adding new properties that break a driver is not really acceptable,
>> so I
>> hope I made a mistake there.
>>
> 
> Sorry to reply late.
> This is a known bus glitch issue. It worked because MediaTek has
> provided patches 1, 2 and 3. In other word, it can not work
> without patches 1, 2 and 3.
> 
> 1.
> https://lore.kernel.org/all/20240327055732.28198-1-yu-chang.lee@mediatek.com/
> 2.
> https://lore.kernel.org/all/20240327055732.28198-2-yu-chang.lee@mediatek.com/
> 3.
> https://lore.kernel.org/all/20240327055732.28198-3-yu-chang.lee@mediatek.com/
> 
> Patches 1, 2 and 3 have been previously reviewed, and the reviewers
> provided the following comments:
> 4.
> https://lore.kernel.org/all/CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=wXpobDWU1CnvkA@mail.gmail.com/
> 5.
> https://lore.kernel.org/all/CAPDyKFpokXV2gJDgowbixTvOH_5VL3B5H8eyhP+KJ5Fasm2rFg@mail.gmail.com/
> As I mentioned earlier, SMI clamp and reset operations should be
> implemented in SMI driver rather than the PM driver. Additionally, the
> reset operations have already been implemented in the clock control
> driver. There is no need to submit duplicate code.
> 
> To address this, I have provided patches 6, 7 to replace patches 1, 2,
> and 3, as I believe this approach aligns more closely with the
> reviewers' requirements.
> 6.
> https://lore.kernel.org/lkml/20250121065045.13514-1-friday.yang@mediatek.com/
> 7.
> https://lore.kernel.org/lkml/20250121064934.13482-1-friday.yang@mediatek.com/
> 
> What's more, I have tested the patch 6, 7 in MediaTek MT8188 SoC.
> It could work well. If you have any questions, please feel free to
> contact me.
> 
>>> What are "SMI LARBs"? Why did things previously work
>>>> without
>>>> acting as a reset controller?
>>>>
>>>
>>> The background can refer to the discussion in the following link:
>>>
>>>
> https://lore.kernel.org/all/CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=wXpobDWU1CnvkA@mail.gmail.com/
>>>
>>>
> https://lore.kernel.org/all/CAPDyKFpokXV2gJDgowbixTvOH_5VL3B5H8eyhP+KJ5Fasm2rFg@mail.gmail.com/
>>> SMI clamp and reset operations should be implemented in SMI driver
>>> instead of PM driver.
>>
>> So the answer to how it worked previously was that nothing actually
>> used
>> this multimedia interface?
>>
>> Your commit message needs to explain why a new required property is
>> okay
>> and why it was not there before.
>>

This conversation slipped through the cracks - wanted to reply to this quite a bit
of time ago but then for whatever reason .... eh here we are :-)

Anyway.

The cleanest option to get the glitching situation to get resolved is probably
exactly the one that Friday proposed with this series...

I agree that the commit needs a proper description, though, and even though the
drivers were never actually used (so it's not a huge problem - as in - no device
gets broken when this is merged), it's still an ABI breakage, and that has to be
justified with a good reason.

The good reason is that there's a hardware bug that you're trying to resolve here
and that emerged only after the initial upstreaming of this binding (do *not*
mention drivers in DT bindings, those describe the hardware, not software!), and
the only way to resolve this situation is by resetting the Local Arbiter (LARB)
of the cam/img/ipe macro-blocks.

Failing to do this, the hardware is going to be unstable during high/dynamic load
conditions.

So, just describe the problem and how you're solving it in the commit description:
that's going to be okay and justifying everything that you're doing here.

I'm sorry for chiming in that late, btw.

Cheers,
Angelo

>> Thanks,
>> Conor.
>>
>>>
>>> I previously added the SMI reset control driver. However, the
>>> reviewer's comments are correct, these functions have already
>>> been implemented in the clock control driver. There is no need
>>> to submit duplicate code.
>>>
>>>
> https://lore.kernel.org/lkml/20241120063305.8135-2-friday.yang@mediatek.com/
>>>
>>>
> https://lore.kernel.org/lkml/20241120063305.8135-3-friday.yang@mediatek.com/
>>>
>>>
>>> On the MediaTek platform, the SMI block diagram like this:
>>>
>>>                  DRAM
>>>                   |
>>>              EMI(External Memory Interface)
>>>                   |  |
>>>            MediaTek IOMMU(Input Output Memory Management Unit)
>>>                   |  |
>>>               SMI-Common(Smart Multimedia Interface Common)
>>>                   |
>>>           +----------------+------------------+
>>>           |                |                  |
>>>           |                |                  |
>>>           |                |                  |
>>>           |                |                  |
>>>           |                |                  |
>>>         larb0       SMI-Sub-Common0     SMI-Sub-Common1
>>>                     |      |     |      |             |
>>>                    larb1  larb2 larb3  larb7       larb9
>>>
>>> The SMI-Common connects with SMI LARBs and IOMMU. The maximum LARBs
>>> number that connects with a SMI-Common is 8. If the engines number
>>> is
>>> over 8, sometimes we use a SMI-Sub-Common which is nearly same with
>>> SMI-Common. It supports up to 8 input and 1 output(SMI-Common has 2
>>> output).
>>>
>>>>>
>>>>> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
>>>>> ---
>>>>>   .../bindings/clock/mediatek,mt8188-clock.yaml | 21
>>>>> +++++++++++++++++++
>>>>>   1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/clock/mediatek,mt8188-
>>>>> clock.yaml
>>>>> b/Documentation/devicetree/bindings/clock/mediatek,mt8188-
>>>>> clock.yaml
>>>>> index 860570320545..2985c8c717d7 100644
>>>>> --- a/Documentation/devicetree/bindings/clock/mediatek,mt8188-
>>>>> clock.yaml
>>>>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8188-
>>>>> clock.yaml
>>>>> @@ -57,6 +57,27 @@ required:
>>>>>     - reg
>>>>>     - '#clock-cells'
>>>>>
>>>>> +allOf:
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            enum:
>>>>> +              - mediatek,mt8188-camsys-rawa
>>>>> +              - mediatek,mt8188-camsys-rawb
>>>>> +              - mediatek,mt8188-camsys-yuva
>>>>> +              - mediatek,mt8188-camsys-yuvb
>>>>> +              - mediatek,mt8188-imgsys-wpe1
>>>>> +              - mediatek,mt8188-imgsys-wpe2
>>>>> +              - mediatek,mt8188-imgsys-wpe3
>>>>> +              - mediatek,mt8188-imgsys1-dip-nr
>>>>> +              - mediatek,mt8188-imgsys1-dip-top
>>>>> +              - mediatek,mt8188-ipesys
>>>>> +
>>>>> +    then:
>>>>> +      required:
>>>>> +        - '#reset-cells'
>>>>> +
>>>>>   additionalProperties: false
>>>>>
>>>>>   examples:
>>>>> --
>>>>> 2.46.0
>>>>>




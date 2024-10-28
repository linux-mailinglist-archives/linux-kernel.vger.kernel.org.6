Return-Path: <linux-kernel+bounces-385171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E823A9B336E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1670F1C21171
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348621DDA2F;
	Mon, 28 Oct 2024 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="psHnpBDl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FBE13D539;
	Mon, 28 Oct 2024 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125555; cv=none; b=jmK1B/Zr5xy650IClaP+Eg2uHRCKU32ONBHuMvhSDnTN5tiSXfRo6dQ2xEr9QCuAg3qC1iBFjVv1aq1h86qf5fT52gWLQ13z9TBeFcoMrGZomIU021gZupp7z7egCqaZAsPWNKxj112HbiF51NS4AICvlBF2vkKcfwf+4uedvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125555; c=relaxed/simple;
	bh=nzbeRC8p1ugu2E5p8U1ZLC9i2WJ4DpBmxiovMdzFjB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soswuaU1dR9rKKV7V5NsDihXDa6Bu51xcjbmJV+5OUcdbmjJBDpm67L/7+kcioXHSbOmJ+jksfpNud13Jgbv0ISEj0rjNXwkz7mDWTYK4mW6/Dw3/18h1aGE0Ph3MG84qP9ZoqOXadsH7ZIJov8gHe6ssb9/FftRAvrU8ktrFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=psHnpBDl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730125551;
	bh=nzbeRC8p1ugu2E5p8U1ZLC9i2WJ4DpBmxiovMdzFjB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=psHnpBDlyIoBue1qxNZAsRNdEq3/bomzXLFpsQqv596QTFtpBWUyraULO2IdN96QB
	 cCbtO1QYndaTTUmE8lIYyBkkuFT9wpBKp5LRdmqGrJCLzbC5P7701Lx2nTBxYq57NK
	 +UbFvMsaciTgHHdCMFY11UxXlG09/t8oG5WFyYfbEoBwL6g07cztXCk/WYL1AllBnp
	 NSoq6ptWRSCoSG8Q7l2MkvL17MfjaG4b8j2IDslzbVq6wYS55TARY+rpvnjuFj66aO
	 29uOmaPygiFgSw4cdh5F9zW5MXeczWQmEFCdIFniBcLsuyLOFFs27Bvg41wGh9S0S7
	 YonAhjR0T++3g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 899EB17E35FC;
	Mon, 28 Oct 2024 15:25:50 +0100 (CET)
Message-ID: <20c793fb-cfdf-4c05-a421-3eb623ff6df0@collabora.com>
Date: Mon, 28 Oct 2024 15:25:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add adsp
 and dai-link properties
To: Fei Shao <fshao@chromium.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-sound@vger.kernel.org
References: <20241025104548.1220076-1-fshao@chromium.org>
 <20241025104548.1220076-2-fshao@chromium.org>
 <5vmfh2nkxtpzt2vk4j6ghro7z5stoyvry3enzoqepg6hjxqrho@fofs5cwa2iqq>
 <CAC=S1njPjtvhsc+voNK447wbQmRiN0xVDi-jgOmba4NLRiNi0Q@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAC=S1njPjtvhsc+voNK447wbQmRiN0xVDi-jgOmba4NLRiNi0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 28/10/24 12:10, Fei Shao ha scritto:
> On Mon, Oct 28, 2024 at 4:54 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Fri, Oct 25, 2024 at 06:44:41PM +0800, Fei Shao wrote:
>>> Add "mediatek,adsp" property for the ADSP handle if ADSP is enabled on
>>> the platform.
>>
>> We see this from the diff.
>>
>>> Add "mediatek,dai-link" property for the required DAI links to configure
>>> sound card.
>>
>> We see this from the diff.
>>
>>>
>>> Both properties are commonly used in the MediaTek sound card driver.
>>
>> If they are used, why suddenly they are needed? What changed?
> 
> Nothing has changed. These should have been added altogether when the
> binding was first introduced. This patch is to fill the gaps and fix
> dtbs_check warnings, like I mentioned in the cover letter.
> I can add a line in the commit message saying it's to fix the warning
> in addition to the cover letter, if that's preferred.
> 
>>
>>>
>>> Signed-off-by: Fei Shao <fshao@chromium.org>
>>> ---
>>>
>>>   .../bindings/sound/mediatek,mt8188-mt6359.yaml         | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
>>> index f94ad0715e32..701cedfa38d2 100644
>>> --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
>>> @@ -29,6 +29,16 @@ properties:
>>>       $ref: /schemas/types.yaml#/definitions/phandle
>>>       description: The phandle of MT8188 ASoC platform.
>>>
>>> +  mediatek,adsp:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: The phandle of MT8188 ADSP platform.
>>
>> And what is the difference between ASoC and ADSP platforms? What are
>> they used for?
> 
> I'm not a MediaTek or audio folks, and I'm afraid that I'm not the
> best person to explain the details accurately in front of experts on
> the list... I know it's an audio DSP but that explains nothing.
> MediaTek didn't provide a meaningful explanation in the tree or
> commits, and I want to avoid adding additional but likely misleading
> descriptions from someone who doesn't have enough knowledge,
> potentially causing even more confusing situations in the future.
> Plus, the same changes were accepted as-is in the past, so I assumed
> they might be self-explanatory to people who are familiar with the
> matter.
> 

The Audio DSP is a Tensilica HiFi-5 DSP, and it's a block that is - hardware
speaking - separated from the rest of the Audio interfaces of the SoC.

The whole sound subsystem can work either with or without the DSP, in the sense
that the DSP itself can remain unpowered and completely unconfigured if its
functionality is not desired - hence, this is a board specific configuration:
if the board wants to use the DSP, we use the DSP - otherwise, we just don't.

Regarding the two "platforms", in short:
"mediatek,platform" -> Audio Front End (AFE)
"mediatek,adsp" -> Audio DSP

Now, you can either link the AFE DAIs to the I2S

As for "mediatek,platform" - that's used to link the Analog Front End (AFE) as
the DAI Link platform (so the path is direct to/from DL/UL DAIs to AFE) or the
ADSP one as the DAI Link platform (so that the path is to/from DL/UL DAIs to
DSP to AFE), but that - of course - still requires an AFE, otherwise you cannot
get the audio out of the speakers or in from the mic anyway.

>>
>>> +
>>> +  mediatek,dai-link:
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>> +    description:
>>> +      A list of the desired dai-links in the sound card. Each entry is a
>>> +      name defined in the machine driver.
>>
>> The list is provided below. I don't understand why do you need it. Your
>> msg is pretty useless - you describe what you do, instead of why.
> 
> I think this is used to explicitly list the intermediate but hidden
> DAIs, but again, there's not much info about them unless MediaTek can
> explain more details and why they need a vendor property for this.
> 

Yes, this is used for exactly that... but I believe that we can deprecate this
now that we have support for the "standard" `audio-routing` property and for the
DAI Link nodes (examples that you can find in current device trees are mm-dai-link,
hs-playback-dai-link, or any other subnode of the sound card).

Specifically, those subnodes *do* require a "link-name" property, which *does*
effectively contain the same DAI Link names as the ones that are inside of the
"mediatek,dai-link" property.

On MT8195, you can find both the subnodes and the mediatek,dai-link - yes - but
that was done to retain compatibility of the device tree with old drivers (so,
an unusual case of new device tree on old kernel).

Finally, I believe that we can avoid adding that "mediatek,dai-link" property
to the MT8188 binding, and rely on:
  1. Whatever is provided in struct snd_soc_card for that device; and
  2. Whatever is provided in device trees as dai link subnodes, which would
     restrict N.1 as that's anyway describing card prelinks.

Cheers,
Angelo

> Regards,
> Fei
> 
>>
>> Best regards,
>> Krzysztof
>>



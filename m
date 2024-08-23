Return-Path: <linux-kernel+bounces-298324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D0E95C5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01B52855AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C514204B;
	Fri, 23 Aug 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lj3nebQl"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B7139D1A;
	Fri, 23 Aug 2024 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395513; cv=none; b=mHZ1Zo8kQ69QRC53uZsJw1KfRnuOTrM7AYkhTDBe6XtWmDQXr8Z7XtWnJjX8BXG9+BfUyFQbSfERDZ11x0ofOQUWuOOupDG6dL8SxAsTEuApaHFGWFMiNdO7Ao7bEhjdxWBQESLWX1YZUy5+RcpqxPKjXR7wRjYzh3hNi/R5FvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395513; c=relaxed/simple;
	bh=CMj1beNB4wRUoPPJesgCwW8AV15FtFsk5vFgNkGvLFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WD6iQfTso61fI6SeIbtyJsM6c/ZykRoc+V/Qz2DHIOw5iH4TCmsyWUoHPQt3Ozo6OvqP23OVXyBKIObdSoPjxww5qHZSIDTKpu3M94t7wNXqT5Zecc8CSzf7BQeOLnXNVhORGIGSkwk+y+sy50X+wnkGg3CVvRdppAJY2CLseb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Lj3nebQl; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 38cf2cf4611b11ef8593d301e5c8a9c0-20240823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=5eHemwOI+4ZXjPX43cRCwVZx1/cN4d16XHD5Mx9w6kk=;
	b=Lj3nebQlByUc4BW1aDzyKrk0q+W+/8XCOACxLSGwiDGNV0vmwncHTyqi+r0zyKufoDT/S9on0WNqhDdaIqsrU/zAeYYuk9dRJ5qTrFSava7ibAsR4nPGJFtg/jJnGyObddZaxgEB+384lKUmxJzBPtQHruVq4EwlbjbuZTWl6ao=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:3be96aaa-c3cd-4f5f-bdd6-7ea36723ac2c,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6dc6a47,CLOUDID:eabbac14-737d-40b3-9394-11d4ad6e91a1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 38cf2cf4611b11ef8593d301e5c8a9c0-20240823
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 160440843; Fri, 23 Aug 2024 14:45:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Aug 2024 23:45:00 -0700
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 23 Aug 2024 14:44:59 +0800
Message-ID: <fb1d3c99-c524-adfa-94b7-822801b98034@mediatek.com>
Date: Fri, 23 Aug 2024 14:44:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: mfd: mediatek: mt6397: Convert to DT schema
 format
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones
	<lee@kernel.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, Jason-ch
 Chen <Jason-ch.Chen@mediatek.com>, Chris-qj chen
	<chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>, Alexandre
 Mergnat <amergnat@baylibre.com>, Chen-Yu Tsai <wenst@chromium.org>
References: <20240808105722.7222-1-macpaul.lin@mediatek.com>
 <2d89c86b-28b4-439f-824b-1d0560ff36bd@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <2d89c86b-28b4-439f-824b-1d0560ff36bd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 8/8/24 20:04, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On 08/08/2024 12:57, Macpaul Lin wrote:
>> Convert the mfd: mediatek: mt6397 binding to DT schema format.
>> 
>> New updates in this conversion:
>>  - Align generic names of DT schema "audio-codec" and "regulators".
>>  - mt6397-regulators: Replace the "txt" reference with newly added DT
>>    schema.
>> 
>> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>  .../bindings/mfd/mediatek,mt6397.yaml         | 202 ++++++++++++++++++
>>  .../devicetree/bindings/mfd/mt6397.txt        | 110 ----------
> 
> You are doing conversions in odd order... and ignore my comments. The
> example from your regulator binding is supposed to be here - I wrote it
> last time.
> 
> Due to doing changes totally unsynchronized, this CANNOT be merged
> without unnecessary maintainer coordination, because of dependency.
> 
> Sorry, that's not how it works for MFD devices.
> 
> Perform conversion of entire device in ONE patchset.

Okay, will collect the conversion of mt6323-regulator.txt and 
rtc-mt6397.txt in the next version.

>>  2 files changed, 202 insertions(+), 110 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
>> 
>> Changes for v1:
>>  - This patch depends on conversion of mediatek,mt6397-regulator.yaml
>>    [1] https://lore.kernel.org/lkml/20240807091738.18387-1-macpaul.lin@mediatek.com/T/

[snip]

>> +$id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek MT6397/MT6323 Multifunction Device
>> +
>> +maintainers:
>> +  - Sen Chu <sen.chu@mediatek.com>
>> +  - Macpaul Lin <macpaul.lin@mediatek.com>
>> +
>> +description: |
>> +  MT6397/MT6323 is a multifunction device with the following sub modules:
> 
> MFD is Linuxism, avoid it.

Will replace MFD with "power management system chip with sub-modules" 
something like this in next version.

>> +  - Regulator
>> +  - RTC
>> +  - Audio codec
>> +  - GPIO
>> +  - Clock
>> +  - LED
>> +  - Keys
>> +  - Power controller
>> +
>> +  It is interfaced to host controller using SPI interface by a proprietary hardware
>> +  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
>> +  See the following for pwarp node definitions:
>> +  ../soc/mediatek/mediatek,pwrap.yaml
> 
> Drop, instead add proper ref or compatible in parent node.

I'm confused here. I've checked mediatek,mt6357.yaml as a reference
.
It uses the similar method here.
     "See the following for pwarp node definitions:"
     "Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml"

If "$ref: /schemas/soc/mediatek/mediatek,pwrap.yaml" is added here,
dt_bindings_check will complain the following errors and more.

Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: pmic: 
compatible: 'oneOf' conditional failed, one must be fixed:
         ['mediatek,mt6397'] is too short
         'mediatek,mt6397' is not one of ['mediatek,mt2701-pwrap', 
'mediatek,mt6765-pwrap', 'mediatek,mt6779-pwrap', 
'mediatek,mt6795-pwrap', 'mediatek,mt6797-pwrap', 
'mediatek,mt6873-pwrap', 'mediatek,mt7622-pwrap', 
'mediatek,mt8135-pwrap', 'mediatek,mt8173-pwrap', 
'mediatek,mt8183-pwrap', 'mediatek,mt8186-pwrap', 
'mediatek,mt8195-pwrap', 'mediatek,mt8365-pwrap', 'mediatek,mt8516-pwrap']
         'mediatek,mt6397' is not one of ['mediatek,mt8186-pwrap', 
'mediatek,mt8195-pwrap']
         'mediatek,mt6397' is not one of ['mediatek,mt8188-pwrap']
         from schema $id: 
http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#

Which also conflicts with the comments in the examples..
 >> +    pwrap {
 >
 > Drop

Please help to check if a $ref or a compatible of pwrap should be added 
here.

>> +
>> +  This document describes the binding for MFD device and its sub module.
> 
> Drop

Will fix it in next version.

>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - mediatek,mt6323
>> +          - mediatek,mt6331 # "mediatek,mt6331" for PMIC MT6331 and MT6332.
>> +          - mediatek,mt6357
>> +          - mediatek,mt6358
>> +          - mediatek,mt6359
>> +          - mediatek,mt6397
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt6366 # "mediatek,mt6366", "mediatek,mt6358" for PMIC MT6366
> 
> Drop comment, it is obvious. Don't repeat constraints in free form text.

Will fix it in next version.

> 
>> +          - const: mediatek,mt6358
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  "#interrupt-cells":
>> +    const: 2
>> +
>> +  rtc:
>> +    type: object
>> +    unevaluatedProperties: false
>> +    description:
>> +      Real Time Clock (RTC)
>> +      See ../rtc/rtc-mt6397.txt
> 
> No, convert the binding.

Will convert it rtc-mt6397.txt and put it into
"mfd/mediatek,mt6397.yaml" together.

> 
>> +    properties:
>> +      compatible:
>> +        oneOf:
>> +          - enum:
>> +              - mediatek,mt6323-rtc
>> +              - mediatek,mt6331-rtc
>> +              - mediatek,mt6358-rtc
>> +              - mediatek,mt6397-rtc
>> +          - items:
>> +              - enum:
>> +                  - mediatek,mt6366-rtc # RTC MT6366
> 
> Drop all such comments.
> 
>> +              - const: mediatek,mt6358-rtc
>> +
>> +  regulators:
>> +    type: object
>> +    oneOf:
>> +      - $ref: /schemas/regulator/mediatek,mt6358-regulator.yaml
>> +      - $ref: /schemas/regulator/mediatek,mt6397-regulator.yaml
> 
> And how is it supposed to be tested?

The dt_bindings_check didn't complain eny thing about these.
Of course I've included the conversion patch of 
mediatek,mt6397-regulator.yaml.

>> +    unevaluatedProperties: false
>> +    description:
>> +      Regulators
>> +      For mt6323, see ../regulator/mt6323-regulator.txt
> 
> Drop, useless.
Should I convert it to DT schema and add to $ref above together?

> 
>> +    properties:
>> +      compatible:
>> +        oneOf:
>> +          - enum:
>> +              - mediatek,mt6323-regulator
>> +              - mediatek,mt6358-regulator
>> +              - mediatek,mt6397-regulator
>> +          - items:
>> +              - enum:
>> +                  - mediatek,mt6366-regulator # Regulator MT6366
>> +              - const: mediatek,mt6358-regulator
>> +
>> +  audio-codec:
>> +    type: object
>> +    unevaluatedProperties: false
> 
> This does not make sense. You do not have any ref here.

The dt_bindings_check will complain error here.
Will replace it with "additionalProperties: false".


>> +    description:
>> +      Audio codec
>> +    properties:
>> +      compatible:
>> +        oneOf:
>> +          - enum:
>> +              - mediatek,mt6397-codec
>> +              - mediatek,mt6358-sound
>> +          - items:
>> +              - enum:
>> +                  - mediatek,mt6366-sound # Codec MT6366
>> +              - const: mediatek,mt6358-sound
> 
> This wasn't in the old binding. Commit msg also does not explain why you
> are doing changes from conversion.

Will update new added item into commit message in next version.

>> +
>> +  clk:
>> +    type: object
>> +    unevaluatedProperties: false
> 
> Again, no, it does not work like this. See example schema for
> explanation of this.

Will replace it with "additionalProperties: false".

> Convert all children - entire device. Then either use ref or
> additionalProperties: true. See Qualcomm mdss bindings for example.

There is no more children available for the clock node of this PMIC.
This is a clock buffer node. However, there are no sub nodes or any
public document explain these clock buffer in public domain.
What I've got is the compatible string in the driver.

>> +    description:
>> +      Clock
> 
> Your descriptions are useless. You just said "clk" node is "clock". Really?

Will improve it in next version.

>> +    properties:
>> +      compatible:
>> +        const: mediatek,mt6397-clk
>> +
>> +  led:
>> +    type: object
>> +    unevaluatedProperties: false
>> +    description:
>> +      LED
>> +      See ../leds/leds-mt6323.txt for more information
> 
> No

Will convert "leds-mt6323.txt" and move it together with 
"mfd/mediatek,mt6397.yaml"

>> +    properties:
>> +      compatible:
>> +        const: mediatek,mt6323-led
>> +
>> +  keys:
>> +    type: object
>> +    $ref: /schemas/input/mediatek,pmic-keys.yaml
>> +    unevaluatedProperties: false
>> +    description: Keys
> 
> Keys are keys? Could keys be anything else?

Will fix it in the next version.

>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    pwrap {
> 
> Drop

Will fix it in the next version.

>> +        pmic {
>> +            compatible = "mediatek,mt6397";
>> +            interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +
>> +            mt6397_codec: audio-codec {
>> +                compatible = "mediatek,mt6397-codec";
>> +            };
>> +
>> +            mt6397_regulators: regulators {
>> +                compatible = "mediatek,mt6397-regulator";
>> +
>> +                mt6397_vpca15_reg: buck_vpca15 {
>> +                    regulator-name = "vpca15";
>> +                    regulator-min-microvolt = <850000>;
>> +                    regulator-max-microvolt = <1400000>;
>> +                    regulator-ramp-delay = <12500>;
>> +                    regulator-always-on;
>> +                };
>> +
>> +                mt6397_vgp4_reg: ldo_vgp4 {
>> +                    regulator-name = "vgp4";
>> +                    regulator-min-microvolt = <1200000>;
>> +                    regulator-max-microvolt = <3300000>;
>> +                    regulator-enable-ramp-delay = <218>;
>> +                };
>> +            };
> 
> Incomplete.
> 
> The parent device example is supposed to be 100% complete.

Will complete the example with MT6397 and MT6323 as reference in the 
next version.

> Best regards,
> Krzysztof

Thanks for the review and still some questions listed above.
Please help to clarify the correction method for the questions.

Best regards,
Macpaul Lin



Return-Path: <linux-kernel+bounces-364561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC399D624
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C74E283530
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CEF1C82E2;
	Mon, 14 Oct 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDIuK8XU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9101B4F2A;
	Mon, 14 Oct 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929302; cv=none; b=eUyTGA/ZWsDLs5MqBvaNjXMWoEPmqPYK2vRlVjI85nEZe+m+butz3hKzFVbkvaKYplmfalrf85N3P73saP7M6pzoGOuW6tQu6LU+NstDqUmk+SNkBRj/4iYu9Aq9qYyBJXok35jq/5b8RDpsNkRmATVrtz6VwFaguMSs3UIHEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929302; c=relaxed/simple;
	bh=89RXUbw94+itBiGwoDiSPK0QbKcmSjywB23uPuz+WWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOljmn2mJ/u4nqmeCRbxy/V28M+RzJwVK2j8ElqnTc9tT+IH0cTcy79RtNIMlNyQHrmdvHt2rWCdyBhmHsnmUnX8cdT6jrUvneWac/y7o+L0SabQMyXd/mo/58cwrKXd7JgEAyoRRDzhXCe+T7mhzapRWr8qAtwx4uSKs3k7CQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDIuK8XU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BAAC4CEC3;
	Mon, 14 Oct 2024 18:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728929301;
	bh=89RXUbw94+itBiGwoDiSPK0QbKcmSjywB23uPuz+WWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PDIuK8XUy+k/pz1Yo6bjfCsIGJax61feiTXb77kidj8/BleKEXxSpGvou835mK3jT
	 Nyg8bkhQE4gcl7Pf9yN2y+3QP7ZNLcaOhRZPUSk7ghhmmn/bzmLhPby/NKMFXcbJIt
	 WmZaM3YMJbCOlmhh+jEDQVHurI0/TGT/+geJEoQEw79kdI6loJh9n7e4R4uD25ewfe
	 Yr5P7TlOJ1SENUs8G5ccap7DT0wJC4rpIh4bSlTX9RZ5adUkTh5fBH+ENnXAciiaFP
	 PierN5SNeY6A7fYKurTu+H+DlBo/VY/mqaT5GpkBy0KGjH4/YqTR1BDRMOW73J5D9d
	 gDpFl4OgR6Srg==
Message-ID: <10a0efab-83a8-4168-993a-c4482a568c96@kernel.org>
Date: Mon, 14 Oct 2024 20:08:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] dt-bindings: mtd: davinci: convert to yaml
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241008-ondie-v5-0-041ca4ccc5ee@gmail.com>
 <20241008-ondie-v5-2-041ca4ccc5ee@gmail.com>
 <4u5iv24enpz46funfvbo2aggx6yiqxy7beaa3ldt5ai5wf65kl@bnlm4eyuwkui>
 <Zw0Ixx9Qu9tgGXGP@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Zw0Ixx9Qu9tgGXGP@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 14:04, Marcus Folkesson wrote:
> 
> Krzysztof,
> 
> I'm sorry for all these iterations, it wouldn't have been necessary if I had
> done my homework better. I'm not too familiar with writing these and I do
> often find the descriptions unclear and not obvious.
> Anyway, thank you for your patience, reviews and help.
> 
> 
> On Tue, Oct 08, 2024 at 03:28:33PM +0200, Krzysztof Kozlowski wrote:
>> On Tue, Oct 08, 2024 at 09:02:45AM +0200, Marcus Folkesson wrote:
>>> Convert the bindings to yaml format.
>>>
>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>> ---
>>>  .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -----------------
>>>  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 115 +++++++++++++++++++++
>>>  2 files changed, 115 insertions(+), 94 deletions(-)
>>>
>>
>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..1263616593532e8483d556b4242b004a16620ddf
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
>>> @@ -0,0 +1,115 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TI DaVinci NAND controller
>>> +
>>> +maintainers:
>>> +  - Marcus Folkesson <marcus.folkesson@gmail.com>
>>> +
>>> +allOf:
>>> +  - $ref: nand-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,davinci-nand
>>> +      - ti,keystone-nand
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>
>> This was different in original binding and commit msg does not explain
>> changes.  Be sure any change from pure conversion is explained in the
>> commit msg.
> 
> Hm. Another misinterpretation from my side.
> Should I use items instead? E.g.
> 
>   reg:
>     items:
>       - description: |
>         Contains 2 offset/length values:
>         - offset and length for the access window.
>         - offset and length for accessing the AEMIF
>         control registers.

You need to list two items, so two times "- description:"
(and drop redundant parts like "offset and length" because this cannot
be anything else)

and this should be pointed out by testing, so open the example and try
to explain why it is so different than expected.


Unless, it is supposed to be one item... but how do I know? You are
looking at the device and its driver, not  me.

> 
>>
>>> +
>>> +  partitions:
>>> +    $ref: /schemas/mtd/partitions/partitions.yaml
>>> +
>>> +  ti,davinci-chipselect:
>>> +    description:
>>> +      Number of chipselect. Indicate on the davinci_nand driver which
>>> +      chipselect is used for accessing the nand.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1, 2, 3]
>>> +
>>> +  ti,davinci-mask-ale:
>>> +    description:
>>> +      Mask for ALE. Needed for executing address phase. These offset will be
>>> +      added to the base address for the chip select space the NAND Flash
>>> +      device is connected to.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    default: 0x08
>>> +
>>> +  ti,davinci-mask-cle:
>>> +    description:
>>> +      Mask for CLE. Needed for executing command phase. These offset will be
>>> +      added to the base address for the chip select space the NAND Flash device
>>> +      is connected to.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    default: 0x10
>>> +
>>> +  ti,davinci-mask-chipsel:
>>> +    description:
>>> +      Mask for chipselect address. Needed to mask addresses for given
>>> +      chipselect.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    default: 0
>>> +
>>> +  ti,davinci-ecc-bits:
>>> +    description: Used ECC bits.
>>> +    enum: [1, 4]
>>> +
>>> +  ti,davinci-ecc-mode:
>>> +    description: Operation mode of the NAND ECC mode.
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    enum: [none, soft, hw, on-die]
>>> +    deprecated: true
>>> +
>>> +  ti,davinci-nand-buswidth:
>>> +    description: Bus width to the NAND chip
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [8, 16]
>>> +    default: 8
>>> +    deprecated: true
>>> +
>>> +  ti,davinci-nand-use-bbt:
>>> +    type: boolean
>>> +    description:
>>> +      Use flash based bad block table support. OOB identifier is saved in OOB
>>> +      area.
>>> +    deprecated: true
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - ti,davinci-chipselect
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    nand-controller@2000000 {
>>> +      compatible = "ti,davinci-nand";
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>
>> I did not notice it last time.... but what is this? How could you have
>> no sizes?
>>
>>> +
>>> +      reg = <0 0x02000000>;
>>
>> This is odd. Address is not 0... and size should be 0.
>>
>> I don't get how it even works. For sure it is not correct.
> 
> Outch. It slipped through when I was laborating.
> 
> This was the example I wanted to get working:
> 
> 
> ```
> examples:
>   - |
>     nand-controller@2000000,0 {
>       compatible = "ti,davinci-nand";
>       #address-cells = <1>;
>       #size-cells = <1>;
>       reg = <0 0x02000000 0x02000000
>       1 0x00000000 0x00008000>;

But that's not what is being used. Open the DTS and look how it is
encoded there. You have unnecessary 64-bit addressing here, plus you
still have technically one item, not two. Maybe existing DTS uses it,
then it's fine, but then take DTS (and correct it if it does not define
proper tuples/items).

> 
>       ti,davinci-chipselect = <1>;
>       ti,davinci-mask-ale = <0>;
>       ti,davinci-mask-cle = <0>;
>       ti,davinci-mask-chipsel = <0>;
> 
>       ti,davinci-nand-buswidth = <16>;
>       ti,davinci-ecc-mode = "hw";
>       ti,davinci-ecc-bits = <4>;
>       ti,davinci-nand-use-bbt;
> 
>       partitions {
>         compatible = "fixed-partitions";
>         #address-cells = <1>;
>         #size-cells = <1>;
> 
>         partition@0 {
>           label = "u-boot env";
>           reg = <0 0x020000>;
>         };
>       };
>     };
> ```
> 
> 
> But I'm getting the following errors:
> 
> ```
> .../ti,davinci-nand.example.dtb: nand-controller@2000000,0: #size-cells: 0 was expected
>         from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
> .../ti,davinci-nand.example.dtb: nand-controller@2000000,0: reg: [[0, 33554432], [33554432, 1], [0, 32768]] is too long
>         from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
> .../ti,davinci-nand.example.dtb: nand-controller@2000000,0: Unevaluated properties are not allowed ('reg' was unexpected)
>         from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
> ```

Well, obviously. That's the point of the schema. The example part is
embedded in node with some address/size cells, which might fit your case
or might not.

> 
> The resuling 'ti,davinci-nand.example.dts' contains the following:
> 
> ```
>     example-0 {
>         #address-cells = <1>;
>         #size-cells = <1>;
> 
>         nand-controller@2000000,0 {
>           compatible = "ti,davinci-nand";
>           #address-cells = <1>;
>           #size-cells = <1>;
>           reg = <0 0x02000000 0x02000000
>           1 0x00000000 0x00008000>;
> ```
>         
> 
> How do I set #address-cells in example-0 to 2?
> I guess that is the problem.



You just set it... There are dozens/hundreds of schemas doing it, what
is exactly a problem here?

Best regards,
Krzysztof



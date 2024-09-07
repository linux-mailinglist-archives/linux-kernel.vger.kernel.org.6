Return-Path: <linux-kernel+bounces-319797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D17970254
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 15:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B511F22B42
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F07F15C137;
	Sat,  7 Sep 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORXKqv2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE015ADA7;
	Sat,  7 Sep 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725714781; cv=none; b=WprcGh/87Xm9Osyi7Ycwef2ibefU6N+bqOPFi4HxVeFucZP6ErsBmx7UUXLYW8d/k4b4W01EaAV+4ZP/Zx1G6QOMRIdhzC70tRikt2WboIbavvCz2OgChPwamCAV/vTqyuSBbRYrcJwHeQLv20A6VxfJLcxXwCsrKhqQn9Nv3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725714781; c=relaxed/simple;
	bh=5xcVFcC3lSy5078QzRE82HrNFUD+O2QbexTWLvWcD9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuLnUUELbxLAXfvJwqvlw+i8zlmS+M0YmfO1Xk3WQ3WBRzaskdR3J49Kb7PjaQWeVgTIv+92cWf/Rm11ru50fXmTA1weIEQN45B61zCu/7FvU3vaMgv7uLEBTdAF+vX+bn2H70BiyBuzVhUMjYkd5r1zTtK5n0J+YLF2X4GrtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORXKqv2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DB4C4CEC2;
	Sat,  7 Sep 2024 13:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725714781;
	bh=5xcVFcC3lSy5078QzRE82HrNFUD+O2QbexTWLvWcD9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ORXKqv2wNTUxArmAh0ldnGJjCkLb7QzNweO0N/OmbsskJIQyydxv5F3okI9Nw1UEi
	 om+AFyNAV2yE/QBbSYxt3jHZU+Ry+BxYFi832H+JkmA53IHOQc07wS7tItmiWvgK4d
	 BbkWS8z6u7MYuh0VVRywAXVtoMuTrspo3zOyO+Jpb9P/6ToLLizr0Y2lCMAysAAT3t
	 wD/rB/rgrQxw01qaLVwhSZMJF+06fUlONvDypybm52KglqW3R4As5Qddrg2Rd1jZtg
	 kLNfs7pu9HuDwnVvMDmsPZWcRTN59iHSdGcHfF2D86JYY8IiK+xD09brtacOqAKdkD
	 Rhfyzm9OK9POg==
Message-ID: <6bfc4c47-e29d-4141-8ba9-c5b0803ab756@kernel.org>
Date: Sat, 7 Sep 2024 15:12:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] dt-bindings: memory-controllers: fsl,ifc: add
 compatible string fsl,ifc-nand
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "open list:MEMORY CONTROLLER DRIVERS" <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, imx@lists.linux.dev
References: <20240830191144.1375849-1-Frank.Li@nxp.com>
 <l2xjrs7txycf3uhhhyzypfzoem2fr4fsvbyg3bt4ktfpbzxz47@loiytha55oml>
 <ZtX8k7UB/Txri5HF@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZtX8k7UB/Txri5HF@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 19:57, Frank Li wrote:
> On Mon, Sep 02, 2024 at 09:11:05AM +0200, Krzysztof Kozlowski wrote:
>> On Fri, Aug 30, 2024 at 03:11:43PM -0400, Frank Li wrote:
>>> ifc can connect nor, nand and fpag. Add child node "nand@" under fsl,ifc
>>> and compatible string "fsl,ifc-nand" when ifc connect to nand flash.
>>>
>>> Fix below warning:
>>> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
>>> 	failed to match any schema with compatible: ['fsl,ifc-nand']
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>> Change from v2 to v3
>>> - add partition child node for nand
>>> - Only partition property is used at ppc
>>> Change from v1 to v2
>>> - add address-cells and size-cells
>>> ---
>>>  .../memory-controllers/fsl/fsl,ifc.yaml       | 26 +++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
>>> index d1c3421bee107..5a11224da8914 100644
>>> --- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
>>> @@ -58,6 +58,32 @@ properties:
>>>        access window as configured.
>>>
>>>  patternProperties:
>>> +  "^nand@[a-f0-9]+(,[a-f0-9]+)+$":
>>> +    type: object
>>> +    properties:
>>> +      compatible:
>>> +        const: fsl,ifc-nand
>>> +
>>> +      reg:
>>> +        maxItems: 1
>>> +
>>> +      "#address-cells":
>>> +        const: 1
>>> +
>>> +      "#size-cells":
>>> +        const: 1
>>> +
>>> +    patternProperties:
>>> +      "^partition@[0-9a-f]+":
>>> +        $ref: /schemas/mtd/partitions/partition.yaml#
>>> +        deprecated: true
>>> +
>>> +    required:
>>> +      - compatible
>>> +      - reg
>>> +
>>> +    additionalProperties: false
>>> +
>>>    "^.*@[a-f0-9]+(,[a-f0-9]+)+$":
>>
>> This pattern is for NAND already. I don't understand why you are
>> duplicating it. If this part does not work, fix it.
> 
> It is old binding. It did not require compatible string. It should split
> into nand\flash\fpga ...
> 
> The difference part require difference compatible string. NAND is only
> 1st step to improve it.

I understand. I would prefer to make it complete, which you are quite
close to it. Just change the remaining pattern for example:

(flash|fpga)......:
  type: object
  oneOf:
    - $ref: /schemas/board/fsl,fpga-qixis.yaml#
    - $ref: /schemas/mtd/mtd-physmap.yaml#
  unevaluatedProperties: false

or something similar.


Best regards,
Krzysztof



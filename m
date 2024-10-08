Return-Path: <linux-kernel+bounces-355418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50019951FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75D51C24A34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575041E0DA8;
	Tue,  8 Oct 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmxSa4+b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900361E0088;
	Tue,  8 Oct 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398216; cv=none; b=PvB+KG07dcb+vS0XHk6T3Ih4gML31ag99hc4fosfh2dapqF8vOgw0557K3rOig7JXW5KkElL0Mwcjnvasg+7MohEvgUz6TuDSNBnbykgXmAYrLSPFhgCXNAylFnrgjf9PjG2XRWGPVRNhqN2WNgJHYZMLXt8ljysQV7WjGrQW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398216; c=relaxed/simple;
	bh=oYAO6+RnfqjPS2tYqJIFO8e6XQXrhYZz+XrfGjL0Ufc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cw1gcLPUpmWI8K7kbEDAn9KK8EFAaiEHOZoSvhcIUnMHTpBlkWYjtxvIJyb5NL5Kc5dSGP4fzANrhSNnf0jpG44q0MihomBmzLzwDYpistaOrA+521fuuP0UCIaEQmTiMhdLpUVCv43PUhzliWdXz0bobGK/K9yGOms9k3Gwew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmxSa4+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F88C4CEC7;
	Tue,  8 Oct 2024 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728398216;
	bh=oYAO6+RnfqjPS2tYqJIFO8e6XQXrhYZz+XrfGjL0Ufc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EmxSa4+byuIFypF0CQ4LUE2nJ4QP+VhgDuYtB2KguvnZjhi5nEODDMa+ZWt+LqzwU
	 jL8AoUBr3kyOMzjDzTj5sPXahJJKFawG9HqplnI2SIpN72E2A+/kiium2dbKoWyIB3
	 tf7rV0I+xH7QRIg/Lf4ee3TCHkFTziDgAnw9Z3oxy5gd1zb+YW6cRJ7Jzc+jxsx9Ui
	 khA5rzwKiHNtWx3eD7BwlYkwogY+4PRoTcrILH7ALP5gYdQvRgeqKQeWMNegVKgumx
	 syOUqioLSNd9y+NwOfAkDQkco1/wxdRFB9nXE0bWTj1EdkH6vTBi2JOWYGkX/ftZqH
	 hzSLLXbMmV7bg==
Message-ID: <3a45f6c8-bf2f-4227-b03a-4cf07a43b8a3@kernel.org>
Date: Tue, 8 Oct 2024 16:36:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
To: Frank Wang <frawang.cn@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com, frank.wang@rock-chips.com
References: <20240929061025.3704-1-frawang.cn@gmail.com>
 <20240929061025.3704-2-frawang.cn@gmail.com>
 <4czjtesext2ulsmcym2cpjavni7zuve2sdgyiqxkjkaxrl2gpf@7nqylzgd5f55>
 <b3046637-7a35-49ef-a2b4-2f44355980a7@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <b3046637-7a35-49ef-a2b4-2f44355980a7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2024 05:04, Frank Wang wrote:
> Hi Krzysztof,
> 
> On 2024/9/30 3:36, Krzysztof Kozlowski wrote:
>> On Sun, Sep 29, 2024 at 02:10:24PM +0800, Frank Wang wrote:
>>> From: Frank Wang <frank.wang@rock-chips.com>
>>>
>>> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
>>>
>>> This change also refactor the clocks list as there are new clocks
>>> adding used for the USB MMU in RK3576 SoC.
>>>
>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>> ---
>>> Changelog:
>>> v4:
>>>   - refactor the clocks list used if:then:
>>>
>>> v3:
>>>   - narrowed rk3576 clocks by compatible property.
>>>
>>> v2:
>>>   - Categorize clock names by oneOf keyword.
>>>
>>> v1:
>>>   - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/
>>>
>>>   .../bindings/phy/rockchip,inno-usb2phy.yaml   | 46 ++++++++++++++++++-
>>>   1 file changed, 44 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>>> index 5254413137c6..fc2c03d01a20 100644
>>> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>>> @@ -20,6 +20,7 @@ properties:
>>>         - rockchip,rk3366-usb2phy
>>>         - rockchip,rk3399-usb2phy
>>>         - rockchip,rk3568-usb2phy
>>> +      - rockchip,rk3576-usb2phy
>>>         - rockchip,rk3588-usb2phy
>>>         - rockchip,rv1108-usb2phy
>>>   
>>> @@ -34,10 +35,12 @@ properties:
>>>       const: 0
>>>   
>>>     clocks:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 3
>>>   
>>>     clock-names:
>>> -    const: phyclk
>>> +    minItems: 1
>>> +    maxItems: 3
>>>   
>>>     assigned-clocks:
>>>       description:
>>> @@ -172,6 +175,45 @@ allOf:
>>>               - interrupts
>>>               - interrupt-names
>>>   
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - rockchip,px30-usb2phy
>>> +              - rockchip,rk3128-usb2phy
>>> +              - rockchip,rk3228-usb2phy
>>> +              - rockchip,rk3308-usb2phy
>>> +              - rockchip,rk3328-usb2phy
>>> +              - rockchip,rk3366-usb2phy
>>> +              - rockchip,rk3399-usb2phy
>>> +              - rockchip,rk3568-usb2phy
>>> +              - rockchip,rk3588-usb2phy
>>> +              - rockchip,rv1108-usb2phy
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          maxItems: 1
>>> +        clock-names:
>>> +          const: phyclk
>> maxItems: 1 instead
> 
> Sorry for late reply.
> 
> Do you mean use "maxItems: 1" instead of "const: phyclk" ?
> 
> 
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - rockchip,rk3576-usb2phy
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 3
>>> +          maxItems: 3
>>> +        clock-names:
>>> +          items:
>>> +            - const: phyclk
>>> +            - const: aclk
>>> +            - const: aclk_slv
>> This list goes to the top property with minItems: 1. Here you have only
>> minItems: 3.
>>
>> This way you have only one definition of entire list with same order of
>> items between variants.
> 
> For rockchip,rk3576-usb2phy, three clocks are all required, and the 
> driver does not care about the order of the clocks.
> 
> So is the above definition correct?

Of course not. What I wrote is correct.

Best regards,
Krzysztof



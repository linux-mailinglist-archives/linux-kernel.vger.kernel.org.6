Return-Path: <linux-kernel+bounces-338118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FB98538B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468FD281CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F18A156237;
	Wed, 25 Sep 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRNNU2lZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A7126F0A;
	Wed, 25 Sep 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248647; cv=none; b=B5QUIbW81LX2a3DNxvMQLWCclcRIucsHX8XiIw2c1N4SwG8NLyDHJ1vbOTMzTdlq0pWugLeLynCFo4BV8F4BtwwZYdas5VCxwCbXQCQ4Yb1Pk/43CxbRqFbKGB2nex69mnOl5iWRAfgof7X9dpSV3gTZoxJxILhXioKO1whUK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248647; c=relaxed/simple;
	bh=Akfo8Gddw9SK+w9XsX7ow8HzfXmSzAecBPPLdWBJbsU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EUR3Pc5m4M6lG89pnk2iqd7HSwOKmu3JSEVRnHQWZHGcpS65qc7CE/ZHWE5p4aN/ESghMkLBH4FCmhejy0dKV95HOfjCUqt/cg9JS+LjdkkkSVA2Zb7v40OOCo7+EnO8FoNLebl6qRlXk17P3J5jxpxrk5Ftj5AYw49UAIMcqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRNNU2lZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785B6C4CEC3;
	Wed, 25 Sep 2024 07:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727248646;
	bh=Akfo8Gddw9SK+w9XsX7ow8HzfXmSzAecBPPLdWBJbsU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=PRNNU2lZby/NT/m3KYScSfzsNzgQ/A0vRf45kpPilzJHDmV5hb1Xsatm54qiPnpyg
	 jW3GrgMDCRmpg4IKrJz5aCZRWNNWEs2DRvFHb58hSI8yOR02p8lFOO8HgOi89ceVIq
	 vY/XUAEEQCe8aaV+BXJpufPJOE9hLmGqAziy9hnRqdFyciOsuITvByl0xXsQKL3EvG
	 6+gU5uN1uMOaVkYu/xN//2dVVljqe50+yogovWBlEN8wiNY5IfJzFhIf3qGxK3yrcW
	 VNnMwL+PQu83f6kFxctMuPhAhSVRbhaaFLQxE7yq5gqvoaFxYtIXvB2k7lljPYCAFo
	 ToXELRQC8FWSg==
Message-ID: <99409dd6-f474-432e-a8fc-687993ebf942@kernel.org>
Date: Wed, 25 Sep 2024 09:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wang <frank.wang@rock-chips.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com, wmc@rock-chips.com
References: <20240923025326.10467-1-frank.wang@rock-chips.com>
 <snccizbw6thn3lhwad4xppp7vqii4p56ttl2gufwc3ke7vfckf@e4b7nvwwtdfr>
 <1f996322-e6f6-4dd5-a1d7-c2bde92c876b@rock-chips.com>
 <e77cab18-155a-4174-bca0-5ff1ce1d2b6f@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <e77cab18-155a-4174-bca0-5ff1ce1d2b6f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/09/2024 09:56, Krzysztof Kozlowski wrote:
> On 24/09/2024 04:24, Frank Wang wrote:
>> Hi Krzysztof,
>> On 2024/9/23 17:31, Krzysztof Kozlowski wrote:
>>> On Mon, Sep 23, 2024 at 10:53:25AM +0800, Frank Wang wrote:
>>>> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
>>>>
>>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>>> ---
>>>>   .../devicetree/bindings/phy/rockchip,inno-usb2phy.yaml | 10 +++++++++-
>>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>>>> index 5254413137c64..214917e55c0b6 100644
>>>> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>>>> @@ -20,6 +20,7 @@ properties:
>>>>         - rockchip,rk3366-usb2phy
>>>>         - rockchip,rk3399-usb2phy
>>>>         - rockchip,rk3568-usb2phy
>>>> +      - rockchip,rk3576-usb2phy
>>>>         - rockchip,rk3588-usb2phy
>>>>         - rockchip,rv1108-usb2phy
>>>>   
>>>> @@ -34,10 +35,16 @@ properties:
>>>>       const: 0
>>>>   
>>>>     clocks:
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>> +    items:
>>>> +      - description: phyclk - PHY input reference clocks.
>>>> +      - description: aclk and aclk_slv are optional and used for USB MMU.
>>>>   
>>>>     clock-names:
>>>> +    minItems: 1
>>>>       const: phyclk
>>>> +    const: aclk
>>>> +    const: aclk_slv
>>> Please test... Not sure what you wanted to achieve here, but maybe
>>> oneOf?
>>
>> The "aclk" and "aclk_slv" clocks are new in RK3576, you mean the changes 
>> should be like the below?
>>
>> @@ -34,10 +35,20 @@ properties:
>>       const: 0
>>
>>     clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 3
>>
>>     clock-names:
>> -    const: phyclk
>> +    minItems: 1
>> +    maxItems: 3
>> +    items:
>> +      oneOf:
>> +        - description: PHY input reference clocks.
>> +          const: phyclk
>> +        - description: aclk for USB MMU.
>> +          const: aclk
>> +        - description: aclk_slv for USB MMU.
>> +          const: aclk_slv
> 
> Nope, you just messed the order. Order is strict.

And you still sent v2 with this messed order. No. Order must be strict.
Cannot be oneOf.

Best regards,
Krzysztof



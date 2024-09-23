Return-Path: <linux-kernel+bounces-336041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EECD97EE67
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036DAB2151D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A06719CC23;
	Mon, 23 Sep 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHJ5hmH9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4F198E6D;
	Mon, 23 Sep 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106165; cv=none; b=fWk6fUqpGrzRpM1rb2SqJN2rlMKIFKY5vshXi/euyXX7tyk5rrGfu0c/zKXPELvKaegbKiEL9+8TTWK/5rzmmaduv1xHl/tkEGa1OhXa4/BWZMmCUVsjKNtwTloqZxGSTYgWzmzTe9pZTDHt6mBqj4gO0zLfL+7VpJwTMLjVl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106165; c=relaxed/simple;
	bh=t+7IuhRWDk00ypz8u+yjo2secAHWniKaBdDHZARt9tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuLL+OyJ0y6o56h2ggf/IJWtpOHVMLTabtde9vipnZlkD/8lEuM2TJoIY7gx4nNkrVPPJJEX7Yxf7IylZ7wyix7JMNhkKDfqQnEzznHc0mwS6u4CqUqkVR1p8G25NzzHl/AWCHdP5Wq2mZMMI4Qt8vuzGK66LVMzTzX8YMK7SnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHJ5hmH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDC1C4CECD;
	Mon, 23 Sep 2024 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727106164;
	bh=t+7IuhRWDk00ypz8u+yjo2secAHWniKaBdDHZARt9tA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WHJ5hmH94HVxC4aUwyQRiop8ww28DHccAf38Cq1/iEbz1FzJ0JHWLaswf2xZq4zLW
	 T8UiG+jzhMWRYZO49iFmGMLQ8Fe2xUQ/Nm4baHZVGPMWjGohXeAHUoZGyFGaowOrNp
	 NIAvNt1tO5ymeQpYXTNTYCFY42ug8K01VeUiQRE8u/JdAVc/gl9zVCpIIxbiN/Q/gm
	 zmnZaCNa+xePHji2SnH5uzkW3ytBjdtqARK+Jt0xNEn6TqqDiWWscp2fxNd7qnjdpX
	 Bppft+ebCc+/qDyEjPOvzEfdIuuMG5EQfUsapb+rgojUV0n9KNk260IPtCBp55WN3y
	 R93LWm+1CnZJg==
Message-ID: <bcb4fcf5-b49b-4e1c-a5c4-e417d04097f0@kernel.org>
Date: Mon, 23 Sep 2024 17:42:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
To: Erez <erezgeva2@gmail.com>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>
References: <20240920181231.20542-1-erezgeva@nwtime.org>
 <20240920181231.20542-4-erezgeva@nwtime.org>
 <2fo7pndjqieq6lfydmq2pnwb374oqoqnrcsezycgougmr7mtl5@2wm6fe3inf5u>
 <CANeKEMPjLYbBi0AXkEdNum=kqtVe_mfTcVf4zUvJsszVhnh+pw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CANeKEMPjLYbBi0AXkEdNum=kqtVe_mfTcVf4zUvJsszVhnh+pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2024 11:21, Erez wrote:
> On Sun, 22 Sept 2024 at 22:40, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Fri, Sep 20, 2024 at 08:12:29PM +0200, Erez Geva wrote:
>>> From: Erez Geva <ErezGeva2@gmail.com>
>>>
>>> Some flash devices need OTP parameters in device tree.
>>> As we can not deduce the parameters based on JEDEC ID or SFDP.
>>>
>>> Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
>>> ---
>>>  .../bindings/mtd/jedec,spi-nor.yaml           | 39 +++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>> index 6e3afb42926e..4f7bb3f41cb1 100644
>>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>> @@ -90,6 +90,43 @@ properties:
>>>        the SRWD bit while writing the status register. WP# signal hard strapped to GND
>>>        can be a valid use case.
>>>
>>> +  otp-n-regions:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Some flash devices need OTP parameters in the device tree.
>>> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
>>> +      This parameter indicates the number of OTP regions.
>>
>> OTP regions where? In DTS? On flash itself?
> 
> Where can OTP regions be?
> Can you please be serious?
> If you have any suggestions, I am happy to hear.
> I did ask before.

Yes, I am serious, imagine that we do not know what you wanted to say.
At first this just sounded like you mix nvmem-cells here.

Out of blue this binding starts mentioning OTP and you add bunch of
generic properties not really matching anything so far. Instead of being
sarcastic about reviewers confusion, rather improve your description.

Otherwise, good luck.



> 
>>
>>> +      The value must be larger or equal to 1 and mandatory for OTP.
>>
>> Don't repeat constraints in free form text. Add proper minimum and
> 
> Sure, I will add a minimum.
> 
>> default, although it is confusing - property is not required but it is
>> mandatory for OTP?
> 
> You are welcome to suggest a better rephrase.
> Using OTP settings is optional.
> If you set OTP then the number of regions and region length are mandatory.
> While offset and base are optional for OTP settings.

So properties should be required?

> 
> 
>>
>>
>>
>>> +
>>> +  otp-len:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Some flash devices need OTP parameters in the device tree.
>>> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
>>
>> Don't repeat the same.
> 
> Is there a grouping description?
> 
>>
>>> +      This parameter indicates the size (length) in bytes of an OTP region.
>>
>> What if each region has different length? Is it possible?
> 
> Yes, there are. Old Mactronix have chips with the first region bigger
> than the second region.
> As these are old chips, we may skip the support of them.

Other devices can come later re-introducing this approach.



Best regards,
Krzysztof



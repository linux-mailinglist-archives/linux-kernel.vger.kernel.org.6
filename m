Return-Path: <linux-kernel+bounces-379825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E47A9AE44C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C4B221BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0051D1E72;
	Thu, 24 Oct 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mc6LQAmU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B51CF7AE;
	Thu, 24 Oct 2024 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771186; cv=none; b=KXJfNI7/bSAwcm7rIlklOFUZwVQQaYAf9prcgzI8eVz+epk8gRQUqILuBSm8PQgZi8Omt94IJRJ59Ef5yAARC1zwpRwfUtMGbkFd+Aw/DnDU1BVCDLUeFGm0sa9nwhU16gKgqKW69vVvDATDCIwt7ac5vJpodhCN/85Full48v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771186; c=relaxed/simple;
	bh=A4o15toB6iNyZruRWfsVqZQLU8qUvQJABUWMfPi2iSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmPr9Gh9F/ofZS5/ZMZ/mq1pkxtl9P8Neph31T9BpWEmigr5e5WsSSSbHl9xvGS9L3wVVO6IFiS/vM/qUjOJyF6w5CFx7H2soJXALHlr+SDSB7znxwCKFdqXz+9q0lYVru6psncMFywt4gLFw7yqQlZPjgifUMrfZ8HeFA9xwlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mc6LQAmU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729771181;
	bh=A4o15toB6iNyZruRWfsVqZQLU8qUvQJABUWMfPi2iSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mc6LQAmU9/FOqpGAxAMqJPgaCT6WfWqhO0NNRI0/uuYbgS4DABY1ve7VwbmJy1VCw
	 o7ZBqLB3yYP2bfGAeqJppzRUO5hf/u1M1pByqQO9G+Cr/wb2OyircblWzIJO99at+8
	 lLwQMHkY6TI7emfnGNKTPsmK/sFnrLfr8b1iF69PZWdeSWwmMTWrpHF2zAcig74v6S
	 1cNXnwPHdlwL9XRvPbLauw0bjfE0U3kX1AxDr/l6VOLiQzAYouDEoXC8lDhccUkLVh
	 DxCpo+USMyyrk4e4OFpBRPdpZjIhlGjKgkuLwAE4IGABVOnkHRTcGh5/Ca+CgFtIuq
	 5bDpz/hrucQwg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 51C9017E35E0;
	Thu, 24 Oct 2024 13:59:41 +0200 (CEST)
Message-ID: <216c62ae-04ae-4eb9-8344-9e5de2efdd14@collabora.com>
Date: Thu, 24 Oct 2024 13:59:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: memory: mediatek: Add smi-sub-common
 property for reset
To: =?UTF-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "krzk@kernel.org" <krzk@kernel.org>
Cc: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
 <20240821082845.11792-3-friday.yang@mediatek.com>
 <3b31bf46-c5c0-41c9-bb4d-3ba9f64a5d1c@kernel.org>
 <7ca196cf1c1f57426fc6b733d01d38f073da7d94.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <7ca196cf1c1f57426fc6b733d01d38f073da7d94.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 24/10/24 03:28, Friday Yang (杨阳) ha scritto:
> On Wed, 2024-08-21 at 10:55 +0200, Krzysztof Kozlowski wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   On 21/08/2024 10:26, friday.yang wrote:
>>> On the MediaTek platform, some SMI LARBs are directly linked to SMI
>>> common. While some SMI LARBs are linked to SMI sub common, then SMI
>>> sub common is linked to SMI common. Add 'mediatek,smi-sub-comm' and
>>> 'mediatek,smi-sub-comm-in-portid' properties here. The SMI reset
>>> driver could query which port of the SMI sub common the current
>> LARB
>>> is linked to through the two properties. The hardware block diagram
>>> could be described as below.
>>>
>>>               SMI Common(Smart Multimedia Interface Common)
>>>                   |
>>>           +----------------+-------
>>>           |                |
>>>           |                |
>>>           |                |
>>>           |                |
>>>           |                |
>>>         larb0       SMI Sub Common
>>>                     |      |     |
>>>                    larb1  larb2 larb3
>>>
>>> Signed-off-by: friday.yang <friday.yang@mediatek.com>
>>> ---
>>>   .../mediatek,smi-common.yaml                  |  2 ++
>>>   .../memory-controllers/mediatek,smi-larb.yaml | 22
>> +++++++++++++++++++
>>>   2 files changed, 24 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-
>> controllers/mediatek,smi-common.yaml
>> b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-
>> common.yaml
>>> index 2f36ac23604c..4392d349878c 100644
>>> --- a/Documentation/devicetree/bindings/memory-
>> controllers/mediatek,smi-common.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-
>> controllers/mediatek,smi-common.yaml
>>> @@ -39,6 +39,7 @@ properties:
>>>             - mediatek,mt8186-smi-common
>>>             - mediatek,mt8188-smi-common-vdo
>>>             - mediatek,mt8188-smi-common-vpp
>>> +          - mediatek,mt8188-smi-sub-common
>>>             - mediatek,mt8192-smi-common
>>>             - mediatek,mt8195-smi-common-vdo
>>>             - mediatek,mt8195-smi-common-vpp
>>> @@ -107,6 +108,7 @@ allOf:
>>>           compatible:
>>>             contains:
>>>               enum:
>>> +              - mediatek,mt8188-smi-sub-common
>>>                 - mediatek,mt8195-smi-sub-common
>>>       then:
>>>         required:
>>> diff --git a/Documentation/devicetree/bindings/memory-
>> controllers/mediatek,smi-larb.yaml
>> b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-
>> larb.yaml
>>> index 2381660b324c..5f162bb360db 100644
>>> --- a/Documentation/devicetree/bindings/memory-
>> controllers/mediatek,smi-larb.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-
>> controllers/mediatek,smi-larb.yaml
>>> @@ -69,6 +69,16 @@ properties:
>>>       description: the hardware id of this larb. It's only required
>> when this
>>>         hardware id is not consecutive from its M4U point of view.
>>>   
>>> +  mediatek,smi-sub-comm:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: a phandle of smi_sub_common that the larb is
>> linked to.
>>
>> Why do you have to smi phandle properties per each node?
>>
> 
> As shown in the picture from the commit message, we have multipule smi-
> sub-common, each SMI larb may link to one of the smi-sub-common. So we
> need the 'mediatek,smi-sub-comm' to describe which smi-sub-common the
> larb is linked to.
> In next version, I will add two smi-sub-common to the diagram in the
> commit message.
> 
>>> +
>>> +  mediatek,smi-sub-comm-in-portid:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 0
>>> +    maximum: 7
>>> +    description: which port of smi_sub_common that the larb is
>> linked to.
>>
>> Merge it into phandle.
>>
> 
> Just confirm,
> Do you mean merge these two into one property, like:
> mediatek,smi-sub-comm = <&phandle port-id>;
> 
>>> +
>>>   required:
>>>     - compatible
>>>     - reg
>>> @@ -125,6 +135,18 @@ allOf:
>>>         required:
>>>           - mediatek,larb-id
>>>   
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - mediatek,mt8188-smi-larb
>>> +
>>> +    then:
>>> +      required:
>>> +        - mediatek,smi-sub-comm
>>> +        - mediatek,smi-sub-comm-in-portid
>>> +
>>
>> and add it to the example (since you claim it is valid for every
>> device).
>>

It's valid only for the Local Arbiters that have a sub-common port, which anyway
are only the ones that are used by CAMSYS if I'm not wrong....

Regardless of that, not all of the mt8188-smi-larb *require* smi-sub-comm.

Besides, if the larb is anyway already linked to a sub-common, can't we just grab
that from walking back?
Or is this property's purpose to actually add a link to a sub-common?

Regards,
Angelo

> 
> OK, I will add this to the example.
> 
>> Best regards,
>> Krzysztof
>>




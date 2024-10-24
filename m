Return-Path: <linux-kernel+bounces-379273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C41B59ADC50
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3631FB21043
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A7189911;
	Thu, 24 Oct 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcMfOT3P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0947166F14;
	Thu, 24 Oct 2024 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751943; cv=none; b=qoZv1Lt15Jw3XYi0vokAM7K9wxZELDB/oQqGqW8jJA9PUvC2MwiCDOuCFj+cBOn9jcj/YAPGSeb+Dq3D/+mlkL6V0ZbiCL0ZBPz2GazBLMf/34cMt9pbTGZU03CmzzVQngNvcriGrgRhBrDdjhTwTqoNu03AwuGBTPZKXfNZOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751943; c=relaxed/simple;
	bh=/NBI298ZuiNdCrcq2u+a+Yvvoham7AgXGEutYSpJHQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNoCsuIcxtWq1Bz4GkFc+5jNlchOm3WbvYv7UldEYVfTVKbU3k9fDhfXgraHif1ZvVpw9qGgQwgBGZKW1eHD7PTp0ddonvYo4zx55vHPcFXTACZ7s8nBpm+dFrfrnNlUBcyLPBApEHTiIS1BsYZGHOOqk99nhNDaBHAL+UfbTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcMfOT3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7028FC4CEC7;
	Thu, 24 Oct 2024 06:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729751943;
	bh=/NBI298ZuiNdCrcq2u+a+Yvvoham7AgXGEutYSpJHQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GcMfOT3PBKu/b2mqMz//+HZ6TF5BQsPjwOWpOeb+tBqlhR/LJ5oIJQzrHe+/190lN
	 XlrBTlAWpE5lUk3XTh/Q34TW06maHE+s54ngkmlxekGa8cixsP+n4nn6M3oreQqZcQ
	 B2UuNsl/0JOJpY/SrAVn0Hq4PktTL24UTRejpsXlG0reh/waZCyWs9U+xsGdB04Ugt
	 KXjY4gdguqNVAnhOr/yn/q8xnBVjJgHkU1E8n9tfeGmf+xD7J5XoIsVA/lJyLOP7uS
	 72ZI939CACtwVm653gIqid+n7KXQ9y//IpfJoIEEggnyFj2ZlyHwxl7Nx/F78Hjohc
	 y2SpWJ04euJYQ==
Message-ID: <b4055440-d5a5-4d42-9cb7-9fc2f39a2148@kernel.org>
Date: Thu, 24 Oct 2024 08:38:57 +0200
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
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <7ca196cf1c1f57426fc6b733d01d38f073da7d94.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/10/2024 03:28, Friday Yang (杨阳) wrote:
> On Wed, 2024-08-21 at 10:55 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 21/08/2024 10:26, friday.yang wrote:
>>> On the MediaTek platform, some SMI LARBs are directly linked to SMI
>>> common. While some SMI LARBs are linked to SMI sub common, then SMI
>>> sub common is linked to SMI common. Add 'mediatek,smi-sub-comm' and
>>> 'mediatek,smi-sub-comm-in-portid' properties here. The SMI reset
>>> driver could query which port of the SMI sub common the current
>> LARB
>>> is linked to through the two properties. The hardware block diagram
>>> could be described as below.
>>>
>>>              SMI Common(Smart Multimedia Interface Common)
>>>                  |
>>>          +----------------+-------
>>>          |                |
>>>          |                |
>>>          |                |
>>>          |                |
>>>          |                |
>>>        larb0       SMI Sub Common
>>>                    |      |     |
>>>                   larb1  larb2 larb3
>>>
>>> Signed-off-by: friday.yang <friday.yang@mediatek.com>
>>> ---
>>>  .../mediatek,smi-common.yaml                  |  2 ++
>>>  .../memory-controllers/mediatek,smi-larb.yaml | 22
>> +++++++++++++++++++
>>>  2 files changed, 24 insertions(+)
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
>>>            - mediatek,mt8186-smi-common
>>>            - mediatek,mt8188-smi-common-vdo
>>>            - mediatek,mt8188-smi-common-vpp
>>> +          - mediatek,mt8188-smi-sub-common
>>>            - mediatek,mt8192-smi-common
>>>            - mediatek,mt8195-smi-common-vdo
>>>            - mediatek,mt8195-smi-common-vpp
>>> @@ -107,6 +108,7 @@ allOf:
>>>          compatible:
>>>            contains:
>>>              enum:
>>> +              - mediatek,mt8188-smi-sub-common
>>>                - mediatek,mt8195-smi-sub-common
>>>      then:
>>>        required:
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
>>>      description: the hardware id of this larb. It's only required
>> when this
>>>        hardware id is not consecutive from its M4U point of view.
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

You respond two months after... That email conversation is not even in
my mailbox anymore.

Anyway, sub-common are subnodes, no?

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

Yes


Best regards,
Krzysztof



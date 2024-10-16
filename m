Return-Path: <linux-kernel+bounces-367874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66829A07D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982AD285F60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742A20720B;
	Wed, 16 Oct 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m6+rhatk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE422071EE;
	Wed, 16 Oct 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075974; cv=none; b=VN5JWZyw4Atw7PInrpQ1g+Fh/W+RkPt0gHj9pVDn3TsTR0fHfUyKlnkSxIiciFr+QqCuGJ2EU3hJKW4x7PG+i2/mz3Lo4siK0LHLVbO3qa9ep1BUtV7NwCSfP+ibFEVn2tMDx3214pPNx2z2lZl5s7WIgL1zNwRKtKaZAUN4AgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075974; c=relaxed/simple;
	bh=Mcip5Kx6I/TZnEO16HfE6x3mJQievwxkLL2RftHqPKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQgBgwNL00efuYYJvwiRqn2FEV7REG8+fUsrymFs39QaQoEA5m9rrBfzR0wqLXCfn6NQVpoR3PCnriNVJ65oZS/BWe4mbIOEk3M84+asCMkImVRbuRJLCiu2q43UwWdWp+/IL6IbYFoEymaAjp+NKgp8vC7DozPveTF0gckDYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m6+rhatk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729075971;
	bh=Mcip5Kx6I/TZnEO16HfE6x3mJQievwxkLL2RftHqPKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m6+rhatk3ym6roLIghMdE6YlIB4cpCEqsL7OTebXgMEMlVtwwAmU9na0VY2eDGeZn
	 yYcngAECMKOv43li7ASMN5NZG+4TQbfsv/ERifiBUkrBBTpOESfWBqfyUAZWPZewEb
	 utux2BWotQz1Uzs/8grjtC24WZUfbv4EcZpF6lr6kXjNdXdZIHM06ouCBeDjkb73Z6
	 kS01ddCgoxfJLMZNKXNMOapo5QuEb3SXXZ2UqifgxR/nI1K1txrms1UdgvH3G43AST
	 tnr+Zh118aNqtKQ7CZs+yW2Bx0kLDBRejEKao4AEje4HNNoPKzr8sHvz/C2MYu9fDJ
	 KwVYlwu+7FgBA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6B6E717E10B5;
	Wed, 16 Oct 2024 12:52:50 +0200 (CEST)
Message-ID: <7865e7ee-d894-4ef4-89c4-5ea3a90ac6f1@collabora.com>
Date: Wed, 16 Oct 2024 12:52:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: mtu3: add mediatek,usb3-drd property
To: Rob Herring <robh@kernel.org>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 ChiYuan Huang <cy_huang@richtek.com>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Chris-qj chen <chris-qj.chen@mediatek.com>
References: <20241015172100.15150-1-macpaul.lin@mediatek.com>
 <20241015222046.GA2164669-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241015222046.GA2164669-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/24 00:20, Rob Herring ha scritto:
> On Wed, Oct 16, 2024 at 01:21:00AM +0800, Macpaul Lin wrote:
>> Add optional 'mediatek,usb3-drd' property to MediaTek MTU3 DT Schema.
>> This flag specify whether it is a USB3 Dual-role device hardware.
>>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>> index d4e187c78a0b..1e70af0dac82 100644
>> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>> @@ -155,6 +155,12 @@ properties:
>>         property is used. See graph.txt
>>       $ref: /schemas/graph.yaml#/properties/port
>>   
>> +  mediatek,usb3-drd:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      Specify whether it is a USB3 Dual-role device hardware.
>> +    type: boolean
>> +
> 
> Don't the standard properties such as usb-role-switch or dr_mode work
> for you?
> 

They do - and in fact, the upstream MTU3 driver doesn't even support parsing
the proposed property because it does parse the standard usb-role-switch property.

This means that this commit is not needed at all.

Cheers,
Angelo

>>     enable-manual-drd:
>>       $ref: /schemas/types.yaml#/definitions/flag
>>       description:
>> -- 
>> 2.45.2
>>




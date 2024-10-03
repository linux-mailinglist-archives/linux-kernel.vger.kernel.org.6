Return-Path: <linux-kernel+bounces-348792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8AE98EBE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08DE282D79
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3938113E04C;
	Thu,  3 Oct 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PI03sLFL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0C13B2AF;
	Thu,  3 Oct 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945549; cv=none; b=me8nKs1QLQ8AkLBmV5BZKxkHbQfvP8DAb8aSM1tTQnIfqc+9QmngL//gfkJmmkaH6sPZCjvq3EI+sh2r1uEjaymLBYrqcj5es/ebWDta7T3mdZZB1IzzvVVcPy/kiBOgDkCdVTsjkgxHrBRmRdH2ZtgE3ivFGBgzgGxiEzIKmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945549; c=relaxed/simple;
	bh=lmmFtIdoLmsASBRqswrRcByVQnqur9EUZC2nGG3BVdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoidepuIXQGGY+p/ZsZcBPISBl0Apyrr+aZWM+icsloZzgZz3PYJD2bDSrKNjGMlqe9DEmqpaWqZZZ9KGJdQzIgwZFvzwzDsPVumDHU3pLSCCpVbC8HT6AbjptXcZfco3ssEjyebf1x093RZkS/N2MIIcF1jIAg8zNFqcupxybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PI03sLFL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727945546;
	bh=lmmFtIdoLmsASBRqswrRcByVQnqur9EUZC2nGG3BVdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PI03sLFL56Rdxl2zndxNCdCM9u1i7qJjuUD/uDc2/UJNEoFrQeTrBVEKPtBNLAUsd
	 KT7/lwGLCaCFoxJQLB6l2PFGFNL0cHznfwfeOfDX/Gc6crdvCC1bU4DoYUInXEEHrw
	 lVcYQNtVnFMzz6IzWBwxbim4hgtX9UURJEeApKnyta483Uc61PmvZ2u6++hK2hsnuy
	 ySt1oa/gRCCBvDmamy4gjSr+7/yc4u3IQOih1o5Wd1CfWxSI01klE2WIxzXF/uVtjl
	 Q69R1kffayupwxFNXEzDdenA76RoafuuYTQ0EYAAcRPOPgWV+VvVSUq5J8Ar13zBrQ
	 Wp+GUD9eHDAtw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9758117E10D2;
	Thu,  3 Oct 2024 10:52:25 +0200 (CEST)
Message-ID: <faa93bb8-ebc2-4f95-84ca-a61b80188e20@collabora.com>
Date: Thu, 3 Oct 2024 10:52:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] dt-bindings: nvmem: mediatek: efuse: Reuse
 mt8186-efuse in mt8188
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241002022138.29241-1-pablo.sun@mediatek.com>
 <20241002022138.29241-4-pablo.sun@mediatek.com>
 <mh7upw2y2dclyosved3chw7chpqgdg4a3j5ftwftfhm6v5uqpt@cotoeuopfbqg>
 <559fc2a5-631c-440a-812f-2907f84b16b4@collabora.com>
 <74uvqyd2n6cxzi4z3miqh5ay7xun2qapjuse7bav5thr44rlml@pr44cvxsngfe>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <74uvqyd2n6cxzi4z3miqh5ay7xun2qapjuse7bav5thr44rlml@pr44cvxsngfe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/10/24 10:13, Krzysztof Kozlowski ha scritto:
> On Wed, Oct 02, 2024 at 09:42:32AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 02/10/24 08:11, Krzysztof Kozlowski ha scritto:
>>> On Wed, Oct 02, 2024 at 10:21:35AM +0800, Pablo Sun wrote:
>>>> mt8188 has the same GPU speed binning efuse field just
>>>> like mt8186, which requires post-processing to convert to the
>>>> bit field format specified by OPP table.
>>>>
>>>> Add the binding for the compatible list:
>>>>     "mediatek,mt8188-efuse", "mediatek,mt8186-efuse"
>>>> so mt8188 uses the same conversion.
>>>>
>>>> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>>> index 32b8c1eb4e80..70815a3329bf 100644
>>>> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>>> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>>> @@ -39,6 +39,10 @@ properties:
>>>>                  - mediatek,mt8195-efuse
>>>>                  - mediatek,mt8516-efuse
>>>>              - const: mediatek,efuse
>>>> +      - items:
>>>> +          - enum:
>>>> +              - mediatek,mt8188-efuse
>>>> +          - const: mediatek,mt8186-efuse
>>>
>>> And this is not compatible with generic one? This is confusing. Why are
>>> you adding generic fallbacks if they are not valid?
>>>
>>
>> It was my suggestion to start dropping the usage of the generic "mediatek,efuse"
>> fallback, as I've seen multiple times feedback saying to not use generic fallbacks.
>>
>> Was that wrong?
> 
> No, just nothing provided the background that such change is
> intentional. Please mention in commit msg that the preferred way from
> now on is not using the generic fallback.  Maybe even add it to the
> binding itself as comment, so people won't grow the enum with fallback.
> 

Cool. Thanks for the explanation, krzk.

Pablo, can you please add a comment in the binding saying that no more entries
shall be added to the generic fallback set?

Having a comment there, instead of just into the commit message, would be (imo)
better... as then, anyone trying to add new compatibles will be more likely to
read that.

Cheers,
Angelo



Return-Path: <linux-kernel+bounces-347109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C515698CDEC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5BD1F22EA4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248F1940B9;
	Wed,  2 Oct 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gu+EMiqG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727E19409A;
	Wed,  2 Oct 2024 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854957; cv=none; b=JcolgS95qEhN3Gf3g++kglXScwhKChQv66kGrcwwLO1yeGnd6kR0PgQuWdKpDsZizt0YixNmZMJXpTH5OA6Avno8tlAXhMmxQoMTcR1rHW3haq9Fis9znQhEExQ+ujDtgJXwoCSXF451STM+AKn/z4nyrxVWXfCcIkTdhKI3L+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854957; c=relaxed/simple;
	bh=SWvaVAQAL3TshA8nFVUBURr/pyJVpPyYwqiGTjxMyFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDJosUdVvM4Teb1AltZme18cS2rmwfca79+vSU0oyxDkG5ufcHplEabxvbDpovVGtU05lEN5z1S59KV/5BQ1v5H+LpDgkpceaP0+p/zLzfvlZff0Va6loeMNQxieeZegZ0O57FwOK4n9EgdVS2TkYSI5SyPv5WvZMeboYBrwHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gu+EMiqG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727854953;
	bh=SWvaVAQAL3TshA8nFVUBURr/pyJVpPyYwqiGTjxMyFE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gu+EMiqGlUViiTmFvVYQ99dNOgXt97jNtX1ks1dPcWKEUzCChIjrDDCDQkGDStG7f
	 o2Tr2bvZ1lF62ex+IyCMk920IkQNLWK8m1WuII50I5SMY6bdvYvjpFhKT/aSaUiazD
	 pX2iDko52LiTEcQTUtewFXzBnQjhN1v7Jj3dejJpamnJx9SMtdD1W7dlCuXCs/VjKb
	 SCVakbvMoxjvLFTLeqnwgMvP/040gccUY/Cc0g7i74v/ZBNr88m60eq10tjGcPO7OS
	 NYl9gV9V1ZmYmfNTO93cGFbqlw/mYrMaDggm2JKUzGncYoqbWyhZADOJjT3Tf/k2Ui
	 J+pD+msxf0aLQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 777D717E105F;
	Wed,  2 Oct 2024 09:42:33 +0200 (CEST)
Message-ID: <559fc2a5-631c-440a-812f-2907f84b16b4@collabora.com>
Date: Wed, 2 Oct 2024 09:42:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] dt-bindings: nvmem: mediatek: efuse: Reuse
 mt8186-efuse in mt8188
To: Krzysztof Kozlowski <krzk@kernel.org>, Pablo Sun <pablo.sun@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241002022138.29241-1-pablo.sun@mediatek.com>
 <20241002022138.29241-4-pablo.sun@mediatek.com>
 <mh7upw2y2dclyosved3chw7chpqgdg4a3j5ftwftfhm6v5uqpt@cotoeuopfbqg>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <mh7upw2y2dclyosved3chw7chpqgdg4a3j5ftwftfhm6v5uqpt@cotoeuopfbqg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/10/24 08:11, Krzysztof Kozlowski ha scritto:
> On Wed, Oct 02, 2024 at 10:21:35AM +0800, Pablo Sun wrote:
>> mt8188 has the same GPU speed binning efuse field just
>> like mt8186, which requires post-processing to convert to the
>> bit field format specified by OPP table.
>>
>> Add the binding for the compatible list:
>>    "mediatek,mt8188-efuse", "mediatek,mt8186-efuse"
>> so mt8188 uses the same conversion.
>>
>> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
>> ---
>>   Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>> index 32b8c1eb4e80..70815a3329bf 100644
>> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>> @@ -39,6 +39,10 @@ properties:
>>                 - mediatek,mt8195-efuse
>>                 - mediatek,mt8516-efuse
>>             - const: mediatek,efuse
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt8188-efuse
>> +          - const: mediatek,mt8186-efuse
> 
> And this is not compatible with generic one? This is confusing. Why are
> you adding generic fallbacks if they are not valid?
> 

It was my suggestion to start dropping the usage of the generic "mediatek,efuse"
fallback, as I've seen multiple times feedback saying to not use generic fallbacks.

Was that wrong?

Cheers,
Angelo




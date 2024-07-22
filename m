Return-Path: <linux-kernel+bounces-258696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9C0938BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8461C21253
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6616849F;
	Mon, 22 Jul 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2VGLy/jK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053312B63;
	Mon, 22 Jul 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639435; cv=none; b=dLq/QYPhzkHwrKuztpt7bR/qmtoWpfFMleGQPUWHojLT5j1l5iHbVoffmUOIQiwOhb8YJAbSTjPZ/9k+WGQsay3dgAd+Sn34uz7dvDEXe6l1dyco+xp5RSmVjOaB7pKwVZIwhlI2b3Gvp/y5xzR4SF/SUsaBJJ7msiuQ7GPVaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639435; c=relaxed/simple;
	bh=0y+SSd3HzuVB5A6DL6ENAzZ5/ElbVtDZp3b9VkjVamI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVslFIRNqFLJPWRIN8MDPixnoN55DtQEOlfij+vgJip/5KJIJG5HeQlqLZdYqp4kqlfWJQaTpNvxuq4pgvclvNUwRENvs+N7gyCfMAy3iXq7JGGamjEC5R+ptHBxEh6Vcx2sKUhPXIOtBGES/3Z16ozChsoGXZu0qe1v8BsJW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2VGLy/jK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721639432;
	bh=0y+SSd3HzuVB5A6DL6ENAzZ5/ElbVtDZp3b9VkjVamI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2VGLy/jK8YVxqbFJktL3gY9D52LdEm31BRANHinVSGUKuJNyWn5MFnI57uXDPK4ML
	 i8xFgjrLxYfKcEKOm0Y3+BSgbvhvrT2w2hQbZGMV10FtS+3PXEvVyn8ELtzQ3AVknF
	 TAZ3DiXaVYdoDpMiIRPWN3Z7EXL+mrrCyAJosPNBrTWnqvDIS9OBBjxmlV6a2GnWQy
	 dsBlDwlIvONpdj0C8LMokb2LxFBTrPq0kwJ3xaDCwGeoRJ+BhAOwm9Q+3Rtu35eXP9
	 mqurhhY8ZpB983rjUR1WE27dH2gDOPxte2afuhHR9jm0RB8fBCeuIaSIjQbNgQn24c
	 P4BxqVotUui/g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6FF0237800DE;
	Mon, 22 Jul 2024 09:10:31 +0000 (UTC)
Message-ID: <d39045cf-bcf5-4d9a-8347-752ff09ccc24@collabora.com>
Date: Mon, 22 Jul 2024 11:10:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola: Update ADSP
 reserved memory region
To: Fei Shao <fshao@chromium.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240719045823.3264974-1-fshao@chromium.org>
 <7edb3361-9e53-44ad-82ec-b2c81834b2ea@collabora.com>
 <CAC=S1nh0c4HL2uUcz_zMmtuJvk7+3iWT5mEtmtpDrp1+nWp2cQ@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAC=S1nh0c4HL2uUcz_zMmtuJvk7+3iWT5mEtmtpDrp1+nWp2cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 22/07/24 05:37, Fei Shao ha scritto:
> On Fri, Jul 19, 2024 at 5:22 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 19/07/24 06:58, Fei Shao ha scritto:
>>> Corsola firmware reserves the memory region of [0x60000000, 0x61100000)
>>
>> Sorry but if the region is supposed to be 0x1100000 long....
>>
>>> exclusively for ADSP usage.
>>> But in fact, a 6 MB "hole" of [0x60A00000, 0x61000000) didn't get
>>> assigned to the ADSP node in the Corsola device tree, meaning no audio
>>> tasks can access and utilize that memory section.
>>>
>>> Update the reserved ADSP memory region to fill the gap.
>>>
>>> Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
>>> Signed-off-by: Fei Shao <fshao@chromium.org>
>>> ---
>>>
>>>    arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>> index afdab5724eaa..0c4a26117428 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>> @@ -169,7 +169,7 @@ adsp_dma_mem: memory@61000000 {
>>>
>>>                adsp_mem: memory@60000000 {
>>>                        compatible = "shared-dma-pool";
>>> -                     reg = <0 0x60000000 0 0xA00000>;
>>> +                     reg = <0 0x60000000 0 0x1000000>;
>>
>> ...why are you making it 0x1000000 long?
> 
> Because 0x61000000-0x61100000 belongs to another existing region,
> `adsp_dma_mem`.
> It's slightly confusing because the diff doesn't show that directly...
> here's its snippet for ref:
> 

Oh, sorry about that, that's right.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> adsp_dma_mem: memory@61000000 {
>          compatible = "shared-dma-pool";
>          reg = <0 0x61000000 0 0x100000>;
>          no-map;
> };
> 
> Regards,
> Fei
>>
>> Cheers,
>> Angelo
>>
>>>                        no-map;
>>>                };
>>>
>>
>>



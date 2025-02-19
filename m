Return-Path: <linux-kernel+bounces-521654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E96A3C070
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E793B9461
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD99A1EA7FC;
	Wed, 19 Feb 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dAWINYM6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826441C3C11;
	Wed, 19 Feb 2025 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972632; cv=none; b=CXfYzpJVpevtzu3dMQMGIWSH8vxBDmSjYLKKvBrK2Md8pNIVGnfnDDYOmxqBAyf3ldf+DbPn+sNnrKDzZklhr4oFyMdRM7qvAFLeInk+8CJCRL76o/iNbryK6+WbEE9M5OyC9y0mJuC6gqNjud45EPxzxYTW/LbSeVjCfHb/zZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972632; c=relaxed/simple;
	bh=AWOeMCIP6k+DdjeVem59jvHAY8phtfH/61lO07anvnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QM+Ipyygbnq6A7mWoUmB17snnQ/unGinTyiBonZns91Peql6+VpJv/Qul8wljt+xCR0ro8si2h2K4RNyYaPe/o0qhTzEojBswHKrx5Rh4qenX82XvMg77bcTgbPSM7QaQqxSEu+tzb6eebE6zI4INrzrSpocP+MbtCHctc+YfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dAWINYM6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739972628;
	bh=AWOeMCIP6k+DdjeVem59jvHAY8phtfH/61lO07anvnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dAWINYM61MZADtGlLWmkm/IFpcjX4E0KXCvxozxCyciEcdp+Sq0J4Rwu1txzlB2gN
	 oWmZ/2UzkdCAZKMt13Q5yYscplizcr/uHx6S8Fv1Kxuu3KnBaeZsL1H3vP2PilHRJY
	 1fyRqK1SmPesLsGhNv7yeIHD4Wma5knfmojHEALD6ZLsAc9hfGI8NRSRebqwZJ1lFV
	 Mx/wWETOXNCzYCTB62VNDVJLflr4AZqmB8oBEFHn5L958tHi3NwE7S3gzyIJ1caOWt
	 h8tD3pEXyWZVy83DqXR2AaJWzxHIRX0Mz2pwOmOgOyosflYwT6N3AK2GFK7EcUFOG9
	 nTTDWJO/e21mA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E1C4C17E14D5;
	Wed, 19 Feb 2025 14:43:47 +0100 (CET)
Message-ID: <8204f202-9af5-46f5-96f8-3cb32fe32179@collabora.com>
Date: Wed, 19 Feb 2025 14:43:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ASoC: mediatek: mt8188: Support DMIC in AFE
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 parkeryang <Parker.Yang@mediatek.com>
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
 <20250218-genio700-dmic-v1-4-6bc653da60f7@collabora.com>
 <6cd2be03-a3e8-4bdc-b91e-51b3e1029782@collabora.com>
 <51ac7a72-9113-46c6-98d8-2924a9572966@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <51ac7a72-9113-46c6-98d8-2924a9572966@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 19/02/25 14:40, Nícolas F. R. A. Prado ha scritto:
> On Wed, Feb 19, 2025 at 12:29:13PM +0100, AngeloGioacchino Del Regno wrote:
>> Il 18/02/25 21:52, Nícolas F. R. A. Prado ha scritto:
>>> From: parkeryang <Parker.Yang@mediatek.com>
>>>
>>> Add the AFE routes that connect the DMIC (I004-I011) to the UL9 frontend
>>> (O002-O009) and register the mt8188-dmic DAI driver during probe.
>>>
>>> Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>>    sound/soc/mediatek/mt8188/Makefile            |  1 +
>>>    sound/soc/mediatek/mt8188/mt8188-afe-common.h |  1 +
>>>    sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    | 24 ++++++++++++++++++++++++
>>>    3 files changed, 26 insertions(+)
>>>
>>> diff --git a/sound/soc/mediatek/mt8188/Makefile b/sound/soc/mediatek/mt8188/Makefile
>>> index 1178bce45c50ba252672a32b3877732a5a76c610..b9f3e4ad7b07ba9e21c846706371c53269f894db 100644
>>> --- a/sound/soc/mediatek/mt8188/Makefile
>>> +++ b/sound/soc/mediatek/mt8188/Makefile
>>> @@ -6,6 +6,7 @@ snd-soc-mt8188-afe-y := \
>>>    	mt8188-afe-pcm.o \
>>>    	mt8188-audsys-clk.o \
>>>    	mt8188-dai-adda.o \
>>> +	mt8188-dai-dmic.o \
>>>    	mt8188-dai-etdm.o \
>>>    	mt8188-dai-pcm.o
>>
>> The Makefile addition doesn't belong to this commit. Please fix.
> 
> I was divided between adding it here or in the previous commit that adds the
> dmic driver. Only in this commit is the mt8188_dai_dmic_register() added, so
> this is the first commit in which any of the code from the dmic driver is
> actually used, hence why I added it here. But adding the makefile entry together
> with the driver code, even if it's not used, makes sense too, so I'll move it
> there.
> 

You can even squash the two commits... after all, adding a piece that doesn't
get used until a later time is practically useless... right?! :-)


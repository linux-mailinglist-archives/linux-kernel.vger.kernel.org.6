Return-Path: <linux-kernel+bounces-209869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF0D903C10
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703D1281E11
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237017C210;
	Tue, 11 Jun 2024 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CgsuC1JE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573BE4CDE0;
	Tue, 11 Jun 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109494; cv=none; b=KZM5Zl1F3oQPBIizTXLuA5bWoZ7PMaTH5YrN6s6eGRshmY6lUtSjFF9aag67qLMyk/esXqI4XNuKow4GR+0tq86RbFd5aWrQK0wxLLfdNjO46lcjHvCWNP9f0WW1MEVpp+fdmsGY21tWgMhAMGXfpSR0p9eAYMtomOnhuQwPOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109494; c=relaxed/simple;
	bh=kj5qaVbqaQZcuY/DAi1KbmqH4orxFs4setQOSPqpduw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkuSvKBRM0PxyVyozMJI391NKayOWUQToRFafi5gNnFegjkGwTMPuxIMgUBsSSmQ0iStiEs6JPcbCeiT1j4RkbLMltZCbRfS6nmQqMbP5l4Ch9qaSEEmseLXaO9P/ygUSuCL8UaRgTtc9IrY9D1ZG7PWtsQW8IMnUCZ2tP4K5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CgsuC1JE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718109491;
	bh=kj5qaVbqaQZcuY/DAi1KbmqH4orxFs4setQOSPqpduw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CgsuC1JErhyECA3tzoGI0mBBnijkB/u/D7XKU3ntgykQVAZiOzecN2VpOqbnLs/Fz
	 Ao5uBmpzwfBH2KoRca+AYtHxsG3iBuukpbHqChzqZc01QTZV6FvEty7rwQujKUMrRt
	 a8PhUuf7EkaqVl9/En2ck6ePLXd/VphRyG2cYrRThlBnUlsyuNv6KGin+k91A1/OI8
	 Qemx6TjnsCUTWMpiMMwqANCZSYiR/LXrsj/jRxzZJL13pGekvL+CQK0ZXZZBgI0QZD
	 V355vc7Gcb3N3B8urMSe5AYyVZc9IDSocaWFXLkbjJuHu83HmBFUCOZLSb7ZkK+T3u
	 gIwuvLGRaOZvQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7418F3780EC6;
	Tue, 11 Jun 2024 12:38:10 +0000 (UTC)
Message-ID: <d7d32ef3-8b2e-476c-a15e-7f829ea0d60a@collabora.com>
Date: Tue, 11 Jun 2024 14:38:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoC: support machine driver with TAS2781
To: Mark Brown <broonie@kernel.org>,
 Rui Zhou <zhourui@huaqin.corp-partner.google.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 matthias.bgg@gmail.com, trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com,
 kuninori.morimoto.gx@renesas.com, maso.huang@mediatek.com,
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240611022227.2508354-1-zhourui@huaqin.corp-partner.google.com>
 <Zmgsfafmfedd9_MV@finisterre.sirena.org.uk>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <Zmgsfafmfedd9_MV@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/06/24 12:52, Mark Brown ha scritto:
> On Tue, Jun 11, 2024 at 10:22:27AM +0800, Rui Zhou wrote:
>> Support amp TAS2781 for mt8188 platform
>>
>> Signed-off-by: Rui Zhou <zhourui@huaqin.corp-partner.google.com>
>> ---
>>   sound/soc/mediatek/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
>> index 5a8476e1ecca..07f67f96c889 100644
>> --- a/sound/soc/mediatek/Kconfig
>> +++ b/sound/soc/mediatek/Kconfig
>> @@ -233,6 +233,7 @@ config SND_SOC_MT8188_MT6359
>>   	select SND_SOC_HDMI_CODEC
>>   	select SND_SOC_DMIC
>>   	select SND_SOC_MAX98390
>> +	select SND_SOC_TAS2781_I2C
>>   	select SND_SOC_NAU8315
>>   	select SND_SOC_NAU8825
> 
> Ideally this would be sorted to avoid spurious merge conficts.  Also do
> we really have dependencies here or should these just be being enabled
> by users - these drivers are all pretty generic now?

The only dependency is on the MT6359 PMIC's audio related IPs and nothing else.

I'd even remove the other select statements for the other codecs, honestly,
as there's no reason why MT8188 wouldn't support a codec or the other, and
there is no reason why that SoC needs exactly those codecs, apart from some
board (Chromebooks) having one, or the other.

Instead of adding a select statement on MT8188_MT6359, adding the TAS2781_I2C
driver as a module in defconfig is a better idea..... at least, IMO.

>  Not that this
> change in itself makes a huge difference to the existing state.

I agree it doesn't make any huge difference, but I also don't see why users
can't simply enable (y/m) that in the kernel configuration :-)

Cheers,
Angelo


Return-Path: <linux-kernel+bounces-210039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FAC903E68
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5221C239AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F6917D889;
	Tue, 11 Jun 2024 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="z8w1uM6J"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F81DDF4;
	Tue, 11 Jun 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114976; cv=none; b=JLwQ3A/1RAzYy6mU3IjRv+4Bv/0MDxQ5g5TlH4CdX6ex6gZ7CpYMSUB5iSYlZBlyOxh4jXsN7gLoJOJpoTBPFyM6h4zlb+u2y0ZLgOwDJFwDqqvZ7MNj0MEQEyK7dHElVNakMwWmdrna4B4XjTwpsNoQoSTU+wQ3J1Ltuvt1k6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114976; c=relaxed/simple;
	bh=ViofiMOvrZEBNMzdr2R4C7k85V0pmt2Bb6QhxHXjizQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG6NYpBWMAd3aX36itxpwM2EuVRgzg3mSzxPgu1yy2ZY3lDvjpVO0MYrCIzc3/nusNNetCUQDrkPTEXXmJSt/zgTuETOLiaVAR9oKqzzFmeAhwBtBGvMBxhVAMTSFtJYpS7AcVruCfGsXDuPzmtU4HBBIcoh9EiAjnNkhYCw8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=z8w1uM6J; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718114972;
	bh=ViofiMOvrZEBNMzdr2R4C7k85V0pmt2Bb6QhxHXjizQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=z8w1uM6JTfeMeIDudhxhwiHEgYehSqnEGTDABQVoj3aC1VPQh4i44uj47CKFXIBbs
	 wmVbqW7fyNsKEnQSQJrVXb7RSYPkeehuB+LFf40zh+kpnyS5Xw+Q7mO+O8Mn+nlm6P
	 HFjWhCBOURo+KcvedcAMuQ/o0cTMGc/eAdDe2s9F1+AEK1UoLNzAQOvTKaHFLTAq32
	 FUt2XoRrrb8vTopBmAHJ1PqIMiEK1iI7fAVoPhc68K5c0PHyz8/ChjTbxUTVg7HHrq
	 tfDwkxnP4fTUg6hZsCRogZKplvnUCQB6VHOidCDOJkFnP9bKJP4pqCT2DHzZTclaWM
	 R/9C4ZUdMa+Qw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1FB533782186;
	Tue, 11 Jun 2024 14:09:32 +0000 (UTC)
Message-ID: <ca44b61a-3399-41b4-9f78-81a2ae963ce3@collabora.com>
Date: Tue, 11 Jun 2024 16:09:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoC: support machine driver with TAS2781
To: Mark Brown <broonie@kernel.org>
Cc: Rui Zhou <zhourui@huaqin.corp-partner.google.com>, lgirdwood@gmail.com,
 perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
 trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com,
 kuninori.morimoto.gx@renesas.com, maso.huang@mediatek.com,
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240611022227.2508354-1-zhourui@huaqin.corp-partner.google.com>
 <Zmgsfafmfedd9_MV@finisterre.sirena.org.uk>
 <d7d32ef3-8b2e-476c-a15e-7f829ea0d60a@collabora.com>
 <ZmhOz7BB8eJ38QVE@finisterre.sirena.org.uk>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ZmhOz7BB8eJ38QVE@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/06/24 15:19, Mark Brown ha scritto:
> On Tue, Jun 11, 2024 at 02:38:09PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 11/06/24 12:52, Mark Brown ha scritto:
>>> On Tue, Jun 11, 2024 at 10:22:27AM +0800, Rui Zhou wrote:
>>>> Support amp TAS2781 for mt8188 platform
> 
>>>> +++ b/sound/soc/mediatek/Kconfig
>>>> @@ -233,6 +233,7 @@ config SND_SOC_MT8188_MT6359
>>>>    	select SND_SOC_HDMI_CODEC
>>>>    	select SND_SOC_DMIC
>>>>    	select SND_SOC_MAX98390
>>>> +	select SND_SOC_TAS2781_I2C
>>>>    	select SND_SOC_NAU8315
>>>>    	select SND_SOC_NAU8825
> 
>>> Ideally this would be sorted to avoid spurious merge conficts.  Also do
>>> we really have dependencies here or should these just be being enabled
>>> by users - these drivers are all pretty generic now?
> 
>> The only dependency is on the MT6359 PMIC's audio related IPs and nothing else.
> 
>> I'd even remove the other select statements for the other codecs, honestly,
>> as there's no reason why MT8188 wouldn't support a codec or the other, and
>> there is no reason why that SoC needs exactly those codecs, apart from some
>> board (Chromebooks) having one, or the other.
> 
> Right, that's what I meant - the drivers are now so generic that they
> probably shouldn't be selecting everything they could possibly work
> with.
> 
>> Instead of adding a select statement on MT8188_MT6359, adding the TAS2781_I2C
>> driver as a module in defconfig is a better idea..... at least, IMO.
> 
> Yes.
> 
>>>   Not that this
>>> change in itself makes a huge difference to the existing state.
> 
>> I agree it doesn't make any huge difference, but I also don't see why users
>> can't simply enable (y/m) that in the kernel configuration :-)
> 
> I think this is a result of the drivers originally being very specific
> to a particular setup

Yeah, I agree.

 >
> and gradually getting made more generic, if the
> driver can only be used on a specific machine then the selects make
> sense but that's no longer the case for these drivers I think.

No this is not going to be used only for a specific machine... so yeah your
thoughts are totally right.

Just as an example, MT8188 (Kompanio) and MT8390 (Genio) are the same SoC again,
like MT8195 (Kompanio) and MT8395 (Genio) - so this driver is also going to be
used for the Genio 700 EVK, other than some SBC, etc, which do anyway expose I2S
pins on some kind of header, so... :-)

Cheers!


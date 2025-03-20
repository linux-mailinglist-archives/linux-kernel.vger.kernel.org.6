Return-Path: <linux-kernel+bounces-569705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE04A6A65B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A30E189453F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207A1DEFC5;
	Thu, 20 Mar 2025 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cDZSPhtQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE54A0C;
	Thu, 20 Mar 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474412; cv=none; b=IT0UIv1RwympUkMlSuzmCHwtzDR1e3B3Z2gkWBPyasbxUqEBEr+ufvzIjnQHG0iv7euwI4xALmI+l7T4Waw84KEpS5NbYEn+iXafIQ+yqLafZDDP2D/eMi8gv/Y/hhG3yrNk+8OuPPYvU8SOSTALJXiEmcjYSO1V2Wvpoo/zig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474412; c=relaxed/simple;
	bh=dSb1rGkUWH+O9PKTS5kcXjpzSzAoMTGvjKFlYsZAbIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q375/fEo8rUrj1Ze4bBcnmjmpdzAV728Wz+oqyehg0BI+YieuRUw1PL5ag5tzYKm6i6Km5Ad69xUms0DqbIOcRs9zT1p1xai4nX1H7QGdc3eFfOF+Amz+kMPJbwC+HWJldSoJ7NvmV2yEn7IDRdQkFkMOe233EYGFM643haopXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cDZSPhtQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742474408;
	bh=dSb1rGkUWH+O9PKTS5kcXjpzSzAoMTGvjKFlYsZAbIU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cDZSPhtQdKCk9SSLCW0czIQ9yP7K095pjew+9ZpZDJDKONmX5x2jONkHAlQJtx4uQ
	 o9rfqITPbXCkGRMBj5CPsl9zPbzVAFNf5J51mFB6gXfQEC7CsBSJuzqDFEJ1eG7/zc
	 S2UrL16vN+bnhKwO8Aw19KtICy+DvbAixpJV9bTxx8MhMn94/lGhyKUIybjqBfXAbM
	 sS1tXxCwunamUN2EYuHcvT8TPTAauxN+LIoRdkFVi3h+NPOdSoivheZMvA6k0lveEF
	 3oQp00h1eyvJ+wXw689tq3XyK7UJ5xcEqhMUpk9X3o7m2R78dQEG8NfaGj3znYDaSb
	 n+wIi0IOQ2rRg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4A62B17E0607;
	Thu, 20 Mar 2025 13:40:07 +0100 (CET)
Message-ID: <204c40d5-de0f-42d0-bc86-d17606c4929f@collabora.com>
Date: Thu, 20 Mar 2025 13:40:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: SOF: MediaTek: Add mt8196 hardware support
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "hailong.fan" <hailong.fan@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, sound-open-firmware@alsa-project.org,
 linux-sound@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, Jjian.Zhou@mediatek.com,
 Xiangzhi.Tang@mediatek.com
References: <20250320031753.13669-1-hailong.fan@mediatek.com>
 <20250320031753.13669-2-hailong.fan@mediatek.com>
 <20250320-cocky-adventurous-rooster-be2abd@krzk-bin>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250320-cocky-adventurous-rooster-be2abd@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/03/25 08:52, Krzysztof Kozlowski ha scritto:
> On Thu, Mar 20, 2025 at 11:17:24AM +0800, hailong.fan wrote:
>> +
>> +void mt8196_sof_hifixdsp_shutdown(struct snd_sof_dev *sdev)
>> +{
>> +	/* set RUNSTALL to stop core */
>> +	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_HIFI_RUNSTALL,
>> +				RUNSTALL, RUNSTALL);
>> +
>> +	/* assert core reset */
>> +	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_CFGREG_SW_RSTN,
>> +				SW_RSTN_C0 | SW_DBG_RSTN_C0,
>> +				SW_RSTN_C0 | SW_DBG_RSTN_C0);
>> +}
>> +
> 
> Drop stray blank line.
> 
>> diff --git a/sound/soc/sof/mediatek/mt8196/mt8196.c b/sound/soc/sof/mediatek/mt8196/mt8196.c
>> new file mode 100644
>> index 000000000000..364069ce9954
>> --- /dev/null
>> +++ b/sound/soc/sof/mediatek/mt8196/mt8196.c
>> @@ -0,0 +1,650 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Look here
> 
>> +/*
>> + * Copyright (c) 2025 MediaTek Inc.
>> + * Author: Hailong Fan <hailong.fan@mediatek.com>
>> + */
> 
> ...
> 
>> +
>> +static const struct of_device_id sof_of_mt8196_ids[] = {
>> +	{ .compatible = "mediatek,mt8196-dsp", .data = &sof_of_mt8196_desc},
> 
> Bindings are before users.
> 
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, sof_of_mt8196_ids);
>> +
>> +/* DT driver definition */
>> +static struct platform_driver snd_sof_of_mt8196_driver = {
>> +	.probe = sof_of_probe,
>> +	.remove = sof_of_remove,
>> +	.shutdown = sof_of_shutdown,
>> +	.driver = {
>> +	.name = "sof-audio-of-mt8196",
>> +		.pm = &sof_of_pm,
>> +		.of_match_table = sof_of_mt8196_ids,
>> +	},
>> +};
>> +module_platform_driver(snd_sof_of_mt8196_driver);
>> +
>> +MODULE_LICENSE("Dual BSD/GPL");
> 
> And here Hm? Don't fake the licensing.
> 
>> +MODULE_DESCRIPTION("SOF support for MT8196 platforms");
>> +MODULE_IMPORT_NS("SND_SOC_SOF_XTENSA");
> 
> Is this correct?
> 

The import namespace you mean? yes, that's for sof_xtensa_arch_ops :-)

Cheers

> 
> Best regards,
> Krzysztof
> 




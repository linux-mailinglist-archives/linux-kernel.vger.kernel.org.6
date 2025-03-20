Return-Path: <linux-kernel+bounces-569654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5610A6A5A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCBD4848CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C234F21D5B0;
	Thu, 20 Mar 2025 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V9E8hfOm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9E21C9F4;
	Thu, 20 Mar 2025 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471882; cv=none; b=Es+d3VidoAZ12gs1OGUYuUIwUi8ztrbfhNFaRi6SMamOTQr0/N7dIfSg6CBupfm/RzL5wAFJMIkPwxT4Fnb6+z6S78clL37eWY9So1dU7RObsp4k9tqigc4U+HJAdXnNoPEV56Feann5rTcKIlU1wJRIOm6Q2x4jqQqMnNTiUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471882; c=relaxed/simple;
	bh=4PB17PpPoG0IB+JwIOSpazM8zXzkgKRzyjbFPrS6N4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZSadcGsRjfs/T23b+D3gM6ATR6ozbc9oxXYuUXYjZYmc8gtjhVYemgX2QegMTHG6ewVsCsdrT5TUdOJSuB+fgmyqkVASvicBghMTq1KlL27pzwabH+ZqR8OzX9EvpoxBLUJaMPJsezaPmzV8/LHuon/OPC0hW4Rp+e+/1Jmarg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V9E8hfOm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742471878;
	bh=4PB17PpPoG0IB+JwIOSpazM8zXzkgKRzyjbFPrS6N4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V9E8hfOmOcegz8AS8ZmFpWuT0hKAtsYT4h9BpYToZyUX7o9OCMsD41AtNfhWZUGer
	 G1xJxuezSeHEKfYv0kccscdNODkN//OKWNQHnqr6mFyrPf7xLM0oE1l3YAwAerc+6i
	 OzpBBJ7IQZhImyBUx1ac5BggqaPwbnOaMgXFlvbCHMt0DTX0pMRZFNwzSAZfOPB3i0
	 Pc2M0Y3fISWYgYUCQB+TUA+i1R1tFjLyxbbaydWHRL5irINXSdipNGAUdfAfapWs2k
	 6F4odB/xbnRAsNqHAz6j3etKM2n4MVE99k8JxGU1HIidde13NcQLMJ6P4afosdvCJ6
	 sTSuSBwo1Oi3Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D67917E017D;
	Thu, 20 Mar 2025 12:57:57 +0100 (CET)
Message-ID: <816dd6ea-0e5f-4d8f-a5eb-99d0670e0d43@collabora.com>
Date: Thu, 20 Mar 2025 12:57:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: SOF: MediaTek: Add mt8196 hardware support
To: "hailong.fan" <hailong.fan@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, Jjian.Zhou@mediatek.com,
 Xiangzhi.Tang@mediatek.com
References: <20250320031753.13669-1-hailong.fan@mediatek.com>
 <20250320031753.13669-2-hailong.fan@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250320031753.13669-2-hailong.fan@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/03/25 04:17, hailong.fan ha scritto:
> Add support of SOF on MediaTek mt8196 SoC.
> MT8196 has a Cadence HiFi-5 DSP core that is responsible for running the
> operating system and application programs. The IPC communication between
> the AP and DSP is based on shared DRAM and mailbox interrupt.
> 
> Signed-off-by: hailong.fan <hailong.fan@mediatek.com>

Hello Hailong,

after seeing this series, I acknowledged that the functions that were duplicated
between MT8188 and MT8195 are, in reality, common between more than just those,
as they are the same in your submission for MT8196.

Therefore, I've send a commit that commonizes those, reducing useless code
duplication.

Can you please rebase your series on top of [1]?

Thanks,
Angelo

[1]: 
https://lore.kernel.org/all/20250320115300.137410-1-angelogioacchino.delregno@collabora.com/



Return-Path: <linux-kernel+bounces-363814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125C499C75F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E65B25E36
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDBD176FA2;
	Mon, 14 Oct 2024 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B2L/wPeN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257E54670;
	Mon, 14 Oct 2024 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902730; cv=none; b=UpCrxWjntxtTT1O/omCn+dje80pV7c2EatsJokEx6XqPWKt1xjvOqVs6a8FTbI8TgkRvEtITD7+Gy4RIXIZTTgCSI0MQNVxl7axQDSIQdh5ZBMLozXCpxFVenqZYfHlLarM7+FMbl0OznHmof3EYFL2fFVqsDtpPZdQI5eNE+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902730; c=relaxed/simple;
	bh=LzevbGBn889H796YREVQWJs6MBQ0CW+YuvI8kJMU7wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pE7W8cCH5YaqIejqYOOZ1YG3+dsdJwmUK1F4tCF+x33nF9Mhw6PpSKN0p9rKBN1clktBVWLdObLbaekcNrj2hRX5CKhQ7KF+yDGdXtwntOAuxtrqs9zxvBtARA+WBAWdnYPz7dLyoGjnO7Y7/81n5Eh6rTOQ6l6UQFDTqaR8Chs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B2L/wPeN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728902724;
	bh=LzevbGBn889H796YREVQWJs6MBQ0CW+YuvI8kJMU7wY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B2L/wPeN5bTBjFe/9yQusjatVCQwxsJ/NlzvSDYpBBZtgNm+b3hvitqsy6KH4PDpB
	 kpSoxX9IeEPU3qyV8cjMmjbHmr//8zWFan5mVq8xfaCGguCWDN+H+1PigNmBpvmQv5
	 W8cIEpDoSs638HPMjRvkqI0cqXSWQC+Sa1t33SWnQ25v3/keer4gR5Hu25qx+2FtS4
	 LYU05rDC+Cj2zhYpG80fG5+pLH6Iez4cijsFDmYrmQvfaq2n5u61XyWdheQFPQIExc
	 i2jZCbK8HqVYJUptB/ZFXx/vbCAUrseJTbiXE9ir1escoTZxPuhciqxXn15J6K/o/n
	 PB/Qt0Om3EUwQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0190917E1395;
	Mon, 14 Oct 2024 12:45:23 +0200 (CEST)
Message-ID: <4c4c8e5f-80a7-46f9-a485-6cf0b5aa7e83@collabora.com>
Date: Mon, 14 Oct 2024 12:45:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: mt8390-genio-700-evk: update
 regulator names
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20241007090244.1731-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241007090244.1731-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/10/24 11:02, Macpaul Lin ha scritto:
> Update regulator names to match schematics, replacing generic terms.
> 1. Add system wide 'reg_vsys' node for 4.2V power rail.
> 2. Add 'reg_vsys' node as 'vin-supply' for the following nodes
>   - common_fixed_5v, edp_panel_fixed_3v3, gpio_fixed_3v3, sdio_fixed_3v3,
>     touch0_fixed_3v3, usb_hub_fixed_3v3, usb_p0_vbus, and usb_p1_vbus.
> 3. Update regulator names according to the stable output name on
>     schematics.
>   - vdd_5v, vedp_3v3, ext_3v3, vio18_conn, wifi_3v3, vio33_tp1, vhub_3v3,
>     vbus_p0, vbus_p1.
>   - vcn18_pmu, vcn33_2_pmu, dvdd_proc_l, dvdd_core, vpa_pmu, dvdd_adsp,
>     va12_abb2_pmu, vsim1_pmu, vufs18_pmu.
> 4. Remove usb_hub_reset_1v8. Use 'hub' node to probe USB HUB
>     in subsequent patches.
> 
> Suggested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Please disregard the first "applied" email, as that was on the wrong kernel tree.

I confirm the series was applied to v6.12-next/dts64 and that this is the
right tree and right branch.

Cheers,
Angelo


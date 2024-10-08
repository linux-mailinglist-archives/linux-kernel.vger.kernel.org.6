Return-Path: <linux-kernel+bounces-354880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ACA9943F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4066A1F225B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D8413D601;
	Tue,  8 Oct 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oKXDUW/v"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0EF8460;
	Tue,  8 Oct 2024 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379010; cv=none; b=GK/6ehj6LLwTRcZXEi1yrb7PT+QQ9M+ysJgIL6mwe5t5N7vrbsZQtTBVG47qPKJNpkdy24Ox+OZlf/uL3W4IwhFApb6iXwWrmivC/oCgkISJHsEmRWDYGlo2MkxJ2USjoLNEdll56baOdNirjvnpzKi2uNCmlkQEsHvANrI4dHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379010; c=relaxed/simple;
	bh=3WVuhvfAxsFrYqhGWJmOo57Ctm0VK0hxRBOs1VjAuSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBrXumTwvJk1U2gxGYST9NFhafM8V8Kf75LxUUQbXdTxEBDLL89YWpCrJi3Yoz5sE7W7tgI5Yf6AFQxLgJ8nw/KSmcf6UumgTqsuLXbHFgYWZRx4g2HnYGfck67t3CaUEx4VZ0L3p2IYO21kVwAYPyYNZiq9ViXJc0BLspWnbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oKXDUW/v; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728379006;
	bh=3WVuhvfAxsFrYqhGWJmOo57Ctm0VK0hxRBOs1VjAuSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oKXDUW/vCw07J1riK+a5FQTJoTPDUgpwEvCd+4leq5unmf9c5CZc6VhbTrvrPZSK3
	 AI9xAEX2+PEp3bz1uLu/JRjJVWnvn4Gho3onQIlj9X0/TSgcL2kpIC/4LV5GfVvAVG
	 xJxi29ZIcH4atpzcebr4AW89Eu1hc3lCvUbxEXEVEY1ogWarPUlrCtAE27UhSJBjOY
	 wKFDCgljD3I4phJlI9cfzJSf6nWaw41HzytXYv3q4rjzPDusR5a3Kw9+Eol5FM+Xpe
	 /wuUBa5aLw2ME0fOvWjNyweQndm0FC9/YrQEtQesYiqBe81gECJ99YpgtHUDCNOJZS
	 RkIO3K4qsbNPg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3761117E10D6;
	Tue,  8 Oct 2024 11:16:46 +0200 (CEST)
Message-ID: <9ab422c4-e4f8-4827-a296-a10270ab11d5@collabora.com>
Date: Tue, 8 Oct 2024 11:16:45 +0200
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




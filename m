Return-Path: <linux-kernel+bounces-354862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C539943B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543C128AD5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7246618A92B;
	Tue,  8 Oct 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jseM6zZJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FEDF58;
	Tue,  8 Oct 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378553; cv=none; b=cl7h1GeQYh4pWc5eWEcqprcBT+wG1gc7VU3o1wvV3bsY/r5mJYX6sqNCJ4V9un/GmvK2B5u2io4GgQOyqjqaX8+rTYUsby3sA5xrRF7fC8GCQ22aoHBahGo0+Mo9fgMnBCOGdEzch0aELD0rrrK9jSVD5/sf2Uu+jcoF3TSo3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378553; c=relaxed/simple;
	bh=VcBPpKEVgFfMDZkzhrWAutVnb7BL+fVfq11Zhn0EkLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz8xNvXPULXpnRY/l5o/NQnrb9MEh/w444E9vKiELALxTcuLXy9Q7q9gFh26KrZ47vXPxVgzWHjVEdoJfw+IVmyN6A1XEZFXuK8TorO5W35msEGoQKB2PaNl/VtxIzLxEckDVm/sE2nUt6cjsmPdibiZ+7jwfJ5i+S7vDLmLDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jseM6zZJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728378550;
	bh=VcBPpKEVgFfMDZkzhrWAutVnb7BL+fVfq11Zhn0EkLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jseM6zZJf+5n4xsFf6SROfF6nJz4IQhcqrTZdT0+iFaMJ3uEqlSmNv9xXeCOpseF+
	 U6Wm84NxLx+glkd5ts+2k5hamnalBeS6K/SbSBe9k3W0qOMyyXu35ZH8L10RTwQxaG
	 5eMk3skUSKkfEkd7Tz3y74gUy5Q9M1zKuG0LyLzxZb7ui23uFje5PcLw5S35A/J67T
	 C/o/qn4qUePWiwE682hhg9MpPjYPEZq6Y2rCKpxxdurFTolHoA9Z6hgPaaGDWY6o1X
	 +PnCRM8mUsfmIW3KsuqY8g2jKs96J/HKRgaB96hL8b7UqQNlc0OHm/mX5ZkbvtwHb/
	 zw/3rkgrXFFQQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B3B117E10D3;
	Tue,  8 Oct 2024 11:09:09 +0200 (CEST)
Message-ID: <e9277edf-d372-4a8e-881c-49a907f0a883@collabora.com>
Date: Tue, 8 Oct 2024 11:09:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8195: Fix dtbs_check error for
 tphy
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Seiya Wang <seiya.wang@mediatek.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20241008071540.32607-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241008071540.32607-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/10/24 09:15, Macpaul Lin ha scritto:
> The u3phy1 node in mt8195.dtsi was triggering a dtbs_check error.
> The error message was:
>    t-phy@11e30000: 'power-domains' does not match any of the regexes:
>      '^(usb|pcie|sata)-phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> Fix this issue by dropping 'power-domains' of u3phy1 node.
> 
> This is because MediaTek tphy dose not need to add mtcmos.  It is not
> necessary to add 'power-domains'. If the power of the tphy is turned off,
> it will affect other functions. From the current USB hardware design
> perspective, even if mtcmos is added to the phy, it is always on.
> 
> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> Changes for v2:
>   - Add detail description of the tphy design for explaining the reason
>     of this change.
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index ade685ed2190..1c6f08dde31c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1920,7 +1920,6 @@ u3phy1: t-phy@11e30000 {
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   			ranges = <0 0 0x11e30000 0xe00>;
> -			power-domains = <&spm MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY>;
>   			status = "disabled";
>   
>   			u2port1: usb-phy@0 {




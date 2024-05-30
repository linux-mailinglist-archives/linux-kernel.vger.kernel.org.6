Return-Path: <linux-kernel+bounces-195226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B38D4939
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A29B1F22668
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286A017C7C2;
	Thu, 30 May 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rWZHEG0L"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B623176AA7;
	Thu, 30 May 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063425; cv=none; b=HqTfPd9sGR/tCaaNcVKngExH4hh5xWB0ICCQ2NPzlqcIOHCEx11RofD+fOxNEG+qZpLua7I3rBT6Cf14eq/i0aO8E1j1Kw12N2TTkK2Mft0KcS/CxsdbcMxP/nJYt/hxKLpXu7O9/unwPhJFURYBSP+CLTo5BvDTtLK/bqJSVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063425; c=relaxed/simple;
	bh=vM8aBy1EFJ3SUlY6OijOqDmrHOooruLWDwMTT3MCdpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPZePvRiyqIXUNog1U8x2sHELNoQg8oVvuwUApNs4NDh8HKzLSfv5fI4P8v9CMINLypG//yQnmFXHZ59HfysZWmKn3nMr9ttlC0gEUp45LlDLWUKDzcRj5ADGmpTq9n545wO3DbuhrgGGZKRq2+hM9g+inicnAkD7q4eTTZXWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rWZHEG0L; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717063422;
	bh=vM8aBy1EFJ3SUlY6OijOqDmrHOooruLWDwMTT3MCdpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rWZHEG0Ll21lZ+BMbIT5Z99zrIB5oW9lp4FEllue5LfVEDLKNFYWl2udQA4XxhqA1
	 4sHi7VuFaBfQn9FSlKhidfGVFjlpEWt/+D6NZ757sSU+WxPTUX88qnDWxeIcs6n3vD
	 zdlBNBDNo6ph9SFAGamYDtDTp5Q2mOgMMLOCuNz8rpQcG35rqFskI5wp+N9O3omOuS
	 V7VLbzIRyWuDdj8E6F9zISJgEw9lTwPDao7lX5ZNRYerOBAq4MNPP2OHUgmDfjyEY/
	 Hn+5ZHpYqymwNpsHzUbpE/6Gwg/YIWLpQaB2EntCCbubz4ifO2hSN65FqNNDpobJE9
	 BRYfWAGkEcgXg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7A76B37821AD;
	Thu, 30 May 2024 10:03:41 +0000 (UTC)
Message-ID: <4f20f130-c9ab-43ea-a758-e29d7be10db0@collabora.com>
Date: Thu, 30 May 2024 12:03:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power
 domain clock
To: Chen-Yu Tsai <wenst@chromium.org>, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240530083513.4135052-1-wenst@chromium.org>
 <20240530083513.4135052-6-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240530083513.4135052-6-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/05/24 10:35, Chen-Yu Tsai ha scritto:
> The MFG_ASYNC domain, which is likely associated to the whole MFG block,
> currently specifies clk26m as its domain clock. This is bogus, since the
> clock is an external crystal with no controls. Also, the MFG block has
> a independent CLK_TOP_AXI_MFG_IN_SEL clock, which according to the block
> diagram, gates access to the hardware registers. Having this one as the
> domain clock makes much more sense. This also fixes access to the MFGTOP
> registers.
> 
> Change the MFG_ASYNC domain clock to CLK_TOP_AXI_MFG_IN_SEL.
> 
> Fixes: 8b6562644df9 ("arm64: dts: mediatek: Add mt8173 power domain controller")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Just one question... what happens if there's no GPU support at all and this
power domain gets powered off?

I expect the answer to be "nothing", so I'm preventively giving you my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...but if I'm wrong and the answer isn't exactly "nothing", then I still agree
with this commit, but only after removing the Fixes tag.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 3458be7f7f61..136b28f80cc2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -497,7 +497,7 @@ power-domain@MT8173_POWER_DOMAIN_USB {
>   				};
>   				mfg_async: power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
>   					reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
> -					clocks = <&clk26m>;
> +					clocks = <&topckgen CLK_TOP_AXI_MFG_IN_SEL>;
>   					clock-names = "mfg";
>   					#address-cells = <1>;
>   					#size-cells = <0>;




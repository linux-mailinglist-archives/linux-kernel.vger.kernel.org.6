Return-Path: <linux-kernel+bounces-213045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A31CC906A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AE81F21E44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37799142910;
	Thu, 13 Jun 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SFFaswTd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33ED1428F0;
	Thu, 13 Jun 2024 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275478; cv=none; b=FdAfWO1ljxmzRt9R34fMuXfZU47jppvF/3Jmt2XcLWwnQVQaWeFN3Wc80J5fuoUtNhSEaZBOA9TP2jIl0qqLKDKbtn1UCEJ/g1z43JErFBG2R3phSMp11TrU/QzyKwgXOXbb9ohG1QVzfY41pjO8NrXmy0vUFEQYLMrcOSsEORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275478; c=relaxed/simple;
	bh=KETQz0HyeS4By8DZMxlCIfM4b04lhUdibaoc0Fm4HuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUCp4Njd3kvN9oVER+1QBDH8xMMcEkOhT7Cjfxwls5C3CCO97/vQkqBv7KxiGjR3u97k/o6WNLINP78ji9/jaUSuTlJXXwiwS1KBNAgegJaE2mKtGSl1yEKSyzdr3JGy7NYm+2vBvyItXgWkHvrta4262/HyHB/0bdW3/SPZSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SFFaswTd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718275474;
	bh=KETQz0HyeS4By8DZMxlCIfM4b04lhUdibaoc0Fm4HuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SFFaswTd6pHuemvGJL2EMC7gN1m4bgZ6247ZOJCTYL7SSdejhqNu9hkISJ8wOkRdY
	 3P1cqfz7RRFl6SGjl2uRL3+4inlL3w5xkBDdI7v1EmaReycafsi44LfDqEmKN8H3Y6
	 tAdJCLeK3H93AQyZsXVHDGOK+M3MxCmykkpn+zzdmL1isQF6gxx0vlmbU5Pp+0u+Gb
	 71sJyEoZIrzvkTZGMqrJ9q0D54STIqGhsqsSxNmNlITL2R84kBBxLSYuMXlZQd9Dea
	 puwhFTnIumsJuLnfDvBWbYkyLGsIcXmJg/AI+vq4zUiUYjI/oqpzgDC0w3Q85cDsO0
	 iRmkrw2BNywsA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 38883378216D;
	Thu, 13 Jun 2024 10:44:34 +0000 (UTC)
Message-ID: <b6f22891-4e5f-4df0-8234-eadab9619cb2@collabora.com>
Date: Thu, 13 Jun 2024 12:44:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: Fix the value of `dlg,jack-det-rate` mismatch
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20240613-jack-rate-v1-1-62ee0259e204@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240613-jack-rate-v1-1-62ee0259e204@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/06/24 12:19, Hsin-Te Yuan ha scritto:
> According to Documentation/devicetree/bindings/sound/dialog,da7219.yaml,
> the value of `dlg,jack-det-rate` property should be '32_64' instead of
> '32ms_64ms'.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Please, two separated commits, one for RockChip, one for MediaTek and
also please add the relevant Fixes tags, so that this can be backported.

arm64: dts: rockchip: rk3399-gru: .....
arm64: dts: mediatek: mt8183-kukui: ....

Thanks,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi | 2 +-
>   arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
> index 8b57706ac814..586eee79c73c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
> @@ -27,7 +27,7 @@ da7219_aad {
>   			dlg,btn-cfg = <50>;
>   			dlg,mic-det-thr = <500>;
>   			dlg,jack-ins-deb = <20>;
> -			dlg,jack-det-rate = "32ms_64ms";
> +			dlg,jack-det-rate = "32_64";
>   			dlg,jack-rem-deb = <1>;
>   
>   			dlg,a-d-btn-thr = <0xa>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index 789fd0dcc88b..3cd63d1e8f15 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -450,7 +450,7 @@ da7219_aad {
>   			dlg,btn-cfg = <50>;
>   			dlg,mic-det-thr = <500>;
>   			dlg,jack-ins-deb = <20>;
> -			dlg,jack-det-rate = "32ms_64ms";
> +			dlg,jack-det-rate = "32_64";
>   			dlg,jack-rem-deb = <1>;
>   
>   			dlg,a-d-btn-thr = <0xa>;
> 
> ---
> base-commit: cea2a26553ace13ee36b56dc09ad548b5e6907df
> change-id: 20240613-jack-rate-c478fa76ce19
> 
> Best regards,



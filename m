Return-Path: <linux-kernel+bounces-340127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE572986ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CF128339E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE201A76DF;
	Thu, 26 Sep 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O8ISMLjX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A51A4E8E;
	Thu, 26 Sep 2024 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339620; cv=none; b=PWmXaKHfnDgtsUt899lrJBs9C815sw7Q9HnU6kiVGCkKH2JJdYGK8DonQitzBfjzTg0XDaFs6IrG17huGaeZMEqCSB+rQR0ElOEmTviUVmUz+mfe7swdXgzK84Lb7gNCXfCkN4EcC0GRncTAC29snHITTIeRsbR8ECGMKX1/GfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339620; c=relaxed/simple;
	bh=kMQ9AayeBKAG8ZAFHg7xt8cXjGqj9KatwkRbtyERWiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hI6WZV/IHYsD41DZqj4Bwd0uFV9VVYyNX0C/Bhbr+YujCYDhNA15yzQE0zlJN+C9zjwfRAXzqFqeSXnvaGwdN0BoxrmajK80NxBczKQHroTf96hjj9EmIUfBugBarqoV2UpOsULx/Z8gMRr7tthPzmbETf/x/TegPip3jO5xNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O8ISMLjX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727339616;
	bh=kMQ9AayeBKAG8ZAFHg7xt8cXjGqj9KatwkRbtyERWiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O8ISMLjXw8XkW2m7YYdxEU20NKBIZ8sfkClchsTPT51Pv56kTqRE/wyLcBbibcTlz
	 Ic/bSzkHOTZj08ZoivPD1R669H2g0DafZgumX1G6nXQJzqPDSFW+4gZtGe9LKmVYRa
	 Sser/d1MjB94czNP/Sk8D0yyXG0q5hZvhQOM/XY4XlMs9o2uqxMZqNo0SuKlq9MgDz
	 tbmnmHvIvgauLJWVZmdSGswQJBC9sd/Pblwp18PjXip+Ci0usTeYu5K61hcNeyFxVb
	 d2en1Qyx2o+wUIqgj/FnK/wDbOgCK00AjUMNOuEfVMvtwuHA54hgeTlJgOwyf5xkB/
	 nsYOZa9FUZ5IA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 604CA17E1080;
	Thu, 26 Sep 2024 10:33:36 +0200 (CEST)
Message-ID: <b3842173-7074-4bcb-80f4-1f6f8cb38a52@collabora.com>
Date: Thu, 26 Sep 2024 10:33:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: mediatek: mt8188: Move vdec1 power domain
 under vdec0
To: Fei Shao <fshao@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240925110044.3678055-1-fshao@chromium.org>
 <20240925110044.3678055-6-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240925110044.3678055-6-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/24 12:57, Fei Shao ha scritto:
> There are two hardware IP blocks in MT8188 video decoder pipeline:
> vdec-lat and vdec-core, which are powered by vdec0 and vdec1 power
> domains respectively.
> 
> We noticed that vdec-core needs to be powered down before vdec-lat
> during suspend to prevent failures. It's unclear if it's an intended
> hardware design or due to power isolation glitch. But in any case, we
> observed a power-off sequence here, and it can be considered as an
> indirect dependency implication between the vdec0 and vdec1 domains.
> 
> Given that, update vdec1 as a sub-domain of vdec0 to enforce the
> sequence. Also, use more specific clock names for both power domains.
> 

As far as I know, yes, there is a sequence:
  - Cores (mtk-vcodec-core) gets suspended first
  - Then the LATs gets suspended (mtk-vcodec-lat)
  - Finally, the LAT SoC gets suspended (mtk-vcodec-lat-soc)

...but you checked that downstream, and your downstream misses the lat-soc HW
instance, and only has the lat one.

Are you sure that this is not the reason why you're getting this issue? :-)

Otherwise, I feel like we must ask for some clarification from MediaTek, as
I'm mostly sure that the two cores are independent from each other (but I
might, of course, be wrong!).

Cheers,
Angelo

> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index ff5c8e0597f9..a6cd08ea74eb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -1064,20 +1064,22 @@ power-domain@MT8188_POWER_DOMAIN_VPPSYS1 {
>   							#power-domain-cells = <0>;
>   						};
>   
> -						power-domain@MT8188_POWER_DOMAIN_VDEC1 {
> -							reg = <MT8188_POWER_DOMAIN_VDEC1>;
> -							clocks = <&vdecsys CLK_VDEC2_LARB1>;
> -							clock-names = "ss-vdec";
> -							mediatek,infracfg = <&infracfg_ao>;
> -							#power-domain-cells = <0>;
> -						};
> -
>   						power-domain@MT8188_POWER_DOMAIN_VDEC0 {
>   							reg = <MT8188_POWER_DOMAIN_VDEC0>;
>   							clocks = <&vdecsys_soc CLK_VDEC1_SOC_LARB1>;
> -							clock-names = "ss-vdec";
> +							clock-names = "ss-vdec1-soc-l1";
>   							mediatek,infracfg = <&infracfg_ao>;
> -							#power-domain-cells = <0>;
> +							#address-cells = <1>;
> +							#size-cells = <0>;
> +							#power-domain-cells = <1>;
> +
> +							power-domain@MT8188_POWER_DOMAIN_VDEC1 {
> +								reg = <MT8188_POWER_DOMAIN_VDEC1>;
> +								clocks = <&vdecsys CLK_VDEC2_LARB1>;
> +								clock-names = "ss-vdec2-l1";
> +								mediatek,infracfg = <&infracfg_ao>;
> +								#power-domain-cells = <0>;
> +							};
>   						};
>   
>   						cam_vcore: power-domain@MT8188_POWER_DOMAIN_CAM_VCORE {




Return-Path: <linux-kernel+bounces-213027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D14906A06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3F8B2250C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53C0142627;
	Thu, 13 Jun 2024 10:30:31 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BC136663;
	Thu, 13 Jun 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274631; cv=none; b=cuAhEa6sAhLJc6KJ8yCcSd2TM0EeDVkTO+cGowzPQlT9p25M6BijkYw/0NJktgcdUwarR7XZPBeyflyFzn7SRaPZpOSvuuKHVB8ABL9QvsixzXGlL8qjJ20Fs5906N6PO6jND3Q4c4kB1/Rr/52Gqz+2UViWc5H5xn6Vncp+4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274631; c=relaxed/simple;
	bh=IvFHXQxoE5aDG5AbKQyVnth/fN9XqZgnuX8AKhKfLDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNcly7rTJkAUWhppR/jvjtZamAoRghbHYwQh+ES80k0zk2wG96NxsYvjaepg+0NKwZU4jsdfH8Ub15CSOlsTclfqqB+3YeOUC14kXiy20tvbELAlP/CirpGqRa2M3Oew6E+rxdx3BivuifAuBiCuMZMJd730WS0TpEcs6IuHEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875be5.versanet.de ([83.135.91.229] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sHhim-0000ZZ-PL; Thu, 13 Jun 2024 12:30:20 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: Re: [PATCH] arm64: dts: Fix the value of `dlg,jack-det-rate` mismatch
Date: Thu, 13 Jun 2024 12:30:19 +0200
Message-ID: <13119127.ZYm5mLc6kN@diego>
In-Reply-To: <20240613-jack-rate-v1-1-62ee0259e204@chromium.org>
References: <20240613-jack-rate-v1-1-62ee0259e204@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Donnerstag, 13. Juni 2024, 12:19:58 CEST schrieb Hsin-Te Yuan:
> According to Documentation/devicetree/bindings/sound/dialog,da7219.yaml,
> the value of `dlg,jack-det-rate` property should be '32_64' instead of
> '32ms_64ms'.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                | 2 +-

sub architectures (Mediatek, Rockchip) are mostly handled by different
people. So it's good to split patches along those lines in the future.

For this change in particular I'm not that concerned in that regard and
am also fine with the Rockchip part going through the Mediatek tree.

I've checked the binding and for the rk3399-gru change:
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Thanks
Heiko

>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
> index 8b57706ac814..586eee79c73c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
> @@ -27,7 +27,7 @@ da7219_aad {
>  			dlg,btn-cfg = <50>;
>  			dlg,mic-det-thr = <500>;
>  			dlg,jack-ins-deb = <20>;
> -			dlg,jack-det-rate = "32ms_64ms";
> +			dlg,jack-det-rate = "32_64";
>  			dlg,jack-rem-deb = <1>;
>  
>  			dlg,a-d-btn-thr = <0xa>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index 789fd0dcc88b..3cd63d1e8f15 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -450,7 +450,7 @@ da7219_aad {
>  			dlg,btn-cfg = <50>;
>  			dlg,mic-det-thr = <500>;
>  			dlg,jack-ins-deb = <20>;
> -			dlg,jack-det-rate = "32ms_64ms";
> +			dlg,jack-det-rate = "32_64";
>  			dlg,jack-rem-deb = <1>;
>  
>  			dlg,a-d-btn-thr = <0xa>;
> 
> ---
> base-commit: cea2a26553ace13ee36b56dc09ad548b5e6907df
> change-id: 20240613-jack-rate-c478fa76ce19
> 
> Best regards,
> 






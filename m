Return-Path: <linux-kernel+bounces-439369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5150A9EAE33
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258B21888E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA69B12E4A;
	Tue, 10 Dec 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XJbG1lW0"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98A1DC982;
	Tue, 10 Dec 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827555; cv=none; b=NjDXQ4GCgM+YRwrjozbhpfAAwrs9blEIbe51yy5kz5vZK7yNEKw/OBZ/6Xc7E17TPOFnZATE1Howcii8BUHHy2lErWmxG1ov3VUz/IWjgpAthY99hFBkreHrOWc3ZrJ9HcpN1m3+mvUzd+gsc8+0kUTL8+ENKE8UqGiKBHiTcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827555; c=relaxed/simple;
	bh=KcuRT9gwOX+t8q9/p363S/BIEnItmU1RXAbOOJJIRJA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iDdxNmCaFL4hcwrYiRhAc6IclG/p3Btl4omEsjbK/MbEBsj88VXpvUSbqixie2VoqBYaqY+BU6g7FzAwUG/3Cwp+yj18X1beCaXSTDX+GueLwEaP6Fbj00xk/AkZYfM+99LCQI92rgVJldwkhCuBUytFKpI7lXAh+3PYC42k3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=XJbG1lW0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733827551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utTTuCvuh3w8J6nQIZy3AvdY9OBVE0hycTiZtgTEi6Y=;
	b=XJbG1lW0Cdd/1WVz8664gHslMX0L0NGOdEauAEbidL2Gz+zZANyaa5m3Y7MF+Jwx1FK1wx
	pqqqBhccPr0qh6EnZzwULif0FUZQ66Kxwgzs8vQB8yte7weND74C9EaecXpmqCgEglz0BF
	qFpD2qwgBraLaXi75Xt3CbLWHoxlNT2gf2NBcVG0NPl8XRo0iAyxPXCf52e4vWk8401iYh
	o9JK+th0SkNNtJx9t8m+GcLRSdvklGZGjF5jzws2NlAZxVD+uvUfVCoZb28YVZ2bhaxxxB
	Ur1oPJd18Q8Rtn2REqhJNcictZvuw6q2QD1ubROxoc/dBFmPPYJzGwR097EJOg==
Date: Tue, 10 Dec 2024 11:45:49 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>, Johan Jonker <jbx6244@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: dts: rockchip: Remove address aligned beats
 from rk3328-roc
In-Reply-To: <20241210013010.81257-7-pgwipeout@gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-7-pgwipeout@gmail.com>
Message-ID: <2b68c2dd3618e5904a4eac1ec87d29a7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Peter,

Thanks for the patch.  Please, see some comments below.

On 2024-12-10 02:30, Peter Geis wrote:
> Since commit 8a469ee35606 ("arm64: dts: rockchip: Add txpbl node for
> RK3399/RK3328"), the snps,aal, snps,txpbl, and snps,rxpbl nodes have
> been unnecessary in the separate device trees. There is also a
> performance loss to using snps,aal. Remove these from the rk3328-roc
> device tree.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> 
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> index 6984387ff8b3..0d476cc2144d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> @@ -155,12 +155,9 @@ &gmac2io {
>  	phy-mode = "rgmii";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&rgmiim1_pins>;
> -	snps,aal;

Huh, I see that quite a few RK3328 board dts files specify
the snps,aal node.  I wonder was it a "cargo cult" approach
at play, :) or was there some real need for it?

Actually, I see now that you added snps,aal to rk3328-roc-
cc.dts in the commit 393f3875c385 ("arm64: dts: rockchip:
improve rk3328-roc-cc rgmii performance."), so I guess that
your further research and testing showed that it actually
isn't needed for Ethernet stability?

>  	snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
>  	snps,reset-active-low;
>  	snps,reset-delays-us = <0 10000 50000>;
> -	snps,rxpbl = <0x4>;
> -	snps,txpbl = <0x4>;

Unless I'm missing something, the commit 8a469ee35606 ("arm64:
dts: rockchip: Add txpbl node for RK3399/RK3328") doesn't add
the snps,rxpbl node to the RK3328 SoC dtsi, and the respective
driver does nothing about it when the snps,txpbl node is found.

Though, I see that rk3328-rock-pi-e.dts is the only other
RK3328 board dts file that specifies the snps,rxpbl node, so
it seems that removing the snps,rxpbl node here should be safe,
especially because it was you who added it in the same commit
mentioned above.  If there were some SoC-level issues, all
RK3328 boards would've needed it.

>  	tx_delay = <0x24>;
>  	rx_delay = <0x18>;
>  	status = "okay";


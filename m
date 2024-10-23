Return-Path: <linux-kernel+bounces-377223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA029ABB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AE71C21084
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14A49659;
	Wed, 23 Oct 2024 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mBI0CMSz"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562C51C5A;
	Wed, 23 Oct 2024 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650492; cv=none; b=HhFTkGDJDL4FTiKLx4k0iOIm/3zrlvALKLPjxcAvA4qzbinjTkYmlwYHYdi2VTju3UoCZdD/2ESyJXStkxFOKj9iBPrmd6JkMVCkE8Tuuum+RsuU3yKoYcDezqmMepsPkEvXBk2VQ89YrutNDcOPqJGxdrO4aJat0Xp9cFnWQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650492; c=relaxed/simple;
	bh=5YgZWN0FSnvAUUOW8PG/vGbazwm/77Rke6f+PmF5WrU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bVSh2vKDbDKtZGe+gSOQlwXjEKpMOeNqeHOU+N1jQGX8rHLLZYizX8gcWawRu2pqM2paBOsg7AkFgyTN0UDUhCjHBuMlGncUtqGiEmPJwDEOzqQMgjv8AeSJPiaZwaTJ3KozQUbf3FZDYtrO4CS32ZJNVncbh35avLk6s1hXZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=fail smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mBI0CMSz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729650488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPF02x/3XuMAe6LpdRIXWrJKdwRi5Z9k99f3PM62XZ8=;
	b=mBI0CMSzZLumzLD2ffsd8EXjlhn40IUot7xmrlISwW2Udl1PSSI44IWK1dNvEkkZqKf9bJ
	RFPN1og6gAtOjg0q/awkPY+iAvij7vB/dnaonF1RBDX6QuMex/haAcTsmbGbBWF6BL2F1C
	qCWxRANtQ55qY0j/73Ylm58ltYygPpopHerSJUij8cQd0JYKK/7eMBxqY2C7taMDU7D4xM
	PhEJPGnoRdNfFsxY0etVGiDpWu6XP0Jwjhk92WiGic/A4gpF8QiCHpO9L7dtIeSKocRfUo
	Lyc2LWwxEn/vp95lWyO2Lp/sFJiKSxK7u7kuU3hu/n8iDJaMXJI5DO+yE3KzFA==
Date: Wed, 23 Oct 2024 04:28:06 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-rockchip@lists.infradead.org, Samuel Holland
 <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Correct GPIO polarity on brcm BT
 nodes
In-Reply-To: <20241018145053.11928-2-didi.debian@cknow.org>
References: <20241018145053.11928-2-didi.debian@cknow.org>
Message-ID: <32d1b0cd30e5464e6744f7f1d87d745d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-10-18 16:45, Diederik de Haas wrote:
> Paragraph "3.4 Power up Timing Sequence" of the AzureWave-CM256SM
> datasheet mentions the following about the BT_REG_ON pin, which is
> connected to GPIO0_C4_d:
> 
>   When this pin is low and WL_REG_ON is high,
>   the BT section is in reset.
> 
> Therefor set that pin to GPIO_ACTIVE_HIGH so that it can be pulled low
> for a reset.
> If set to GPIO_ACTIVE_LOW, the following errors are observed:
> 
>   Bluetooth: hci0: command 0x0c03 tx timeout
>   Bluetooth: hci0: BCM: Reset failed (-110)
> 
> So fix the GPIO polarity by setting it to ACTIVE_HIGH.
> This also matches what other devices with the same BT device have.
> 
> Fixes: a3a625086192 ("arm64: dts: rockchip: Fix reset-gpios property
> on brcm BT nodes")
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

I'm a bit late to the party, :) but just wanted to confirm that
the information provided in the patch description is correct.

> ---
> Changes in v2:
> - Better commit description with references to the datasheet
> - Dropped the (self-)blame as it's not useful to evaluate the 
> usefulness
>   of this patch
> 
>  arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> index a477bd992b40..0131f2cdd312 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> @@ -688,7 +688,7 @@ bluetooth {
>  		host-wakeup-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
>  		pinctrl-0 = <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
>  		pinctrl-names = "default";
> -		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
> +		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
>  		vbat-supply = <&vcc_wl>;
>  		vddio-supply = <&vcca_1v8_pmu>;
>  	};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
> index e9fa9bee995a..1e36f73840da 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
> @@ -404,7 +404,7 @@ bluetooth {
>  		host-wakeup-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_HIGH>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&bt_host_wake_h &bt_reg_on_h &bt_wake_host_h>;
> -		shutdown-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_LOW>;
> +		shutdown-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
>  		vbat-supply = <&vcc_3v3>;
>  		vddio-supply = <&vcc_1v8>;
>  	};


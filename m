Return-Path: <linux-kernel+bounces-248845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72B92E2A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEDC282973
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CB515251C;
	Thu, 11 Jul 2024 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="yf6OX+Ww"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363AB1514EF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687418; cv=none; b=Z3Xu7CZH4FFUGRYvpWhEcrW5kWA3WUJUfOpf4wUDVCi4I0CFT3jvSQJVkaADdSAlRnMxt2hGCgeLG5YbtXb1cj3B3EXtfjbj6G7IWg3yPb3BByBxMq6bqL4vZxQC4POhMF9k7gHZku+aeGIGCHVMKCXBKwhSKo8C4VJtbwz+SaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687418; c=relaxed/simple;
	bh=Z09fS+At1jYk0KAjNpfgIJN3HcOBE2BJSY3HNrlDiN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLHqEf7YfQQNoNC2F/NFqIH7h4amenK3kKtRoD/Kznkcj604MxPwFDh45bsWwTKPLTNJR60Yj/FmVkocbGX8uRIB1iYYvW9hLxq4g+k9Cr2mrVmIpmewW+CoErCUytohzCg8+/mvsCidlZPC0RwXCeF3CwzCIMCWtvVL/AEnITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=yf6OX+Ww; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1720687400;
 bh=1Q85VnghNs5hkwDn1aNHDbw1L6VAgcZyl3McRTNEi7Q=;
 b=yf6OX+Ww2wLBow47PAgktVj16q/QAQJEwX1+EQ4TiKsI3BKIDshfduZZ1aq5P97gris3Sc4zM
 v7dA3WnCPvBeQLgovi6OT/VH+VTVpYR917h/dBpGaxVBOcEm+J9/0EoEo7J91XVs87P2K8AqV+O
 SiUM0HxaVVrJ4Eg1mOzxAMJDnZOq+js8E2LktqXT8t/rzQSZpuVuBGkOk5B8JnKPQB1H2/sjLoI
 GRzSise/HR22UUMcdTOGNo86y6GdW4MxR0rlb2V0fSZeD3BbM8sM6M7uyo2D6ONGn7+6Wc0ljO8
 FZpfuyHXiiVrCJf87NRxr8nJH90l48x4mcP3zjsyJFng==
Message-ID: <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
Date: Thu, 11 Jul 2024 10:43:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4
 node
To: Anand Moon <linux.amoon@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240711060939.1128-1-linux.amoon@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240711060939.1128-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 668f9b244502e8d75e871b7e

Hi Anand,

On 2024-07-11 08:09, Anand Moon wrote:
> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> signals.Each component of PCIe communication have the following control
> signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
> high-speed signals and communicate with other PCIe devices.
> Used by root complex to endpoint depending on the power state.
> 
> PERST is referred to as a fundamental reset. PERST should be held low
> until all the power rails in the system and the reference clock are stable.
> A transition from low to high in this signal usually indicates the
> beginning of link initialization.
> 
> WAKE signal is an active-low signal that is used to return the PCIe
> interface to an active state when in a low-power state.
> 
> CLKREQ signal is also an active-low signal and is used to request the
> reference clock.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> V2: Update the commit messge to describe the changs.
>     use pinctl group as its pre define in pinctl dtsi
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index 2e7512676b7e..ab3a20986c6a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -301,7 +301,7 @@ &pcie30phy {
>  
>  &pcie3x4 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie3_rst>;
> +	pinctrl-0 = <&pcie30x4m1_pins>;

Use of the existing pcie30x4m1_pins group may not be fully accurate for
the PERST pin. The use of reset-gpios indicate that the PERST pin is
used with GPIO function and the driver will implicitly change the
function from perstn_m1 to GPIO. So this may not be best representation
of the hw, hence my initial suggestion, something like:

	pcie30x4_pins: pcie30x4-pins {
		rockchip,pins =
			<4 RK_PB4 4 &pcfg_pull_none>,
			<4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
			<4 RK_PB5 4 &pcfg_pull_none>;
	};

Similar change should probably also be done for pcie2x1l0 and pcie2x1l2,
not just pcie3x4.

Regards,
Jonas

>  	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>  	vpcie3v3-supply = <&vcc3v3_pcie30>;
>  	status = "okay";
> @@ -341,10 +341,6 @@ pcie2_2_rst: pcie2-2-rst {
>  	};
>  
>  	pcie3 {
> -		pcie3_rst: pcie3-rst {
> -			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
>  		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
>  			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
> 
> base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905



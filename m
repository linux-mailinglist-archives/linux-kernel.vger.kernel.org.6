Return-Path: <linux-kernel+bounces-280744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F068F94CE83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41500B212C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AC11922C9;
	Fri,  9 Aug 2024 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="k9Ni1dmH"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024721922E2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198850; cv=none; b=NYY0OwFge+vRZ+g9IIdibIgyR4ro05EsqGILmFTv8A9NzgUjNLLFHSozZw8h4jmdCoM9okaTd07zZjJnS07yqP7Uo1Ay1NDgrsP3DWDONTD5P4qnrdVEKr4QsKWoNniphC7JLPqa0xMxCm7YLJIaFXxcgrNbF01TSsi7XQfBAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198850; c=relaxed/simple;
	bh=SMzcdYFvMjTzaYN1elvm5cK56QJk4Z4R1xqPoyL0vho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UroC+fCgDlFTbAhEGaiENGDKPywIvJHcZb9wUpx0jIC08aiI73kaXIIuqy3isD1zOLv/DnX5TQyvp26VQNdyKxq7bPzAoaTExA66mmDCcez3EjUYgK1A7sWtGN8qbg0GGNnRVNkyKHlstsh9hSbKclxYQBLCPNspimoa8FPqxS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=k9Ni1dmH; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1723198842;
 bh=OO67g+83piiNdnui6ZP/Dz8vFOwmBNOFhFvNVMXIXKM=;
 b=k9Ni1dmH4apkeZzlNLmVAUWgb8Q0ITEvQiQnoWM+dKP8FgyKV7po0IO/ih4Qmyw9OGzKbvY/p
 vsRs+CFCLus/7SIJG85795AXrL8OnXijgmNWudiSEV3CvXMXw1E2EROzcg5Of8RQHZgHX3YVjow
 yQNp4TSl+LC4CQmhIcar11YWXVOFovsOIOsGzpc3+kPcAx2WsbJ0GfLKaje0sDSigFb+mwDJsNU
 bn3x5e4Eia4QfRWWqHtrO5rHkQ75UQdmtWXmVRTc9RtYVikxY80b7YQmkSJPfaiX482FeZJ1UH2
 3bJH7WjgBAOPQSOB0bHhrgIxKx/0Bx1aXUq6R3V0XgiA==
Message-ID: <17c5e90e-a99d-4e4d-bc18-0366019f0bcf@kwiboo.se>
Date: Fri, 9 Aug 2024 11:59:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: rockchip: Add missing pinctrl wake and
 clkreq for PCIe node
To: Anand Moon <linux.amoon@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dragan Simic
 <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240729123709.2981-1-linux.amoon@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240729123709.2981-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66b5e899527e81fbd62263f5

Hi Anand,

On 2024-07-29 14:37, Anand Moon wrote:
> Add missing pinctrl settings WAKE and CLKREQ for PCIe 3.0 x4, PCIe 3.0 x1
> and PCIe 2.1 x1 nodes. Each component of PCIe communication have the
> following control signals: PERST, WAKE, CLKREQ, and REFCLK.
> These signals work to generate high-speed signals and communicate with
> other PCIe devices. Used by root complex to endpoint depending on
> the power state.
> 
> PERST# is referred to as a fundamental reset. PERST should be held
> low until all the power rails in the system and the reference clock
> are stable. A transition from low to high in this signal usually
> indicates the beginning of link initialization.
> 
> WAKE# signal is an active-low signal that is used to return the PCIe
> interface to an active state when in a low-power state.
> 
> CLKREQ# signal is also an active-low signal and is used to request the
> reference clock.  L1 sub-states is providing a digital signal
> (CLKREQ#) for PHYs to use to wake up and resume normal operation.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v5: Merged all 3 patch into single patch, reabse on master
>     Fix the $subject and commit message.
>     Drop the RK_FUNC_GPIO for WAKE and CLKREQ as these seignal are
>     ment for was introduced to allow PCI Express devices to enter
>     even deeper power savings states (“L1.1” and “L1.2”) while still
>      appearing to legacy software to be in the “L1” state
> ---
>  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 46 +++++++++++++------
>  1 file changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index 966bbc582d89..a1e83546f1be 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -318,7 +318,7 @@ map2 {
>  
>  &pcie2x1l0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_0_rst>;
> +	pinctrl-0 = <&pcie30x1_pins>;
>  	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
>  	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
>  	status = "okay";
> @@ -326,7 +326,7 @@ &pcie2x1l0 {
>  
>  &pcie2x1l2 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_2_rst>;
> +	pinctrl-0 = <&pcie20x12_pins>;
>  	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
>  	vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
>  	status = "okay";
> @@ -338,7 +338,7 @@ &pcie30phy {
>  
>  &pcie3x4 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie3_rst>;
> +	pinctrl-0 = <&pcie30x4_pins>;
>  	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>  	vpcie3v3-supply = <&vcc3v3_pcie30>;
>  	status = "okay";
> @@ -363,28 +363,48 @@ hp_detect: hp-detect {
>  		};
>  	};
>  
> -	pcie2 {
> -		pcie2_0_rst: pcie2-0-rst {
> -			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +	pcie20x1 {
> +		pcie20x12_pins: pcie20x12-pins {
> +			rockchip,pins =
> +				/* PCIE20_1_2_CLKREQn_M1_L */
> +				<3 RK_PC7 4 &pcfg_pull_up>,
> +				/* PCIE_PERST_L */
> +				<3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>,
> +				/* PCIE20_1_2_WAKEn_M1_L */
> +				<3 RK_PD0 4 &pcfg_pull_up>;

Some unanswered questions from v4:

How come you use internal pull-up/down on these pins?
And why do they differ for each pcie node in this series?

Regards,
Jonas

>  		};
> +	};
>  
> +	pcie30x1 {
>  		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
>  			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  
> -		pcie2_2_rst: pcie2-2-rst {
> -			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		pcie30x1_pins: pcie30x1-pins {
> +			rockchip,pins =
> +				/* PCIE30x1_0_CLKREQn_M1_L */
> +				<4 RK_PA3 4 &pcfg_pull_down>,
> +				/* PCIE30x1_0_PERSTn_M1_L */
> +				<4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_down>,
> +				/* PCIE30x1_0_WAKEn_M1_L */
> +				<4 RK_PA4 4 &pcfg_pull_down>;
>  		};
>  	};
>  
> -	pcie3 {
> -		pcie3_rst: pcie3-rst {
> -			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> +	pcie30x4 {
>  		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
>  			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
> +
> +		pcie30x4_pins: pcie30x4-pins {
> +			rockchip,pins =
> +				/* PCIE30X4_CLKREQn_M1_L */
> +				<4 RK_PB4 4 &pcfg_pull_up>,
> +				/* PCIE30X4_PERSTn_M1_L */
> +				<4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>,
> +				/* PCIE30X4_WAKEn_M1_L */
> +				<4 RK_PB5 4 &pcfg_pull_down>;
> +		};
>  	};
>  
>  	usb {
> 
> base-commit: dc1c8034e31b14a2e5e212104ec508aec44ce1b9



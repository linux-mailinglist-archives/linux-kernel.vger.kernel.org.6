Return-Path: <linux-kernel+bounces-363222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D97E99BF2F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DC91F22390
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8738248C;
	Mon, 14 Oct 2024 04:38:42 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50987231CB1;
	Mon, 14 Oct 2024 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728880721; cv=none; b=B4I/R7vbFLN830xHLHgdk7gseJWJrkfxr4D77ZC8g3zTYMPgpf1JBFT1y0eUiZdQ6Fm0gptQd6C0FFa2FN4Pb8i1C2O0PffQBYj+vJqnOV2SUsUjObsg/ZtqHgN33mcUE4vlNNzEfVCn28eS5yZ8BaAW8xOi8OftKKtvo0yqISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728880721; c=relaxed/simple;
	bh=VnMOFtM0rlHaYJg0Ihqs5/eTndvXXGk4vEpt32Iqk/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGAkL8PExaaGHF5c/yKM3Ld0e3zUn/DyP0Bg3p+6tyOYd+MVs6EODCQ939lTfauL9ScG7aRon5A6WgeW0UUcBCd3m42goEM7Rg9RG9IlI1z00jEqxjs4k7pKRuZ5sFVF6f0URH04oy4KNSffvEm/TlRFu32spefLqrIsJfJMkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip4t1728880692tn6r7d7
X-QQ-Originating-IP: EQSBChDx8AzRGfPF8zb2/7A9tODnohSmh1T0qLU6P6M=
Received: from [IPV6:240f:10b:7440:1:5070:3965 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Oct 2024 12:38:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13288931529560564606
Message-ID: <CE605641E53903DC+0f0ea6b2-9423-4aa2-ac9d-652a9ac5c237@radxa.com>
Date: Mon, 14 Oct 2024 13:38:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add new SoC dtsi for the
 RK3566T variant
To: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, TL Lim <tllim@pine64.org>,
 Marek Kraus <gamiee@pine64.org>, Tom Cubie <tom@radxa.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <95fc64aaf6d3ac7124926bcb0c664406b4e5fe3d.1728752527.git.dsimic@manjaro.org>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <95fc64aaf6d3ac7124926bcb0c664406b4e5fe3d.1728752527.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NvH2zBBgt3uT+tf1ztEnscQb8q8EJj8iUYLudHj4RY97astqYsjZu+Lm
	x8a0ZDoKYyIcSM8mtC1By0wX69RgXlnrqhUZoVb5r/dQBzGPq5L9AbDNgPgORYUbKq5cfOF
	W32HGGlYbcUSOd4lRRJGJjH0mVl3fGjWc33dfa8+O5LJ3xTkYanzK3V5452JNLBYENjdosc
	TxnNIgsXsBkAvHJ3bo20NrC5cqLqD2aY8Dj1Mr8UfOzmkjX4Vir7a103t4TnjB+8kn6xnT7
	mdbmZhEEhfQ8NRYL9dHTvaVI3i/+SHJfh4FfUtuWr+NJY1THg9yYqN6kiJgHDaiuV6VFW5l
	TJrfcTx26/U796KKr4602oKug1pagtuRwCGAQNiNQP6Xcn7lPhBdSt9hMExfAUeLlV42TTy
	xytU/dfp0nc80dPNCzLnCQrsTNS/HHJ5uTiAUBGawTw5VbxbuMewjfGqEFvXFLvUCUJQ7p3
	6ODl55A+qKJ0VvNX0xqDDWJSv+FnuLCEgfUWwn8A2q63LXp7xNk6FUMOh7c/zW8XLpXF2vz
	sr3P5nwQhxsjRmDSMgcLXrYOJs+NhF6Xib849PuXJehGhmRenIQ5LBEec2iZGTcP1ZB/DxI
	Jo0tM76+7+f1nqSQjlSRr32aY6P92v9pvrdXuBPMrvDwwHNSDErg2mIzrN6q+HbXs/JvPQI
	Bd8qtYO4tdA9XarWp8XJlf+fplEEETcdLot/6Cb1Pihc8ujXp+Ou8nuN2a+rg8IGLh5h14x
	4zPbqQVtwe+Es67KrQ6v0C8xSGwhr9AxUwe2tCrGzt8e2XVImDBpCVOJair0jvfEckrkEH6
	BnEeBZPbj7BQNcwapVaYze0oykKwHDnx9XBqrgVcuCCvxSStuPj29vw3VyeZ7mjTbcg8/A7
	lRQMq701yuzR+wShogqfCSxQ+BuPVTKE/89++Y1DvDJioNCOYnPtyfFcfRWnzxcYYU1JaKk
	eqQ7O9WceS2RwlYcSNIrbHeOUbsoEGxlmS+dYGtRR4knInw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Hi,

On 10/13/24 02:04, Dragan Simic wrote:
> Add new SoC dtsi file for the RK3566T variant of the Rockchip RK3566 SoC.
> The difference between the RK3566T variant and the "full-fat" RK3566 variant
> is in fewer supported CPU and GPU OPPs on the RK3566T, and in the absence of
> a functional NPU, which we currently don't have to worry about.
> 
> Examples of the boards based on the RK3566T include the Pine64 Quartz64 Zero
> SBC, [2] the Radxa ROCK 3C and the Radxa ZERO 3E/3W SBCs.  Unfortunately,
> Radxa doesn't mention the use of RK3566T officially, but its official SBC
> specifications do state that the maximum frequency for the Cortex-A55 cores
> on those SBCs is lower than the "full-fat" RK3566's 1.8 GHz, which makes
> spotting the presence of the RK3566T SoC variant rather easy. [3][4][5]  An
> additional, helpful cue is that Radxa handles the CPU and GPU OPPs for the
> RK3566T variant separately in its downstream kernel. [6]
> 
> The CPU and GPU OPPs supported on the RK3566T SoC variant are taken from the
> vendor kernel source, [1] which uses the values of the "opp-supported-hw" OPP
> properties to determine which ones are supported on a particular SoC variant.
> The actual values of the "opp-supported-hw" properties make it rather easy
> to see what OPPs are supported on the RK3566T SoC variant, but that, rather
> unfortunately, clashes with the maximum frequencies advertised officially
> for the Cortex-A55 CPU cores on the above-mentioned SBCs. [2][3][4][5]  The
> vendor kernel source indicates that the maximum frequency for the CPU cores
> is 1.4 GHz, while the SBC specifications state that to be 1.6 GHz.  Unless
> that discrepancy is resolved somehow, let's take the safe approach and use
> the lower maximum frequency for the CPU cores.
> 
> Update the dts files of the currently supported RK3566T-based boards to use
> the new SoC dtsi for the RK3566T variant.  This actually takes the CPU cores
> and the GPUs found on these boards out of their earlier overclocks, but it
> also means that the officially advertised specifications [2][3][4][5] of the
> highest supported frequencies for the Cortex-A55 CPU cores on these boards
> may actually be wrong, as already explained above.
> 
> The correctness of the introduced changes was validated by decompiling and
> comparing all affected board dtb files before and after these changes.
> 
> [1] https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> [2] https://wiki.pine64.org/wiki/Quartz64
> [3] https://dl.radxa.com/rock3/docs/hw/3c/radxa_rock3c_product_brief.pdf
> [4] https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_product_brief.pdf
> [5] https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_product_brief.pdf
> [6] https://github.com/radxa/kernel/commit/2dfd51da472e7ebb5ef0d3db78f902454af826b8
> 
> Cc: TL Lim <tllim@pine64.org>
> Cc: Marek Kraus <gamiee@pine64.org>
> Cc: Tom Cubie <tom@radxa.com>
> Cc: FUKAUMI Naoki <naoki@radxa.com>
> Helped-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> Helped-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>   .../dts/rockchip/rk3566-radxa-zero-3.dtsi     |  2 +-
>   .../boot/dts/rockchip/rk3566-rock-3c.dts      |  2 +-
>   arch/arm64/boot/dts/rockchip/rk3566t.dtsi     | 90 +++++++++++++++++++
>   3 files changed, 92 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3566t.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> index de390d92c35e..1ee5d96a46a1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> @@ -3,7 +3,7 @@
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/leds/common.h>
>   #include <dt-bindings/soc/rockchip,vop2.h>
> -#include "rk3566.dtsi"
> +#include "rk3566t.dtsi"

could you drop this change for now?

We(Radxa) think we use RK3566.

and vendor kernel[6] refers efuse value to determine it's -T or not.
can you do similar way?

>   / {
>   	chosen {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
> index f2cc086e5001..9a8f4f774dbc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
> @@ -5,7 +5,7 @@
>   #include <dt-bindings/leds/common.h>
>   #include <dt-bindings/pinctrl/rockchip.h>
>   #include <dt-bindings/soc/rockchip,vop2.h>
> -#include "rk3566.dtsi"
> +#include "rk3566t.dtsi"

same here.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

>   / {
>   	model = "Radxa ROCK 3C";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566t.dtsi b/arch/arm64/boot/dts/rockchip/rk3566t.dtsi
> new file mode 100644
> index 000000000000..cd89bd3b125b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566t.dtsi
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3566-base.dtsi"
> +
> +/ {
> +	cpu0_opp_table: opp-table-0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <850000 850000 1150000>;
> +			clock-latency-ns = <40000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <850000 850000 1150000>;
> +			clock-latency-ns = <40000>;
> +		};
> +
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <850000 850000 1150000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +
> +		opp-1104000000 {
> +			opp-hz = /bits/ 64 <1104000000>;
> +			opp-microvolt = <900000 900000 1150000>;
> +			clock-latency-ns = <40000>;
> +		};
> +
> +		opp-1416000000 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <1025000 1025000 1150000>;
> +			clock-latency-ns = <40000>;
> +		};
> +	};
> +
> +	gpu_opp_table: opp-table-1 {
> +		compatible = "operating-points-v2";
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <850000 850000 1000000>;
> +		};
> +
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <850000 850000 1000000>;
> +		};
> +
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <850000 850000 1000000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <900000 900000 1000000>;
> +		};
> +
> +		opp-700000000 {
> +			opp-hz = /bits/ 64 <700000000>;
> +			opp-microvolt = <950000 950000 1000000>;
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	operating-points-v2 = <&cpu0_opp_table>;
> +};
> +
> +&cpu1 {
> +	operating-points-v2 = <&cpu0_opp_table>;
> +};
> +
> +&cpu2 {
> +	operating-points-v2 = <&cpu0_opp_table>;
> +};
> +
> +&cpu3 {
> +	operating-points-v2 = <&cpu0_opp_table>;
> +};
> +
> +&gpu {
> +	operating-points-v2 = <&gpu_opp_table>;
> +};


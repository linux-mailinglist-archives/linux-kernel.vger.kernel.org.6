Return-Path: <linux-kernel+bounces-572998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F055A6D14F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F37D3B36B3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 21:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0044B1A83E2;
	Sun, 23 Mar 2025 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="GuNp/Owu"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA5136E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742766553; cv=none; b=N/iojRdJ92q5PxAGWitQrhlSjEnXcDddNS+eX3PBHengABRrkd8+iYnLCZq3n1ESq5kQ/Ir6zJ/KeDtjCxIsAswoA2vAi8xqvXKGltzylAQok7b6dSwy8yk/uFxVREhJ+diH2icWWn/zVxkh9nYOGIJU1g986t0NcsQ8WvjMmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742766553; c=relaxed/simple;
	bh=iNbMesR78k5RmGnUZmI7+2dHw/wq+VZMcYtPF+HAY0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZqe7iSxvt/qySE5Pc9L2J+30BnI9pGHquPfhWh9XTQ/fjUO6RwvteEqL04FuDmvEiWKt74zakk04xuJpDfItnvPpVG2eejqjUQZz6Y+9jT5/j89ih4gd85U+QyVJo9rsuSgAPzxMTjQ5BA1OuV6DuAGDabpiYM+wSAWs06aYu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=GuNp/Owu; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1742766550;
 bh=G4qA4COV9YHp+Oo7CvUkU/OS+JOY7kTPl3jpE0A4KLQ=;
 b=GuNp/OwufxVmqcwVD5CwJIb5n8XhBphLMvH2JlEztKXrQjeEodifsy7O3R67+83bmX0n4xnG7
 si2Yt1bF7pDCkV+eDV4e2AtzZg6wjgDsvR1EbD5hGYHQEfxpAfyFXdHHSU0nC6S3mcodXfA8l0p
 NHJ8osWAEwlH5dizF79veBpw5Gs9pldqs6eIV+LYYUYkNQxy9rHainj9f+OrLht7OOzTGMopbKG
 00pkmJyfzrgTqrHfD43nUHHz9vEgMGDu9Qm0lW56yPIruz5p9ytaN5xHcIzJgYiDg199F6LU6g2
 OHqvuxIxIAmC3uOz9UWdQRuc2GIeszefBniPaOYnfK5g==
X-Forward-Email-ID: 67e081d4bd529871d5f80e10
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <bcedff66-26e4-4630-88cd-6ab9fbcf5598@kwiboo.se>
Date: Sun, 23 Mar 2025 22:49:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency
 scaling support
To: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
 Dragan Simic <dsimic@manjaro.org>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250320100002.332720-1-amadeus@jmu.edu.cn>
 <20250320100002.332720-2-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250320100002.332720-2-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 2025-03-20 11:00, Chukun Pan wrote:
> By default, the CPUs on RK3528 operates at 1.5GHz. Add CPU frequency and
> voltage mapping to the device tree to enable dynamic scaling via cpufreq.
> 
> The OPP values come from downstream kernel[1], and voltage is chosen from
> the one that makes the actual frequency close to the displayed frequency.
> 
> [1] https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 64 ++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index 621fc19ac0b3..9dae18c3c770 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -61,6 +61,7 @@ cpu0: cpu@0 {
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			clocks = <&scmi_clk SCMI_CLK_CPU>;
> +			operating-points-v2 = <&cpu0_opp_table>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -69,6 +70,7 @@ cpu1: cpu@1 {
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			clocks = <&scmi_clk SCMI_CLK_CPU>;
> +			operating-points-v2 = <&cpu0_opp_table>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -77,6 +79,7 @@ cpu2: cpu@2 {
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			clocks = <&scmi_clk SCMI_CLK_CPU>;
> +			operating-points-v2 = <&cpu0_opp_table>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -85,6 +88,7 @@ cpu3: cpu@3 {
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			clocks = <&scmi_clk SCMI_CLK_CPU>;
> +			operating-points-v2 = <&cpu0_opp_table>;
>  		};
>  	};
>  
> @@ -103,6 +107,66 @@ scmi_clk: protocol@14 {
>  		};
>  	};
>  
> +	cpu0_opp_table: opp-table-0 {

nitpick:

There is only one cpu cluster on this SoC, I suggest we name this node
opp-table-cpu with a cpu_opp_table label.

For a forthcoming GPU series I named the node opp-table-gpu with a
gpu_opp_table label.

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <825000 825000 1100000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <825000 825000 1100000>;
> +			clock-latency-ns = <40000>;
> +		};

Both 408 and 600 MHz freq will use a normal PLL and based on the vendor
opp-table there are chip variants that presumably require 875000
microvolt.

Because of this 875000 is the lowest microvolt we should use in the
entire table, to ensure all chip variants can run stable.

Dragan is working on a chip binning project to help improve opp voltage
selection based on chip quality. Hopefully that project will result in
something that can also be used for RK3528 in the future.

> +
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <825000 825000 1100000>;
> +			clock-latency-ns = <40000>;
> +		};
> +
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <850000 850000 1100000>;
> +			clock-latency-ns = <40000>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <850000 850000 1100000>;

For remaining freq TF-A will use PVTPLL and configure an osc ring length,
then the voltage supplied in opp and chip quality will determine/limit
the real cpu clock speed.

This means that the voltage used is less important when it comes to
stability. However, we should keep 875000 as the lowest microvolt for
all opp above.

The voltage for remaining opp does not matter, historically mainline
picks the highest voltage from vendor tree to ensure stability. With the
use of PVTPLL that should not really be an issue, and we could pick
voltages that will give closest speed for majority of users.

> +			clock-latency-ns = <40000>;
> +		};
> +
> +		opp-1416000000 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <925000 925000 1100000>;
> +			clock-latency-ns = <40000>;
> +		};
> +
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <975000 975000 1100000>;
> +			clock-latency-ns = <40000>;
> +		};
> +
> +		opp-1800000000 {
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <1037500 1037500 1100000>;
> +			clock-latency-ns = <40000>;
> +		};
> +
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +			opp-microvolt = <1100000 1100000 1100000>;

This looks good, we should not go above the highest voltage used in
vendor tree.

A DT overlay can be used if a user wants to use board optimized voltages.

Regards,
Jonas

> +			clock-latency-ns = <40000>;
> +		};
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0", "arm,psci-0.2";
>  		method = "smc";



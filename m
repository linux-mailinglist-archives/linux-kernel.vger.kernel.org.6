Return-Path: <linux-kernel+bounces-549182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76CCA54EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881457AA3FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489131FDE37;
	Thu,  6 Mar 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="sCnMgo2x"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F18624B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274179; cv=none; b=qWAHdtgKFWaz30woENbLPt2HJdnggP/5g/yq/lUSd7pHfL2SejHmHry6BKm0LpPCCx7BIWJsbbo1CiTGMq0rF5lOoWM1AgYRMBV5aWD8RVsQfzKJFxLDajjKFnw1XhtKgWTCpGO5gqQMDMWoc9S9wtv2bfF279ZmHsqyL7U3lOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274179; c=relaxed/simple;
	bh=lK+vRH600i1adJh8Bk09nBcEHPeyoBBqSlrQrBD/hwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgHXXPJqb6zpEypISl446vT6wn3PDnsK5vnDpA41hlxGINvjg5pjUGfsyUksaRUz5Xk9pQT3LnVUcI0wIPbHeCf6ccSJTfzN0bVieB3qf3fncrVjjaDZGmMLGLnHsj7givv2Oh+eLtFCa8eHvlY9bmNBfNaZnQNQu8SwnIKJgmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=sCnMgo2x; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741274176;
 bh=v3aEbi3vbvtvRY+uN9WWZd+0zMgBkgvraJ9LrR9SE5c=;
 b=sCnMgo2xx8FAVt7UTYtQP74jNhGUNvtPg1IsmBUQ/q6f7D3CyhlwBaJ6nW+oIqZGf8gHdsvL/
 haRx4svJQ1aHZs/6uaByehicEmuZ5IBrInzGcB+7VGlFidDxs0ePdNNizmJenvoBaXJE53yce/i
 MhBBf1wJbV7ZFQkSu+PwztsQ2hJdezYu3tn82idLqlsrOS7v6cShLR9au+Jlu7hYCKsH/pDgES9
 xaad1yENhayoGJeU5LIKN8mGAMqNJwgYtDAjUCZSI2kGAX/wFTI0FOPypq++2rpyprtoYnM9omr
 AdlXPG5KE4KrEhb2vXETlpqsUZdc7CZAWsfeFqoRJKZQ==
X-Forward-Email-ID: 67c9bc3e7d53aa09926028af
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <281b8025-8288-4274-b863-f091c05cbabe@kwiboo.se>
Date: Thu, 6 Mar 2025 16:16:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528
 SoC
To: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250306150017.488975-1-amadeus@jmu.edu.cn>
 <20250306150017.488975-2-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250306150017.488975-2-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 2025-03-06 16:00, Chukun Pan wrote:
> Same as RK3568, RK3528 uses SCMI clk instead of ARMCLK.
> Add SCMI clk for CPU, GPU and RNG will also use it.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 33 ++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index b1713ed4d7e2..476b83f98834 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -59,6 +59,9 @@ cpu0: cpu@0 {
>  			reg = <0x0>;
>  			device_type = "cpu";
>  			enable-method = "psci";
> +			clocks = <&scmi_clk SCMI_CLK_CPU>;
> +			assigned-clocks = <&scmi_clk SCMI_CLK_CPU>;
> +			assigned-clock-rates = <1200000000>;

This is new compared to v1, please add operating-points instead.
cpu_pvtpll is already initialized to 1.2 GHz by firmware, see e.g. [1].

[1] https://lore.kernel.org/u-boot/20250123224844.3104592-5-jonas@kwiboo.se/

Regards,
Jonas

>  		};
>  
>  		cpu1: cpu@1 {
> @@ -66,6 +69,7 @@ cpu1: cpu@1 {
>  			reg = <0x1>;
>  			device_type = "cpu";
>  			enable-method = "psci";
> +			clocks = <&scmi_clk SCMI_CLK_CPU>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -73,6 +77,7 @@ cpu2: cpu@2 {
>  			reg = <0x2>;
>  			device_type = "cpu";
>  			enable-method = "psci";
> +			clocks = <&scmi_clk SCMI_CLK_CPU>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -80,6 +85,22 @@ cpu3: cpu@3 {
>  			reg = <0x3>;
>  			device_type = "cpu";
>  			enable-method = "psci";
> +			clocks = <&scmi_clk SCMI_CLK_CPU>;
> +		};
> +	};
> +
> +	firmware {
> +		scmi: scmi {
> +			compatible = "arm,scmi-smc";
> +			arm,smc-id = <0x82000010>;
> +			shmem = <&scmi_shmem>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			scmi_clk: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
>  		};
>  	};
>  
> @@ -88,6 +109,18 @@ psci {
>  		method = "smc";
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scmi_shmem: shmem@10f000 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0x0010f000 0x0 0x100>;
> +			no-map;
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,



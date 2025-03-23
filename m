Return-Path: <linux-kernel+bounces-572989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20684A6D126
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27E016C789
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C2F19E83E;
	Sun, 23 Mar 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="DfL9ynNe"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF33A8C1
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742763892; cv=none; b=rVVDF+joa1vcj3XSTSaiI+bcYX/y3oBpwkbGqYeS4JV1A3fP9QkUVQEzGCIuyDcq5udT2IFKzXDVkfFxZ24ofS6lEhDY1tiuAqbi0za4+f1ETP5C4UaqOCYNlnI8Nny9CPZfMQlsYIXLeDDaD1iTAlN06FESS+w2moA0CdNSqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742763892; c=relaxed/simple;
	bh=/X12eYTqOZV+6YxzXp1x6S+HtTYjtDKqcPxroQ544vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rj7lWmo+FkrxoWiJaUrrDM1bNIzVkESQCDBLT3htiUrI8ksTCvNlcmbEQve6T4qcAYlklfwDwFCYUKKuk6AkOlSfCdjAQpudR6ZKKg4heKPZc8lcutvINlaCBjZW8yOL7T8+mKXbX7dK+FsMaWn40fLjUATARAPig4YZ98/u6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=DfL9ynNe; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1742763883;
 bh=FwRTNZOGaMzk6sK4gqhqpSsftDoXWbs1L9reGg1ZKBI=;
 b=DfL9ynNe0So0hln/rdgumR3TgYgg/rrBPsMJF5QUTuhaSuqdukZPMDfBLYGTLaCLGJTkkx5VX
 rfxHidiqAXf62s+E++f4oMGTJX9aI1hEABzXeo5frkkRb/Z/7P7PRt1/vT+nvtxJdgliy1NRbM/
 cqmmKGmCkwxh2h8XsvGLf/b0k1KHNHVB88ehN9BlisM4gZ4e9Hx2kmnX4rF3TjV0mglpHVcVwRg
 vfppDxPVxzZuB4ngQ/7+y1uwu1C1dlXondokzkqvb7CjZA5mzU1CnSk/nTqDi0/tSD9LVYiSJ6D
 7tJorJuXrD0i9CwrLkqFj+ViOnd/DcePusHC3kJAvsMg==
X-Forward-Email-ID: 67e07765bd529871d5f80612
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <201122ca-74d1-4938-9940-7da051896da9@kwiboo.se>
Date: Sun, 23 Mar 2025 22:04:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add DMA controller for RK3528
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250318100010.2253408-1-amadeus@jmu.edu.cn>
 <20250318100010.2253408-3-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250318100010.2253408-3-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 2025-03-18 11:00, Chukun Pan wrote:
> Add DMA controller dt node for RK3528 SoC.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index 7f1ffd6003f5..ad77e0ef70f2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -493,6 +493,24 @@ sdhci: mmc@ffbf0000 {
>  			status = "disabled";
>  		};
>  
> +		dmac: dma-controller@ffd60000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x0 0xffd60000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +			arm,pl330-periph-burst;
> +			clocks = <&cru ACLK_DMAC>;
> +			clock-names = "apb_pclk";

nitpick:

Please move the clock related props before interrupts to keep prop order
consistent in the rk3528.dtsi-file. See [1] for preferred prop order.

[1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

Regards,
Jonas

> +			#dma-cells = <1>;
> +		};
> +
>  		pinctrl: pinctrl {
>  			compatible = "rockchip,rk3528-pinctrl";
>  			rockchip,grf = <&ioc_grf>;



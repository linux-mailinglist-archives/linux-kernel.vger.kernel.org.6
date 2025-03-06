Return-Path: <linux-kernel+bounces-549386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082BEA551E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A76F3A4A48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE52566F8;
	Thu,  6 Mar 2025 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="j4U/3HjK"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664AE2144BC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280137; cv=none; b=K6+MAm8GBBqD1pTlCFzpT99XLsBKK6eEKYzKXet9bgFwbBWuZ5hoh1YBLwdnRRJ0UmbPzl5aLxpWrtZeSRpZ9Bu5JvrR3Kk3rA7eAUsQekRMvBAzFWFoNgXiLjynj8hRg3uABusE6pPuUfjkuCvTKPVW/Lb1vmTNSfD8+q7TYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280137; c=relaxed/simple;
	bh=cNmccHvTTMSoTFUGW5G92HYWRzCGPOazWKInDL47LPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7HJPXz7pUytb/EHYDP19WzUFrleIojrrrDou93mZqc5ty4KWAnf4MjwDkNDHbybwk6KezfFolf8L0wwTpT1Af3ac6GFoS51pNkStgXGW7yCCrxDzir4pXNF3faZ9Z88B4bDN1SCbAFUZXZzCNFdTsNhZ0DktNww+TwYNGZnrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=j4U/3HjK; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741280134;
 bh=6bMGhfu3cKthCvL1T3G+dPSizYb8EcgG80qlrt/kJJ8=;
 b=j4U/3HjKIlIV0GDb6nSJD/eAMPCeps+0sI81Ny4k++X013ANHaM9kaL4iMBXdz/vIsC6qqbKa
 Of4mjCmVaWQxz+sJGfRNBloR0WCkjuSBe5VK4VV9bxlVoilDh95UGM5hIiR/XAnsBNByhAuykxJ
 n1J0s//3SsoM3ZChWgpzYmANw/k+twrQAE5QESJk7Dvi59cHEWuqfGh8jHYAOY9qsDkFWwv0h6R
 Y58Ey+aS6LO6Kn1nj3zdXqQD6kbc9Kl7ljUy9F5IvOUeWZRuoX6ONN/PSyBzT3izi7hS0nto7gh
 A3ljRy57mSaNRb033lh10ayhWMQ1cVhwhlQHa4PlCR1g==
X-Forward-Email-ID: 67c9d3797d53aa09926043e9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <cdbc1556-4662-4078-a4d6-33545e2e2491@kwiboo.se>
Date: Thu, 6 Mar 2025 17:55:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add rk3528 QoS register node
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250306123809.273655-1-amadeus@jmu.edu.cn>
 <20250306123809.273655-3-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250306123809.273655-3-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 2025-03-06 13:38, Chukun Pan wrote:
> The Quality-of-Service (QsS) node stores/restores specific
> register contents when the power domains is turned off/on.
> Add QoS node so that they can connect to the power domain.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 160 +++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index b1713ed4d7e2..0c0e7f151462 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -129,6 +129,166 @@ gic: interrupt-controller@fed01000 {
>  			#interrupt-cells = <3>;
>  		};
>  
> +		qos_crypto_a: qos@ff200000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200000 0x0 0x20>;
> +		};
> +
> +		qos_crypto_p: qos@ff200080 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200080 0x0 0x20>;
> +		};
> +
> +		qos_dcf: qos@ff200100 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200100 0x0 0x20>;
> +		};
> +
> +		qos_dft2apb: qos@ff200200 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200200 0x0 0x20>;
> +		};
> +
> +		qos_dma2ddr: qos@ff200280 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200280 0x0 0x20>;
> +		};
> +
> +		qos_dmac: qos@ff200300 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200300 0x0 0x20>;
> +		};
> +
> +		qos_keyreader: qos@ff200380 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff200380 0x0 0x20>;
> +		};
> +
> +		qos_cpu: qos@ff210000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff210000 0x0 0x20>;
> +		};
> +
> +		qos_debug: qos@ff210080 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff210080 0x0 0x20>;
> +		};
> +
> +		qos_gpu_m0: qos@ff220000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff220000 0x0 0x20>;
> +		};
> +
> +		qos_gpu_m1: qos@ff220080 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff220080 0x0 0x20>;
> +		};
> +
> +		qos_pmu_mcu: qos@ff240000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff240000 0x0 0x20>;
> +		};
> +
> +		qos_rkvdec: qos@ff250000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff250000 0x0 0x20>;
> +		};
> +
> +		qos_rkvenc: qos@ff260000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff260000 0x0 0x20>;
> +		};
> +
> +		qos_gmac0: qos@ff270000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270000 0x0 0x20>;
> +		};
> +
> +		qos_hdcp: qos@ff270080 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270080 0x0 0x20>;
> +		};
> +
> +		qos_jpegdec: qos@ff270100 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270100 0x0 0x20>;
> +		};
> +
> +		qos_rga2_m0ro: qos@ff270200 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270200 0x0 0x20>;
> +		};
> +
> +		qos_rga2_m0wo: qos@ff270280 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270280 0x0 0x20>;
> +		};
> +
> +		qos_sdmmc0: qos@ff270300 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270300 0x0 0x20>;
> +		};
> +
> +		qos_usb2host: qos@ff270380 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270380 0x0 0x20>;
> +		};
> +
> +		qos_vdpp: qos@ff270480 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270480 0x0 0x20>;
> +		};
> +
> +		qos_vop: qos@ff270500 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff270500 0x0 0x20>;
> +		};
> +
> +		qos_emmc: qos@ff280000 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280000 0x0 0x20>;
> +		};
> +
> +		qos_fspi: qos@ff280080 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280080 0x0 0x20>;
> +		};
> +
> +		qos_gmac1: qos@ff280100 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280100 0x0 0x20>;
> +		};
> +
> +		qos_pcie: qos@ff280180 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280180 0x0 0x20>;
> +		};
> +
> +		qos_sdio0: qos@ff280200 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280200 0x0 0x20>;
> +		};
> +
> +		qos_sdio1: qos@ff280280 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280280 0x0 0x20>;
> +		};
> +
> +		qos_tsp: qos@ff280300 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280300 0x0 0x20>;
> +		};
> +
> +		qos_usb3otg: qos@ff280380 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280380 0x0 0x20>;
> +		};
> +
> +		qos_vpu: qos@ff280400 {
> +			compatible = "rockchip,rk3528-qos", "syscon";
> +			reg = <0x0 0xff280400 0x0 0x20>;
> +		};

These QoS node are typically referenced from power domains so that the
PMU driver know what QoS to save/restore when a power domain is power
cycled.

Vendor kernel only reference the two qos_gpu nodes in it's power domains,
do you have any documentation or knowledge about what power domain the
remaining QoS are related to?

It would have been helpful to include PMU support to help understand the
QoS <-> PD relationship, on their own they do not tell us that much :-)

Regards,
Jonas

> +
>  		cru: clock-controller@ff4a0000 {
>  			compatible = "rockchip,rk3528-cru";
>  			reg = <0x0 0xff4a0000 0x0 0x30000>;



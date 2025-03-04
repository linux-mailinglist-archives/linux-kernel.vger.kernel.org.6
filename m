Return-Path: <linux-kernel+bounces-545156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67634A4E9BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BAE17F62B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11522BD58A;
	Tue,  4 Mar 2025 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="OdeKeDmc"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23B2BD584;
	Tue,  4 Mar 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108673; cv=pass; b=WD/j5LN3w2Mhadbj5Mf51fSX+HR+DuRILZYsxzsJuEa7oqsIyaEZQm2henAMGjsNPCR80T1mX5zBiH6j6FnXe2RaK0ycdsmOejZF+Yxih+lAtMll+n4Brhx/bjQpK+CrFkpFoS8f2yXonVVW89uZUv3ej8ljpom0owaOlu6lVWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108673; c=relaxed/simple;
	bh=uLTZ4u9mww4svOZdPvj4sAm/xoXrQdMzEbT1XBPo5F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZKNeBdshbjBXuMseXjTFfin1F2d9keHenXUq4rlI3HMLaDPlHi19bZot1gHNEAIv4g9PD6h+Z3nt+Z1+cVM5yFWEQQo5NoE6QnIxMLE2d4KioDOk3OU+NSkAW4wALvBERoDpHx/urDHSTfHttbAJ+Edz8+ltBvY4HRLRtXjqtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=OdeKeDmc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741108654; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Cn3hJpE7SoGEucl3ZE5MWdfDQTZaqZB+4tdMp9wJ3NNHrtKGuR5476yRJ+z2jkF9yRBa4H7Fr/DrRn9FMpZ2ClWH8ClDHniWWDwSjt8WN+ljcklTnbLz+tiE1CUSrIcIAcdlRAIh+g3a0RxT8i2ezboUSU0gWm7/OsNdczeiDcU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741108654; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7WMScFZAkTq8yg1G5slYKsHitTL/MRFrvfKi5nUyvhA=; 
	b=BNatXZo2xInUuPrLuBs4G95bC9v3vmmJNKstBi+f5g12pFVB3r0arjj/1QVKDQozSF3iAVXShNuiYhMqrStdSdlZwtls/QktP1tZF1bmnuT3tfvbuXv7Kg9+z64TcSH2mhkTUmaIjVXFruQzf07otuXjpCHsV+jmqAcmDnzVrRc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741108654;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=7WMScFZAkTq8yg1G5slYKsHitTL/MRFrvfKi5nUyvhA=;
	b=OdeKeDmcdDmQDVFAxowDTIQ6TyS8EjDlgxqAwSp5MqXBREgQAPyTE8jFNF6UgG3X
	xuuGG8yENhwuZ5ozhN7K+AjMJ4A6N0+NS5W+Cdh1v+0QvLtp+bbFH4uyk+RXRDlk7t+
	ZwVpMBxHN+9LMXj54hAw1RmEhhZb/GpC7vezYhAE=
Received: by mx.zohomail.com with SMTPS id 1741108651558457.8426232371871;
	Tue, 4 Mar 2025 09:17:31 -0800 (PST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: heiko@sntech.de, Andy Yan <andyshrk@163.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: rockchip: Add hdmi for rk3576
Date: Tue, 04 Mar 2025 12:17:30 -0500
Message-ID: <6133294.lOV4Wx5bFT@earth>
In-Reply-To: <20241231095728.253943-3-andyshrk@163.com>
References:
 <20241231095728.253943-1-andyshrk@163.com>
 <20241231095728.253943-3-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Andy,

On Tuesday, 31 December 2024 04:57:19 EST Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Add hdmi and it's phy dt node for rk3576.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 58 ++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3576.dtsi index 130d11a2cc89..b83f421dc11d
> 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -450,6 +450,11 @@ soc {
>  		#size-cells = <2>;
>  		ranges;
> 
> +		hdptxphy_grf: syscon@26032000 {
> +			compatible = "rockchip,rk3576-hdptxphy-grf", 
"syscon";
> +			reg = <0x0 0x26032000 0x0 0x100>;
> +		};
> +
>  		sys_grf: syscon@2600a000 {
>  			compatible = "rockchip,rk3576-sys-grf", "syscon";
>  			reg = <0x0 0x2600a000 0x0 0x2000>;
> @@ -894,6 +899,46 @@ vop_mmu: iommu@27d07e00 {
>  			status = "disabled";
>  		};
> 
> +		hdmi: hdmi@27da0000 {
> +			compatible = "rockchip,rk3576-dw-hdmi-qp";
> +			reg = <0x0 0x27da0000 0x0 0x20000>;
> +			clocks = <&cru PCLK_HDMITX0>,
> +				 <&cru CLK_HDMITX0_EARC>,
> +				 <&cru CLK_HDMITX0_REF>,
> +				 <&cru MCLK_SAI6_8CH>,
> +				 <&cru CLK_HDMITXHDP>,
> +				 <&cru HCLK_VO0_ROOT>;
> +			clock-names = "pclk", "earc", "ref", "aud", "hdp", 
"hclk_vo1";
> +			interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "avp", "cec", "earc", "main", 
"hpd";
> +			phys = <&hdptxphy>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hdmi_txm0_pins &hdmi_tx_scl 
&hdmi_tx_sda>;
> +			power-domains = <&power RK3576_PD_VO0>;
> +			resets = <&cru SRST_HDMITX0_REF>, <&cru 
SRST_HDMITXHDP>;
> +			reset-names = "ref", "hdp";
> +			rockchip,grf = <&ioc_grf>;
> +			rockchip,vo-grf = <&vo0_grf>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				hdmi_in: port@0 {
> +					reg = <0>;
> +				};
> +
> +				hdmi_out: port@1 {
> +					reg = <1>;
> +				};
> +			};
> +		};
> +
>  		qos_hdcp1: qos@27f02000 {
>  			compatible = "rockchip,rk3576-qos", "syscon";
>  			reg = <0x0 0x27f02000 0x0 0x20>;
> @@ -1655,6 +1700,19 @@ uart11: serial@2afd0000 {
>  			status = "disabled";
>  		};
> 
> +		hdptxphy: hdmiphy@2b000000 {
> +			compatible = "rockchip,rk3576-hdptx-phy", 
"rockchip,rk3588-hdptx-phy";
> +			reg = <0x0 0x2b000000 0x0 0x2000>;
> +			clocks = <&cru CLK_PHY_REF_SRC>, <&cru 
PCLK_HDPTX_APB>;
> +			clock-names = "ref", "apb";
> +			resets = <&cru SRST_P_HDPTX_APB>, <&cru 
SRST_HDPTX_INIT>,
> +				 <&cru SRST_HDPTX_CMN>, <&cru 
SRST_HDPTX_LANE>;
> +			reset-names = "apb", "init", "cmn", "lane";
> +			rockchip,grf = <&hdptxphy_grf>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		sram: sram@3ff88000 {
>  			compatible = "mmio-sram";
>  			reg = <0x0 0x3ff88000 0x0 0x78000>;

This patch needs rebasing over the USB support patches.

Regards,
Detlev.




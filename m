Return-Path: <linux-kernel+bounces-348795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF798EBEF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E05BB21532
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C571448DC;
	Thu,  3 Oct 2024 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hQ29Oi8B"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7E13B2AF;
	Thu,  3 Oct 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945884; cv=none; b=iO93xCWoaExPsV+d2mM3yBUCw3gL1BswXXtUCsWXKu9bshZTrLBprGQZBhnE/7uf5VZdKKvkWmIGeVEPPkdPydJvPGlANIQ0W9CMnlpR5VWOO0rbQmi5g7ZGmvLsN+Ln4VmxSv82ut2fAyOTAc5qyyrp0d1ErHpu0oQLeE+1fCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945884; c=relaxed/simple;
	bh=JG8at6Zdgsq+ccUHGmtcOZh5lLyAkf7AEwk1/9/xIPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JLfQlG20N06ijuK27u36+hwFT11uJGmMJNynDtetTPNS6g/RcLM7fim3FJJvR/6GJScNreaUcdeSOjZE2Pp6JUVea0J+ngCjAwl3U+D3gyJYvxal+JPnhmJBhniXi2cs4cXbTdotQybML0eOgLiTznUHkxHTgen+05Wf37XcxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hQ29Oi8B; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9293c974816511ef8b96093e013ec31c-20241003
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=t+NkV+DHbhadmuS6uQmNF40Icx0bC1GHvjZLIUym1E4=;
	b=hQ29Oi8B/0f5x8KO4wPSUVarJnzF45bn37ztQyLFgEuBwz3crt30+c1dw/86QCO3vSwLudLNzsNlQplYXW/A5IA3/Fc6mzN01N11ysvZCj2s3Mkux9y6AgzdTfw3teH3Zwf7Eih7w1a7qdqaXREov2s+dAuwbt2ZUtNEilzcrzQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:c228968a-1b50-40f8-b063-a599351f79d6,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:2a5d0bf6-9f42-4992-a777-27d2757e4c2a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 9293c974816511ef8b96093e013ec31c-20241003
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1332517876; Thu, 03 Oct 2024 16:57:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 3 Oct 2024 16:57:51 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 3 Oct 2024 16:57:50 +0800
Message-ID: <8b428ac5-2bd9-47cf-1dc4-7594c1b05b94@mediatek.com>
Date: Thu, 3 Oct 2024 16:57:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/9] arm64: dts: mediatek: mt8188: Add PCIe nodes
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, Jieyy Yang <jieyy.yang@mediatek.com>, Jianguo Zhang
	<jianguo.zhang@mediatek.com>, Jian Yang <jian.yang@mediatek.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
References: <20241003070139.1461472-1-fshao@chromium.org>
 <20241003070139.1461472-3-fshao@chromium.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20241003070139.1461472-3-fshao@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/24 14:59, Fei Shao wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> 
> Add PCIe node and the associated PHY node.
> Individual board device tree should enable the nodes as needed.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
> Changes in v2:
> - add linux,pci-domain to PCIe node
> - add power domain to PCIe PHY node.
>    The binding patch:
>    https://lore.kernel.org/all/20240926101804.22471-1-macpaul.lin@mediatek.com/
> 
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 64 ++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index 10195a4e4e9d..23101d316c4e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -1763,6 +1763,54 @@ xhci0: usb@112b0000 {
>   			status = "disabled";
>   		};
>   
> +		pcie: pcie@112f0000 {
> +			compatible = "mediatek,mt8188-pcie", "mediatek,mt8192-pcie";
> +			reg = <0 0x112f0000 0 0x2000>;
> +			reg-names = "pcie-mac";
> +			ranges = <0x82000000 0 0x20000000 0 0x20000000 0 0x4000000>;
> +			bus-range = <0 0xff>;
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P0>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_26M>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_32K>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
> +				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_FMEM>;
> +			clock-names = "pl_250m", "tl_26m", "tl_96m", "tl_32k",
> +				      "peri_26m", "peri_mem";
> +
> +			#interrupt-cells = <1>;
> +			interrupts = <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH 0>;
> +			interrupt-map = <0 0 0 1 &pcie_intc 0>,
> +					<0 0 0 2 &pcie_intc 1>,
> +					<0 0 0 3 &pcie_intc 2>,
> +					<0 0 0 4 &pcie_intc 3>;
> +			interrupt-map-mask = <0 0 0 7>;
> +
> +			iommu-map = <0 &infra_iommu IFR_IOMMU_PORT_PCIE_0 0xffff>;
> +			iommu-map-mask = <0>;
> +
> +			phys = <&pcieport PHY_TYPE_PCIE>;
> +			phy-names = "pcie-phy";
> +
> +			power-domains = <&spm MT8188_POWER_DOMAIN_PEXTP_MAC_P0>;
> +
> +			resets = <&watchdog MT8188_TOPRGU_PCIE_SW_RST>;
> +			reset-names = "mac";
> +
> +			status = "disabled";
> +
> +			pcie_intc: interrupt-controller {
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
>   		nor_flash: spi@1132c000 {
>   			compatible = "mediatek,mt8188-nor", "mediatek,mt8186-nor";
>   			reg = <0 0x1132c000 0 0x1000>;
> @@ -1775,6 +1823,22 @@ nor_flash: spi@1132c000 {
>   			status = "disabled";
>   		};
>   
> +		pciephy: t-phy@11c20700 {
> +			compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3";
> +			ranges = <0 0 0x11c20700 0x700>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			power-domains = <&spm MT8188_POWER_DOMAIN_PEXTP_PHY_TOP>;
> +			status = "disabled";
> +
> +			pcieport: pcie-phy@0 {
> +				reg = <0 0x700>;
> +				clocks = <&topckgen CLK_TOP_CFGREG_F_PCIE_PHY_REF>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +			};
> +		};
> +
>   		i2c1: i2c@11e00000 {
>   			compatible = "mediatek,mt8188-i2c";
>   			reg = <0 0x11e00000 0 0x1000>,

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>

Thanks.
Macpaul Lin


Return-Path: <linux-kernel+bounces-347499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D8898D383
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9036AB20B60
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1A51CFECE;
	Wed,  2 Oct 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T+s41gYV"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D231CF5E7;
	Wed,  2 Oct 2024 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872975; cv=none; b=PZL+bSxy609HsYFE6KulPzzNL76p36VbumYuZvwr8RvocOuU3k9tzhRymubyA03392t8d85mq59POQ+US1tdHyL6K2C+nqjHBBcZNlEwOXYoqjpwNYHJGp1xZvZqLzNFH6wNWpOEIh2XhwunTp3njgilufxWrlKt+nMmjjdbvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872975; c=relaxed/simple;
	bh=uwntXRwbNBTGsaI2fUr5lXsoUMzoaYf2YgRqtCM135U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PGrjSGhiNEzak9PalVEipIHvCdB06pfRx+DOvaQHN5JOJ7LyTtJTP7WqySgzCLqtat5OHp8Eey9H5PJmazmAiPleAR5MigGyO7Rr7u2qoJCvxR3KsM5Ptbu5XrhTicWpAv5KTn5UmcMh6xO/rD01n1GDnFilQX0krORU5QJmWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=T+s41gYV; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d0c250d080bb11efb66947d174671e26-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=0Ni+WI8epTIdbJVSUpHgDqL3C5owd4TU9qiJVvDIbbE=;
	b=T+s41gYVMlSDbJTTBzBDbUir/UGuDMhp++4DcNw6/1meYqL/ItQgJWyMHeJXnNCiE56M3bKsDkoIp2AMuejvbx4fQG11xlj6LxhQRTBkXpC1sAVFIpoOdqHQpu/8G0sGeqVVkAwbIAbpYAK0nVYMnpV8Dc7x4oDMz83KwvvbbE4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:9296df5e-1619-473c-87cd-d986ba839340,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:d209a9ed-33c7-4396-bf34-2026ee4f15f5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d0c250d080bb11efb66947d174671e26-20241002
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 171565082; Wed, 02 Oct 2024 20:42:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 20:42:40 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 2 Oct 2024 20:42:40 +0800
Message-ID: <7faeac1b-0b7a-a820-16a5-330b82d12e01@mediatek.com>
Date: Wed, 2 Oct 2024 20:42:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/9] arm64: dts: mediatek: mt8188: Add PCIe nodes
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <jianguo.zhang@mediatek.com>,
	<jian.yang@mediatek.com>, <jieyy.yang@mediatek.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring
	<robh@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>
References: <20241002114614.847553-1-fshao@chromium.org>
 <20241002114614.847553-3-fshao@chromium.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20241002114614.847553-3-fshao@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 10/2/24 19:41, Fei Shao wrote:
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
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 62 ++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index 10195a4e4e9d..9431f3c5c228 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -1763,6 +1763,53 @@ xhci0: usb@112b0000 {
>   			status = "disabled";
>   		};
>   
> +		pcie: pcie@112f0000 {
> +			compatible = "mediatek,mt8188-pcie", "mediatek,mt8192-pcie";
> +			reg = <0 0x112f0000 0 0x2000>;
> +			reg-names = "pcie-mac";

It seems the property 'linux,pci-domain = <0>;' is missing?

[snip]

> +			};
> +		};
> +
>   		nor_flash: spi@1132c000 {
>   			compatible = "mediatek,mt8188-nor", "mediatek,mt8186-nor";
>   			reg = <0 0x1132c000 0 0x1000>;
> @@ -1775,6 +1822,21 @@ nor_flash: spi@1132c000 {
>   			status = "disabled";
>   		};
>   
> +		pciephy: t-phy@11c20700 {
> +			compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3";
> +			ranges = <0 0 0x11c20700 0x700>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			status = "disabled";
> +

The power-domains property is missing.
It should be 'power-domains = <&spm MT8188_POWER_DOMAIN_PEXTP_PHY_TOP>;'

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

Thanks!
Best regards,
Macpaul Lin


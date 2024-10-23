Return-Path: <linux-kernel+bounces-377593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3339AC103
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69B91F25380
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81821581EE;
	Wed, 23 Oct 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FZ2ajHD7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538E157476;
	Wed, 23 Oct 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670696; cv=none; b=mLt4cdeilm0DhT5zXbETqreKz/nonPnaVXQLE2EkUImUu5FgbkBo493vp8Syo2MbHh+7GKE8m5eUhs02J/94z4p6ZqaJFzZ9E0PsmiB0AeyUZ1/GfwFZsTWG6DrdEHWW6ivnZk9jTa/CQfsG3uPARRZmuwYnxaUNTiOIkCB8Zpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670696; c=relaxed/simple;
	bh=wNfICjJunBTv30G0phhjw+sCEjvSUL1ZCOKjFP3/F4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YRw+kzjcM1bgn1LaL7onQRxCwEOmR6eng315JeUm9SV2ArhndjRK2F9iDsUxsouvhro63ZWL2lku6THux0FZnXJjgjR5QSjAd5JwjYaXv+viNVZozxAWQUXjS97uZL4TNhs9w2jz2uPjQrxRRNoqCzxE3+t2tf3qQh4m8+/1Pig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FZ2ajHD7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 782cbad6911511efb88477ffae1fc7a5-20241023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=Z9QTpl9GyOqZve1SjsYWKPD8jJQ96/F6+w63OTVRGAs=;
	b=FZ2ajHD7dfCOU6EKbVNhukWtxVvxtuAF4vjVqVFOdhTw2XsIP3dgSU3S0ONFvmMAOUZ5B9G/xBm8678XA3ClI5OLD7GuNj4fMVCFqbkdaZOo0v3QM8Oqc75kSkKwcHcha2mTJz/ZmRDNchcr4TSqSFj4Lwp/B8fy4hEi4KEoSyU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:fdbf0c2c-f118-4f59-aed1-1e9918c464a1,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:b0fcdc3,CLOUDID:6abefa2d-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 782cbad6911511efb88477ffae1fc7a5-20241023
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2109470363; Wed, 23 Oct 2024 16:04:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 16:04:45 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 23 Oct 2024 16:04:44 +0800
Message-ID: <e971e56a-7171-9735-473b-5f77799c972b@mediatek.com>
Date: Wed, 23 Oct 2024 16:04:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-usb@vger.kernel.org>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	Fabien Parent <fparent@baylibre.com>, Yow-Shin Liou
	<yow-shin.liou@mediatek.com>, Simon Sun <simon.sun@yunjingtech.com>
References: <20241023071226.14090-1-macpaul.lin@mediatek.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20241023071226.14090-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 10/23/24 15:12, Macpaul Lin wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
> configuration for TCPC Port, USB-C connector, and related settings.
> 
> Configure dual role switch capability, set up PD (Power Delivery) profiles,
> and establish endpoints for SSUSB (SuperSpeed USB).
> 
> Update pinctrl configurations for U3 P0 VBus default pins and set dr_mode
> to "otg" for OTG (On-The-Go) mode operation.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Yow-Shin Liou <yow-shin.liou@mediatek.com>
> Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>   .../dts/mediatek/mt8395-genio-1200-evk.dts    | 54 +++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> Changes for v2:
>   - Drop the no need '1/2' DT Schema update patch in the 1st version.
>   - Fix intent for 'ports' node, it should under the 'connector' node.
>   - Correct the index for 'port@0' and 'port@1' node.

[snip]

I've found the alphabet order of these nodes are not good.
I'll send v3 to re-order these new nodes.

Thanks
Macpaul Lin


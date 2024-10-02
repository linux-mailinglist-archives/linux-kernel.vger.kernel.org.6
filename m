Return-Path: <linux-kernel+bounces-346938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2DE98CB3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBCC284A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30BA11187;
	Wed,  2 Oct 2024 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XT88rwe3"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE28BE8;
	Wed,  2 Oct 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835717; cv=none; b=geXx0lCsXGzlScEUm39bWe2lZanARkusInKP1VwH1WeOfkxTnPVX4G6Rz4hlljVMgrmsd8xMiRONQnbgkanwBmLXgR8HhZ/N0YUAWcWTzLoXM0eu8wCSezuQKB0GmD6qbNAr9xXJoMVo96z6BfrWGSgTCnmqsjlBA7M0ycJj+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835717; c=relaxed/simple;
	bh=/wgqRlR8gU8E8K2TgkjJMDTUSwREOP9bAXMyPCwI3Kg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tx0YrV/MU9Y1yX+T+sHFLiAdRfrqSIVFEXb3kvY5FRkK5YwA5jX6GbMQLDPt0FXiwcJI5ZydVCRSInxKzqpawhkj6bJsrrwh1wgNKcvKgy/3ZIPEZwDkP4qTsY7b5+3e1+HnGRUqx90/50CHqJ86ItBicZOa8krodQmV24pTYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XT88rwe3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 13dd3030806511efb66947d174671e26-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AcPXQUaCxOIV+61poGYvI0YUnLEQXuMc5eUSKOoaXqU=;
	b=XT88rwe3EaDKFdEwQOGXaw9rCj4DRhVLohIQK4nCT5DDlDF7nRHGXb9cLQX8yiz2ErQg4J0zc/sfr2pljh2cmGz4iiU1xaIm4Qy/4B1YjO4DGI2Ih+/gRmjF6Ra/68jWm9OL35gl3aNBzGRwSqqGBBlY7dAS3AIGT+YVGudLOVk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:21686805-0883-40ef-aaf0-1fc2912391b5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:494913d1-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 13dd3030806511efb66947d174671e26-20241002
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 535654352; Wed, 02 Oct 2024 10:21:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 10:21:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Oct 2024 10:21:43 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v3 0/6] Enable Mali GPU on MediaTek Genio 700 EVK
Date: Wed, 2 Oct 2024 10:21:32 +0800
Message-ID: <20241002022138.29241-1-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.044400-8.000000
X-TMASE-MatchedRID: KEJBxOLBAjImTNBjrl+CAW3NvezwBrVmojQrbrPpzzqGisL/BZ/9PdW+
	IybvzGvgeyV2YHoU7/9OpyDH40bTVCZ6g2ERe8TsEhGH3CRdKUW1k3bRIdXVNDRCaZSKE/OsA1b
	OITH3wO2jkL1tNPFpRvdsbxOBLnf/SSOWVJeuO1AURSScn+QSXhhJCIHRlO51+gtHj7OwNO2tdP
	9AzJTY3N0bSp+8QIl/aV4pUm/qj5FdlXbNLWcTJSSNE2xxcJan3FPN7y72I2X/VPzeOYtIXNrfj
	pJgt9jNWLbrjyWszO633j8cs89UgXZrUbEZipAEiWT09mQz7szw9kH8zAy44SIduk5Jkjd3Vcr2
	04P67pw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.044400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BB5BB6716194BF829B372D5EC5D1D350D243FA7ACD22CFF460F39C63E9B156DF2000:8
X-MTK: N

This series is based on linux-next, tag: next-20240927

Enables the GPU on mt8390-genio-700-evk.dts. 
The panfrost driver probed with dmesg:

panfrost 13000000.gpu: clock rate = 390000000
panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0 minor 0x0 status 0x0
panfrost 13000000.gpu: features: 00000000,000019f7, 
  issues: 00000003,80000400
panfrost 13000000.gpu: Features: L2:0x08130206 Shader:0x00000000
  Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
panfrost 13000000.gpu: shader_present=0x10005 l2_present=0x1
[drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0

Changes in v3:
- Drop patch "nvmem: mtk-efuse: Enable postprocess for mt8188 GPU
 speed binning" as suggested by Angelo.
- Add patch "dt-bindings: nvmem: mediatek: efuse: Reuse mt8186-efuse in mt8188"
 to reuse "mediatek,mt8186-efuse" compatible.
- Updated patch "arm64: dts: mediatek: mt8188: Add efuse for GPU speed binning"
 to revise the compatible string and remove Reviewed-By tag.

Pablo Sun (6):
  arm64: dts: mediatek: mt8188: Fix wrong clock provider in MFG1 power
    domain
  clk: mediatek: clk-mt8188-topckgen: Remove univpll from parents of
    mfg_core_tmp
  dt-bindings: nvmem: mediatek: efuse: Reuse mt8186-efuse in mt8188
  arm64: dts: mediatek: mt8188: Add efuse for GPU speed binning
  soc: mediatek: mediatek-regulator-coupler: Support mt8188
  arm64: dts: mediatek: mt8390-genio-700-evk: Enable Mali GPU

 .../bindings/nvmem/mediatek,efuse.yaml        |  4 +++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 13 ++++++--
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 31 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt8188-topckgen.c    |  9 ++++--
 drivers/soc/mediatek/mtk-regulator-coupler.c  |  1 +
 5 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.45.2



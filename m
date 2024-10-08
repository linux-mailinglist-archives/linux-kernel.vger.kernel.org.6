Return-Path: <linux-kernel+bounces-354642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580E994088
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13911C24944
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDBE200121;
	Tue,  8 Oct 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VRL022xj"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA431FF7D5;
	Tue,  8 Oct 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371756; cv=none; b=YrKeRWrlQLB1ULeVZm2DuTWDcrj8K4JktRW52E27X7FYErza8bQIDVWVQJcgI7DUdr2GtuDjOY0eOMjKgyIlzKE4tfW863uIaLHHwvq8iRGJN3ATDNFKvY3TGoohyBakUxQCs0DYinzYmnppZ2yM4w4uuchjJpARSJeeNRhncs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371756; c=relaxed/simple;
	bh=wB+CnyJMHS+Nlxfeo611NP8PCYTpzaH6o0xPYIkualc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YfonqcWa9eef9R9735etLr1NJwW/VMhfl/B16Pxn24kAclFEq5SLY5kwPB1MYmYQr1NabMpYG5kyQCoW3N0t+caal855PnIU7NsYM1VfR6BafRzWRWct1LnJlxcykiJ6/tUYK8WkEMPYQAY4RFPYy2Xbuw+Q6su1xm6baynC/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VRL022xj; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 24c8e594854511ef88ecadb115cee93b-20241008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=uoyI+nVkYzrj6lLhx8WQAuejk7KwoCBnxwU+9IsqgPw=;
	b=VRL022xjvG2XR5m947070JkYnaGEfD5J+9Q9hOJAX73kd20ylvJR7xx2fYAF+FDSORNsiHf1/n6sKi2KcIByCUuGw2RaPEKerUAtRCxgx2B33ccrvLNAvvdzXcLb1if9F0rU3PIkkmB3B+NY8QnGrjBPjGtkOS0+ckYtUVEwslw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ad63e665-a456-42fc-b842-33c99c749aa2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:33cc7526-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 24c8e594854511ef88ecadb115cee93b-20241008
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 504953561; Tue, 08 Oct 2024 15:15:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Oct 2024 15:15:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Oct 2024 15:15:47 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Seiya Wang <seiya.wang@mediatek.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen
 Chu <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH v2] arm64: dts: mediatek: mt8195: Fix dtbs_check error for tphy
Date: Tue, 8 Oct 2024 15:15:40 +0800
Message-ID: <20241008071540.32607-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The u3phy1 node in mt8195.dtsi was triggering a dtbs_check error.
The error message was:
  t-phy@11e30000: 'power-domains' does not match any of the regexes:
    '^(usb|pcie|sata)-phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
Fix this issue by dropping 'power-domains' of u3phy1 node.

This is because MediaTek tphy dose not need to add mtcmos.  It is not
necessary to add 'power-domains'. If the power of the tphy is turned off,
it will affect other functions. From the current USB hardware design
perspective, even if mtcmos is added to the phy, it is always on.

Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 -
 1 file changed, 1 deletion(-)

Changes for v2:
 - Add detail description of the tphy design for explaining the reason
   of this change.

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index ade685ed2190..1c6f08dde31c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1920,7 +1920,6 @@ u3phy1: t-phy@11e30000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0 0x11e30000 0xe00>;
-			power-domains = <&spm MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY>;
 			status = "disabled";
 
 			u2port1: usb-phy@0 {
-- 
2.45.2



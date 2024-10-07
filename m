Return-Path: <linux-kernel+bounces-353114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058569928CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2143286039
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F239118BC09;
	Mon,  7 Oct 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jSn/UOxA"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45FA231CA9;
	Mon,  7 Oct 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295690; cv=none; b=BiM8TuptTwH+1CnaBs2OvCNwlom1fKWdMbrfkX2VKv3xOP7ejKLXU+89PWeNeay3Giz1BM5iLFY/IT7fs9hgb6Y9JW6RS2VRBmbfMzYsap+r30gVprYLBlbshgP8A2H9ZBI6tiMixFtMrMR1WDuW+WqixMWsqU7dVyHf49RjqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295690; c=relaxed/simple;
	bh=Nvv2QIrQSR6i2kMgLqXqzNmD2D7ghA1/2S+65g2qM64=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kJ6cauozLQPDCwq+6GAQGMRC1IKeVNqH2Qu1Tr6s9VKNOdmS3nTzoRBxRc8EQQzEcPh9RMfF0DSsaC2DPOlSvqRqIVl2fftKb1ehZWb4vZDL5WnG0sh0ByE+AH8JXp69dfFd/Yyk9a9OWBc8B2gzjwXT+P47VpDAPdHmC892gEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jSn/UOxA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 092d0a24849411ef8b96093e013ec31c-20241007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xRF+WqijDSYeiE+tIaQ004Lnw2TEBFE2Gfpl2FGIHNs=;
	b=jSn/UOxAXl5jZDKgPrOkOR3ZlvXw3+fdqrOTsctLfqcXm7fzKdbtJwZ73e8hCYKc6WqlxJ8A5B02iSvC2T3JLrmFyvGcOvBahe5DtybLb9e7621mIp0/a8bqoxSvtSuShzI+9eZvkdBBB/HSRFsOUHNqS0PemFVE/1jAKjltghY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:15f711da-35f7-4db5-b29a-d2b1cc0819d7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:916cdf40-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 092d0a24849411ef8b96093e013ec31c-20241007
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1443292378; Mon, 07 Oct 2024 18:08:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Oct 2024 18:08:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Oct 2024 18:08:00 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Jieyy Yang <jieyy.yang@mediatek.com>,
	Jian Yang <jian.yang@mediatek.com>, Jianguo Zhang
	<jianguo.zhang@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen
 Chu <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH] arm64: dts: mediatek: mt8390-genio-700-evk: enable pcie
Date: Mon, 7 Oct 2024 18:07:49 +0800
Message-ID: <20241007100749.6657-1-macpaul.lin@mediatek.com>
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

Enable PCIE, PCIEPHY and related Pinctrls for mt8390-genio-700-evk
board.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Changes for v1:
 - This patch depends on the pcie patch of mt8188.dtsi
   [1] https://lore.kernel.org/all/20241004081218.55962-3-fshao@chromium.org/

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 3e77f59f2c74..bb68665f0b2d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -393,6 +393,16 @@ &mt6359codec {
 	mediatek,mic-type-1 = <3>; /* DCC */
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins_default>;
+	status = "okay";
+};
+
+&pciephy {
+	status = "okay";
+};
+
 &pio {
 	audio_default_pins: audio-default-pins {
 		pins-cmd-dat {
@@ -758,6 +768,15 @@ pins-rst {
 		};
 	};
 
+	pcie_pins_default: pcie-default {
+		mux {
+			pinmux = <PINMUX_GPIO47__FUNC_I1_WAKEN>,
+				 <PINMUX_GPIO48__FUNC_O_PERSTN>,
+				 <PINMUX_GPIO49__FUNC_B1_CLKREQN>;
+			bias-pull-up;
+		};
+	};
+
 	rt1715_int_pins: rt1715-int-pins {
 		pins_cmd0_dat {
 			pinmux = <PINMUX_GPIO12__FUNC_B_GPIO12>;
-- 
2.45.2



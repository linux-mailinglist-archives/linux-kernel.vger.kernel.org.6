Return-Path: <linux-kernel+bounces-523929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED28A3DD06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9835421A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777B41FBEAB;
	Thu, 20 Feb 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pOPGWVnn"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42D1D5AD4;
	Thu, 20 Feb 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062094; cv=none; b=V/PgfJ7GXoRnRsg3efwJSJQwqys5btERKDGHYrvm7P6xCgsQS5FT1CmOWLFXd2YNQhtA5GCgmdKmjZtt1sfzjQWPur9BuGrt33idXKq5bHN83BinM49uSb5Ki2P2I0FeS5u5Ucu3t02H8X3JDSbp22pQR8SorjgfGDt7UjvnnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062094; c=relaxed/simple;
	bh=lE5AXf9alDZl07YL5bLXxY1kDbZritBNauw65SCYKY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnfkwXzjQpHDbVN+x6q8fcvKilk/q3k7At3n36fTgCAjYnt7E3VK9AfEcthNCH2gwF+R3OShXxMGUWH8qE6Cs1OO9iOZ6w3vSGKi4+DehjT0Ta3Usz9ycrJ42bqEsYwl+ulUJO3T7DK3Kk1tQolS3anFAkcgQiz+Ey2R4axRsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pOPGWVnn; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d59e5932ef9711efaae1fd9735fae912-20250220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PSrQTSCqMjbqIbURLRKTd4NKXbT6AEa8/dleY0GQJaQ=;
	b=pOPGWVnnNq48hkYu4FY898PCNbCrVpZpKkJIgVMO+nkEmfRYrDDh7V/FHSVQIW2iN+I1Faiu7/9iRzNe6nPUSRSTVClE78miqt2BhK8l+VZLbAxNs0FYbfNPdfNriJUkJJxIFR4mjlOlEUS9LFlLiSO3Vg66uMEDo2dijLxWXvE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:c927acf8-5a3b-4064-8c00-fea434e67a8a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:b09921dc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d59e5932ef9711efaae1fd9735fae912-20250220
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2005052567; Thu, 20 Feb 2025 22:34:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 20 Feb 2025 22:34:46 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 20 Feb 2025 22:34:46 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-usb@vger.kernel.org>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	Fabien Parent <fparent@baylibre.com>, Simon Sun <simon.sun@yunjingtech.com>
Subject: [PATCH v4 2/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add support for MUX IT5205
Date: Thu, 20 Feb 2025 22:33:54 +0800
Message-ID: <20250220143354.2532448-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250220143354.2532448-1-macpaul.lin@mediatek.com>
References: <20250220143354.2532448-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add ITE IT5205 (TYPEC MUX) under I2C2 bus and configure its properties;
also add references to it5205fn from MT6360 TYPE-C connector for TYPEC
configuration.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8395-genio-1200-evk.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

Changes for v2:
 - This is a new patch in the v2 patch.

Changes for v3:
 - No change.

Changes fo4 v4:
 - Drop it5205fn phandle for node typec-mux@48.
 - Reorder properties of typec-mux@48
 - Add "Reviewed-by:" tag. Thanks!

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index ca039c8e4c71..8ec5c4cf59f3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -224,6 +224,21 @@ &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	typec-mux@48 {
+		compatible = "ite,it5205";
+		reg = <0x48>;
+		vcc-supply = <&mt6359_vibr_ldo_reg>;
+		mode-switch;
+		orientation-switch;
+		status = "okay";
+
+		port {
+			it5205_sbu_ep: endpoint {
+				remote-endpoint = <&mt6360_ssusb_sbu_ep>;
+			};
+		};
+	};
 };
 
 &i2c6 {
@@ -368,6 +383,13 @@ typec_con_ss: endpoint {
 							remote-endpoint = <&mtu3_ss0_role_sw>;
 						};
 					};
+
+					port@2 {
+						reg = <2>;
+						mt6360_ssusb_sbu_ep: endpoint {
+							remote-endpoint = <&it5205_sbu_ep>;
+						};
+					};
 				};
 			};
 		};
-- 
2.45.2



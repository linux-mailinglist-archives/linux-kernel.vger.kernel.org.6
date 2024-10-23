Return-Path: <linux-kernel+bounces-377516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59BA9ABFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215421C212CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB49153BEE;
	Wed, 23 Oct 2024 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P8mN/KnB"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357614D430;
	Wed, 23 Oct 2024 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667565; cv=none; b=MavGrQ3n0OABhUbDAzCAE5otGRa2gqnNipWEy/SWT3Wz5N5nYY+1zogQrq2b7wZ0XLcOil7ih3GhWPI29nQnc9isj4fPxWXekGOXj2UPKYNtxWMl2enz/f1Ckes4v2IZf6gTaG6/Ou+7c/rlSCO/sB1YclYp3ILal05KCCc/KHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667565; c=relaxed/simple;
	bh=aqlKhcczblCkJ2Ir6ENH/zKeUhbm7Ux7gXxHKgQWy2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRKHHibBD+xysL2q6MvmImB6BY7y7Ab4u5BJ36ai4/aUYMo17aHMHmrKLcTJkndKVdJZq30LbRHNKdNR0A8b929Ec1ksH9nbkU2AoCXUh5xXqkzLi2FBwzPPQDtmzVbocJuneR1BymJ4A7fOY+gkKX4Ewt7ZYH2jnLpzGVP3xf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=P8mN/KnB; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2ec6a1f6910e11efb88477ffae1fc7a5-20241023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dG13J0Y11zTLAF6mBQ+UKC5Y5vRX6I05iFRrQ0sCp64=;
	b=P8mN/KnBQtXDsjwd+MKwHGTYsJx/q2GnOLDvMq/7Ud7Io/HFr/Y5zNKOsdnqgSNUojUQpDoRtP7hs+QfFpmb1vTwiMdMNbYYtAmob/a+Mh4Bdo2xwr5bHBlYDuw4NwZ38CIqB3TjiwBV5nWxbZsENky6xVyPNpxS6vZVoVudsko=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:d131dfeb-7149-4069-9f7a-ba97f79451a4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:c3a3bacc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2ec6a1f6910e11efb88477ffae1fc7a5-20241023
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1590350549; Wed, 23 Oct 2024 15:12:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 15:12:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Oct 2024 15:12:33 +0800
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
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add support for MUX IT5205
Date: Wed, 23 Oct 2024 15:12:26 +0800
Message-ID: <20241023071226.14090-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241023071226.14090-1-macpaul.lin@mediatek.com>
References: <20241023071226.14090-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.849300-8.000000
X-TMASE-MatchedRID: y/MOm6ldwRLwi+JtrEQDF/OS+SRxjgFwO8xCfog1G6TfUZT83lbkECc/
	xZYu98DIXlLd88CeldeEWLXMLbnj9s9tfSEZlKTR0Xw0ILvo/uV9LQinZ4QefPcjNeVeWlqY+gt
	Hj7OwNO2i5u/VvsFaHZo/FbJ9dxneJfIFhtB+fg142nvvg/R7I/+H0edVFfSNiWM4GkOCkv6Uc5
	7FjAsx+8BJfDkpwagKV0vb6dLWo92cVs3n0bcGPqMnTJRI0XInfXwUEm1ouDzLDYxFC1/7rn6Gd
	Nk4NWmA
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.849300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1BDDA5227DA9E30728ABF0AC3DB9070AC31DF6B397CEC1F8E8567801DD19F8AF2000:8
X-MTK: N

Add ITE IT5205FN (TYPEC MUX) under I2C2 bus and configure its properties;
also add references to it5205fn from MT6360 TYPE-C connector for TYPEC
configuration.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../dts/mediatek/mt8395-genio-1200-evk.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

Changes for v2:
 - This is a new patch in the v2 patch.

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 195e486d9101..57c68d033196 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -229,6 +229,21 @@ &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	it5205fn: typec-mux@48 {
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
@@ -282,6 +297,13 @@ mt6360_ssusb_ep: endpoint {
 							remote-endpoint = <&ssusb_ep>;
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



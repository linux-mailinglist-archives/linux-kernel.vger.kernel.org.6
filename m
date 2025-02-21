Return-Path: <linux-kernel+bounces-525291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1281DA3EDA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6243617F6D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706C71FFC4C;
	Fri, 21 Feb 2025 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Gv7ueKez"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895A200110;
	Fri, 21 Feb 2025 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124276; cv=none; b=lrHicxOMm3MI/66//cZpMatq+0vcYSbMgtgXORX+b/lOonLtjl7WIz/jjmgkUufzesTc6wynrQ7USTKUxPZ3CuQYviCtdAwudhAZHw5H45anuE4hf/RGMsQP9N7sKTabTJHNmLEDPLXkBrAdkgCOFMkzQVtYCWQFzY6EhCjvBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124276; c=relaxed/simple;
	bh=dsa0zm7ZKsc3TUI/3W5Eh7iKueQ+/ysC7K8/5zVKicI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDkkDxpTQ7/CCFdpw95evUwXc27GYLWuNvf3Cvm8QhtcEF3CHogpUMa0MZhrcpMD7rE2CU2A3ljMzStgAZmWq4Bn31J4EhkbVZA7/WbDFiqblEf1bB7VUCGPfOjywL3lHLxw5czdWb2FtWdPz77Ww5Ffyk0V5DX5++MucnkOwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Gv7ueKez; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9b783f66f02811ef8eb9c36241bbb6fb-20250221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3BHfA1ZK9IJwn4Rwgn34SAEt3c6Rgow6Iq4j21KTuhI=;
	b=Gv7ueKezeiHiDrmMcIeCB0Kr65OuvfokufR+f+c0ysnOfJ+BGREL1/wmJ2cf8NzjBvnckRX4bcU4KuGEUFxfIYifQE930V+gDZOimrkuITHPdRI/8pzkK+5eXoF81Y4KhUcOcOhuAuJI6G0Hb7PbgmutiUWodEUVV5p3ABepJHM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:2a114fe8-b623-44eb-a0e1-249ddff220e9,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:15112adc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:5,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9b783f66f02811ef8eb9c36241bbb6fb-20250221
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1928255421; Fri, 21 Feb 2025 15:51:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 21 Feb 2025 15:51:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 21 Feb 2025 15:51:04 +0800
From: Friday Yang <friday.yang@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Garmin Chang
	<garmin.chang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
CC: Friday Yang <friday.yang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 2/2] clk: mediatek: Add SMI LARBs reset for MT8188
Date: Fri, 21 Feb 2025 15:50:54 +0800
Message-ID: <20250221075058.14180-3-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250221075058.14180-1-friday.yang@mediatek.com>
References: <20250221075058.14180-1-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

SMI LARBs require reset functions when MTCMOS powers on or off.
Add reset platform data for SMI LARBs in the image, camera and IPE
subsystems.

Signed-off-by: Friday Yang <friday.yang@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8188-cam.c | 17 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8188-img.c | 18 ++++++++++++++++++
 drivers/clk/mediatek/clk-mt8188-ipe.c | 14 ++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8188-cam.c b/drivers/clk/mediatek/clk-mt8188-cam.c
index 7500bd25387f..9b029fdd584e 100644
--- a/drivers/clk/mediatek/clk-mt8188-cam.c
+++ b/drivers/clk/mediatek/clk-mt8188-cam.c
@@ -20,6 +20,8 @@ static const struct mtk_gate_regs cam_cg_regs = {
 #define GATE_CAM(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &cam_cg_regs, _shift, &mtk_clk_gate_ops_setclr)

+#define CAM_SYS_SMI_LARB_RST_OFF	(0xA0)
+
 static const struct mtk_gate cam_main_clks[] = {
 	GATE_CAM(CLK_CAM_MAIN_LARB13, "cam_main_larb13", "top_cam", 0),
 	GATE_CAM(CLK_CAM_MAIN_LARB14, "cam_main_larb14", "top_cam", 1),
@@ -72,6 +74,17 @@ static const struct mtk_gate cam_yuvb_clks[] = {
 	GATE_CAM(CLK_CAM_YUVB_CAMTG, "cam_yuvb_camtg", "top_cam", 2),
 };

+/* Reset for SMI larb 16a/16b/17a/17b */
+static u16 cam_sys_rst_ofs[] = {
+	CAM_SYS_SMI_LARB_RST_OFF,
+};
+
+static const struct mtk_clk_rst_desc cam_sys_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = cam_sys_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(cam_sys_rst_ofs),
+};
+
 static const struct mtk_clk_desc cam_main_desc = {
 	.clks = cam_main_clks,
 	.num_clks = ARRAY_SIZE(cam_main_clks),
@@ -80,21 +93,25 @@ static const struct mtk_clk_desc cam_main_desc = {
 static const struct mtk_clk_desc cam_rawa_desc = {
 	.clks = cam_rawa_clks,
 	.num_clks = ARRAY_SIZE(cam_rawa_clks),
+	.rst_desc = &cam_sys_rst_desc,
 };

 static const struct mtk_clk_desc cam_rawb_desc = {
 	.clks = cam_rawb_clks,
 	.num_clks = ARRAY_SIZE(cam_rawb_clks),
+	.rst_desc = &cam_sys_rst_desc,
 };

 static const struct mtk_clk_desc cam_yuva_desc = {
 	.clks = cam_yuva_clks,
 	.num_clks = ARRAY_SIZE(cam_yuva_clks),
+	.rst_desc = &cam_sys_rst_desc,
 };

 static const struct mtk_clk_desc cam_yuvb_desc = {
 	.clks = cam_yuvb_clks,
 	.num_clks = ARRAY_SIZE(cam_yuvb_clks),
+	.rst_desc = &cam_sys_rst_desc,
 };

 static const struct of_device_id of_match_clk_mt8188_cam[] = {
diff --git a/drivers/clk/mediatek/clk-mt8188-img.c b/drivers/clk/mediatek/clk-mt8188-img.c
index cb2fbd4136b9..d44bfbd8308a 100644
--- a/drivers/clk/mediatek/clk-mt8188-img.c
+++ b/drivers/clk/mediatek/clk-mt8188-img.c
@@ -20,6 +20,8 @@ static const struct mtk_gate_regs imgsys_cg_regs = {
 #define GATE_IMGSYS(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &imgsys_cg_regs, _shift, &mtk_clk_gate_ops_setclr)

+#define IMG_SYS_SMI_LARB_RST_OFF	(0xC)
+
 static const struct mtk_gate imgsys_main_clks[] = {
 	GATE_IMGSYS(CLK_IMGSYS_MAIN_LARB9, "imgsys_main_larb9", "top_img", 0),
 	GATE_IMGSYS(CLK_IMGSYS_MAIN_TRAW0, "imgsys_main_traw0", "top_img", 1),
@@ -58,6 +60,17 @@ static const struct mtk_gate imgsys1_dip_nr_clks[] = {
 	GATE_IMGSYS(CLK_IMGSYS1_DIP_NR_DIP_NR, "imgsys1_dip_nr_dip_nr", "top_img", 1),
 };

+/* Reset for SMI larb 10/11a/11b/11c/15 */
+static u16 img_sys_rst_ofs[] = {
+	IMG_SYS_SMI_LARB_RST_OFF,
+};
+
+static const struct mtk_clk_rst_desc img_sys_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = img_sys_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(img_sys_rst_ofs),
+};
+
 static const struct mtk_clk_desc imgsys_main_desc = {
 	.clks = imgsys_main_clks,
 	.num_clks = ARRAY_SIZE(imgsys_main_clks),
@@ -66,26 +79,31 @@ static const struct mtk_clk_desc imgsys_main_desc = {
 static const struct mtk_clk_desc imgsys_wpe1_desc = {
 	.clks = imgsys_wpe1_clks,
 	.num_clks = ARRAY_SIZE(imgsys_wpe1_clks),
+	.rst_desc = &img_sys_rst_desc,
 };

 static const struct mtk_clk_desc imgsys_wpe2_desc = {
 	.clks = imgsys_wpe2_clks,
 	.num_clks = ARRAY_SIZE(imgsys_wpe2_clks),
+	.rst_desc = &img_sys_rst_desc,
 };

 static const struct mtk_clk_desc imgsys_wpe3_desc = {
 	.clks = imgsys_wpe3_clks,
 	.num_clks = ARRAY_SIZE(imgsys_wpe3_clks),
+	.rst_desc = &img_sys_rst_desc,
 };

 static const struct mtk_clk_desc imgsys1_dip_top_desc = {
 	.clks = imgsys1_dip_top_clks,
 	.num_clks = ARRAY_SIZE(imgsys1_dip_top_clks),
+	.rst_desc = &img_sys_rst_desc,
 };

 static const struct mtk_clk_desc imgsys1_dip_nr_desc = {
 	.clks = imgsys1_dip_nr_clks,
 	.num_clks = ARRAY_SIZE(imgsys1_dip_nr_clks),
+	.rst_desc = &img_sys_rst_desc,
 };

 static const struct of_device_id of_match_clk_mt8188_imgsys_main[] = {
diff --git a/drivers/clk/mediatek/clk-mt8188-ipe.c b/drivers/clk/mediatek/clk-mt8188-ipe.c
index 8f1933b71e28..70a011c1f9ce 100644
--- a/drivers/clk/mediatek/clk-mt8188-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8188-ipe.c
@@ -20,6 +20,8 @@ static const struct mtk_gate_regs ipe_cg_regs = {
 #define GATE_IPE(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &ipe_cg_regs, _shift, &mtk_clk_gate_ops_setclr)

+#define IPE_SYS_SMI_LARB_RST_OFF	(0xC)
+
 static const struct mtk_gate ipe_clks[] = {
 	GATE_IPE(CLK_IPE_DPE, "ipe_dpe", "top_ipe", 0),
 	GATE_IPE(CLK_IPE_FDVT, "ipe_fdvt", "top_ipe", 1),
@@ -28,9 +30,21 @@ static const struct mtk_gate ipe_clks[] = {
 	GATE_IPE(CLK_IPE_SMI_LARB12, "ipe_smi_larb12", "top_ipe", 4),
 };

+/* Reset for SMI larb 12 */
+static u16 ipe_sys_rst_ofs[] = {
+	IPE_SYS_SMI_LARB_RST_OFF,
+};
+
+static const struct mtk_clk_rst_desc ipe_sys_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = ipe_sys_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(ipe_sys_rst_ofs),
+};
+
 static const struct mtk_clk_desc ipe_desc = {
 	.clks = ipe_clks,
 	.num_clks = ARRAY_SIZE(ipe_clks),
+	.rst_desc = &ipe_sys_rst_desc,
 };

 static const struct of_device_id of_match_clk_mt8188_ipe[] = {
--
2.46.0



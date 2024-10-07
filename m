Return-Path: <linux-kernel+bounces-352699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24969922CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 04:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A341B222C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217C1171D;
	Mon,  7 Oct 2024 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E5/7I1yU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715A33FE
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728269084; cv=none; b=FDQaFiJCjCAVWGxA+e5cY8xHt0F+1MefEc/Eusxk1N2eWf7jyXekHdHVSYv6o/Lt/nVecqImAE0uZCgSwkaBbtw0u2x/aRHzm/4xHJrJkZAux6PE8ycJtg/ZcMKCOXD8niyY7SXrfea71EWXGLAXdTcJAQTpUmqcDlxSjDgjLSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728269084; c=relaxed/simple;
	bh=arRI+Ny7bCW4RIoZvGnb0fg89AFXHo9m34s5RLJt+Q8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JPcBAA1bQk65aFYiU6ySIpur9ZwcgBdCP9qEyIaGw4YOVOyxnfPKoLtELee4EaVojpCtPZaOZzpNmUUklTvX0q7aRvsqwMNY0CbU/1ZVMGftvK0pduCThZmwe9nbiShVwjQEpqH+jzBTY+HF148dEEt2ZhRREEWXLhSpWZZ+Ddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E5/7I1yU; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 13420d54845611efb66947d174671e26-20241007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Lc8ruaBmuClVv6jKY+UwbLVrhQa4kd7YEydWFIokluY=;
	b=E5/7I1yUy4m7LuMUYr5rh6qxn61slqFr0JvOOt9V7EcsUYuBRR8bURTN0yO+4dTmI7FhbYCWRZILPtKSYueHuHtQsWBXLcuhIexEOm1I+8FA0K1kTSnGhyfmExE1SA53MnV9nXzk/3vRx+QpP7HZMmI5e/4Wln2+bJ5EIwHv4PU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:deec1780-aa41-41be-9ed6-1f9840bc462d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:ae9c6126-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 13420d54845611efb66947d174671e26-20241007
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1452206281; Mon, 07 Oct 2024 10:44:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Oct 2024 10:44:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Oct 2024 10:44:26 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, "Sen
 Chu" <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH] soc: mediatek: pwrap: add pwrap driver for MT8188 SoC
Date: Mon, 7 Oct 2024 10:43:50 +0800
Message-ID: <20241007024350.7878-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.330200-8.000000
X-TMASE-MatchedRID: Lx+z0QQ7WQzMHUInqqZ02m3NvezwBrVmbd6rGhWOAwTvksLyT2rH0flY
	oV6p/cSxEc8OveTE8ifBowxuB9F6wnVkgEm9JWcdFYJUGv4DL3x9LQinZ4QefPcjNeVeWlqY+gt
	Hj7OwNO3x/F0UMEoTu6PVes6PULD+Jqo2WRVUqOu4+0yNOBdx7s/YGhV+CHHtxz43l3L7/1DURw
	1qtj+SMJmLv3skqBS9bX3DR8zNrRF/EKhRRqJkqaMnTJRI0XInfXwUEm1ouDzLDYxFC1/7rn6Gd
	Nk4NWmA
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.330200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	706DD3ECF896AB75FC26799BD8F81C70939B8EC67BB206DDC93097D410ABA4682000:8
X-MTK: N

MT8188 are highly integrated SoC and use PMIC_MT6359 for
power management. This patch adds pwrap master driver to
access PMIC_MT6359.

Signed-off-by: Sen Chu <sen.chu@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 9fdc0ef79202..5d3c90e32067 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1087,6 +1087,23 @@ static const int mt8183_regs[] = {
 	[PWRAP_WACS2_VLDCLR] =			0xC28,
 };
 
+static int mt8188_regs[] = {
+	[PWRAP_INIT_DONE2] =            0x0,
+	[PWRAP_STAUPD_CTRL] =           0x4C,
+	[PWRAP_TIMER_EN] =              0x3E4,
+	[PWRAP_INT_EN] =                0x420,
+	[PWRAP_INT_FLG] =               0x428,
+	[PWRAP_INT_CLR] =               0x42C,
+	[PWRAP_INT1_EN] =               0x450,
+	[PWRAP_INT1_FLG] =              0x458,
+	[PWRAP_INT1_CLR] =              0x45C,
+	[PWRAP_WACS2_CMD] =             0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =    0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =    0x894,
+	[PWRAP_WACS2_VLDCLR] =          0x8A4,
+	[PWRAP_WACS2_RDATA] =           0x8A8,
+};
+
 static const int mt8195_regs[] = {
 	[PWRAP_INIT_DONE2] =		0x0,
 	[PWRAP_STAUPD_CTRL] =		0x4C,
@@ -1324,6 +1341,7 @@ enum pwrap_type {
 	PWRAP_MT8173,
 	PWRAP_MT8183,
 	PWRAP_MT8186,
+	PWRAP_MT8188,
 	PWRAP_MT8195,
 	PWRAP_MT8365,
 	PWRAP_MT8516,
@@ -1845,6 +1863,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	case PWRAP_MT6797:
 	case PWRAP_MT8173:
 	case PWRAP_MT8186:
+	case PWRAP_MT8188:
 	case PWRAP_MT8365:
 	case PWRAP_MT8516:
 		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
@@ -2393,6 +2412,19 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
 	.init_soc_specific = pwrap_mt8183_init_soc_specific,
 };
 
+static struct pmic_wrapper_type pwrap_mt8188 = {
+	.regs = mt8188_regs,
+	.type = PWRAP_MT8188,
+	.arb_en_all = 0x777f,
+	.int_en_all = 0x180000,
+	.int1_en_all = 0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_ARB,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static const struct pmic_wrapper_type pwrap_mt8195 = {
 	.regs = mt8195_regs,
 	.type = PWRAP_MT8195,
@@ -2456,6 +2488,7 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 	{ .compatible = "mediatek,mt8173-pwrap", .data = &pwrap_mt8173 },
 	{ .compatible = "mediatek,mt8183-pwrap", .data = &pwrap_mt8183 },
 	{ .compatible = "mediatek,mt8186-pwrap", .data = &pwrap_mt8186 },
+	{ .compatible = "mediatek,mt8188-pwrap", .data = &pwrap_mt8188 },
 	{ .compatible = "mediatek,mt8195-pwrap", .data = &pwrap_mt8195 },
 	{ .compatible = "mediatek,mt8365-pwrap", .data = &pwrap_mt8365 },
 	{ .compatible = "mediatek,mt8516-pwrap", .data = &pwrap_mt8516 },
-- 
2.45.2



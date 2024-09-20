Return-Path: <linux-kernel+bounces-334371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7197D662
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4571F2502E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CF517BEAC;
	Fri, 20 Sep 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WIT7j+3+"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CDB17BB0F;
	Fri, 20 Sep 2024 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839751; cv=none; b=ZP8OqMYdI5vEWVJgAusBspuC84jaXx+XsExxTHK3rrddu5ApIk5+CtnbkLj5WkEnC+4/YYCGWsNRUfgbiTTQdon4J5PokafCnhR4oJhnsMyroszx58PU+Xlo3x7vvfNK7JDT7A/kdlrtUrYqc1ktww6p0pfOylUYnMPjypRbpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839751; c=relaxed/simple;
	bh=rO+DFtjnNoakem7Mt3wC/njZfsI8NcL1HUeldA3qdks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Efas3yKzzIa2VnTN43FAbYGBoYjTTUt2V8b+03pPzxaP+UF/yxdBL3irANgyFh1mohH9giDAcYVcixOyIjm3XoABAdEG7Uc1ppgki5gJY1pNxbYaws55udan6Zm0waivec7Ratpc/Wb+tvj0LdV4WkhkI4OX8sd2pld83K+C1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WIT7j+3+; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2a97a084775611ef8b96093e013ec31c-20240920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MarHWvPhnrRmZZ0mB9cLT4wuW+YFOfVdbYWu9RkLw6U=;
	b=WIT7j+3+5Qtm2JB7vxxF5MpHQ6wEdNFV5sIWTImJqn/MHnBa4mCfo8iNYYaH1F9WbglQfMZquwrV+2fvi6jC1hUb12+m2dIXBVcxuJuXVUGy8p/YZVL12J0Z+ukvTajHh4l7OjQCtHDKDb/6Uryl5an6VRewfsjaHUKhpUgpcvE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f0b21068-757b-455d-aa41-3590e8039bd1,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:aeb94e9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2a97a084775611ef8b96093e013ec31c-20240920
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 374313643; Fri, 20 Sep 2024 21:42:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 20 Sep 2024 06:42:22 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 20 Sep 2024 21:42:22 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH 3/5] nvmem: mtk-efuse: Enable postprocess for mt8188 GPU speed binning
Date: Fri, 20 Sep 2024 21:41:09 +0800
Message-ID: <20240920134111.19744-4-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240920134111.19744-1-pablo.sun@mediatek.com>
References: <20240920134111.19744-1-pablo.sun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Similar to mt8186, the efuse data for mt8188's GPU speed binning
requires post-process to convert the bit field format expected
by the OPP table.

Since mt8188 efuse is not compatible to mt8186, add a new compatible
entry for mt8188 and enable postprocess.

Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
---
 drivers/nvmem/mtk-efuse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 9caf04667341..4984145025bb 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -105,6 +105,10 @@ static const struct mtk_efuse_pdata mtk_mt8186_efuse_pdata = {
 	.uses_post_processing = true,
 };
 
+static const struct mtk_efuse_pdata mtk_mt8188_efuse_pdata = {
+	.uses_post_processing = true,
+};
+
 static const struct mtk_efuse_pdata mtk_efuse_pdata = {
 	.uses_post_processing = false,
 };
@@ -112,6 +116,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pdata = {
 static const struct of_device_id mtk_efuse_of_match[] = {
 	{ .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
 	{ .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
+	{ .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8188_efuse_pdata },
 	{ .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
 	{/* sentinel */},
 };
-- 
2.45.2



Return-Path: <linux-kernel+bounces-346936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2610E98CB37
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BAF2830AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3CBE40;
	Wed,  2 Oct 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AFP5GQBM"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51D23BB;
	Wed,  2 Oct 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835716; cv=none; b=i4ntBEZ+gjxaZaY6623mDXQvBzAi1grHlM/h3JL0FodpN0eWkdbTX0FfplGXyGb4R7vq343QFuwp6GDwGi/g6D+QwEUTLt9orbITTKNFKuTS6af/28zeOpSh0LBgQOVDmT2OEsk9zR1z/N2V/5WIJmPVYH8WBmQQeZ6YIjVKDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835716; c=relaxed/simple;
	bh=Yr21CsAAEwgJudKdThCXG2Z6+ajUMQ0dlt18JPXTnFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oir88hWIQyi//CjwauyRAYMmTS1XCdrk/Upp/+DqlZKg5ndcC8QoGqK+Ae+C/be9jw1IbIkJYXokR1Lyy/ABTS8pn1Qqj/4waxQEl9c7dPqIUAMP9WlSAzG8u+H0fCGdDnBd5LJ2M5YGkiz30wCNVAZ/SqZiPLQRpd8Y4aWTXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AFP5GQBM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1520bdae806511efb66947d174671e26-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1zObuiTQhxW/rlGHABQlocVTuM4eYd/LNgN0pppkVxg=;
	b=AFP5GQBMUNEA9zvyAce7Ei69EjmJelC1zCWurN+baaI93KnTK84+J//bCAY5/Cf4om8+mnOqYaRoN+mvVwfR+3KtTbwVQw4AxLbEjyMVGj0pj1Eaz9zJdtHek16Qzvok6QGEu1c3fEvTWV+KSOwrWxw+Vxh5hq6pCLeD/C32whA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:7452a59f-4da5-4216-a2ca-c086d81df505,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:6dc6a47,CLOUDID:db94a6ed-33c7-4396-bf34-2026ee4f15f5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1520bdae806511efb66947d174671e26-20241002
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 738533679; Wed, 02 Oct 2024 10:21:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 10:21:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Oct 2024 10:21:49 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v3 2/6] clk: mediatek: clk-mt8188-topckgen: Remove univpll from parents of mfg_core_tmp
Date: Wed, 2 Oct 2024 10:21:34 +0800
Message-ID: <20241002022138.29241-3-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241002022138.29241-1-pablo.sun@mediatek.com>
References: <20241002022138.29241-1-pablo.sun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Same as MT8195, MT8188 GPU clock is primarly supplied by the dedicated
mfgpll. The clock "mfg_core_tmp" is only used as an alt clock when
setting mfgpll clock rate.

If we keep the univpll parents from mfg_core_tmp, when setting
GPU frequency to 390000000, the common clock framework would switch
the parent to univpll, instead of setting mfgpll to 390000000:

    mfgpll                            0        0        0   949999756
    univpll                           2        2        0  2340000000
       univpll_d6                     1        1        0   390000000
          top_mfg_core_tmp            1        1        0   390000000
             mfg_ck_fast_ref          1        1        0   390000000
                mfgcfg_bg3d           1        1        0   390000000

This results in failures when subsequent devfreq operations need to
switch to other frequencies. So remove univpll from the parent list.

This solution is taken from commit 72d38ed720e9 ("clk: mediatek:
clk-mt8195-topckgen: Drop univplls from mfg mux parents")

Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8188-topckgen.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
index c4baf4076ed6..6b07abe9a8f5 100644
--- a/drivers/clk/mediatek/clk-mt8188-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
@@ -342,11 +342,14 @@ static const char * const dsp7_parents[] = {
 	"univpll_d3"
 };
 
+/*
+ * MFG can be also parented to "univpll_d6" and "univpll_d7":
+ * these have been removed from the parents list to let us
+ * achieve GPU DVFS without any special clock handlers.
+ */
 static const char * const mfg_core_tmp_parents[] = {
 	"clk26m",
-	"mainpll_d5_d2",
-	"univpll_d6",
-	"univpll_d7"
+	"mainpll_d5_d2"
 };
 
 static const char * const camtg_parents[] = {
-- 
2.45.2



Return-Path: <linux-kernel+bounces-341615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2895F988278
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8D61F22767
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBDA1BBBC9;
	Fri, 27 Sep 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UzlmxgXJ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C7189BB8;
	Fri, 27 Sep 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433061; cv=none; b=fJ13JkU5Tu/LptBQGgUdvyuK6vvCni2gYP0ghDyiiZudBu2edLfHfKoXZMuHBiHy9q5D509pN3UYMjQ/tRYx3MAEbhyVE6dBQEXah0b5u0iP8fHrNsr/jiL1sHlG+rjDknsYi4GfxLbdzi9Adnif0Tqd5B3Fi4mlnz/Mg9MM/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433061; c=relaxed/simple;
	bh=Yr21CsAAEwgJudKdThCXG2Z6+ajUMQ0dlt18JPXTnFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZY+fjEyFPTtmGgJSiuCbLG0RU41mYpOIx33yHuFzZF5VuHsmB0svLzy3eW7glOysvSuNeqmicuI674V1Jpb9Qrae0G0HF84uq0kHSNACTYZ1IbOhAFEgMS75YiQZQiMxwf7AFNcFzd2riYQmhOwEmfEmJ5T3y2b44QXf9+Qp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UzlmxgXJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9366b4d27cbb11efb66947d174671e26-20240927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1zObuiTQhxW/rlGHABQlocVTuM4eYd/LNgN0pppkVxg=;
	b=UzlmxgXJGgO4+t51pMrKQ3J2Pe/MO0Xt9DSOmQlW27A8CqgyaEt5SNi9M4xvkAKsfqmXzRvKfqENnhibbyaULl00+IErKqQI++dfJkBd8qln6SctUUCuzmiiQhUV9aqhX31ENhArCKdStVY/ejivp8UnPxxHf7UR0C1Bbmb2AAA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:554c8971-fd57-4310-ba9d-db4ce7d215a9,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:8fde5a18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9366b4d27cbb11efb66947d174671e26-20240927
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1894307034; Fri, 27 Sep 2024 18:30:54 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Sep 2024 18:30:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Sep 2024 18:30:52 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Srinivas
 Kandagatla" <srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v2 2/6] clk: mediatek: clk-mt8188-topckgen: Remove univpll from parents of mfg_core_tmp
Date: Fri, 27 Sep 2024 18:30:01 +0800
Message-ID: <20240927103005.17605-3-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240927103005.17605-1-pablo.sun@mediatek.com>
References: <20240927103005.17605-1-pablo.sun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.252300-8.000000
X-TMASE-MatchedRID: HeXu+URsDm0X/DgtOsKbJEKcYi5Qw/RVYU4M4UEhdYoOUs4CTUgKy6dy
	K1rXVA/F9tuSNsrGP8feAMGbXnKiN7UN8Yzp1vtfY1bQMCMvmn744jpewrcFYd9RlPzeVuQQj3Q
	bFpHxze16x+6+hw5F9YAy6p60ZV62fJ5/bZ6npdiujVRFkkVsm2n/dxZcthzfAoxCop8urBB/sV
	WmBTFpqjtD2bk2vochWOrrLJZ9w3iZA5i25phAPFwGzKj7bzV7iB28mlw/zlI3CWA+QZI+O46H7
	DI0GsVcMmI24qiENwrMpIbcl3IoA+q1XYAYw09q9Z1yWryVTWo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.252300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F273C4FF516C218231C131467DBBFF6BEFF1DCEEFD9B3CCEEC2167AB69E24F7D2000:8
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



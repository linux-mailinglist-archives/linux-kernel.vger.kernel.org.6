Return-Path: <linux-kernel+bounces-334372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC197D665
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4167B1F25436
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1117C222;
	Fri, 20 Sep 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Nc/S41um"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C817BEC5;
	Fri, 20 Sep 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839754; cv=none; b=ek7ZsAbLW7gySJvcvpNiDs4IymONwYvLgqRE7+NN3cq/KBkN9TP0jIujwKoDSVOj4dMPx4jScvP0Mi3H4VIsRM2fJE+N5UGn/Es2oDvWLnhuh351xK25YwcyGTZAjkU657qvtVEjJZp+w5kEFXRtxHVB658aBkw0WN3CxoCV10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839754; c=relaxed/simple;
	bh=qOceVorAZvTRXQLWP6QJKKOjlzDIeFKsARPn1D+Y6EE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1tsXcBfAmqxMFRenN5PiDN2/rKaYWdim4Y+ExHN3oi1xSnrbYnI32t4yvDSRhKQ/hKN9AghX0RPk24dVJWiQUl62LOstbGlEzKKTEc652unIqHEVDP98FiVGvTgpdynLlfsurY4CF6BgL397FMheHI7a2HExbPtWqbjP9I4opI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Nc/S41um; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2a2f0268775611efb66947d174671e26-20240920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NhoCCaFffSxTrq/SCjrYPSay+Ic98uE1jW+vIVZg6oI=;
	b=Nc/S41um9pR5RLvq8p44GuOxvaRmww6aiUGGW2Tx2vCJDnXEQhnXciFq7oou4x6bpZ4TNI5QsHlsNroCm8lA/Vyl2FP76TdXtt7JRv5KhxUJtLT8waV3XqjdrbrWzCsV5tFQHaFOJ/TaN7Jfk0I4uMqtCX3cYQIlCod4yQVukZ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:13d3936f-f18e-4eca-9f1a-25d7a2ffeda7,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:a8b94e9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2a2f0268775611efb66947d174671e26-20240920
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1352258061; Fri, 20 Sep 2024 21:42:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 20 Sep 2024 21:42:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 20 Sep 2024 21:42:21 +0800
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
Subject: [PATCH 2/5] clk: mediatek: clk-mt8188-topckgen: Remove univpll from parents of mfg_core_tmp
Date: Fri, 20 Sep 2024 21:41:08 +0800
Message-ID: <20240920134111.19744-3-pablo.sun@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.220100-8.000000
X-TMASE-MatchedRID: 6mUaupESUicX/DgtOsKbJEKcYi5Qw/RVYU4M4UEhdYoOUs4CTUgKy6dy
	K1rXVA/F9tuSNsrGP8feAMGbXnKiN7UN8Yzp1vtfA9lly13c/gHt/okBLaEo+IWXGHd13QwAo8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqt4XgtCAUmrqUKYfTzGGy8aC9j0U24TSafOrFVoj5IqtJ8dr
	/u/DLEnwHOhuuQEdvLcdzPe3Qcn3bSiULcJKjUyoEDzLGQCF4vwZBgUyJVEbl6Fw8/PpTMRaVvm
	iAyeA2kc5MSfkiJFI5QBJtcKcOYfpRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.220100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E9E4C39A28787342393ECA9258E7290EA1B256B30B3614CD06F8F7BD2D4C723A2000:8
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
---
 drivers/clk/mediatek/clk-mt8188-topckgen.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
index 2ccc8a1c98f9..74ee692ac613 100644
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
 	"mainpll_d5_d2",
-	"univpll_d6",
-	"univpll_d7"
 };
 
 static const char * const camtg_parents[] = {
-- 
2.45.2



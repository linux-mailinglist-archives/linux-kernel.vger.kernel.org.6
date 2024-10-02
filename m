Return-Path: <linux-kernel+bounces-346937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD7998CB39
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EF21F24AC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41436D528;
	Wed,  2 Oct 2024 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ICfCR4S1"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723292F44;
	Wed,  2 Oct 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835716; cv=none; b=IA2Du6pIVvwaCkaRpSMeG1QUaEEMGCGBpj4CWOxouuHe0xE5EK3qunovnoSpGurnlnGtnxuLesFd3eofmCG7ssfyQbY1Kj0HPa8bvIn3OkwRdkUJ+wonjXw4rnFtWbOYUM4Ckw2GBP+xVnZidpK9uyx1bDc5AytYWpvPbE+smOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835716; c=relaxed/simple;
	bh=p0xljmztD31PYSFLyL5vp1xd2x8LHHqqamlWrvyrZ3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LD/wrOJhGdId3LcHxZit7lpVz0yY2+YKmDzjtBmzKJ0a0sNghZqe7XIhqDYYYGEt6wDl0eU8hTivgkZKLKABG6EBt3kDFfFk+3+Yi2Mt67zBQcBnRTtCFLA8dIcuoBjdgFTWB0zKX3FjWm+F1zRF6chxTC6v13BAuSoQPCr71ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ICfCR4S1; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 14148b34806511ef8b96093e013ec31c-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sx3Vdwociw+7bgWqHeh3LpMurxRj0XhtssaWVj1YGYE=;
	b=ICfCR4S1l6K7avnpTP+noOXhCmb42nmsI/n7oizxGtdB9t5sEGKZkyGWaDhrKiFhM6L7h2njhjKjERMjCb2sAU+0escZDPNfXmWqo3m+oq+rlBBqzOXyLsQlBwOvKt5l2YJdcJn5ZUu5PdH6IU1JS07179V7Ya6Uz79K1Hilbuc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f3575a45-8ee4-4d2d-866d-674f0e5f362f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:023888b6-067a-45ef-ad40-860f1548309a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 14148b34806511ef8b96093e013ec31c-20241002
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1080636259; Wed, 02 Oct 2024 10:21:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 10:21:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Oct 2024 10:21:46 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v3 1/6] arm64: dts: mediatek: mt8188: Fix wrong clock provider in MFG1 power domain
Date: Wed, 2 Oct 2024 10:21:33 +0800
Message-ID: <20241002022138.29241-2-pablo.sun@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.548300-8.000000
X-TMASE-MatchedRID: PcZ0mOXO/jwPRVepDWIjx/fLKp/JCt7h6SXuwUgGH0iyrCkM9r1bWnTv
	v/bTZRlobaFo1bdWCGaQJkPYvdXnnwzyMxeMEX6wFEUknJ/kEl7dB/CxWTRRu+rAZ8KTspSzetP
	JfHqWaH9JLwBSa8cIhAW80jAWz86QWJqqfG38YMr34hqv8Qa5Lzd2iAQV2uozvjeXXjV9ouogrK
	mwTJoL/Ns19EgxHqqiF0aD5ljt43pMcHZD6gqu7wxMjfifIXfowkvVoA11Twp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.548300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2E5731F8DCEDE1326F76D329AE748F85559A3ABF2C5A0CA0200AF644AB264D732000:8
X-MTK: N

The clock index "CLK_APMIXED_MFGPLL" belongs to the "apmixedsys" provider,
so fix the index.

In addition, add a "mfg1" label so following commits could set
domain-supply for MFG1 power domain.

Fixes: eaf73e4224a3 ("arm64: dts: mediatek: mt8188: Add support for SoC power domains")
Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index cd27966d2e3c..02a5bb4dbd1f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -956,9 +956,9 @@ mfg0: power-domain@MT8188_POWER_DOMAIN_MFG0 {
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
 
-					power-domain@MT8188_POWER_DOMAIN_MFG1 {
+					mfg1: power-domain@MT8188_POWER_DOMAIN_MFG1 {
 						reg = <MT8188_POWER_DOMAIN_MFG1>;
-						clocks = <&topckgen CLK_APMIXED_MFGPLL>,
+						clocks = <&apmixedsys CLK_APMIXED_MFGPLL>,
 							 <&topckgen CLK_TOP_MFG_CORE_TMP>;
 						clock-names = "mfg", "alt";
 						mediatek,infracfg = <&infracfg_ao>;
-- 
2.45.2



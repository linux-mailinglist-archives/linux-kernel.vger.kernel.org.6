Return-Path: <linux-kernel+bounces-334370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2C97D65F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178EB1F24CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7593217BB0A;
	Fri, 20 Sep 2024 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SQeeA4li"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FC17B506;
	Fri, 20 Sep 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839747; cv=none; b=HxPd8wPuNOcpgltF3ECyt6AxCX+m6tC736bg6bvv+fpsdIoFZTdMD5rkJey35GZwnjJgd+/4ZQbutFTKy6NWx2n7p1y9cjLmn21gW/0ZzMb4iESsW/oDcFP6VjmI6fPZRjMpyzFfUijukkhaK3fM7ebC1VKkRMXBYzxWYuFN/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839747; c=relaxed/simple;
	bh=48kR4307+f0xawXLPR/6nuOZKLDb6FFxmzd1qOUv3VY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rngd+eSYMLK56+NVf4i9xXMzXOMIlfQvNIrr1ZKg2Lxapdc+oh5RHxP7vLjze7Z1zTaJ4Orei5r/hbQZSc+1mbtmGXWWkoMiYXdMovpSfXsY5+4pvhM23wu0vr1Ya5Df1eIE4T5H44q2VQkH3kaAPSiJeolFySiuC/2HKp7AVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SQeeA4li; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2909d714775611ef8b96093e013ec31c-20240920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6fNkpx8yInEDktvhahzTbJz3OXq0KQfG32J2/mZQM2U=;
	b=SQeeA4liJEFPxXrGjGQc87dicEfVsM0gjxEP+7afgrSFIhK6XfuIvnPn/6DSZmFoFE/LoON31ovP0xXjEdO/5ynycyYnuTmkpX72hVAaLwTKh//PqUXoqcfM+LIMDhr/obOcdt/069gF9n2qFhcjxCCuw8nFPBz/XycJVphKWlc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:107b5ac6-773a-4119-9fc0-c632b102dedb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:8a6bff17-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2909d714775611ef8b96093e013ec31c-20240920
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2084515162; Fri, 20 Sep 2024 21:42:21 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 20 Sep 2024 21:42:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 20 Sep 2024 21:42:19 +0800
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
Subject: [PATCH 1/5] arm64: dts: mediatek: mt8188: Fix wrong clock provider in MFG1 power domain
Date: Fri, 20 Sep 2024 21:41:07 +0800
Message-ID: <20240920134111.19744-2-pablo.sun@mediatek.com>
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
X-TM-AS-Result: No-10--3.516100-8.000000
X-TMASE-MatchedRID: +rnZyzwxyNIPRVepDWIjx/fLKp/JCt7hXW2lZgTs6mzfUZT83lbkEPBY
	Ro06eVj3qeTGwaWK7dyAMuqetGVetnyef22ep6XYxlblqLlYqXLetNGkEDQrI+B5LykgR4DXTWc
	vApzCWVLvAbW4qQmY4Gn7CIB1iw88YT7jkPs65/Si0djfdRK1jzeJDevMXv/zyuuRMrTTzW+Oh+
	wyNBrFXDJiNuKohDcKzKSG3JdyKAPqtV2AGMNPaiHWPYzouJUy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.516100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D98EB045355BC250620669345B381D34A8C31BFC89CAAB7290297AD83953F32E2000:8
X-MTK: N

The clock index "CLK_APMIXED_MFGPLL" belongs to the "apmixedsys" provider,
so fix the index.

In addition, add a "mfg1" label so following commits could set
domain-supply for MFG1 power domain.

Fixes: b8369604050b ("UPSTREAM: arm64: dts: mediatek: mt8188: Add support for SoC power domains")
Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
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



Return-Path: <linux-kernel+bounces-338228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE5985512
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADD31C23615
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A22315921D;
	Wed, 25 Sep 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pGOLeaAr"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E83153BEE;
	Wed, 25 Sep 2024 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251538; cv=none; b=kgCLrZ5O7xNZcQG8ZxF1glnlrwxhj308WOWAFv65/jridF++ijJJcCE1cHapTDVi+joa6MoTk8ov+lJArayuQG466oJtPpONpm6fLNbpNOb8kuo91hJp2H2FlfKktZY373aJGGA5/A5C8kh6QctGr+GyPY+VTYJopsXJ6FuXScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251538; c=relaxed/simple;
	bh=E4nNFFvMZkEQNPfl+mFeqOm0ZlAe6uYcyzIkUo4Szv0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ME7NCXxYSNFThluqsO39FAYBlHOaCC7holuUzi5kET99i6GmSdmfJ4g/Yqqbig6gnnfbrkYFguj6sKWRZJa5XwEfcPaiGSGsfFkVvF5wEGgtgFucdWvgHC8c+xswHjtXpPAMGpfz9lYMdisxX4hgNeXrAP3SGXx6epx3PDL+EvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pGOLeaAr; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ecd0f1d47b1411efb66947d174671e26-20240925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=37F1OHaShuh5YOl5yr/QWDxroLyh6khCJ1bm+0dqZBA=;
	b=pGOLeaArNmPatkzqpBux6QUDa46KJXDCaIoj6Ifb472qF4cMqMXTSDpiZ1R7+k3unBoYLgXAU6uNLWEjw/qeT7UGQM68F7MQawg14NVJhn4RsdlW/AwdH3Be45pUC1Kto1zQJ8nTgyde6Qe8tAJGbiXEG7WY4eD/5YsixIhrabA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:5380d1a3-b283-4135-8bee-b883cdf65e95,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6dc6a47,CLOUDID:c5953918-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: ecd0f1d47b1411efb66947d174671e26-20240925
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1813105391; Wed, 25 Sep 2024 16:05:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Sep 2024 16:05:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Sep 2024 16:05:19 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, "Sen
 Chu" <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>, Tommy Chen <tommyyl.chen@mediatek.com>
Subject: [PATCH v3] arm64: dts: mediatek: mt8195: Add power domain for dp_intf0
Date: Wed, 25 Sep 2024 16:05:15 +0800
Message-ID: <20240925080515.16377-1-macpaul.lin@mediatek.com>
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
X-TM-AS-Result: No-10--4.739500-8.000000
X-TMASE-MatchedRID: SlB0fb4khOUZ7Eu9TqPx8ED6z8N1m1ALQBnqdxuJ5SA4YKAM3oRt9g2f
	2+c5equm0OsI7hqGDS1Mn6L65ug232QexWkOikPfGVyS87Wb4lwNgFUqZt55AxjQD3m2MCf7tTq
	5wzqAYJijtBJIHld7XYgmzRSnu+RYr78SC5iivxwURSScn+QSXgGlEJORGTlJ+gtHj7OwNO0X9r
	pBZuBDbcFmQGkpeAqhUvhqE0gbH574d28m8PV9uo59ndbLaFhyBITe/0ZtGOk3wa44Od3MjvQPW
	lg2m8guqzTXpO4+RaKcjwfT+qpWaaMnTJRI0XInfXwUEm1ouDzLDYxFC1/7rn6GdNk4NWmA
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.739500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1342942027DFC659AEEAF3ABAF9BB25373D93F3CED4C7E0BD352FAF4A3F0B46E2000:8
X-MTK: N

During inspecting dtbs_check errors, we found the power domain
setting of DPI node "dp_intf0" is missing. Add power domain setting
to "MT8195_POWER_DOMAIN_VDOSYS0" for "dp_intf0"

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Tommy Chen <tommyyl.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
 1 file changed, 1 insertion(+)

Changes for v1:
 - This patch is related to adding mt8195-dp-intf to DT schema fix for
  - http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml 
  - patch: https://lore.kernel.org/all/20240924103156.13119-6-macpaul.lin@mediatek.com/

Changes for v2:
 - Fix typo for Tommy's email address. Others remains no change.

Changes for v3:
 - Added Suggested-by: and Reviewed-by: tags. Thanks!

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index ade685ed2190..6218bd7abb05 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3252,6 +3252,7 @@ dp_intf0: dp-intf@1c015000 {
 			compatible = "mediatek,mt8195-dp-intf";
 			reg = <0 0x1c015000 0 0x1000>;
 			interrupts = <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			clocks = <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
 				 <&vdosys0  CLK_VDO0_DP_INTF0>,
 				 <&apmixedsys CLK_APMIXED_TVDPLL1>;
-- 
2.45.2



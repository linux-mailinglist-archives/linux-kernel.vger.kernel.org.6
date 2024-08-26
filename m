Return-Path: <linux-kernel+bounces-300852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465D095E946
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AD92816B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BD4839F4;
	Mon, 26 Aug 2024 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TYtZVC2b"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E1A376E6;
	Mon, 26 Aug 2024 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655286; cv=none; b=O7MJI93ds633uxAbn4XiTPDQQU/sfwuAXrLvwa3j/1g7oBj7sRd2rIp+qfXeum29IrtCcX/NKvapcRa3n5bp0jiM+ehWMpEbtEj3RN0IcWfvah8sVqDSCCYThaEdr3h+cCGuzqSeqhyrzEutydarXrEE1etJd0X42MO5+SMsgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655286; c=relaxed/simple;
	bh=NijuPrNNY8R0rCq8srbalaQaVxCtGYdkjcA43ZCcJ+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=adnvTsG3SU1Rp+tGAHffHo97AapIuF0SJCCKE25An3UgCPBCWeqRFrcWSqFQFeUgEaNjCZMZarxu0AoYTZLOqx9QZGXxKm+ca+OL5cnnsIF1CsMf4bcFJ19USnizZCcc/5srCClqBWFjHEqQB5U8J06kHAy+ymov9/i24VIbWw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TYtZVC2b; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0cce08aa637811ef8593d301e5c8a9c0-20240826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GhEGP67YqgDTHdc3MR4JRlg6CcNYu9PfdwxgzbrschE=;
	b=TYtZVC2bXZYu92oVLzbLgtex4mnx4pwnc01egiAbQxQYo07bNDXl4Oda92mFvwpGEIBtxRB+417OKjI3duaNN3ztgNb4EF/BlQ6nKMNEG3GPcIk1SM29SBpO+KjesjnCJQpW0lZVwQ5ZvVucKlzBEjo3F6J2lcbxECo7NKf/ZF4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:682e81d5-5dcd-4add-901b-daf16065caa6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:70282dcf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0cce08aa637811ef8593d301e5c8a9c0-20240826
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 597071622; Mon, 26 Aug 2024 14:54:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Aug 2024 14:54:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Aug 2024 14:54:33 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>, "Flora
 Fu" <flora.fu@mediatek.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, "Sen
 Chu" <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>, "Chen-Yu
 Tsai" <wenst@chromium.org>
Subject: [PATCH] dt-bindings: mfd: mediatek,mt6357: Fixup reference to pwrap node
Date: Mon, 26 Aug 2024 14:54:15 +0800
Message-ID: <20240826065415.19641-1-macpaul.lin@mediatek.com>
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
X-TM-AS-Result: No-10--5.439900-8.000000
X-TMASE-MatchedRID: 4yX2sz1oRLp9lFIAHkDJoGwbuvhCHs3cIaLR+2xKRDJx1e3NhjX9AuYh
	IkEoymbrAVodxTEMxukn1aTwtcqsuC2W7Y+Npd9R2Ud/1nepkpO4vBuE2X0HlbVhTD1Udgq8sfS
	7f652nAkaHPg6l5sD1LC4kqiZ5QQdN/oZxYKnT+KJLZlzl4NipK+LpFmmk3oAzsQ8iRVyD453Bx
	krWYnPYuLzNWBegCW2wgn7iDBesS15zdAzex5xZvDdgbPba51UvzNMf/9vK7qOHIk1iqa/6b+AX
	Gx5R3JwZtl4/3Pi+WmUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.439900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AC04E90D57252F3BA31C6C398C459E4271DFE4A6508F56029BBE6ECF0243C2992000:8
X-MTK: N

The mt6357 is a subnode of pwrap node. Previously, the documentation
only included a note in the description of mt6357. This change adds the
appropriate $ref for pwrap to ensure clarity and correctness.

  $ref: /schemas/soc/mediatek/mediatek,pwrap.yaml

Additionally, the indentation for the pmic section has been adjusted
to match the corresponding structure.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../bindings/mfd/mediatek,mt6357.yaml         | 124 +++++++++---------
 1 file changed, 65 insertions(+), 59 deletions(-)

Changes for v1:
 - This patch has been made based on linux-next/master branch.

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
index b67fbe0..5f4f540 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
@@ -22,69 +22,75 @@ description: |
 
   It is interfaced to host controller using SPI interface by a proprietary hardware
   called PMIC wrapper or pwrap. This MFD is a child device of pwrap.
-  See the following for pwrap node definitions:
-  Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
 
 properties:
-  compatible:
-    const: mediatek,mt6357
-
-  interrupts:
-    maxItems: 1
-
-  interrupt-controller: true
-
-  "#interrupt-cells":
-    const: 2
-
-  mediatek,hp-pull-down:
-    description:
-      Earphone driver positive output stage short to
-      the audio reference ground.
-    type: boolean
-
-  mediatek,micbias0-microvolt:
-    description: Selects MIC Bias 0 output voltage.
-    enum: [1700000, 1800000, 1900000, 2000000,
-           2100000, 2500000, 2600000, 2700000]
-    default: 1700000
-
-  mediatek,micbias1-microvolt:
-    description: Selects MIC Bias 1 output voltage.
-    enum: [1700000, 1800000, 1900000, 2000000,
-           2100000, 2500000, 2600000, 2700000]
-    default: 1700000
-
-  regulators:
-    type: object
-    $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml
-    unevaluatedProperties: false
-    description:
-      List of MT6357 BUCKs and LDOs regulators.
-
-  rtc:
+  pwrap:
     type: object
-    $ref: /schemas/rtc/rtc.yaml#
-    unevaluatedProperties: false
-    description:
-      MT6357 Real Time Clock.
+    $ref: /schemas/soc/mediatek/mediatek,pwrap.yaml
     properties:
-      compatible:
-        const: mediatek,mt6357-rtc
-      start-year: true
-    required:
-      - compatible
-
-  keys:
-    type: object
-    $ref: /schemas/input/mediatek,pmic-keys.yaml
-    unevaluatedProperties: false
-    description:
-      MT6357 power and home keys.
-
-required:
-  - compatible
-  - regulators
+      pmic:
+        type: object
+        additionalProperties: false
+        properties:
+          compatible:
+            const: mediatek,mt6357
+
+          interrupts:
+            maxItems: 1
+
+          interrupt-controller: true
+
+          "#interrupt-cells":
+            const: 2
+
+          mediatek,hp-pull-down:
+            description:
+              Earphone driver positive output stage short to
+              the audio reference ground.
+            type: boolean
+
+          mediatek,micbias0-microvolt:
+            description: Selects MIC Bias 0 output voltage.
+            enum: [1700000, 1800000, 1900000, 2000000,
+                   2100000, 2500000, 2600000, 2700000]
+            default: 1700000
+
+          mediatek,micbias1-microvolt:
+            description: Selects MIC Bias 1 output voltage.
+            enum: [1700000, 1800000, 1900000, 2000000,
+                   2100000, 2500000, 2600000, 2700000]
+            default: 1700000
+
+          regulators:
+            type: object
+            $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml
+            unevaluatedProperties: false
+            description:
+              List of MT6357 BUCKs and LDOs regulators.
+
+          rtc:
+            type: object
+            $ref: /schemas/rtc/rtc.yaml#
+            unevaluatedProperties: false
+            description:
+              MT6357 Real Time Clock.
+            properties:
+              compatible:
+                const: mediatek,mt6357-rtc
+              start-year: true
+            required:
+              - compatible
+
+          keys:
+            type: object
+            $ref: /schemas/input/mediatek,pmic-keys.yaml
+            unevaluatedProperties: false
+            description:
+              MT6357 power and home keys.
+
+        required:
+          - compatible
+          - regulators
 
 additionalProperties: false
 
-- 
2.45.2



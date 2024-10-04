Return-Path: <linux-kernel+bounces-349857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A6798FC49
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060211C220C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFDE208D1;
	Fri,  4 Oct 2024 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PHmdj+Vp"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337EDDA1;
	Fri,  4 Oct 2024 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728008682; cv=none; b=Ok+C0cC674roxhDoAO3P/ct+5WM0Q0xHCpqjc+68GYKBAf5DVXBbp5S95G4TlnGfUcGrjI4ddXCElYxkfz/zdDJjJnsSLx6g4aZM1jOlqpfRj/zlBHQSnC/RhzxSSHgBoIRig92WgwIjWEKCZsUgGhZQD1OX9MpwQfr3L6Qeh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728008682; c=relaxed/simple;
	bh=BW65+7mAxbbksZMjyHZtyEB+oDA+79HwcdaDbGz/hEY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cQhrEftWBnYQIimI6LbhPOgLaMLm4mDwZGCvaDMn1P0Q87Q8u+N9XFEHhwjjSEfEKwJei6dstmTOYxXyHoKFeW2R7OiUk0o+lTwVwleRQFHFW/ECf0TsDoer3EMVQxo+wt9CcgxPvKSaDdxzXI3NT/J7zbEwZQa9xWoFpzEn3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PHmdj+Vp; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cbca511281f711ef8b96093e013ec31c-20241004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Kjly8y7UsTFJRLhG7/ML1Rzsva3stHv/nqE2+gId9i0=;
	b=PHmdj+VpDl2JpLLFmDqlEyZnu5NOwJBHjvqErE1rOKAdt9SRhLD6H15ihBSqylIkGQLVgYkjRcBP9kGRC2TZXwyT1JeGQ/lwMjQwMLtIRDcnvYgY6A+udfbesN/1BS3zi3IGNRXPLiNcAweNsd1iZS98D7eBch1wyy+kLydrSII=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:1d3fec9a-5c26-4386-af91-88a132c3c040,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c850b764-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cbca511281f711ef8b96093e013ec31c-20241004
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <moudy.ho@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1183843751; Fri, 04 Oct 2024 10:24:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Oct 2024 10:24:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 4 Oct 2024 10:24:31 +0800
From: Moudy Ho <moudy.ho@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "jason-jh . lin"
	<jason-jh.lin@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v3] dt-bindings: display: mediatek: split: add subschema property constraints
Date: Fri, 4 Oct 2024 10:24:30 +0800
Message-ID: <20241004022430.19689-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.848600-8.000000
X-TMASE-MatchedRID: Ru+54+IMWaQ72d2F4DOSZIzb2GR6Ttd3MZm0+sEE9mtb6PBUqmq+Utdh
	dhqLxa0jj6kCfX0Edc5fvtuIsaf1Zbf0EuHoGRzu/IBH0OAL+EeusS9CiBzL8VSkag5D7Fg8O0i
	2vQl58jgZoBsQWiqLArpjAjMHHtZlHxPMjOKY7A9qHXONfTwSQsRB0bsfrpPInxMyeYT53RnDa+
	4JklccgJy6v5kFJZhEinJ4I5Ggj8rhkRPh6jPIcsP7/0dW/TeQ+mRKzDVuOcuVSFhjFH946aGuH
	qXWE6OVz8eQmvI53il5lSmbrC6fdtr/To2FgNrjDLMIOOVTHz2nbLeYgH6K31Zca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.848600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9DECDB592F3AC4DFB91808774BE073A28B4AF3D9B721064985D5E56E3CF704D42000:8
X-MTK: N

The display node in mt8195.dtsi was triggering a CHECK_DTBS error due
to an excessively long 'clocks' property:
  display@14f06000: clocks: [[31, 14], [31, 43], [31, 44]] is too long

To resolve this issue, the constraints for 'clocks' and
other properties within the subschemas will be reinforced.

Fixes: 739058a9c5c3 ("dt-bindings: display: mediatek: split: add compatible for MT8195")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

--
This is based on [v2] dt-bindings: display: mediatek: split: add clocks count constraint for MT8195

Changes since v2:
  - Revise the commit message.
  - Enhance the descriptions of 'clocks'.
  - Strengthen the conditions within the subschema.

Changes since v1:
  - Adding functional descriptions and quantity restrictions.
---
 .../display/mediatek/mediatek,split.yaml      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
index e4affc854f3d..0ffcd9d2b718 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
@@ -57,6 +57,9 @@ properties:
   clocks:
     items:
       - description: SPLIT Clock
+      - description: Used for interfacing with the HDMI RX signal source.
+      - description: Paired with receiving HDMI RX metadata.
+    minItems: 1
 
 required:
   - compatible
@@ -72,9 +75,30 @@ allOf:
             const: mediatek,mt8195-mdp3-split
 
     then:
+      properties:
+        clocks:
+          maxItems: 3
+
+        power-domains:
+          maxItems: 1
+
       required:
         - mediatek,gce-client-reg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8173-mdp3-split
+
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        power-domains:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.34.1



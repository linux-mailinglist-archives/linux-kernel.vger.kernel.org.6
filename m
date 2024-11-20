Return-Path: <linux-kernel+bounces-415262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1499D33AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475271F24023
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C1915B971;
	Wed, 20 Nov 2024 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LuwcqE0y"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165A158858;
	Wed, 20 Nov 2024 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084634; cv=none; b=WSk7CYiVAt0gPyNyr4e4Gi7Jzg/LAv0gsB0YiofIDhhLLqd4i7Qsupenm/TRS5vLb/+SZdE5YqEKRRZRWvADH0gSuVb+RC/VznnORPjpRIalk0VnxobR82yyIS8+8Wiq5saPSNkrpVfh3y59ldRHf0DrI7I37DuXt6LIO2cdckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084634; c=relaxed/simple;
	bh=O4a1k3XLdKuaEvqaG0zX3MwJPfNdYDKzWOzW4YrZq48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJ4FBgUmhDhXlZT1J7RqPuK9BGhJCyR7c6zoqCzCwxl5/4CZ3ZYS8jLuJ0fAgIfAo+NzB1dnIfJ+olvbBP5lfWiGK1O8IxfuJu3l67uVXkQBnnfzZy0obntWMGW/vP3btNLrU0RJJnRr37BgNzfPxs/Tg4ZVmGEWjoibctrAXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LuwcqE0y; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dc2db760a70911ef99858b75a2457dd9-20241120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+gMs/diYXN4X9z9nI+JN/RNmvVcQKJVNx8MA0OWmObQ=;
	b=LuwcqE0yZnCObFpVMBJA8S++6g0pofeAwsubYTTtM9isJwZClk+w0hDPm8Lx7IONFnDayQsMhU3o+ji5ApHE0uilklMdtz6q51yUROElZ+MT4IQDPCphEIVRI2X07dNkDsT9eFXoHAuOKj7/tZyfcM+WoQAxaWVNOwKGe5Vx7wY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:aed3b39e-17db-48be-abab-a9b766bbceb2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:caf480a0-f395-4dfc-8188-ce2682df7fd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dc2db760a70911ef99858b75a2457dd9-20241120
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 125359592; Wed, 20 Nov 2024 14:37:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Nov 2024 14:37:04 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Nov 2024 14:37:04 +0800
From: Friday Yang <friday.yang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Friday Yang
	<friday.yang@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: memory: mediatek: Add SMI reset and clamp related property
Date: Wed, 20 Nov 2024 14:36:38 +0800
Message-ID: <20241120063701.8194-2-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241120063701.8194-1-friday.yang@mediatek.com>
References: <20241120063701.8194-1-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On the MediaTek platform, some SMI LARBs are directly linked to SMI
Common. While some SMI LARBs are linked to SMI Sub Common, then SMI
Sub Common is linked to SMI Common. The hardware block diagram could
be described as below.
Add 'resets' and 'reset-names' for SMI LARBs to support SMI reset
and clamp operation. The SMI reset driver could get the reset signal
through the two properties.

             SMI-Common(Smart Multimedia Interface Common)
                          |
         +----------------+------------------+
         |                |                  |
         |                |                  |
         |                |                  |
         |                |                  |
         |                |                  |
       larb0       SMI-Sub-Common0     SMI-Sub-Common1
                   |      |     |      |             |
                  larb1  larb2 larb3  larb7       larb9

Signed-off-by: Friday Yang <friday.yang@mediatek.com>
---

Although this can pass the dtbs_check, maybe there is a better way
to describe the requirements for 'resets' and 'reset-names' in bindings.
But I don't find a better way to describe it that only SMI larbs located
in camera and image subsys requires the 'resets' and 'reset-names'.
I would appreciate it if you could give some suggestions.

.../mediatek,smi-common.yaml                  |  2 +
 .../memory-controllers/mediatek,smi-larb.yaml | 53 +++++++++++++++----
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 2f36ac23604c..4392d349878c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -39,6 +39,7 @@ properties:
           - mediatek,mt8186-smi-common
           - mediatek,mt8188-smi-common-vdo
           - mediatek,mt8188-smi-common-vpp
+          - mediatek,mt8188-smi-sub-common
           - mediatek,mt8192-smi-common
           - mediatek,mt8195-smi-common-vdo
           - mediatek,mt8195-smi-common-vpp
@@ -107,6 +108,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - mediatek,mt8188-smi-sub-common
               - mediatek,mt8195-smi-sub-common
     then:
       required:
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 2381660b324c..302c0f93b49d 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -69,6 +69,18 @@ properties:
     description: the hardware id of this larb. It's only required when this
       hardware id is not consecutive from its M4U point of view.

+  resets:
+    maxItems: 1
+    description: This contains a phandle to the reset controller node and an index
+      to a reset signal. SMI larbs need to get the reset controller by the node.
+      SMI could get the reset signal by the index number defined in the header
+      include/dt-bindings/reset/mt8188-resets.h.
+
+  reset-names:
+    const: larb
+    description: The name of reset controller. SMI driver need to obtain the
+      reset controller based on this.
+
 required:
   - compatible
   - reg
@@ -125,19 +137,38 @@ allOf:
       required:
         - mediatek,larb-id

+  - if:  # only for camera and image subsys
+      properties:
+        mediatek,smi:
+            contains:
+              enum:
+                - smi_sub_common_img0_4x1
+                - smi_sub_common_img1_4x1
+                - smi_sub_common_cam_5x1
+                - smi_sub_common_cam_8x1
+
+    then:
+      required:
+        - resets
+        - reset-names
+
 additionalProperties: false

 examples:
   - |+
-    #include <dt-bindings/clock/mt8173-clk.h>
-    #include <dt-bindings/power/mt8173-power.h>
-
-    larb1: larb@16010000 {
-      compatible = "mediatek,mt8173-smi-larb";
-      reg = <0x16010000 0x1000>;
-      mediatek,smi = <&smi_common>;
-      power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
-      clocks = <&vdecsys CLK_VDEC_CKEN>,
-               <&vdecsys CLK_VDEC_LARB_CKEN>;
-      clock-names = "apb", "smi";
+    #include <dt-bindings/clock/mediatek,mt8188-clk.h>
+    #include <dt-bindings/power/mediatek,mt8188-power.h>
+    #include <dt-bindings/reset/mt8188-resets.h>
+
+    larb10: smi@15120000 {
+        compatible = "mediatek,mt8188-smi-larb";
+        reg = <0 0x15120000 0 0x1000>;
+        clocks = <&imgsys CLK_IMGSYS_MAIN_DIP0>,
+                 <&imgsys1_dip_top CLK_IMGSYS1_DIP_TOP_LARB10>;
+        clock-names = "apb", "smi";
+        power-domains = <&spm MT8188_POWER_DOMAIN_DIP>;
+        resets = <&imgsys1_dip_nr_rst MT8188_SMI_RST_LARB10>;
+        reset-names = "larb";
+        mediatek,larb-id = <10>;
+        mediatek,smi = <&smi_sub_common_img0_4x1>;
     };
--
2.46.0



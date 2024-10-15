Return-Path: <linux-kernel+bounces-365570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C918699E47D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E61A1C23365
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7021E765B;
	Tue, 15 Oct 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dIZg9dNZ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6008B16A92D;
	Tue, 15 Oct 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989355; cv=none; b=STjyJ9OQSZah0BJcJaTeoncG21PVactACcHQ5pvEnhDonCpy6AU6NVRgd0h/1tRf/ah6+SXgVDVdkbinoXv/sudVUNahLunrKmVH5vmdUyjavw/4sGRUH8H8mRIObQ4ZyfYWeghPQJiQux5HTJmsZwCUyDPFaF7X2aFyLiDnG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989355; c=relaxed/simple;
	bh=gSowaey9fHJcIYX6mmkBzqtjye8WHjyEg/klSDzQxE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m2FteRyPPEQF5aEYcZPvd0A0lT7IHWoX5pAfndX7NlQo5hTq3FpI+5rahZVn6znh8qmh/StsnRewNL7lSh5ZaCqB3rtrkL2sWGCzzuxvhaz1RTNNQuQ8oPOK7r97XPGUSYZCK8zVCDZYUarXUIrwJQ6NQp9TOdXOVIdSBFdEvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dIZg9dNZ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fca4a91c8ae011ef8b96093e013ec31c-20241015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=a8qCVhVIWFAmnRKX3OXq2rlmCfjQb9p/E9Q29h/MGfI=;
	b=dIZg9dNZ78CGEz1H5ECI36zLGdngdlbEClKELM1jSO3OqVVt2+Sw61arhAY6Kl88wQeVGbRUPm10bhca+TME1A5VUIvEB/IuXetLJYy/9DQOposl6Unkjt9cMg/WZTjPDxTudr9P/4n7VCa0zIgkAU9MQOPQomUjNat9ClSzQRM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:424b073b-aa29-43db-9b83-dac143259757,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:d85a4765-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fca4a91c8ae011ef8b96093e013ec31c-20241015
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 62356359; Tue, 15 Oct 2024 18:33:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 15 Oct 2024 18:33:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 15 Oct 2024 18:33:56 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Matthias Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, ChiYuan Huang
	<cy_huang@richtek.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chris-qj chen
	<chris-qj.chen@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: usb: mediatek,mt6360-tcpc: add ports properties
Date: Tue, 15 Oct 2024 18:33:36 +0800
Message-ID: <20241015103337.20479-1-macpaul.lin@mediatek.com>
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
X-TM-AS-Result: No-10--5.840500-8.000000
X-TMASE-MatchedRID: 6pbNFWS8cDsogNuHjUlKTcV1CHtMfzqgJNtuyL6mpIXfUZT83lbkEDQz
	47GqDWjpiYeJX0ZLCFCwji3+hURDy7YCBNsYIDyvjtK7dC6UBnnlOkM7VYqzaZsoi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNZGN3uF5aYuhkFr/Uz3mflTcBaWlN+Fm4iCeCicusNBiC3m0DNajQcvAvp
	LE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.840500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	636958D15D9342168208B73159A0A722B66D6B91044804FA29D1FA68BA23E3B02000:8
X-MTK: N

Add 'ports' and sub node 'port' properties to specify connectors on the
High-Speed/Super-Speed data bus, or Sideband Use (SBU) AUX lines
endpoints of the USB controller.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../bindings/usb/mediatek,mt6360-tcpc.yaml    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
index 053264e60583..5b6ea0d734ea 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
@@ -32,6 +32,27 @@ properties:
     description:
       Properties for usb c connector.
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description:
+      Any connector to the data bus of this controller should be specified.
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "port@[0-2]$":
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          It could be one of the following interface types. High-Speed
+          (HS) data bus endpoint to the Type-C connector, SuperSpeed (SS)
+          data bus endpoint to the Type-C connector, or Sideband Use (SBU)
+          AUX lines endpoint to the Type-C connector for the purpose of
+          handling altmode muxing and orientation switching.
+
 additionalProperties: false
 
 required:
-- 
2.45.2



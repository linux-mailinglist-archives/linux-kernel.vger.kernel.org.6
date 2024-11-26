Return-Path: <linux-kernel+bounces-421821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2069E9D9090
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1DC28CC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38135028C;
	Tue, 26 Nov 2024 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T6iiUTvq"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982BF179A3;
	Tue, 26 Nov 2024 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589948; cv=none; b=f6o1/josXr2gLImvGVbwJjufOEBKSbjJTFHlVjkUqZc3z6U7nV52pUnkaeVCpMC7fgDv+I4gzE4Sa0WvD7CJyj7g65c+LdF9AqoUawk0bkhcDg58qkx4r5GidngO9eW0kPTQdv6QZjvsn1w3aul1j4QSXNUnHKyjV0ZU+H4dM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589948; c=relaxed/simple;
	bh=CAYFTFjK6HJvufX54oC/SNbmhfgr992LRRp9GE1vCrc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=azCRfGPl+3ROUh4CAYyB/52nZnXhWlv/LMJV+W5Z2f/wj0GyM4ZiLOOdIO3wqyN9VEJqS/4ZADA0Ejp9mIZqwHHLNSow6WvfAdBvhdD3awucxFte8PEfowBJoUbnHdeWzOZpsqoHxGGJ8KDJ3w02NtNpGtsgeWDD24uN51ZjJpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=T6iiUTvq; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 63f5180eaba211ef99858b75a2457dd9-20241126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dsX2OtdSOdKOeKbYRD06E8b/FeaBxyzTsQ+biVAxEL8=;
	b=T6iiUTvqAu9aNPKJ8hAHUJYEIWgc7lfhyFvgL0f7S8IYCV1JByJQIWD0hW26S4cgQNOOAvoKl8/clzaume6Cay4ovwbiCOF+bXifN+0jBtXerrWYlFlfxROtGOWF+EBkWsF2vJp0jzmwKhAdwbSnSP28Qo0Yx2WFhQSO3QxHMGQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:63cd028d-8dfb-45d4-aa48-7ea7fd3e9836,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:bbef63b9-596a-4e31-81f2-cae532fa1b81,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 63f5180eaba211ef99858b75a2457dd9-20241126
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1970975331; Tue, 26 Nov 2024 10:59:02 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Nov 2024 10:59:01 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Nov 2024 10:59:00 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: phy: mediatek,xsphy: add property to set disconnect threshold
Date: Tue, 26 Nov 2024 10:58:58 +0800
Message-ID: <20241126025859.29923-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add a property to tune usb2 phy's disconnect threshold.
And add a compatible for mt8196.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
index a9e3139fd421..2e012d5e1da1 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
@@ -49,6 +49,7 @@ properties:
       - enum:
           - mediatek,mt3611-xsphy
           - mediatek,mt3612-xsphy
+          - mediatek,mt8196-xsphy
       - const: mediatek,xsphy
 
   reg:
@@ -129,6 +130,13 @@ patternProperties:
         minimum: 1
         maximum: 7
 
+      mediatek,discth:
+        description:
+          The selection of disconnect threshold (U2 phy)
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 1
+        maximum: 15
+
       mediatek,efuse-intr:
         description:
           The selection of Internal Resistor (U2/U3 phy)
-- 
2.46.0



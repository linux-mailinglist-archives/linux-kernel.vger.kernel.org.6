Return-Path: <linux-kernel+bounces-360594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C995999D07
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F8E280BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11FD209F30;
	Fri, 11 Oct 2024 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GoGcYPsV"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A6209694;
	Fri, 11 Oct 2024 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629304; cv=none; b=QpZUVWSiEdcGyfCcOVKoK473rpDAf9IYlbVZ1lUWeDzzMW0Gtvc5xgCBRHxSYn7zt8dF5sCY572IbUuvZdHlujkLfvWKemnSsIexmod8Gu08aSA2270ZrE9QOFtEW8q/Pvj5HA5xjSRT9ixhn1BGGTvjWWC7pNtg6nPrPkOpPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629304; c=relaxed/simple;
	bh=w0mpnanmMdVQFr7/jyzJWYjwj8gVo9DlPWDXPC3hOGY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gyFBP/8hO6xdpOIXlSDKWixTJf1EiV1FWW72EouF2SoTqrGD5u8/aX42G99kNlReJ+aFxQNsR3XvecUPkPgN/Jnes/mtYRHLBUIUQ767qiKyXbRUtUQjBAF/XyuLKxwIeB08dxsEcK75SRfX9w/I1VTTONS8mNr2bSgisk8jvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GoGcYPsV; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cb1274ca879c11ef8b96093e013ec31c-20241011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=y2T9fRA9uvlVR02QkoFnRdEwwHlGLql4m/SX4vgEwHo=;
	b=GoGcYPsVH18eV2yFySiMsYYm1WP4DMT7fnZI9dlVcyPcHiNAti7DFcDS9GlGO/p89+X3GftJVU1kGkqZ0GIjHQ50h9VezV6CrdDGMrXcGTAUguyD+QFkXxCFxgiu0DFFUZ7Q8bGg35JTaVY7oo0cNpAE3JpWhze/rZrwHsemEig=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2db058d1-0bb6-46af-8907-036b5c2f81df,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:d4341741-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cb1274ca879c11ef8b96093e013ec31c-20241011
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 220178317; Fri, 11 Oct 2024 14:48:16 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 11 Oct 2024 14:48:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 11 Oct 2024 14:48:13 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2] dt-bindings: phy: mediatek: tphy: add a property for power-domains
Date: Fri, 11 Oct 2024 14:48:10 +0800
Message-ID: <20241011064810.5103-1-macpaul.lin@mediatek.com>
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
X-TM-AS-Result: No-10--2.165100-8.000000
X-TMASE-MatchedRID: k8Cd32tj8sGMNoAzq9nHoWNW0DAjL5p++OI6XsK3BWHfUZT83lbkEJVD
	ZsT0rYWCqP2RhwqsDVhYSGAnlsUp3lAXAjgfNI2iRy+94mWbR+blOkM7VYqzaZi7/tnxUUyGo8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqt7aENEMomdGuGxZsjVPBjfObxZIv/aSQArgevuQgg4NYHJD
	IxduTwSZmxuzUAi+Dfup5+b9g7ZTRiF54b8Md0Br5sQoYg/dmD4sOrsb4iT/K/bbEolHIgZUOc7
	GjOamnWv5a9cmIodEspRnLV2kwrLg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.165100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4AD9FFC112EA5D5D7D7DB547735B4F1CC3D11219A3110772C6367C57CD5144FB2000:8
X-MTK: N

MediaTek TPHY should be existed in a power-domains.
So we add property 'power-domains' and set 'maxItems: 1' in the
DT Schema.

A reminder is also added to the description of 'power-domains'
property.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/phy/mediatek,tphy.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

Changes for v2:
 - Add a reminder in description of 'power-domains' property.
 - Fix commit message from v1.

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index 423b7c4e62f2..6be3aa4557e5 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -125,6 +125,16 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 28
 
+  power-domains:
+    description:
+      The TPHY of MediaTek should exist within a power domain. The
+      developer should be aware that the hardware design of MediaTek TPHY
+      does not require the addition of MTCMOS. If the power to the TPHY
+      is turned off, it will impact other functions. From the current
+      perspective of USB hardware design, even if MTCMOS is added to the
+      TPHY, it should remain always on.
+    maxItems: 1
+
 # Required child node:
 patternProperties:
   "^(usb|pcie|sata)-phy@[0-9a-f]+$":
-- 
2.45.2



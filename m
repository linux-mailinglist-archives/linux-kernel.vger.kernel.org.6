Return-Path: <linux-kernel+bounces-570990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41BEA6B79F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251093B793F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832E9221F1A;
	Fri, 21 Mar 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DjpdAuva"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65421D3D4;
	Fri, 21 Mar 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549707; cv=none; b=tZmFLKRLiHdRCBL0jFivM453ngHorjNhfMrEARvFMDz2SNqyrvpImAJ/RC3onZXeW020Bzv0FBShDcp58CYJ/Jc3upjt8TklZvaAy9mv0dXOFCWp1L3E2bH2rk3scvVogh1hn4m7MwC/DSBp/5LZ9Lm9nhwehbSim1zWunaERM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549707; c=relaxed/simple;
	bh=xOTVBmsYBPa6tvlsp9HoWaV4r0m6xmMLlDQw+cm4Zzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyLZ1c3E3uNzBuwP1bBPzb5BG/RqOoN6ZHUMrllWsIrEN0cH06o+So5C9E/zMO2hUfZ1IQ2644xVMIa5JhC5djqg5j5Qubs+vqtReeNbBycQ8PygZzv356udU15l5L3LAR6HZXqh0KpOx4pDv8sUYdn7w9CUhE9ijzwkF7BB6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DjpdAuva; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c18ec0d8063711f08eb9c36241bbb6fb-20250321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=j3XZVVX4nT3Yo0YKOnG/wibSc0FBMXKfOMnK+MEXxsk=;
	b=DjpdAuvaGb/RTSbNifjPUm2gLUeKSM6WlPCVHF5oKC4k+Fq1VQnhwI4cVtg/Po50zRenINP18Ufk6aW8P9LeET328jKKCY6G84z8VKuEIcyrZ03U0ue+OZ8RO2EMKtINUnaQD9r/0/WAevYqid02dTZtswvCRL4ZpnggPQTiXH4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:0b4c36a7-d81f-4e9e-9966-9511c612e558,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:5a79a1c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c18ec0d8063711f08eb9c36241bbb6fb-20250321
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <paul-pl.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 818943364; Fri, 21 Mar 2025 17:34:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 21 Mar 2025 17:34:57 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 21 Mar 2025 17:34:57 +0800
From: paul-pl.chen <paul-pl.chen@mediatek.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<chunkuang.hu@kernel.org>, <angelogioacchino.delregno@collabora.com>
CC: <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
	<jason-jh.lin@mediatek.com>, <nancy.lin@mediatek.com>,
	<singo.chang@mediatek.com>, <xiandong.wang@mediatek.com>,
	<sirius.wang@mediatek.com>, <paul-pl.chen@mediatek.com>,
	<sunny.shen@mediatek.com>, <fshao@chromium.org>, <treapking@chromium.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 01/15] dt-bindings: arm: mediatek: mmsys: add compatible for MT8196
Date: Fri, 21 Mar 2025 17:33:30 +0800
Message-ID: <20250321093435.94835-2-paul-pl.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
References: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Paul-pl Chen <paul-pl.chen@mediatek.com>

In previous SoCs, a single HW pipeline was an independent mmsys,
which included the OVL module, PQ module, and display interface
module.

In the 8196, to increase the flexibility of pipeline connection
and control, the OVL module on a single HW pipeline was separated
into two mmsys, namely ovlsys0 and ovlsys1. The PQ module was also
separated into a dispsys0, and the display interface module was
separated into a dispsys1. Additionally, display power-related
settings are controlled through vdiso-ao.

For example:
The primary path and external path of the display both use
ovlsys0 -> dispsys0 -> dispsys1, forming a pipeline.

The third path of the display uses ovlsys1 -> dispsys0 -> dispsys1,
forming another pipeline.

Therefore, the 8196 needs to add 5 compatible string to support
mmsys for MT8196.

Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index 3f4262e93c78..5f244a8f6a47 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -39,6 +39,11 @@ properties:
               - mediatek,mt8195-vdosys1
               - mediatek,mt8195-vppsys0
               - mediatek,mt8195-vppsys1
+              - mediatek,mt8196-dispsys0
+              - mediatek,mt8196-dispsys1
+              - mediatek,mt8196-ovlsys0
+              - mediatek,mt8196-ovlsys1
+              - mediatek,mt8196-vdisp-ao
               - mediatek,mt8365-mmsys
           - const: syscon
 
-- 
2.45.2



Return-Path: <linux-kernel+bounces-189754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B6A8CF48D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 16:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9EB1C2093C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 14:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89F17C79;
	Sun, 26 May 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YVKAw7ba"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9DF1755A;
	Sun, 26 May 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716734693; cv=none; b=pBl13iVWiKr6AZuQKAGK8WYec8VrskK6hF/0aYqp8cWYPG8jA03oSsUIiW6G2pwsDI8RceL1Eyy0liUixYSOePU9NhIfPOiCoBYZbA+s4j/TmZv+XY5ztHYWPaavxbGg7GQE078jwdGt8pNpDHM0B2FSPX0lIYZdclCZlkO8wRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716734693; c=relaxed/simple;
	bh=1IQnkFeo5hwJ8HyehC09JEYs92fCaB3Xdgd27Gp26KY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvRD6P48utZulm/WsaFbpEVLcfZERZX2luV+3QE2CIqYg6NLifniC7spWrVRXMeE/CMMrwOIrAR9cY6P3I0phfZ+9Tj8fSReJ7YwZgIE/hGmCJztemYIlVuKtqswyUW/h1ASUFXo4LCChtAtNXXD8lKt6ZdeIP1hJObZoDT6co4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YVKAw7ba; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7f5202a21b6e11efbfff99f2466cf0b4-20240526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LN8PN6WdAK9w2x83kX6kZCxmAZMlqcey6szu6viJQYg=;
	b=YVKAw7baL7vJ3VcFQgQeUqNQXAhkHAkveOoSgyHXIv4fIXycXUuxC0MglsVjVwa9Nzz+tgCryXi/Q1cjvlOAZ7sRi5wbUJiQNvSFZBq2fp/S4JX5dhQlHhKbs88zP6ztctU7Q2g188uowDc8nAdwjur7UUNPt66cnQfzDPxzchk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:9262af6f-7536-4d31-83f1-47d33fa33d74,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:c78f3a93-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7f5202a21b6e11efbfff99f2466cf0b4-20240526
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1803323063; Sun, 26 May 2024 22:44:46 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 26 May 2024 22:44:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 26 May 2024 22:44:44 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Conor Dooley <conor+dt@kernel.org>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <dri-devel@lists.freedesktop.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH RESEND,v6 1/8] dt-bindings: gce: mt8195: Add CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Date: Sun, 26 May 2024 22:44:36 +0800
Message-ID: <20240526144443.14345-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.865800-8.000000
X-TMASE-MatchedRID: MfleD8Y7obJ/Kgj3tMS/EPyAR9DgC/hHDqdsP48ZEpT1gF7PCEF9bjFa
	TRf5dTetd1cwAoVwUpIm83mw8YvWBKF2E6v/FJwhB7TqRAYVohYrHkgIan9a0fzaSz3Z/4aaP6C
	wLhrNSrC58Ekbt0Wd7Np5CTaON5EqmWDI8lRCplAD2WXLXdz+AZl/lu28zzkBDnmf9WY7ZBKjxY
	yRBa/qJcFwgTvxipFajoczmuoPCq0OgglS6qcJsUexYicplFw7ccARSyKgLYRMwC29MKGo+unRf
	lVQtoI8QwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.865800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C3B4DB69AA1B3C67773B7A127EFD4E0DF27F5495CEAD2173FCF5137A26A0BFEE2000:8
X-MTK: N

There are 2 kind of GCE event signal:
- The SW token means: a GCE event signal triggered by SW drivers.
e.g. SW driver append a GCE command to set a GCE event after a specific
GCE command. Or SW driver use CPU to write a event id to GCE register to
trigger the GCE event corresponding to that event id.

- The HW event means: a GCE event signal triggered by HW engines.
e.g. When HW OVL fetches all the data in frame buffer, HW OVL will send
a frame done irq and also send a frame done GCE event via HW bus directly.

CMDQ_SYNC_TOKEN_SECURE_THR_EOF is a SW token event that is set in the
end of each cmdq secure pkt. It is used as a secure irq to notify
CMDQ driver in the normal world that GCE secure thread has completed
a secure cmd buffer in thee secure world.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 include/dt-bindings/gce/mt8195-gce.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/gce/mt8195-gce.h b/include/dt-bindings/gce/mt8195-gce.h
index dcfb302b8a5b..b6b3db82c381 100644
--- a/include/dt-bindings/gce/mt8195-gce.h
+++ b/include/dt-bindings/gce/mt8195-gce.h
@@ -800,6 +800,12 @@
 #define CMDQ_EVENT_WPE_VPP1_WPE_GCE_FRAME_DONE	969
 #define CMDQ_EVENT_WPE_VPP1_WPE_DONE_SYNC_OUT	970
 
+/*
+ * Notify normal CMDQ there are some secure task done,
+ * this token sync with secure world.
+ */
+#define CMDQ_SYNC_TOKEN_SECURE_THR_EOF			980
+
 #define CMDQ_EVENT_DP_TX_VBLANK_FALLING	994
 #define CMDQ_EVENT_DP_TX_VSC_FINISH	995
 
-- 
2.18.0



Return-Path: <linux-kernel+bounces-342560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDFE98904E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0BB1C213A9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E51166F31;
	Sat, 28 Sep 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rC5Nwr3J"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6849B15AD90
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540164; cv=none; b=m0J3ICmpp9F87L7tvlOFSruQ+bW+iDqbfc6FmMbhjkZVBjWFEqLge8WeRT7ldvi/Njd2/eUKWBIuk2e2If6iWm2YUnaRuedqtJC00ALPSENkShUWjrjm9EkMvm1s/NqwvCeLj49XiyLQ9iCgX9FTi13xXUzSZSwHN6uXEzPPReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540164; c=relaxed/simple;
	bh=cicAHvJ+tEUlj83SrGBK3zIkyzNEbngoaSMi7OYhI/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tyFeZ7vuSbwh5ytbpEcPTnL42/1XXGenSJ3Jr0wjdfDMtxuitG0FZW2b7YqV4sC9e2G5Bs54y/3H2G/LEwPANWEyldP7z/UNkG+eoT7DB35LoCy6mU7olIUJ+Vt/yuzOflpFNGIyVgGSEtdFlwjp0jaggPsDJp7+DjUU4G97CtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rC5Nwr3J; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ecd6131a7db411efb66947d174671e26-20240929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=uOl84F+rlha9l0mpAstimfoZW1JysW/A365N8QrMQ/c=;
	b=rC5Nwr3J9AIfC9H+kKqmGnvTl8rKcXeqgNqtUOuIo1uWivzy1IEzY1OkxAvV4QsGkim/5YVli4rmPxN9GmtI//FYe/usBRe+KiDk1KjKDjAubyJbN1RrHh5n+GKz9BD2qIZHuydLoto7n25pzNQAvh98byEHCGgrRP7p99a4O18=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:50ff4e30-d254-4939-ab90-e9684ec59c35,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:02db6518-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ecd6131a7db411efb66947d174671e26-20240929
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1905411193; Sun, 29 Sep 2024 00:15:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 29 Sep 2024 00:15:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 29 Sep 2024 00:15:47 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Shawn Sung <shawn.sung@mediatek.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH v8 0/3] Fix degradation problem of alpha blending series
Date: Sun, 29 Sep 2024 00:15:43 +0800
Message-ID: <20240928161546.9285-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

Some SoCs not support pre-multiplied pixel formats and extending
configuration of OVL pre-multiplied color formats, such as MT8173.

Fix the SoC degradation problem by this sreies.

---
Change in v8:
Remove blend_modes for not supported pre-multiplied SoCs to fix the
return error from drm_plane_create_blend_mode_property().

Change in v7:
1. Add the remove color format comment patch for OVL
2. Fix warning: 'const' type qualifier on return type has no effect

Chnage in v6:
1. Use blend_modes instead of function pointer in OVL
2. Use ethdr instead of mdp_rdma to get blend_modes
3. Add 0 checking for adding blend_mode property for mtk_plane

Change in v5:
Add fix patch for mtk_plane

Change in v4:
Add lost cases of mtk_ovl_fmt_convert_with_blend

Change in v3:
Change MACRO approach to function pointer in driver data

Change in v2:
Fix build error and typo

Change in v1:
Add fix patch for OVL unsupport color format settings by driver data

---

Jason-JH.Lin (3):
  drm/mediatek: ovl: Remove the color format comment for
    ovl_fmt_convert()
  drm/mediatek: ovl: Add blend_modes to driver data
  drm/mediatek: Add blend_modes to mtk_plane_init() for different SoCs

 drivers/gpu/drm/mediatek/mtk_crtc.c           |  1 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       |  2 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       | 10 +++++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  2 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 44 ++++++++++++++++---
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  7 +++
 drivers/gpu/drm/mediatek/mtk_ethdr.c          |  7 +++
 drivers/gpu/drm/mediatek/mtk_ethdr.h          |  1 +
 drivers/gpu/drm/mediatek/mtk_plane.c          | 15 +++----
 drivers/gpu/drm/mediatek/mtk_plane.h          |  4 +-
 10 files changed, 76 insertions(+), 17 deletions(-)

-- 
2.43.0



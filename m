Return-Path: <linux-kernel+bounces-338378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB88985712
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B9CB20B64
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959FD17A5A6;
	Wed, 25 Sep 2024 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EGf40Cak"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE6115AD83
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259579; cv=none; b=e3ngFrbZHV158PKjIbuHceWfF15NX7V1i91s6mR+GK8HcY6H2v16aGhWC202UcRPvqxT96enu+Orp0z2hSppivwhc7x6YX7t0vISNXTYW1ucfuyIUqCfKrYU4Pw4cT7CDzNCE0WS3h+RYlzDozlofnquNUEez1CO6hm65/xm5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259579; c=relaxed/simple;
	bh=4v+DVWqYMoZee8v/1AXaLiLQT5QtSnkWCYl0g6HXyn0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tbDQeOk8e3bRrXUmuynHLNP4rXZdX9lo3rDkan6DNoOd+583gmtPGOVvyRhzMY55tEa89+E1oa9ey6+VvSOEY+wT84whkKXsruABOeiegrc/shYG+bLtTUVJDNmlHiPVXDGBjvGvj1Bp2mZguFplEqqdOHA9ucmKppSwl36KIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EGf40Cak; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a75da4047b2711efb66947d174671e26-20240925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TugJHXCaFkeeyesFwwQUZjkVyiQ4jMA5hShejsDmsrA=;
	b=EGf40Cak4lWXquov7qXmLodBmK5ijblXtOq+bzctm7a37WpqcV54ToY3pPF80gzzOj0LdUVZUj4Zn2aH7ojicdDnxHGNoePgUlvPeC633FfaW33pBnSYdhVIfhqrJsTA75/stbN7kMf0ewxH3MV2HNLe/3kXtu1vxreVEOzD0mw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:3d51afa4-e303-488c-86b3-ebc9150117ca,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:05ab3b18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a75da4047b2711efb66947d174671e26-20240925
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1811739284; Wed, 25 Sep 2024 18:19:31 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Sep 2024 18:19:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Sep 2024 18:19:28 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Shawn Sung <shawn.sung@mediatek.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH v5 0/2] Fix degradation problem of alpha blending series
Date: Wed, 25 Sep 2024 18:19:25 +0800
Message-ID: <20240925101927.17042-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.489600-8.000000
X-TMASE-MatchedRID: 7VDZqSP3y+1zDgxKJu7ruvSZ/2axrnPB1KoSW5Ji1XuPaLJ/Ca3ST/T9
	YCTkB8JLpEJ5RjVa0d0+zJdigxeeCDW+K/PcvqBrydRN/Yyg4pi4vBuE2X0HlQdFz8y7LneV8oL
	zUWewXkiVMlcqqHWd7aBVvEjzNBpCHxPMjOKY7A8LbigRnpKlKSPzRlrdFGDw5s9yGugQduwwcm
	99lxyatwQsom3hlNW0uy4ZmLibKBgwPvERclccVw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.489600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 646BF43563C005C7C2E41D5D2A092AFB2EF8869251E77B8858EABB8248E8A2462000:8
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

Some SoCs not support pre-multiplied pixel formats and extending
configuration of OVL pre-multiplied color formats, such as MT8173.

Fix the SoC degradation problem by this sreies.

---

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

Jason-JH.Lin (2):
  drm/mediatek: ovl: Add fmt_convert function pointer to driver data
  drm/mediatek: Add blend_modes to mtk_plane_init() for different SoCs

 drivers/gpu/drm/mediatek/mtk_crtc.c           |  1 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       |  2 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       | 10 ++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  3 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 93 +++++++++++++++++--
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  7 ++
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |  8 ++
 drivers/gpu/drm/mediatek/mtk_plane.c          |  9 +-
 drivers/gpu/drm/mediatek/mtk_plane.h          |  4 +-
 9 files changed, 122 insertions(+), 15 deletions(-)

-- 
2.43.0



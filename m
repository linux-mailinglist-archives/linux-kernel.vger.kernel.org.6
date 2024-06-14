Return-Path: <linux-kernel+bounces-214330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78819082D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8411C22881
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F063146D60;
	Fri, 14 Jun 2024 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FzFJHs2f"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87D19D894
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718337705; cv=none; b=bXBDDVhYBsXy4MjynIL420PXDStcgvpFAAPVhE7ypgLv6OtNarUvbr0bZAFjOfiXgE/ti2CVOu/55gKinWw8RaWF2kxPJEyKNv/jOY9T9LlTxPrljk1NOf4erOI08U5Ex6j25oSpb0YPeP24aaOkpWrbfiLfmTioVI/oBpaSJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718337705; c=relaxed/simple;
	bh=yQpgV/upBkqIHsXWhvICnGeX0GRq/NCKorfFFk2+OJo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XqUxDz1Bl1q7Yk5aYKrynIka2j0KypD2uwIc0iKCNzRXhF9EsueyuA9SnBrCMUdeUmdwz+jBYXmLcRJPNzoGQl2zsCmWR5SYaDgspwD5GzDoJrIM7vtbZDa21j550XSepwsoRBe0cYKQzwtvguRu1TrQItAIaw/a51anLZyU1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FzFJHs2f; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cb0f40b82a0211efa54bbfbb386b949c-20240614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VhJt4H7m25HdTeiGoiaZmPXbeNUjQW89pMMXO+LSutM=;
	b=FzFJHs2fbME1+B98DQ+nHHha/My7zd6irMgF5fj0nojQUpvd9IjtMAl0AlId76lkEe+nTYeu0xorvZDBwzKPIOw3IaLsvmWnCVth+Odo2aJfcgJyf1eXUTEmWxaDAeRNH5UVRkZppwn4tsqRx6M8wNDaVKR6IgPE9dL0aWYiECM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:1726d7ab-707a-424a-af09-84bf61a42787,IP:0,U
	RL:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:100
X-CID-META: VersionHash:393d96e,CLOUDID:53ee1285-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cb0f40b82a0211efa54bbfbb386b949c-20240614
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2063254935; Fri, 14 Jun 2024 12:01:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jun 2024 21:01:34 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jun 2024 12:01:34 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 0/2] Fix sleeping function called from invalid context
Date: Fri, 14 Jun 2024 12:01:31 +0800
Message-ID: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

We found that there is a spin_lock_irqsave protection in msg_submit()
of mailbox.c and it is in the atomic context.
So when the mailbox controller driver calls pm_runtime_get_sync() in
mbox_chan_ops->send_data(), it will get this BUG report.
"BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1164"

Add API to mbox_chan_ops to make mailbox takes into account that a driver
may need PM done.

Jason-JH.Lin (2):
  mailbox: Add power_get/power_put API to mbox_chan_ops
  mailbox: mtk-cmdq: Move pm_runimte_get and put to mbox_chan_ops API

 drivers/mailbox/mailbox.c          | 55 ++++++++++++++++++++++++++++++
 drivers/mailbox/mtk-cmdq-mailbox.c | 37 ++++++++++----------
 include/linux/mailbox_controller.h | 11 ++++++
 3 files changed, 84 insertions(+), 19 deletions(-)

-- 
2.18.0



Return-Path: <linux-kernel+bounces-415261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B749D33A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7B31F24030
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908A815A87C;
	Wed, 20 Nov 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gOTPkY0q"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902A15855E;
	Wed, 20 Nov 2024 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084634; cv=none; b=PGmvVTYJT9dyd6z8G5FcVk7PEMt0gm6rBbGAYdB7HHXsGyZftNqt2BrVvP4cZV8je7UZQSs/nX2auF3Xx6OEAvBl8/8RXyPDitG3NWYjmp+QlMBLJQQdCGqAcGfUqcqFmV/mWIbz8Yb3W57E3rgk7IJmQZhxSBibozW3CMt/K0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084634; c=relaxed/simple;
	bh=AfjbZbM6Xs6tLIsXsfBn4/QxlBGWAMOY6zC6vkjViQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W3t7rHw9rtPYtZG5cRqae+iZtEZ/Sw/UiShGwxzP9V5OyYL9MrNJ7aYBPcvF6mjYC+Gg9kAEQ3p4kfKZfWmEyH+AhQyoPC/kUMOh08gNph3fnfRL+6DkBOSsa+tuYavyDGenM39b78ioZWadMLzuoHnp+PxCyjJgEp0TjziIpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gOTPkY0q; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: db0cc312a70911ef99858b75a2457dd9-20241120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=I3TGAr8UNpOKrZxR5qC575V/3UsZbqaqa70mKIYt9K8=;
	b=gOTPkY0qQA5wF+LXuYNf9svVtTxKLIF00fH2Sv6tOL1fPGlXDdeF1BFmdmy6nOU7AJoGxTch3wxSWwC85KA0Yz+PdTOJ40PaMnDkTo5vb3dJsXWUioOlDUBgGePWmqt5s7yabBLUw00vDVP3A+qPOtHSMSS9dUibi2kxR9CFr58=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:bb918a2b-f7ab-4892-a64e-0fe879bed786,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:c7f847ce-1d09-4671-8b9c-efcc0e30e122,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: db0cc312a70911ef99858b75a2457dd9-20241120
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 965620131; Wed, 20 Nov 2024 14:37:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Nov 2024 14:37:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Nov 2024 14:37:02 +0800
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
Subject: [PATCH v2 0/2] Add SMI clamp in MediaTek SMI driver
Date: Wed, 20 Nov 2024 14:36:37 +0800
Message-ID: <20241120063701.8194-1-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on tag: next-20241119, linux-next/master

Refer to the discussion in the following link:
https://lore.kernel.org/all/CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=wXpobDWU1CnvkA@mail.gmail.com/
https://lore.kernel.org/all/CAPDyKFpokXV2gJDgowbixTvOH_5VL3B5H8eyhP+KJ5Fasm2rFg@mail.gmail.com/
SMI clamp and reset operations should be implemented in SMI driver
instead of PM driver.

When we enable/disable power domain, the SMI LARBs linked to this power
domain could be affected by the bus glitch. To avoid this issue, SMI
need to apply clamp and reset opereations.

This patch mainly add these functions:
1) Register genpd callback for SMI LARBs and handle this power domain
   status change in SMI driver.
2) Add bindings to support SMI Sub Common for MT8188.
3) Add bindings to support SMI larbs reset opearation

Changes v2:
- According to previous discussions in v1, divided these four
  patches into two topic separately
- Modify the description for 'resets' in binding
- Add const value 'larb' for 'reset-names' in binding
- Modify requirement for 'resets' and 'reset-names' in binding
- Delete 'mediatek,smi-sub-comm' in binding
- Delete 'mediatek,smi-sub-comm-in-portid' in binding
- Modify the example in binding
- Add 'mtk_smi_larb_clamp_port_mt8188' definition in SMI driver
- Change the way to parse the 'resets' in driver
- Change label from 'err_pm_disable' to 'err_link_remove'

v1:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240821082845.11792-3-friday.yang@mediatek.com/
https://patchwork.kernel.org/project/linux-mediatek/patch/20240821082845.11792-4-friday.yang@mediatek.com/

friday.yang (2):
  dt-bindings: reset: mediatek: Add mt8188 SMI reset control binding
  reset: mediatek: Add reset control driver for SMI

 .../bindings/reset/mediatek,smi-reset.yaml    |  53 ++++++
 drivers/reset/Kconfig                         |   9 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-mediatek-smi.c            | 156 ++++++++++++++++++
 include/dt-bindings/reset/mt8188-resets.h     |  11 ++
 5 files changed, 230 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
 create mode 100644 drivers/reset/reset-mediatek-smi.c

--
2.46.0



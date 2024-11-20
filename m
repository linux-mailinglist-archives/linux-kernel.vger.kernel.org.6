Return-Path: <linux-kernel+bounces-415255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3A49D338E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A466B22E60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFF11581F0;
	Wed, 20 Nov 2024 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iJBIHWZh"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A4E545;
	Wed, 20 Nov 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084395; cv=none; b=rVn5oB3pvb5yERtKtB1YUrccZ5KUzb57NWY0XydB+gDSLSKrjrrnhacauJqYZPs/Of4PabYRDQGb2msWHmo0JW7xPILIjz6/1CHOapnbEc1ZcJ8hwStpjDZiq4cFSE2pdtx7QCXj/otgiLIer5519opqqRaIM2uL6i7OdkeYros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084395; c=relaxed/simple;
	bh=LOuS70QFzSO7FRLeireJC7FpGbHHu+7JYaO7eDwD+Xw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cm4miMOUa/EXF1iUD2cdfQ8JUXWUUrDQJzuqGX8hILJNN8b2zphNDQJEDvBec+7tQVnP0pp353zL7Fy775N+XWZmmbaHNuBTHjcgGH4G6stcm0fRAS5QiLw9MoWQBYcvMyPXjizHAZylLU6QQCt6RfHFO5neSknqHeFK1An+wlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iJBIHWZh; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4d86e626a70911ef99858b75a2457dd9-20241120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7XJ/IRWNQ6dXRG9QeIWYl13jSAxsiZs7JN33ZiHyh8g=;
	b=iJBIHWZhG8vbYmmMXebEsmnQaWaw/z8L8Mgsuxq2t0Yz2hdI5XArt+RqD/0Y0rsw9UE2wNWcI7+NyjBXf+bGpvpXCg7KeqkE2Q+aTZ58HgXX+iVu4w3JMkbkk0iaUDnvOUPCCoDlvUdCgWNLTkmeChBPteM2pFRJxIVoEw4YTfo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:fba3b662-2967-4ed0-a66f-d6e1fa2b9c49,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:26e218b9-596a-4e31-81f2-cae532fa1b81,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 4d86e626a70911ef99858b75a2457dd9-20241120
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 880690284; Wed, 20 Nov 2024 14:33:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Nov 2024 14:33:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Nov 2024 14:33:05 +0800
From: Friday Yang <friday.yang@mediatek.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Friday Yang
	<friday.yang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 0/2] Add MediaTek SMI reset controller driver
Date: Wed, 20 Nov 2024 14:32:54 +0800
Message-ID: <20241120063305.8135-1-friday.yang@mediatek.com>
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
1) Add SMI reset controller driver to implement SMI LARBs reset opereations.
2) Add bindings for describing the reset controller.

Changes v2:
- According to previous discussions in v1, divided these four
  patches into two topic separately
- Change from 'mediatek,larb-rst-syscon' to 'mediatek,larb-rst'
- Modify the description for 'mediatek,larb-rst'
- Modify the description for '#reset-cells'
- Change compatible to 'mediatek,mt8188-smi-reset'
- Add COMPILE_TEST for RESET_MTK_SMI in Kconfig
- Drop label in binding's example
- Use MMIO instead of regmap in reset controller driver

v1:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240821082845.11792-2-friday.yang@mediatek.com/
https://patchwork.kernel.org/project/linux-mediatek/patch/20240821082845.11792-5-friday.yang@mediatek.com/

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



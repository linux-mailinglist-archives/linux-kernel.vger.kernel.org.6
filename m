Return-Path: <linux-kernel+bounces-525289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D607A3ED99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54CD3B9A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291D1FFC4D;
	Fri, 21 Feb 2025 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dTd9H/mu"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0A1FF1D1;
	Fri, 21 Feb 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124270; cv=none; b=SgOCxtOnqX90sD3Rfd1ptnQ8Bd6+nj3AnMoq9tNO5RK9SyPaXJjHbS2fEc2sEIsRjnrj+G8ShYQ607WrzloGMpPcIpSyeKrJA8ZKU9vpNVh1zujozTw4Zoi0oa3bLbpPCsLsaLHuejYN26qKbbasRxkPiKO2pwp+hJyfEtA1b7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124270; c=relaxed/simple;
	bh=WDF+AaPoasicPg5cjVd43KSl6VbCzFp6Lbsto9p3UZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OYMgCNj3eVu+1D3iBRrGBixV4orUxWhzWE778orFI/yYjtLZLtKCDPmbPfLr2YCseVHbROMPRPjih0DkXGygV+KqHB11WvPYoD+t9xL0pvSetmW5X1Un4ReAiOqe1v7VR8a+1RvXNfm7Tnw0YK9nMxoHtFx+YmzvI0YGdMJKx10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dTd9H/mu; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 987e4e86f02811ef8eb9c36241bbb6fb-20250221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8NPujDCOA2i+sZ1Eo+mp2xCE16CGmm1ZdIPKOowNMtk=;
	b=dTd9H/muFL+Wagj+GFDqM3ZXmia2b/QpBKPhDXD+XkDEgaJoTti9EvEPBryJsFf3pJQiRKB5PoYP4xdLeW8HbOWOosjwUJF3IUjukRjqKMKCAEe1KcxwnjvO5AY7AlrrIUnHb0M7LbFr7sawRhaexhL2aHn4DR4KWrU4F/15XmM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:9938e1d6-09b7-4b87-8eb9-74d3a9758de0,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:60aa074,CLOUDID:800b63a4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:2,IP:nil
	,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 987e4e86f02811ef8eb9c36241bbb6fb-20250221
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 596277761; Fri, 21 Feb 2025 15:51:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 21 Feb 2025 15:51:01 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 21 Feb 2025 15:51:00 +0800
From: Friday Yang <friday.yang@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Garmin Chang
	<garmin.chang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
CC: Friday Yang <friday.yang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 0/2] Add SMI LARBs reset for MediaTek MT8188 SoC
Date: Fri, 21 Feb 2025 15:50:52 +0800
Message-ID: <20250221075058.14180-1-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on tag: next-20250220, linux-next/master

On the MediaTek MT8188 SoC platform, we encountered power-off failures
and SMI bus hang issues during camera stress tests. The issue arises
because bus glitches are sometimes produced when MTCMOS powers on or
off. While this is fairly normal, the software must handle these
glitches to avoid mistaking them for transaction signals. What's
more, this issue emerged only after the initial upstreaming of this
binding.

The software solutions can be summarized as follows:

1. Use CLAMP to disable the SMI sub-common port after turning off the
   LARB CG and before turning off the LARB MTCMOS.
2. Use CLAMP to disable/enable the SMI sub-common port.
3. Implement an AXI reset for SMI LARBs.

This patch primarily provides the implementation of an AXI reset.

Changes v4:
- Modify the commit message

v3:
https://lore.kernel.org/lkml/20250121065045.13514-2
-friday.yang@mediatek.com/
https://lore.kernel.org/lkml/20250121065045.13514-3
-friday.yang@mediatek.com/

Friday Yang (2):
  dt-bindings: clock: mediatek: Add SMI LARBs reset for MT8188
  clk: mediatek: Add SMI LARBs reset for MT8188

 .../bindings/clock/mediatek,mt8188-clock.yaml | 21 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt8188-cam.c         | 17 +++++++++++++++
 drivers/clk/mediatek/clk-mt8188-img.c         | 18 ++++++++++++++++
 drivers/clk/mediatek/clk-mt8188-ipe.c         | 14 +++++++++++++
 4 files changed, 70 insertions(+)

--
2.46.0



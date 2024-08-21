Return-Path: <linux-kernel+bounces-295131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE52959768
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBD21F219E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19241199FC2;
	Wed, 21 Aug 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NpNDCJ6T"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C21CEAD5;
	Wed, 21 Aug 2024 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228940; cv=none; b=tv+dGhvzoBRpvCEfZ/eRC+Zuk1Tv7rQK4ePv5zTlPOyxg5LphpJDCzHgGX8NINR7vsPSbHYSl+AqDNbDApN/zoWYOONrGhv8Sjyg2cr04AyhX/qxxFCP4qmD1jLj8bE+6cKElzEGJlMShPdlunyGPdtUaZA/smXgfrg6GRNicIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228940; c=relaxed/simple;
	bh=VxOzlUYauVhbVHBSbPfYpLFqSQ+zTMay4dd2Nw7tFXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QZ6QRw/GzXhxICoLdz1En0OeNmy/cMI0Xna4+TTKLlnLqwPPnJ0zKuIjn6KXM4HV8pCmZcHUWh9gtWjZz/uRdVQ8K0qpgvNUyYP5Eqw6uaKCBBFJnGJ8/Xr+TvRlgIzSiGpfJNDu6yevxzJmEOn57igxiSPikzLtV6DYATE7QT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NpNDCJ6T; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6364ad5c5f9711ef8593d301e5c8a9c0-20240821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Tfvrvcu6RP0eyXcpdgDoO9aUBkQLTiA9tNk3AuOteYE=;
	b=NpNDCJ6TeOrQ6ob9e6NG5fX5nALXRFHZqFoT9yH+Cyehb1PdWjVhC4Z0nUvf8cNznm8KNsYmHoVwipUJA6kNYxaxR2A4sno6xnPxwA4o+yV6x3iBn5oDz5b6GRz6mQvRWjDXefZaFoNjiRbRObzSlIM/56ccyYZKlOoiNJJKMFw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:bbd8c93e-7dd0-4e69-a1b0-43a4f61ec940,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:6dc6a47,CLOUDID:e08df1ce-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 6364ad5c5f9711ef8593d301e5c8a9c0-20240821
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1341116; Wed, 21 Aug 2024 16:28:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Aug 2024 16:28:47 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Aug 2024 16:28:46 +0800
From: friday.yang <friday.yang@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Yong Wu <yong.wu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Friday Yang <friday.yang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 0/4] Add SMI clamp and reset
Date: Wed, 21 Aug 2024 16:26:48 +0800
Message-ID: <20240821082845.11792-1-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.945500-8.000000
X-TMASE-MatchedRID: VM+0CAai3W23D+jgn28P5kLcvIIgiVuN9pLnYtQ99xJh2fnHe1cil/Ds
	kP9n+KGGhKaZgkam63X6BsxBntd8/69VPpt+QVb+QpxiLlDD9FWZ2scyRQcer19eTSR8I6duVkP
	jnlLOkq2MVdvRiR/Be0ixezJGk2ozwuTfHDVJ/15VTfJWlqPdDEyQ5fRSh265NSweOixQAJJHdE
	c8dOyw1Vl+Hk3Iw2bEgDLqnrRlXrYbaLjLw/bFed0H8LFZNFG73Yq8RVaZivWLgpbqFBoHY1+gu
	K2n/tPR07d2g0qCMsnZWKG32TjC/QGeyeOvBlDN
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.945500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 45E3677124D75BD3EF1299E16BE0A636DF103054266AA26AA09BEE43E120A57C2000:8

Based on tag: next-20240821, linux-next/master

Refer to the discussion in the following link:
https://lore.kernel.org/all/CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=wXpobDWU1CnvkA@mail.gmail.com/
https://lore.kernel.org/all/CAPDyKFpokXV2gJDgowbixTvOH_5VL3B5H8eyhP+KJ5Fasm2rFg@mail.gmail.com/
SMI clamp and reset operations should be implemented in SMI driver
instead of PM driver.

When we enable/disable power domain, the SMI LARBs linked to this power
domain could be affected by the bus glitch. To avoid this issue, SMI
need to apply clamp and reset opereations.

These patches mainly add these functions:
1) Register genpd callback for SMI LARBs and handle this power domain
   status change into SMI driver.
2) Add SMI reset control driver to implement SMI reset opereations.
3) Add bindings for describing the reset control regmap and SMI Sub Common.

friday.yang (4):
  dt-bindings: memory: mediatek: Add mt8188 SMI reset control binding
  dt-bindings: memory: mediatek: Add smi-sub-common property for reset
  memory: mtk-smi: mt8188: Add SMI clamp function
  reset: mediatek: Add reset control driver for SMI

 .../mediatek,smi-common.yaml                  |   2 +
 .../memory-controllers/mediatek,smi-larb.yaml |  22 +++
 .../bindings/reset/mediatek,smi-reset.yaml    |  46 ++++++
 drivers/memory/mtk-smi.c                      | 148 ++++++++++++++++-
 drivers/reset/Kconfig                         |   9 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-mediatek-smi.c            | 152 ++++++++++++++++++
 include/dt-bindings/reset/mt8188-resets.h     |  11 ++
 8 files changed, 389 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
 create mode 100644 drivers/reset/reset-mediatek-smi.c

--
2.46.0



Return-Path: <linux-kernel+bounces-546272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC8A4F89D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444F33A135D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF941F8677;
	Wed,  5 Mar 2025 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kVU0y0iJ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49FA14658D;
	Wed,  5 Mar 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162860; cv=none; b=af/x/YRDO8yLz44kQGT+gO+xWuM49c7kOzple+L+NFexZtOoKp4e35x9Hd/fCo5TSe5VJ2E+qX5mDz9Cf4cqnPDK+C+kdXdIDrOQYgvQV3HSr9SJ3B0V2+UxUhubtOIggUOIW90P8BVJqReDGeBdsvsu7UuBs/cKUJ77HwjVccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162860; c=relaxed/simple;
	bh=s3Uk1BHVwIcZ5VUVVc13SVRBkZzEcEhWNPCLgY3F+N4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdFB3otcEJNXhdyHfbcImSqMbi1S58yPKzbGKjYeHYn4qPBtIO4krhJUezSPDhscbjot8KXjj3HIT5FZMp7rs0i6JGRrafhhh0+Gm4efv/GOW3CXR2VVwSFSlgaK622k3j23y8b/PGK/HwMf8zR7T+n7HdwQ2lD5Y6x50Ns0QRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kVU0y0iJ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bfcbacbaf99a11ef8eb9c36241bbb6fb-20250305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GFxWueo3Q7D0lqnHm7zaaDzy31RkGxj9+qLmZ+0IIcM=;
	b=kVU0y0iJ1+0wStsj/S44pJwmWI3j954AP+9dA5t7YJ3MuOraAF4DCjIHdw7TpE5cljyMlOdhaDJczDbN6tuM6Zqp5274MOyw5genNDNVmfAPPQmDirTiVnV6PI4E4WjpEUN69OskZaksE/Ci79frisJ68wxa2tmnA6d1wC0aUjg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:869f8c68-3c77-4ff1-b476-1edf62165389,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:6461fa8b-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bfcbacbaf99a11ef8eb9c36241bbb6fb-20250305
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1280654986; Wed, 05 Mar 2025 16:20:50 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 5 Mar 2025 16:20:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 5 Mar 2025 16:20:49 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, Jjian Zhou <jjian.zhou@mediatek.com>
Subject: [PATCH RFC 0/3] add VCP mailbox and IPC driver
Date: Wed, 5 Mar 2025 16:20:37 +0800
Message-ID: <20250305082047.15746-1-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The VCP mailbox has 5 groups. Each group has corresponding interrupts,
registers, and 64 slots (each slot is 4 bytes). Since different features
share one of the mailbox groups, the VCP mailbox needs to establish a
send table and a receive table. The send table is used to record the
feature ID, mailbox ID, and the number of slots occupied. The receive table
is used to record the feature ID, mailbox ID, the number of slots occupied,
and the receive options. The API setup_mbox_table in mtk-vcp-ipc.c calculates
the slot offset and pin index for each feature ID based on the mailbox ID and
slot number in the send and receive tables (several slots form a pin, and
each pin can trigger an interrupt). These descriptions are written in the
mtk-vcp-ipc.c file -- we call it the IPC layer.

We have two questions:
How should we describe the mailbox and IPI?
Can the intermediate IPC layer be rewritten as a virtual mailbox layer?

Example of send and recve table:
Operation | mbox_id | ipi_id | msg_size | align_size | slot_ofs | pin_index |  notes
send          0          0       18          18           0          0
recv          0          1       18          18          18          9
send          1         15        8           8           0          0
send          1         16       18          18           8          4
send          1          9        2           2          26         13
recv          1         15        8           8          28         14       ack of send ipi_id=15
recv          1         17       18          18          36         18
recv          1         10        2           2          54         27       ack of send ipi_id=2
send          2         11       18          18           0          0
send          2          2        2           2          18          9
send          2          3        3           4          20         10
send          2         32        2           2          24         12
recv          2         12       18          18          26         13
recv          2          5        1           2          44         22
recv          2          2        1           2          46         23

Recv ipi_id=2 is the ack of send ipi_id=2(The ipi_id=15 is the same.)

Jjian Zhou (3):
  mailbox: mediatek: Add mtk-vcp-mailbox driver
  firmware: mediatek: Add vcp ipc protocol interface
  dt-bindings: mailbox: mtk,vcp-mbox: add mtk vcp-mbox document

 .../bindings/mailbox/mtk,vcp-mbox.yaml        |  49 ++
 drivers/firmware/Kconfig                      |   9 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/mtk-vcp-ipc.c                | 481 ++++++++++++++++++
 drivers/mailbox/Kconfig                       |   9 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mtk-vcp-mailbox.c             | 179 +++++++
 include/linux/firmware/mediatek/mtk-vcp-ipc.h | 151 ++++++
 include/linux/mailbox/mtk-vcp-mailbox.h       |  34 ++
 9 files changed, 915 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml
 create mode 100644 drivers/firmware/mtk-vcp-ipc.c
 create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
 create mode 100644 include/linux/firmware/mediatek/mtk-vcp-ipc.h
 create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h

--
2.45.2



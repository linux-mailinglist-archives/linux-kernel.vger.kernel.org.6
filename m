Return-Path: <linux-kernel+bounces-563993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF7A64B99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C07DE7A71EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5805E221730;
	Mon, 17 Mar 2025 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FqMInOu/"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AA38B;
	Mon, 17 Mar 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209421; cv=none; b=AjApOtJT65CL3LujyQYwEK9DSBV3wvouUX/b5zfqOMCUWjlNx1bKgcLLr7XQuzqvc8d1J1B3pA5SEuOol4xOokYWEirRFWvvGv9AVgOYVH/KOwGqJi6LwbPVgxpNG1b1yyPxHaBrmx0DYNhgRbcwUgzHPbPamZTncwKonZmVh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209421; c=relaxed/simple;
	bh=CI2O3QoR8fwKrsxCtcAgNWI4XnD0T0da3jTU3OBOfiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QOpbciE3cEBgU/EWGPL0VTILfc8i8pek25iX1yK4Yt40ZhozZCBDngPcB3izCRfyoW9uuO39Cx4ZNSKUCLNGCPrjIRbgW6b4ZYWk4WlRBXHD3uFnp8+LDl3mV1KjNWbLDM8PcLQ/0KAWTOlItBTA3Bb8fxp0/40bC2h4FKE/ogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FqMInOu/; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 785457ae031f11f08eb9c36241bbb6fb-20250317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=657JLeMn4zGfcS0ZqmrhuDCOiVafOjPS5gLha6fBHnQ=;
	b=FqMInOu/3cUuHByDD6uJmAIQZ3TTGMSPmDdJkN7j7uMDBWeZ560uT/Ro+k7/boYVpN1LNjGaHRQhWqu1pwIuXK8gR6lSMyqMIH1KN/uzKIT3yERg7ZOH89ieN+7RlUGTziKmMOyOSGkW02OTNV436Lm34KUxNPghQLBkjlZ581I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:99a37237-b729-4f65-9388-2a6403c134ef,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:498c798c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 785457ae031f11f08eb9c36241bbb6fb-20250317
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1670026747; Mon, 17 Mar 2025 19:03:34 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 17 Mar 2025 19:03:33 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 17 Mar 2025 19:03:32 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>, Jjian Zhou <jjian.zhou@mediatek.com>
Subject: [PATCH RFC v3 0/3] add VCP mailbox and IPC driver
Date: Mon, 17 Mar 2025 19:03:22 +0800
Message-ID: <20250317110331.2776-1-jjian.zhou@mediatek.com>
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
  dt-bindings: mailbox: mtk,mt8196-vcp-mbox: add mtk vcp-mbox document

 .../bindings/mailbox/mtk,mt8196-vcp-mbox.yaml |  49 ++
 drivers/firmware/Kconfig                      |   9 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/mtk-vcp-ipc.c                | 481 ++++++++++++++++++
 drivers/mailbox/Kconfig                       |   9 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mtk-vcp-mailbox.c             | 179 +++++++
 include/linux/firmware/mediatek/mtk-vcp-ipc.h | 151 ++++++
 include/linux/mailbox/mtk-vcp-mailbox.h       |  34 ++
 9 files changed, 915 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,mt8196-vcp-mbox.yaml
 create mode 100644 drivers/firmware/mtk-vcp-ipc.c
 create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
 create mode 100644 include/linux/firmware/mediatek/mtk-vcp-ipc.h
 create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h

-- 
2.45.2



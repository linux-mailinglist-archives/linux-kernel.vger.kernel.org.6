Return-Path: <linux-kernel+bounces-379580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC689AE0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D42928464B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAE41B85FD;
	Thu, 24 Oct 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IVynVBW5"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F51B85D4;
	Thu, 24 Oct 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762007; cv=none; b=sC6rgFCZJodFNdqFZkC3SmxIwUNyAg6Hfjl+2VSsvsC12Yeo5YH+QqaA28pwh6NBBKU4W5KEWCgbid7oWY211RvP9Ym84rbK/DYxwUQ+IdXEZlEEIU0kj5UUsaGR1rhW/EWFOIqWLcLinrGnGbLIl9OeuKP1FbnGRadek4D09V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762007; c=relaxed/simple;
	bh=RzC3P/bd7ulzkYAm2qj8aTc72v5rbAlUoIp6KusaCl0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J1KFqnJFjODIVakPjsClq9ELtBgksyMwC0lsZAKynpdvDLN4dSzqX5zY1r7vkJyZ9KRQSiP4wmxq3eyeGr/APiVbep46hhqCcKtBmwXwYK/fFti6AyKWTDFbftUdEeS6bCTpL0vU9125NFE95QnMoaLu3vrN1BQIbqOIwHb63Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IVynVBW5; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 11c7ae7491ea11efb88477ffae1fc7a5-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pJpQaYRYOFoOBzvOr5AFD9WL6zha/mkCFXA5uGrTyhw=;
	b=IVynVBW5NdsfSxn2yTMYtlzn0bADSgpKTrEv7zhKMq244qTYP7e2/aBQttBbyUkzHc6nF2mtp1rq2iRJ7Xl5+1IOpRL3fiSAz3Ve08vNJ/VzrJEmqGJanLOOYXlEuUeec/uROdfLedz/gVWe+pnzWYDzvk3Zu/9bGj577z8DAjw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:cb27b63d-e76f-46f5-a471-d53440137e09,IP:0,U
	RL:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:100
X-CID-META: VersionHash:b0fcdc3,CLOUDID:2f2bcccc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3|8,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 11c7ae7491ea11efb88477ffae1fc7a5-20241024
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <karl.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1765193837; Thu, 24 Oct 2024 17:26:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Oct 2024 17:26:36 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 17:26:36 +0800
From: Karl.Li <karl.li@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Karl Li <Karl.Li@mediatek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Chungying Lu <chungying.lu@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Karl Li
	<karl.li@mediatek.com>
Subject: [PATCH 0/3] Add MediaTek APU Mailbox Support For MT8196
Date: Thu, 24 Oct 2024 17:25:42 +0800
Message-ID: <20241024092608.431581-1-karl.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Karl Li <karl.li@mediatek.com>

Based on tag: next-20241021, linux-next/master

Hello,

This patch series introduces support for the MediaTek APU (AI Processing Unit) mailbox, a crucial component for facilitating communication between the APU and other system processors within MediaTek platforms. The APU subsystem relies on a message-passing mechanism built atop the mailbox infrastructure, necessitating enhancements to the existing mailbox framework to accommodate the APU's communication requirements.

The series begins by adding the necessary device tree bindings for the APU mailbox, followed by an enhancement to the mailbox framework allowing for bottom-half processing of received data. This is particularly important for the APU's operation, as it relies on a combination of mailbox messages and shared memory for data exchange. Finally, we introduce the MediaTek APU mailbox driver itself, which implements the communication protocol and exposes additional hardware features for broader system integration.

Patch Summary:
1. dt-bindings: mailbox: mediatek: Add apu-mailbox document
   - Introduces the device tree bindings necessary for describing the APU mailbox in device tree sources, enabling the kernel to correctly configure and utilize this component.

2. mailbox: add support for bottom half received data
   - Enhances the mailbox framework to support sleepable contexts in the processing of received messages. This is critical for APU communication, where message handling may require operations that cannot be performed in atomic contexts.

3. mailbox: mediatek: Add mtk-apu-mailbox driver
   - Adds the driver for the MediaTek APU mailbox, facilitating communication with the APU microprocessor and providing interfaces for other system components to interact with the APU through spare registers.

This work is a step towards fully integrating MediaTek's APU capabilities with the Linux kernel, enhancing support for AI features on MediaTek platforms.

Please review and provide feedback.

Best regards

Karl Li (3):
  dt-bindings: mailbox: mediatek: Add apu-mailbox document
  mailbox: add support for bottom half received data
  mailbox: mediatek: Add mtk-apu-mailbox driver

 .../mailbox/mediatek,apu-mailbox.yaml         |  55 +++++
 drivers/mailbox/Kconfig                       |   9 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mailbox.c                     |  16 ++
 drivers/mailbox/mtk-apu-mailbox.c             | 222 ++++++++++++++++++
 include/linux/mailbox/mtk-apu-mailbox.h       |  20 ++
 include/linux/mailbox_client.h                |   2 +
 include/linux/mailbox_controller.h            |   1 +
 8 files changed, 327 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.yaml
 create mode 100644 drivers/mailbox/mtk-apu-mailbox.c
 create mode 100644 include/linux/mailbox/mtk-apu-mailbox.h

-- 
2.18.0



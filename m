Return-Path: <linux-kernel+bounces-379584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA869AE0C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F44285202
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8F1C07C3;
	Thu, 24 Oct 2024 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tI/h7ACd"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE31B3924
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762046; cv=none; b=r8mRsgvx5VOIUSUppua8VIPcTrvMq/n4DpCb2YtpVEdBCxGOh1t6m88eDAB4R2sMbGRjzmZcRH8CTXTkVxIUEIq7EsqDmOQe6cIBO0lXb24MMztkTtFrk1qmAN4fcf/+TOdJP/VvJuGRa/1hTaeUA08uA2RCKmdqTtfb2W1nIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762046; c=relaxed/simple;
	bh=C/8++dvVsR5hXH8rjgSUEUUXyuB5lvPSmCL12pwFSUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R9EqpLTMwBsYz2ROhrA04/lCUiRq8GJcZU6/2cY6fwfwCooXho/RXU/jc1QuoZOhiEXnecZrDzsfPiAa6PNn31QOD91W7dFysjXpmAedckhYP1L5sFQc3r51JCTtNI8QV6ExeeLwe4iyAzMMKr9KorFxiScmWr7BnLEl9mM6BU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tI/h7ACd; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2b1a6e5291ea11efb88477ffae1fc7a5-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qzmpXSP96VCl55BYbAELjaoJE0JaKXnVW27Q0eZgiiU=;
	b=tI/h7ACdBzMK0HJJpK/FvzGuob1AkmAQRTFtjBQb9KYFn4SlEEAFAe04ZGTTsd0zlRWxe6qlKqLFNNZJEzh3Wd4djvaKyY3p9hsDhIqEgoZnUxzwMgJ8GXMGSqsbceMHhLzWI+1af7MwolGLmJbva+Ix5kZ/L39yQCo8iLb0ffE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:1e80492a-3450-43d7-bc0f-824748406fc5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:60a4c441-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2b1a6e5291ea11efb88477ffae1fc7a5-20241024
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <karl.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 762838025; Thu, 24 Oct 2024 17:27:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Oct 2024 17:27:19 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 17:27:19 +0800
From: Karl.Li <karl.li@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Karl Li <Karl.Li@mediatek.com>,
	Chungying Lu <chungying.lu@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Karl Li
	<karl.li@mediatek.com>
Subject: [PATCH 0/1] Add MediaTek APU SMC call Definition
Date: Thu, 24 Oct 2024 17:27:04 +0800
Message-ID: <20241024092712.431605-1-karl.li@mediatek.com>
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

This patch introduces the SMC calls for MediaTek APU.

The start and stop sequences of the APU microprocessor are managed within the ARM Trusted Firmware (ATF), which requires a secure and reliable communication channel to issue commands from the non-secure world. This patch adds the necessary infrastructure to issue these SMC calls, ensuring that the APU can be securely managed by the system's software.

Please review and provide feedback.

Best regards

Karl Li (1):
  soc: mediatek: Add command for APU SMC call

 include/linux/soc/mediatek/mtk_apu_secure.h | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/linux/soc/mediatek/mtk_apu_secure.h

-- 
2.18.0



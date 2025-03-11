Return-Path: <linux-kernel+bounces-556098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E5FA5C0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEB13AA031
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206A4256C7E;
	Tue, 11 Mar 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c/KoERW2"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FB11CBA;
	Tue, 11 Mar 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695820; cv=none; b=Hjx8alN1fUFEg8wjqC27T+2zH3Waj+MKD1hoiPu62+VX6CyhRKPhnwleJuTIiAHV8ZFFAU5Op/wrEbJY16k67BMHWogzzQLJyNXhEQRDbUOqm+iznAE716J5ui8ISk7KnOSUSDoWK+zDlwRk4VJqVeDhe4C6yCqXPKxkhYyBtg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695820; c=relaxed/simple;
	bh=j9UTbrj8tbEEfoE7QqDfPdH+rALFI1BIBtcwboLWbGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qhdv9R7ZtJg5St8/H5TFllMfyWrkWoFd0SCCxxVfQvKvgksxhEmfdLV41uDeQ2aS07WmoEbPQA1OHg+B/Kt5UUtFFHqYpswrO46ubZFcxhBnWIUoYBD0k+7jR83BAGdgARhbf79FbClgtdpckX8WzhzdxcckzDV8APnZ/iUn6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c/KoERW2; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a42a393afe7311efaae1fd9735fae912-20250311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KK+/RmR1fDa/48B6jmY4n1J//yOw/sjpmxW9roLWxqI=;
	b=c/KoERW244gwPXkPELVTdOrKW92IIrut58Yxv7soknudOx8Cn4y4zrjPkVTBvKdnqiZ9Mzd2OoxqylRdKoAAv14OMni92DC1FcooMUrju966l5RdQyeY+CDHXbx6IkAgtqbaij5EIPiCVvvMuXHm+3CHTYne/zJ4T3HO5BFS2Xo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:61c788a3-8993-431c-93ff-836f5ab09e31,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:c7e2f749-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a42a393afe7311efaae1fd9735fae912-20250311
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1661960772; Tue, 11 Mar 2025 20:23:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 11 Mar 2025 20:23:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 11 Mar 2025 20:23:27 +0800
From: Friday Yang <friday.yang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: Friday Yang <friday.yang@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 0/2] Add SMI reset and clamp for MediaTek MT8188 SoC
Date: Tue, 11 Mar 2025 20:23:20 +0800
Message-ID: <20250311122327.20685-1-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on tag: next-20250307, linux-next/master

On the MediaTek MT8188 SoC platform, we encountered power-off failures
and SMI bus hang issues during camera stress tests. The issue arises
because bus glitches are sometimes produced when MTCMOS powers on or
off. While this is fairly normal, the software must handle these
glitches to avoid mistaking them for transaction signals. What's
more, this issue emerged only after the initial upstreaming of SMI
driver.

The software solutions can be summarized as follows:

1. Use CLAMP to disable the SMI sub-common port after turning off the
   LARB CG and before turning off the LARB MTCMOS.
2. Use CLAMP to disable/enable the SMI sub-common port.
3. Implement an AXI reset for SMI LARBs.

Changes v5:
- Use 'devm_pm_runtime_enable' instead of 'pm_runtime_enable'.
- Remove 'pm_runtime_disable' in 'mtk_smi_common_remove' and
  'mtk_smi_larb_remove'.

v4:
https://lore.kernel.org/lkml/20250221074846.14105-2-friday.yang@mediatek.com/
https://lore.kernel.org/lkml/20250221074846.14105-3-friday.yang@mediatek.com/

friday.yang (2):
  dt-bindings: memory: mediatek: Add SMI reset and clamp for MT8188
  memory: mtk-smi: mt8188: Add SMI reset and clamp for MT8188

 .../mediatek,smi-common.yaml                  |   2 +
 .../memory-controllers/mediatek,smi-larb.yaml |  19 +++
 drivers/memory/mtk-smi.c                      | 150 +++++++++++++++++-
 3 files changed, 164 insertions(+), 7 deletions(-)

--
2.46.0



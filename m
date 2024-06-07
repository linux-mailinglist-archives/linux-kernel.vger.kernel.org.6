Return-Path: <linux-kernel+bounces-205245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B9B8FF9EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F1D28292C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4A1172C;
	Fri,  7 Jun 2024 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uIFYUYCk"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C528819
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717727185; cv=none; b=LU3T1pkhuzpDZHIlPWZLE6oQO9yywM0OJeE+SX1FEs8QeZjGeG9GlehHK3Bld01AKmrqYD34yR1CHD23YySYAynbEHknzFbTi8H/Qi1gZmffzeWGBctD0x7QJ6cl0fWpElmTuIOD+hHW4Dmsp8fAIUWp+Zuyx8ciofP0wkbPx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717727185; c=relaxed/simple;
	bh=d3kPG/il1q6KCc+6zs88T4ul/hnCiaV64YoLO/tMf/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0aoZ0ZC0Pva9rLVDMXf0NIkwF+Ui2GWzYJBagZ7ns0tW8hApsiKdIkDc3rWbEfBjrxkve3XlUETmVHanKJZuU0U2UUl3hSHEbCl1//S64fnz2lqlr0JyMGOvhrxouLCvVRP197uwn+K3seMt1xumec5+3EhDsUjJX2cOPC9DY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uIFYUYCk; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 52114ffe247511efa22eafcdcd04c131-20240607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BLEU828uCInFLuwTYCQ33Lcs5sdd10hyJlrloS9Xaw4=;
	b=uIFYUYCkFdwmPziXHOc7czH/inm67R50e4fF2fUNvafml+9YY4gfb0fpfhHVRg1bnQUMGSgUWNjqdp1wlDQBx++vJgZ7mj/tvwKw8qPqTEvSHUp/DJaiCEtCBtFeXH/XiolcO0kSeUVCI7QJgXK7uVX2LXtIAvXUt+Mc8IS3bdo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:3b63d2a0-caf0-4ac8-a844-eba207ac19b1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:169ad084-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 52114ffe247511efa22eafcdcd04c131-20240607
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <phil.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1791235917; Fri, 07 Jun 2024 10:26:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 7 Jun 2024 10:26:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 7 Jun 2024 10:26:16 +0800
From: Phil Chang <phil.chang@mediatek.com>
To: <anna-maria@linutronix.de>
CC: <alix.wu@mediatek.com>, <angelogioacchino.delregno@collabora.com>,
	<frederic@kernel.org>, <jy.ho@mediatek.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<matthias.bgg@gmail.com>, <phil.chang@mediatek.com>, <tglx@linutronix.de>
Subject: [PATCH v2] hrtimer: check hrtimer with a NULL function
Date: Fri, 7 Jun 2024 10:26:14 +0800
Message-ID: <20240607022614.22902-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <877cf2i56q.fsf@somnus>
References: <877cf2i56q.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Since hrtimers do not allow a NULL function to be passed,
to prevent a kernel crash, return before adding the timer to a queue.

Signed-off-by: Phil Chang <phil.chang@mediatek.com>
---
 kernel/time/hrtimer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 492c14aac642..d32c1afe59b3 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1285,6 +1285,9 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
+	if (WARN_ON(!timer->function))
+		return;
+
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard
-- 
2.18.0



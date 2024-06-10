Return-Path: <linux-kernel+bounces-208239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3519022BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF811C2123B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542E974048;
	Mon, 10 Jun 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dvG3r7o9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22815A8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026314; cv=none; b=gUjgOsU6szDpWGajqIynvorVCu69hKVvvEo1YDDwQMFee76XPfmIDghDV2YrTpsOSa/GBjhN+KmDjqLeo+ixqf7rhscEqdE9qA9KtOfzKhfQlJsKS+q14MEXM3Sj945z6x7eRUU95IO+CGV+3CrYK8jPcriTSnbo8W6IlnISzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026314; c=relaxed/simple;
	bh=NsttH2H1tTIziuJ/Sox01Avh2nZ2Bn/nT5IuGy9CR3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFKUKR9j6Daqz+IGEjAB1vI92G2phPUUxl1XmI6AtbAzRyBpouLNok09g2AzRXfgdblxvNYCpQ56HQObV+Xa5FTQ/YH7xNYAa+HNIj6vBT5L4N/yq0cNk2iPfqnBSgo9Ln33WtrfVAHUKEA8KW96Cm+BDHLYzNVcawOvj12ANPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dvG3r7o9; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c458cef6272d11efa22eafcdcd04c131-20240610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VQGZ1zUp5zV8bRtMR4KUV+3pZEPO+/wvOdVlhuvTtRE=;
	b=dvG3r7o995lrPyz1k85Aa1K5MWfHzVR00zD8kxEdes1ntKzgIR5CxijoR/bpAheAJ2lZpbbgO5BgeWI/8ad9n1I2XL5jZlqN/FotckxhJfOb7vdcx8Ok3SXXlGI/W/2mZESlBvEZppRhqLNrvHqbf7dvlevKnZdr8qJxoALZunA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:55cec7e0-90c4-42d0-a532-4be15121a3f9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:5947e984-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c458cef6272d11efa22eafcdcd04c131-20240610
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <phil.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 725074320; Mon, 10 Jun 2024 21:31:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 10 Jun 2024 21:31:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 10 Jun 2024 21:31:37 +0800
From: Phil Chang <phil.chang@mediatek.com>
To: <anna-maria@linutronix.de>
CC: <alix.wu@mediatek.com>, <angelogioacchino.delregno@collabora.com>,
	<frederic@kernel.org>, <jy.ho@mediatek.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<matthias.bgg@gmail.com>, <phil.chang@mediatek.com>, <tglx@linutronix.de>
Subject: [PATCH v3] hrtimer: check hrtimer with a NULL function
Date: Mon, 10 Jun 2024 21:31:36 +0800
Message-ID: <20240610133136.327-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <87bk496seb.fsf@somnus>
References: <87bk496seb.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

To prevent improper usage of hrtimers and avoid potential kernel crashes,
this commit introduces a validation check for hrtimers with a valid function callback,
discard the hrtimers that have a NULL callback.

The `run_hrtimer` executes callbacks for every hrtimer,
and these callbacks must not be NULL. A NULL callback can lead to a kernel crash.
This update ensures that all hrtimers have properly initialized callbacks
before execution.

Signed-off-by: Phil Chang <phil.chang@mediatek.com>
---
 kernel/time/hrtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 492c14aac642..b8ee320208d4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1285,6 +1285,8 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(!timer->function))
+		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard
-- 
2.18.0



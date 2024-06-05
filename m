Return-Path: <linux-kernel+bounces-202027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D328FC6DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE080B213ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79971946C4;
	Wed,  5 Jun 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LEM1Pm0o"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A51946AD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576928; cv=none; b=ZiFnAcTfAp0+dE69TklIDokDcQKHZ+0LF24FHzhRvjDdTIQI6pWSidynQjHDcv04VtyWbAScpCmMOI1TXUxcAdRLptd99YQBHZofn08m680a5wIwfXzln3dh8PqcuIQsuxuscKVVjEsaVGU7L3Lcg+V+DE6/1XCsiVGGWyeM3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576928; c=relaxed/simple;
	bh=bv5ccVG7t7ykGZd3BstFBCtxxsj8RWsfTWmb2ZXH3Ak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hh+mz8KtLjIRjYxYLgIyhTIiHWXMempiR+sLIg2vcvC4wEpWuS1O+TAvVFaX2oHcET4gFbY89hDtnoCsxpIC5uEJI8F7P/t+yWhaHbtdS1t/AW6WLD/l3WpzTxiNtg2RG0xkERE6c2spIdJiCsIFAze9DsaUi2fO0WPzyRWOwV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LEM1Pm0o; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7643c79e231711efbace61486a71fe2b-20240605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yJOhU36Sulck3XKLceCGLLYHOWWD2hegzqpiQV7qmlA=;
	b=LEM1Pm0oEJyaMCjJ9gWbRxQpGI/IbWSizTz15yBrUrOogz4YA3pbl6bVg/LFisE/awRm49ehb3TDVcv/IW/Ec/1wWbf0iTchxSJbMNqdOu76oRgGqfJdQxewdXra0hfQH8Q4TcYHQZl+YtVmDQbdfaza8ZB00I0SMTPPTHpDYnM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:e869c2d8-f886-4d1b-8cf3-add9f2d0a750,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:dd713d88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7643c79e231711efbace61486a71fe2b-20240605
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <phil.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 159291805; Wed, 05 Jun 2024 16:41:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Jun 2024 16:41:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 5 Jun 2024 16:41:51 +0800
From: Phil Chang <phil.chang@mediatek.com>
To: <phil.chang@mediatek.com>
CC: <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<jy.ho@mediatek.com>, <alix.wu@mediatk.com>
Subject: [PATCH] hrtimer: check hrtimer with a NULL function
Date: Wed, 5 Jun 2024 16:41:49 +0800
Message-ID: <20240605084149.6420-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.213600-8.000000
X-TMASE-MatchedRID: iX1jgSPyW0MyRohotsnq58nlbo5l7mGFIaVkFIrQFhvIvQIyugvKdTcG
	i0cOVVas3BlBvFCka9vSwA55kcDk3AQmkMsZWj5Btw+xHnsmQjPt/okBLaEo+PGdmr05lx3uh29
	kdZ+JxXd6wzwWse0GPMTTRBeQbHHJ4X8HWMSNX7obLGyK+CyynruesBT0pDFRr3/jxaIcqUijxY
	yRBa/qJcFwgTvxipFa9xS3mVzWUuA152LecOHHIwca30uf/jvRgPl3osVJSN/wVkpD0xi45QwMz
	A7WoSpZ1xb9AUchuK0SYeEaauBUU2dWz3iro9yhm+i9Sq1gE3ZVDwmeFLwirS9GZyhImPsFdmtR
	sRmKkASJZPT2ZDPuzPD2QfzMDLjho65UufHcDvg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.213600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	62FD71F87D3C8F06B47FFB7EE4A3A63358C9398A4C51ADBED4F0102CDBD008D22000:8
X-MTK: N

simillar with timers, check for timer->function == NULL.
If the pointer is NULL, discard the request silently.

Signed-off-by: Phil Chang <phil.chang@mediatek.com>
---
 kernel/time/hrtimer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 492c14aac642..72d6e7bc9cd9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1297,9 +1297,13 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 
 	base = lock_hrtimer_base(timer, &flags);
 
+	if (!timer->function)
+		goto out;
+
 	if (__hrtimer_start_range_ns(timer, tim, delta_ns, mode, base))
 		hrtimer_reprogram(timer, true);
 
+out:
 	unlock_hrtimer_base(timer, &flags);
 }
 EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
@@ -1667,6 +1671,11 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);
 	fn = timer->function;
 
+	if (WARN_ON_ONCE(!fn)) {
+		/* Should never happen. */
+		goto out;
+	}
+
 	/*
 	 * Clear the 'is relative' flag for the TIME_LOW_RES case. If the
 	 * timer is restarted with a period then it becomes an absolute
@@ -1710,6 +1719,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	 * hrtimer_active() cannot observe base->running.timer == NULL &&
 	 * timer->state == INACTIVE.
 	 */
+out:
 	raw_write_seqcount_barrier(&base->seq);
 
 	WARN_ON_ONCE(base->running != timer);
-- 
2.18.0



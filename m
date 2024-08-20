Return-Path: <linux-kernel+bounces-293281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D4B957CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F038281E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4474753368;
	Tue, 20 Aug 2024 05:54:41 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D248C1BF2B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133280; cv=none; b=XfnKdVa831W0jsc1mfW0WJyTQYio6kqQr4p+PyIQ5BKl2PBGyUUfIxQAij+B0xbzaJcU657QtHshak8TpFyC4nbGXhkvd7cHKpucXPrEOUFJNgIuUhoVzUcuDpNPzwMZ8Wz7QduvdXRa1EBFTPr69qEg5crGs9kt6v03bK+pMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133280; c=relaxed/simple;
	bh=3HeErADYDGIN4F+k/n48krz9TH9MCVLFuwmVLC3rRCY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OnnMIeUQqKdWeHGkzjgo/S/7hzfbGhAI1/T/cdpf78wcX4pzijblphnhcVWWjAXZPMsu5PTH+qjlkmWZpDM7D253edvKREvlaY2VfBzx6i/39yj+cKUxCHlTS6glhSewqM/79I3hpnXJt9JzGt0N3pGP8sH5CuzqMsbTlhbIzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866c42edb17c-a41ae;
	Tue, 20 Aug 2024 13:51:24 +0800 (CST)
X-RM-TRANSID:2ee866c42edb17c-a41ae
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766c42edc1ba-f7350;
	Tue, 20 Aug 2024 13:51:24 +0800 (CST)
X-RM-TRANSID:2ee766c42edc1ba-f7350
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: song@kernel.org
Cc: yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	zhujun2@cmss.chinamobile.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/bpf: remove unused variable
Date: Mon, 19 Aug 2024 22:51:22 -0700
Message-Id: <20240820055122.3769-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The variable is never referenced in the code, just remove them.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/bpf/runqslower/runqslower.bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/bpf/runqslower/runqslower.bpf.c b/tools/bpf/runqslower/runqslower.bpf.c
index 9a5c1f008fe6..fced54a3adf6 100644
--- a/tools/bpf/runqslower/runqslower.bpf.c
+++ b/tools/bpf/runqslower/runqslower.bpf.c
@@ -70,7 +70,6 @@ int handle__sched_switch(u64 *ctx)
 	struct task_struct *next = (struct task_struct *)ctx[2];
 	struct runq_event event = {};
 	u64 *tsp, delta_us;
-	long state;
 	u32 pid;
 
 	/* ivcsw: treat like an enqueue event and store timestamp */
-- 
2.17.1





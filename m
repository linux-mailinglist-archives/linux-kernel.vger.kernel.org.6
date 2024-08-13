Return-Path: <linux-kernel+bounces-284877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A152B95064E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EF31F22764
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8135119CD03;
	Tue, 13 Aug 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="idiuLaVw"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41A519CCF0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555185; cv=none; b=REco3q+ftmihxvj1aia/E8IoIrJGT3PnWqghUY7d9RJSTQLn4grljA8UBfy8SF2igUDiN/qgpLJaOR2gK9pdCz1NTnJ7gpVhfPZV11xS2Tq6gLzrNsirY/kU5UEX86z81f2wc5FFGKclvXVTj6JNVy4nOlnHZrhjc/b57VzgizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555185; c=relaxed/simple;
	bh=ZMGTy6L5ameQtkF0U00DXCC0w5avqUDwOcTxgkwPhVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ofgoQvId/Ixx3Anmuu0uW9yfZEpnCd7/NG7Ui4F15N93darPDq/hsovorwPPCBTZND/CiAj+erVYIXZfSvk1Vcvbl1xGlGK9P+O5E+whnVqEZhHIgHocsM3HB+ggf0uPM+355uhNefCiRxP15DNRu5NB3JPsiZXpjXoyp5vrtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=idiuLaVw; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5hybL
	gfjPzD38zj1PtzkVJO3sqnNe/5QU/Bs5Yqk2sA=; b=idiuLaVwMGrNU9YRKIyRw
	3gUvgNDcCUPOw9G+qS4UOVb8/kLTGnVEPt7+UmMHjud3G4trIUP+aVH9DKewjjAC
	5Tnk9TOZr8hGXAueU6mFPC+SaT/LoqJ2Coxkte94syjLxv+7nd4LyIv6Y++SfUR+
	D15W5JK6f8bpwp0CWpkuAA=
Received: from localhost.localdomain (unknown [113.246.65.153])
	by gzsmtp1 (Coremail) with SMTP id pSkvCgAXj5krXbtm_V7cAA--.37546S2;
	Tue, 13 Aug 2024 21:18:36 +0800 (CST)
From: Bing Huang <huangbing775@126.com>
To: peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH RESEND] sched/fair: Remove stale buddies comment for last and skip
Date: Tue, 13 Aug 2024 21:18:35 +0800
Message-Id: <20240813131835.2747-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:pSkvCgAXj5krXbtm_V7cAA--.37546S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4fKFW3AFW5Ww4DXw17trb_yoWDGFX_Cw
	nYg3s5Gr10yr1agrW7Gw4fXr9Yqay8KFyrZ3Z8tFZ7t3WIqr98JF95CFyfWr93Gwn2kF4D
	Grn3Was29F18GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbNJ53UUUUU==
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbimgw6r2VLdDSBDgAAsi

From: Bing Huang <huangbing@kylinos.cn>

commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") has removed last and
skip. Modify the comment accordingly.

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..383582f87def 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5466,8 +5466,6 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Pick the next process, keeping these things in mind, in this order:
  * 1) keep things fair between processes/task groups
  * 2) pick the "next" process, since someone really wants that to run
- * 3) pick the "last" process, for cache locality
- * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq)
-- 
2.25.1



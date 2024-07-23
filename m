Return-Path: <linux-kernel+bounces-259968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E493A092
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5161A28372D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199D152511;
	Tue, 23 Jul 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="moGBIpDx"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616914EC77
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738537; cv=none; b=a0r1/CCFDBdYmWtUR5pkiIULsXS40vd3s8Ijh1tfA/Mr/67/W/OOMDhjgZQQQ6dGy9XIbcRO1A4EjOE+RbCQY0XJydGFlJkaul/pbk3Mx6KaEhgf3Oo9v9ZvKNBh2DcftW0R4hlOqDaT8b10+TKjNvJmVyWFkB2o39Q7rxp5keU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738537; c=relaxed/simple;
	bh=ZMGTy6L5ameQtkF0U00DXCC0w5avqUDwOcTxgkwPhVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OoCIqGM5WzE8u1PAn6gO+T9E3UwFFP5u6e5qUYQidLctHKCNgSX5z4apVvPB8jo3wyITrnEN//nLgZehLhhIaN25CgRqqX5cSw1/Jj+JPu5B6HIMYVzoCD6yTatx96wvtyvz+xKZRuVNouk58tzPgF45cBVr1f6S5cQk75gOKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=moGBIpDx; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5hybL
	gfjPzD38zj1PtzkVJO3sqnNe/5QU/Bs5Yqk2sA=; b=moGBIpDx0vUfH9an+rT7a
	O4omCQKT6EW/u3FxGO26RcexPGMD4q2fIn7ZLEzWr7zaj+/T+NFYpJNupjVnHMBt
	7XHOlBQUDpzf0V3+G/dfudgt1Py8odByi8i00gZeRcnEXmYuX55pgod3ukZE2w0/
	vOx/v+tn8UkCpZRlD8xqA0=
Received: from localhost.localdomain (unknown [113.247.46.246])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wDn76NgpJ9mVkJbAg--.40445S2;
	Tue, 23 Jul 2024 20:38:56 +0800 (CST)
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
Date: Tue, 23 Jul 2024 20:38:56 +0800
Message-Id: <20240723123856.3852-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn76NgpJ9mVkJbAg--.40445S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4fKFW3AFW5Ww4DXw17trb_yoWDGFX_Cw
	nYg3s5Gr10yr1agrW7Gw4fXr9Yqay8KFyrZ3Z8tFZ7t3WIqr98JF95CFyfWr93Gwn2kF4D
	Grn3Was29F18GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbuyI5UUUUU==
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbimhwlr2VLcpe2hgABs2

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



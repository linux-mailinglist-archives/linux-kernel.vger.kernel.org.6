Return-Path: <linux-kernel+bounces-544419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934BDA4E12C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E834E3AF2FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84702080C6;
	Tue,  4 Mar 2025 14:27:30 +0000 (UTC)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424C205E09
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098450; cv=fail; b=oUuYN7Oi65mroj3aRBYrOfm9OFdJkxE3nIIBD/B2Hm8IIB416JjEja0B4LhaFYEXcRo7VTkxnq2hvP2H4VLD2a/6VOY8DacDIXHHWhDfxkP29bIBmB9N7MVY4/UHekl8OJ4T4iofN8Y1WERoJ7vwIUp/YkhS5DK1ayp64QKxlhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098450; c=relaxed/simple;
	bh=8QX7RWrogIG18kfd/R+4GHcCr0GMIY/ERbfbHMu9raE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOB5OOwepafSuoPYnzYOVOdjBdOAsYePfIJ1LZdvWnPJMJobeVjZsTHLKbgL3Xh+JsTA6KdgcBeo+OMi2TE3zLVCj6M+siBz2RC1jrX1/NFaNrK0cfKXITwpjOqeShUlXoERgWtd9wZvd3YyBmOKKdDGdlY81HeSgRQua0OkO8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=222.66.158.135; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 3D35240D5705
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:27:25 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dJR6lnnzFwdQ
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:25:43 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id D24914272A; Tue,  4 Mar 2025 17:25:34 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541453-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 1095142216
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:58:24 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 9BAD03063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:58:23 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557D63B60A9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62E51F9A8B;
	Mon,  3 Mar 2025 10:53:43 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8E1F30B3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999222; cv=none; b=uT5ze9QnTU2Nx5MjN/wXjImae68JhvNlVx/8+TK4Uf0tMFvIl2tKZOpehGUQWe36dsc9HcoV4dQPDXXqK3QLDKudbta9sscL34CegTQvxNfeL93BPLrfgmL8gPeJU0wpqVJGRp2TuxR/b9wR05ScdJiJNha7HQ5aUJ4NpQq4tNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999222; c=relaxed/simple;
	bh=IxLafNvvFttrmOiNrSQRs+lSseO4cQaIwe4/IL5N2Gk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcOSPehZwhWR92LWY0r5QH4TOv1V2GALCEwERVL5cOz+MLcuqeqmS/sC5J3DCfxuUeOr5uu2PYwB0YDjjvwBZ4KXnbtDJ4piTd04zogqEmsozbpnacPQnox02rVs0ffztay3T3VvkESKN7olBwsgPYXU+ZaSvOm1R/lwvAbTxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 523ArPdi092378;
	Mon, 3 Mar 2025 18:53:25 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Z5wXR4r0zz2K8nM6;
	Mon,  3 Mar 2025 18:48:39 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 3 Mar 2025 18:53:22 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH V2 2/3] sched/fair: Do not consider the sched-delayed task when yield
Date: Mon, 3 Mar 2025 18:52:40 +0800
Message-ID: <20250303105241.17251-3-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105241.17251-1-xuewen.yan@unisoc.com>
References: <20250303105241.17251-1-xuewen.yan@unisoc.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 523ArPdi092378
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dJR6lnnzFwdQ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703160.70991@wHEIEBjdU72t8ccWz6ir8Q
X-ITU-MailScanner-SpamCheck: not spam

When task call sched_yield, if there is only one task in rq,
it is no need to yield, however now, the rq->nr_running include
the sched-delayed tasks which are indeed not runnable tasks.
So sub the sched-delayed tasks when check the nr-running.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a354f29c4f6f..8797f6872155 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8992,7 +8992,7 @@ static void yield_task_fair(struct rq *rq)
 	/*
 	 * Are we the only task in the tree?
 	 */
-	if (unlikely(rq->nr_running =3D=3D 1))
+	if (unlikely((rq->nr_running - cfs_h_nr_delayed(rq)) =3D=3D 1))
 		return;
=20
 	clear_buddies(cfs_rq, se);
--=20
2.25.1




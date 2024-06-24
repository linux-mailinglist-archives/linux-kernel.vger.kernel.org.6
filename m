Return-Path: <linux-kernel+bounces-227429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517DA915115
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AEF1C2460B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E119D08C;
	Mon, 24 Jun 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QQ0wBYMT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VSv9lJ/A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E7519D063
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240861; cv=none; b=A/uilJcuSyxJ/faVYmMweYe2EHcVH5DqTfebgExVGeiozEHmqvtB4A4CdnyqaGh0sWc52vPPQkF3Z8m0hmeTRm8zmvzOfMfpsV/gUPbfj+I8pWZl8qUOojVQr9NqCkN2PoAL1vX/8fiycI/jpC/lAhdAtYUyF+JVNv3ikkssFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240861; c=relaxed/simple;
	bh=NzMYnlU25XlcmunTuNeMNqwHFYLTvlMOwqg3Y6KHY+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmzHSuwmRQJT/dLv8crVN6mlruP5sF9xvXoswJhAD06oOnKRfAm/W1GxloGlmLnSJp64YoikW1r/Jpga+fFHnfORyFimyf10tyEMvWplMorKOv7ucUdRIQ5wqTI2T+HqRYIYP1hznjO/m16V/2f+YYyPdFWdCQAedCoyrsaU6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QQ0wBYMT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VSv9lJ/A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719240858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRwb6bZH+C76mHYt3MDxKdtn1jFC4cvRGSrCMq7mXCs=;
	b=QQ0wBYMTwJkEyIGivDQrQWLyruVTMPFqOMVSxCuskrTXzawKRI8IUPns3iq/cbrNfeD9Dw
	Q9AcAziqyRdx27p+8QJwGv9vWCG3edDIFVwGJVuOOgczvNLnFYc19G2ZzxgFwonhkO0UIh
	KQdvZOgtAAhgdku2aWE4qrRrxpAVT1iqQr5LvtS+Sqaf63qVuszFZm/1I5kRgLbC9uDJ4z
	CmPHqQ0mzj8gwcYa5GezxlzHSiwIPSJoBD7U1gWtGQ0FtCBoYlbV5ms0VqeXrjYmc1a81M
	VynFhsNGvVYrvj87umCXeYWtp1bJbpVbZtZszR5LnMoX1M/VWg3D0jFei/VcqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719240858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRwb6bZH+C76mHYt3MDxKdtn1jFC4cvRGSrCMq7mXCs=;
	b=VSv9lJ/AQDL1mSFpFZbJc4viptpvb+gqENT54ulqh3u4MfKJXaUAA5DiYpNnWgwjTa/5x6
	Ym2ug4XstfGgpWDA==
Date: Mon, 24 Jun 2024 16:53:54 +0200
Subject: [PATCH v2 2/5] timer_migration: Improve tracing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-tmigr-fixes-v2-2-3eb4c0604790@linutronix.de>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
In-Reply-To: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

Trace points of inactive and active propagation are located at the end of
the related functions. The interesting information of those trace points is
the updated group state. When trace points are not located directly at the
place where group state changed, order of trace points in traces could be
confusing.

Move inactive and active propagation trace points directly after update of
group state values.

This change is also a preparation to be able to split out update of group
state information easily into a separate function. Which in turn is
required to fix a possible race in setup code.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index d91efe1dc3bf..600c9e866fae 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -656,6 +656,8 @@ static bool tmigr_active_up(struct tmigr_group *group,
 
 	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state));
 
+	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+
 	if (walk_done == false)
 		data->childmask = group->childmask;
 
@@ -673,8 +675,6 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 */
 	group->groupevt.ignore = true;
 
-	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
-
 	return walk_done;
 }
 
@@ -1306,9 +1306,10 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 
 		WARN_ON_ONCE((newstate.migrator != TMIGR_NONE) && !(newstate.active));
 
-		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state,
-				       newstate.state))
+		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state)) {
+			trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
 			break;
+		}
 
 		/*
 		 * The memory barrier is paired with the cmpxchg() in
@@ -1327,8 +1328,6 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	if (walk_done == false)
 		data->childmask = group->childmask;
 
-	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
-
 	return walk_done;
 }
 

-- 
2.39.2



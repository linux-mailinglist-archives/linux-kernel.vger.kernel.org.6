Return-Path: <linux-kernel+bounces-398585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9AD9BF328
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764E91F22D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784152038DF;
	Wed,  6 Nov 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="poQGc65H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zro7LkBK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426D204080
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910293; cv=none; b=YGZmSMLw1qg+KTTgSjCAqNx0DqxSWLEDCIUQiovlIRaj9yoMkLl76LJmHfEhwbShz8l15GQrKPAhjLSaPZzc7cg9uL5T75ngP0A730BFQB3BPCzQO0Z/YsFuncA2xUD1fwxLs2rcOaZF7n8tUe0WBjhQsyaXwt8KKpsxkhmJrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910293; c=relaxed/simple;
	bh=j+pW09KlCfHgEwChtrQmLqJdAkLRMYqlpV0/EVc7ZLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rZrGjHtk/afgIP488p5S/fjmrd0NIVHM2GQf0tcaNU8ZebEx+0jUrxvOftFn8cfS1Rg3HdH3Wr2L/BFhO7FNEB1QKTOukGDbl+XRYjvhowKW38AXg1FkaEkOWvvtf59z9M2rI50gAdFuxf3NZfiAbkQdv8xGgfjfDoRuZkcxKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=poQGc65H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zro7LkBK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 6 Nov 2024 17:24:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730910290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GQrCrITldNuGCh3c3Ejb12ZGNxCVfnc9RHcU2GD5HLk=;
	b=poQGc65HMQGUGapZ9yh/65RCv1kODx50O20Nv1oQu+PK940ewfU2PcEEAqYD+JGjNMOKnZ
	HKQACrXsQrCJiraFwhM8p6ouIVNVMpBYu95nTC6ioDIfsPy20K4dvJQArrKax7NbY1/bs3
	CuIJxG9CvBTUl5gh+YJ3olvKq2zTYJDWlm0KnR0eugsyYUPVsC+UryOQbutc0xy9fy11jF
	2jIxgYmRw4Ptdo5jCfOqzNpCKHyvJhEv8beRfAQItLgQJxYgLn3i75M5p/z7Iuj0VHlNvJ
	EQhldFhGRkkgC894322ES5j2LdXYc8N6gPrkonbvxVG6vRB1HPd1FyymyEGeMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730910290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GQrCrITldNuGCh3c3Ejb12ZGNxCVfnc9RHcU2GD5HLk=;
	b=Zro7LkBKYLG97v403vx8LrSvV4S/YDhDsJtr3rwqjwkTBXT1v85d7arMrHDacStqrVSGfQ
	bb6yViZ6NzJYHLCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH] sched, x86: Update the comment for TIF_NEED_RESCHED_LAZY.
Message-ID: <20241106162449.sk6rDddk@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Add the "Lazy" part to the comment for TIF_NEED_RESCHED_LAZY so it is
not the same as TIF_NEED_RESCHED.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 75bb390f7baf5..a55c214f3ba64 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -87,7 +87,7 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	4	/* rescheduling necessary */
+#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling needed */
 #define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
 #define TIF_SSBD		6	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-- 
2.45.2



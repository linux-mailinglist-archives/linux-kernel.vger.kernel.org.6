Return-Path: <linux-kernel+bounces-355337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E789950CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8148AB276C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C151DF73A;
	Tue,  8 Oct 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+1W7Quw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NSR4skyB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71C26ADD;
	Tue,  8 Oct 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395870; cv=none; b=HX14u+EouBAOn1iEkZlarHLqFaWJbyH00jYILRfRmbEss1dS/rTmx7ZFw0iwUqQo6AaUSOHKrnVT8IbULjdk9aufgrRfI/otlhpMeSPGPC6rDeZy0+uiAHgVPV4gNl1bgW+M4FxM5MyTUU+peQr0Fxfk//wP6BkiGZnut3FEhZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395870; c=relaxed/simple;
	bh=dgqlCo6djy+sBVeKf7V93rVMuP1WNL+lntFf1aIDEXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l3EQ8YaOGoMGNEuv3WNEhvAmGeqbUIuFahyMceZsHWbOLYPWeZzGF3GZPIQF3qkmBoV2xTKJ3SJrhIn7JxNT+N0yoVLERMWSiladez5A6YFsYF9+KXyzNLC18zJStfN66MOjwHYMjn6RljSmXkrI4M6ju2dshHXJ+gY9/sKfyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+1W7Quw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NSR4skyB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Oct 2024 15:57:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728395867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mTGesulOIN7xlBlbtZ32fMZsDu5BhOC6CvYlt9xD1bU=;
	b=D+1W7Quw7lLiMEY8/MtTDRpTY6pEUZA3Dr9todOncwQOdl/q5JSrJh/RXBs36SRKX4sOKH
	sFnkA55e7EDqvTVH0IxfL+P5beZguYH60bwTg21/ZOrIE5tdfxQ0BHmjAN21Zt0NJ/J+PJ
	FOfmyfxr1Ro43UaFvpm1WLMeRJwHZBYnLyFc8YUGt0suRotq6tUQJLIsxbEH8koR8YMbo2
	83uwBadND09PRQxoBrCbfNp94CXaAnU0Me67hSqBtVmOH1TWuuRYg0oOvPGb6Gr8jp9KdH
	dTnGVcBNW6QqhJtEqN5z3WPbDx7Tl/ZhFWiu+mDx7bdNxP9mtnEQ14zQ6dgMqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728395867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mTGesulOIN7xlBlbtZ32fMZsDu5BhOC6CvYlt9xD1bU=;
	b=NSR4skyB8geCONZb73pvKel3gvlDpgqOybJRPAq/SUMMKfWowadZr8Pa8u14DiOqB60enu
	xtaWn5baIx+PXdCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] alpha: Make thread_info::flags unsigned long.
Message-ID: <20241008135745.Ndzf7UIa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The users of thread_info::flags such as test_and_set_ti_thread_flag()
expect 'flags' to be an unsigned long but alpha is defining an unsigned
int here.

Make thread_info::flags unsigned long.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/alpha/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 4a4d00b37986e..913e6ddb09d3e 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -16,7 +16,7 @@ struct thread_info {
 	struct pcb_struct	pcb;		/* palcode state */
 
 	struct task_struct	*task;		/* main task structure */
-	unsigned int		flags;		/* low level flags */
+	unsigned long		flags;		/* low level flags */
 	unsigned int		ieee_state;	/* see fpu.h */
 
 	unsigned		cpu;		/* current CPU */
-- 
2.45.2



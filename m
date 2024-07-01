Return-Path: <linux-kernel+bounces-236471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B202691E2BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24941C20D71
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EAB16C846;
	Mon,  1 Jul 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wmt1HGVA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UVmXqcr4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114216C69E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845297; cv=none; b=W8zhHbrNKXqvlLvTukBU19AmzvRnQwYOM1kHwsis75T1tZfujblKBhOHCL/45yt+JJu0RYVfdHuUD8QIHHVaJaGM5aqbsjsmJdSBq0Jj8U1PyVDGj0KSnGw7IzkNKvP3t200IfWWeHxGjqogK3EIa2MVPP0lsqGgPoHYk9fDSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845297; c=relaxed/simple;
	bh=uPYmhri3xmLQXRSCzKBJCGTyjaB0QtlZdBJLGjE5stI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckSrHMewnCRhr90pUaTjcUGYwSfouT4OmtFfWx69py+1f//7Tu3RJ3N+5/AXTuH4iFnWNRZw+8mQWs9k13eC3IVLC6kWuwt7niFzGRashcF6eC9iJIxrMlPLDTZ/+TBH3/NWFvlR0OS/o/qET/CJ4kdnzdrRVHU6vX+NuG/yVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wmt1HGVA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UVmXqcr4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719845291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjJI+Isbe1o3BN2CZY4+tqaGo4HhsuAYWg7sVXb7zMA=;
	b=Wmt1HGVAaQqdjkytzlE/WlFf7j3FUWnyMzG4KA1Vr5t+Tvay6YnKw/iWGxYzEkq/U8xezi
	EsyeEuUlbqMSR8yZDL4j8fXVERJy12ADJh4btwf0GolKFwP9IFMc6Veu/vQW8IDxjJF8C8
	ruC9Xm11oR9SXHJi/3uuVIbNRVSjrrIZVwdu1Dkx1ePNXmFPn3jmhTr4Jvah68PqcbPCcP
	eeIjJR+dhRnkkUbQO+Cn+qp9bK3fgE9nWlLarOKf2jjGDbdHb2hWPoQ8rnuPl0rL0muJNv
	IIuPDn6P0x+yCdnQBv5rMRwWTmDAC/TY9LqUK7XH1fsEZ30Yr69MHooBmQa7yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719845291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjJI+Isbe1o3BN2CZY4+tqaGo4HhsuAYWg7sVXb7zMA=;
	b=UVmXqcr4MTFXkLc8dG5U7eqduCyNN/yQp7ohWZyHReHfnFJjmq4+1oed3OTWrKMI5ZVDer
	Zdqr542sssNqqGCw==
Date: Mon, 01 Jul 2024 16:47:55 +0200
Subject: [PATCH 2/5] vdso: Add comment about reason for vdso struct
 ordering
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-vdso-cleanup-v1-2-36eb64e7ece2@linutronix.de>
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
In-Reply-To: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/vdso/datapage.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index d04d394db064..7647e0946f50 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -77,6 +77,10 @@ struct vdso_timestamp {
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
  *
+ * The ordering of the struct members is optimized to have fast access to the
+ * often required struct members which are related to CLOCK_REALTIME and
+ * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ *
  * @basetime is used to store the base time for the system wide time getter
  * VVAR page.
  *

-- 
2.39.2



Return-Path: <linux-kernel+bounces-559856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8ADA5FAA5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0255189B62F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E58B2690F9;
	Thu, 13 Mar 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OCQH7Obx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="teH3p7U7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1CD2690D7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881585; cv=none; b=f5jgZ7zPkPvXX385XC6fYWgjEDCt9nEx8ZPa5pN6kTQHnsJ+nnY30VNvFjH8Gueit4BKv623ho57gSLI6ilf7OGiQTHSeCx2iQOnqAYvwoqf5ljsVWJRNZMAyIQIlotkFExdId9HCqW9h+QwtKf/OvwQTKoFkmIXdv4lGrrEvJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881585; c=relaxed/simple;
	bh=qmDjoX8h7NEB+eT+QeAl4QsgBucU40XmMm5U6V0gatE=;
	h=Message-ID:From:To:Cc:Subject:Date; b=dE9uETB9Q79J0Pk6qc01IaE74D7/CY5VwL6QvTCRW+DJ7FdLeZeCSRRFtGE3HSaHCYBfCWfy/pHPCZ7RWYtbLWAncOyWUNZtgjb/zJTgWLt1kGnp2umeo7OF0wcN6bJP4KTyFgUyMDO6BZYAXYYhBDvfT+C5qH0USjGKApU/JJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OCQH7Obx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=teH3p7U7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313154615.860723120@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=pC5u9IABiaLSzqnFooP5hA+9dFjsd9YXaN72QMClq10=;
	b=OCQH7ObxZUU6lnkrIcTfdQ8HDsvfirXW75Jxkidk+zO+7PNuDhq8pzMsWsO41A3GYEZMaN
	79BWoZ3+9gTKrqqt78CmtuRAnWqcq/jRT0cQh6wkuiU8sOJJ2yWtDqyBLBUhgOA7zmxOO9
	oELoQtxv9fNyRMVHUEsJwDF9xVEuCkhFSxFt+78Tj+OsLUPCKGLV6Y/4XxLo0gVUbeMK2w
	81iAr/oOQ58IiGqB3pf/tsJQ6w7w7oKsv8UpRsxj5hBaQJhx59IDB/uM3qyVCatkSnOrwT
	NNkzb8wMvaFqKBQNAPHCY44wuInsscFbz5frCzOBZc4abqctXTxfJuaZyJ19kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=pC5u9IABiaLSzqnFooP5hA+9dFjsd9YXaN72QMClq10=;
	b=teH3p7U7E0QN1oYeJxEiAlmy7/bx6AAh+KJ8Nps7uujVf9OteziRBzJNougoyY+MZQW3a3
	d5hyy6s7odsrg6CQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 00/46] genirq: Cleanups and conversion to lock guards
Date: Thu, 13 Mar 2025 16:59:41 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The generic interrupt core code has accumulated quite some inconsistencies
over time and a common pattern in various API functions is:

    unsigned long flags;
    struct irq_desc *desc = irq_get_desc_[bus]lock(irq, &flags, mode);

    if (!desc)
       return -EINVAL;
    ....
    irq_put_desc_[bus]unlock(desc, flags);

That's awkward and requires gotos in failure paths.

This series provides conditional lock guards and converts the core code
over to use those guards. Along with that it converts the other open coded
lock/unlock pairs and fixes up coding and kernel doc formatting.  The
conversions were partially done with Coccinelle where possible.

The series applies on Linus tree and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git irq/core

Thanks,

	tglx
---
 include/linux/irq.h     |    2 
 kernel/irq/autoprobe.c  |   26 -
 kernel/irq/chip.c       |  640 ++++++++++----------------
 kernel/irq/cpuhotplug.c |   10 
 kernel/irq/debugfs.c    |    3 
 kernel/irq/internals.h  |   47 -
 kernel/irq/irqdesc.c    |  136 +----
 kernel/irq/manage.c     | 1154 ++++++++++++++++++++----------------------------
 kernel/irq/pm.c         |   38 -
 kernel/irq/proc.c       |   65 --
 kernel/irq/resend.c     |   50 --
 kernel/irq/spurious.c   |  104 +---
 12 files changed, 920 insertions(+), 1355 deletions(-)


Return-Path: <linux-kernel+bounces-272829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4143F9461AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17B9283301
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B21537CA;
	Fri,  2 Aug 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w5bsSDi3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9PNULkK7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713651A83AA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615342; cv=none; b=dTeH7QAwfQ5RVpS7HH2YF5v8LzSXgMsaHpCVgWfHxufUK8qIEEfv4SX0OSJ3BDaS2qCcNsf7UTyi2ucu0y79bijJ+Uu3RUpRNWhaUkHpOI2sJSloYcMxQuXdZ+bxSOX7v0KR41GL+5CoDwQPb4SFXOt6U00e6aGkhZ28mXiGzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615342; c=relaxed/simple;
	bh=d+Wiu8zj79HL9B1OsDzwAdEN4qtriV/hYO6wjALllFs=;
	h=Message-ID:From:To:Cc:Subject:Date; b=jFx1ZPXWZrwsJt+cAdB+pl519jeyZt/H8sXgX7cYWoCfIrn0fLGz9WfqnF1M/cGIzWmiLuCZhsByqLwK+7pMt9QuuMf95V+JIvaKw2i9I1fSdnKFQI0Rxwp7k7qKKr7GPa/72S5VxRnAPC15unnE280XBUO1AdG2f1V/0KpYRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w5bsSDi3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9PNULkK7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155038.556977544@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=mBU4ZREADs/ltFLjgBjHawWJcRxXOFRrTGK3zpAADkM=;
	b=w5bsSDi3vL0w/dUf3/D4JctLrFMcG+GpSvzMVMKFgSNXHckLcWkdMvZoC0BEcLpojumeCK
	OXHRJMGPPmj77+FUSn7+MN2velTbIRFYjok7CR/Q3kMp9vpYWXPesgiY3VPiaQtzp569G+
	/ZSFT3SbAaBnWBsYTYDS3zHb2dE6Tz7SIU9fRfY2WuCtouQzZ9lJQ0btjrgu334JCHl9Qn
	xY+0r/W5ug7Q3wX8KTwwC1PtVRsiObhaFcUESqrfSAQDlVGuAj2SW4LuIIRk4HWnsBJtKd
	4g9WoF4svkrUs7pl/n+UUozYiQF1Dn6fppzI0IOsiDjfgRsCUiNabHmhdBnMZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=mBU4ZREADs/ltFLjgBjHawWJcRxXOFRrTGK3zpAADkM=;
	b=9PNULkK7HkUiN7tN/cMq+3wgxtlePqM+gcaMh3LfelPqVapa9rMD4Lrfcncdr2+j7cyNGU
	cZNdgRy8FuBoc3Ag==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Breno Leitao <leitao@debian.org>
Subject: [patch 00/15] x86/ioapic: Robustness fix and cleanup
Date: Fri,  2 Aug 2024 18:15:33 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Breno reported a panic during testing with failslab in the IO-APIC
code. This is a historical leftover and can be handled gracefully.

While looking at that I stumbled over quite some historical leftovers of
debug printks, overly big comments for trivialities and a pile of coding
style violations.

So after fixing the failslab problem I just went through and modernized the
(IO)APIC code.

The series is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/apic

Thanks,

	tglx
---
 arch/x86/include/asm/apic.h         |   33 -
 arch/x86/kernel/apic/apic.c         |   81 +--
 arch/x86/kernel/apic/io_apic.c      |  749 ++++++++++++++----------------------
 arch/x86/kernel/mpparse.c           |   12 
 drivers/iommu/intel/irq_remapping.c |   11 
 5 files changed, 369 insertions(+), 517 deletions(-)





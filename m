Return-Path: <linux-kernel+bounces-439337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDA39EADE0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0C91887D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85E1DC980;
	Tue, 10 Dec 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xG9mVcm9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="McaG3mSz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140723DE8D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826045; cv=none; b=kBsghfy6pfy7eUyMf5y4iISs7znLUiarwu2Zq+qP1wKheZBtEUsgGsD4x5o9fhd1BaPmAJ1nQVRrfUeU6FIbzm6slTRM+5sDa7wugauTvek7qk/is7HP+kqX5Xo8VWpwXhHhkqGQDBBk+MgqfPMC13w5wGsctSJr8y+9HaEtzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826045; c=relaxed/simple;
	bh=B0hVCWdpTDSmefaK7BFocMJDWtu1VBTbd8+4/EJ1hOc=;
	h=Message-ID:From:To:Subject:cc:Date; b=Zl2BpGE6IdLQ4WskI7rKX4S0ch02KSPxFCQcSRg1iKy0Hog5zgrW2ov+oYXltMKZRkT+62KAMYk6ldl9xGT0/yeJWd140xWffnQc8ppbMWWbWkYqSn/qxR/SbVcExboQ6ryX8O5BMfwrJQ6Ctd9s1S+qMjes/8GwwEi8yt+uT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xG9mVcm9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=McaG3mSz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241210101114.126983214@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733826042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=cuX3Gy8CWZsEfSwzMhlFm5E/Zotdzw70yX99TIO9/Xw=;
	b=xG9mVcm9mT00tQT1vFTfppfsJQqZdLVDg2K0T8pz3rjKHJ7S6SeC3wa/Ghoanau11MpWEp
	Icw57y8bMTCgjfTMnz+4Ekpk8grfqexkNtHLsowXmRUqWZGJ9dePfXYXMACnhgBEU5Brqi
	K55nAobPwheu3XkprqzPk7m0vmyPtPAosEqghsOy/TBCt8elTZnVRtNao75aNcF4dLkEgT
	GXD1uBO8lmD81tFkGLGt4Pw+ZMx599wacCdbPmUmhSCyNfsTst/e2nOmwbKPpv7cyRx4UU
	UcKsttOTgf/o2kYwqTN9PS2uNT1/cs21ht3h8mIBpJushgSRaJLqbTLgU65y5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733826042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=cuX3Gy8CWZsEfSwzMhlFm5E/Zotdzw70yX99TIO9/Xw=;
	b=McaG3mSzb0ho6iw9lmFg4FEQ9D9wKnun8ce3lVaEmjcblFZA36Z5mA5leNMEunW1XP/FE+
	COgXrhEoYL8UCyBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 0/2] genirq: Make interrupt context enforcing work
 unconditionally
cc: Marc Zyngier <maz@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>
Date: Tue, 10 Dec 2024 11:20:41 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

While looking at GENERIC_PENDING_IRQ I stumbled over the fact, that the
interrupt context enforcement for ARM[64] which was attempted by

 commit 1b57d91b969c ("irqchip/gic-v2, v3: Prevent SW resends entirely")

actually never worked because handle_enforce_irqctx() is a wrapper around
the actual check and that wrapper is only providing the informatuib when
GENERIC_PENDING_IRQ is set. That's not the case for ARM[64].

Make it available unconditionally and clean up the now pointless wrapper.

Thanks,

	tglx
---
 internals.h |    8 --------
 irqdesc.c   |    2 +-
 resend.c    |    2 +-
 3 files changed, 2 insertions(+), 10 deletions(-)



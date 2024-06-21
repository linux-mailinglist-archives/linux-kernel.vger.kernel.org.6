Return-Path: <linux-kernel+bounces-224323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB2D9120C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C7E1F23B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9016E895;
	Fri, 21 Jun 2024 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A7McZitc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkbfNvaj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33B1C02
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962677; cv=none; b=RsD/g3oj3QmsNdfyl9ayPUY7KLjV2gHDUALtkkOMMezhRCmKR6H/wlhrBGaJN+uBfwF+GQqYfObF2MEbop5gwqa8cEPFTofEN2yUM6aAoNyWZ3FimOx8wLODj43z5553XUlJhZXA0jenoDATQH8ULU44vvVet5MhzKjN8wwhNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962677; c=relaxed/simple;
	bh=KVJZo+2Hq8SQGkCmhtfuKpFH5c+yIZcNIezdL4bB2fc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F9gkpC52IlfgTZNOS+wZ3/z9qo3ftSoMUXG2GZVF7GGMXjznVI1DtEZhLS4X2qozGQxQP8pjeGpI8+JkL3fzFfT0RavsFRrOo89JI3rgGx1B/+MDGZIwdml+at/3YMOiWZc54tdLa4LvAxrUh89ZD6Dni7zCXUG/WpHCi6n0DW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A7McZitc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nkbfNvaj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718962674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ImW1blG59sHAp+VqsRI4ftejETb/hMrEEkAXhK7LQ3A=;
	b=A7McZitcq4gwWzPMT/AI9tVl0HAb4es33LbSttDHihvwHOJM5Eej/64/xT9e92IfFfEKtc
	yjXk4+p1mzbUlnYHjj/nJ1+IVw8cRQ6vDCVfkRYch5qsFg6A5wcFk1yRZDtkxX4h9eBrgC
	x+p+dc2E0V80ZyX+IzwcBe/MO+9cVhhUrTwajzJsLcTjZjkj8vQkNHBwc30Nqm1WBn7qDZ
	4ENegoiwocZAs1L3egaBvPySSW3fCb3UNyFxuwSFkBKJsFDedmfhhatbjzRrMJ1/Z57QQR
	oMNXBWiYuDKPzeRSBvPm3TEm/lnjEUD6L17g4YTCj93VBqgYxY02WHgG82ahlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718962674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ImW1blG59sHAp+VqsRI4ftejETb/hMrEEkAXhK7LQ3A=;
	b=nkbfNvajJtYcDQBfzwP/wvYVgQdN/8UKfxVi6+mN5X5ed7yq/6zpvMvUy553u3DZkURLIq
	jSnDPtnqoeDrabAw==
Subject: [PATCH 0/3] timer_migration: Fix a possible race and improvements
Date: Fri, 21 Jun 2024 11:37:05 +0200
Message-Id: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMFJdWYC/x3LQQqAIBBA0avIrBOcwYK6SrQIHW0WWWhEEN49a
 fn4/BcKZ+ECk3oh8y1FjtSAnQK3rSmyFt8MZMiagVBfu8SsgzxctCfXYyCLo3XQjjPzH9owL7V
 +KAmKtl0AAAA=
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Narasimhan V <Narasimhan.V@amd.com>

Borislav reported a warning in timer migration deactive path

  https://lore.kernel.org/r/20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local

Sadly it doesn't reproduce directly. But with the change of timing (by
adding a trace prinkt before the warning), it is possible to trigger the
warning reliable at least in my test setup. The problem here is a racy
check agains group->parent pointer. This is also used in other places in
the code and fixing this racy usage is adressed by the first patch.

While working with the code, I saw two things which could be improved
(tracing and update of per cpu group wakeup value). This improvements are
adressed by the other two patches.

Patches are available here:

  https://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/misc

Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org

Thanks,

Anna-Maria

---
Anna-Maria Behnsen (3):
      timer_migration: Do not rely always on group->parent
      timer_migration: Spare write when nothing changed
      timer_migration: Improve tracing

 kernel/time/timer_migration.c | 55 ++++++++++++++++++++-----------------------
 kernel/time/timer_migration.h | 12 +++++++++-
 2 files changed, 36 insertions(+), 31 deletions(-)



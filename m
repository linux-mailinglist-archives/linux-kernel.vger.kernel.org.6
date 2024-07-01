Return-Path: <linux-kernel+bounces-235999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1991DC38
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4376F1F2161D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4928139CF3;
	Mon,  1 Jul 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SSYTNvNJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GeaVGEne"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695312C52E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829143; cv=none; b=CN5wcFWE9wmU/GgFSDZEBY1rzPM9Eevv8MFXrOfc/3ysd/axxdbgOsocdv8H7/NeAQoOPomuvQjlcv5sq1JNN9GrLzkUUHB4YwLrUhcaR0bacLfkHBmSdDDRFLVoZ9pNxVqN9qYqxaR14YRD3FYrYyAN1VaP+w7q5bmgnzD/hIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829143; c=relaxed/simple;
	bh=DWyhSviFBq49KsWE1GHUBThsO3yvc6bExLckvSCcooo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PWKSPvFSzUPENXe8ux7B4Zb1MKsGkT9T2pbW3lTljYPUaMStvPWdnm9jA+wXWzj+t9GnB7P8KJ67C4Fa2ptZSCeh/rHiuUBxXm8Gmteh0TV6xfvORW5+7Ri0M12Zutvn6T5dpreFamMHJ0wCDnWKG8WOjrM5z0PNRxbN4BTbnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SSYTNvNJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GeaVGEne; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719829136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RIDlsaHGKdsfbXEOFSQDvXxqmkVZhbx1B8rojESXhF0=;
	b=SSYTNvNJcAdG5+jOoPO5t3fVUlb4PNhOEY0cxsxg+emurg3J25j+Cm82zJ6e7wCPUNi1Uy
	8YGmmKR80RjlgQ31RSfc9iOSypBkFuZ4echhQYofSqNWMCc1TLmM/UUpDYf5/s2jsJHBKs
	mzvkoq2dj5/Z4uJ5MnKYKc5SM+B/ZDfb641qrXdX7eu8z32tfGmKMFyruqgxQiO1+w0rLf
	1lwcz4GsnaHyqoZ6kb413W1wUL8aQLLWDyqnHJ7Rm34Es55MvIpDEADZKbhOGN7xe6yqbu
	WZauiknxXZ+XZMnnXGQWgWx6Db1FqeMQdThw+gG1jjy4BEwYZ9nTrfK9TCjcXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719829136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RIDlsaHGKdsfbXEOFSQDvXxqmkVZhbx1B8rojESXhF0=;
	b=GeaVGEneYBcmdpYdeOMJ3A1MGaeuraNMkUZbjlHWie03CTZb6c3t02ovOBxfu3FUb5KZZ9
	O14yUBLT/TSRETCA==
Subject: [PATCH v3 0/8] timers/migration: Fix three possible races and some
 improvements
Date: Mon, 01 Jul 2024 12:18:36 +0200
Message-Id: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHyCgmYC/23MQQ6CMBCF4auQrq1phwrFlfcwLrAdYBJtTYsNh
 nB3Cys1Lt9Mvn9mEQNhZMdiZgETRfIuj3JXMDO0rkdONm8GApSoQPLxTn3gHU0YuQVzkB0o2Sj
 DsngE3B4ZnC95DxRHH15bPMn1+r+TJBdcG92C1ahtXZ9u5J5j8I6mvUW2thJ8evXtIfsSr8qIS
 qi6Eb9+WZY37zmY0OoAAAA=
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

Borislav reported a warning in timer migration deactive path

  https://lore.kernel.org/r/20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local

Sadly it doesn't reproduce directly. But with the change of timing (by
adding a trace prinkt before the warning), it is possible to trigger the
warning reliable at least in my test setup. The problem here is a racy
check agains group->parent pointer. This is also used in other places in
the code and fixing this racy usage is adressed by the first patch.

There were two other races reported by Frederic in setup path:

  https://lore.kernel.org/r/ZnWOswTMML6ShzYO@localhost.localdomain

  https://lore.kernel.org/r/ZnoIlO22habOyQRe@lothringen

Those races are both is addressed by the change of patch 2.

Some updates/cleanups are provided by patch 3-8. ("timers/migration:
Improve tracing" and "timers/migration: Spare write when nothing changed"
are the same as provided by v2).

Patches are available here:

  https://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/misc

---
Changes in v3:
- Address the new reported possible race (childmask and parent pointer)
  together with the existing race (both reported by Frederic).
- New cleanup: Two patches to access childmask and parent pointer only in
  one place
- New cleanup: Rename childmask to parentmask as during discussions there
  was some kind of confusion because of the naming
- New cleanup: Fix typo
- Fix prefix in all patches (s$timer_migration$timers/migration$)
- Link to v2: https://lore.kernel.org/r/20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de

Changes in v2:
- Address another possible race in setup code (reported by Frederic) and
  recycle therefore one improvement patch
- Change order and move the already existing improvement patch to the end
  of the queue
- Existing patches didn't change
- Link to v1: https://lore.kernel.org/r/20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de

Thanks,

        Anna-Maria

---
Anna-Maria Behnsen (8):
      timers/migration: Do not rely always on group->parent
      timers/migration: Move hierarchy setup into cpuhotplug prepare callback
      timers/migration: Improve tracing
      timers/migration: Use a single struct for hierarchy walk data
      timers/migration: Read childmask and parent pointer in a single place
      timers/migration: Rename childmask by parentmask to make naming more obvious
      timers/migration: Spare write when nothing changed
      timers/migration: Fix grammar in comment

 include/linux/cpuhotplug.h             |   1 +
 include/trace/events/timer_migration.h |   4 +-
 kernel/time/timer_migration.c          | 366 ++++++++++++++++-----------------
 kernel/time/timer_migration.h          |  27 ++-
 4 files changed, 197 insertions(+), 201 deletions(-)



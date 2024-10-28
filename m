Return-Path: <linux-kernel+bounces-384372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB049B2959
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843831F239FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37BE1922E4;
	Mon, 28 Oct 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RsvexYUr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vyw9nNaH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF5190671
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100968; cv=none; b=GN/FjFDK6DmQKuyPww/B15NxA8UQ1d4p5TBV2IHap//DPawbCrl9TWlYSL6LMdV9SK6bmOWvieTDqkDtMK1P+K4AP0RK3MHtbRiZu6Nsqf/8cKRHeBx+lPSVuoTQ8auWF+Anj5ziN+Jj2FX7YXmxCRi7SEK9zeFcTNdwohZ5R54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100968; c=relaxed/simple;
	bh=NpvWzh7Ftalp3C4DmfRGMNBTWvj2+Oo5LMKljDU2TCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DBeAtXGMneVKoNeEJLUYgKwIs8rh8BIFg/Orq20ubzsTWEdbGaiQJBhY6MKKrl0sNE8VSsqGWFFcvDceJrR7/kO9FZDInsiZJoGGc8v5Tlbvq552jlyfbR/VQibKgtuUHn8r/+lfM9RJzzCK48fImAC4RtyXPL+71/lXc4EC4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RsvexYUr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vyw9nNaH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mL11sOnXoBUyTFWl/QkWTr94BmP52wyuD/23j1W1GZM=;
	b=RsvexYUro2sA90GG0603iffH81IVphBgyqmSbJMAj4qoe0fjQnZP+ue70diBw0ehXUBgLr
	ygjbv6LK4qgxg2reNYVbFNEiKZ31faN7mVK/uBkr5A2E1KELGhiBT+ZdRseEjOesCenAJt
	xYIDxqCPLOetbqjEWycLTBUG5BiY43Koap2O+dHGmoSAZST1dACRbY4ds7JK20y1bKJBN2
	baU7C8Hn+b38X34dsngtmpQDc1TFmb/ztNogeBGDo5HAHxc5UAXUowo3nRtcTrmFLL4xX2
	endtmUXDFX+rpKMgzZWZLhZ79HwgsX/LtnhDrLRGGjx8166Ypb1HX9pABLDLCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mL11sOnXoBUyTFWl/QkWTr94BmP52wyuD/23j1W1GZM=;
	b=vyw9nNaHtLptk4SInGPZSZ4tj8H+cx+PktgQlIR5GMReJviCifBAQbZ2FUK4e5MfHGPPUD
	xzU2/XeYpqHfGZBg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Kalle Valo <kvalo@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 00/12] hrtimers: Switch to new hrtimer interface functions (5/5)
Date: Mon, 28 Oct 2024 08:35:44 +0100
Message-Id: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the fifth part of a 5-part series (split for convenience). All 5
parts are:

Part 1: https://lore.kernel.org/lkml/cover.1729864615.git.namcao@linutronix=
.de
Part 2: https://lore.kernel.org/lkml/cover.1729864823.git.namcao@linutronix=
.de
Part 3: https://lore.kernel.org/lkml/cover.1729865232.git.namcao@linutronix=
.de
Part 4: https://lore.kernel.org/lkml/cover.1729865485.git.namcao@linutronix=
.de
Part 5: https://lore.kernel.org/lkml/cover.1729865740.git.namcao@linutronix=
.de

To use hrtimer, hrtimer_init() (or one of its variant) must be called, and
also the timer's callfack function must be setup separately.

That can cause misuse of hrtimer. For example, because:
  - The callback function is not setup
  - The callback function is setup while it is not safe to do so

To prevent misuse of hrtimer, this series:
  - Introduce new functions hrtimer_setup*(). These new functions are
    similar to hrtimer_init*(), except that they also sanity-check and
    initialize the callback function.
  - Introduce hrtimer_update_function() which checks that it is safe to
    change the callback function. The 'function' field of hrtimer is then
    made private.
  - Convert all users to use the new functions.
  - Some minor cleanups on the way.

Most conversion patches were created using Coccinelle with the sematic
patch below; except for tricky cases that Coccinelle cannot handle, or for
some cases where a Coccinelle's bug regarding 100 column limit is
triggered. Any patches not mentioning Coccinelle were done manually.

virtual patch
@@ expression timer, clock, mode, func; @@
- hrtimer_init(timer, clock, mode);
  ...
- timer->function =3D func;
+ hrtimer_setup(timer, func, clock, mode);

@@ expression timer, clock, mode, func; @@
- hrtimer_init(&timer, clock, mode);
  ...
- timer.function =3D func;
+ hrtimer_setup(&timer, func, clock, mode);

@@ expression timer, clock, mode, func; @@
- hrtimer_init_on_stack(&timer, clock, mode);
  ...
- timer.function =3D func;
+ hrtimer_setup_on_stack(&timer, func, clock, mode);

@@ expression timer, clock, mode; @@
- hrtimer_init_sleeper_on_stack(timer, clock, mode);
+ hrtimer_setup_sleeper_on_stack(timer, clock, mode);

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>

Nam Cao (12):
  hrtimers: Delete hrtimer_init()
  hrtimers: Switch to use __htimer_setup()
  hrtimers: Merge __hrtimer_init() into __hrtimer_setup()
  serial: xilinx_uartps: Use helper function hrtimer_update_function()
  io_uring: Use helper function hrtimer_update_function()
  wifi: rt2x00: Switch to use hrtimer_update_function()
  hrtimers: Make callback function pointer private
  hrtimers: Remove unnecessary NULL check in hrtimer_start_range_ns()
  hrtimers: Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper()
  hrtimers: Rename debug_init() to debug_setup()
  hrtimers: Rename debug_init_on_stack() to debug_setup_on_stack()
  tracing/timers: Rename hrtimer_init event to hrtimer_setup

 Documentation/trace/ftrace.rst                |  4 +-
 .../net/wireless/ralink/rt2x00/rt2800mmio.c   |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800usb.c    |  2 +-
 drivers/tty/serial/xilinx_uartps.c            |  4 +-
 include/linux/hrtimer.h                       |  4 +-
 include/linux/hrtimer_types.h                 |  4 +-
 include/trace/events/timer.h                  |  8 +--
 io_uring/io_uring.c                           |  2 +-
 kernel/time/hrtimer.c                         | 69 +++++--------------
 kernel/time/timer_list.c                      |  2 +-
 tools/perf/tests/shell/trace_btf_enum.sh      |  2 +-
 11 files changed, 35 insertions(+), 68 deletions(-)

--=20
2.39.5



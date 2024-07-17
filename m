Return-Path: <linux-kernel+bounces-255443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B509340C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB091C21A54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34153181D16;
	Wed, 17 Jul 2024 16:50:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B50181CE9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235010; cv=none; b=UjnJ4xx3SCCQk4sw5gIJxF3H/0/2yBZ1Bx3uujdLn2iKfEMDMSRLi3/bF8hnBwEQ/aJJEv4qIdAwnFnIkMC0vzdxRdoYIlvKDUfpaTM5FQ9Mhn9caZjy/m3/bAbmeiZfgjXFTCc2BkzVcA/WIlh/21i/iqOfqgAp/+K9t4JdNt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235010; c=relaxed/simple;
	bh=FOotqtbfuJ/4ufY4YyEJ8lg73RpNxOQMJdow8HqdcSY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=X8o/azb+Lo3ybktYEkNn5nLa+QmGgEwr/LyDiq8t/j6WsevZmNRIyLz8Mal8D/BohhL01bsEVSQErTtyyr5P2GQgKmi5vJPnVIzv3ucnT6+6Fx4cwrrb0V0zNYHsbln5RsJdF/VqOrKv369da8s4BqvOerchvOthBFZ2edzrbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEC4C2BD10;
	Wed, 17 Jul 2024 16:49:36 +0000 (UTC)
Date: Wed, 17 Jul 2024 12:49:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Clark Williams <williams@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, "Luis Claudio R. Goncalves"
 <lclaudio@uudg.org>, John Kacur <jkacur@redhat.com>
Subject: [GIT PULL] tracing: Update MAINTAINERS file
Message-ID: <20240717124927.6b4c1bb1@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

tracing: Update of MAINTAINERS and CREDITS file

- Update Daniel Bristot de Oliveira's entry in MAINTAINERS with respect to
  his tracing code.

- Add more credits to him in CREDITS file and move his entry to be
  alphabetical.

This had a dependency on tip/sched tree, so I added it on top of the
commit that it depended on, and waited until it made it into your tree
before submitting this.

Please pull the latest trace-v6.11-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.11-2

Tag SHA1: 082c8d2e632f97408207ab5215a70e71269e9e86
Head SHA1: 5f7c72df1ba6ba00ee163ba4049c785ac5930759


Steven Rostedt (Google) (1):
      tracing: Update MAINTAINERS file

----
 CREDITS     | 10 +++++++---
 MAINTAINERS |  3 ---
 2 files changed, 7 insertions(+), 6 deletions(-)
---------------------------
commit 5f7c72df1ba6ba00ee163ba4049c785ac5930759
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Mon Jul 15 14:47:45 2024 -0400

    tracing: Update MAINTAINERS file
    
    Gone but never forgotten.
    
    [ Also moved Daniel's name to be consistent with the alphabetical order ]
    
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Juri Lelli <juri.lelli@redhat.com>
    Cc: Kate Stewart <kstewart@linuxfoundation.org>
    Cc: Clark Williams <williams@redhat.com>
    Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
    Cc: John Kacur <jkacur@redhat.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    Link: https://lore.kernel.org/20240715144745.51d887a9@rorschach.local.home
    Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/CREDITS b/CREDITS
index 88c4c08cb613..d7798910e99f 100644
--- a/CREDITS
+++ b/CREDITS
@@ -271,9 +271,6 @@ D: Driver for WaveFront soundcards (Turtle Beach Maui, Tropez, Tropez+)
 D: Various bugfixes and changes to sound drivers
 S: USA
 
-N: Daniel Bristot de Oliveira
-D: Scheduler contributions, notably: SCHED_DEADLINE
-
 N: Carlos Henrique Bauer
 E: chbauer@acm.org
 E: bauer@atlas.unisinos.br
@@ -534,6 +531,13 @@ S: Kopmansg 2
 S: 411 13  Goteborg
 S: Sweden
 
+N: Daniel Bristot de Oliveira
+D: Scheduler contributions, notably: SCHED_DEADLINE
+D: Real-time Linux Analysis
+D: Runtime Verification
+D: OS Noise and Latency Tracers
+S: Brazil and Italy
+
 N: Paul Bristow
 E: paul@paulbristow.net
 W: https://paulbristow.net/linux/idefloppy.html
diff --git a/MAINTAINERS b/MAINTAINERS
index 2e1b8bbacb5e..0b7e4cd4ffd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18895,7 +18895,6 @@ F:	include/uapi/linux/rtc.h
 F:	tools/testing/selftests/rtc/
 
 Real-time Linux Analysis (RTLA) tools
-M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
@@ -19529,7 +19528,6 @@ S:	Maintained
 F:	drivers/infiniband/ulp/rtrs/
 
 RUNTIME VERIFICATION (RV)
-M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
@@ -22806,7 +22804,6 @@ F:	kernel/trace/trace_mmiotrace.c
 
 TRACING OS NOISE / LATENCY TRACERS
 M:	Steven Rostedt <rostedt@goodmis.org>
-M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 S:	Maintained
 F:	Documentation/trace/hwlat_detector.rst
 F:	Documentation/trace/osnoise-tracer.rst


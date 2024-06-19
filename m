Return-Path: <linux-kernel+bounces-220467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035FF90E224
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59807B226CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5881E4C635;
	Wed, 19 Jun 2024 04:05:29 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9941E878
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769928; cv=none; b=n8CvBZ6lf3uPddZYNuZi1/9ypdHH3b+FZyQLwePO73rABazQ3MNM0Vde/YZWV+kx8TcipOoGSSyIfyfx1MoyVAiOTw/rE86nyVafLXawSu7u71Ztr/tDbirGZQ5qNKRYZXPizMlbbdyOKAfpFFTwhak7vBa28WRcJ+5SaFSIz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769928; c=relaxed/simple;
	bh=q2wQbY2M6W+WWZICaH3LyquyTOM9BGzcmpoj/Zh08H8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=COZ2zf4RzsFpNETuT83tN8rhabvm3lNi8wD6dXy3XJh7YvhW0Q1iBnKWGuXBKe2MvMgI9lIz10wnY44NrcQHzbLOH1uaDQvj3SCaoqhH14PnXzU52wQa6dVv0zuULaE2LY6ZGdkCh9SRcgWImD/KIUThd8hkA2EubHNkwwT9p0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:52086)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmZZ-00E6La-N7; Tue, 18 Jun 2024 22:05:25 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:55888 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmZY-009RKH-BN; Tue, 18 Jun 2024 22:05:25 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Tejun Heo <tj@kernel.org>,
  linux-kernel@vger.kernel.org
References: <20240609142342.GA11165@redhat.com>
	<87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
	<20240610152902.GC20640@redhat.com>
	<20240613154541.GD18218@redhat.com>
	<87ikyamf4u.fsf@email.froward.int.ebiederm.org>
	<20240617183758.GB10753@redhat.com>
	<87iky5k2yi.fsf@email.froward.int.ebiederm.org>
	<87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
Date: Tue, 18 Jun 2024 23:05:16 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87iky5inlv.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmZY-009RKH-BN;;;mid=<87iky5inlv.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19qO6ww9qXWAM8xKGdWMh3T3kotA0Uo1eQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 482 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 14 (2.9%), b_tie_ro: 12 (2.4%), parse: 1.54
	(0.3%), extract_message_metadata: 19 (3.9%), get_uri_detail_list: 3.7
	(0.8%), tests_pri_-2000: 19 (3.9%), tests_pri_-1000: 3.3 (0.7%),
	tests_pri_-950: 1.63 (0.3%), tests_pri_-900: 1.24 (0.3%),
	tests_pri_-90: 85 (17.6%), check_bayes: 83 (17.2%), b_tokenize: 10
	(2.1%), b_tok_get_all: 9 (1.9%), b_comp_prob: 3.2 (0.7%),
	b_tok_touch_all: 56 (11.6%), b_finish: 1.16 (0.2%), tests_pri_0: 317
	(65.8%), check_dkim_signature: 0.72 (0.2%), check_dkim_adsp: 3.2
	(0.7%), poll_dns_idle: 0.92 (0.2%), tests_pri_10: 4.1 (0.9%),
	tests_pri_500: 12 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 01/17] signal: Make SIGKILL during coredumps an explicit
 special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


Simplify the code that allows SIGKILL during coredumps to terminate
the coredump.  As far as I can tell I have avoided breaking this
case by dumb luck.

Historically with all of the other threads stopping in exit_mm the
wants_signal loop in complete_signal would find the dumper task and
then complete_signal would wake the dumper task with signal_wake_up.

After moving the coredump_task_exit above the setting of PF_EXITING in
commit 92307383082d ("coredump: Don't perform any cleanups before
dumping core") wants_signal will consider all of the threads in a
multi-threaded process for waking up, not just the core dumping task.

Luckily complete_signal short circuits SIGKILL during a coredump marks
every thread with SIGKILL and signal_wake_up.  This code is arguably
buggy however as it tries to skip creating a group exit when is already
present, and it fails that a coredump is in progress.

Ever since commit 06af8679449d ("coredump: Limit what can interrupt
coredumps") was added, dump_interrupted needs not just TIF_SIGPENDING
set on the dumper task but also SIGKILL set in it's pending bitmap.
This means that if the code is ever fixed not to short-circuit and
kill a process after it has already been killed the special case
for SIGKILL during a coredump will be broken.

Sort all of this out by making the coredump special case more special.
Perform all of the work in prepare_signal and leave the rest of the
signal delivery path out of it.

In prepare_signal when the process coredumping is sent SIGKILL find
the task performing the coredump and use sigaddset and signal_wake_up
to ensure that task reports fatal_signal_pending.

Return false from prepare_signal to tell the rest of the signal
delivery path to ignore the signal.

Remove the "signal->core_state || !(signal->flags &&
SIGNAL_GROUP_EXIT)" test from complete_signal as signal delivery after
process exit does not reach complete_signal.

I have tested this and verified I did not break SIGKILL during
coredumps by accident (before or after this change).  I actually
thought I had and I had to figure out what I had misread that kept
SIGKILL during coredumps working.

v1: https://lkml.kernel.org/r/20211213225350.27481-1-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 1f9dd41c04be..e3662fff919a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -907,8 +907,12 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 	sigset_t flush;
 
 	if (signal->flags & SIGNAL_GROUP_EXIT) {
-		if (signal->core_state)
-			return sig == SIGKILL;
+		if (signal->core_state && (sig == SIGKILL)) {
+			struct task_struct *dumper =
+				signal->core_state->dumper.task;
+			sigaddset(&dumper->pending.signal, SIGKILL);
+			signal_wake_up(dumper, 1);
+		}
 		/*
 		 * The process is in the middle of dying, drop the signal.
 		 */
@@ -1033,7 +1037,6 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 	 * then start taking the whole group down immediately.
 	 */
 	if (sig_fatal(p, sig) &&
-	    (signal->core_state || !(signal->flags & SIGNAL_GROUP_EXIT)) &&
 	    !sigismember(&t->real_blocked, sig) &&
 	    (sig == SIGKILL || !p->ptrace)) {
 		/*
-- 
2.41.0



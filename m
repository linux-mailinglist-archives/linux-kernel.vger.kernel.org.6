Return-Path: <linux-kernel+bounces-220481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA3990E240
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5D31F231EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B303F53E22;
	Wed, 19 Jun 2024 04:13:00 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09FE2A8D3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770380; cv=none; b=rfhif6l9ew3/20WhYEuappVplefSDzobEBm/Uoy/uGEbO1DhsdOGI/h2F7rY0qQF9YmCK3kh2HYRGgWyyUG5wN0y3M5G6KBBuTtxy3Yz6Bx2ftk5odAF5Vy19JW0pvXm6U+BJtTMHSLK1ZVaxDqHJZA5KcsdLZspTQ9ESh2roHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770380; c=relaxed/simple;
	bh=hcUFQAxueVB1U7SwcYYc/DV9YG48AAloDLiW68bjzsI=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=NuryD2mLB3b604aDyp1D2I7kb6GNbZgFsCZ3UmM7p/tSel9H5BF7kbJrGnI+r2o0ro+aGi7pv8csVL67S92QypM51Khc3mU7nEx+HM5i4kMoJvD4MeiIT1ghwSqlIv2rL61VPwerlQfOLuVmMLixBl1cMFnV+tlbo6I8gs07Fxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:34508)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmaP-004PJ4-LG; Tue, 18 Jun 2024 22:06:18 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56746 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmaO-009RUo-Nc; Tue, 18 Jun 2024 22:06:17 -0600
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
Date: Tue, 18 Jun 2024 23:06:08 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <877celinkf.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmaO-009RUo-Nc;;;mid=<877celinkf.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+Szj+jOI9RXNy+Sb3fEgssCDHScSg1/yA=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  1.0 XMMoneyMeta_00 Subject Contains Money Spam
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 350 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (3.2%), b_tie_ro: 10 (2.8%), parse: 0.98
	(0.3%), extract_message_metadata: 12 (3.5%), get_uri_detail_list: 1.55
	(0.4%), tests_pri_-2000: 13 (3.7%), tests_pri_-1000: 2.4 (0.7%),
	tests_pri_-950: 1.25 (0.4%), tests_pri_-900: 1.03 (0.3%),
	tests_pri_-90: 52 (15.0%), check_bayes: 51 (14.6%), b_tokenize: 7
	(2.0%), b_tok_get_all: 6 (1.7%), b_comp_prob: 2.1 (0.6%),
	b_tok_touch_all: 33 (9.3%), b_finish: 0.89 (0.3%), tests_pri_0: 243
	(69.4%), check_dkim_signature: 0.61 (0.2%), check_dkim_adsp: 3.0
	(0.9%), poll_dns_idle: 1.12 (0.3%), tests_pri_10: 2.1 (0.6%),
	tests_pri_500: 8 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 03/17] coredump: Consolidate the work to allow SIGKILL
 during coredumps
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


Consolidate all of the work to allow SIGKILL during coredumps in
zap_threads.  Move the comment explaning what is happening from
zap_process.  Clear the per task pending SIGKILL to ensure that
__fatal_signal_pending returns false, and that interruptible waits
continue to wait during coredump generation.  Move the atomic_set
before the comment as setting nr_threads has nothing to do with
allowing SIGKILL.

With the work of allowing SIGKILL consolidated in zap_threads make the
process tear-down in zap_process as much like the other places that
set SIGKILL as possible.

Include current in the set of processes being asked to exit.
With the per task SIGKILL cleared in zap_threads the current process
remains killable as it performs the coredump.  Removing the
only reason I know of for not current to exit.

Separately count the tasks that will stop in coredump_task_exit that
coredump_wait needs to wait for.  Which tasks to count is different
from which tasks to signal, and the logic need to remain even when
task exiting is unified.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a57a06b80f57..be0405346882 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -366,18 +366,17 @@ static int zap_process(struct task_struct *start, int exit_code)
 	struct task_struct *t;
 	int nr = 0;
 
-	/* Allow SIGKILL, see prepare_signal() */
 	start->signal->flags = SIGNAL_GROUP_EXIT;
 	start->signal->group_exit_code = exit_code;
 	start->signal->group_stop_count = 0;
 
 	for_each_thread(start, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {
+		if (!(t->flags & PF_POSTCOREDUMP)) {
 			sigaddset(&t->pending.signal, SIGKILL);
 			signal_wake_up(t, 1);
-			nr++;
 		}
+		nr += (t != current) && !(t->flags & PF_POSTCOREDUMP);
 	}
 
 	return nr;
@@ -393,9 +392,12 @@ static int zap_threads(struct task_struct *tsk,
 	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
 		signal->core_state = core_state;
 		nr = zap_process(tsk, exit_code);
+		atomic_set(&core_state->nr_threads, nr);
+
+		/* Allow SIGKILL, see prepare_signal() */
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
+		sigdelset(&tsk->pending.signal, SIGKILL);
 		tsk->flags |= PF_DUMPCORE;
-		atomic_set(&core_state->nr_threads, nr);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 	return nr;
-- 
2.41.0



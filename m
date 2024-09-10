Return-Path: <linux-kernel+bounces-323462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B21D973D72
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270301F271C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0141A257C;
	Tue, 10 Sep 2024 16:34:57 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BD1A2576
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986097; cv=none; b=uLDbVMpa4SQ4oP0xxNXqw8FsLDI4kXfsCHXG31t/NK2g5punQExaGvbLMM3ZEz/H4sXMUo5evWgf3LK7TFRoCe9GPiKbiOuX0aYrExYPUEes8B9xPUN5e6W3A4rPI9SyE/IJKj5KIQhQRvLfqYVfNFYo/F74QQg049/C90X1JJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986097; c=relaxed/simple;
	bh=s2QLbs6AlMPIZ39Kp3ay5HrTCXR3d60GegJTLMweQ8A=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=ZhezyR+TAxlvFXGVMS9oA2SK7Dvwd4zLUse69FJnLKXo2pWJLs3d1BI1vAkSFYU4zUI+I91Slu3SwpCwdGdkCl3zvkFpNZ2Z1CkbKgper4WWzhmHJ+4wetEBp/LgjzGnB/ARuEFYkeWgBV5sdgw21/8erQ3C/dxOHjKjwdu5WyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:51708)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so3pH-008dji-Tm; Tue, 10 Sep 2024 10:34:47 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:52852 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so3pG-005fvC-Sp; Tue, 10 Sep 2024 10:34:47 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jubilee Young <workingjubilee@gmail.com>
Cc: oleg@redhat.com,  akpm@linux-foundation.org,  apais@microsoft.com,
  benhill@microsoft.com,  linux-kernel@vger.kernel.org,
  romank@linux.microsoft.com,  ssengar@microsoft.com,
  sunilmut@microsoft.com,  torvalds@linux-foundation.org,
  vdso@hexbites.dev
References: <CAPNHn3rTjMcbNXRpZTBc-zEkmnnMJO2iem9-eUdBkyaquz88rw@mail.gmail.com>
Date: Tue, 10 Sep 2024 11:34:18 -0500
In-Reply-To: <CAPNHn3rTjMcbNXRpZTBc-zEkmnnMJO2iem9-eUdBkyaquz88rw@mail.gmail.com>
	(Jubilee Young's message of "Sat, 7 Sep 2024 01:45:50 -0700")
Message-ID: <87seu7bh85.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1so3pG-005fvC-Sp;;;mid=<87seu7bh85.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18iK5UHiTVcf4TAFGs8O555pmqMBzDpUgM=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4999]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Jubilee Young <workingjubilee@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 442 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 12 (2.8%), b_tie_ro: 11 (2.4%), parse: 0.96
	(0.2%), extract_message_metadata: 4.0 (0.9%), get_uri_detail_list:
	1.54 (0.3%), tests_pri_-2000: 3.5 (0.8%), tests_pri_-1000: 2.7 (0.6%),
	tests_pri_-950: 1.55 (0.4%), tests_pri_-900: 1.10 (0.2%),
	tests_pri_-90: 179 (40.4%), check_bayes: 176 (39.9%), b_tokenize: 5
	(1.2%), b_tok_get_all: 9 (2.1%), b_comp_prob: 3.3 (0.8%),
	b_tok_touch_all: 153 (34.6%), b_finish: 1.43 (0.3%), tests_pri_0: 215
	(48.7%), check_dkim_signature: 0.50 (0.1%), check_dkim_adsp: 2.8
	(0.6%), poll_dns_idle: 0.99 (0.2%), tests_pri_10: 3.9 (0.9%),
	tests_pri_500: 9 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: vdso@hexbites.dev, torvalds@linux-foundation.org, sunilmut@microsoft.com, ssengar@microsoft.com, romank@linux.microsoft.com, linux-kernel@vger.kernel.org, benhill@microsoft.com, apais@microsoft.com, akpm@linux-foundation.org, oleg@redhat.com, workingjubilee@gmail.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Jubilee Young <workingjubilee@gmail.com> writes:

>> if the process is ptraced, debugger can insert the breakoint into
>> please_insert_the_breakpoint_here(). Otherwise breakpoint_if_debugging()
>> is a cheap nop.
>
> Generally a programmer wants to put this kind of conditional breakpoint
> on an exception path, for which, unless one is working with a language that
> abuses exceptions for control flow (which unfortunately describes... many),
> the performance isn't of enormous concern. Not that it's free, either, but
> opening a file and scanning it is a lot more code than a single call
> to prctl.

I want to reiterate what Oleg pointed out elsewhere in this
conversation.

Observing a process is ptracing the current process does not mean a
debugger is attached to the current process.  It could be strace, or
upstart or some other code that happens to use the ptrace facility.

Which in turn means that opening /proc/self/status and looking for
TracerPid does not reliably detect if a debugger is attached.

Which unfortunately means that this must be solved as a coopeartive
effort between the library implementation and the debuggers.  Nothing
else can reliably tell you that a debugger is attached to your process.




Which in turn means this can not be solved in the kernel.  It must
be done as a cooperative effort between the implementation of the
library and the debuggers.

>> Perhaps it makes sense to discuss the alternatives? Say, a process can have a
>> please_insert_the_breakpoint_here() function implemented in asm which just does
>> asm(ret).
>
> There's some merit in having the debuggers recognize this pattern, as that
> then would save every language that wants to have this power available
> the trouble of reimplementing it. But first debuggers must recognize it,
> which would require teaching each of them, which can be... tedious.

Unfortunately that is the only solution that I can see that will work
reliably.

> Having a function named `fatal` or whatever likewise has this issue.
> A toolchain, however, can simply insert a jump to a breakpoint easily,
> without having to hold gdb, lldb, cdb, and whatever-other-db's hand.

Eric


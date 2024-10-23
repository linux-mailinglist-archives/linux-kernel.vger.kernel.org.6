Return-Path: <linux-kernel+bounces-378390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8BF9ACF48
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6CE2829E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A716A1CACE7;
	Wed, 23 Oct 2024 15:44:44 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AB1C6F43;
	Wed, 23 Oct 2024 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698284; cv=none; b=V32FY3cvKTLO/PwvNcnD1hyWuLOuCbltWS1bptFtfxnixkTlX3/+9soF/xBPsCiw3wzIV4JgmOOMIckl/0/JjskDQXJ72T5/mh92jUOYSnwfCEPzkpt3VvgFuWGlBO4Fyhwsh64C7rPH78dlX39pDYHnFQxnbmtYiAeDjVZrUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698284; c=relaxed/simple;
	bh=BJsQa4UwFXYxZ2llPGv6z6ugbvbu+ADQbnfLdebuFZg=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=iHj9ZrsjnyuS3EI967L+m7WEFVN2UJaanTrmuT3hMOw24Yi9d8NKNVbV5XQoqJGhubkzNseOhjmJQqC3BIJWLh31axNLSKmzs/mmGaDcObRfwJqZayBsVzdAD7MvgdAOi9VOJz9If+ltF5WGEIFYLS8U7+Qo4FTF3vpz3oNCLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:37192)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t3dXF-00Gq8R-Vr; Wed, 23 Oct 2024 09:44:34 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:48910 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t3dXE-00Ce3Q-Ub; Wed, 23 Oct 2024 09:44:33 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Yan Zhao <yan.y.zhao@intel.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-coco@lists.linux.dev,
  x86@kernel.org,  rick.p.edgecombe@intel.com,
  kirill.shutemov@linux.intel.com
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
	<87frop8r0y.fsf@email.froward.int.ebiederm.org>
	<tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
Date: Wed, 23 Oct 2024 10:44:11 -0500
In-Reply-To: <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
	(Kirill A. Shutemov's message of "Tue, 22 Oct 2024 15:06:15 +0300")
Message-ID: <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1t3dXE-00Ce3Q-Ub;;;mid=<87cyjq7rjo.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1899tWOjUmFXe4DAmPwzY/yTaOmZMJ+rQQ=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4764]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Kirill A. Shutemov" <kirill@shutemov.name>
X-Spam-Relay-Country: 
X-Spam-Timing: total 475 ms - load_scoreonly_sql: 0.08 (0.0%),
	signal_user_changed: 11 (2.3%), b_tie_ro: 10 (2.0%), parse: 1.67
	(0.4%), extract_message_metadata: 18 (3.8%), get_uri_detail_list: 1.66
	(0.3%), tests_pri_-2000: 6 (1.3%), tests_pri_-1000: 3.6 (0.8%),
	tests_pri_-950: 1.69 (0.4%), tests_pri_-900: 1.36 (0.3%),
	tests_pri_-90: 164 (34.5%), check_bayes: 147 (30.9%), b_tokenize: 7
	(1.4%), b_tok_get_all: 6 (1.3%), b_comp_prob: 3.1 (0.7%),
	b_tok_touch_all: 127 (26.7%), b_finish: 0.96 (0.2%), tests_pri_0: 251
	(52.9%), check_dkim_signature: 0.86 (0.2%), check_dkim_adsp: 3.1
	(0.7%), poll_dns_idle: 0.73 (0.2%), tests_pri_10: 1.92 (0.4%),
	tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: kirill.shutemov@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, yan.y.zhao@intel.com, kirill@shutemov.name
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> Waiting minutes to get VM booted to shell is not feasible for most
> deployments. Lazy is sane default to me.

Huh?

Unless my guesses about what is happening are wrong lazy is hiding
a serious implementation deficiency.  From all hardware I have seen
taking minutes is absolutely ridiculous.

Does writing to all of memory at full speed take minutes?  How can such
a system be functional?

If you don't actually have to write to the pages and it is just some
accounting function it is even more ridiculous.


I had previously thought that accept_memory was the firmware call.
Now that I see that it is just a wrapper for some hardware specific
calls I am even more perplexed.


Quite honestly what this looks like to me is that someone failed to
enable write-combining or write-back caching when writing to memory
when initializing the protected memory.  With the result that everything
is moving dog slow, and people are introducing complexity left and write
to avoid that bad implementation.


Can someone please explain to me why this accept_memory stuff has to be
slow, why it has to take minutes to do it's job.

I would much rather spend my time figuring out how to make accept_memory
run at a reasonable speed than to litter the kernel with more of this
nonsense.

Eric


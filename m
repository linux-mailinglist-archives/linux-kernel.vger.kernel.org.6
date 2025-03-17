Return-Path: <linux-kernel+bounces-564269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B288A6519B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A14A3A910E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8F23E227;
	Mon, 17 Mar 2025 13:47:42 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850014A4E0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219262; cv=none; b=X6fzGA8lHGl0qHUJ+L8Se5csU+bl2FoZrwvzXT8aTH8JAtwPqH5qXmjNclmhf+2hOHR8pN3StoZmb9u2fmhUGb86NnG4+od28fuALaSTnhUapFWV3UHqJlDCOmeAY07ns/o1PhwxGjMvuqJnRi6lXI6+cTjPRnNCD4fnxXZoQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219262; c=relaxed/simple;
	bh=FUAGxSnhR1t8Np3jzCiwBr6lZTqyKfAJbH5KVHS1oIA=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Content-Type:Subject; b=kP4to6xk/L1fuEM95qaF5xH3V9W/Ue8J85fbL0cWN5KnZdYg/WA5hPFcc3Wp29acwrFtaFzf+lX4aShNwmyi3xmG0U8mkpsbCbxIio0Ybhck6quIkSjEpilFPhtgFJYNKUOaBMDSZx7YmdjbcBW6w2N2KkxVZuElNNjZ8I1fDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:44470)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tuAoc-001XWc-FI; Mon, 17 Mar 2025 07:47:38 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:59574 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tuAoa-003fO2-WF; Mon, 17 Mar 2025 07:47:38 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 <linux-kernel@vger.kernel.org> ,
 Kexec Mailing List <kexec@lists.infradead.org>,
 Kees Cook <keescook@chromium.org> 
Date: Mon, 17 Mar 2025 08:47:30 -0500
Message-ID: <87r02v7or1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tuAoa-003fO2-WF;;;mid=<87r02v7or1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX197FQxHXBXos5TSabCI0KcBicWE4+FEdFM=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.2552]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 743 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (1.5%), b_tie_ro: 10 (1.3%), parse: 0.89
	(0.1%), extract_message_metadata: 23 (3.1%), get_uri_detail_list: 1.98
	(0.3%), tests_pri_-2000: 31 (4.2%), tests_pri_-1000: 2.3 (0.3%),
	tests_pri_-950: 1.22 (0.2%), tests_pri_-900: 0.97 (0.1%),
	tests_pri_-90: 193 (26.0%), check_bayes: 189 (25.4%), b_tokenize: 6
	(0.8%), b_tok_get_all: 42 (5.7%), b_comp_prob: 1.93 (0.3%),
	b_tok_touch_all: 135 (18.1%), b_finish: 0.97 (0.1%), tests_pri_0: 205
	(27.6%), check_dkim_signature: 0.81 (0.1%), check_dkim_adsp: 3.9
	(0.5%), poll_dns_idle: 248 (33.5%), tests_pri_10: 2.7 (0.4%),
	tests_pri_500: 268 (36.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] MAINTAINERS: Remove myself
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false


Unfortunately I no longer have time to meaningfully take part in the
linux kernel development.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9763412a508..7469254b13ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8644,7 +8644,6 @@ F:	rust/kernel/net/phy/reg.rs
 
 EXEC & BINFMT API, ELF
 M:	Kees Cook <kees@kernel.org>
-R:	Eric Biederman <ebiederm@xmission.com>
 L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
@@ -12824,9 +12823,7 @@ F:	fs/kernfs/
 F:	include/linux/kernfs.h
 
 KEXEC
-M:	Eric Biederman <ebiederm@xmission.com>
 L:	kexec@lists.infradead.org
-S:	Maintained
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
 F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
-- 
2.41.0



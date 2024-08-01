Return-Path: <linux-kernel+bounces-271657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CCF94512D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE5C283D80
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A041B4C30;
	Thu,  1 Aug 2024 16:58:01 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2E13C9A3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531480; cv=none; b=VHlVLZTfN8KjvzPTee9F73cmgNxpBhRUfAMGIgcshenANnVe2bHdpqm3JPaYBHtqsk5erhAFGO73rzj9lcEXKX/sEKxDDvOPemGihe6mEZaDYqHLP1KMNP5qIGa2aOVcoY1GNAKPo3F21oH8QRajAP6fqmNFHHVwzW4p7I7t3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531480; c=relaxed/simple;
	bh=oyi7eKj96uvxsOSky8mAfwoxTIKQuhUucLYiJxKks0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG7c9w2YE4vteX0QZP1koTuXzVh+ohmhmJjktaf/92uq2Ht3tZX+UBV1uaVKwcl6W3bjLj2/auSXxbA7glf7JH43ttRC6zF5b9S7YgvPR5+lWF6jmkVIlCaq9ZUPmiiNyZ7WIFtsOhD0RM87EhLE5PBRuBQwZdATSU2H4Aa4CyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1235D21A03;
	Thu,  1 Aug 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAD2013946;
	Thu,  1 Aug 2024 16:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VSpgLJO+q2aELgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 01 Aug 2024 16:57:55 +0000
Date: Thu, 1 Aug 2024 18:57:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: ltp@lists.linux.it, Aleksa Sarai <cyphar@cyphar.com>,
	Alexey Gladkov <legion@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	=?iso-8859-2?Q?Ga=EBl?= PORTAY <gael.portay@rtone.fr>,
	linux-kernel@vger.kernel.org
Subject: Re: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
Message-ID: <20240801165756.GA1526142@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1235D21A03
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated

Hi all,

> This is a patch-set that implements fchmodat2() syscall coverage.
> fchmodat2() has been added in kernel 6.6 in order to support
> AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
> There's no man pages yet, so please take the following links as
> main documentation along with kernel source code:

I would hope that it'd be at least Christian's fork [1], but it's not there.
I suppose nobody is working on the man page.

> https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
> https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/

> ***********
> * WARNING *
> ***********

> fchmodat2_02 fails with EOPNOTSUPP because of missing feature.

For a record, it's fchmodat2_01.c (from this patchset) which is failing (on
6.10.1-1.g4c78d6f-default Tumbleweed and 6.6.21-0-lts Alpine, both x86_64 VMs).

Andrea, I would personally just skip test on EOPNOTSUPP (that's what we do in
LTP on EOPNOTSUPP). The question why is not supported and whether is going to be
fixed.

Looking into glibc change 65341f7bbe ("linux: Use fchmodat2 on fchmod for flags
different than 0 (BZ 26401)") one year old change from glibc-2.39 [2] it looks
just accepted behavior (glibc returns EOPNOTSUPP on symlink):

+  /* Some Linux versions with some file systems can actually
+     change symbolic link permissions via /proc, but this is not
+     intentional, and it gives inconsistent results (e.g., error
+     return despite mode change).  The expected behavior is that
+     symbolic link modes cannot be changed at all, and this check
+     enforces that.  */
+  if (S_ISLNK (st.st_mode))
+    {
       __close_nocancel (pathfd);
-      return ret;
+      __set_errno (EOPNOTSUPP);
+      return -1;
+    }

Also musl also behaves the same on his fallback on old kernels [3]
(it started 10 years ago on 0dc48244 ("work around linux's lack of flags
argument to fchmodat syscall") when SYS_fchmodat was used and kept when this
year SYS_fchmodat2 started to be used in d0ed307e):

	int ret = __syscall(SYS_fchmodat2, fd, path, mode, flag);
	if (ret != -ENOSYS) return __syscall_ret(ret);

	if (flag != AT_SYMLINK_NOFOLLOW)
		return __syscall_ret(-EINVAL);

	struct stat st;
	int fd2;
	char proc[15+3*sizeof(int)];

	if (fstatat(fd, path, &st, flag))
		return -1;
	if (S_ISLNK(st.st_mode))
		return __syscall_ret(-EOPNOTSUPP);


> According to documentation, the feature has been implemented in
> kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
> on symbolic files. Also kselftests, which are meant to test the
> functionality, are not working and they are treating fchmodat2()
> syscall failure as SKIP. Please take a look at the following code
> before reviewing:

> https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123

I see there is a kselftest workaround in 4859c257d295 ("selftests: Add fchmodat2
selftest") [4], where fchmodat2 failure on symlink is simply skipped.

Aleksa, you're probably aware of this fchmodat2() failure on symlinks. Does
anybody work or plan to work on fixing it? LTP has policy to not cover kernel
bugs, if it's not expected to be working we might just skip the test as well.

I see a RFC UAPI related patchset [5] which touches include/uapi/linux/fcntl.h,
but AFAIK it's not related to this problem.

Kind regards,
Petr

[1] https://github.com/brauner/man-pages-md
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=65341f7bbea824d2ff9d37db15d8be162df42bd3;hp=c52c2c32db15aba8bbe1a0b4d3235f97d9c1a525
[3] https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c
[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/tools/testing/selftests/fchmodat2/fchmodat2_test.c?h=next-20240801&id=4859c257d295949c23f4074850a8c2ec31357abb
[5] https://lore.kernel.org/lkml/20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com/

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v4:
> - add SAFE_FCHMODAT2
> - Link to v3: https://lore.kernel.org/r/20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com

> Changes in v3:
> - removed fchmodat2.h
> - Link to v2: https://lore.kernel.org/r/20240723-fchmodat2-v2-0-e658a98b113e@suse.com

> Changes in v2:
> - merge first 3 tests into a unique one
> - move fchmodat2 in lapi/stat.h
> - add test for error checking
> - Link to v1: https://lore.kernel.org/r/20240521-fchmodat2-v1-0-191b4a986202@suse.com

> ---
> Andrea Cervesato (5):
>       Add SAFE_SYMLINKAT macro
>       Add fchmodat2 syscalls definitions
>       Add fchmodat2 fallback definition
>       Add fchmodat2_01 test
>       Add fchmodat2_02 test

>  include/lapi/stat.h                                |  16 +++
>  include/lapi/syscalls/aarch64.in                   |   1 +
>  include/lapi/syscalls/arc.in                       |   1 +
>  include/lapi/syscalls/arm.in                       |   1 +
>  include/lapi/syscalls/hppa.in                      |   1 +
>  include/lapi/syscalls/i386.in                      |   1 +
>  include/lapi/syscalls/ia64.in                      |   1 +
>  include/lapi/syscalls/loongarch.in                 |   1 +
>  include/lapi/syscalls/mips_n32.in                  |   1 +
>  include/lapi/syscalls/mips_n64.in                  |   1 +
>  include/lapi/syscalls/mips_o32.in                  |   1 +
>  include/lapi/syscalls/powerpc.in                   |   1 +
>  include/lapi/syscalls/powerpc64.in                 |   1 +
>  include/lapi/syscalls/s390.in                      |   1 +
>  include/lapi/syscalls/s390x.in                     |   1 +
>  include/lapi/syscalls/sh.in                        |   1 +
>  include/lapi/syscalls/sparc.in                     |   1 +
>  include/lapi/syscalls/sparc64.in                   |   1 +
>  include/lapi/syscalls/x86_64.in                    |   1 +
>  include/safe_macros_fn.h                           |   4 +
>  include/tst_safe_macros.h                          |   3 +
>  lib/safe_macros.c                                  |  20 ++++
>  runtest/syscalls                                   |   3 +
>  testcases/kernel/syscalls/fchmodat2/.gitignore     |   2 +
>  testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
>  testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 114 +++++++++++++++++++++
>  testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c |  68 ++++++++++++
>  27 files changed, 255 insertions(+)
> ---
> base-commit: 8422d4680b21e6576da63c677b5d49f46b477df0
> change-id: 20240517-fchmodat2-5b82867d71fc

> Best regards,


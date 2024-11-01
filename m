Return-Path: <linux-kernel+bounces-392960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063DA9B9A25
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7F0281FC3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9EC1E32D9;
	Fri,  1 Nov 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QHcwywjX"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F141547DC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496255; cv=none; b=uFjkaLxQmsHpQoAMZErWpXdlxk7rirlZV72bI6dY8luYs/9GZIh0ehkcIR1wC5ff9KhpDDqWf4MlT+0sqTQHa2cffhHAcMhuZbOAOy1OVHScIAoYRu7QwJvGc/ArdSloUD74n0V4hXb4PVLAQcRFJNcLBOMCuSY4TfiP6ZGV4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496255; c=relaxed/simple;
	bh=RHL+xF3CVZPqVUcgRw4y78BDHoiWWtviuypjCBEvddo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDFNiO25BZRfgYV+7nfSWpI2ixM3ttnfV/047ClvkYIxf2mPG7RmkvJe+ezwNQ+tZq+uz/IFT7lqRCFTfmNWhp64KKYnM9E+pN+rmN1hbkvnxTAJanar/YThVcrbhW6aAW4MWpyksI9YIwZaFUzCgH8zqPtmtrKIbw1RSbt1Hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QHcwywjX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730496239;
	bh=RHL+xF3CVZPqVUcgRw4y78BDHoiWWtviuypjCBEvddo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHcwywjXb0FycugFwzEM5a7hUoX1wzrKCgSCDw8/lyZ8p1WFU6A7B4mExpD1jf4QH
	 9LDrmiwxlzRzNPmxHPMVGehKKXg6HZaKpt9Nl8vX+S+c9VF9BT9zAC/fYWuB2QTmOE
	 2gT/MeD+tXSYqdy7epX7Lf1GwlSI3uZCvNpGXGk8=
Date: Fri, 1 Nov 2024 21:23:48 +0000
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc changes for v6.13
Message-ID: <ce65b110-259a-4edf-a84b-4015c6160f52@t-8ch.de>
References: <ba23217d-5eaf-4146-8ed7-27289cece364@t-8ch.de>
 <7bac1319-fe1c-454d-b96d-8344bdce3961@t-8ch.de>
 <f9d51d6b-f38e-48bb-be5a-97217fb503c1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9d51d6b-f38e-48bb-be5a-97217fb503c1@paulmck-laptop>

Hi Paul,

On 2024-11-01 13:22:17-0700, Paul E. McKenney wrote:
> On Fri, Nov 01, 2024 at 02:22:13PM +0000, Thomas Weißschuh wrote:
> > (resend to add missing Cc: LKML)
> > 
> > 
> > Hi Paul,
> > 
> > The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> > 
> >   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20241101-for-6.13-1
> > 
> > for you to fetch changes up to ad0558f3883130954ca724697f2d19aef93967b3:
> > 
> >   selftests/nolibc: start qemu with 1 GiB of memory (2024-10-07 21:57:45 +0200)
> 
> Thank you!  I have pulled this into -rcu at signed tag nolibc.2024.11.01a,
> which copies from your signed tag.

Thanks!

> The usual "make run" and "make user" worked fine, but "make libc-test"
> gave me the build errors shown below.  Is there some setup step that
> I omitted?  Or is this not really a necessary test?

That test does not actually test nolibc but the nolibc test suite.
It uses your system libc and makes sure that the nolibc test
expectations match the behaviour of a "real" libc.
The missing strlcat() function was added to glibc only in 2.38, so I
guess you have an older version.
On my glibc 2.40 "make libc-test" works and the test itself succeeds.

I'll see if there is a reasonable to make libc-test work on older glibc.
But it shouldn't impact this cycle.

For better architecture coverage I would recommend ./run-tests.sh over
"make run/user". Speaking about this I remember the discussion from the
6.12 PR where Willy proposed an improved run-tests.sh error message.
It seems he didn't push it as a commit, so let's add keep it in mind for
next cycle.

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>   CC      libc-test
> nolibc-test.c: In function ‘run_syscall’:
> nolibc-test.c:1083:63: warning: argument 1 null where non-null expected [-Wnonnull]
>  1083 |                 CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
>       |                                                               ^~~~
> nolibc-test.c:358:77: note: in definition of macro ‘EXPECT_SYSER2’
>   358 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
>       |                                                                             ^~~~
> nolibc-test.c:1083:47: note: in expansion of macro ‘EXPECT_SYSER’
>  1083 |                 CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
>       |                                               ^~~~~~~~~~~~
> In file included from nolibc-test.c:26:
> /usr/include/x86_64-linux-gnu/sys/stat.h:205:12: note: in a call to function ‘stat’ declared ‘nonnull’
>   205 | extern int stat (const char *__restrict __file,
>       |            ^~~~
> nolibc-test.c: In function ‘run_stdlib’:
> nolibc-test.c:1137:75: warning: implicit declaration of function ‘strlcat’; did you mean ‘strncat’? [-Wimplicit-function-declaration]
>  1137 |                 CASE_TEST(strlcat_0);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 0), buf, 3, "test"); break;
>       |                                                                           ^~~~~~~
> nolibc-test.c:613:80: note: in definition of macro ‘EXPECT_STRBUFEQ’
>   613 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
>       |                                                                                ^~~~
> nolibc-test.c:1143:75: warning: implicit declaration of function ‘strlcpy’; did you mean ‘strncpy’? [-Wimplicit-function-declaration]
>  1143 |                 CASE_TEST(strlcpy_0);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 0), buf, 3, "test"); break;
>       |                                                                           ^~~~~~~
> nolibc-test.c:613:80: note: in definition of macro ‘EXPECT_STRBUFEQ’
>   613 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
>       |                                                                                ^~~~
> nolibc-test.c: In function ‘run_syscall’:
> nolibc-test.c:358:62: warning: argument 1 is null but the corresponding size argument 2 value is 1 [-Wnonnull]
>   358 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
>       |                                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> nolibc-test.c:361:9: note: in expansion of macro ‘EXPECT_SYSER2’
>   361 |         EXPECT_SYSER2(cond, expr, expret, experr, 0)
>       |         ^~~~~~~~~~~~~
> nolibc-test.c:1073:47: note: in expansion of macro ‘EXPECT_SYSER’
>  1073 |                 CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll(NULL, 1, 0), -1, EFAULT); break;
>       |                                               ^~~~~~~~~~~~
> In file included from /usr/include/poll.h:1,
>                  from nolibc-test.c:35:
> /usr/include/x86_64-linux-gnu/sys/poll.h:54:12: note: in a call to function ‘poll’ declared with attribute ‘access (write_only, 1, 2)’
>    54 | extern int poll (struct pollfd *__fds, nfds_t __nfds, int __timeout)
>       |            ^~~~
> /usr/bin/ld: /tmp/ccvUtmw4.o: in function `run_stdlib':
> nolibc-test.c:(.text+0x44f9): undefined reference to `strlcat'
> /usr/bin/ld: nolibc-test.c:(.text+0x4580): undefined reference to `strlcat'
> /usr/bin/ld: nolibc-test.c:(.text+0x4607): undefined reference to `strlcat'
> /usr/bin/ld: nolibc-test.c:(.text+0x468e): undefined reference to `strlcat'
> /usr/bin/ld: nolibc-test.c:(.text+0x4715): undefined reference to `strlcat'
> /usr/bin/ld: /tmp/ccvUtmw4.o:nolibc-test.c:(.text+0x479c): more undefined references to `strlcat' follow
> /usr/bin/ld: /tmp/ccvUtmw4.o: in function `run_stdlib':
> nolibc-test.c:(.text+0x4823): undefined reference to `strlcpy'
> /usr/bin/ld: nolibc-test.c:(.text+0x48aa): undefined reference to `strlcpy'
> /usr/bin/ld: nolibc-test.c:(.text+0x4931): undefined reference to `strlcpy'
> /usr/bin/ld: nolibc-test.c:(.text+0x49b8): undefined reference to `strlcpy'
> /usr/bin/ld: nolibc-test.c:(.text+0x4a3f): undefined reference to `strlcpy'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:230: libc-test] Error 1


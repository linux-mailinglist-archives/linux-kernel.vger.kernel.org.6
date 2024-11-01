Return-Path: <linux-kernel+bounces-392996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE39B9A91
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056582829E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F8D1E32A4;
	Fri,  1 Nov 2024 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laufurh+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E4140E34
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730498646; cv=none; b=AsR/qHOkqTuzzK5qGZgEQp78kv9T7sEKWC1Z0264Cg1+xXAXHjwJg2OeKBWmvqCmIbHyvV8eJNL14N04y0Z76b2iXkzd1eHMcEixOYRQEdEIpoRJL4zK+ZG65YBs6nE/Yn2N9G+m/+fDtF5qoTYEyW1ElmVp0d3yORotEBVneSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730498646; c=relaxed/simple;
	bh=VeBJILimtyXi2Rv9u/2Xi6HbNggbDWCk1XxRFYbsrFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFtUfRduepKS3DviEyQ/SaU1Z5ZcQXfJEwByNKSbvMgoszDH/iZN2spsKhQNDZ6SkWSw5ySCzi2k7abBMPsXvKXkBVNNQrrDnJs4YKIqO/d3Msc16dCqLK3KJb7iadxjldXbMWVo2YlE1g2idaDjZybLyZ/YoZT24YV1cfvPdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laufurh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E779BC4CECD;
	Fri,  1 Nov 2024 22:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730498645;
	bh=VeBJILimtyXi2Rv9u/2Xi6HbNggbDWCk1XxRFYbsrFQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=laufurh+QxQCuxkXyr1DuyoL0xt33+9d42ZeeJZqeu1U3gRVJUUfjWsO+Hxe3zg6m
	 QaCKNj9xbrNhsSx2u3hLclk3mog0vhyNgXSUj5XYnxJH2Zd38Cj0TDlO4zjXHeZzz7
	 34enX9Rn8Uo3Qm4LugTVBYNlJJ2ch/ZT8GyMbWaoELXNogjgPRjWDwg8jhBmKlzrCV
	 ri51uvjEF8mFa60AU+GTg4EO2onmHRNHcxlwOn71GYiBK8lcBeC5GN9CMjWiBa9bbJ
	 MICP31653NxSnpK6Ls6+YSnH1AoQ0YVp5VgxvKNx3TIz1bIHuFM5+DWO9ILdqe88q3
	 bH9ZbGzqPM4Lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 859F9CE0F74; Fri,  1 Nov 2024 15:04:05 -0700 (PDT)
Date: Fri, 1 Nov 2024 15:04:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc changes for v6.13
Message-ID: <b7da7110-92f4-47cc-b69d-6811057e6561@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ba23217d-5eaf-4146-8ed7-27289cece364@t-8ch.de>
 <7bac1319-fe1c-454d-b96d-8344bdce3961@t-8ch.de>
 <f9d51d6b-f38e-48bb-be5a-97217fb503c1@paulmck-laptop>
 <ce65b110-259a-4edf-a84b-4015c6160f52@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce65b110-259a-4edf-a84b-4015c6160f52@t-8ch.de>

On Fri, Nov 01, 2024 at 09:23:48PM +0000, Thomas Weißschuh wrote:
> Hi Paul,
> 
> On 2024-11-01 13:22:17-0700, Paul E. McKenney wrote:
> > On Fri, Nov 01, 2024 at 02:22:13PM +0000, Thomas Weißschuh wrote:
> > > (resend to add missing Cc: LKML)
> > > 
> > > 
> > > Hi Paul,
> > > 
> > > The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> > > 
> > >   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20241101-for-6.13-1
> > > 
> > > for you to fetch changes up to ad0558f3883130954ca724697f2d19aef93967b3:
> > > 
> > >   selftests/nolibc: start qemu with 1 GiB of memory (2024-10-07 21:57:45 +0200)
> > 
> > Thank you!  I have pulled this into -rcu at signed tag nolibc.2024.11.01a,
> > which copies from your signed tag.
> 
> Thanks!
> 
> > The usual "make run" and "make user" worked fine, but "make libc-test"
> > gave me the build errors shown below.  Is there some setup step that
> > I omitted?  Or is this not really a necessary test?
> 
> That test does not actually test nolibc but the nolibc test suite.
> It uses your system libc and makes sure that the nolibc test
> expectations match the behaviour of a "real" libc.
> The missing strlcat() function was added to glibc only in 2.38, so I
> guess you have an older version.
> On my glibc 2.40 "make libc-test" works and the test itself succeeds.
> 
> I'll see if there is a reasonable to make libc-test work on older glibc.
> But it shouldn't impact this cycle.

I expect I will be upgrading at some point, so this might not be worth
worrying about unless others are also running into it.

> For better architecture coverage I would recommend ./run-tests.sh over
> "make run/user". Speaking about this I remember the discussion from the
> 6.12 PR where Willy proposed an improved run-tests.sh error message.
> It seems he didn't push it as a commit, so let's add keep it in mind for
> next cycle.

Makes sense to me!

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> >   CC      libc-test
> > nolibc-test.c: In function ‘run_syscall’:
> > nolibc-test.c:1083:63: warning: argument 1 null where non-null expected [-Wnonnull]
> >  1083 |                 CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
> >       |                                                               ^~~~
> > nolibc-test.c:358:77: note: in definition of macro ‘EXPECT_SYSER2’
> >   358 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
> >       |                                                                             ^~~~
> > nolibc-test.c:1083:47: note: in expansion of macro ‘EXPECT_SYSER’
> >  1083 |                 CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
> >       |                                               ^~~~~~~~~~~~
> > In file included from nolibc-test.c:26:
> > /usr/include/x86_64-linux-gnu/sys/stat.h:205:12: note: in a call to function ‘stat’ declared ‘nonnull’
> >   205 | extern int stat (const char *__restrict __file,
> >       |            ^~~~
> > nolibc-test.c: In function ‘run_stdlib’:
> > nolibc-test.c:1137:75: warning: implicit declaration of function ‘strlcat’; did you mean ‘strncat’? [-Wimplicit-function-declaration]
> >  1137 |                 CASE_TEST(strlcat_0);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 0), buf, 3, "test"); break;
> >       |                                                                           ^~~~~~~
> > nolibc-test.c:613:80: note: in definition of macro ‘EXPECT_STRBUFEQ’
> >   613 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
> >       |                                                                                ^~~~
> > nolibc-test.c:1143:75: warning: implicit declaration of function ‘strlcpy’; did you mean ‘strncpy’? [-Wimplicit-function-declaration]
> >  1143 |                 CASE_TEST(strlcpy_0);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 0), buf, 3, "test"); break;
> >       |                                                                           ^~~~~~~
> > nolibc-test.c:613:80: note: in definition of macro ‘EXPECT_STRBUFEQ’
> >   613 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
> >       |                                                                                ^~~~
> > nolibc-test.c: In function ‘run_syscall’:
> > nolibc-test.c:358:62: warning: argument 1 is null but the corresponding size argument 2 value is 1 [-Wnonnull]
> >   358 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
> >       |                                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > nolibc-test.c:361:9: note: in expansion of macro ‘EXPECT_SYSER2’
> >   361 |         EXPECT_SYSER2(cond, expr, expret, experr, 0)
> >       |         ^~~~~~~~~~~~~
> > nolibc-test.c:1073:47: note: in expansion of macro ‘EXPECT_SYSER’
> >  1073 |                 CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll(NULL, 1, 0), -1, EFAULT); break;
> >       |                                               ^~~~~~~~~~~~
> > In file included from /usr/include/poll.h:1,
> >                  from nolibc-test.c:35:
> > /usr/include/x86_64-linux-gnu/sys/poll.h:54:12: note: in a call to function ‘poll’ declared with attribute ‘access (write_only, 1, 2)’
> >    54 | extern int poll (struct pollfd *__fds, nfds_t __nfds, int __timeout)
> >       |            ^~~~
> > /usr/bin/ld: /tmp/ccvUtmw4.o: in function `run_stdlib':
> > nolibc-test.c:(.text+0x44f9): undefined reference to `strlcat'
> > /usr/bin/ld: nolibc-test.c:(.text+0x4580): undefined reference to `strlcat'
> > /usr/bin/ld: nolibc-test.c:(.text+0x4607): undefined reference to `strlcat'
> > /usr/bin/ld: nolibc-test.c:(.text+0x468e): undefined reference to `strlcat'
> > /usr/bin/ld: nolibc-test.c:(.text+0x4715): undefined reference to `strlcat'
> > /usr/bin/ld: /tmp/ccvUtmw4.o:nolibc-test.c:(.text+0x479c): more undefined references to `strlcat' follow
> > /usr/bin/ld: /tmp/ccvUtmw4.o: in function `run_stdlib':
> > nolibc-test.c:(.text+0x4823): undefined reference to `strlcpy'
> > /usr/bin/ld: nolibc-test.c:(.text+0x48aa): undefined reference to `strlcpy'
> > /usr/bin/ld: nolibc-test.c:(.text+0x4931): undefined reference to `strlcpy'
> > /usr/bin/ld: nolibc-test.c:(.text+0x49b8): undefined reference to `strlcpy'
> > /usr/bin/ld: nolibc-test.c:(.text+0x4a3f): undefined reference to `strlcpy'
> > collect2: error: ld returned 1 exit status
> > make: *** [Makefile:230: libc-test] Error 1


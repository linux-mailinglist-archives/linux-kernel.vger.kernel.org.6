Return-Path: <linux-kernel+bounces-398964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A1E9BF88E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8D91F23734
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC8020CCDF;
	Wed,  6 Nov 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laas.fr header.i=@laas.fr header.b="nG86iHVo"
Received: from laas.laas.fr (laas.laas.fr [140.93.0.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C820C47E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.93.0.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928862; cv=none; b=Ykx5Gr8pFwr9a3dKwmv2TBLHIcx6SyVLeBjBqJOmDtkdBK9Ph7C20GXXneG9tDKyT9ssspkzXL4QeVoXyrg132U3Gb+xCSLN0/dSXpeV9sl8cWKVgKIVXJFMrI9Q4p/jhGOGVZuKGH9ASpxn3C0e+aafoAtfX/ImZCB0ks8sgcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928862; c=relaxed/simple;
	bh=p3EdMN5YxUjIjgcd2QoxnSqoHgDWCXsbx1F6vAXJRe8=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject; b=LXEyW67jTp/D7CDb7w/qlIxb+74n2IENvieLTrSIh4Oeqh+D18VGqo9Gd6Q5c7KnzUBNXxX3nutVnSDs/FpvvhRumOYsrEI+/qNFAOAX+cqIaAKPD1PSJObRkSGbz4eKkoCBtDh6/AFo2ZGyHnpmL7BsSgGz0pCTdr8v1dOoivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laas.fr; spf=pass smtp.mailfrom=laas.fr; dkim=pass (1024-bit key) header.d=laas.fr header.i=@laas.fr header.b=nG86iHVo; arc=none smtp.client-ip=140.93.0.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laas.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laas.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=laas.fr; h=
	mime-version:content-type:content-transfer-encoding:message-id
	:date:from:to:cc:subject; s=20240315; bh=p3EdMN5YxUjIjgcd2QoxnSq
	oHgDWCXsbx1F6vAXJRe8=; b=nG86iHVobXtZ92OIDPLa34tWBfEy4mopx+Jg4mb
	a2IFuJP74oYkvYGhpvX5cqrM4b9FMZ30ro0BgXfZJO3WeRR/COXg8rMk1XUIuvrw
	vs4Vg5OOZR4y5vTSxdMm1w3TUBqPkRiurjP7HXyFqCqe0axSu9xuPftbmEg0RhrI
	tvcE=
Received: from cactus.useless-ficus.net (useless-ficus.net [IPv6:2001:470:7ffe:0:0:0:0:cafe])
	(authenticated bits=0)
	by laas.laas.fr (8.18.1/8.16.0.29) with ESMTPSA id 4A6LTmtd056595
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 6 Nov 2024 22:29:51 +0100 (CET)
Received: from ficus.useless-ficus.net (ficus.useless-ficus.net [IPv6:2001:470:7ffe:1::1])
	by cactus.useless-ficus.net (Postfix) with ESMTP id D8A2AA6;
	Wed,  6 Nov 2024 22:29:44 +0100 (CET)
Received: by ficus.useless-ficus.net (Postfix, from userid 1001)
	id D0DCA60557C; Wed,  6 Nov 2024 22:29:44 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	 boundary="2odsP31YlV"
Content-Transfer-Encoding: 7bit
Message-ID: <26411.57288.238690.681680@gargle.gargle.HOWL>
Date: Wed, 6 Nov 2024 22:29:44 +0100
From: Anthony Mallet <anthony.mallet@laas.fr>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: posix timer freeze after some random time, under pthread create/destroy load
X-Mailer: VM 8.2.0b under 28.2 (x86_64--netbsd)
X-Scanned-By: MIMEDefang 3.4


--2odsP31YlV
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Hi,

I'm facing an issue with posix timers configured to send SIGALRM
signal upon expiry. The symptom is that the timer randomly freezes
(the signal handler not triggered anymore). After analysis, this happens
in combination with pthreads creation / destruction.

I have attached a test case that can reliably reproduce my issue on
affected kernels. It involves creating a timer that increments a
global counter at each tick, while the main thread is spawning and
destroying other threads. At some point, the counter gets stalled. In
the context of this test case, I do heavy thread creation and
destruction, so that the issue triggers almost immediately. Regarding
the real-world issue, it happens in the context of aio(7) work, which
also involves thread creation and destruction but presumably at a much
lower rate, and the issue consequently triggers much less often.

I could reproduce the issue reliably with mainline kernels from 6.4
to 6.11 (included), and on several distributions, different hardware
and glibc versions. Kernels earlier than 6.3 (included) do not exhibit
the problem at all.

Once the issue triggers, simply resetting the timer (with
timer_settime(2)) makes it work again, until next
stall. timer_gettime(2) does not show garbage and the values are still
as expected. Only the signal handler is not called. Manually sending
SIGALRM with raise(SIGALRM) also works and invokes the signal handler
as expected.

Also note that using setitimer(2) instead of a posix timer does not
show any problem with the same test program.

Before filling a proper bug report, I wanted to have your opinion
about this. This e-mail is already probably too long for an
introduction, but I can of course provide you with any missing detail
that you would deem necessary.

Thanks for you attention,
Anthony Mallet


--2odsP31YlV
Content-Type: text/plain;
	 name="timer.c"
Content-Disposition: inline;
	 filename="timer.c"
Content-Transfer-Encoding: 7bit

/* Public domain - Anthony Mallet on Mon Nov  4 2024 */

#include <err.h>
#include <errno.h>
#include <pthread.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>

static volatile int ticks;

/* SIGALRM handler */
void
tick(int arg)
{
  (void)arg; /* unused */

  /* global counter - even if access is not atomic, we don't care here as the
   * exact value is not used, only the fact that the value changes is relevant
   */
  ticks++;
}

/* thread forking thread */
void *
thr(void *arg)
{
  pthread_attr_t attr;
  pthread_t t;
  (void)arg; /* unused */

  /* spawn a new thread in detached state so that we don't grow too much */
  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
  if (pthread_create(&t, &attr, thr, NULL))
    err(2, "pthread_create");

  return NULL;
}

int
main()
{
  int hz = 1000; /* 1kHz timer - the higher, the faster the issue happens */

  struct sigaction act;
  struct itimerspec tv;
  struct timespec pts, ts, rem;
  sigset_t sigset;
  timer_t timer;
  int i, c1, c2;

  /* SIGALRM handler */
  act.sa_handler = tick;
  sigemptyset(&act.sa_mask);
  act.sa_flags = 0;
  if (sigaction(SIGALRM, &act, NULL) == -1)
    err(2, "sigaction");

  sigemptyset(&sigset);
  sigaddset(&sigset, SIGALRM);
  if (pthread_sigmask(SIG_UNBLOCK, &sigset, NULL) == -1)
    err(2, "pthread_sigmask");


  /* SIGALRM timer at 'hz' frequency */
  if (timer_create(CLOCK_REALTIME, NULL, &timer) == -1)
    err(2, "timer_create");

  tv.it_interval.tv_nsec = 1000000000/hz;
  tv.it_interval.tv_sec = 0;
  tv.it_value = tv.it_interval;


  /* thread forking threads - this is an issue spotted on ubuntu-22.04 and
   * 24.04, as well as other distributions, that affects timer signal
   * delivrery. This seems to affect kernels from 6.4 to 6.11 inclusive. */
  thr(NULL);


  /* start timer */
  if (timer_settime(timer, 0, &tv, NULL) == -1)
    err(2, "timer_settime");

  /* 100 periods delay */
  pts.tv_sec = 0;
  pts.tv_nsec = tv.it_interval.tv_nsec * 100; /* 100ms */
  while(pts.tv_nsec >= 1000000000) {
    pts.tv_nsec -= 1000000000;
    pts.tv_sec++;
  }
  /* for 1s */
  for (i = 0; i < 10; i++) {
    ts = pts;
    c1 = ticks;
    while (nanosleep(&ts, &rem) != 0 && errno == EINTR) ts = rem;
    c2 = ticks;

    if (c1 == c2) {
      /* the counter is stuck, SIGALRM not firing anymore */
      fprintf(stderr, "SIGALRM issue after %d ticks\n", c1);

      /* just resetting the timer at this point makes it work again: */
      /* timer_settime(timer, 0, &tv, NULL); */
      /* (the issue will trigger again after some time) */

      /* also note that timer_gettime(timer, &tv) will show both correct
       * tv.it_interval and tv.it_value changing normally */

      /* manually sending SIGALRM also still works: */
      /* raise(SIGALRM); */

      return 2;
    }
  }

  printf("OK, no issue\n");
  return 0;
}

--2odsP31YlV--


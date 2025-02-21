Return-Path: <linux-kernel+bounces-525683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C35A3F324
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D409119C1DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722A209689;
	Fri, 21 Feb 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="PhUhWAUO"
Received: from smtpcmd10101.aruba.it (smtpcmd10101.aruba.it [62.149.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2036209671
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137993; cv=none; b=P0pLeVa2i+XyaAue5TfCnbl/8crnvLVz4vhuJ5UYt7RErXnNHrDohEDOpbK62TYYYz4nRQG99qeiXqgDiKR/6KaIdgfhr7l1+8HYpISiLR/vinS01JHMLVXV+8TPVgEOlyyN4xJhrBnRAn2OdrbAYUguetBtJW79LQ6rzpAE0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137993; c=relaxed/simple;
	bh=ecnRFDGZEbSlAbXsCT3MFiq7C2g4sJV6p0HMIMrtKTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oglXaY6p/Yyv4H0DH2KA97qvvml4tInMe1CrtotvIpvAs1+YrNRJaFmV6rlDQ33/DWBniFXL4uXijrMBQFkpYdjSRKVQoYk4E98rX6tAIEixDx7i7NnjSjZRuDqGxxNzB51ln5y93+YoBaWpNq0JgYoMXHWw8HULOdx+aWx338U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=PhUhWAUO; arc=none smtp.client-ip=62.149.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id lRNitd9Ir1ugblRNit8C3b; Fri, 21 Feb 2025 12:39:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1740137986; bh=ecnRFDGZEbSlAbXsCT3MFiq7C2g4sJV6p0HMIMrtKTo=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=PhUhWAUOw/j10LH3d35O2lKU9fIq337ifLlTwlPB4H50MB82TwyusbSIuN7LTmFaj
	 oZVZxmAFqrwBucb92Y6klNEysDXJNEyDUZA+oYkPhhGvGsMaql+w4jWqj4a3EKi+kt
	 htV2tN+sMJeC0A2uYvk89LIlG/wUUIz3SY//hDSkNaE52NodQHIlCJL2jzxvL/ToiO
	 YlQopVFuSVp1P+9EBgSuEkLWFWkbuP9GrIcJVWVfsFnqwhd0HFRhGfQnwTIvZd0LYM
	 ZULcXjZTGKydrMiUhQhWydSqd24yhsIPzC7zQSeJ+iKyrdd63oybd71P6vkcCmkqEy
	 E43A8dNda3UQA==
Message-ID: <9d9f2a9a-ab90-4fbf-bc0e-d4c8b83d7082@enneenne.com>
Date: Fri, 21 Feb 2025 12:39:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH] pps: add epoll support
Content-Language: en-US
To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <40322dd7ce0243b6bc89b21d8884980b@diehl.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <40322dd7ce0243b6bc89b21d8884980b@diehl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEF7QPtJwbKUz3Q1DHWVKwyjOi2leLg2zoQqB+7aUnDUS0X8iESs0A+o5PLebOAK+xPRf2pGLuWnb72A5Cm4bHCZaeR6w0It/+igEB1JBq0i+iMShjEa
 JKKavXvWufVPIh1fPFzHgRyXqz750g7U3dMkcvN+lGvlQCsZNES/U7ymAfAgxO6gPLkios4xTQeB95jcPxYQMsMhOMtLNK8IEQZYf9RcYXVYiMCHFxWgcKfL
 lE8JyxA265MZ8yl+jRcZrA==

On 21/02/25 11:49, Denis OSTERLAND-HEIM wrote:
> Hi,
> 
> Okay, if poll is expected to work, than we have a bug.
> Actually a pretty old one.
> 
> pps_cdev_poll() uncoditionally returns (EPOLLIN | EPOLLRDNORM), which results in poll() will return immediately with data available
> (EPOLLIN | EPOLLRDNORM).
> To avoid this, you need conditionally return 0.

I think you are right!

Looking at the code I think the correct patch should be:

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 6a02245ea35f..7a52bb9f835b 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -41,7 +41,7 @@ static __poll_t pps_cdev_poll(struct file *file, poll_table *wait)

         poll_wait(file, &pps->queue, wait);

-       return EPOLLIN | EPOLLRDNORM;
+       return pps->info.mode & PPS_CANWAIT ? 0 : EPOLLIN | EPOLLRDNORM;
  }

  static int pps_cdev_fasync(int fd, struct file *file, int on)

> My patch adds a context per open file to store the last_ev value when ioctl(PPS_FETCH) is invoked and uses this last_ev in poll as
> condition.
> 
> Sorry, for the missing memset(&fdata, 0, sizeof(fdata)).
> Intention was set to 0, yes.

OK

> ```c
> #include <stdio.h>
> #include <string.h>///home/giometti/Projects/ailux/imx9/linux/linux-imx
> #include <poll.h>
> #include <fcntl.h>
> #include "timepps.h"
> 
> int main(int argc, const char* argv[]) {
>      struct pollfd instance = { .fd = open((argc > 1) ? argv[1] : "/dev/pps0", O_RDONLY), .events = POLLIN|POLLERR , .revents = 0 };
>      pps_handle_t pps_handle;
>      static const struct timespec timeout = { 0, 0 };
>      if (time_pps_create(instance.fd, &pps_handle)) {
>          perror("failed to create pps handle");
>          return 1;
>      }
>      for (int loops = 4; --loops; ) {
>          pps_info_t pps_info;
>          memset(&pps_info, 0, sizeof(pps_info));
>          if (!poll(&instance, 1, 2000/*ms*/)) {
>              printf("timeout");
>              continue;
>          }
>          if ((instance.revents & POLLIN) != POLLIN) {
>              printf("nothing to read?");
>              continue;
>          }
>          if (time_pps_fetch(pps_handle, PPS_TSFMT_TSPEC, &pps_info, &timeout)) {
>              perror("failed to fetch");
>              return 1;
>          }
> 
>          printf(
>              "assert: %lu\ntime: %ld.%09ld\n",
>              pps_info.assert_sequence,
>              pps_info.assert_tu.tspec.tv_sec,
>              pps_info.assert_tu.tspec.tv_nsec
>          );
>      }
>      return 0;
> }
> ```
> 
> Currently output looks like:
> ```
> $ cat /sys/class/pps/pps0/assert; ./test /dev/pps0
> 1520598954.468882076#60
> assert: 60
> time: 1520598954.468882076
> assert: 60
> time: 1520598954.468882076
> assert: 60
> time: 1520598954.468882076
> ```
> 
> You see no waits between the loops.

Please, try again with the above patch.

However, before doing the test, you should consider to add this patch too:

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 6a02245ea35f..7a52bb9f835b 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -56,10 +56,13 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct 
pps_fdata *fdata)
         int err = 0;

         /* Manage the timeout */
-       if (fdata->timeout.flags & PPS_TIME_INVALID)
-               err = wait_event_interruptible(pps->queue,
+       if (fdata->timeout.flags & PPS_TIME_INVALID) {
+               if (pps->info.mode & PPS_CANWAIT)
+                       err = wait_event_interruptible(pps->queue,
                                 ev != pps->last_ev);
-       else {
+               else
+                       return -EOPNOTSUPP;
+       } else {
                 unsigned long ticks;

                 dev_dbg(&pps->dev, "timeout %lld.%09d\n",
@@ -69,12 +72,15 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct 
pps_fdata *fdata)
                 ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);

                 if (ticks != 0) {
-                       err = wait_event_interruptible_timeout(
+                       if (pps->info.mode & PPS_CANWAIT) {
+                               err = wait_event_interruptible_timeout(
                                         pps->queue,
                                         ev != pps->last_ev,
                                         ticks);
-                       if (err == 0)
-                               return -ETIMEDOUT;
+                               if (err == 0)
+                                       return -ETIMEDOUT;
+                       } else
+                               return -EOPNOTSUPP;
                 }
         }

In fact RFC2783 states:

3.4.3 New functions: access to PPS timestamps

...
    Support for blocking behavior is an implementation option.  If the
    PPS_CANWAIT mode bit is clear, and the timeout parameter is either
    NULL or points to a non-zero value, the function returns an
    EOPNOTSUPP error.  An application can discover whether the feature is
    implemented by using time_pps_getcap() to see if the PPS_CANWAIT mode
    bit is set.
...

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming



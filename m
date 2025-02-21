Return-Path: <linux-kernel+bounces-525439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00807A3EFFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA08189E03B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB07204C11;
	Fri, 21 Feb 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="EXRnOVyr"
Received: from smtpcmd10101.aruba.it (smtpcmd10101.aruba.it [62.149.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52377204099
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129670; cv=none; b=goO2tnwUfA9Na70bBDjxdEIhkrh+ggXgu9ZJ/2//tdSQ+xWb7sp7KBYq06HkGUZYNQ1nFUw4WJlkSGjnhFcbYe2TAPGdtrp0loFvERJ+MIgO8aBcC7STyXPUbza/vtr9fP9LQroB1VDCIW0VhWL+ZS78B5RKcb3HQj7GONzBi1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129670; c=relaxed/simple;
	bh=tIQm/jO7eNjLFdx54naVskws4KFEWsapyGpZiNLShZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzQEriJFV6j+d+lAb4f555QvVHb2fzPKcB0IpVT1zTuPUhTzQZGdkaKdmWch5fTMKNrMIbS0rck3fBVOHt/wdw2jx0EfKA9pXVUzqgvjFXswzqCh3VanI2k3XK/Uft5yHB2Q2rsGmFQ8lpI7nOLQLtLk+fZUh4ruOUGyqtNsBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=EXRnOVyr; arc=none smtp.client-ip=62.149.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id lPARtb3Ab1ugblPASt6iqe; Fri, 21 Feb 2025 10:17:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1740129476; bh=tIQm/jO7eNjLFdx54naVskws4KFEWsapyGpZiNLShZU=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=EXRnOVyrRMFZ6TrSax3W+ml+zdJv7vK0VYtEidlDFwh+uGDo1EJzX9QJojhZPSGd5
	 VYini5DhQdq5lsiMdERCX3tTvOoGdgvZc7DZLthW/T1bJ3SuPkcc6myuRF1eC46s+Q
	 DtuBrv9I8Ztpbhcf8g9Q/yKRlmFLt1otS3xHkdhH3Ro8Sqc0BtfKo2kD5w5gBJWQ5W
	 xl6BaA3atS8gxiC1IxsXyXpsY6z0RoFmX+opOWzKTVk+JT69gunoEWVGjUzrtdir76
	 8W3Nn/duxt6cOYQsF6X8dmQ9+L6SycD7RBnfZvSeZoxm9TISC7xGL83BV1ywpcGTiu
	 8VEvKFBSxuX0w==
Message-ID: <9a7ddaae-83ff-440d-8423-58178dfb76cd@enneenne.com>
Date: Fri, 21 Feb 2025 10:17:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: add epoll support
Content-Language: en-US
To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <8baae1732dfc47759687e7537cac57ad@diehl.com>
 <09e91710-c1db-415f-b010-b27a3712fb13@enneenne.com>
 <456070491e3642e9a6017ff7d3bb982b@diehl.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <456070491e3642e9a6017ff7d3bb982b@diehl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAqt92AigK7AnxyhQQ3AnPZ1YoG22nwVqGOv/jHfA1z5DIfLfHIEk+LcY5y9zImTzuLSuoxfjqQ3NxGRYOq/fUW6Is+Ob/ENleHSkc8+lMx0NkRvsjvc
 /8De4/v+M3JaZjtfIGcrg5b0SAi0YqA8tGxZ+MgdDS5p8OqffkFtAp03k9GDzyzR00MJx6YcRgMghVlQSh0dVznZMptmFRx23KVJ29qK0WKDi199A0zjsGaF
 KkH81/g+BJ+aMOqhsPeDow==

On 20/02/25 17:45, Denis OSTERLAND-HEIM wrote:
> Hi,
> 
> Thanks for the fast answer.
> 
> -----Original Message-----
> From: Rodolfo Giometti <giometti@enneenne.com>
> Sent: Thursday, February 20, 2025 9:51 AM
> To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH] pps: add epoll support
> 
>> Can you explain it a bit better?
> I will do my best.
> 
> In an application, that has more to do than just dealing with one PPS device,
> to use PPS_FETCH with a timeout until next event, you need a thread which can sleep.

Why are you saying that? If you use blocking I/O with a timeout in the poll() it 
should work.

> I would really like to avoid threads and the resulting synchronization complexity.
> 
> Alternative is to fetch the current assert value in at least twice the expected fequency.
> This would definetly work, but epoll is the more efficent way to do.
> 
> Without epoll in one thread:
> ```c
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/pps.h>
> 
> struct per_pps {
>      int dev_fd;
>      struct pps_fdata fdata;
>      unsigned int last_assert;
> };
> 
> int main(int argc, const char* argv[]) {
>      int ret = 0;
>      struct per_pps instances[] = {
>          { .dev_fd = open((argc > 1) ? argv[1] : "/dev/pps0", O_RDONLY) },
>          { .dev_fd = open((argc > 2) ? argv[2] : "/dev/pps1", O_RDONLY) }
>      };
>      if (instances[0].dev_fd < 0 || instances[1].dev_fd < 0) {
>          perror("failed to open dev");
>          ret = 1;
>          goto out;
>      }
> 
>      for (int loops = 10; --loops;) {
>          for (int i = 0; i < 2; ++i) {
>              if (ioctl(instances[i].dev_fd, PPS_FETCH, &instances[i].fdata) < 0) {

fdata is not initialized here... is it set to all zero?

>                  perror("failed to fetch data");
>                  ret = 1;
>                  goto out;
>              }
> 
>              if (instances[i].last_assert != instances[i].fdata.info.assert_sequence) {
>                  instances[i].last_assert = instances[i].fdata.info.assert_sequence;
>                  printf(
>                      "assert: %u\ntime: %lld.%09d\n",
>                      instances[i].fdata.info.assert_sequence,
>                      instances[i].fdata.info.assert_tu.sec,
>                      instances[i].fdata.info.assert_tu.nsec
>                  );
>              }
> 
>          }
>          usleep(300000);
>      }
> 
> out:
>      if (instances[0].dev_fd >= 0)
>          close(instances[0].dev_fd);
>      if (instances[1].dev_fd >= 0)
>          close(instances[1].dev_fd);
>      return ret;
> }
> ```
> 
> Syscalls are pretty expensive and epoll allows use to reduce them.
> 
> ```c
> #include <stdio.h>
> #include <string.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/pps.h>
> #include <poll.h>
> 
> int main(int argc, const char* argv[]) {
>      int ret = 0;
>      struct pollfd instances[] = {
>          { .fd = open((argc > 1) ? argv[1] : "/dev/pps0", O_RDONLY), .events = POLLIN|POLLERR , .revents = 0 },
>          { .fd = open((argc > 2) ? argv[2] : "/dev/pps1", O_RDONLY), .events = POLLIN|POLLERR , .revents = 0 }
>      };
>      if (instances[0].fd < 0 || instances[1].fd < 0) {
>          perror("failed to open dev");
>          ret = 1;
>          goto out;
>      }
> 
>      for (int loops = 4; --loops;) {
>          if(poll(instances, 2, 2000/*ms*/)) {

Here you are using poll()...

>              struct pps_fdata fdata;
>              for (int i = 0; i < 2; ++i) {
>                  if ((instances[i].revents & POLLIN) != POLLIN)
>                      continue;
> 
>                  if (ioctl(instances[i].fd, PPS_FETCH, &fdata) < 0) {

Again, fdata is not initialized here...

>                      perror("failed to fetch data");
>                      ret = 1;
>                      goto out;
>                  }
> 
>                  printf(
>                      "assert: %u\ntime: %lld.%09d\n",
>                      fdata.info.assert_sequence,
>                      fdata.info.assert_tu.sec,
>                      fdata.info.assert_tu.nsec
>                  );
>              }
>          } else {
>              printf("time-out\n");
>          }
>      }
> 
> out:
>      if (instances[0].fd >= 0)
>          close(instances[0].fd);
>      if (instances[1].fd >= 0)
>          close(instances[1].fd);
>      return ret;
> }
> ```

I think you should try current LinuxPPS implementation but with proper fdata 
initialization.

>> RFC2783 states that to access to PPS timestamps we should use the
>> time_pps_fetch() function, where we may read:
>>
>> 3.4.3 New functions: access to PPS timestamps
>>
>>     The API includes one function that gives applications access to PPS
>>     timestamps.  As an implementation option, the application may request
>>     the API to block until the next timestamp is captured.  (The API does
>>     not directly support the use of the select() or poll() system calls
>>     to wait for PPS events.)
>>
>> How do you think to use this new select()/poll() support without breaking the
>> RFC2783 compliance?
> To me RFC reads like the spcification of pps-tools/timepps.h and not the one for the char device.

Yes, but the char device used to implement the PPS API should work with 
select()/poll()!

> 3.4.1 New functions: obtaining PPS sources
> ...
>     The definition of what special files are appropriate for use with the
>     PPS API is outside the scope of this specification, and may vary
>     based on both operating system implementation, and local system
>     configuration.
> 
> To me "The API does not directly support the use of the select() or poll() system calls" simply means:
>     there is no wrapper function that calls select() or poll() for you

I agree.

> I do not see why an additional function of the underlying character device would break the API.
> You may just do not use it and everything works like before.
> But I see your point.
> If the char dev interface is ment to be the RFC interface only, there is no need to support epoll.
> Maybe it would be better to add epoll support to sysfs assert/clear?

As far as I know, epoll() uses the kernel select/poll mechanism and this support 
should work correctly at the moment. If no, we have to fix it.

Try your code with the current LinuxPPS implementation replacing the ioctl(fd, 
PPS_FETCH &fdata) with:

     time_pps_fetch(instances[i].fd, PPS_TSFMT_TSPEC, &info, NULL);

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming



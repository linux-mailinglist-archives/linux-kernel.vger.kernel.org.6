Return-Path: <linux-kernel+bounces-529711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB54A42A20
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB1617424F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0A149DF4;
	Mon, 24 Feb 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="Ce40eeyP"
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D625B674
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418743; cv=none; b=bYNRfZkuIl8d12SzSZ02RtMXtuSb736S5/j56zF89DKUUWOGAuBM9gwwBeciVpOsoYMHKNcCGIwHJ4AL10CYSxQ0tKJffFIM0NB+h+wINOj1hBXjjruK0oIG8aHULqdsnX+VwQsHihryOo8lIRI2uvmSLX5JVPs+VnuqxrrVgt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418743; c=relaxed/simple;
	bh=8jZdM9hdLypnK+zXNo8nY01Cw/wyyYPHXWuHDBXcohw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGVNK4LTIoOeJiOQLiMgirf5ogWE8rSdJivwwjwbINw9KXWBqY1gVZ/NIlgNcpmB+EJfbi4qEtxWXnq6rc7EXQ5IXtIBM5qAVc4d9ZQ8b0U9Ecb1EKcwk113SOgg53mVgNlx5BqdpgmmjfgAPZfv+ZkY+RIQ4ZP1uYDfU19+1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=Ce40eeyP; arc=none smtp.client-ip=62.149.158.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id mcPptSVE6NbHHmcPptK3rl; Mon, 24 Feb 2025 18:38:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1740418730; bh=8jZdM9hdLypnK+zXNo8nY01Cw/wyyYPHXWuHDBXcohw=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=Ce40eeyPZ7KqYzLIMh8KC7DQVptBuwLXggKzAKLOs3sDleXvDMKCoeNK4jzotvldt
	 svmmZOMAQbzgmw8n0bUGIn9ae9d/Vspui+YeEv/X0du8xcsnEliXJSCnfkzFTCElAm
	 oAaSu2sNrTqVFtledABH6JxDVujW0cJe1blGbOIy31KCg58Z461/ls+VEThXsywuQr
	 BzjrWV12eEOpMmDMW9cX5zPhQAHFS6cOIc2eJ6L9TkHE9HyaCxtz42HHa5VFxdLUV/
	 r77K0QuDG1KLDc3T85/AiMbRVylnus68fMDD+BN+hY31hQjo1d39TkW1E9UZnpw/NO
	 ZEhdV2I+4AmTQ==
Message-ID: <97190cf3-259e-4a3c-93c1-83a86416ff3a@enneenne.com>
Date: Mon, 24 Feb 2025 18:38:49 +0100
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
References: <0653b036d2b44d57914f8cb3e405aa0d@diehl.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <0653b036d2b44d57914f8cb3e405aa0d@diehl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfO6tR4imTim59XmQmz0rO0uE5Er2DA39TJWkn6xW6OI2OF2fwVX3iaQC43R6ng5ancEgxO0o35CkmmpfhizmRlvUv2Q0Hhghqsq1czo0B0uYpEP1nwfW
 LFDSpFaLCmmMc2MYNTn6WiKoCRO+ryPy1vqfHuVDxGFn1VspyicA5v+QPr36J1oFqX5b58cJAuzS03anvkXzIzDYP1ueOH4+dAP1zJiW1jr7PR+36vGUgW/b
 OSFvuzXmo8jf9d4xU5PAGQ==

On 24/02/25 12:38, Denis OSTERLAND-HEIM wrote:
> Hi,
> 
> I tested it today and that patch creates not the expected behavior.

[snip]

> The idea is to use poll to wait for the next data become available.
> The should poll work like `wait_event_interruptible(pps->queue, ev != pps->last_ev)`,
> where `poll_wait(file, &pps->queue, wait)` already does the first part,
> but the condition `ev != pps->last_ev` is missing.
> 
> Poll shall return 0 if ev == ps->last_ev
> and shall return EPOLLIN if ev != ps->last_ev; EPOLLRDNORM is equivalent[^1] so better return both
> 
> In case of ioctl(PPS_FETCH) ev is stored on the stack.
> If two applications access one pps device, they both get the right result, because the wait_event uses the ev from their stack.
> To do so with poll() ev needs to be available via file, because every applications opens a sepate file and the file is passed to poll.
> That is what my patch does.
> It adds a per file storage so that poll has the ev value of the last fetch to compare.

I agree, but are you sure that your solution will save you in case of fork()? 
So, why don't simply add a new variable as below?

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 6a02245ea35f..dded1452c3a8 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -40,8 +40,11 @@ static __poll_t pps_cdev_poll(struct file *file, poll_table 
*wait)
         struct pps_device *pps = file->private_data;

         poll_wait(file, &pps->queue, wait);
+       if (pps->info.mode & PPS_CANWAIT)
+               if (pps->fetched_ev != pps->last_ev)
+                       return EPOLLIN | EPOLLRDNORM;

-       return EPOLLIN | EPOLLRDNORM;
+       return 0;
  }

  static int pps_cdev_fasync(int fd, struct file *file, int on)
@@ -186,9 +195,11 @@ static long pps_cdev_ioctl(struct file *file,
                 if (err)
                         return err;

-               /* Return the fetched timestamp */
+               /* Return the fetched timestamp and save last fetched event  */
                 spin_lock_irq(&pps->lock);

+               pps->last_fetched_ev = pps->last_ev;
+
                 fdata.info.assert_sequence = pps->assert_sequence;
                 fdata.info.clear_sequence = pps->clear_sequence;
                 fdata.info.assert_tu = pps->assert_tu;
@@ -272,9 +283,11 @@ static long pps_cdev_compat_ioctl(struct file *file,
                 if (err)
                         return err;

-               /* Return the fetched timestamp */
+               /* Return the fetched timestamp and save last fetched event  */
                 spin_lock_irq(&pps->lock);

+               pps->last_fetched_ev = pps->last_ev;
+
                 compat.info.assert_sequence = pps->assert_sequence;
                 compat.info.clear_sequence = pps->clear_sequence;
                 compat.info.current_mode = pps->current_mode;
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index c7abce28ed29..aab0aebb529e 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -52,6 +52,7 @@ struct pps_device {
         int current_mode;                       /* PPS mode at event time */

         unsigned int last_ev;                   /* last PPS event id */
+       unsigned int last_fetched_ev;           /* last fetched PPS event id */
         wait_queue_head_t queue;                /* PPS event queue */

         unsigned int id;                        /* PPS source unique ID */

> If you want to avoid this extra alloc and derefers, we may use file position (file.f_pos) to store last fetched ev value.
> The pps does not provide read/write, so f_pos is unused anyway.
> 
> I am a little bit puzzeled about your second diff.
> Every pps client that uses pps_event() supports WAITEVENT, because this is in the generic part.
> To me not using pps_event() but reimplement parts of pps_event() seems to be a bad idea.
> That’s why I thing that this diff is not needed.

All clients specify their PPS information within the struct pps_source_info, and 
if for some reason one source doesn't add the PPS_CANWAIT flag, we should 
properly support this setting.

However, this is related to the poll() support, and we can defer it for the moment.

Thank you so much for your suggestions and tests! :)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming



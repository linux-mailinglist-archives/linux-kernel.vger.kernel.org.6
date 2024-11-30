Return-Path: <linux-kernel+bounces-426327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD499DF1C8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ABA4B21408
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC62119F424;
	Sat, 30 Nov 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nh2.me header.i=@nh2.me header.b="k2qrgdRD"
Received: from mail.nh2.me (mail.nh2.me [116.202.188.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECED31A0AF5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.188.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980974; cv=none; b=NQIfiLNeyNnGovrFhERY+855Zu4MCMClFl83p62dUmGPJIqwzuWoBaffn83PsoWwisOfoKiDfZEMPYkKzHYnUxcV8pPvuikqf8EwvjNMIC6i02Gh6N1t3oGvTgWNZqoetMpxQnCf7WzSOC+b0EisQcTv1EJbR0qOpzTOx7rY+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980974; c=relaxed/simple;
	bh=9w6EZjWLohBs+LSKZHCsRLrBAHest8jgaZ7Ee5F5wck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekfygzvmTeTnMrOj8ccOn5VpiEn8i5HZbztSTfOZXAKtmLyNWtnFUyiU8SVCE91eQFCoOSzFi+dMJg0n3snyjrEBHLTieXm0VcnYpF+oMhyjfsCAXBM3I6IVOBpoZ4lHcKCVNyweT0OoNNZDK8e4dWta62m7OJG2uvQPPO6+HV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nh2.me; spf=pass smtp.mailfrom=nh2.me; dkim=pass (2048-bit key) header.d=nh2.me header.i=@nh2.me header.b=k2qrgdRD; arc=none smtp.client-ip=116.202.188.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nh2.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nh2.me
Message-ID: <7df5f683-692c-42c7-a50a-9cafe672212f@nh2.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nh2.me; s=mail;
	t=1732980961; bh=VHTrYpQwSTl014FPiU0AGrODbQMkWajNDJ9CPjWglSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k2qrgdRDMde453sf9Fv7YhJaw+Z12zDsDjzlCWD6kaUFEHLOt7T3fGX8ucgIqEVjp
	 sp0rztBCqjw6SBH/0bNPKEhtBJm1y7Mm8m0J/lAQHomiq08qswtRHawP/y7wrGsoFZ
	 xdPbYaHj5nG7tW0B5c64hwQaraVB1eztq7O/Dk7quQUAL6KNysXe7JChIrYvhX/0Oe
	 cjqwM8LAR0hwwbtXTIBDOZEJf+bLBJBDb8tqGCjK+n4y05PJ7SZXPxUkqSIs9Y3GSF
	 vnWnxmbBPoOyJ7B6zfpzwSFO98RDplQDuzHZuxPyXfuxnL3xrR61UMrSZ1jJxEw/2T
	 ur6+ApEaoh8ww==
Date: Sat, 30 Nov 2024 16:36:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Wislist for Linux from the mold linker's POV
To: Theodore Ts'o <tytso@mit.edu>
Cc: Rui Ueyama <rui314@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Florian Weimer <fw@deneb.enyo.de>
References: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
 <87ttbrs1c5.fsf@mid.deneb.enyo.de>
 <CACKH++br0qCHhxsy1kuyK29OB_bgME3FUXA_XepRL=7FYXOvQA@mail.gmail.com>
 <2c33be3f-8c41-48f1-a6ad-b4ea00ec515f@nh2.me>
 <20241129181244.GA11702@mit.edu>
Content-Language: en-US
From: =?UTF-8?Q?Niklas_Hamb=C3=BCchen?= <mail@nh2.me>
In-Reply-To: <20241129181244.GA11702@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ted,

On 2024-11-29 19:12, Theodore Ts'o wrote:
> It's not actually an fsync() in the close case).  We initiate
> writeback, but we don't actually wait for the writes to complete on
> the close().  [..]  But in the case where the
> application programmer is too lazy to call fsync(2), the delayed
> completion of the transaction complete is the implicit commit, and
> nothing is bloced behind it.  (See below for more details.)
Then I actually have a question for you, as it seems I do have a situation where the close-without-rename blocks the userspace application's `close(2)` on ext4.

I have program which, when writing files, uses

    openat(..., O_WRONLY|O_CREAT|O_TRUNC|O_CLOEXEC)

In `strace -T`, writing 1 GiB to a file in an empty directory, it shows

    close(3<output.bin>) = 0 <0.000005>

but in a directory where `file2` already exists, it takes 2.5 seconds:

    close(3<output.bin>) = 0 <2.527808>

Is that expected?

Repro:

    time python -c 'with open("output.bin", "wb") as f: f.write(b"a" * (1024 * 1024 * 1024))'

The first run is fast, subsequent runs are slow; `rm output.bin` makes it fast again.

Environment: Linux 6.6.33 x86_64, mount with `ext4 (ro,relatime,errors=remount-ro)`
> But yes, the reason behind this is applications such as tuxracer
Ahah glorious, I didn't know that.
"But boss, the new kernel reduces global server throughput by 10x..." -- "Whatever the cost, my tuxracer high score MUST NOT BE LOST."

> In essence, file system developers are massively outnumbered by
> application programs, and for some reason as a class application
> programmers don't seem to be very careful about data corruption
> compared to file system developers --- and users *always* blame the
> file system developers.
Personally (as an application programmer) I would probably prefer the old behaviour, because now as a correct application it is difficult to opt out of the performance penalty, and understanding your own performance and benchmarking becomes ever more complex.
Writing fast apps that do file processing with intermediate files now requires inspecting which FS we're on and what their mount options, and implementing "quirks" style workarounds like "rm + rename instead of just rename".

But I equally relate to the frustration of users that lost files, and I can understand why you added this.

One can also blame the POSIX API for this to some extent, as it doesn't make it easy for the application programmer to do the right thing.

AppDev:    How do I write a file?
Posix:     write() + close().
AppDev:    Really?
Posix:     Actually, no. You also need to fsync() if you care about the data.
AppDev:    OK I added it, good?
Posix:     Actually, no. You also need to fsync() the parent dir if you care about the data and the file is new.
AppDev:    How many more surprise steps will there be?
Fsyncgate: Hi

I'm wondering if there's a way out of this, to make the trade-offs less global and provide an opt-out.
(As an application programmer I can't ask my users to enable `noauto_da_alloc`, because who knows what other applications they run.)
Maybe an `open(O_I_READ_THE_DOCS)` + fcntl flag, which disables wrong-application heuristics?
It should probably have a more technical name.

I realise this is fighting complexity with somewhat more complexity, but maybe buffering-by-default-and-fsync-for-durability was the wrong default all along, and close-is-durable-by-default-and-there-is-and-opt-out would be the better model; not sure.

Niklas


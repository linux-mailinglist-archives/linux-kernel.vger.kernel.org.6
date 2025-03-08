Return-Path: <linux-kernel+bounces-552224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19997A57720
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 02:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C55178A44
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CA91F16B;
	Sat,  8 Mar 2025 01:12:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A0EACD;
	Sat,  8 Mar 2025 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741396359; cv=none; b=NJzOn2ERA28RptSX6OY1ssMm+mdfId1mGvipx48Y5K8f3vrtKnfaimxgoE4eKHE88Piy+hkivXlLWMxM530fOzSPGTrT+DRSnXzd84LhwdrFxvX+MkDplUq4W8hrJ70yO79pB950sncZfHT8YtH6zVNM9Uc63R/p/SyWaNjG90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741396359; c=relaxed/simple;
	bh=YAUkg8TEJ5yVNr/zf1J0fvVRyBfCp4Kbd9lvTbNtuI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hequYSBcRUnK1bj4UDQvPVdhB4b1+EDYRlUOjjfPRm3FbbAFsV2F0rUTDQrKRJbSVuK8UuN5rGtjTQl2ioJnMSIQEP1uofUu/nsMKdDD1BX5PK6N/GpEBwpDtQqMNF253hj3t/QYAXaFNsnkLGh/b+Yk2QxPSCfBKvdbUY5P548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5938C4CED1;
	Sat,  8 Mar 2025 01:12:37 +0000 (UTC)
Date: Fri, 7 Mar 2025 20:12:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in tracepoint_add_func (2)
Message-ID: <20250307201238.1a3f9f53@gandalf.local.home>
In-Reply-To: <67cb890e.050a0220.d8275.022e.GAE@google.com>
References: <67cb890e.050a0220.d8275.022e.GAE@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Mar 2025 16:02:22 -0800
syzbot <syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com> wrote:

> syzbot found the following issue on:
> 
> HEAD commit:    7eb172143d55 Linux 6.14-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b9a464580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bed8205d3b84ef81
> dashboard link: https://syzkaller.appspot.com/bug?extid=161412ccaeff20ce4dde
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Yeah, because you add random fault injections, you wont hit it, unless you
have the right addition of faults.

> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/06a492964134/disk-7eb17214.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/83adeaa22219/vmlinux-7eb17214.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7386164633ed/bzImage-7eb17214.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com

There's a ton of fault injections here, which if happened in a real
situation, would mean the system was likely about to crash. Especially
since it's failing on 1 page allocations of GFP_KERNEL, which only happens
when there's no free memory available.

This warning is the least of you worries in such a scenario.

-- Steve



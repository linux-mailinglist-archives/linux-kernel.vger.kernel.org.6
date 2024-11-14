Return-Path: <linux-kernel+bounces-409692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BED19C9026
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C9281D84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C8917A583;
	Thu, 14 Nov 2024 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBgg4byw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF92146013
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602966; cv=none; b=pPwxk6hZ1d+NRiI4XQ+F3ABE2mrDBQvC3eX+VIxuTsirwDYF4wBfOYEd9GfoOO08dNshz/0Wh8+bVKDUultiUQjHxW+7fGQ1kHmJH3UkVEXM4jRAVioUlC5fUVh9IHGFWUk+EQrWlrz5Saitht0Aj8aLUmsyyN40zGFiAYtIaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602966; c=relaxed/simple;
	bh=UZ7/k3La6hpVjyvdQa3Gz/bnOaEt7YWpzyqh527H4Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUQwTomBbPDTkQR/l4gSYlsNdHxkJZd1OU8pIuoaqAVBRKp5YBTyqPPd0NR14IKcInWL7DtQUj8mZiMbTkGXq6ADFktqgHJHVWteNeEnP7QZK3LmRRJPebywa9dXFuCHouS92KpnSuYcM9mJzv3PsIukZMCa9NJv3Wwt7Ag2XnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBgg4byw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21406C4CED0;
	Thu, 14 Nov 2024 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731602966;
	bh=UZ7/k3La6hpVjyvdQa3Gz/bnOaEt7YWpzyqh527H4Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBgg4bywkJAe7kkP1NbBjNr7QODkz6WYbn7q+46PRyX+Wse08fU0E+BTX5VDPkTPE
	 6MmSzvOAjndbEs27oTlrBMAc0ouOYM0B+SbXLsF3XdpM7VXkr1Kx3+72b7by1QtEtO
	 LS0OZTjdhbiRcCX52c/QaLVKUDr5glioL+EdpjUFEi8fJxjc+LK+ALfXp/rd35Btfl
	 hO+AlrcdwPfMhEAfQQwqMBugc3Ml7sKY86qXLvzwuiBIsWVab10dVHmkmGawTL6eH4
	 ZyQ0i8JRFbaz0no9XD3bBYpDJ6dUe3tmo1w5Krw0aVz4DARUpEIWwigBsqm76FAIl+
	 p6G522mstI2wA==
Date: Thu, 14 Nov 2024 17:49:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: syzbot <syzbot+852e935b899bde73626e@syzkaller.appspotmail.com>
Cc: jstultz@google.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] WARNING in posixtimer_send_sigqueue
Message-ID: <ZzYqE-L-9Ga3Fe7n@localhost.localdomain>
References: <673549c6.050a0220.1324f8.008c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <673549c6.050a0220.1324f8.008c.GAE@google.com>

Le Wed, Nov 13, 2024 at 04:52:22PM -0800, syzbot a écrit :
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f714e8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
> dashboard link: https://syzkaller.appspot.com/bug?extid=852e935b899bde73626e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f714e8580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1657b0c0580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/disk-929beafb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinux-929beafb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/bzImage-929beafb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+852e935b899bde73626e@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5854 at kernel/signal.c:2008
> posixtimer_send_sigqueue+0x9da/0xbc0 kernel/signal.c:2008

That's because prepare_signal() does not only return false when the signal is
ignored but also when the task group is exiting. It's possible that the task
enters in do_exit() with pending signal and then the timer is reset and a new
signal is queued before the sighand dies.

This should fix it:

diff --git a/kernel/signal.c b/kernel/signal.c
index cbf70c808969..10b464b9d91f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2003,9 +2003,15 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
 	if (!prepare_signal(sig, t, false)) {
 		result = TRACE_SIGNAL_IGNORED;
 
-		/* Paranoia check. Try to survive. */
-		if (WARN_ON_ONCE(!list_empty(&q->list)))
+		if (!list_empty(&q->list)) {
+			/*
+			 * If task group is exiting with the signal already pending,
+			 * wait for __exit_signal() to do its job. Otherwise if
+			 * ignored, it's not supposed to be queued. Try to survive.
+			 */
+			WARN_ON_ONCE(!(t->signal->flags & SIGNAL_GROUP_EXIT));
 			goto out;
+		}
 
 		/* Periodic timers with SIG_IGN are queued on the ignored list */
 		if (tmr->it_sig_periodic) {


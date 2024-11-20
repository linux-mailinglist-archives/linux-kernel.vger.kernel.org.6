Return-Path: <linux-kernel+bounces-416028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140A99D3F55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD99A2846EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAE413B7A3;
	Wed, 20 Nov 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVCYRtZ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CDB13B58A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117696; cv=none; b=H9gnhi/XJcFyvPNSUMBo0AgeQngxqba3Iaxhd+N8BHB/qKrsEG5RRd8xkj2Zk/ioJzeEx+dYPcKKQxEyGZZKQ05AcYnG0XWnflc5cIX5QedTuNlwBz+SL1nSNkeLmYUOfxGsZQN4ArbWJGxrguNn/979Y6n14bv5GiRNfL7ORKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117696; c=relaxed/simple;
	bh=zJdOLH17uHs9cCf5Ktv/Iw+P6Co6A948bLVb04sdEQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyOfzOG2392Vs/igLl7neuFz5dPv1VkU4fRYZpwPpPl5362rvglw3N/kmC3x7JDBl1qvJLMa0EF3E/37blO/tc8pOKL+XqDrM45+SlIXCjQDKoXKatXsiRPJoDw1W9U6Kh/7zU5uEnfv92fUP6K12MYPAsIS25cUyfzeGcJgRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVCYRtZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4CAC4CECD;
	Wed, 20 Nov 2024 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732117696;
	bh=zJdOLH17uHs9cCf5Ktv/Iw+P6Co6A948bLVb04sdEQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVCYRtZ6wRXnIyAJ3aT5MrfzXBVFTM0adB2XgfYyupLMHF+iJJdxz2ecl9iwIuGJ9
	 kj0Uqj+jkzhdd3aWmjEwhkmaED/gyP5O+qY/oKzG9FmSLrH9Qb8vqQ9qL/tynbWhwo
	 l0sGNzpsr+kX+a+OiDearJkyuma/9NJ6ADcIHJwA7vZdCSjnJ2S21JWKSbQOdKv/TO
	 jPdawuCXs3RZyxNXGlUNRx7Dyb5vsNn8NwscfvaHjc4OY1Uk7VtuRJwfutX9ui1Zrk
	 mUxe8bOh+9CE9NWG1uNxJ8FiZrBo+4tZ2sSDKGTmvgRqLPs4itjIGQAoeDpK+4ifiJ
	 C2gkb/CUE+ZPw==
Date: Wed, 20 Nov 2024 16:48:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] timers/core for v6.13-rc1
Message-ID: <20241120-nennwert-hausfassade-e515eddb6198@brauner>
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
 <173195758632.1896928.11371209657780930206.tglx@xen13>
 <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>
 <20241120-backwaren-faible-99807b4768bb@brauner>
 <Zz3SLAW-97Zhjfhv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zz3SLAW-97Zhjfhv@gmail.com>

On Wed, Nov 20, 2024 at 01:12:28PM +0100, Ingo Molnar wrote:
> 
> * Christian Brauner <brauner@kernel.org> wrote:
> 
> > On Tue, Nov 19, 2024 at 04:33:45PM -0800, Linus Torvalds wrote:
> > > On Mon, 18 Nov 2024 at 11:22, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > 
> > > >   - Core infrastructure for VFS multigrain timestamping
> > > >
> > > >     This is required to allow the kernel to use coarse grained time stamps
> > > >     by default and switch to fine grained time stamps when inode attributes
> > > >     are actively observed via getattr().
> > > >
> > > >     These changes have been provided to the VFS tree as well, so that the
> > > >     VFS specific infrastructure could be built on top.
> > > 
> > > Bah. Except the vfs tree didn't take it as a shared branch, but
> > > instead cherry-picked the commits and as a result they are duplicate
> > > and caused a (trivial) merge conflict.
> > 
> > Wait, I'm confused. I definitely pulled that branch the day after Thomas
> > gave it to me and in my vfs.mgtime branch I clearly see:
> > 
> > commit d7c898a73f875bd205df53074c1d542766171da1
> > Merge: 8cf0b93919e1 2a15385742c6
> > Author:     Christian Brauner <brauner@kernel.org>
> > AuthorDate: Mon Oct 7 12:47:19 2024 +0200
> > Commit:     Christian Brauner <brauner@kernel.org>
> > CommitDate: Thu Oct 10 10:20:57 2024 +0200
> > 
> >     Merge tag 'timers-core-for-vfs' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip into vfs.mgtime
> > 
> >     Timekeeping interfaces for consumption by the VFS tree.
> > 
> >     Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > Unless I did something odd during the pull?
> 
> The problem was caused by two commits which got rebased in the VFS 
> tree:
> 
> Commit 1:
> 
>   ee3283c608df ("timekeeping: Add interfaces for handling timestamps with a floor value")
> 
>   commit ee3283c608dfa21251b0821d7bb198c7ae3189f6
>   Author:     Jeff Layton <jlayton@kernel.org>
>   AuthorDate: Wed Oct 2 17:27:16 2024 -0400
>   Commit:     Christian Brauner <brauner@kernel.org>
>   CommitDate: Thu Oct 10 10:20:46 2024 +0200
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Which is a rebase of Thomas's original commit:
> 
>   70c8fd00a9bd ("timekeeping: Add interfaces for handling timestamps with a floor value")
> 
>   commit 70c8fd00a9bd0509bbf7bccd9baea8bbd5ddc756
>   Author:     Jeff Layton <jlayton@kernel.org>
>   AuthorDate: Wed Oct 2 17:27:16 2024 -0400
>   Commit:     Thomas Gleixner <tglx@linutronix.de>
>   CommitDate: Sun Oct 6 20:56:07 2024 +0200
> 
> And commit 2:
> 
>   2a15385742c6 ("timekeeping: Add percpu counter for tracking floor swap events")
> 
>   commit 2a15385742c689a271345dcbb4c28b9c568bc7ce
>   Author:     Jeff Layton <jlayton@kernel.org>
>   AuthorDate: Wed Oct 2 17:27:17 2024 -0400
>   Commit:     Christian Brauner <brauner@kernel.org>
>   CommitDate: Thu Oct 10 10:20:46 2024 +0200
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Which is a rebase of Thomas's original commit:
> 
>   96f9a366ec8a timekeeping: Add percpu counter for tracking floor swap events
> 
>   commit 96f9a366ec8abe027326d7aab84d64370019f0f1 (tag: timers-core-for-vfs)
>   Author:     Jeff Layton <jlayton@kernel.org>
>   AuthorDate: Wed Oct 2 17:27:17 2024 -0400
>   Commit:     Thomas Gleixner <tglx@linutronix.de>
>   CommitDate: Sun Oct 6 20:56:07 2024 +0200

I was just looking through my reflog and I realised that I did a rebase
onto v6.12-rc2 (v6.12-rc1 had a horribly virtqueue bug that made testing
in a vm a giant pain). Sorry about that I should've noticed that
earlier.

Though I'm confused why -next didn't catch this. When that happens -next
usually reports duplicate commits. Hm... Did I miss the report?

9fed2c0f2f07 (HEAD -> vfs.mgtime, tag: vfs-6.13.mgtime, origin-all/vfs.mgtime) HEAD@{0}: am: fs: reduce pointer chasing in is_mgtime() test
b40508ca5d5c HEAD@{1}: rebase (finish): returning to refs/heads/vfs.mgtime
b40508ca5d5c HEAD@{2}: rebase (reset): 'onto': Merge patch series "timekeeping/fs: multigrain timestamp redux"
d7c898a73f87 HEAD@{3}: rebase (reset): 'onto': Merge tag 'timers-core-for-vfs' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip into vfs.mgtime
8cf0b93919e1 (tag: v6.12-rc2, master.v6.12-rc2) HEAD@{4}: rebase (reset): 'onto'


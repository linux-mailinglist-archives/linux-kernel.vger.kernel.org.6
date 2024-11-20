Return-Path: <linux-kernel+bounces-416262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3099D42A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A50B229F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7EF1BD50A;
	Wed, 20 Nov 2024 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn22U385"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67F1386D7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131877; cv=none; b=nyS86FiOPMiKVzYbftIFEzdKGpjAirEoxTbbJmMbYRlxvGjUJjY5HluCyFWjdMW6az4gb+g5arMXYOdiA6ndkzuAbYZeljQSzwz7ylN3XYgBykV7rknIVL5TeaJ9tubUIgBw1/eIt9b4+dhSXH37sVrp96UFOtw7GKeZAR/rIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131877; c=relaxed/simple;
	bh=IZEUfEBA1GzgFRBNbx1tHS/egkklfYbaa5zvGtyCCqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM9F7L9H3621ixs1WyqRUUu8FHiFt3v8SnXCHt4s97/y/fLlGK/wZA+P0sHCzlDaXrjoqrkx4TGXQsCSAsmHJRnPzl476z1M/DPFPji8TD+dJLHvOBN3aWB4gvN/haEyEo1jgtRWPQplg7li4PDQWnEaucCIL+AmccZ0f4yxj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn22U385; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A298C4CECD;
	Wed, 20 Nov 2024 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732131877;
	bh=IZEUfEBA1GzgFRBNbx1tHS/egkklfYbaa5zvGtyCCqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gn22U385nUsSZCxBW7uRTwvMBZSCi1ucG0zd9CHa4Q0lt/NQJyAm0BoCXgu4RDmS7
	 uryrSwk8hwAHJhWiKZLVkLl+U9Txs4Be0qYJIbRNc8V0BDJ9HQW46puBPifkLsSCNP
	 gI/Ap5TM2ND75SJW2NDznsYl+5pfdwKNcGS63Uu6VxVQ9fxBGH34LZqdaxKH8zBGwS
	 9vbjOk7ZErTDdpKyJvrODe7XvWlbaYvNkJFSvFDIJn/wCfaeBW/P5WZcgNIv7rWLKT
	 +sUWGUDApHddbrsEmfOGbPhWqOmmOx8c3NBPjA4RTcET8+SZCJibWXpbfvp8E5iQo6
	 LPPbhWqpDjIRw==
Date: Wed, 20 Nov 2024 20:44:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] timers/core for v6.13-rc1
Message-ID: <20241120-kurort-belehren-9f5212e1dc18@brauner>
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
 <173195758632.1896928.11371209657780930206.tglx@xen13>
 <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>
 <20241120-backwaren-faible-99807b4768bb@brauner>
 <Zz3SLAW-97Zhjfhv@gmail.com>
 <20241120-nennwert-hausfassade-e515eddb6198@brauner>
 <Zz4J_a2bYyNzJxWZ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zz4J_a2bYyNzJxWZ@gmail.com>

On Wed, Nov 20, 2024 at 05:10:37PM +0100, Ingo Molnar wrote:
> 
> * Christian Brauner <brauner@kernel.org> wrote:
> 
> > On Wed, Nov 20, 2024 at 01:12:28PM +0100, Ingo Molnar wrote:
> > > 
> > > * Christian Brauner <brauner@kernel.org> wrote:
> > > 
> > > > On Tue, Nov 19, 2024 at 04:33:45PM -0800, Linus Torvalds wrote:
> > > > > On Mon, 18 Nov 2024 at 11:22, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > >
> > > > > 
> > > > > >   - Core infrastructure for VFS multigrain timestamping
> > > > > >
> > > > > >     This is required to allow the kernel to use coarse grained time stamps
> > > > > >     by default and switch to fine grained time stamps when inode attributes
> > > > > >     are actively observed via getattr().
> > > > > >
> > > > > >     These changes have been provided to the VFS tree as well, so that the
> > > > > >     VFS specific infrastructure could be built on top.
> > > > > 
> > > > > Bah. Except the vfs tree didn't take it as a shared branch, but
> > > > > instead cherry-picked the commits and as a result they are duplicate
> > > > > and caused a (trivial) merge conflict.
> > > > 
> > > > Wait, I'm confused. I definitely pulled that branch the day after Thomas
> > > > gave it to me and in my vfs.mgtime branch I clearly see:
> > > > 
> > > > commit d7c898a73f875bd205df53074c1d542766171da1
> > > > Merge: 8cf0b93919e1 2a15385742c6
> > > > Author:     Christian Brauner <brauner@kernel.org>
> > > > AuthorDate: Mon Oct 7 12:47:19 2024 +0200
> > > > Commit:     Christian Brauner <brauner@kernel.org>
> > > > CommitDate: Thu Oct 10 10:20:57 2024 +0200
> > > > 
> > > >     Merge tag 'timers-core-for-vfs' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip into vfs.mgtime
> > > > 
> > > >     Timekeeping interfaces for consumption by the VFS tree.
> > > > 
> > > >     Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > 
> > > > Unless I did something odd during the pull?
> > > 
> > > The problem was caused by two commits which got rebased in the VFS 
> > > tree:
> > > 
> > > Commit 1:
> > > 
> > >   ee3283c608df ("timekeeping: Add interfaces for handling timestamps with a floor value")
> > > 
> > >   commit ee3283c608dfa21251b0821d7bb198c7ae3189f6
> > >   Author:     Jeff Layton <jlayton@kernel.org>
> > >   AuthorDate: Wed Oct 2 17:27:16 2024 -0400
> > >   Commit:     Christian Brauner <brauner@kernel.org>
> > >   CommitDate: Thu Oct 10 10:20:46 2024 +0200
> > >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > > Which is a rebase of Thomas's original commit:
> > > 
> > >   70c8fd00a9bd ("timekeeping: Add interfaces for handling timestamps with a floor value")
> > > 
> > >   commit 70c8fd00a9bd0509bbf7bccd9baea8bbd5ddc756
> > >   Author:     Jeff Layton <jlayton@kernel.org>
> > >   AuthorDate: Wed Oct 2 17:27:16 2024 -0400
> > >   Commit:     Thomas Gleixner <tglx@linutronix.de>
> > >   CommitDate: Sun Oct 6 20:56:07 2024 +0200
> > > 
> > > And commit 2:
> > > 
> > >   2a15385742c6 ("timekeeping: Add percpu counter for tracking floor swap events")
> > > 
> > >   commit 2a15385742c689a271345dcbb4c28b9c568bc7ce
> > >   Author:     Jeff Layton <jlayton@kernel.org>
> > >   AuthorDate: Wed Oct 2 17:27:17 2024 -0400
> > >   Commit:     Christian Brauner <brauner@kernel.org>
> > >   CommitDate: Thu Oct 10 10:20:46 2024 +0200
> > >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > > Which is a rebase of Thomas's original commit:
> > > 
> > >   96f9a366ec8a timekeeping: Add percpu counter for tracking floor swap events
> > > 
> > >   commit 96f9a366ec8abe027326d7aab84d64370019f0f1 (tag: timers-core-for-vfs)
> > >   Author:     Jeff Layton <jlayton@kernel.org>
> > >   AuthorDate: Wed Oct 2 17:27:17 2024 -0400
> > >   Commit:     Thomas Gleixner <tglx@linutronix.de>
> > >   CommitDate: Sun Oct 6 20:56:07 2024 +0200
> > 
> > I was just looking through my reflog and I realised that I did a rebase
> > onto v6.12-rc2 (v6.12-rc1 had a horribly virtqueue bug that made testing
> > in a vm a giant pain). Sorry about that I should've noticed that
> > earlier.
> 
> So, so sh1t happens, but I think there could also be a workflow bug 
> here: somehow your tooling added your Signed-off-by during the rebase, 
> to a commit not committed by you originally.

I see. I assume that happens because I have an ancient
.git/hooks/prepare-commit-msg which contains:

COMMIT_MSG_FILE=$1
COMMIT_SOURCE=$2

SOB=$(git var GIT_COMMITTER_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"

I honestly have no idea anymore why I added that hook originally...

> 
> > Though I'm confused why -next didn't catch this. When that happens -next
> > usually reports duplicate commits. Hm... Did I miss the report?
> 
> I haven't seen duplicate commit warnings from -next for some time - but 
> it can detect accidental rebases, because without your SOB added -next 
> would have detected the incorrect SOB chain I believe. So I'd 
> investigate how your SOB got there. I don't think vanilla rebase is 
> adding it automatically?

Yes, vanilla rebase doesn't do this.


Return-Path: <linux-kernel+bounces-415727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BF9D3A63
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F3928177D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DF019F46D;
	Wed, 20 Nov 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAFVzzLc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727241AA1F6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104753; cv=none; b=dmsPsMSmVupQUWr4e7SKEyCcEYZo22grTU0oTfBPh5OrG6WpXqQBtAFTCsJU1/DJ8UjnDfDSdgU/OQr1lexo756jJQpNsuUVMsYSvR3WpvHkt/i71QcPoCFpJZBBDsdd05UQGniLqt52f0pAYumPuhMLWKQNuZRzqQ+FfDfhEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104753; c=relaxed/simple;
	bh=RfIXQrCG49g6FBpdwSnUE0PC7y6jE/0TACL/TJSFeCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH0Blwaf5bgnWRg/bv6DGVVqPJamjKGrBGaY7mEmAxjK5ZfsuQ8uSH1SpSe3ge6maWMt5cFdFr2CctbhJyQiStZIRo2j3zenREuyZy+AS17+/pW/LTIRcz3LUhp/S45VeDeU5kCjS7VvYAnzPPXdNBBdSM66QJW80Ge3gMapUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAFVzzLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B954C4CED6;
	Wed, 20 Nov 2024 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732104753;
	bh=RfIXQrCG49g6FBpdwSnUE0PC7y6jE/0TACL/TJSFeCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAFVzzLcrZ3/cO9/NhUkddSsirAqV9Y2ovGkaSw6P02gueKlciyKD53fc0pWQbmi9
	 3FFx13K81tneWFVowRbtAOncEB5jfALZ7HIA5jckzsljvzAYTcl0KmkNDnX86JnYq0
	 +HIfn5MuTKbRTotFCU14KRRR95H52fWuAmn+G/pcpcyCD3jczBEIbKDvMGlLsiOSPR
	 9CTilVHy8PihJJ407yHDKCjHPzidCW4tu+Uk8dM//D4FP9LGj++PkSCXtdpXkTMSZN
	 bRMOzqWeKynBWWXglqrohL6ZtH8lR75YLkjxD/Nwm5qO+qaPgnCtr8phjGbCqGmA7j
	 5BlY9tPfPD2ZQ==
Date: Wed, 20 Nov 2024 13:12:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [GIT pull] timers/core for v6.13-rc1
Message-ID: <Zz3SLAW-97Zhjfhv@gmail.com>
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
 <173195758632.1896928.11371209657780930206.tglx@xen13>
 <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>
 <20241120-backwaren-faible-99807b4768bb@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-backwaren-faible-99807b4768bb@brauner>


* Christian Brauner <brauner@kernel.org> wrote:

> On Tue, Nov 19, 2024 at 04:33:45PM -0800, Linus Torvalds wrote:
> > On Mon, 18 Nov 2024 at 11:22, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > 
> > >   - Core infrastructure for VFS multigrain timestamping
> > >
> > >     This is required to allow the kernel to use coarse grained time stamps
> > >     by default and switch to fine grained time stamps when inode attributes
> > >     are actively observed via getattr().
> > >
> > >     These changes have been provided to the VFS tree as well, so that the
> > >     VFS specific infrastructure could be built on top.
> > 
> > Bah. Except the vfs tree didn't take it as a shared branch, but
> > instead cherry-picked the commits and as a result they are duplicate
> > and caused a (trivial) merge conflict.
> 
> Wait, I'm confused. I definitely pulled that branch the day after Thomas
> gave it to me and in my vfs.mgtime branch I clearly see:
> 
> commit d7c898a73f875bd205df53074c1d542766171da1
> Merge: 8cf0b93919e1 2a15385742c6
> Author:     Christian Brauner <brauner@kernel.org>
> AuthorDate: Mon Oct 7 12:47:19 2024 +0200
> Commit:     Christian Brauner <brauner@kernel.org>
> CommitDate: Thu Oct 10 10:20:57 2024 +0200
> 
>     Merge tag 'timers-core-for-vfs' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip into vfs.mgtime
> 
>     Timekeeping interfaces for consumption by the VFS tree.
> 
>     Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Unless I did something odd during the pull?

The problem was caused by two commits which got rebased in the VFS 
tree:

Commit 1:

  ee3283c608df ("timekeeping: Add interfaces for handling timestamps with a floor value")

  commit ee3283c608dfa21251b0821d7bb198c7ae3189f6
  Author:     Jeff Layton <jlayton@kernel.org>
  AuthorDate: Wed Oct 2 17:27:16 2024 -0400
  Commit:     Christian Brauner <brauner@kernel.org>
  CommitDate: Thu Oct 10 10:20:46 2024 +0200
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Which is a rebase of Thomas's original commit:

  70c8fd00a9bd ("timekeeping: Add interfaces for handling timestamps with a floor value")

  commit 70c8fd00a9bd0509bbf7bccd9baea8bbd5ddc756
  Author:     Jeff Layton <jlayton@kernel.org>
  AuthorDate: Wed Oct 2 17:27:16 2024 -0400
  Commit:     Thomas Gleixner <tglx@linutronix.de>
  CommitDate: Sun Oct 6 20:56:07 2024 +0200

And commit 2:

  2a15385742c6 ("timekeeping: Add percpu counter for tracking floor swap events")

  commit 2a15385742c689a271345dcbb4c28b9c568bc7ce
  Author:     Jeff Layton <jlayton@kernel.org>
  AuthorDate: Wed Oct 2 17:27:17 2024 -0400
  Commit:     Christian Brauner <brauner@kernel.org>
  CommitDate: Thu Oct 10 10:20:46 2024 +0200
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Which is a rebase of Thomas's original commit:

  96f9a366ec8a timekeeping: Add percpu counter for tracking floor swap events

  commit 96f9a366ec8abe027326d7aab84d64370019f0f1 (tag: timers-core-for-vfs)
  Author:     Jeff Layton <jlayton@kernel.org>
  AuthorDate: Wed Oct 2 17:27:17 2024 -0400
  Commit:     Thomas Gleixner <tglx@linutronix.de>
  CommitDate: Sun Oct 6 20:56:07 2024 +0200

Thanks,

	Ingo


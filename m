Return-Path: <linux-kernel+bounces-415570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8769D382F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2651F2306D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61119D8A8;
	Wed, 20 Nov 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG2BqxTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA719C561
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097935; cv=none; b=c0B9tKeS6bbdQKG8ypjJ4d9NAvRxhL9mnmD64M48cwUUHVqlZzDxnhhuUkd6+vev9OCaFPE0irkM696wyHSs2vzGE/mkLR/8RviqDZVAo02JjEOiIfUSWie5Q68g4g3jXMTQ+uGhsGqjhpdwgWXKsECdqR1d7u/wOBhLqFTnwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097935; c=relaxed/simple;
	bh=5Thvdj4LZp0/89Y9nB/eA+4SIafyW+S6X8Sg9pfd55c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuwAOHAyhTVf1vCQXF91Uho1Qpg2gACSFtA4aSkmVQuMQrGGE1+4XczzumjBYS2+DMn7OcMZeVWSQ69B7Pg7yoY7TeBz7K20yeOnyLBNELvDKyY36Jvj4rpVuVbO9tIdI3jQkfMe8r762ew4BPTERwblmp6zQh9IB9YDPmk1oJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG2BqxTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D046C4CECD;
	Wed, 20 Nov 2024 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732097935;
	bh=5Thvdj4LZp0/89Y9nB/eA+4SIafyW+S6X8Sg9pfd55c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jG2BqxTeyMIdfRMoUE1DhKUmJM4a4hTmIuEpzJBUn9E4yG6FjGmNg+IaoEGejrQwE
	 78h1phNAngTjpFSUk/UvZMqN/TH3m6g54pK+6ZETRBqKocbV7aoB+r6A2Iv5401WeV
	 w8vgEOTQZ4FOE/rn/0LWglf0AIpU4UoICP0i60vGosVjGq5nqa2MYoNeRiDAlrS726
	 KxvbFvi99COGtWpf+PrdVkPnM5qfoQwJLK88PhtwYre6xfFL8/r2ozt7LvIajCo/Jn
	 pTKsXY3JR70u8xmMf2eub8HmPQOrcS++F5Inbg6gHlHu1Kv8tzpFvgv3WAW1M7s2u9
	 9ajAUDGrCtZbA==
Date: Wed, 20 Nov 2024 11:18:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Subject: Re: [GIT pull] timers/core for v6.13-rc1
Message-ID: <20241120-backwaren-faible-99807b4768bb@brauner>
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
 <173195758632.1896928.11371209657780930206.tglx@xen13>
 <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>

On Tue, Nov 19, 2024 at 04:33:45PM -0800, Linus Torvalds wrote:
> On Mon, 18 Nov 2024 at 11:22, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> 
> >   - Core infrastructure for VFS multigrain timestamping
> >
> >     This is required to allow the kernel to use coarse grained time stamps
> >     by default and switch to fine grained time stamps when inode attributes
> >     are actively observed via getattr().
> >
> >     These changes have been provided to the VFS tree as well, so that the
> >     VFS specific infrastructure could be built on top.
> 
> Bah. Except the vfs tree didn't take it as a shared branch, but
> instead cherry-picked the commits and as a result they are duplicate
> and caused a (trivial) merge conflict.

Wait, I'm confused. I definitely pulled that branch the day after Thomas
gave it to me and in my vfs.mgtime branch I clearly see:

commit d7c898a73f875bd205df53074c1d542766171da1
Merge: 8cf0b93919e1 2a15385742c6
Author:     Christian Brauner <brauner@kernel.org>
AuthorDate: Mon Oct 7 12:47:19 2024 +0200
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Thu Oct 10 10:20:57 2024 +0200

    Merge tag 'timers-core-for-vfs' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip into vfs.mgtime

    Timekeeping interfaces for consumption by the VFS tree.

    Signed-off-by: Christian Brauner <brauner@kernel.org>

Unless I did something odd during the pull?


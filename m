Return-Path: <linux-kernel+bounces-346182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C284E98C0FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718BA1F20D67
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D0C1CBE8D;
	Tue,  1 Oct 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePdlTQ/y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330841C9ECA;
	Tue,  1 Oct 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794853; cv=none; b=HBpgLPCCUXNnJhVwXhvH5qQLOG/Ys6HmtJWGjPwnFxpi8xwIguuUfy1W6PjBavNZQUjg/mdGHfJy+xRrQ33Mia8N9oMj6j+EbVtZWQEgjZm/6TnFDmbqMQYefn7bDU8ijlZEGmUq5aC3LR8WaZ3BaBnuZWLA2sq08oQ3mcg4FUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794853; c=relaxed/simple;
	bh=om3nscZ/oTAku5Fz/xL6gLTx1q4mYdNQaIXLbUrNTTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDAfYJYdaJd/+66xeAtdFazhS41npiMoD57GlTuBpuS9sozdNLfivwMvFaAIAq1Ris7IQP3Ktrt5J5C6lP1lnJohAyXvG2pk5xIi+6izDMwI111V57Z+qViHUzlgKFh0HFl9il/l51cgSHE2g7+DWqu/G62HxPdA4UVKrLCwGz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePdlTQ/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4176C4CEC6;
	Tue,  1 Oct 2024 15:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794853;
	bh=om3nscZ/oTAku5Fz/xL6gLTx1q4mYdNQaIXLbUrNTTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePdlTQ/yNf5Ucy6s1QDse7VaT0vDmaXrngYkec1z1nFoPAmTMmoTVlB8Z13gwPOOj
	 +WBYuPboSvElbCY7PI96dt2e5gymhq4TjSMWTQ00Qr7EnxP+x4chCVSlJw2alN1yis
	 n2Hjslf7njND3UtZv7byOni5Jxcnwr7vI4yl3RHHMENaMXZicr40kb/3AWc6oamtim
	 ix6in2O3xw7Z9Y6GXtXhK1RMYigO8Y5x1j4sn7hhFIHSCQO+4CwMyZXA70u2/DgjAD
	 NoJYzvkVz52UIkTXLFE4PxzOJnBdgRK6NxotIiGCedRoh6h5QRfGrNxBo/8s9UTL6A
	 tKiUaw7qfwbBw==
Date: Tue, 1 Oct 2024 17:00:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Benjamin Coddington <bcodding@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20241001-feigling-lotsen-223db961f8d2@brauner>
References: <20241001091134.1eab47c2@canb.auug.org.au>
 <20241001141958.77cf8bd6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001141958.77cf8bd6@canb.auug.org.au>

On Tue, Oct 01, 2024 at 02:19:58PM GMT, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 1 Oct 2024 09:11:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the vfs-brauner tree, today's linux-next build (powerpc
> > ppc64_defconfig) produced this warning:
> > 
> > fs/lockd/svclock.c: In function 'nlmsvc_lock':
> > fs/lockd/svclock.c:483:34: warning: unused variable 'inode' [-Wunused-variable]
> >   483 |         struct inode            *inode = nlmsvc_file_inode(file);
> >       |                                  ^~~~~
> > 
> > Introduced by commit
> > 
> >   81be05940ccc ("NLM/NFSD: Fix lock notifications for async-capable filesystems")
> 
> This became a build failure in my i386 defconfig build, so I applied
> the following patch for today.

Thank you. I just folded that fix into the commit.


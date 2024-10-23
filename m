Return-Path: <linux-kernel+bounces-377746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D019AC398
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582DB281766
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155019CCEC;
	Wed, 23 Oct 2024 09:19:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED21991BF;
	Wed, 23 Oct 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675159; cv=none; b=QsOY3H5xwsqEqKrNbMxI52LnfiI+OlWDUb+M9PRM+N/W6FT7EJIHO1dCUeuK2Z9Bn3fKp7KBofLV3I4f4J+Q2k2ap8S95xicmMhBmNgv7lISC5OIvXN2EJaDWzM9SwzPg6N4OYYgGjeMmH2q54Nu84LvgNEOV6nW03BtHh1ekkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675159; c=relaxed/simple;
	bh=3sCg3cEIvbF39mGDqwfkOkEbwTg3yY96fFAO+BaKDSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5ztMN7F4kDW8VJ4bJndgUDQ5MtXkO0xLVIFLw8Q9OfvpoM/Ajxu90eqEunFr1OGpA6MzombHYfImwdmriXEs/dduIK1pkJPyW0tyLzEX5X9p7cVdqm7PIHeNCDVmlpHVp1JF1x0FijhgcYLAuVv0pon7sDTtZOqMowHWD6pGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDD0C4CEC7;
	Wed, 23 Oct 2024 09:19:17 +0000 (UTC)
Date: Wed, 23 Oct 2024 05:19:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
 Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <20241023051914.7f8cf758@rorschach.local.home>
In-Reply-To: <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
References: <ZxZ8MStt4e8JXeJb@sashalap>
	<792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
	<ZxdKwtTd7LvpieLK@infradead.org>
	<20241022041243.7f2e53ad@rorschach.local.home>
	<ZxiN3aINYI4u8pRx@infradead.org>
	<20241023042004.405056f5@rorschach.local.home>
	<CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 10:36:20 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > To put it this way. The bugs I'm fixing was for code in linux-next
> > where the bugs were never found. They only appeared when they went into
> > Linus's tree. So why put the fixes in linux-next, if it didn't catch
> > the bugs I fixed in the first place?  
> 
> Hmmm...
> 
> Your arguments sound very similar to those being used in recent
> discussions about not posting patches for public review...
> 
> Please follow the process! ;-)

What process?

Note, I probably post everything to mailing lists more than anyone
else (besides stable). All my commits come from mailing lists. Even
things I change myself. I always send out the change to a list. Then I
use patchwork to pull it into my tree.

After the changes are tested, I send out the patches *again* with my
[for-next] tags in the subject. If it's a fix for Linus, it goes out as
a "[for-linus]" tag. These emails automatically update my patchwork
status.

No change goes into Linus's tree from me that hasn't been sent out
publicly.

But pushing to linux-next for a day or two, what does that give me?

-- Steve


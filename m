Return-Path: <linux-kernel+bounces-240471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26653926E16
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEED31F228F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3391BC4E;
	Thu,  4 Jul 2024 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts1WtiRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941C1B7E4;
	Thu,  4 Jul 2024 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720063989; cv=none; b=AnKYqZDIKAwdNnkRHL8c+LGBdiwR1yLjpZP/XEjySysinFgf25ktTIGpwhLRRxDZvOpqejQPIYj+59H2XcGL6GG3nTnCKgh282FL9CxDMA8Xa6PqiV6wT1L0blVdbm22yReFYBIytdbMlklmr6yj00JBVJAhPAf5chq88er0qnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720063989; c=relaxed/simple;
	bh=tcm1IcCORRAi6yPGnK23d43U5d99YCQ7myWX0KsENNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFd6hDm8NDawGB+M6yc713Tk7WDOv176xByBjqfa+6+Ps2NFY4zTiCTzlu8HxZBkEbYTH+rgJTxZbjkXKkEaR67j0M8D9PdI5aBWtTj0TKOUf5VmPoMPssxihaZoKZOlJ3cIVJU6/ach7sXf7cUR2NRO2CWuK9hotJOb5yo3a1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts1WtiRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCDBC2BD10;
	Thu,  4 Jul 2024 03:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720063988;
	bh=tcm1IcCORRAi6yPGnK23d43U5d99YCQ7myWX0KsENNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ts1WtiRxrRypIJlOi/Or/G0T5uB6qyn16k62V1VunKRaq2XHdtKxVR5V3ELW34Yn2
	 wrCttctsy2MihhkXG2xnXqY3AsbM0sBvLqTtr2fj6MAVq6B7ft6NfLJjbClFXqfIpy
	 GNIqQiPhePWPI7vaCca16Luw8JOaV/I8+lxYcD7Di9+eSLiMO9X+52f+MVYNGcLd2D
	 zu7hF+QdhWGvEfSGs2MIjgOZL8KrbP1JpMT0EXlfAk265VOhkvH6RhEo5IPs07/814
	 LfuxvdxdX3AuQvqubKnx11cGvY6genODrb8CaUiQttoDYSnsZ36ZBrCBtou1jOLPxW
	 The2lTBnsp5bg==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 4/4] Docs/mm/index: move allocation profiling document to unsorted documents chapter
Date: Wed,  3 Jul 2024 20:33:05 -0700
Message-Id: <20240704033305.93425-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAJuCfpFO_C_LgxrRWrxG9o==RRtYAbkbP3ZJULwdmTjDcAJNrg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 3 Jul 2024 19:10:03 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> On Wed, Jul 3, 2024 at 4:00 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed, 03 Jul 2024 16:18:42 -0600 Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > > SeongJae Park <sj@kernel.org> writes:
> > >
> > > > The memory allocation profiling document was added to the bottom of the
> > > > new outline.  Apparently it was not decided by well-defined guidelines
> > > > or a thorough discussions.  Rather than that, it was added there just
> > > > because there was no place for such unsorted documents.  Now there is
> > > > the chapter.  Move the document to the new place.
> > >
> > > I'll take this for now, but it's truly sad to see new documentation
> > > being added to the slushpile at the end.  It seems better to create a
> > > "development tools" section in the new outline and put the allocation
> > > profiling document there?
> >
> > I have no strong opinions about that.  Cc-ing Suren and Kent, as they are the
> > author of the allocation profiling document and hence might have some opinion.
> 
> IMHO if this would be the only document belonging to "development
> tools" then keeping it under unsorted is fine.
> If more documents will fall into that category then Jonathan's
> suggestion makes sense to me. Looking at the current list, page_owner
> and maybe damon might be considered for this category as well.
> SeongJae, WDYT?

I agree it makes more sense to have multiple documents under dedicated
sections.  And putting page_owner sounds not that odd to me.

DAMON is, however, not a tool but a framework that helps easy development of
access-aware kernel components.  Such components could be development tools and
system operations optimizations (using DAMOS).  So, IMHO, 'development tools'
section is not the perfect place for DAMON documents.

Actually, even for allocation-profiling and page_owner, I think 'development
tools' might not be a perfect category.  I understand those as features that
could be useful for system investigations of multiple purposes.

So, in short, I think it is not easy to find a perfect cateogry...


Thanks,
SJ

[...]


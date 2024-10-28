Return-Path: <linux-kernel+bounces-384571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C199B2BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0152F1C2115D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074DD1D079F;
	Mon, 28 Oct 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qL9XQruz"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4E1CF2AB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108903; cv=none; b=NEJeVEYzTT13mpGpRmiGsAGqwc8tgQZ7AnJ92T4xJ+AMhGCgTI2Xy/IOHEGuBogXpLaMjvNYsvvw5vn/iDuF2NV2q92e9dF5t+DGHoN77YufG5nhOjx0MIIK8CEqstWaXlyqotmpMO8x9ccon2AH92VKwlILxigo0asDRcjZKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108903; c=relaxed/simple;
	bh=LvYX3cME3AJ70VaRKqOhXq67JTgrCyZqrp93iN2wUHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmmQLD/kYF8gBjnxJgSlMhCTYtmK11LCLcthStrzzAZCjtlEZNOqQfFJcUD5RjJHhvMsSqFvvsaK7SSFSIXGFnkjonNbq2NIoAv0iFLhRdej7wTJPba55b/tg0vXM00KrGPbJKSboAMpyJMbHJGMm9nqusGQyoeVmCFYUaTaKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qL9XQruz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G+IDj9bWpKqWiBt8Iz3SvHjmd4OIVVnq52tb3lSVp8E=; b=qL9XQruzYLdlpq8xypFjw42cmv
	JiXcBp7oL/12Yd+LJ19WD6gPt7GgULScNnBTAezimGsr8d/C62SCNSMlJPaBhqQet51pEZzNS35wK
	dG4btrI1Vw5nTBIqPQYwWuDU5R+gEoVX+wobcHj01UA4kWuxqKkHQa7lOKQNmKJYE0SK8Y3bryBUh
	dnbpQ5MjqMlPusw6/1xIo0ntK0ayVg/xtQshvPreGg0w8jR0+LJRiosHaNM4p/8aOZlWvrIHxXPdA
	XkvanIjIpK+Jj7+jLXxtrYykjTzq+6iLKG1LYaH7MwJlsvuAp8L+F8Y+eu3klVa2t0pgqjglb9zLM
	/tFvlnWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t5MMH-0000000AI05-18PP;
	Mon, 28 Oct 2024 09:48:21 +0000
Date: Mon, 28 Oct 2024 02:48:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Edward Cree <ec429@cantab.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] CREDITS: do the decent thing
Message-ID: <Zx9d5Xjk3XQGuZji@infradead.org>
References: <ff3fcde5-f8b3-4b20-36c5-68d73d0e4757@cantab.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3fcde5-f8b3-4b20-36c5-68d73d0e4757@cantab.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> Just because we can no longer work with someone does not mean we have
>  to efface their name from history.  Whether we consider them to be
>  good or bad people, I have seen no-one claiming that any of them were
>  bad *kernel maintainers*.  As an international collaboration, Linux
>  should be above national animosities, and where local laws force our
>  hand we should not go one step further than those laws require.  Are
>  we truly so small, so self-righteous?
> Oh, and dear Linus: I'm not a Russian troll.  I hate Russian military
>  expansionism (current and historic) just as much as you.  Try to use
>  *your* mush to realise that opposing the ham-handed and secretive way
>  the MAINTAINERS patch was done does not make one a supporter of
>  Russian aggression.
> 
> Sent from my personal address rather than my work account, because I
>  don't want to give my employer's lawyers any more of an aneurysm than
>  I doubtless already am.

Agreed with all of the above and:

Acked-by: Christoph Hellwig <hch@lst.de>

for the patch.  But please fix up the damaged whitespaces before
the subsequent lines.



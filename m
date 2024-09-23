Return-Path: <linux-kernel+bounces-336174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589DD97F01C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B2C1C21888
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123E19E98E;
	Mon, 23 Sep 2024 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB7yV0+h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C894316419;
	Mon, 23 Sep 2024 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114811; cv=none; b=pBOyRH6fCgymsuK/ECD4eCP/2N9SAJiOthDA2aohbOJIN3nONFBeZMaU3iy7igsY3yojluabmbfdC6CWer39WDrkeXGVIh1V4YT/Ggt6Dbi5n5g2VIayXAFPWzHAfIFznZS5gbrolZMp4g+GOGjV6Syqxt3eMa0ZrnI24kd3uZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114811; c=relaxed/simple;
	bh=y5b4KtnDOj4QBTD66t2HC9KVb7E5zAFjXeVF6r+5vVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbD02LK/nAA4aPoCt6osou38Qn7uIDUHXTKC0M9dqG2wVoI6ucFJzXfWJNlJpLcuQKAYCstaMKg5es4HESCZc2wuCM77XpQVumMU5ACQBoCBFaHiVPHHsk7oO2EnaamvAu4ZWQgmS2o6eKRCxbHBoFwFQS9UbfN3UeSsAz/GvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB7yV0+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034BAC4CEC4;
	Mon, 23 Sep 2024 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727114811;
	bh=y5b4KtnDOj4QBTD66t2HC9KVb7E5zAFjXeVF6r+5vVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LB7yV0+h1n3/JmP3b3a4oUuCHdpT3rQIfM6BNrAOyTzYM3lJs20E3KQMY6Qb5eroi
	 IaBDyCVuIxrqLyfzrX3r4DXrGP5f2zirSAy3QHAhl15FOfTMbbWLCWJRodk4Pchemt
	 7dMfCVsH53iJFSq8NCxqAf/kjf9cez9+rrpUekxLUNHje/zhzG4KRd0LMEW0e0I5i5
	 VE5UlPmr0VGVk6wmxZT0zsHaXNgzyxRAmewgGZg70MPdXP808RNgGDMUMIzwk4SgGR
	 LlNfyfB1/3SNj7pDCLIgZl8eLwwlS7Y2yn4v6zEorzYxE0UyMd7qqeOkcIRKr1vjKI
	 0P+LbnwijAjrA==
From: SeongJae Park <sj@kernel.org>
To: "Diederik de Haas" <didi.debian@cknow.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Update DAMON doc URL
Date: Mon, 23 Sep 2024 11:06:48 -0700
Message-ID: <20240923180649.557221-1-sj@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <D4DTEKH7A93W.1MGHTQZGU5UCC@cknow.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Sep 2024 18:46:57 +0200 "Diederik de Haas" <didi.debian@cknow.org> wrote:

> Hi SeongJae,
> 
> On Mon Sep 23, 2024 at 6:32 PM CEST, SeongJae Park wrote:
> > On Mon, 23 Sep 2024 12:05:58 +0200 Diederik de Haas <didi.debian@cknow.org> wrote:
> >
> > > The old URL doesn't really work anymore and as the documentation has
> > > been integrated in the main kernel documentation site, change the URL to
> > > point to that.
> >
> > Nice finding!  Thank you for fixing this!
> >
> > Nonetheless, I'd prefer having 'mm/damon/Kconfig:' as the prefix of the commit
> > subject.
> 
> Do you want me to send a v2 for it or will that be fixed when
> committing?

I think Andrew would make the change on his town when he adds this to mm tree.
But I'd like to reduce his burden if possible.  So, if you don't mind, please
send v2.


Thanks,
SJ

> 
> > Other than the trivial nit,
> >
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> Thanks :)
> 
> Cheers,
>   Diederik
> 
> > > ---
> > >  mm/damon/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> > > index fecb8172410c..35b72f88983a 100644
> > > --- a/mm/damon/Kconfig
> > > +++ b/mm/damon/Kconfig
> > > @@ -9,7 +9,7 @@ config DAMON
> > >  	  access frequency of each memory region. The information can be useful
> > >  	  for performance-centric DRAM level memory management.
> > >  
> > > -	  See https://damonitor.github.io/doc/html/latest-damon/index.html for
> > > +	  See https://www.kernel.org/doc/html/latest/mm/damon/index.html for
> > >  	  more information.
> > >  
> > >  config DAMON_KUNIT_TEST
> > > -- 
> > > 2.45.2
> 
> 


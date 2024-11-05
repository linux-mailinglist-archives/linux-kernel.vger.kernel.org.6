Return-Path: <linux-kernel+bounces-395726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8989BC21F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2661C21AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4843E125B9;
	Tue,  5 Nov 2024 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qioACxOC"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED9BA53
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730767484; cv=none; b=BAwTmym+2GDk003Y/P8gazhAYM6Eex4PivSQdIWE3ehYUGiPrRCGJeQfAYHae0/8ndoSHEgIHFdcC9e5uekzrALcUNui0Q6FYG7NTrMsnZbMw2hhB9Nbsw1OtUIg7whTVmrf73YNely5eToV9umrMvVNOsoiBODH1P5Mj+Gfej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730767484; c=relaxed/simple;
	bh=qI4U8UHlxuJ0ygiNz2oCZ4pANli9Ae9HqU6UmwdB83Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpHU5o/RrIAKl7JmRZtDkkvi0GBRbfcnD5qbE7+mQXXNLC3wG48Xu+83Jn3ibCyf70r2P0t6sdvEsmYeTKoPNM2qpI55wunAyMKyL+Jz+6MlxMhQ0T617JkzlSVoytcqqufdA4YOLpyCWWIMuTGY3pNl6/1q2BhOIbt8gfTgS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qioACxOC; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 5 Nov 2024 00:44:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730767479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEmM3g8sIXghcPr8TOIqNkDpB8IugLU270wgo1SRLLo=;
	b=qioACxOCGjN7SHmWYQ7+Cxp3M1WITO3BM64vMpdiVyUJNvZ2+SkP8tOC/rFW5bVcMLe2J0
	7KUYane+fiGHuUsYmEwJRd4RS4M6maq1Lj44tZuGz5TrOFa6HZxY0y3XtcaEr9UndKPKSm
	nuM5sDlFcgQfVjFiJc62TV7WJTKif44=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Keren Sun <kerensun@google.com>, akpm@linux-foundation.org,
	hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] mm: fix checkpatch.pl warnings in memcg v1 code
Message-ID: <ZylqcBXieSti46xr@google.com>
References: <20241104222737.298130-1-kerensun@google.com>
 <ZylnaFbRZMDYR_Hw@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZylnaFbRZMDYR_Hw@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 05, 2024 at 12:31:36AM +0000, Matthew Wilcox wrote:
> On Mon, Nov 04, 2024 at 02:27:33PM -0800, Keren Sun wrote:
> > The patch series fixes 1 error and 27 warnings found by checkpatch.pl in the
> > memcg1 code.
> 
> Please do not do this.  Fixing checkpatch messages in existing code
> is counterproductive.  Only run checkpatch on new code, and even then
> take its suggestions with a grain of salt.

I do agree in general, but not in this case. These are nice cleanups
no matter what checkpatch.pl thinks of it :)

Thanks!


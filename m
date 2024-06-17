Return-Path: <linux-kernel+bounces-218210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3034490BB17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A063EB23638
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBD817F397;
	Mon, 17 Jun 2024 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0b3hZ2ZY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D269929410;
	Mon, 17 Jun 2024 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652647; cv=none; b=INBUaiMj268zoZC/1mt4KnMYgn3OjmJZGAqMS7AHWCFgBsK1Sb1/eTNcwkzIij5iS5Sq+XXkfE8qMyzcXQ5kXzr+qnq66DGbTUb4uBwFzqwaXSt4wgTtpneiNnAmnYeWB9w9npmnWhAPpRftUjAfEFLa5kHLMjZSXucMNbuZKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652647; c=relaxed/simple;
	bh=cVX0SdYoJqBkMgOZqxZIHGybXqcAsvW36JJizcqc4bM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tSfE3nXrvF5n2tQVNNOY5PeMbxOsdwgGgGVZaDZ8IlYfAdZkiaUZWH4af9qfPaujBnQokEEeG/895LlzuI2kLPJc91vWvXplFmUiGb56UyV1vauzP0bEsBYbhujhlONNrGBNi2ISVvhEfmtjKGPPEN3JhARm7weYuiwFW8LOsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0b3hZ2ZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1606AC2BD10;
	Mon, 17 Jun 2024 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718652647;
	bh=cVX0SdYoJqBkMgOZqxZIHGybXqcAsvW36JJizcqc4bM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0b3hZ2ZYIH6ZRlB2Aa+pX+i1RRrO3GKwRfSPT02WUVo6Bfs+tMBhw+9DAQd5ycelg
	 jmFobRL5J4aPcRo0reLo577eHzghLNGjBa0ajqI1c6kAa56/FDzNnI7bRNduNcBQNm
	 xkAEMjVtDgLqww7ZYQTe2uRJ9UMSEjviAN9jtgZM=
Date: Mon, 17 Jun 2024 12:30:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Brendan Higgins
 <brendanhiggins@google.com>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the kunit-next tree
Message-Id: <20240617123046.51171b70e613606212c92b5a@linux-foundation.org>
In-Reply-To: <46645216-dcb7-45d6-83c5-fdd9451362ff@linuxfoundation.org>
References: <20240611152225.7264e9df@canb.auug.org.au>
	<46645216-dcb7-45d6-83c5-fdd9451362ff@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 13:21:25 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:

> Hi Andrew,
> 
> On 6/10/24 23:22, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commit is also in the mm tree as a different commit (but
> > the same patch):
> > 
> >    425ae3ab5a1f ("list: test: add the missing MODULE_DESCRIPTION() macro")
> > > This is commit
> > 
> >    245e5db4adaf ("lib/list_test: add the missing MODULE_DESCRIPTION() macro")
> > 
> > in the mm-nonmm-unstable branch of the mm tree.
> > 
> 
> Can you drop the patch from mm tree? It will help avoid merge conflicts
> in case there are other KUnit patches that depend on this end up in
> kunit-next.

I dropped this from mm.git on June 11.


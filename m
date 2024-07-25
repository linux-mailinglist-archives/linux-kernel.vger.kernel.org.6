Return-Path: <linux-kernel+bounces-262608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C5B93C973
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3FAB206AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85524770E9;
	Thu, 25 Jul 2024 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yrqZB9/z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BC4C7B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938886; cv=none; b=Sv/+JILwZ6wUNf4eCnz3cQDTYn6bXMPvRDsnatmXrNjeOpKZRrBZK02FSa4+IbnxC96UJbNWXY1JbBGDPtXmC4Qu0FomHdSYE4rRFaoyXEvAOo+95HFKBOFhdCa4+HeuNoyD9NViSubXGTHYgg7zQdtsGLiTlxgfpkn2g56SRAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938886; c=relaxed/simple;
	bh=EonBZNIMfXTTGkQRxL3TuRf0CW1y7npm618AHRH9WP8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DavH2+pfyMoEgvFwgDgOREXMNXJt/t7b6gbYrJG5bUfhuJjWnidCrEy/PmiZqae2BLZUAsXsB71PqKeuVw2eNj+g9xWQ2SHWptrlUqVl0x6fauvtJUFsbjrmKh6VsBevsltMvu7m9gbHXtWLOkgSweOfL568DQSjgCPuG/GkovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yrqZB9/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3266CC116B1;
	Thu, 25 Jul 2024 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721938885;
	bh=EonBZNIMfXTTGkQRxL3TuRf0CW1y7npm618AHRH9WP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yrqZB9/zlqvwOyFLOZjXi+h3U1J0x+irLixtZRkC5A0Q57noJA/pjvNAHZfXKHoeG
	 Q4+bDSmgnxN7mLBntgdCrWcgX9mgrw9ts3kXPiSi/nACJhR9Hk9EcKIGCwRAqecphE
	 hfiU/7AQbkCaZf+SzE5gaoXuA4CCyE0LMyyJz11w=
Date: Thu, 25 Jul 2024 13:21:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Davis <goldside000@outlook.com>
Cc: urezki@gmail.com, hch@infradead.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Capitalize letters for readability
Message-Id: <20240725132124.b0d317ba1d9e7d1651b71a65@linux-foundation.org>
In-Reply-To: <PH7P223MB1039C0F7DAC6FFB32F61DE48F7AB2@PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM>
References: <PH7P223MB1039C0F7DAC6FFB32F61DE48F7AB2@PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 15:28:29 -0400 Steven Davis <goldside000@outlook.com> wrote:

> This patch capitalizes the first letters of error and
> debug messages to enhance readability. This is important
> for adhering to the style of other error messages in the
> kernel, and making it easier and clearer to read the 
> messages upon the (likely dark) terminal.

hm.

x1:/usr/src/25> grep "  pr_[^(]*.*: [A-Z]" mm/*.c | wc -l
34
x1:/usr/src/25> grep "  pr_[^(]*.*: [a-z]" mm/*.c | wc -l 
97

If we're going to make this change then we should change everything,
add a checkpatch rule, etc.

But I do think such a change is too trivial to justify churning the
code around.


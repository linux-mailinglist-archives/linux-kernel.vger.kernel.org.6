Return-Path: <linux-kernel+bounces-524921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 466BFA3E8BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D217D188EEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB6D26771C;
	Thu, 20 Feb 2025 23:43:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D71EE006
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095027; cv=none; b=Ka8958uyM977+wkJmrEIz3a8mQl3qn0ATnzU8+Gktajk7Lt7vtCKQlqbK/DZEi92sBfFVrAPWIeEKPY2pMcpL3MbX7SK5TXPsT5nRED6n442YhlE9UHXNeZRFTz5aAZ4lVISiWmPFECx/rlWFc0Ft4/k6vISLIfHIZzowOVej5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095027; c=relaxed/simple;
	bh=mK3PrJ0kjaa7GyzsSTMs4dX7q0sSvturVmvEmE2Q5t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWYc3gmZJlMK5u1h7UCkfXKaZsOMg+BZ17JwLIZYr80BkePbAId779qHZmwVI+IneOEjj3PXzKqb7/GavzblJEAf1otA8LCoyBhZzAGhacf6Co3TMJbRTy0wxye3OOUw3jN5UVVb1JvKPcgb9n0U+TG61SywRKttQFrNCzMap2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC68C4CED1;
	Thu, 20 Feb 2025 23:43:45 +0000 (UTC)
Date: Thu, 20 Feb 2025 18:44:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Matthew Wilcox <willy@infradead.org>, Byungchul Park <byungchul@sk.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb
 numbers over 90%
Message-ID: <20250220184412.22c2c7fb@gandalf.local.home>
In-Reply-To: <20250220232503.2416-1-hdanton@sina.com>
References: <20250220052027.58847-1-byungchul@sk.com>
	<20250220103223.2360-1-hdanton@sina.com>
	<20250220114920.2383-1-hdanton@sina.com>
	<Z7c0BTteQoZKcSmJ@casper.infradead.org>
	<20250220232503.2416-1-hdanton@sina.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 07:25:02 +0800
Hillf Danton <hdanton@sina.com> wrote:

> > I'll tell you what would happen in my home town. If someone said
> > that to a co-worker, they would likely be terminated.
> >   
> Interesting, I want to know if the three words, rape, pregnancy and WTK,
> could be used before judge in your hometown court by anyone like your lawyer.

Hillf,

This isn't a court. And there's no reason to use the word "rape" in a
technical conversation on the Linux kernel mailing list. Perhaps a person
reading this was a victim of rape. How do you think that would make them
feel? Welcomed to our community? Absolutely not. Which is why it's totally
unacceptable.

-- Steve


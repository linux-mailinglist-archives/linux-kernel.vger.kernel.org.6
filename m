Return-Path: <linux-kernel+bounces-524855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4198DA3E7FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22619189FE21
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668B3264A6E;
	Thu, 20 Feb 2025 23:05:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07A179A7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092714; cv=none; b=IWIfnJkxMMJeLK88I968MNCPEI91PIKe5StJmlZyQsL2jmfk0QL/xuS4fXHhupygfEUxvtLAt/MSVAZq4B/G6F/zbg0sdoa55fl5i7a8Apm+cophFr0m/k3m2SsBRpHq7wYiyrFzVmo6rZfUs3IWmM8udsJV08rD3T+cf7bmR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092714; c=relaxed/simple;
	bh=igVOC7FZuOMG9A21SYd0Wpr0SJHMy/0fIUHuYX0rdOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqwaxjYfL4ZK9Ygl9D3BoK+U7oFQyZSHlXMwyQLNMWPfWIfqmM9Vg7ea4rubUCosfK/9nSbujCLnX74YZ/IpVYcTdZsYfcucgBhJo6NuVtIjtVUG9/TGBadCKZMobJKPf/LmhpVnCU3Gqy58+wINStaOSSX8EF2yDWACeAqp5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED73C4CED1;
	Thu, 20 Feb 2025 23:05:12 +0000 (UTC)
Date: Thu, 20 Feb 2025 18:05:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Hillf Danton <hdanton@sina.com>,
 Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb
 numbers over 90%
Message-ID: <20250220180539.0fadab4b@gandalf.local.home>
In-Reply-To: <ebna3dzn7aevgpzxjdb4vykmrheb7erqpdbos3ayl6tnimijpp@ibkvhcsa3pib>
References: <20250220052027.58847-1-byungchul@sk.com>
	<20250220103223.2360-1-hdanton@sina.com>
	<20250220114920.2383-1-hdanton@sina.com>
	<Z7c0BTteQoZKcSmJ@casper.infradead.org>
	<Z7dFuTkdQ7PmP7sY@home.goodmis.org>
	<ebna3dzn7aevgpzxjdb4vykmrheb7erqpdbos3ayl6tnimijpp@ibkvhcsa3pib>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 17:53:41 -0500
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> > I'll tell you what would happen in my home town. If someone said
> > that to a co-worker, they would likely be terminated.  
> 
> I can't agree with the "this is a firing offence" approach.

My point was, if this was in a company, it could very well be a firing offense.

> 
> We're a community, no one is employed by anyone else here; we work
> together because we have to and we have to figure out how to get along.
> We work via consensus, not appeals to authority.

As a community, yes, things are different. But we should not have to
tolerate such language.


-- Steve


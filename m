Return-Path: <linux-kernel+bounces-396765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062BF9BD1AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE611F250A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0424317C9B9;
	Tue,  5 Nov 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kkJWyW1j"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A415380B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822788; cv=none; b=eCeFrRGO/XpEpbqyj5YXKa0IHafMEIFqFY1mWaxvyK42kRlS56ngYVEUDyJaBBukqrhHISB+zGXTn3XEB6eG9b1vwJSQxUIuzYzrOK4LB2Jo8VtMXJgmXiVcyp5PNATgrjIBulqpKhi2OxyJndzT0WoR3+B2lmr5p9M6T7gS4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822788; c=relaxed/simple;
	bh=sbgLKZPjJro6OftLylKQYeSBOg3vHCE89pxzGK3ijEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKg5mxUWBtBASNT/KENE6budY4SHm9c81vmO6Gn0mImFIlPVB0osvbNj4qtG5d+NsH+H1TWt0zSiG5c8SMzNRVwXFjCv+y1sSOJDqQAihdEOf1y5R4P/Kgr/YhdNcD81grB1UE9nt68wzDzcfPc1Oa5ETHvh7td0F3/5VvkaVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kkJWyW1j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wNK4+WQ/AdJS8pNeUvM3UkTOhpJsFz8Q28pGPXZtp80=; b=kkJWyW1jzNujk9b5spEbNsseQz
	MgMqxxjGKCVuMc93lQg+0Q40GLAPqw6snxWi8PYMmLyTMvifD5kBn6T9dqNVt0tNwOBrIBZ3OlKmJ
	ezCRmTDBGj/6e6CiWCILjg1jjXOORomA3WBZzewL5Hq+WRGcNNUtOV2ugBk7HowjLikgYnoe4e2QV
	+ARIh0RDBmQ72GME2OoYKCJiAUh8wKATHjLGgbxdkfFIuIjFuznQfKjrRUi46ZuKgD3jg+iwWBkee
	qqyhrXXcDl375ydI7UwQbXUJZnEYzI82E+cA1lDciJc+ZEA7R/1+0ihGNbKGaEmhdUaiC2UC9Lbpl
	mTo1r0gA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8M4U-0000000BMZu-28Y1;
	Tue, 05 Nov 2024 16:06:22 +0000
Date: Tue, 5 Nov 2024 16:06:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dylan <falaichte@mailfence.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
Subject: Re: Russians in the Kernel
Message-ID: <20241105160622.GV1350452@ZenIV>
References: <1116521637.127547.1730818127738@fidget.co-bxl>
 <1552791356.130304.1730819601359@fidget.co-bxl>
 <237077017.130501.1730819723674@fidget.co-bxl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <237077017.130501.1730819723674@fidget.co-bxl>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 05, 2024 at 04:15:23PM +0100, Dylan   wrote:
> Hello everyone,
> 
> The recent stir about the removal of prominent contributors from the Linux kernel for nothing more than being Russian has prompted me, someone who has absolutely no business being in and around the kernel mailing list to compose a message and hopefully provide the prospective of an end-user of the Linux kernel. Some people feel blanket banning an entire group of people for the wrongdoing of a handful is rather unfair and not in keeping with the spirit of free and open source software. Rather than complain about the change and governmental overreach in community projects, I'd like to offer a technical solution that could ensure things continue as they have while adhering to sanctions.

WTF is "being Russian" and what does that have to do with anything?

> Would it not be possible for the Russian kernel development community to pull together and continue working on the Linux kernel in their own tree and then have any patches sent back upstream by someone that is not a Russian citizen? I feel the solution would definitely help with making things right to the veteran contributors that have been working on the kernel for decades and allow patchsets to be more closely monitored for possible sabotage by having all patch submissions be sent through an intermediary that is easily identified as handling Russian code.

*snort*

For one thing, sanctions are not tied to citizenship.  For another,
any proxy set up to bypass the sanctions that really exist (i.e.
based on employment by sanctioned companies) would fall under the
same sanctions.

For another, you _really_ don't want to set anything with even
the slightest whiff of "that's how to hide patch origin and/or
evade review" - that's an open invitation to any organization
that wants to feed something underhanded into the kernel.
Won't be a healthy place to hang around, to put it very mildly.


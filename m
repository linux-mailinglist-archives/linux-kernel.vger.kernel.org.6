Return-Path: <linux-kernel+bounces-519989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C291AA3A46D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BAF1892E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19326FDAD;
	Tue, 18 Feb 2025 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iClLy0g7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0413211499;
	Tue, 18 Feb 2025 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900218; cv=none; b=Gw/2qbMDYXIbik/7q+sn6wwWTZfsB4DRRYnjq4+E9QjZVRALjErIls8HfGSUZzXktDpWMIJWZwtHnA0Z7DmE7TPF9CXN2XVUwYoefxLLRlEoklP058V7AP07lwOJ3uh0qjKMqsOD2d+NwGVUutiBqeFUgw340utOYG+/PNBHoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900218; c=relaxed/simple;
	bh=cf0I6T/jgGhCH/BIbTGo1aKei5EhfdmRIPY++ABuDYk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M3XvSEhwZxgRZJ4hBKVeP2SF6AW4DRcN6dPyhqj1bUO1GNtC7MeUgKcYY/KQDJCWe/Tnkc85Qf75vtu6nCHRQfB7psm535qc3N3OVDiVVDUYsA7ytXIuqoOlsrmOrJUvJ5PpjsSagOHBCsSdhN7xFCLoqs67Cuy+aDOSoai2agk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iClLy0g7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DC2C4CEE2;
	Tue, 18 Feb 2025 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739900218;
	bh=cf0I6T/jgGhCH/BIbTGo1aKei5EhfdmRIPY++ABuDYk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iClLy0g7emGVyZ6/Fzt6cE0y4nI59VWbE2vPP7VbgsswOEE4zbecUQW9oe6zgh3Pa
	 lSMr+PWoNQu6JhPT6DlQIp4mBjMCVvIDXigpHTQVCXtS7Ts9cPuk8CQ3Rrj4LVOVS2
	 msc8nFrZaJ87OM+5/AyusG9xB+a9NEs8jqimINhzhU5e8g2GsCJ1ykJ8H5MQa7Qlj9
	 vCbhGmQJheMtGOEuVlC7z/1rPouVqc9Vxl5cxVkBXSV2nq/2lHYSP4BPBbI9N/5oqx
	 WObK7uzLypbaLjxISYEG0m7z3ovsNHBZuBkcR6/bTUgn7qJFzdegU3lmLDUMb8IKM7
	 K+r3Ec4vzq9yA==
Date: Tue, 18 Feb 2025 18:36:55 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
    rust-for-linux <rust-for-linux@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>, 
    linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
In-Reply-To: <Z7SwcnUzjZYfuJ4-@infradead.org>
Message-ID: <45rpsr92-4416-9no4-8o26-r0998nr77nr8@xreary.bet>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Feb 2025, Christoph Hellwig wrote:

> So we'll have these bindings creep everywhere like a cancer and are
> very quickly moving from a software project that allows for and strives
> for global changes that improve the overall project to increasing
> compartmentalization [2].
[ ... ]

> [2] The idea of drivers in eBPF as done by HID also really doesn't help
> with that as much as I like eBPF for some use cases

I don't necessarily agree on this specific aspect, but what (at least to 
me personally) is the crucial point here -- if we at some point decide 
that HID-eBPF is somehow potentially unhealthy for the project / 
ecosystem, we can just drop it and convert the existing eBPF snippets to a 
proper simple HID bus drivers trivially (I'd even dare to say that to some 
extent perhaps programatically).

This is not growing anywhere beyond pretty much a few hooks to make 
writing HID-eBPF driver code more convenient compared to creating a 
full-fledged kernel one.

It's mostly useful for quick-turnaround debugging with users who are not 
generally capable of compiling kernel modules / applying patches to test 
fixes, although the usage is admittedly slightly expanding beyond that.

To me that's something completely different than making changes (or 
bindings, "ABI stability contracts", or however we want to call it) that 
are pretty much impossible to revert, because everything quickly becomes 
depending on the new core code.

-- 
Jiri Kosina
SUSE Labs



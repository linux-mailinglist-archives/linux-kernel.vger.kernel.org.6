Return-Path: <linux-kernel+bounces-405523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FD89C5266
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E154283630
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13EE212163;
	Tue, 12 Nov 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="izgjO7xQ"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0C1E4AD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404923; cv=none; b=VRERCvgXMWfFO+K8hvr+0qI9pGNcDLUcbPrdxMRaPIjOnxsYTEUazYCgKcg1yJq+fgP8yHQCBlwos29ANrXHiU8YmsokvbmH3p1UKcBGzXQ4Sd3AcYC6ES4xihEnG+4g3KjaiccB0PD+xVjSJF4Gc7WmadCcA4RjvVYuQUbLH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404923; c=relaxed/simple;
	bh=LrtAQhxTOMENsDkUTMA8xkgddOLcwv2DtqWpfLXRdSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXULSIpBZJZvkJg6b3ftIX07tGcr1fHqwxYPuUKn0ldDT20nmBnVz/8VAGjLRN7iyl38xgkf9hw8mvEwEhi9xhFhfuYAhJ0GJzeNlAw6BGZqJazx/TsOWIx/daDqAEc7QTHVFKdQg/posLJPlArvfIH0hBc4PECie0J0Jj9Abkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=izgjO7xQ; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 2255042118;
	Tue, 12 Nov 2024 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1731404914;
	bh=LrtAQhxTOMENsDkUTMA8xkgddOLcwv2DtqWpfLXRdSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=izgjO7xQF0rD6dbjle7potQOfb9o9kMeJg2fNMJf8M1tniYhJhTTkLi9xDlxySdyc
	 as71DhG+oYTmbbnKJZi+c1pgLLJn5MIyXyTvXjwDIbn1OM34NrlPw/Y6r2M2AhPptT
	 UpcwHIaPq80Dua/+/TLdHrFwMQti+IV+pwkGVnxOl/HYQeGmgCZN8YiI90MakOj4R7
	 sWW66AMdHFfwtUScOnZQw9Q2NTCrzvo3ekF+2f4F0H+1PLW/dcKT+c9f+vo5Fxa5FO
	 f5BXMI1vpr7SmkA5NsgJjzx1xz4Dsjw6uWUFTmhKo9eryVEY9wSLk4Tn/Y3LFdVKTZ
	 o6zLkpX+KOdYA==
Message-ID: <821d15f9-233e-4b9d-8194-5de1835113c7@asahilina.net>
Date: Tue, 12 Nov 2024 18:48:33 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix __wp_page_copy_user fallback path for remote mm
To: Alistair Popple <apopple@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Sergio Lopez Pascual <slp@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 Dan Williams <dan.j.williams@intel.com>
References: <20241101-mm-remote-pfn-v1-1-080b609270b7@asahilina.net>
 <c00226ea-6e29-4432-a1c4-a25e9e05df9c@redhat.com>
 <2d8380b9-3d03-4263-b5bf-7e0227c83ba9@asahilina.net>
 <0977a33b-8318-43a5-a5a1-4eb8c93ca270@redhat.com>
 <64d386e8-6684-4213-8aba-7d1daf94f2cf@asahilina.net>
 <412298ff-80bc-4111-8c72-29a5263a5d32@redhat.com>
 <87ttceu0i8.fsf@nvdebian.thelocal>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <87ttceu0i8.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/24 8:24 AM, Alistair Popple wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 07.11.24 18:32, Asahi Lina wrote:
>>> On 11/8/24 2:14 AM, David Hildenbrand wrote:
>>>> I recall that there is still a problem with false-positives on
>>>> folio_test_anon() with ZONE_DEVICE pages, so it's maybe not that
>>>> easy ... and the whole get_dev_pagemap() stuff is nasty.
> 
> Specifically FS DAX reuses PAGE_MAPPING_ANON in
> include/linux/page-flags.h
> 
>     /*
>      * Different with flags above, this flag is used only for fsdax mode.  It
>      * indicates that this page->mapping is now under reflink case.
>      */
>     #define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
> 
> FS DAX pages are never anon though, so you could probably test for
> !vma_is_dax() and/or add an implementation of is_fsdax_page().
> 
>>>> Likely we would have to do what GUP does, and temporarily grab a pgmap
>>>> reference. Gah.
>>>>
>>>>
>>>> So if we sort out the pagemap stuff and the possibly wrong
>>>> folio_test_anon() on some ZONE_DEVICE pages (but not all, because IIRC
>>>> DEVICE_PRIVATE can be anon ...), it might be doable.
> 
> Correct, DEVICE_PRIVATE and DEVICE_COHERENT pages are always anon (at
> least for now).
> 
>>>> But it sounds ugly, especially because that code might change soon and
>>>> not require messing with ZONE_DEVICE pages on that level.
> 
> Yes, I'm hopoing to get the next version of that series posted this
> week. I found a couple of other FS DAX bugs that slowed me down.
> 
>  - Alistair
> 
>>>> And then, we'd not be able to handle VM_PFNMAP cleanly ...
>>>>

If this is all going to be fixed another way soon then I think there's
no rush to get a workaround in earlier than that, I just don't want it
to fall by the wayside.

We have my original patch downstream in libkrunfw (which despite the
lockdep complaints does work in practice), so we can keep that in until
the proper solution lands upstream.

Alistair, can you Cc me on future submissions? So I'm reminded to test
this out (FWIW the case I'm interested in is just `gdb /bin/foo` with
the whole root filesystem on DAX, though I imagine a statically linked
foo on a DAX mount by itself is probably an equivalent repro).

~~ Lina


Return-Path: <linux-kernel+bounces-405754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFD39C5699
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904F71F265AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1472E1FB730;
	Tue, 12 Nov 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="aQZUj9n9"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92951F77B6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410900; cv=none; b=n/Z9Wrbtfdl3IBdcm2UlKkJ9RMUynKkHY5BtA+dhdpzojwi6vTikyXwdyZl08PNqdCHZWdGr850TUiwFUxb/cLosLsqi385eG5jcSOGidKjPtWItvchh5uxlBVbivyWFgIpWEj0rKxmxYOKq3+obSmkFF6FSAiZlwaD5D4JGBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410900; c=relaxed/simple;
	bh=qvVC5S1lMfYGMt3SGwT/Cfc8QpLCdcFWKTOkeSrlUmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1jos772cf4Vwgoo24A69NUyivZGn9fHJdOUnqLR+WsrimpbZh3yVav5YGSzdbNlX7u41afOpYcpGJakhb2ZOwq4RMblzVe2fyL7B+gRKpjfi5vAqymqDEXCwZNJfr9NJ3a+87vQ1ZSQkbsizhErGb2zWmXM1P4yOYi4HP/8Cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=aQZUj9n9; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id E9DC741F4A;
	Tue, 12 Nov 2024 11:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1731410895;
	bh=qvVC5S1lMfYGMt3SGwT/Cfc8QpLCdcFWKTOkeSrlUmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aQZUj9n9OUMWu43r9D/leB3Y2fi2fV3QlOQgBqKo33YFuUI/tHDCNdJgRnJEU4F/V
	 e0w3YlehUoYGsA4PdGH0bP05q6VSOp3N9WQ1DYxg2BXz79kjxK3/JSA0LlOlLWKH6u
	 wXRXTlIgOSMuXQNUh6HeehcCXR/AvZ+QZ+2P75ygR07+ncUWAaYbUwOHVZ2xc+Z8Al
	 WdqFfGzRVbn5UbZM0ob0E50wm3ZyX7n3Ft5BtXMCQmwKgbvLd2YsxqWHS4MjL5jm2Y
	 r7SRztYNelCK/wlfunlOXiuOsSY8CAW5MwKDxuADnu7KVZch/Hqoss5afDbXC5iEqg
	 Tqz2ZmKEMJmPQ==
Message-ID: <e2d5f3a5-f6f1-4567-a162-a0e814292738@asahilina.net>
Date: Tue, 12 Nov 2024 20:28:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix __wp_page_copy_user fallback path for remote mm
To: David Hildenbrand <david@redhat.com>, Alistair Popple <apopple@nvidia.com>
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
 <821d15f9-233e-4b9d-8194-5de1835113c7@asahilina.net>
 <50578e9d-6562-4f0f-af7c-cabfb875bbb7@redhat.com>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <50578e9d-6562-4f0f-af7c-cabfb875bbb7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/12/24 7:00 PM, David Hildenbrand wrote:
> On 12.11.24 10:48, Asahi Lina wrote:
>>
>>
>> On 11/11/24 8:24 AM, Alistair Popple wrote:
>>>
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 07.11.24 18:32, Asahi Lina wrote:
>>>>> On 11/8/24 2:14 AM, David Hildenbrand wrote:
>>>>>> I recall that there is still a problem with false-positives on
>>>>>> folio_test_anon() with ZONE_DEVICE pages, so it's maybe not that
>>>>>> easy ... and the whole get_dev_pagemap() stuff is nasty.
>>>
>>> Specifically FS DAX reuses PAGE_MAPPING_ANON in
>>> include/linux/page-flags.h
>>>
>>>      /*
>>>       * Different with flags above, this flag is used only for fsdax
>>> mode.  It
>>>       * indicates that this page->mapping is now under reflink case.
>>>       */
>>>      #define PAGE_MAPPING_DAX_SHARED    ((void *)0x1)
>>>
>>> FS DAX pages are never anon though, so you could probably test for
>>> !vma_is_dax() and/or add an implementation of is_fsdax_page().
>>>
>>>>>> Likely we would have to do what GUP does, and temporarily grab a
>>>>>> pgmap
>>>>>> reference. Gah.
>>>>>>
>>>>>>
>>>>>> So if we sort out the pagemap stuff and the possibly wrong
>>>>>> folio_test_anon() on some ZONE_DEVICE pages (but not all, because
>>>>>> IIRC
>>>>>> DEVICE_PRIVATE can be anon ...), it might be doable.
>>>
>>> Correct, DEVICE_PRIVATE and DEVICE_COHERENT pages are always anon (at
>>> least for now).
>>>
>>>>>> But it sounds ugly, especially because that code might change soon
>>>>>> and
>>>>>> not require messing with ZONE_DEVICE pages on that level.
>>>
>>> Yes, I'm hopoing to get the next version of that series posted this
>>> week. I found a couple of other FS DAX bugs that slowed me down.
>>>
>>>   - Alistair
>>>
>>>>>> And then, we'd not be able to handle VM_PFNMAP cleanly ...
>>>>>>
>>
>> If this is all going to be fixed another way soon then I think there's
>> no rush to get a workaround in earlier than that, I just don't want it
>> to fall by the wayside.
>>
>> We have my original patch downstream in libkrunfw (which despite the
>> lockdep complaints does work in practice)
> 
> I assume it's sufficient to deadlock when a writer pops up after you
> succeeded with the first read-locking, and before you start the second
> read-locking. IIRC, rwsem is a fair lock, so read-locking when already-
> read-locked is not guaranteed to work.
> 
> That's why lockdep complains.
> 

That's fair, I just mean that "works most of the time" is probably good
enough for the time being considering that this codepath is only invoked
by debuggers in practice anyway.

~~ Lina



Return-Path: <linux-kernel+bounces-240417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3E2926D65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D531C21A03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0761805A;
	Thu,  4 Jul 2024 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x+5GUD8q"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083D17BC9;
	Thu,  4 Jul 2024 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720059523; cv=none; b=gAWF4Tp1l5JhGvt4TlVZDn2YfFAKVGcCBsanZ08ReAtvpofAUjBg5qjjxQhJ4rHa5txS+i2K0pDifqJc29zfayF3uJb9khSZjnZvftqS+PvVAoKUbAulWVo0IQXoFrHx+0xOLARl/RPGm/4pMYJqyaCGhSJFrqLWcH8UU3du5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720059523; c=relaxed/simple;
	bh=Kvg4uFFS+cAF10ezRPJVO6ka+cVbzGF66bEBj7SFleQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHh4vXsDgF+fOAp4wnQQ4GoB5BarzTizAemxImS73Vz9u/dI+EeIU6/Y4qZ+ko8OYZv94ZF+1zaP+gVQWbbfA8dfPvyEwl81pjweeea5HUXp8eL6img3lxl/2p0EXwz2u5mKOv9Yv4J25wS9ZFzoihfRbYUjZV/hUF0XZwe6+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x+5GUD8q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=94REdKfYR7keuLl0NvxhS+99V2sHMpOB+7xBvMYVslo=; b=x+5GUD8qyxaMpRyngAU0uPUxTJ
	TozvgJh1Dm/co3t7c5K8Jl5rhhprfx7fRsmvLJpgdAjvDw++b+7cvaAUo09C3cWS7/DT/IsuiaJ0I
	6Ygmi1jZcPHEO3i30B3+j/J8I5rvMv2YOFulDELzCaN+dOYLX5CSS4XmSctxhq4Yitraf3wmnF4V5
	Lw2gvgRZKiJLAQ+H4rnSY1ylbpmbgPZzkW9pEA4soqOnT6M5M0g8wrD2GzqTX/2EPVkfM892+C/CA
	J73bwMW/TtdzvV5m0D2303E639GLnZBK44lpfJXkd3hts5DXjSFsVtGSKVLj0qMl35M4x5flb1jXq
	q2y2XT6A==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPC3P-0000000BvQt-1W1H;
	Thu, 04 Jul 2024 02:18:35 +0000
Message-ID: <1d805df8-748a-4bbc-a3d9-d6aa01a0b16e@infradead.org>
Date: Wed, 3 Jul 2024 19:18:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Docs/mm/index: move allocation profiling document to
 unsorted documents chapter
To: Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kent Overstreet <kent.overstreet@linux.dev>
References: <87msmyt8zh.fsf@trenco.lwn.net>
 <20240703230040.90283-1-sj@kernel.org>
 <CAJuCfpFO_C_LgxrRWrxG9o==RRtYAbkbP3ZJULwdmTjDcAJNrg@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJuCfpFO_C_LgxrRWrxG9o==RRtYAbkbP3ZJULwdmTjDcAJNrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/3/24 7:10 PM, Suren Baghdasaryan wrote:
> On Wed, Jul 3, 2024 at 4:00 PM SeongJae Park <sj@kernel.org> wrote:
>>
>> On Wed, 03 Jul 2024 16:18:42 -0600 Jonathan Corbet <corbet@lwn.net> wrote:
>>
>>> SeongJae Park <sj@kernel.org> writes:
>>>
>>>> The memory allocation profiling document was added to the bottom of the
>>>> new outline.  Apparently it was not decided by well-defined guidelines
>>>> or a thorough discussions.  Rather than that, it was added there just
>>>> because there was no place for such unsorted documents.  Now there is
>>>> the chapter.  Move the document to the new place.
>>>
>>> I'll take this for now, but it's truly sad to see new documentation
>>> being added to the slushpile at the end.  It seems better to create a
>>> "development tools" section in the new outline and put the allocation
>>> profiling document there?
>>
>> I have no strong opinions about that.  Cc-ing Suren and Kent, as they are the
>> author of the allocation profiling document and hence might have some opinion.
> 
> IMHO if this would be the only document belonging to "development
> tools" then keeping it under unsorted is fine.
> If more documents will fall into that category then Jonathan's
> suggestion makes sense to me. Looking at the current list, page_owner
> and maybe damon might be considered for this category as well.
> SeongJae, WDYT?
> Thanks,
> Suren.
> 

Documentation/dev-tools/ already contains 20 files.
Unless you want to keep it under Documentation/mm/, that is.

-- 
~Randy


Return-Path: <linux-kernel+bounces-435868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297DF9E7E19
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FF41887364
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7278227470;
	Sat,  7 Dec 2024 03:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GjAb1UEO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDE54652;
	Sat,  7 Dec 2024 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733541878; cv=none; b=dP0xtlqBIWviot0Iy2FuprONKbWnX1fRdPV3L2UPHIkPtzbYLNreY5ezErlixP0BdNGp1yEigbVS8X5Ru1g7VQdaXViGl59zskyhtMb0b6w+TK05t9aDMX0fhNkbod6OLHieemrdyOKR/1Vh/iCB02+QaQarBYPHKYZcS5OXv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733541878; c=relaxed/simple;
	bh=8dTTICXOY5sMJezD8l2pZrs7KvqENMOpc2Joj8JVtHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gowD+pKgHuA2oQKPi2FCrbC5vW2r8AD7aFFKty7abaHEBqWBL/ZMC64ZNDcrIlbevNh8+cLDeWsTDi0eM5ucjsKN+akL28kLqDzO39dhO64g6IaGXiFn1Nholl1tKRW4EbzfQ4O/p/mHB/ceXBUQI8/p/BS1P/qHZvq8qRI3otI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GjAb1UEO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=nKj9c8ew3kNAe5SKbPkZjUFfwubf/S0pdSa5aoLLfC8=; b=GjAb1UEOgeruIM2Icpq8rmj/2Q
	azopy9/npMjjJZoa3XU0SBPYzU3n+mGtCkdYUtmAX3plraPVZsRHEI/kBJO0uhP57uXBH/eZozzO1
	99YMhcfAG/dOAXi8WS4uwvIj+LZk6pHmumv8h88AOZmV/r2IdfyvRXlhKWKr7mtduV/lD0fj3A3uq
	4MfQqm7/1JqCWQG87J+Ga1tPyM6ALi9CI4L27jonNC/0gA4KNWso7JPd8myj2vh4rOWkE2go3iMOz
	edjFe1+Avs3slI8u2mMgSosg+ru+LWYkjQxkzk272VwTKJgqoyN6fmjj9yOA/dbI+AcIyi6SbRkn6
	EEHwKAJQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJlQM-0000000FMX3-1bIG;
	Sat, 07 Dec 2024 03:24:08 +0000
Message-ID: <9baeaab7-61d8-4121-8aa5-cf1c129daa40@infradead.org>
Date: Fri, 6 Dec 2024 19:23:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] docs/mm: document latest changes to vm_lock
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
 mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
 oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
 peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
 brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
 minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
 souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com
References: <20241206225204.4008261-1-surenb@google.com>
 <20241206225204.4008261-7-surenb@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241206225204.4008261-7-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Can someone explain what the (consistent) usage of '!' does in this file?
This is the only file in Documentation/ that uses this syntax.


E.g.:

> diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
> index 81417fa2ed20..92cf497a9e3c 100644
> --- a/Documentation/mm/process_addrs.rst
> +++ b/Documentation/mm/process_addrs.rst
> @@ -716,7 +716,11 @@ calls :c:func:`!rcu_read_lock` to ensure that the VMA is looked up in an RCU
>  critical section, then attempts to VMA lock it via :c:func:`!vma_start_read`,
>  before releasing the RCU lock via :c:func:`!rcu_read_unlock`.
>  
> -VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` semaphore for
> +In cases when the user already holds mmap read lock, :c:func:`!vma_start_read_locked`
> +and :c:func:`!vma_start_read_locked_nested` can be used. These functions always
> +succeed in acquiring VMA read lock.

thanks.
-- 
~Randy



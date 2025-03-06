Return-Path: <linux-kernel+bounces-549279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC94A5503A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725391887EB4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AB021149F;
	Thu,  6 Mar 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlNCe4dW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468691991CF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277365; cv=none; b=CeXXRmx2/fEABv/YJjIib1/lQhfiw5oPqC0KD3P6Alf79tH1b0m8FhrCtJYMbKQzWuM1aXF+B2TGQq4r3z2hWE2XbXQa4zNf6yR+gQOBU2fyp0Qh5hFCEyMTwJsDos1TOV0uCXulhd8aINv6wpfYXEfwpqf0bD89BMGoMz7V17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277365; c=relaxed/simple;
	bh=mbEDFlMfOQjMT/91+LVAC5cfjE6oIz8x1TltphBKM+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Umen2OJ5Ey79wvuzOa6jam7bTUTjJxN07otzoSUZvKJ40pyaJ0rCsYmx6MoryLXusFBpSTa7r0VOV7TPtmLJEyN8FD3xiJLUAelBTLdKO4neZW77/9EEhOq2Ggfs3Ghn5p2381nJhn3ek6I2L9f14688NCxg2oqFUduw08xN2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlNCe4dW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741277364; x=1772813364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mbEDFlMfOQjMT/91+LVAC5cfjE6oIz8x1TltphBKM+o=;
  b=DlNCe4dW74LA4sbrZu8xp00cLf7ftBVEJAJWjN3mQlNafgI0kzvgDsK9
   WCIscdHwo5LYxXOcsqOrXDtvw8TjnSLkmcStCe0RN2negbsihwnEv2fwj
   J4g/uhFCxFklNtRjzfcmpn931RKcKyBJBnZ39UUZKyS5xjfMTfamHjdzC
   xWEBbEbwykLdq02AEaH9ynwo/dTXL9sbvIfPzhewnv/EqSJl5iJsJZWnk
   sm6xzE7NpzZgcvHAxuQG/siPHe9b+6JJ68h5d4ycTS0e/m2lj9qakpx9W
   O4jJpo4q2inolhnoAK2s5zRHodeT0ngOWEXg2Ua/Nn0Zwi0sPyEWGrwTH
   Q==;
X-CSE-ConnectionGUID: 0g0Zzyp7T+C6LcMmO+mPdQ==
X-CSE-MsgGUID: xyS/KVf8ROSZtsYM2oUfTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42495392"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42495392"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 08:09:13 -0800
X-CSE-ConnectionGUID: aveQA0pmQyyg28REEV5zCA==
X-CSE-MsgGUID: tOd5QqqARrqslTXHXpQOmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="118798282"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.31]) ([10.125.110.31])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 08:09:11 -0800
Message-ID: <716f5a42-6828-4f0e-9002-d3bd5c4ad363@intel.com>
Date: Thu, 6 Mar 2025 08:09:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/vmemmap: Use direct-mapped VA instead of
 vmemmap-based VA
To: Andrew Morton <akpm@linux-foundation.org>,
 Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: "Harry Yoo (Oracle)" <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
 osalvador@suse.de, byungchul@sk.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, max.byungchul.park@sk.com,
 max.byungchul.park@gmail.com, x86@kernel.org
References: <20250217114133.400063-1-gwan-gyeong.mun@intel.com>
 <20250217114133.400063-2-gwan-gyeong.mun@intel.com>
 <Z7QaPwI1eMPEwHii@MacBook-Air-5.local>
 <20250217214342.33b4fcc4e775cf5ca70053a0@linux-foundation.org>
 <06eff380-a386-44d1-9115-33a08c2d8c95@intel.com>
 <20250305194641.357826b606a53f98474eb997@linux-foundation.org>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250305194641.357826b606a53f98474eb997@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 19:46, Andrew Morton wrote:
> Can we please have review from x86 maintainers?

I didn't respond here because I thought this was the same problem from
the same contributor that we addressed in another thread:

> https://lore.kernel.org/all/d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com/

I think this approach is a hack. It basically requires that every bit of
code that _might_ update (and then use) a PGD in the init_mm know how to
find the direct map alias and then use that instead. This would further
specialize the x86 code. I have no reason to believe that this is truly
an x86-specific problem. Are we really the only arch that has a
per-process PGD that maps the shared kernel page tables?

The right solution (like I mentioned in the other thread) is to sync the
PGDs more aggressively. Syncing them is expensive, of course, but it's a
pretty darn rare operation.


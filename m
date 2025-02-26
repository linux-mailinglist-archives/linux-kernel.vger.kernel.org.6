Return-Path: <linux-kernel+bounces-533647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926EFA45D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00E23AAF63
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24A2153EA;
	Wed, 26 Feb 2025 11:30:44 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70832189F57
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569444; cv=none; b=BIphAVjHUcRL+dzFORkbp1cOg12e1lhA7v33GJVv9vwVimenaXcSxSs3q47HrvJvwlyLKmNVibWY9CoT/VzuiTIJghHLLgM4apz6Rp70BO0sJNYOMTqEu0ZuhlpHt01GR7Aa5QAY2wiDJP1JZndiCNMkBuJwV/N5IFNq5QZ2BdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569444; c=relaxed/simple;
	bh=Vj0k0Xz8v+PvsqVolEgKEFB7rkqHzqE8zyl2dJdOgK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY6W7othdS9KVnDygQ8KnJpS4H/lVxp7hgfg1uhx9R6vkVA3OTfp/qSkzhqjsuAPZXXPGiCzxVTGg+10qxy8nweZU2j7fDLrKlpfB9PCwpueOvOdx8KRzpS/h1Ny8+ysVVRYItQCd4c74KowHK6ngzOJCbGVhTPk3lZ62Dxkgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-d3-67befb55b04c
Date: Wed, 26 Feb 2025 20:30:24 +0900
From: Byungchul Park <byungchul@sk.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, ying.huang@intel.com,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	willy@infradead.org, david@redhat.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	rjgolo@gmail.com
Subject: RFC v12 rebased on v6.14-rc4
Message-ID: <20250226113024.GA1935@system.software.com>
References: <20250220052027.58847-1-byungchul@sk.com>
 <8accbd91-ca59-43f8-b190-7e1ac3df5e11@intel.com>
 <fc94c383-5788-43c8-beb3-2fd76acae7bd@suse.cz>
 <20250220233710.GB39373@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220233710.GB39373@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsXC9ZZnoW7o733pBvtmaVjMWb+GzeLzhn9s
	Fp9ePmC0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL2Y19jBbHp0xltPj9A6jj5KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8f7fVfZPM4sOMLusfWXnUfj1GtsHp83yQXwRXHZpKTmZJal
	FunbJXBl7F/tWPBPuKJ58zHGBsb9/F2MnBwSAiYSt088YIOxvx1tBbNZBFQlXjT1MYPYbALq
	Ejdu/ASzRQRUJB5tOMraxcjFwSzQziyxoXMaWEIYqGHjxRVANgcHr4C5xMwOXZAaIYETjBIz
	+xtZQGp4BQQlTs58AmYzC2hJ3Pj3kgmknllAWmL5Pw6QMKeApcS59pPsILaogLLEgW3HmUDm
	SAhsY5dYt/QrC8ShkhIHV9xgmcAoMAvJ2FlIxs5CGLuAkXkVo1BmXlluYmaOiV5GZV5mhV5y
	fu4mRmBMLqv9E72D8dOF4EOMAhyMSjy8D87sTRdiTSwrrsw9xCjBwawkwsuZuSddiDclsbIq
	tSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA2PPRpc/bissa9MDgoQc
	U6dwxsfr19gVXlnUVxHHOPGgYez/13v+Cvz8l3Z814llv9QVbpc/Dpv1T2jOJ/aM5AquFaHR
	IWtvfUrIPi3Xel9rz6ffD57EBHJOuHcroTpyw4VZx+OEEnWScvzWbmAqfRF9v4Lxxttt1dKS
	sT/ufW6N+1sr9TGNrVKJpTgj0VCLuag4EQDrtH8GxQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXC5WfdrBv6e1+6wYs3YhZz1q9hs/i84R+b
	xaeXDxgtvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBazG/sYLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj/f7rrJ5LH7xgcnjzIIj7B5bf9l5NE69xubxeZNc
	AH8Ul01Kak5mWWqRvl0CV8b+1Y4F/4QrmjcfY2xg3M/fxcjJISFgIvHtaCsbiM0ioCrxoqmP
	GcRmE1CXuHHjJ5gtIqAi8WjDUdYuRi4OZoF2ZokNndPAEsJADRsvrgCyOTh4BcwlZnbogtQI
	CZxglJjZ38gCUsMrIChxcuYTMJtZQEvixr+XTCD1zALSEsv/cYCEOQUsJc61n2QHsUUFlCUO
	bDvONIGRdxaS7llIumchdC9gZF7FKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGGHLav9M3MH4
	5bL7IUYBDkYlHt4HZ/amC7EmlhVX5h5ilOBgVhLh5czcky7Em5JYWZValB9fVJqTWnyIUZqD
	RUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAmCFiopF4cLb2i89qKj3/DoROPWgytWnmfDfL
	M8m6tT710mFrvVvDJrGf1noWzqJVumiZ4vQtLc8Xc7qnJr+vV15Y/HSfY+Skm7oFlX7hi6Ku
	K9v8kcgO+Me4NNt41q/XrwUjsyzlfgRrprTbR7z/fqorNVzH0jjgWlDo+xwrBbtAjrY9f92U
	WIozEg21mIuKEwE7jT2ErAIAAA==
X-CFilter-Loop: Reflected

On Fri, Feb 21, 2025 at 08:37:10AM +0900, Byungchul Park wrote:
> On Thu, Feb 20, 2025 at 04:29:51PM +0100, Vlastimil Babka wrote:
> > On 2/20/25 16:15, Dave Hansen wrote:
> > > On 2/19/25 21:20, Byungchul Park wrote:
> > >> I'm posting the latest version so that anyone can try luf mechanism if
> > >> wanted by any chance.  However, I tagged RFC again because there are
> > >> still issues that should be resolved to merge to mainline:
> > > 
> > > I don't see anything fundamentally different here from the last 11
> > > versions. I think the entire approach is dangerous and basically makes
> > > things impossible to debug. It's not clear that some of the failure
> > > scenarios that I've brought up in the past have actually been fixed.
> > 
> > Yes, and it's still an invasive change to the buddy allocator.
> 
> Didn't want.. but admit.
> 
> > IIRC at Plumbers the opinion in the audience was that there might be ways to
> > improve the batching on unmap to reduce the flushes without such an invasive
> > and potentially dangerous change? Has that been investigated?
> 
> Sure.  I tried like, by holding those pages not freed until either no
> one accesses the interesting pages or memory pressure is high.  However,
> unfortunately it was super hard to fix performance degradation by the
> number of page reclaim increased due to the unfreed pages.
> 
> > Also "Rebase on akpm/mm.git mm-unstable(5a7056135b) as of Nov 22, 2024." is
> > very outdated at this point?
> 
> Sorry for that.  I will rebase and share.

This is the same patch set but rebased on v6.14-rc4.

	Byungchul
> 
> 	Byungchul
> > 
> > Thanks,
> > Vlastimil
> > 
> > > What I've said here still stands:
> > > 
> > >> https://lore.kernel.org/all/fab1dd64-c652-4160-93b4-7b483a8874da@intel.com/
> > > 
> > >> I think tglx would call all of this "tinkering".  The approach to this
> > >> series is to "fix" narrow, specific cases that reviewers point out, make
> > >> it compile, then send it out again, hoping someone will apply it.
> > >> 
> > >> So, for me, until the approach to this series changes: NAK, for x86.
> > >> Andrew, please don't take this series.  Or, if you do, please drop the
> > >> patch enabling it on x86.
> > > 
> > > I think I'd also like to stop being cc'd on this. If LUF is merged into
> > > mainline and proven to work on arm64 or riscv for a year, I'd be happy
> > > to take another look at enabling it on x86. I think that's just about
> > > the only thing that would make me reconsider.
> > > 


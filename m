Return-Path: <linux-kernel+bounces-533652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB0BA45D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF923A8CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5D82144DB;
	Wed, 26 Feb 2025 11:33:55 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6554A322A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569635; cv=none; b=r6qANpT36NnBbCuMYJl/TmcxNcRvrJn5scfoF/e83/eg2Kanp6hV3OWHldURau+Ia8aYgqH7hYu7o1J0ck4v7rypxg6Dy1pAwYBllEDmsCrmF4toOxYPL4PZWiLY6MzrmK3pdpNGIC3+8zHoqbFVWCmjxAlatwxbLiLx7RVi4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569635; c=relaxed/simple;
	bh=VEcaaA2VUlEIIxyi7R5bg4TfuTafRFf0fzKtDg9/U0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9XhhxKBdTi4ap4JilOcHjiDVWTqCatFsExBdBzd+xBl6+7RZvZno16rST4s9+79ymmWQs2xohzZ0ZQ9tB556DIrb8PeNsgC3FI+ehV9ngDKkbZD5ZrifIwGDN0gD28/WAGta4R1EHKD76VONRqrKQC/8uwaYUegMXMwm4nQlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-2f-67befc1cc8a2
Date: Wed, 26 Feb 2025 20:33:43 +0900
From: Byungchul Park <byungchul@sk.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, ying.huang@intel.com,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	willy@infradead.org, david@redhat.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	rjgolo@gmail.com
Subject: RFC v12 rebased on mm-unstable as of Feb 21, 2025
Message-ID: <20250226113342.GB1935@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsXC9ZZnoa7Mn33pBlN3KljMWb+GzeLzhn9s
	Fp9ePmC0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL2Y19jBbHp0xltPj9A6jj5KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8f7fVfZPM4sOMLusfWXnUfj1GtsHp83yQXwRXHZpKTmZJal
	FunbJXBlzFlnXrBapOJ+w37GBsZn/F2MnBwSAiYSH78sZYOxr725wQRiswioSsxatAgsziag
	LnHjxk9mEFtEQEXi0YajrF2MXBzMAu3MEhs6p4ElhAWsJJ6vXckIYvMKmEts3nkWrEhI4ASj
	xMz+RhaIhKDEyZlPwGxmAS2JG/9eAm3jALKlJZb/4wAJcwpYSpxrP8kOYosKKEsc2HacCWSO
	hMA2dol1k+eyQ1wqKXFwxQ2WCYwCs5CMnYVk7CyEsQsYmVcxCmXmleUmZuaY6GVU5mVW6CXn
	525iBEblsto/0TsYP10IPsQowMGoxMP74MzedCHWxLLiytxDjBIczEoivJyZe9KFeFMSK6tS
	i/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MFqaKt8Vmx1SbSexQGi+
	R82Hr3c5fyzKm77yiHXS+9eb5T133zB67/Nwvo2myob9DKLzNBw3VJfPkEljaz638Wz8ldIN
	n94vnT5H6c7XN8aTp/Qr7z168bqVs9BTQ/EPWgsO/lqSNflJg8OzKCG1BrsoW8etKp+bWndz
	for9J9wqqSzE1vV2b5oSS3FGoqEWc1FxIgCoLs8uxgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXC5WfdrCvzZ1+6weWrghZz1q9hs/i84R+b
	xaeXDxgtvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBazG/sYLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj/f7rrJ5LH7xgcnjzIIj7B5bf9l5NE69xubxeZNc
	AH8Ul01Kak5mWWqRvl0CV8acdeYFq0Uq7jfsZ2xgfMbfxcjJISFgInHtzQ0mEJtFQFVi1qJF
	bCA2m4C6xI0bP5lBbBEBFYlHG46ydjFycTALtDNLbOicBpYQFrCSeL52JSOIzStgLrF551mw
	IiGBE4wSM/sbWSASghInZz4Bs5kFtCRu/HsJtI0DyJaWWP6PAyTMKWApca79JDuILSqgLHFg
	23GmCYy8s5B0z0LSPQuhewEj8ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAGFtW+2fiDsYv
	l90PMQpwMCrx8D44szddiDWxrLgy9xCjBAezkggvZ+aedCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGaRfVS+QnRK4N2uoTpKzEwVOv7Ryzl1GeUSNb
	yMhQzq1Q3vGr4L/jyyT/BXnNi5Pz3uBZe4e/TPn97wf7EmQNHvQZMJr8KT+woFVjZ/VaBhuz
	nOCbrt4MjI/rudV49rjP6nzusLjhayAz79Hk/BusmutmxK/cW7JXdk3+KZ0wHvX1yzqfMiqx
	FGckGmoxFxUnAgCk/JsKrQIAAA==
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

This is the same patch set but rebased on akpm/mm.git
mm-unstable(f7ed46277aa) as of Feb 21, 2025.

	Byungchul

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


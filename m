Return-Path: <linux-kernel+bounces-576226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F06A70C86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6427D16698C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26577267B9D;
	Tue, 25 Mar 2025 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4NjjxMQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2D190664
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940353; cv=none; b=IrYvQ8gS9muH4xmP07POypT7jKBc3eiptNSbSGZzQWZvJgCBARBjWfv8h/Fz3GVjFoYYrOoP+EeSzuIbfKsNaTbXfmnDP0+24dk7lEa5mour/jho0CFFLFN4wur3kkm2VnMLlQg7vEvpIc7rNTfcjdKKirByO8NzXUA2/KQKXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940353; c=relaxed/simple;
	bh=H/G0uzHtJbq8O5EuUJeV+sv7t7xBlJqB/VXFBoAMC4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbKMuqTWuU0UN6Ymy/QcDrS6doNPrxrLP4cItZ4bAb8xorMIIHcI7Ik7AUX7xSrPEphDd0cCAaIXoVKV6FeerH0PtjvL2cFz72WTLp6JzHcgJLIJwuJdXCKaRXgr2s4V5Lo0Ujw4uT58vEooqb21o3JsFZlzV4M+bqypfDsjiCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4NjjxMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6D2C4CEE4;
	Tue, 25 Mar 2025 22:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742940353;
	bh=H/G0uzHtJbq8O5EuUJeV+sv7t7xBlJqB/VXFBoAMC4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4NjjxMQYlIKmEn1SMB18Y4RyVeA/RS4KMYOPCvZHSnXUIrICOKhLf2NzWJJDguBP
	 u/L8xLbUEPaAJHgmNP2TfDQ+UmdU7HQjr7Tx5r9oXS9sXfmoeVbWeTyR68mg4xjL7k
	 M3HUruK9/YylWNkiVxvHQypiBSXpSgSTETbv/QN9Ozv4P2o6dbYGKY72bFTPPYxLUn
	 /N8fnGSVVEhTT7UeGKqjAirdkSIwz3Unrfx/lZEYYeSX0HAXXfrPhN+KLglOEftflx
	 AoeATdS/cOy+Egx77G466fzxYuIDYOINa2z11s8TUfaBYcFPIBLpo4DpkDuMCZ8ymr
	 0D9JJKQ190jrg==
Date: Tue, 25 Mar 2025 23:05:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Nick Terrell <terrelln@meta.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Ard Biesheuvel <ardb@kernel.org>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"brgerst@gmail.com" <brgerst@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compile problems w/gcc 9.4.0 in linux-next
Message-ID: <Z-MovH_wFIW-xFBE@gmail.com>
References: <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
 <SN6PR02MB415765C109AF9820DDC3AF0FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575C4BA0C467B1C95EEB21D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z90XZqJVwuWkarnX@gmail.com>
 <SN6PR02MB4157E2AC0708EB2074302E6FD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <323A7651-9BD8-4C8B-8784-8C9DAEF5FC88@meta.com>
 <Z-KDA-yFUuNM6PSx@gmail.com>
 <9B7AFB33-E930-44F4-B5AE-1414B3E9A56A@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9B7AFB33-E930-44F4-B5AE-1414B3E9A56A@meta.com>


* Nick Terrell <terrelln@meta.com> wrote:

> 
> 
> > On Mar 25, 2025, at 6:18 AM, Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > > 
> > 
> > * Nick Terrell <terrelln@meta.com> wrote:
> > 
> >> 
> >> 
> >>> On Mar 21, 2025, at 8:16 AM, Michael Kelley <mhklinux@outlook.com> wrote:
> >>> 
> >>>> 
> >>> From: Ingo Molnar <mingo@kernel.org> Sent: Friday, March 21, 2025 12:38 AM
> >>>> 
> >>>> * Michael Kelley <mhklinux@outlook.com> wrote:
> >>>> 
> >>>>>> What are your thoughts as maintainers of lib/zstd?
> >>>>> 
> >>>>> FYI, the same segfault occurs with gcc 10.5. The problem is fixed
> >>>>> in gcc 11.4.
> >>>> 
> >>>> So the patch below would work this around on GCC9 and GCC10?
> >>> 
> >>> I've confirmed that the patch gives a clean compile with gcc 9.4.
> >>> 
> >>> Note that I confirmed yesterday that the gcc problem is fixed with
> >>> 11.4. I don't know about earlier gcc 11 minor versions. Lemme see
> >>> if I can get the original gcc 11 release and try that to confirm that
> >>> your patch has the right version cutoff.
> >> 
> >> Thanks for the report & proposed fix!
> >> 
> >> If you can test gcc-11.0, that would be great, otherwise we could just
> >> cut off at (__GNUC__ >= 12 || (__GNUC__ == 11 && __GNUC_MINOR__ >= 4))
> >> 
> >> I am preparing the zstd-v1.5.7 update, and I will pull a patch that 
> >> fixes this into my tree. If someone wants to submit a patch I'll pull 
> >> that, otherwise I can submit one later today.
> > 
> > The proper cutoff would be GCC 11.1, not 11.4, as per the testing of 
> > Michael Kelley, right?
> 
> Sorry, I didn't quite realize that the [tip: x86/core] was a commit. I'll drop
> my patch, and just make sure that the fix is preserved in the zstd-v1.5.7
> upgrade.

Yeah, the segfault triggered due to changes in the x86 tree, so the fix 
(workaround) is now upstream, but I think the cutoff is overly 
conservative:

  1400c87e6cac ("zstd: Increase DYNAMIC_BMI2 GCC version cutoff from 4.8 to 11.0 to work around compiler segfault")

So it might be a good idea to follow it up with your improved cutoff 
patch, as a delta patch on top? That doesn't have any urgency that I 
can see, so it can go through your tree, or any other path you'd 
prefer!

Thanks,

	Ingo


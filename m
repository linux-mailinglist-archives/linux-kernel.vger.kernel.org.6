Return-Path: <linux-kernel+bounces-552755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C22A57DB7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05EA3AC089
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70441E5210;
	Sat,  8 Mar 2025 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qYwuVrGd"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C68148857
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741461333; cv=none; b=KE5qrz1B110hfkhZWMusn7fuAzoOu8IEBm8UsXzuUgN5oyTvGuT9yur5GtONRkJhQNZiJtLCykm1i61AuKN9eYDNqStopvSEFGxeDcCcorzSpq1xzyWI6thQR2YlRz1eNE3eDmdt1sE1Q6dDaoaZ9SFSgN/pzDXwA00Y03buCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741461333; c=relaxed/simple;
	bh=ThRfEjaMXH8Uw3+BNDOdBtD7reexvKpMiCAheJxQxXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkjz3oH2F47gxk7joYSjy7hQXcnpMdCGv84k6Dyz0CbVZYs5hi3NI/6spbYw3UH7I341c7Q+Lrd7SNM4LguT0DsmiblQcJqzOS8v3txU9UcGFPNR4LBh6N66AAQCmEddxrVmkizdl1RT0rpjDE1PNqq9N/gdXURjoAUU0WJAUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=qYwuVrGd; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8003:ca73:434c:8ca7:921e:6209] ([IPv6:2601:646:8003:ca73:434c:8ca7:921e:6209])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 528JF5ex911877
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 8 Mar 2025 11:15:05 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 528JF5ex911877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741461306;
	bh=CjZwy+PBWyWlbkhdLvXgvgMevu9DTUlZfmF6j4/oq4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qYwuVrGdsIT+fM9eQFNF19EdJ5e9bExWTJpSQtrkv9XvnbkyKofIyM6aiBISNyicI
	 VkUfAqa+nGv27lcNBt5eR/JDk3xudgMYVpGnUqeQ+n/feXOEL5BgaCWogGS/B2t+ps
	 5Czj2U3dQxSKjdEYYEY+5vsXokOUmajkhpY+Tkb0j2Y1ESOiXIPuePRP2zjHE+NZ3u
	 TDDbDrgm6On8suaap7OMo4CmRsl1SSjLYB8/ziP/yUKbndNGMa8h0YUQfKZKoPtCFP
	 W+5Hr8P2a01wKfeHINavIBbpeFPiaTcSk89TGlIlDcfc/ouiEauoJRU881jaGfMDfP
	 ieQ/lz6H9KOPA==
Message-ID: <22d90b7f-fdc9-40e3-8afb-c7bf313f60c2@zytor.com>
Date: Sat, 8 Mar 2025 11:15:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Linus Torvalds <torvalds@linuxfoundation.org>,
        Uros Bizjak <ubizjak@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 09:04, Linus Torvalds wrote:
> 
> That said, I do want to bring up another issue: maybe it's time to
> just retire the LOCK_PREFIX thing entirely?
> 
> It harkens back to Ye Olde Days when UP was the norm, and we didn't
> want to pay the cost of lock prefixes when the kernel was built for
> SMP but was run on an UP machine.
> 
> And honestly, none of that makes sense any more. You can't buy a UP
> machine any more, and the only UP case would be some silly minimal
> virtual environment, and if people really care about that minimal
> case, they should just compile the kernel without SMP support.
> Becxause UP has gone from being the default to being irrelevant. At
> least for x86-64.
> 

I think the key there is that "they should just compile the kernel 
without SMP support" (which may very well make sense for some oddball 
embedded uses) *does* still mean that remaining cases of locks 
can/should be elided so demacroizing it is still not an option.

But yes... would get rid of a lot of crap machinery which is basically 
dead code, and that would be a Very Good Thing[TM].

	-hpa



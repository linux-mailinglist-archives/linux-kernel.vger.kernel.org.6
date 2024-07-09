Return-Path: <linux-kernel+bounces-245982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B439C92BC48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B7BB27CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4918F2C7;
	Tue,  9 Jul 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bJHewCJn"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB2188CC8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533533; cv=none; b=e7oh/oj8JyZHrzR+TU/qvC3OfF2Xnznd5h7U/W3+aY98NRE85wFPeRz2QWt0515UVjNK+x9vSEAMxLbFC57dfD5bDDVnnDsXMe+Q+UIEH9Cl5K/yqe/hki191L463IB2QH/cA9qsJpYOWNrkF1jSfi1DmiegbRBMm3Z9zKwKFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533533; c=relaxed/simple;
	bh=4GwK0wBUo08PrDLPTcwJSHbI6ytKzz57oxvuxLcXKy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFDLJ+ZZm4PDVA8DnEDlGo34ixb7r6sdgWVIHK+N/C4G8IH7p5uavdH/RBJyb9cTlJOKvTxHfhHUjxtxe0jHErj6t8iAdVliS3ngnUzZ+vjEOSdxg1EV6XgP0K5M94d6Z3/tgUFQG5eht3RthceTCU2SlZ3fJCB2CyVgmaNEhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bJHewCJn; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 469Dw8Li3514289
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 9 Jul 2024 06:58:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 469Dw8Li3514289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720533492;
	bh=uY8yj978GlXI2G3OqNP1RrGw/fehtNWKPpdBQghfhs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bJHewCJnM1SWeSO+LiFzmaVfZsEJ8ctQavejQK40NDpGKsOzOAikcnTWyZCOVbyXp
	 SHUUnw52f0Q1ZzBZPlV3TFSaDQqEyx5hPilhS3m12V+NogShJDyUyWN0GeFfdCPPdi
	 N7A0+cXSU72VzqwZ0woeVcOqSKxL+XNvaCg3LpvwnSudoQiRDhSDBuulevMoev+Wp6
	 yfzjq96SxOC6HT/SbHVA8nDtWW4LIrBvu+W37X18146yStB2IidJ/HOjEZzZcYmnjw
	 PUxsGTy7J85OoBnpZP9RWrCxoPrO4isja3J9HW0kkFCg3Rlp+aQlkpf66rGlc8bVG/
	 zT9CGMOlx71uQ==
Message-ID: <246c77ec-1911-4f43-9ce6-7e087b3a4562@zytor.com>
Date: Tue, 9 Jul 2024 06:58:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
To: Borislav Petkov <bp@alien8.de>, Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        nik.borisov@suse.com, houwenlong.hwl@antgroup.com,
        Juergen Gross <jgross@suse.com>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>
 <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base>
 <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
 <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>
 <20240703161705.GAZoV5gQIgtORQeHdQ@fat_crate.local>
 <DE8FD8AA-35C6-4E51-B1E0-CE9586892CB3@zytor.com>
 <20240705094418.GAZofAcvelmnRzbkoG@fat_crate.local>
 <cda57e5f-acf5-414c-8faa-d2496c02ced9@citrix.com>
 <20240705134517.GAZof47bcaL5i2b4ju@fat_crate.local>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240705134517.GAZof47bcaL5i2b4ju@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/5/2024 6:45 AM, Borislav Petkov wrote:
> On Fri, Jul 05, 2024 at 11:30:16AM +0100, Andrew Cooper wrote:
>> You cite perf.  Look at the disassembly of the two approaches...
>>
>> cpu_feature_enabled() might give you warm fuzzy feelings that you've
>> eekd out every ounce of performance, but it's an absolute disaster at a
>> code generation level by forcing the compiler to lay out both side and
>> preventing any kind of CSE.  As I've reported before, count the number
>> of RDPKRU instructions in trivial-looking xsave handling functions for a
>> glimpse of the practical consequences.
> 
> Yes, I do cite perf because what you have above is not saying: "yes, this is
> a fast path and doing an alternative is warranted." If that is the case, sure,
> by all means. If not, make the C readable and ignore code generation. Who
> cares.
> 
>> Anyway, none of this is the complicated aspect.  The complicated issue
>> is the paravirt wrmsr().
>>
>> TGLX's complaint is that everyone turns on CONFIG_PARAVIRT, and the
>> paravirt hook for wmsr() is a code generation disaster WRT parameter
>> handling.  I agree that it's not great, although it's got nothing on the
>> damage done by cpu_feature_enabled().
>>
>>
>> But, seeing as I've got everyone's attention, I'll repeat my proposal
>> for fixing this nicely, in the hope of any feedback on the 3rd posting...
>>
>> The underlying problem is that parameter setup for the paravirt wrmsr()
>> follows a C calling convention, so the index/data are manifested into
>> %rdi/%rsi.  Then, the out-line "native" hook shuffles the index/data
>> back into %ecx/%edx/%eax, and this cost is borne in all kernels.
> 
> A handful of reg ops per a WRMSRNS? Meh, same argument as above. But...
> 
>> Instead, the better way would be to have a hook with a non-standard
>> calling convention which happens to match the WRMSR instruction.
>>
>> That way, the native, and simple paravirt paths inline to a single
>> instruction with no extraneous parameter shuffling, and the shuffling
>> cost is borne by PARAVIRT_XXL only, where a reg/reg move is nothing
>> compared to the hypercall involved.
>>
>> The only complication is the extable #GP hook, but that's fine to place
>> at the paravirt site as long as the extable handler confirms the #GP
>> came from a WRMSR{NS,} and not a branch.
> 
> ... yes, I'd gladly review patches which address that and make the whole deal
> cleaner. I'm still sceptical those handful of regs shuffling ops would matter
> in any benchmark but sure, if it can be done in a cleaner way, why not...
> 
> Unless I'm missing some use case where that overhead really matters. Then by
> all means...
> 

It looks that it no longer makes sense to include this patch in this
patchset; it is not something that can be done as a small cleanup.

Any objection?

Thanks!
     Xin


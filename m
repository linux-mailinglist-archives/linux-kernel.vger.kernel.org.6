Return-Path: <linux-kernel+bounces-238783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C304E924FE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2883B21917
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C40182C3;
	Wed,  3 Jul 2024 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="h7GXSRM7"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2D18042
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978184; cv=none; b=Aj1CXN21yQgCK9wP1dtU6qXLb1ef4ddncFM3E8mXvclLXe3Kw48gKowaLm+PYUkAV/ITtbg8KaU5cyjbhFBA4jgdStLbHVR6mjjVHqYJVJB104jvyiYepQV3lxvyiKo0JdaEPnwSAy2MeNIIxnuCpOPmrWmS2lNnTDzmlw6g1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978184; c=relaxed/simple;
	bh=a6TKJdWYiAp3I0uWNzwAOR9657oxxZMqD+Cd6q6GXPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1gNr901AuluoFUBGRlo+Jczxh+nCHgcgejqQ9r5GdOGVomhTvWLOlbRID9XjtFjfE10DFa1V5ZyfEreqhzanwOwpX4KrHWQ19WxFX4LOLtxq6uuqtHkYgvcVjBCmUo6tw+Ixt1py9Qicf0NzQeYlczMmaF4LlcDB367/olULwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=h7GXSRM7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4633gLTk146462
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 2 Jul 2024 20:42:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4633gLTk146462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719978143;
	bh=Ex/fYNECMashiRiup/1meZ1pO0xIwMpSCpz7AOoym0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h7GXSRM7ujiYemNFWgE6zgJRZwNnQg1woodnmE/0KZ9b1gWOJWX+rjPiR45mz0rkC
	 4fR004Q/bHruhXFwabXZfC0wfWamqlaYZE8LrY7SFvhFcIDoCUVT4/0yKufcXdWqmR
	 zujocGagCy3vxTxkvRfIl0L7w5snHxDgkRujP3x3sigG1i9bNpWIXSh7BEceNqcENk
	 CGS/Pu9IBDmaHqQatdA2/p5PbdXDI86WKsy8jp3kD9CpSAmTMiiZqlWAcalJ3kIibn
	 DyI/gtiCGF1zCbQlCZG1jTqq9s+SqmILQLpXALHtP4aWDxQ1usYdLTVKBIoe5ZdN5n
	 0YP9R4NkUSMkQ==
Message-ID: <52d155d1-61bb-4829-b2ec-b60cdd1bf2c5@zytor.com>
Date: Tue, 2 Jul 2024 20:42:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/fred: Always install system interrupt handler
 into IDT
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Xin Li
 <xin3.li@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
 <2f632ef59c8c9cc27c3702bc2d286496ed298d65.1718972598.git.houwenlong.hwl@antgroup.com>
 <dca1635b-1e08-4dbb-9dbb-335cbdcf9b9d@zytor.com>
 <20240628093656.GA103025@k08j02272.eu95sqa>
 <c0ec7712-c538-4cd1-ada2-d0120c662ce8@zytor.com>
 <c2548e16-7251-4d1c-87a2-f1c09be83e3e@zytor.com>
 <20240703024438.GA76553@k08j02272.eu95sqa>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240703024438.GA76553@k08j02272.eu95sqa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/2024 7:44 PM, Hou Wenlong wrote:
> On Wed, Jul 03, 2024 at 01:16:29AM +0800, Xin Li wrote:
>> On 6/28/2024 8:18 AM, Xin Li wrote:
>>> On 6/28/2024 2:36 AM, Hou Wenlong wrote:
>>>> Hi Xin,
>>>>
>>>> It seems preferable to parse the FRED command line and disable FRED
>>>> early instead of using this method. As mentioned in my cover letter, I
>>>> initially attempted to fix the problem this way (by parsing the command
>>>> line in cpu_parse_early_param()). Should I send a new patch for it, or
>>>> will you be covering it in your work to enable FRED early?
>>>>
>>>
>>> I have done it in my patches that enables FRED early, but if you want,
>>> you can post it, because you're a key contributor in this work.
>>>
>>
>> Please let me know if you want to do it.
>>
> Hi Xin,
> 
> Sorry for forgetting to reply. I think it would be better for the fix to
> be covered in your work.

NP, thanks!



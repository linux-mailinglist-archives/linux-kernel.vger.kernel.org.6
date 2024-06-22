Return-Path: <linux-kernel+bounces-225858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9B91362B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF4CB23D06
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC97442F;
	Sat, 22 Jun 2024 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZyeIAfJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D35EE80;
	Sat, 22 Jun 2024 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093223; cv=none; b=rJWOkBB7kofJyNlsgICI4HDHMOlQx5Mi4MICSuk/wB0KwHdjTtY9ULP8h8sdUc9yeHESVqVW5RbSoaFkXmjqjvhmKL1FIyqwie+NPfxyNzSkO3ULCPXPLYdkaEv71cR5ssfQQ5DBQaitfWQ9A08HduIUySXacmtQIeAGGQG8dwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093223; c=relaxed/simple;
	bh=31I/XL260ic/76jnIjXbuW84xaRzL5GwSm7lPDALlcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTwtTPUao3zdPtxL6LaOM8P62zUzOqUAHImkiX+T5wgViIvaZGCo5MXY9uRBw1e5Z0e0j1xo28KfplsTkK/zCd1ok89PKpSA7+Yc+ZRDIhvVafvf8JhXc0rZcu+Lf6gTzDhafFFTigtFC75/AaYuZF+1tZHBdxxI2dNYFouuRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NZyeIAfJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=s6zUmfJfOm69la/U36J/TC8NRjaqkn0V+dXnPUEy87k=; b=NZyeIAfJcUuHIz/qAgRplGItFq
	M3iSxBvLKRuu/ogNKEAbiShRwHhtnZS/TXN4gZCdzGuDGEPZoRZCFgHZEAS4ehcukXqaWaa/spSEX
	b4A/E83LJGrSeBCsYcpqgjAI4n7y6Qil8j4EeuSTm1zRegy9851gSnr/NCcEl8I75WVGGGU3+Rru5
	+g30PGSRk3o1qEgvqBJjOjQValo7Br0KddO15/VOTye0hgskSbhntXpAkNBt7BI4xFCpoYvL6K8OH
	E99qGwRKPTMiakMwYyjABPIIg5WrvGdNoyePtrSaDli4pZ9KOMcIjBVx9hV5f4toS5xUdIYMMWcil
	ivwqvPpw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sL8fy-0000000CrKS-3owu;
	Sat, 22 Jun 2024 21:53:39 +0000
Message-ID: <e5c58296-dc05-4df2-966b-2e5b1cdf0e4e@infradead.org>
Date: Sat, 22 Jun 2024 14:53:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
 <87ikyvccwc.fsf@meer.lwn.net>
 <2acd884f-2f04-4d39-b559-aac99f9ae35e@gmail.com>
 <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
 <e6bf0675-f542-482d-a861-000772b1d10e@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e6bf0675-f542-482d-a861-000772b1d10e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/22/24 12:43 PM, Carlos Bilbao wrote:
> Hello folks,
> 
> On 6/12/24 17:17, Randy Dunlap wrote:
> 
>>
>> On 6/1/24 8:03 AM, Carlos Bilbao wrote:
>>> Extend the Index of Further Kernel Documentation by adding entries for the
>>> Rust for Linux website, the Linux Foundation's YouTube channel, and notes
>>> on the second edition of Billimoria's kernel programming book. Also,
>>> perform some refactoring: format the text to 75 characters per line and
>>> sort per-section content in chronological order of publication.
>>>
>>> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
>>> ---
>>>  Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
>>>  1 file changed, 44 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/Documentation/process/kernel-docs.rst
>>> b/Documentation/process/kernel-docs.rst
>> The 2 lines above should be on one line, but fixing that doesn't fix everything.
>> 'patch' still says that it's a malformed patch.
>>
>> Carlos, please check Documentation/process/email-clients.rst section on
>> Thunderbird, especially for line length and line wrap.
>>
>> I'm still looking...
> 
> 
> I followed the instructions for Thunderbird but atm I'm tired of trying to
> make it work. I'll just go back to using 'git send-email' for patches. I'm
> resending this patch like that.
> 

Good plan. :)

> 
>>
>>> index 8660493b91d0..6f3e290abd22 100644
>>> --- a/Documentation/process/kernel-docs.rst
>>> +++ b/Documentation/process/kernel-docs.rst
>>> @@ -3,27 +3,27 @@
>>>  Index of Further Kernel Documentation
>>>  =====================================
> 
> Thanks,
> Carlos

-- 
~Randy


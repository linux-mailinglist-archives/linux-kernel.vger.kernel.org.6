Return-Path: <linux-kernel+bounces-440175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CEF9EB9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BC7166CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157912046AE;
	Tue, 10 Dec 2024 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="TXiCOse+"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533D23ED41
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857097; cv=none; b=oQHTivj6selkoOe5gZDk2hIFvEZHbLv2nBAOFmG9aX1RSCIdgBn0Sta6esmLzWL+Jtw+16vzrxgu4B+zJfX1qf+wfMUQYeOXyU27RI6D9CNi4StScqBSOjl3xLd1j/B5j5z4dntzxP0y5TgSGJMwtgVY+jDMx0BR/9bv+Bc4yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857097; c=relaxed/simple;
	bh=7JN1ip0ZnnglVsxW2IDoPTTy2fJtNriHVLdpJGUPuWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYcpPTpBx+Mx4W5HYgE/dvChorqT9EI0IUmRhbaGGRW7di59CNJbynL6LiJGTns78ghhcGQovAG0pYnTZmOu5LDnjubvR+cgep1GaQWGMOMdpqO3SEXFmrv3qkOCVggiXxqxrOM3YhELwb2siSRZ854tDq2qqQrvZGVhhY6TgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=TXiCOse+; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BCD38100094;
	Tue, 10 Dec 2024 18:57:00 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2C4AA13C2B1;
	Tue, 10 Dec 2024 10:57:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2C4AA13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733857020;
	bh=7JN1ip0ZnnglVsxW2IDoPTTy2fJtNriHVLdpJGUPuWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TXiCOse+IBAqhG3eXlnw4225a5afvpt4VNn7HqjcOa4P3wUfpHGaNKzpqDU7XjtKv
	 FyPeImaAYzkOoJ3CVhFO9KiESM0APJntZE4n+/BwBXn9w3ZCSbdFxpD2J+u0xjjrnN
	 jgUfxzntU0XyAoh4HO2EmJOObW9Gu2uDPqcLYkJ4=
Message-ID: <00d8ba74-7661-e6ac-8a67-7af1df0f2f0a@candelatech.com>
Date: Tue, 10 Dec 2024 10:56:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] mm/alloc_tag: Add kasan_alloc_module_shadow when
 CONFIS_KASAN_VMALLOC disabled
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20241210041515.765569-1-hao.ge@linux.dev>
 <20241210065304.781620-1-hao.ge@linux.dev>
 <CAJuCfpGVTyKJ5yMQUqvNXRfBnBYj+dhUEqq0YAddtrqcWP27yw@mail.gmail.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CAJuCfpGVTyKJ5yMQUqvNXRfBnBYj+dhUEqq0YAddtrqcWP27yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1733857091-9qi64w4nqN4w
X-MDID-O:
 us5;ut7;1733857091;9qi64w4nqN4w;<greearb@candelatech.com>;536d06e365f87d56c7a5ab8c2fd573cd
X-PPE-TRUSTED: V=1;DIR=OUT;

On 12/10/24 09:55, Suren Baghdasaryan wrote:
> On Mon, Dec 9, 2024 at 10:53 PM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> When CONFIG_KASAN is enabled but CONFIG_KASAN_VMALLOC
>> is not enabled, we may encounter a panic during system boot.
>>
>> Because we haven't allocated pages and created mappings
>> for the shadow memory corresponding to module_tags region,
>> similar to how it is done for execmem_vmalloc.
>>
>> The difference is that our module_tags are allocated on demand,
>> so similarly,we also need to allocate shadow memory regions on demand.
>> However, we still need to adhere to the MODULE_ALIGN principle.

Hello,

I applied this patch:

https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.com/raw

as well as the v2 patch in this email thread, on top of today's Linus
kernel (plus local patches that should be un-related to this particular
issue) and now my system boots when my current mix of kernel debugging is enabled.

Thanks for the fix!

--Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com




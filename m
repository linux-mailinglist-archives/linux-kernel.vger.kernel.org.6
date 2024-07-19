Return-Path: <linux-kernel+bounces-257566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C89937BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E8B21224
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447F14600C;
	Fri, 19 Jul 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OJDT1Ee0"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226BE2746B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412349; cv=none; b=cIp448ZxsVkUcaHkaghnWIfzGhcURVacMIWDmMDseDix4i92Kj5SE3FNRHfT8uAGuBpcmCYR5E9IKBlOivOn0j6JiimCEKgVv3s/SC4InigfNdA/QeBL1/qUP90Isc2/nKdSc/Ke7B+E5GLGcBS+emBCaTm86D6KQHhrmspWKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412349; c=relaxed/simple;
	bh=b3JynVypbl/6EaPFYMOpovKgcT7kEaRHPdWGESwVYCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaZkM3eYHGwLZfvsVDtRzVaix+l+CrEzelkMy1donyK5tJ6DUpFMRkwS+8pld2/8vFBPxqFdGeZK0VPja8k1hL9obnpTBG9R1w8N7iZbiBvNasw8bZYUrPAzvVC4jSDqzI526SW0LXIWn0UvJ84c1kQSZyIfHMFguINNnULwFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OJDT1Ee0; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1721412340;
	bh=b3JynVypbl/6EaPFYMOpovKgcT7kEaRHPdWGESwVYCc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OJDT1Ee0lTtgMV17fxxm30bXTxhbTzVnPg17/r6Wz5AC4mb0EzRvNKugQpH1oOQXZ
	 snmHly/pNhGzESCBUGD4LHD1PWRvb4jWktq1P/zPoIqxPZrDIMytADrmQ2GoAzYoGZ
	 yHIZCmoINwsPWYZvthrBui1OUE3u3mGtyXLlGxOsTgIUUWnD5QTUcxRvGhLI7u743D
	 Cu6JKe/f0yCnmdSv6152/puIw05b7GCKNEu3V42q8+RMvDmwECGznA/lxKaOMd0HoW
	 FcZ93weP9AqlZh3h45af1bXc1BUTiSce8xf9d/cJjssDDlqksNPqIGOO5F6ZsLx4f7
	 oTItLyVCSKOYQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WQczS0KzRz1DDL;
	Fri, 19 Jul 2024 14:05:40 -0400 (EDT)
Message-ID: <76333f65-c2c0-47bc-94f7-8f18e60def30@efficios.com>
Date: Fri, 19 Jul 2024 14:05:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ring-buffer: Updates for 6.11
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Thorsten Blum <thorsten.blum@toblux.com>
References: <20240716155118.152dea35@rorschach.local.home>
 <a71100aa-ffe4-477e-814a-1564e00cb067@efficios.com>
 <20240719103218.6c1eedfc@rorschach.local.home>
 <7e29c303-c91f-4229-9b9d-b60d8a60c38b@efficios.com>
 <20240719121940.5ce9a90a@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240719121940.5ce9a90a@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-19 12:19, Steven Rostedt wrote:
> On Fri, 19 Jul 2024 10:59:37 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>> So I went to update this, and realized there's no place that actually
>>> mentions anything about this being used across reboots (besides in the
>>> change logs). The only documentation is in kernel-parameters.txt:
>>>
>>>                           If memory has been reserved (see memmap for x86), the instance
>>>                           can use that memory:
>>>                           
>>>                                   memmap=12M$0x284500000 trace_instance=boot_map@0x284500000:12M
>>>
>>>                           The above will create a "boot_map" instance that uses the physical
>>>                           memory at 0x284500000 that is 12Megs. The per CPU buffers of that
>>>                           instance will be split up accordingly.
>>>
>>> I do plan on adding more documentation on the use cases of this, but I
>>> was planning on doing that in the next merge window when the
>>> reserve_mem kernel parameter can be used. Right now, we only document
>>> what it does, and not what it is used for.
>>>
>>> Do you still have an issue with that part missing? No where does it
>>> mention that this is used across boots. There is a file created in the
>>> boot mapped instance directory that hints to the usage
>>> (last_boot_info), but still there's no assumptions made.
>>>
>>> In other words, why document a restriction on something that hasn't
>>> been documented?
>>
>> AFAIU the intended use of this feature is to convey trace buffer
>> data from one kernel to the next across a reboot, which makes it
>> a whole different/new kind of ABI.
> 
> That may be my intention, but there's nothing here to imply that. In
> fact, after I read the document, it looks to me as a way to simply
> designate a location of address space for the ring buffer. This could
> be because of some special hardware. Nothing here says "exists on
> reboot". Thinking that this implies that the ring buffer will last
> across boots is not going to make it a new API. In fact, in my test
> cases, it fails (due to KASLR) approximately once every 5 boots. So
> it's not something you can even rely on.

Then the commit message is misrepresenting the usefulness of the
feature. What is the use-case for specifying the location of the
ring buffer address space in physical memory beyond re-accessing
it after reboot ? What is that special hardware you are referring
to ?

> 
>>
>> Having no documentation will not stop anyone from using this new
>> feature and make assumptions about ABI guarantees. I am concerned
>> that this ABI ends up being defined by accident/misuses rather than
>> by design if it is merged without documentation.
> 
> This is not an ABI. Remember, Linus's mandate is to "not break user
> space". There's no use space involved here.

I should have used filesystem terminology here rather than ABI. This
ring buffer memory area is similar to a filesystem on-disk format,
because it needs to be agreed upon by two distinct kernel instances.

I'm pretty sure there are inherent expectations about not breaking
file systems.

IMHO it makes it even more important to clearly document the guarantees
given about it or lack thereof.

> 
>>
>> Very often when I find myself documenting a feature, I look back at
>> the user-facing result and modify the ABI where it does not make
>> sense. Merging this ABI without documentation prevents that.
> 
> Again, this isn't a "user facing feature", where I consider "user"
> being user space.

You are right, it's not about userspace. It is about the in-memory
equivalent of an on-disk format, and it should be documented.

> 
>>
>> So if you ask my honest opinion there, I would say that merging this
>> ABI without documentation feels rushed.
> 
> It's not an ABI (Application Binary Interface). What's the application?
> What's the binary interface?

No argument there, it's not about userspace applications. It's the
in-memory equivalent of an "on-disk format".

> It's a kernel command line telling the
> kernel to place the ring buffer at some specific address space. Nothing
> more.

The whole justification for adding this feature *is* keeping a ring
buffer around across kernel reboots. If it's just a way to let the
kernel specify where to place the ring buffer in memory, then what
is the use-case justifying its integration ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com



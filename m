Return-Path: <linux-kernel+bounces-561904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54423A6185A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9819517DB4D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F15F204845;
	Fri, 14 Mar 2025 17:42:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26D078F2E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974149; cv=none; b=J/pTdRgTsFVA4R0WLUcvYzIHUEfx5RTi2c3UhkBepEyV9cWTkSRQ8uLM5dplHBIaeRr/gkg89lvtKRRha07ucSz84BTpG+W+IjrC5mE7QtpIhQPsjOt5qeXTh6oJB8JtvhKwTFYYyR7zbmthaFBHVGdYyiNLD7+rli3WbFV8EdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974149; c=relaxed/simple;
	bh=SYPAmNIQd2QdVNM9Lk8EyrEN1jmV3AxjZUWF8H+caUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owgm5auE+4jDUSMLL1QJyRizwROJMh/lI36Zrhc5Jps76gy0Do/VZ+5dPx+uBKgfEvIo0Zo0ACMsd/pNkPjYMUmbcgsCX429rvvrD7wPLsf38SF9706rgeS44lUF6SWovIaA3RY+kqsIBy39Jg6gtH6aDfnWSLNXjSEmvCLHzYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7D3B1596;
	Fri, 14 Mar 2025 10:42:36 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B36C3F673;
	Fri, 14 Mar 2025 10:42:23 -0700 (PDT)
Message-ID: <012dfeb5-cb5f-4852-9c70-5a49ca61a754@arm.com>
Date: Fri, 14 Mar 2025 17:42:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 46/49] x86,fs/resctrl: Remove duplicated trace header
 files
To: Fenghua Yu <fenghuay@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-47-james.morse@arm.com>
 <bea2a7d6-9f94-4e35-a85e-932bac0ec98a@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <bea2a7d6-9f94-4e35-a85e-932bac0ec98a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fenghua,

On 07/03/2025 02:32, Fenghua Yu wrote:
> On 2/28/25 11:59, James Morse wrote:
>> The copy-pasting python script harmlessly creates some empty trace
>> point header files. Remove them.

>> diff --git a/fs/resctrl/pseudo_lock_trace.h b/fs/resctrl/pseudo_lock_trace.h
>> deleted file mode 100644
>> index 7a6a1983953a..000000000000
>> --- a/fs/resctrl/pseudo_lock_trace.h
>> +++ /dev/null
>> @@ -1,17 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> -#undef TRACE_SYSTEM
>> -#define TRACE_SYSTEM resctrl
>> -
>> -#if !defined(_X86_RESCTRL_PSEUDO_LOCK_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
>> -#define _X86_RESCTRL_PSEUDO_LOCK_TRACE_H
>> -
>> -#include <linux/tracepoint.h>
>> -
>> -#endif /* _X86_RESCTRL_PSEUDO_LOCK_TRACE_H */
>> -
>> -#undef TRACE_INCLUDE_PATH
>> -#define TRACE_INCLUDE_PATH .
>> -
>> -#define TRACE_INCLUDE_FILE pseudo_lock_trace
>> -
>> -#include <trace/define_trace.h>
> 
> This patch may be merged into patch #45 to fix the compilation errors in patch #45?

As a final step before merging it. Otherwise patch 45 is impossible to work with - it
can't be reviewed, but it can be regenerated. (and the script that does that inspected to
show I have nothing up my sleeve!).

The alternative is a patch that is "mostly generated, but then lightly messed with", which
means we would want someone to double check it.


Thanks,

James


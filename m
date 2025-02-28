Return-Path: <linux-kernel+bounces-539318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55BA4A332
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DB3189C6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673126FDB4;
	Fri, 28 Feb 2025 19:55:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2050C230BD8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772530; cv=none; b=lYSZ43Y9aapHL3EEN6FAdVzg4f8F5QHkFXkhLedBG8u7NVaHKuPmWHH1d0EVrxMVETPf8syRZIx8tVOSrgD0juWWkkgi8LqoXMJqUKMt6owTu7W4/nq87ahHJ/LIsEPYuMeHd1gw5G5fCpfTxs2VH9N8woS1B++RqES9h707g24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772530; c=relaxed/simple;
	bh=+tfHQjfpf/kVJGDuX+IhePHsJLEjr3Ddygk5rSJAQU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otdMeucm9bryeX9dneKLqmDToab/0fP3R2UsgjZCKR2Aml50QzSmEIZRkncwDcuZGW5d7bCilMV+qFagJTcEMyWGS/FwUPPjyG6oCG2P7pt0hwhHIu6IVvYPWPmj//bQL5pBvmkgVHBcG3IMuuSisd34k8p+QgUeLfVufov2x3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0EB41007;
	Fri, 28 Feb 2025 11:55:43 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF4DB3F5A1;
	Fri, 28 Feb 2025 11:55:21 -0800 (PST)
Message-ID: <7562c41a-42f1-4d33-a543-d92ead1d72da@arm.com>
Date: Fri, 28 Feb 2025 19:55:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 36/42] x86/resctrl: Add end-marker to the
 resctrl_event_id enum
To: babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-37-james.morse@arm.com>
 <f91e1dd2-2ab3-4c23-893d-a87d4d38e43e@amd.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <f91e1dd2-2ab3-4c23-893d-a87d4d38e43e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 27/02/2025 20:26, Moger, Babu wrote:
> On 2/7/25 12:18, James Morse wrote:
>> The resctrl_event_id enum gives names to the counter event numbers on x86.
>> These are used directly by resctrl.
>>
>> To allow the MPAM driver to keep an array of these the size of the enum
>> needs to be known.
>>
>> Add a 'num_events' define which can be used to size an array. This isn't
>> a member of the enum to avoid updating switch statements that would
>> otherwise be missing a case.

>> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
>> index 51c51a1aabfb..70226f5ab3e3 100644
>> --- a/include/linux/resctrl_types.h
>> +++ b/include/linux/resctrl_types.h
>> @@ -51,4 +51,6 @@ enum resctrl_event_id {
>>  	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
>>  };
>>  
>> +#define QOS_NUM_EVENTS		(QOS_L3_MBM_LOCAL_EVENT_ID + 1)

> Why cant this be part of "enum resctrl_event_id" like we defined
> RDT_NUM_RESOURCES?

Maybe its a difference that only exists in my head, but the rdt resource array is
completely a resctrl concept, the positions in the enum don't mean anything.
Not so for for resctrl_event_id - those numbers mean something to the X86 CPUs. Resctrl
needs some unique identifier for those, and its simpler just to use these directly. I
didn't want to add anything to this enum.

If there are mpam specific events, (currently there is only the risk of bandwidth counters
on the L2, or scattered at random through the system), I'd prefer to support them via perf
and keep them out of here completely.


Thanks,

James


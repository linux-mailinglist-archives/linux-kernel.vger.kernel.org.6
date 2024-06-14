Return-Path: <linux-kernel+bounces-214976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A572908CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412C31C25422
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E78F44;
	Fri, 14 Jun 2024 13:59:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163D079CF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373555; cv=none; b=rDqnRiYbn/fcBQoiOtoeAuOkYx80YVtmBNIh/BZkv6e77Ge8yHEyEk0nh7dLyP/J9oT7QFjzyhy/80piTj9IE3m0m6DY8J2uGMroQRim6AbD0X7ODQicmDCP/HESaNGiX6zDpldSMxTiZBEGTaR9BZAK7UHylxiVoG+nWZvpI3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373555; c=relaxed/simple;
	bh=O8rQAoZh+GFQusD52/AxHZGlDyQ2BNovWAmx80/SfT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxLXgsaDdAw/xaIpg4F/3myR3gGyekQNkyDFwDFyRGMg/YVDPmY1sLxh08MVzgYhmwB4yhJOmof77Vj4/UWNfjGzMJVgiyC0Me1WFntNiuZPUR2Nu7Y2ZuSNEYJ0PhrPZSr/t8IGFWinAsBYos2HNtrl94FjQj2bEh5gk/Mrdu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DE8FFEC;
	Fri, 14 Jun 2024 06:59:38 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BB913F5A1;
	Fri, 14 Jun 2024 06:59:09 -0700 (PDT)
Message-ID: <a029cfe6-7526-44c1-a0db-88d2ad8bb827@arm.com>
Date: Fri, 14 Jun 2024 14:59:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 28/31] x86/resctrl: Drop __init/__exit on assorted
 symbols
Content-Language: en-GB
To: Dave Martin <Dave.Martin@arm.com>,
 Amit Singh Tomar <amitsinght@marvell.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
 Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-29-james.morse@arm.com>
 <c27c7813-5744-4363-bb7b-f9fbe80fd549@intel.com>
 <ZhfzF8L6w1pgJJ1r@e133380.arm.com>
 <47af4fef-35d3-4d88-9afa-42c1a99fbe07@marvell.com>
 <ZhlfQKMg4xeA53SD@e133380.arm.com>
 <b87653fa-34e3-4124-a96f-f5d2b9730f10@marvell.com>
 <ZjEaA+YRPA+p9msM@e133380.arm.com>
 <cb40c3e6-f678-45c7-b8e7-a6f337b51dfb@marvell.com>
 <ZjO4LXqGcy4bwsn4@e133380.arm.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <ZjO4LXqGcy4bwsn4@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi guys,

On 02/05/2024 16:58, Dave Martin wrote:
> On Wed, May 01, 2024 at 09:51:51PM +0530, Amit Singh Tomar wrote:
>>>>> I think James will need to comment on this, but I think that yes, it
>>>>> is probably appropriate to require a reboot.  I think an MPAM error
>>>>> interrupt should only happen if the software did something wrong, so
>>>>> it's a bit like hitting a BUG(): we don't promise that everything works
>>>>> 100% properly until the system is restarted.  Misbehaviour should be
>>>>> contained to MPAM though.

Indeed - all the reasons for the MPAM error interrupt being triggered indicate a software
bug, so re-mounting resctrl with the same buggy code isn't going to fix anything.


>>>> if "resctrl" is nonfunctional in this state, then this comment[1] here does
>>>> *not* make sense.
>>>>
>>>> "restore any modified controls to their reset values."

The MPAM driver goes on to reset all the MPAM hardware to the best of its ability.
These means everything gets set back to 100%, so its as if MPAM is not implemented.
This is better than throttling the wrong task because an out-of-range PARTID for
${important_task} is using the configuration of ${background_process}...


>>> Can you clarify what you mean here?
>>
>> What I meant was, What's the rationale behind restoring the modified
>> controls, if user is going to restart the system anyways (in order to use
>> MPAM again),  but later realized that it is needed so that *non* MPAM loads>> (user may still want to run other things even after MPAM error interrupt)
>> would not have any adverse effect with modified controls.
>>
>> Therefore, taking my statement back.
> 
> Ack: we can't force the system to restart without losing data.  Really,
> the decision about when and whether to attempt a graceful shutdown or
> reboot should be left to userspace.  But until userspace does shut down
> the system, we do our best to behave as if the broken part of the system
> (MPAM) were not present at all.

Dave's systemd choking on this angle is interesting - I'll go experiment with this.

The alternative here is to delete the __exit text completely as it can't be run, and
instead get MPAM's error interrupt to disable the static-keys and return -EIO for every
call into the arch code.
I didn't do this as its likely to cause extra churn to ensure that every arch helper can
propagate errors back to user-space, and this seemed like a good (re-)use of existing code.

The third option was to not do anything in MPAM, and just print a message to say bad
things might be happening. Given its extra work for hardware to detect the error
conditions, I previously assumed no-one would do this, and hardware would just 'go wrong'
instead... but as someone has built this, it would be good to try and react to it.


Thanks,

James


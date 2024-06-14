Return-Path: <linux-kernel+bounces-214979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC9A908CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622FB1F22617
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D08F44;
	Fri, 14 Jun 2024 13:59:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2718EAE5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373567; cv=none; b=r13APiUJTi4jZ3b2kJ+v8JmdtpPDqXbYn2tcMiuXjqXfUo2tbndmUqRS9qsVP+dxw6YecKZAPDE9Lhb1lINN9SXwBYgZB2XhLn9Kohs/2QKSNojgHWXASu+QL88Y9sUl6lZArjiIFru3apJeH2DI/UAldtWTORdfRNyxkc4hHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373567; c=relaxed/simple;
	bh=6gZAugCiypbEKq85VPzONnpYfjaFeJdLh1a8csN8qmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHvOREch2l7SjEYdAN7rHIZVJR/XUcq5+Q8LSouxjU0l7fi+QDTVAVmzY7srrlk76fvewD8/NoBRbc+CgTfaSABJHyJbv31qkvCmJK9N7a5ewdePLDShNHz7mrV1ijpmzDCDkNAOwuwDHLnQLCYVvle+nM5xivr/c8tNeiOE96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D56A4FEC;
	Fri, 14 Jun 2024 06:59:49 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6936E3F5A1;
	Fri, 14 Jun 2024 06:59:22 -0700 (PDT)
Message-ID: <9b1f537d-4965-472b-bc85-cfa22c87c58e@arm.com>
Date: Fri, 14 Jun 2024 14:59:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v1 28/31] x86/resctrl: Drop __init/__exit
 on assorted symbols
Content-Language: en-GB
To: Amit Singh Tomar <amitsinght@marvell.com>,
 Dave Martin <Dave.Martin@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
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
From: James Morse <james.morse@arm.com>
In-Reply-To: <47af4fef-35d3-4d88-9afa-42c1a99fbe07@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Amit, Reinette,

On 11/04/2024 16:51, Amit Singh Tomar wrote:
>> On Mon, Apr 08, 2024 at 08:32:36PM -0700, Reinette Chatre wrote:
>>> On 3/21/2024 9:51 AM, James Morse wrote:
>>>> Because ARM's MPAM controls are probed using MMIO, resctrl can't be
>>>> initialised until enough CPUs are online to have determined the
>>>> system-wide supported num_closid. Arm64 also supports 'late onlined
>>>> secondaries', where only a subset of CPUs are online during boot.
>>>>
>>>> These two combine to mean the MPAM driver may not be able to initialise
>>>> resctrl until user-space has brought 'enough' CPUs online.
>>>>
>>>> To allow MPAM to initialise resctrl after __init text has been free'd,
>>>> remove all the __init markings from resctrl.
>>>>
>>>> The existing __exit markings cause these functions to be removed by the
>>>> linker as it has never been possible to build resctrl as a module. MPAM
>>>> has an error interrupt which causes the driver to reset and disable
>>>> itself. Remove the __exit markings to allow the MPAM driver to tear down
>>>> resctrl when an error occurs.
>>>
>>> Obviously for the reasons you state this code has never been exercised.
>>> Were you able to test this error interrupt flow yet?

>> I think this will have to wait for James to respond.
>>
>> There is code to tear down resctrl in response to an MPAM error interrupt,
>> but I don't know how it has been exercised so far (if at all).

Previously I saw one or two kernfs structures left behind. (to discover this you had to
leave a shell with its CWD in the filesystem), but it looks like those issues have been
solved.

Dave points out that resctrl_exit() removing the sysfs mount point means the filesystem
can't be umount()ed. Systemd doesn't seem to care today, but might choke on this in the
future.

I think the right thing to do here is get resctrl_exit() to call rdtgroup_destroy_root(),
and drop sysfs_remove_mount_point(). This creates a bit of asymmetry, but if resctrl were
a module the mount-point stuff would be done in module init/exit - only we don't have a
module to unload, so the asymmetry is to be expected. I don't think its worth adding new
__exit text that we know will never be used for the sake of symmetry.

With this change, triggering the interrupt makes all the files under resctrl disappear, I
can then umount() the filesystem, but not re-mount it.


The aim here is for the arch code to be able to say "this is broken, I can't support
resctrl" with minimum changes to the existing code.

There are a couple of vanishingly unlikely corner cases that need tightening up: e.g. the
rmid_ptrs[] array disappears, a syscall could get blocked on the rdtgroup_mutex while the
teardown happens, once it gains the lock it discoverers a surprise NULL pointer.

Fixing these can wait until after the code is moved as these things can't happen on x86.
(patches are in the 'extra's branch of the mpam tree:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot%2bextras/v6.10-rc1
)


> We are managed to test the MPAM error interrupt (on the platform that supports MPAM
> interrupts on software errors). For instance programming
> more resource control groups (part IDs) than available, and It appears to correctly remove
> the "resctrl" mount point (though mount command still shows resctrl on /sys/fs/resctrl
> type resctrl (rw,relatime)
> ), but
> 
> # mount -t resctrl resctrl /sys/fs/resctrl
> mount: /sys/fs/resctrl: mount point does not exist.
> 
> Additionally, a question regarding this, Is a complete system restart necessary to regain
> the mount?

It is - but you are likely to hit the same software bug again. The story here is about
keeping the machine running without penalising the wrong task. I think its acceptable for
programs driving resctrl to go wrong, provided the workload doesn't run with the wrong
configuration.


Thanks,

James


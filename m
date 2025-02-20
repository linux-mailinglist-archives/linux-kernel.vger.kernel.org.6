Return-Path: <linux-kernel+bounces-524096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B0A3DF16
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95B13A69D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B63C211292;
	Thu, 20 Feb 2025 15:44:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B620E316;
	Thu, 20 Feb 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066273; cv=none; b=us3fysDdktP/xxwpWRPufe/9u9imSXC4cYcyUwX49nRKkT8LRuF6dBP22LmjnqdnZmOq3cpF9Yh46Ssv26MJBl+eBXXxHacPO2XMwl9vhb029nB6mHFa6QZ7CiFQfqGsbudEQnZUGaWPBT0UfDHHPyFzt90ZeOUZaYXzsllW7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066273; c=relaxed/simple;
	bh=Vs6rNY3qTbEpZYfiwoGz3htUlmZ2gN6bpbwkGZfN5Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4S0cSl2L1SlgoPAuQbrg3p3k2DF4XAr8oRdmrSvi7gs1C9AEPwsIr2SrhYtt+oRzO8NbuWsHW07bi/lDaLheKQ1CvZ+gj0wt8f14Sx73uwfKA0MhUjvZqB1XfZr8eCFn6LeMFEIyZPn0YCNdXTuDVEifBXbNcczie9dA+ottpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42B5D16F3;
	Thu, 20 Feb 2025 07:44:49 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07B793F59E;
	Thu, 20 Feb 2025 07:44:26 -0800 (PST)
Date: Thu, 20 Feb 2025 15:44:24 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, peternewman@google.com, x86@kernel.org,
	hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
	thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Message-ID: <Z7dN2KpsQjVUb3KR@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>
 <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
 <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>

Hi,

On Wed, Feb 19, 2025 at 03:09:51PM -0600, Moger, Babu wrote:
> Hi Dave,
> 
> On 2/19/25 07:53, Dave Martin wrote:
> > On Wed, Jan 22, 2025 at 02:20:30PM -0600, Babu Moger wrote:
> >> Provide the interface to list the assignment states of all the resctrl
> >> groups in mbm_cntr_assign mode.

[...]

> >> +static int resctrl_mbm_assign_control_show(struct kernfs_open_file *of,
> >> +					   struct seq_file *s, void *v)
> >> +{

[...]

> > Unlike the other resctrl files, it looks like the total size of this
> > data will scale up with the number of existing monitoring groups
> > and the lengths of the group names (in addition to the number of
> > monitoring domains).
> > 
> > So, this can easily be more than a page, overflowing internal limits
> > in the seq_file and kernfs code.
> > 
> > Do we need to track some state between read() calls?  This can be done
> > by overriding the kernfs .open() and .release() methods and hanging
> > some state data (or an rdtgroup_file pointer) on of->priv.
> > 
> > Also, if we allow the data to be read out in chunks, then we would
> > either have to snapshot all the data in one go and stash the unread
> > tail in the kernel, or we would need to move over to RCU-based
> > enumeration or similar -- otherwise releasing rdtgroup_mutex in the
> > middle of the enumeration in order to return data to userspace is going
> > to be a problem...
> 
> Good catch.
> 
> I see similar buffer overflow is handled by calling seq_buf_clear()
> (look at process_durations() or in show_user_instructions()).
> 
> How about handling this by calling rdt_last_cmd_clear() before printing
> each group?

Does this work?

Once seq_buf_has_overflowed() returns nonzero, data has been lost, no?
So far as I can see, show_user_instructions() just gives up on printing
the affected line, while process_durations() tries to anticipate
overflow and prints out the accumulated text to dmesg before clearing
the buffer.

In our case, we cannot send more data to userspace than was requested
in the read() call, so we might have nowhere to drain the seq_buf
contents to in order to free up space.

sysfs "expects" userspace to do a big enough read() that this problem
doesn't happen.  In practice this is OK because people usually read
through a buffered I/O layer like stdio, and in realistic
implementations the user-side I/O buffer is large enough to hide this
issue.

But mbm_assign_control data is dynamically generated and potentially
much bigger than a typical sysfs file.

> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 484d6009869f..1828f59eb723 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1026,6 +1026,7 @@ static int resctrl_mbm_assign_control_show(struct
> kernfs_open_file *of,
>         }
> 
>         list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +               rdt_last_cmd_clear();
>                 seq_printf(s, "%s//", rdtg->kn->name);
> 
>                 sep = false;
> @@ -1041,6 +1042,7 @@ static int resctrl_mbm_assign_control_show(struct
> kernfs_open_file *of,
>                 seq_putc(s, '\n');
> 
>                 list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> mon.crdtgrp_list) {
> +                       rdt_last_cmd_clear();

I don't see how this helps.

Surely last_cmd_status has nothing to do with s?

[...]

Cheers
---Dave


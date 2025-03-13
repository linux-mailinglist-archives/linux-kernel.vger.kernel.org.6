Return-Path: <linux-kernel+bounces-560341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B2AA602C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C7A420532
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD71F4612;
	Thu, 13 Mar 2025 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2CxPUzz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D542AA9;
	Thu, 13 Mar 2025 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898200; cv=none; b=cJl6zq787hWP6YNa1/mj4WIbMldNrImbAbYP+ZiSZK3+fMrhox1x5oPcyRED/t04BKK1ZS0/nYNulEn6dBoJB8Sl8rOz7n5TbHZad7119VXc8z6Hp1UI5B7rZ8WOU4O+OD7Z3k0b5wGoUg6owAKzh/9xYdZIxEjF8lKBQhypTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898200; c=relaxed/simple;
	bh=mLAlCqYCbYi8Tz7gyZwo2pmMdHDEESJWMN8CkQrRVgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPnW1kBpZHZhXmxbBcpiX/fDy1Qmcx1u0Qc/4ug/TRUlTJqVAzfkwpgJeNG8VELB00S2mI73MJaotnW6LzPTQ6YijGwvEtMcTuaF047vArkhEQgjqlT8TJFnN7CJ48sNWRptWDgofCh9iglmtDFW2WpEMRbg8gxRif2Ewbmy7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2CxPUzz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741898198; x=1773434198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mLAlCqYCbYi8Tz7gyZwo2pmMdHDEESJWMN8CkQrRVgI=;
  b=B2CxPUzzwIA7Or/79hbGlhMwhVMhH0DIc8hYFWtzZ5ygvpSoVVxyhgSR
   9XR3DSTNpUm6VB2C52QB7iJIUtuAj7j7fnvJao2M3PaVjJWxRdzjMQQEX
   xS1qCkM78OKpdfwVz7JxVcVShvy3n1EzUHTtHVUonVWLwRer0UWhAmhiK
   QM6wyYl8mbXT/6PNLsghHHn5G1xI5J964Blqtez/kY1M56iZaYDAs7bmJ
   crqpv+BVPYww7hUyiKtlDdmhXzXJ/XutjGYKsbA7zgiTxt8IqMltgtBEJ
   IJsAiaxi2uXCnhElQMiPJ7uZOd18s56QybNe4E+Yadwe+XRZ7ihe7BBj8
   A==;
X-CSE-ConnectionGUID: X1tI+qqqRBa9pXHNyXGtcQ==
X-CSE-MsgGUID: iQP0V+wySqqOtLhhWdHz1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42945407"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42945407"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 13:36:37 -0700
X-CSE-ConnectionGUID: vjmZss9dQii/lO6d73MReA==
X-CSE-MsgGUID: zXm1khAJSWaao1/Zy1PU3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="122000600"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 13:36:37 -0700
Date: Thu, 13 Mar 2025 13:36:35 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	"Moger, Babu" <bmoger@amd.com>,
	Peter Newman <peternewman@google.com>,
	Dave Martin <Dave.Martin@arm.com>, corbet@lwn.net,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
	rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Message-ID: <Z9NB0wd8ZewLjNAd@agluck-desk3>
References: <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>

On Thu, Mar 13, 2025 at 03:13:32PM -0500, Moger, Babu wrote:
> Hi Reinette,
> 
> On 3/13/25 11:08, Reinette Chatre wrote:
> > Hi Babu,
> > 
> > On 3/12/25 11:14 AM, Moger, Babu wrote:
> >> Hi Reinette,
> >>
> >> On 3/12/25 12:14, Reinette Chatre wrote:
> >>> Hi Babu,
> >>>
> >>> On 3/12/25 9:03 AM, Moger, Babu wrote:
> >>>> Hi Reinette,
> >>>>
> >>>> On 3/12/25 10:07, Reinette Chatre wrote:
> >>>>> Hi Babu,
> >>>>>
> ..
> 
> >>>>>> We can add the mkdir support later. That way we can provide basic ABMC
> >>>>>> support without too much code complexity with mkdir support.
> >>>>>
> >>>>> This is not clear to me how you envision the "first phase". Is it what you
> >>>>> proposed above, for example:
> >>>>>       #echo "LclFill, LclNTWr, RmtFill" >
> >>>>>          /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
> >>>>>
> >>>>> In above the counter configuration name is a file. 
> >>>>
> >>>> Yes. That is correct.
> >>>>
> >>>> There will be two configuration files by default when resctrl is mounted
> >>>> when ABMC is enabled.
> >>>> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
> >>>> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
> >>>>
> >>>>>
> >>>>> How could mkdir support be added to this later if there are already files present?
> >>>>
> >>>> We already have these directories when resctrl is mounted.
> >>>> /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_total_bytes
> >>>> /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_local_bytes
> >>>> /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_total_bytes
> >>>> /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_local_bytes
> >>>>
> >>>> We dont need "mkdir" support for default  configurations.
> >>>
> >>> I was referring to the "mkdir" support for additional configurations that
> >>> I understood you are thinking about adding later. For example,
> >>> (copied from Peter's message
> >>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/):
> >>>
> >>>
> >>>  # mkdir info/L3_MON/counter_configs/mbm_local_bytes
> >>>  # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> >>>  # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> >>>  # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> >>>  # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> >>> LclFill
> >>> LclNTWr
> >>> LclSlowFill
> >>>
> >>> Any "later" work needs to be backward compatible with the first phase.
> >>
> >> Actually, we dont need extra file "event_filter".
> >> This was discussed here.
> >> https://lore.kernel.org/lkml/CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com/
> > 
> > I undestand from that exchange that it is possible to read/write from
> > an *existing* kernfs file but it is not obvious to me how that file is
> > planned to be created.
> 
> My bad.. I misspoke here. We need "event_filter" file under each
> configuration.
> 
> 
> > 
> > My understanding of the motivation behind support for "mkdir" is to enable
> > user space to create custom counter configurations.
> > 
> 
> That is correct.
> 
> > I understand that ABMC support aims to start with existing mbm_total_bytes/mbm_local_bytes
> > configurations but I believe the consensus is that custom configurations need
> > to be supported in the future.
> > If resctrl starts with support where counter configuration as
> > managed with a *file*, for example:
> > /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
> > how will user space create future custom configurations?
> > As I understand that is only possible with mkdir.
> > 
> >>
> >> # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes
> >> # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes
> >> # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes
> >> # cat info/L3_MON/counter_configs/mbm_local_bytes
> >>  LclFill
> >>  LclNTWr
> >>  LclSlowFill
> >>
> >> In the future, we can add mkdir support.
> >>
> >> # mkdir info/L3_MON/counter_configs/mbm_read_only
> > 
> > This is exactly my concern. resctrl should not start with a user space where
> > a counter configuration is a file (mbm_local_bytes/mbm_total_bytes) and then
> > switch user space interface to have counter configuration be done with
> > directories.
> > 
> >> # echo LclFill > info/L3_MON/counter_configs/mbm_read_only
> >> # cat info/L3_MON/counter_configs/mbm_read_only
> >>   LclFill
> > 
> > ... wait ... user space writes to the directory?
> > 
> 
> My bad. This is wrong. Let me rewrite the steps below.
> 
> > 
> > 
> >>
> >> #echo mbm_read_only > test/mon_data/mon_L3_00/assign_exclusive
> >>
> >> Which would result in the creation of test/mon_data/mon_L3_*/mbm_read_only
> >>
> >> So, there is not breakage of backword compatibility.
> > 
> > The way I understand it I am seeing many incompatibilities. Perhaps I am missing
> > something. Could you please provide detailed steps of how first phase and
> > second phase would look?
> 
> No. You didn't miss anything. I misspoke on few steps.
> 
> Here are the steps. Just copying steps from Peters proposal.
> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
> 
> 
> 1. Mount the resctrl
>    mount -t resctrl resctrl /sys/fs/resctrl
> 
> 2. When ABMC is supported two default configurations will be created.
> 
>   a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>   b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
>   These files will be populated with default total and local events
>   # cat info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>     VictimBW
>     RmtSlowFill
>     RmtNTWr
>     RmtFill
>     LclFill
>     LclNTWr
>     LclSlowFill
> 
>   # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>    LclFill,
>    LclNTWr
>    LclSlowFill
> 
> 3. Users will have options to update the event configuration.
>    echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter

Once the "mkdir" support described below is implemented users will not
need to redefine these legacy event file names. That makes me happy.

> 
> 4. As usual the events can be read from the mon_data directories.
>    #mkdir /sys/fs/resctrl/test
>    #cd   /sys/fs/resctr/test
>    #cat  test/mon_data/mon_data/mon_L3_00/mbm_tota_bytes
>    101010
>    #cat   test/mon_data/mon_data/mon_L3_00/mbm_local_bytes
>    32323
> 
> 5. There will be 3 files created in each group's mon_data directory when
> ABMC is supported.
> 
>    a. test/mon_data/mon_L3_00/assign_exclusive
>    b. test/mon_data/mon_L3_00/assign_shared
>    c. test/mon_data/mon_L3_00/unassign
> 
> 
> 6. Events can be assigned/unassigned by these commands
> 
>  # echo mbm_total_bytes > test/mon_data/mon_L3_00/assign_exclusive
>  # echo mbm_local_bytes > test/mon_data/mon_L3_01/assign_exclusive
>  # echo mbm_local_bytes > test/mon_data/mon_L3_01/unassign
> 
> 
> Note:
> I feel 3 files are excessive here. We can probably achieve everything in
> just one file.

Maybe the one file could look like:

# cat mon_L3_assignments
mbm_total_bytes: exclusive
mbm_local_bytes: shared
mbm_read_only: unassigned

with new lines appearing when mkdir creates new events, and the obvious
write semantics:

# echo "mbm_total_bytes: unassigned" > mon_L3_assignments

to make updates.

> Not sure about mbm_assign_control interface as there are concerns with
> group listing holding the lock for long.
> 
> -----------------------------------------------------------------------
> Second phase, we can add support for "mkdir"
> 
> 1. mkdir info/L3_MON/counter_configs/mbm_read_only
> 
> 2. mkdir option will create "event_filter" file.
>    info/L3_MON/counter_configs/mbm_read_only/event_filter
> 
> 3. Users can modify event configuration.
>    echo LclFill > info/L3_MON/counter_configs/mbm_read_only/event_filter
> 
> 4. Users can assign the events
> 
>   echo mbm_read_only > test/mon_data/mon_L3_00/assign_exclusive
> 
> 5. Events can be read in
> 
>    test/mon_data/mon_data/mon_L3_00/mbm_read_only

Is there a matching "rmdir" to make this go away again?

> -- 
> Thanks
> Babu Moger


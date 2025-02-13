Return-Path: <linux-kernel+bounces-513610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A5CA34C64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404E33A41D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D044423A9AB;
	Thu, 13 Feb 2025 17:52:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02DF221552;
	Thu, 13 Feb 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469120; cv=none; b=ktH3BwvFbVjCDamr3dbqqd6W4Trp5Kjpr0BpgKPrTJN2NZS/XrVZxr0nvpwfJEVPnVvonqwqq10Sot4qvuW5hnjn6jk0Qcr06nRUncp6hJR80+Whvz/LHLmbyeavckAA1sEMuNK/xWzVaKrpQiVXLvENB2xvIuSatncMpXA7S48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469120; c=relaxed/simple;
	bh=zqV75qnQLwyFHhLFq1/Rw5B46LsPeHmSTmkyGiMlIk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evU61HYvnF+QcRtxPRXjpDf/8Dsh9CIeB1MVuLFjNqj5y4quIR74FgejJ7GYzG9LOFi5JS6V/x6p13iyPGK7g9BFdNirH1pAwHLuQEjQOhN1usZouBTStqCWyRamwVe/Y8hF8EUssXPOF8kWVRDYHEjH4Yb2qawoVcNPOF6FZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1C4B113E;
	Thu, 13 Feb 2025 09:52:17 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 444863F5A1;
	Thu, 13 Feb 2025 09:51:53 -0800 (PST)
Date: Thu, 13 Feb 2025 17:51:50 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Peter Newman <peternewman@google.com>, corbet@lwn.net,
	reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, tony.luck@intel.com,
	fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com,
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
Message-ID: <Z64xNm7GrXuVj3gv@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <CALPaoCgiZ=tZE_BF2XzeYMRG84x4+kGKfhHWj2Uo=Cre_B_6Vg@mail.gmail.com>
 <7a87b18c-cfba-4edd-946b-dd2831f56633@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a87b18c-cfba-4edd-946b-dd2831f56633@amd.com>

On Mon, Feb 03, 2025 at 02:49:27PM -0600, Moger, Babu wrote:
> Hi Peter,
> 
> On 2/3/25 08:54, Peter Newman wrote:

[...]

> >> # Linux Implementation
> >>
> >> Create a generic interface aimed to support user space assignment
> >> of scarce counters used for monitoring. First usage of interface
> >> is by ABMC with option to expand usage to "soft-ABMC" and MPAM
> >> counters in future.
> > 
> > As a reminder of the work related to this, please take a look at the
> > thread where Reinette proposed a "shared counters" mode in
> > mbm_assign_control[1]. I am currently working to demonstrate that this
> > combined with the mbm_*_bytes_per_second events discussed earlier in
> > the same thread will address my users' concerns about the overhead of
> > reading a large number of MBM counters, resulting from a maximal
> > number of monitoring groups whose jobs are not isolated to any L3
> > monitoring domain.
> > 
> > ABMC will add to the number of registers which need to be programmed
> > in each domain, so I will need to demonstrate that ABMC combined with
> > these additional features addresses their performance concerns and
> > that the resulting interface is user-friendly enough that they will
> > not need a detailed understanding of the implementation to avoid an
> > unacceptable performance degradation (i.e., needing to understand what
> > conditions will increase the number of IPIs required).
> > 
> > If all goes well, soft-ABMC will try to extend this usage model to the
> > existing, pre-ABMC, AMD platforms I support.
> > 
> > Thanks,
> > -Peter
> > 
> > [1] https://lore.kernel.org/lkml/7ee63634-3b55-4427-8283-8e3d38105f41@intel.com/
> > 
> 
> Thanks for the heads-up. I understand what's going on and have an idea of
> the plan. Please keep us updated on the progress. Also, if any changes are
> needed in this series to meet your requirements, feel free to share your
> feedback.

Playing devil's advocate, I wonder whether there is a point beyond
which it would be better to have an interface to hand over some of the
counters to perf?

The logic for round-robin scheduling of events onto counters, dealing
with overflows etc. has already been invented over there, and it's
fiddly to get right.  Ideally resctrl wouldn't have its own special
implementation of that kind of stuff.

(Said my someone who has never tried to hack up an uncore event source
in perf.)

Cheers
---Dave


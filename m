Return-Path: <linux-kernel+bounces-523791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5506BA3DB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C164A17AA11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2AD1F8EEE;
	Thu, 20 Feb 2025 13:29:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AFF433BE;
	Thu, 20 Feb 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058166; cv=none; b=BtZ5jN4NZvHTxNyD10Uf1w5CDs2P6rTNidiaRBR3JPjdorU4GcV7Uaavy21S/l1XaEky7CxlWlG4mxKqii0IHIxDpdNXYUkC9LHVoq3WL5RtkbWVDUIdGh1dUxpxKTnbCqLHChf72kSyDOvlfIIzd8vz7tzxs9vDmK497VlFwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058166; c=relaxed/simple;
	bh=xX9InoHiSAbPiM/wLgu8BPJCJTPmy9xbOommvTSQ9Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUgqjQn8tRZu2M2g/APBoiRlzDfnaREHCeAKTJI9xf5QqOm6nNpOBOfIAho4hO5di3I/X6zpUxpLVLtNdRkDuL1cP7TLGcSntjTFeMUrOOXlex1559p9BTVnNp95QuBAGHysBRJ8jNEcN1bu9yjO+t3NRyyDbS85zQwYobu5yN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BB1A1BB0;
	Thu, 20 Feb 2025 05:29:40 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 833683F5A1;
	Thu, 20 Feb 2025 05:29:17 -0800 (PST)
Date: Thu, 20 Feb 2025 13:29:10 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, peternewman@google.com, fenghua.yu@intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
	daniel.sneddon@linux.intel.com, jpoimboe@kernel.org,
	perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
	xiaoyao.li@intel.com, seanjc@google.com, xin3.li@intel.com,
	andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 01/23] x86/resctrl: Add __init attribute to functions
 called from resctrl_late_init()
Message-ID: <Z7cuJu/pLAXsM3ty@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <e946a96a5d161f7b32e84c23c1a0024a31db2898.1737577229.git.babu.moger@amd.com>
 <Z7Xccob9B2IMiAXy@e133380.arm.com>
 <68cab18c-9a17-45a2-8374-86deccf2664b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cab18c-9a17-45a2-8374-86deccf2664b@amd.com>

Hi,

On Wed, Feb 19, 2025 at 10:53:41AM -0600, Moger, Babu wrote:
> Hi Dave,
> 
> On 2/19/25 07:28, Dave Martin wrote:
> > Hi,
> > 
> > On Wed, Jan 22, 2025 at 02:20:09PM -0600, Babu Moger wrote:
> >> resctrl_late_init() has the __init attribute, but some of the functions
> >> called from it do not have the __init attribute.
> >>
> >> Add the __init attribute to all the functions in the call sequences to
> >> maintain consistency throughout.
> > 
> > (BTW, did you just find these cases by inspection, or were you getting
> > build warnings?
> > 
> > Even with CONFIG_DEBUG_SECTION_MISMATCH=y, I struggle to get build
> > warnings about section mismatches on inlined functions.  Even building
> > with -fno-inline doesn't flag them all up (though I don't think this
> > suppresses all inlining).
> > 
> > If you have a way of tracking these cases down automatically, I'd be
> > interested to know so that I can apply it elsewhere.)
> 
> It is mostly by code inspection at this point.
> 
> You can refer to this commit [1].
> 
> We used to see section mismatch warnings when non-init functions call
> __init functions.
> 
> MODPOST Module.symvers
> WARNING: modpost: vmlinux: section mismatch in reference:
> rdt_get_mon_l3_config+0x2b5 (section: .text) -> rdt_cpu_has (section:
> .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference:
> rdt_get_mon_l3_config+0x408 (section: .text) -> rdt_cpu_has (section:
> .init.text)
> 
> 
> 1.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.14-rc3&id=bd334c86b5d70e5d1c6169991802e62c828d6f38

Right.

No problem with this patch, but I'll bear in mind for the future that
CONFIG_DEBUG_SECTION_MISMATCH has limitations...

Cheers
---Dave


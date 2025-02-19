Return-Path: <linux-kernel+bounces-521620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDE1A3BFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814347A6C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552131E32D3;
	Wed, 19 Feb 2025 13:31:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1C445C14;
	Wed, 19 Feb 2025 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971882; cv=none; b=ZJyJo7UYThCBJ/TnFwgKXbsBEC7okEBlI9jrvj5rJAzlyP3BbIPjxIdrMgryt8avDpPV/W/0NBy3bnnbPjkA9MURpORC/N2fOqjhGueelzIXWbRwNHJuprQSHb+U4bGied4ePPlUazjZoDVpQypqLLUn4xtAKEW/lBxhvZoxeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971882; c=relaxed/simple;
	bh=8E6LhZDZawxbFz++AdRMNcgQ/lGBysSnzYO+XcFSN2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdC4oF6BBbGbteZH5JnBr6IAl50S/+NwwJdm3zxauPEKPd8weGvU2tXi8Ng+dyeSAsW+4Nb2Jwnr8ufoCSSaLuzEoQbpiIskHyML0RpSzmCe2dbDujm/Pxf5x3rZo+mBL47T4xIl09NPTgV5QR4zFr7/Mh11/LKKRkKiX8xzgrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 471A21682;
	Wed, 19 Feb 2025 05:31:38 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E429A3F59E;
	Wed, 19 Feb 2025 05:31:15 -0800 (PST)
Date: Wed, 19 Feb 2025 13:31:13 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <bmoger@amd.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
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
Subject: Re: [PATCH v11 12/23] x86/resctrl: Introduce interface to display
 number of free counters
Message-ID: <Z7XdIbYEqqjfLSsC@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <f60eced8c7b81267b0067b0c41a4ddbc263ded5b.1737577229.git.babu.moger@amd.com>
 <bc963e40-46cd-42a2-95f0-a2e1a35cbc25@intel.com>
 <811b0f54-4c59-43fd-a551-3485b242e20d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811b0f54-4c59-43fd-a551-3485b242e20d@amd.com>

On Fri, Feb 07, 2025 at 12:59:55PM -0600, Moger, Babu wrote:
> Hi Reinette,
> 
> On 2/5/2025 6:19 PM, Reinette Chatre wrote:
> > Hi Babu,
> > 
> > On 1/22/25 12:20 PM, Babu Moger wrote:

[...]

> > > diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> > > index 31ff764deeeb..99cae75559b0 100644
> > > --- a/Documentation/arch/x86/resctrl.rst
> > > +++ b/Documentation/arch/x86/resctrl.rst
> > > @@ -299,6 +299,14 @@ with the following files:
> > >   	memory bandwidth tracking to a single memory bandwidth event per
> > >   	monitoring group.
> > > +"available_mbm_cntrs":
> > > +	The number of monitoring counters available for assignment in each
> > > +	domain when mbm_cntr_assign mode is enabled on the system.
> > > +	::
> > > +
> > 
> > Documentation jumps in with some hardcoded values that may cause confusion.
> > It looks to be missing something like (and looking back this also applies
> > to "num_mbm_cntrs"):
> > "For example, on a system with 30 available monitoring/(hardware?) counters in
> > each of its L3 domains:"
> 
> Sure.

It could make sense to write something like
"... 30 available [hardware] memory bandwidth counters in each ..."

MPAM has different kinds of counters, at least in theory.

(No big deal, though.)

Cheers
---Dave


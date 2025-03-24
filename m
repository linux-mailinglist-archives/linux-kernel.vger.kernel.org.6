Return-Path: <linux-kernel+bounces-574181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E178DA6E175
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 783B87A42E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BF02676CB;
	Mon, 24 Mar 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0qrWwBq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B626462B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838085; cv=none; b=IB4zFqOWzweTYJ3DTfkh0hHNMPeTLhcF8MVBI92z/oYm0bGa+ot6Sp4cU1+6t3MfGGx9mN6xe1Eyfqd/5yOUn3O3p9p2nSd4eOiK43O08wgCY0kUDTGoVVfzEVqN97kxpNEOlPin8nLSOG2zuOR1O+T7/ZawRq36O5gksktsJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838085; c=relaxed/simple;
	bh=hy9anLT+yso7HLVYKMgm3lQib/ckrtMmioGEPpx4hus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcvIzPGCjKarIpgoqjKzP7NpZP5lAodHFeoIM/ltDiycfkFbqQMc+7NbQrB4DerzsWAOv1YZnABCIEWVaVM+W+VHJfa1owirvkiMgzXNUNn3krqdW9UHwwXEhYaj6tI2uvi4LaKBM987JiWLag57sfk0Km4TyF1oINlCtWTK3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0qrWwBq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742838084; x=1774374084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hy9anLT+yso7HLVYKMgm3lQib/ckrtMmioGEPpx4hus=;
  b=m0qrWwBqNu1BcdumapwnA7OwYw6j/eQMYNOfsNAcEWYiPsB9chTS+9Nr
   Xer7/W0Jk/2cjTie+BKXvQfQ8cWZ/QnWPhaKVxm0KP9r7ck5G75heTVyN
   TQ/Cz45BMMumzWHXTlonYTlMCUExw46SkghfTe3cnFvmupEgCXN3iCz7m
   IYgvjhWwebMBExs5rMzXIMhzbSfACnZM1Q82Hm1fUNAZgyInFJXoUEfuf
   zOBI8/e0tEJZ5tYe1MEtzRT0vhO8iriqWg7DiovuDvAYIvf130K0vuEE7
   tsBPncIhfwxf6Q7Aq6ETWH76IgEzOfvudbWHioaea0AszEqgBh5/2HXS2
   g==;
X-CSE-ConnectionGUID: Kp3tgertRvilWY67IgsZaw==
X-CSE-MsgGUID: A5rbG2k0QUGzywmcUCYtBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="61583214"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="61583214"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 10:41:23 -0700
X-CSE-ConnectionGUID: AWPngOkURvy4A35d0cpDAw==
X-CSE-MsgGUID: 6teCpmLqTPSutk2e5RuVBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124280593"
Received: from pmsonava-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.197])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 10:41:22 -0700
Date: Mon, 24 Mar 2025 10:41:15 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v4 03/36] x86/bugs: Restructure mmio mitigation
Message-ID: <20250324174115.ogelbfgdmeoybi3b@desk>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
 <20250313192606.iijythngqtpx4tyy@desk>
 <20250324092915.GAZ-El68JG2BVuMK0K@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324092915.GAZ-El68JG2BVuMK0K@fat_crate.local>

On Mon, Mar 24, 2025 at 10:29:15AM +0100, Borislav Petkov wrote:
> On Thu, Mar 13, 2025 at 12:26:06PM -0700, Pawan Gupta wrote:
> > Hmm, that would not be straightforward, specially for sysfs status.
> 
> See below:
> 
> - the unknown thing is done only for this vuln and not for the others
> 
> - it doesn't do anything besides reporting things differently - it doesn't
>   apply any mitigations - it is simply causing unnecessary complications which
>   don't bring anything besides maintenance overhead. Unless I'm missing an
>   angle...

"Unknown" status reporting was requested by Andrew Cooper. I am not able to
find that conversation though. IIRC, the reason was out-of-service CPUs
were not tested for the presence of vulnerability. Adding Andrew to Cc.

> - all the currently unaffected CPUs can also be in "unknown" status so why is
>   this special?

Makes sense.

> IOW, just whack the thing.

I will let Andrew comment on this.


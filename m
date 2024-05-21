Return-Path: <linux-kernel+bounces-185207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9465A8CB208
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7E6B22ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC54C1CD3B;
	Tue, 21 May 2024 16:17:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930D4C66
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308257; cv=none; b=AVTfP/slQZOHuLmV0nqVQkwedjCF4YlVhgVqlbMkfsEVZRKB9VQDV0D0yvhexzc0/5Et41BQd152k6XXbokzTGREzAgwem161mDrlz6XEl+s+/mCBvAtzlIuMamo3+oN/34KZFQToBBRnMvf7LhRavO3RB8gYtf2ZAfcMpoPoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308257; c=relaxed/simple;
	bh=Mp+X4n+G4e+9QIapZ3qaEU0CrBdfMJsKLNODW33+ROE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVfg8f4QuYd57ciiFqomo1J4DO7Ka4OujephlGvXnn53Qfgo7AsFYZszVm2ERp3f0fo6ODdKPfErfNlsQ6PwMIMfGgPa8Wq+Yn98TIJzxYnkbBlYWuNAOfTnuD+WlLMA1pJS7daLQunpx6F/e1Sceu6hRyibWNNlvUaC764D6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 2zYdvrMlTIS1fAj8yLSpqA==
X-CSE-MsgGUID: LWCeBn2GTO+fj129Higj0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23652296"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="23652296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:17:21 -0700
X-CSE-ConnectionGUID: FInIGSHkSASZXYn4LNWvgw==
X-CSE-MsgGUID: P/ernt7WR92JzSqFzPwp9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="70387499"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:17:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1s9SAr-00000009i16-3hrV;
	Tue, 21 May 2024 19:17:13 +0300
Date: Tue, 21 May 2024 19:17:13 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, mjguzik@gmail.com,
	patches@lists.linux.dev, peterz@infradead.org,
	rick.p.edgecombe@intel.com, tglx@linutronix.de, trenn@suse.de,
	ubizjak@gmail.com, x86@kernel.org
Subject: Re: [PATCH v6.1 16/49] x86/platform/intel-mid: Switch to new Intel
 CPU model defines
Message-ID: <ZkzJCWIahaYPYwDz@smile.fi.intel.com>
References: <Zkyrtgj7yQR8H-Bz@smile.fi.intel.com>
 <20240521161002.12866-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521161002.12866-1-tony.luck@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 21, 2024 at 09:10:01AM -0700, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> N.B. Drop Haswell. CPU model 0x3C was included by mistake
> in upstream code.

Yep, the result looks good. Dunno if it's better to have a separate patch with
proper Fixes tag. Up to you, folks.

-- 
With Best Regards,
Andy Shevchenko




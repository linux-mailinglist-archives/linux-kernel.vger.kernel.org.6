Return-Path: <linux-kernel+bounces-540114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67586A4ADCD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE251702C1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D1B1E8329;
	Sat,  1 Mar 2025 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6L20/+N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621E1C5F1E;
	Sat,  1 Mar 2025 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740860445; cv=none; b=ukx51Uelk5Kbpckr2Qj2yG/A4UIFWnq66fspRQ7VINtggiTP1FUEtliffQaY5yLYTBaj0qfTJh3r33qO6vObfYz5DvDL669WRC3+yo/6ucTCXx/auCK8pC5hk0Ewj09pmEA33v7IAR6JRuc7OS3miCo5vHOnLhFV0QvqBWYRTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740860445; c=relaxed/simple;
	bh=6vIeTwmtJ1CsQjKzPDtsmgP96gOLvVQrci7HtsL6z3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiOd53XM3ecL53Pmg3wWupQqjJ2DmYI93Pe+C7v1jvwAF9Mj9AHvfhgVWKMdtso4fcjP6x4Vytt5HLI0druOMsmyV9hKEztI5Pa0DKyNWs6v9aEH0+4JhEfA8R9+ka7fST8myKTw3fgDnPHF//ZJ488LTh7lvrfvDoLshA289ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6L20/+N; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740860444; x=1772396444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6vIeTwmtJ1CsQjKzPDtsmgP96gOLvVQrci7HtsL6z3Y=;
  b=M6L20/+NEgqFXplxgBStEtGlRn0zLBobN6yc78EudeE90mNCgHBM9MzZ
   z12FGyPY4sqA++eAy8yiU+ESGef+MbnPQlTdwC3USKCq/OPIHyyOCCr4d
   g3h9Q/5254tdGhm7RUG2/QWRHWaAIioyMKGs7mHqINmMqyLgDQV4LkApl
   Bc4p9ZnTUW30q8XjQWQoupXeJGsqvC/faJ4o8tpWITpvzEQCAEpYg/KiR
   s3YCDg4d/5HwlgWWyy6tAvWDAxaDuyUOGrMY0Jqm/j9OsTAH6TuGHZzPB
   vr2fVqY++ykyEqdVoaNpapl6Sf28GmWk00dhEuZLG0YtSrpcTOT9ilm+2
   w==;
X-CSE-ConnectionGUID: OpK9meZdT6uMTU/z0PlApg==
X-CSE-MsgGUID: cZelTt5tQAiEkk+Fm0yYCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="42018045"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="42018045"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 12:20:44 -0800
X-CSE-ConnectionGUID: 7u6lqpU+RrmQYuAah9RXNg==
X-CSE-MsgGUID: t3rt7YX3TOKeoGdVfb5V+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="122774739"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 01 Mar 2025 12:20:37 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toTK1-000GfL-2p;
	Sat, 01 Mar 2025 20:20:31 +0000
Date: Sun, 2 Mar 2025 04:19:49 +0800
From: kernel test robot <lkp@intel.com>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Woodhouse <dwmw@amazon.co.uk>, Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	NeilBrown <neilb@suse.de>, Zqiang <qiang.zhang1211@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/9] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <202503020344.HCIfRKwM-lkp@intel.com>
References: <20250227221924.265259-4-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227221924.265259-4-lyude@redhat.com>

Hi Lyude,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2014c95afecee3e76ca4a56956a936e23283f05b]

url:    https://github.com/intel-lab-lkp/linux/commits/Lyude-Paul/preempt-Introduce-HARDIRQ_DISABLE_BITS/20250228-062508
base:   2014c95afecee3e76ca4a56956a936e23283f05b
patch link:    https://lore.kernel.org/r/20250227221924.265259-4-lyude%40redhat.com
patch subject: [PATCH v9 3/9] irq & spin_lock: Add counted interrupt disabling/enabling
config: sparc-randconfig-001-20250302 (https://download.01.org/0day-ci/archive/20250302/202503020344.HCIfRKwM-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020344.HCIfRKwM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020344.HCIfRKwM-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/locking/spinlock.c: In function '_raw_spin_lock_irq_disable':
>> kernel/locking/spinlock.c:178:9: error: implicit declaration of function '__raw_spin_lock_irq_disable'; did you mean '_raw_spin_lock_irq_disable'? [-Wimplicit-function-declaration]
     178 |         __raw_spin_lock_irq_disable(lock);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         _raw_spin_lock_irq_disable


vim +178 kernel/locking/spinlock.c

   174	
   175	#ifndef CONFIG_INLINE_SPIN_LOCK_IRQ
   176	noinline void __lockfunc _raw_spin_lock_irq_disable(raw_spinlock_t *lock)
   177	{
 > 178		__raw_spin_lock_irq_disable(lock);
   179	}
   180	EXPORT_SYMBOL_GPL(_raw_spin_lock_irq_disable);
   181	#endif
   182	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-364868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322DF99DA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997201F21E97
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCFA1DB356;
	Mon, 14 Oct 2024 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoXKOOz7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47C1DAC93
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950003; cv=none; b=aeLVyhw5CD1warQZycqq524fHjXA6GHlFvcXQsi2BjWmYoLzoUJg3MkG5jEGY8H1Z/ZSR9zN8S7oY1gbpho0ObFIx0NZN6Aw2La0aP6oIK7Dm0J5mDHeb4+fL44ilmp+13xorobkMrIup8m2CeY4O/g9JvfAe+jP3T/CVDsXszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950003; c=relaxed/simple;
	bh=XerAkngai8u+DuuprsMQt/pVzZ3XZC5gXNaTekETm9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7gaotnvdqJuGIB4sF0tod7AHd0NHrz2cSTV7APyaINiQVWsgyEwiDt2TIAK2CxQCj8WaKdp7lBbbRA8yed6yBfatBR1iSDtv1+T2635V0kb/deTL/nlixc+KjcSy6vvN1UUNPsL+qLcVEzdR5NUGUT4KMbgZcBfb+cT4qP1aoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoXKOOz7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728950002; x=1760486002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XerAkngai8u+DuuprsMQt/pVzZ3XZC5gXNaTekETm9k=;
  b=IoXKOOz7GiDgzxaziZbmwqr+6Lw1vXxIzi148Oa0lOsRTaMyZFMT6bpp
   l5K/TlqPYq7Dsx3LRaqRjEM6KXVJ2hj1dmAjDJV7SoghPLIJ9qEBlhHGD
   pejx1mJlRwFUWTb7cYOXQ5P0xf/cvS9p2GptWzc8W+QyuunY9sSK3NOf4
   jbPVcqyiMF0bZtJCMLxcMxU7OflWfs45GqqTzfu13UwurN6TiQhnSKBse
   3y+lPdrtrKULCkRzr8NZ5+d3XGiQoCcjCtQ97haWLuQk9J4clNGLg8B8Z
   Dt1rVHxQlz67ubG/QSoxjftycRpya3gZWKdtcd7oFwZtwgkHQxLs9Lj8E
   w==;
X-CSE-ConnectionGUID: rl+wC8gXRESiGB1f8hfy0w==
X-CSE-MsgGUID: uqDXdwhgTcGAhC9TVlmFlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28408294"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28408294"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 16:53:21 -0700
X-CSE-ConnectionGUID: 86hYXFeaQmmPgp4Ydmcztw==
X-CSE-MsgGUID: JzPgZJZPQGGQDS1K1Drjrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77590266"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2024 16:53:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0UsB-000HL5-1w;
	Mon, 14 Oct 2024 23:53:11 +0000
Date: Tue, 15 Oct 2024 07:52:49 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,
	Theodore Ts'o <tytso@mit.edu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v20 2/6] security: Add EXEC_RESTRICT_FILE and
 EXEC_DENY_INTERACTIVE securebits
Message-ID: <202410150756.KOkRl5oz-lkp@intel.com>
References: <20241011184422.977903-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011184422.977903-3-mic@digikod.net>

Hi Mickaël,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b]

url:    https://github.com/intel-lab-lkp/linux/commits/Micka-l-Sala-n/exec-Add-a-new-AT_CHECK-flag-to-execveat-2/20241012-024801
base:   8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
patch link:    https://lore.kernel.org/r/20241011184422.977903-3-mic%40digikod.net
patch subject: [PATCH v20 2/6] security: Add EXEC_RESTRICT_FILE and EXEC_DENY_INTERACTIVE securebits
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20241015/202410150756.KOkRl5oz-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241015/202410150756.KOkRl5oz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410150756.KOkRl5oz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from init/init_task.c:2:
   In file included from include/linux/init_task.h:9:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from init/init_task.c:2:
   In file included from include/linux/init_task.h:13:
   In file included from include/linux/securebits.h:5:
>> include/uapi/linux/securebits.h:135:23: warning: '/*' within block comment [-Wcomment]
     135 |  *       (e.g. sh /tmp/*.sh).  This makes sense for (semi-restricted) user
         |                       ^
   2 warnings generated.


vim +135 include/uapi/linux/securebits.h

    97	
    98	#define SECBIT_EXEC_RESTRICT_FILE (issecure_mask(SECURE_EXEC_RESTRICT_FILE))
    99	#define SECBIT_EXEC_RESTRICT_FILE_LOCKED \
   100				(issecure_mask(SECURE_EXEC_RESTRICT_FILE_LOCKED))
   101	
   102	/*
   103	 * When SECBIT_EXEC_DENY_INTERACTIVE is set, a process should never interpret
   104	 * interactive user commands (e.g. scripts).  However, if such commands are
   105	 * passed through a file descriptor (e.g. stdin), its content should be
   106	 * interpreted if a call to execveat(2) with the related file descriptor and
   107	 * the AT_CHECK flag succeed.
   108	 *
   109	 * For instance, script interpreters called with a script snippet as argument
   110	 * should always deny such execution if SECBIT_EXEC_DENY_INTERACTIVE is set.
   111	 *
   112	 * This secure bit may be set by user session managers, service managers,
   113	 * container runtimes, sandboxer tools...  Except for test environments, the
   114	 * related SECBIT_EXEC_DENY_INTERACTIVE_LOCKED bit should also be set.
   115	 *
   116	 * See the SECBIT_EXEC_RESTRICT_FILE documentation.
   117	 *
   118	 * Here is the expected behavior for a script interpreter according to
   119	 * combination of any exec securebits:
   120	 *
   121	 * 1. SECURE_EXEC_RESTRICT_FILE=0 SECURE_EXEC_DENY_INTERACTIVE=0 (default)
   122	 *    Always interpret scripts, and allow arbitrary user commands.
   123	 *    => No threat, everyone and everything is trusted, but we can get ahead of
   124	 *       potential issues thanks to the call to execveat with AT_CHECK which
   125	 *       should always be performed but ignored by the script interpreter.
   126	 *       Indeed, this check is still important to enable systems administrators
   127	 *       to verify requests (e.g. with audit) and prepare for migration to a
   128	 *       secure mode.
   129	 *
   130	 * 2. SECURE_EXEC_RESTRICT_FILE=1 SECURE_EXEC_DENY_INTERACTIVE=0
   131	 *    Deny script interpretation if they are not executable, but allow
   132	 *    arbitrary user commands.
   133	 *    => The threat is (potential) malicious scripts run by trusted (and not
   134	 *       fooled) users.  That can protect against unintended script executions
 > 135	 *       (e.g. sh /tmp/*.sh).  This makes sense for (semi-restricted) user
   136	 *       sessions.
   137	 *
   138	 * 3. SECURE_EXEC_RESTRICT_FILE=0 SECURE_EXEC_DENY_INTERACTIVE=1
   139	 *    Always interpret scripts, but deny arbitrary user commands.
   140	 *    => This use case may be useful for secure services (i.e. without
   141	 *       interactive user session) where scripts' integrity is verified (e.g.
   142	 *       with IMA/EVM or dm-verity/IPE) but where access rights might not be
   143	 *       ready yet.  Indeed, arbitrary interactive commands would be much more
   144	 *       difficult to check.
   145	 *
   146	 * 4. SECURE_EXEC_RESTRICT_FILE=1 SECURE_EXEC_DENY_INTERACTIVE=1
   147	 *    Deny script interpretation if they are not executable, and also deny
   148	 *    any arbitrary user commands.
   149	 *    => The threat is malicious scripts run by untrusted users (but trusted
   150	 *       code).  This makes sense for system services that may only execute
   151	 *       trusted scripts.
   152	 */
   153	#define SECURE_EXEC_DENY_INTERACTIVE		10
   154	#define SECURE_EXEC_DENY_INTERACTIVE_LOCKED	11  /* make bit-10 immutable */
   155	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


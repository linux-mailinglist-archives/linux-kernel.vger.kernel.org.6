Return-Path: <linux-kernel+bounces-309917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435A9671D1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8BC283CEB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34A611CA1;
	Sat, 31 Aug 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYS/RCk2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0086DF6C;
	Sat, 31 Aug 2024 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725110993; cv=none; b=OQyLT/H21eLpJAtwU/8pNQBekzNyG43oCDyUSxt+t5H/fxz8yERBlru2ni9wr4a/tT5jBropCXxjRNLkxBfOblsRhwJfiGHGvfW4EmeEiJjp+zGRdICWiFTHiDmBOm1KBssJn0kx3nlgfPmpzaW0/Fl2W8SNWkp3O0qLgyQzl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725110993; c=relaxed/simple;
	bh=hVOLyxRZbQYfFNcM2qTTz3H4OV0aZePrb4+I5W69coM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad0jO0GIdB9Tx0venLzGJ5v3FKbyQ1VpvvT4nYuIw2OgIjkbjWgofT9tulBYmQfsuxU+zqrPj82FDnsK2kK1zS8q5a3+FrPgfqyFFefRtYRiQTeVHX3pGyI49dfctNtfEukYxC2ZVDS4+8zJqY/efPXBJBLc2VtqVcorCSxljxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYS/RCk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3D8C4CEC0;
	Sat, 31 Aug 2024 13:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725110993;
	bh=hVOLyxRZbQYfFNcM2qTTz3H4OV0aZePrb4+I5W69coM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cYS/RCk299MDpnQ4vLYJUwKSNYXCiwQUj/PsZK9O/SgZOZd8hefrkg8Y8LyuzAh8R
	 lr073grVfqEU8q0CN9/AZA0JBHTeU1miM2wsY/35Dye4T3+OKHd8ltP+Av2/PXWpsy
	 1RCAZmPl5oeoeiyf4Tj2raikjz5HneFZutWqJZZuwvz249th0BbetF215fWXfcOv0L
	 G18ewKAhxpHhwqxrvjnlI5Cei7y8YTvCrdEpx6VQi/qLIS5Ukj/etFFlQvTDxNdvwc
	 0Ev3qA1s02YyD+BWYwGX86x6ybGTWz1r0hMwWEHg+T8noeB7zep7GWstoozxmntyqt
	 0h5NvJ859RQ8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E3735CE0FF5; Sat, 31 Aug 2024 06:29:51 -0700 (PDT)
Date: Sat, 31 Aug 2024 06:29:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2024.08.30a 27/33] include/linux/srcu.h:246:37:
 error: 'SRCU_READ_FLAVOR_NORMAL' undeclared
Message-ID: <287df78c-a528-40ad-afe2-88e6cff88cc5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202408311318.wcMCNEWH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408311318.wcMCNEWH-lkp@intel.com>

On Sat, Aug 31, 2024 at 01:51:05PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.08.30a
> head:   05416eb79213ad6a9770faa795059fdd00adb6e0
> commit: d4401cc54f3e2985675be825f5222aff9764ab8b [27/33] srcu: Convert srcu_data ->srcu_reader_flavor to bit field
> config: m68k-randconfig-r072-20240831 (https://download.01.org/0day-ci/archive/20240831/202408311318.wcMCNEWH-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311318.wcMCNEWH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408311318.wcMCNEWH-lkp@intel.com/

Good catch, thank you!  Does this commit fix the issue for you?

e97f0db697ae ("fixup! srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()"

Please see the end of this message for this in patch form.  I believe
that this will fix the other reports, as well.  (Famous last words!)

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/notifier.h:16,
>                     from include/linux/memory_hotplug.h:7,
>                     from include/linux/mmzone.h:1432,
>                     from include/linux/topology.h:33,
>                     from include/linux/irq.h:19,
>                     from include/asm-generic/hardirq.h:17,
>                     from ./arch/m68k/include/generated/asm/hardirq.h:1,
>                     from include/linux/hardirq.h:11,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/kernel_stat.h:8,
>                     from arch/m68k/kernel/asm-offsets.c:16:
>    include/linux/srcu.h: In function 'srcu_read_lock':
> >> include/linux/srcu.h:246:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
>      246 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/srcu.h:246:37: note: each undeclared identifier is reported only once for each function it appears in
>    include/linux/srcu.h: In function 'srcu_read_lock_nmisafe':
> >> include/linux/srcu.h:267:37: error: 'SRCU_READ_FLAVOR_NMI' undeclared (first use in this function)
>      267 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
>          |                                     ^~~~~~~~~~~~~~~~~~~~
>    include/linux/srcu.h: In function 'srcu_read_lock_notrace':
>    include/linux/srcu.h:279:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
>      279 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/srcu.h: In function 'srcu_down_read':
>    include/linux/srcu.h:308:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
>      308 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/srcu.h: In function 'srcu_read_unlock':
>    include/linux/srcu.h:323:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
>      323 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/srcu.h: In function 'srcu_read_unlock_nmisafe':
>    include/linux/srcu.h:339:37: error: 'SRCU_READ_FLAVOR_NMI' undeclared (first use in this function)
>      339 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
>          |                                     ^~~~~~~~~~~~~~~~~~~~
>    include/linux/srcu.h: In function 'srcu_read_unlock_notrace':
>    include/linux/srcu.h:348:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
>      348 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/srcu.h: In function 'srcu_up_read':
>    include/linux/srcu.h:365:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
>      365 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~
>    make[3]: *** [scripts/Makefile.build:117: arch/m68k/kernel/asm-offsets.s] Error 1
>    make[3]: Target 'prepare' not remade because of errors.
>    make[2]: *** [Makefile:1193: prepare0] Error 2
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:224: __sub-make] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:224: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> 
> vim +/SRCU_READ_FLAVOR_NORMAL +246 include/linux/srcu.h
> 
>    221	
>    222	/**
>    223	 * srcu_read_lock - register a new reader for an SRCU-protected structure.
>    224	 * @ssp: srcu_struct in which to register the new reader.
>    225	 *
>    226	 * Enter an SRCU read-side critical section.  Note that SRCU read-side
>    227	 * critical sections may be nested.  However, it is illegal to
>    228	 * call anything that waits on an SRCU grace period for the same
>    229	 * srcu_struct, whether directly or indirectly.  Please note that
>    230	 * one way to indirectly wait on an SRCU grace period is to acquire
>    231	 * a mutex that is held elsewhere while calling synchronize_srcu() or
>    232	 * synchronize_srcu_expedited().
>    233	 *
>    234	 * The return value from srcu_read_lock() must be passed unaltered
>    235	 * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
>    236	 * the matching srcu_read_unlock() must occur in the same context, for
>    237	 * example, it is illegal to invoke srcu_read_unlock() in an irq handler
>    238	 * if the matching srcu_read_lock() was invoked in process context.  Or,
>    239	 * for that matter to invoke srcu_read_unlock() from one task and the
>    240	 * matching srcu_read_lock() from another.
>    241	 */
>    242	static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
>    243	{
>    244		int retval;
>    245	
>  > 246		srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>    247		retval = __srcu_read_lock(ssp);
>    248		srcu_lock_acquire(&ssp->dep_map);
>    249		return retval;
>    250	}
>    251	
>    252	/**
>    253	 * srcu_read_lock_nmisafe - register a new reader for an SRCU-protected structure.
>    254	 * @ssp: srcu_struct in which to register the new reader.
>    255	 *
>    256	 * Enter an SRCU read-side critical section, but in an NMI-safe manner.
>    257	 * See srcu_read_lock() for more information.
>    258	 *
>    259	 * If srcu_read_lock_nmisafe() is ever used on an srcu_struct structure,
>    260	 * then none of the other flavors may be used, whether before, during,
>    261	 * or after.
>    262	 */
>    263	static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp)
>    264	{
>    265		int retval;
>    266	
>  > 267		srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
>    268		retval = __srcu_read_lock_nmisafe(ssp);
>    269		rcu_try_lock_acquire(&ssp->dep_map);
>    270		return retval;
>    271	}
>    272	

------------------------------------------------------------------------

commit e97f0db697aef503a9363137dcfa7f3dc66573ac
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Aug 30 11:19:28 2024 -0700

    fixup! srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 718c1a17b70a3..4ba96e2cfa405 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -56,8 +56,13 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
 void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
+#ifdef CONFIG_TINY_SRCU
+#define __srcu_read_lock_lite __srcu_read_lock
+#define __srcu_read_unlock_lite __srcu_read_unlock
+#else // #ifdef CONFIG_TINY_SRCU
 int __srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx) __releases(ssp);
+#endif // #else // #ifdef CONFIG_TINY_SRCU
 void synchronize_srcu(struct srcu_struct *ssp);
 
 #define SRCU_GET_STATE_COMPLETED 0x1
@@ -181,7 +186,7 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
 void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 #else
-static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor) { }
+#define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
 #endif
 
 


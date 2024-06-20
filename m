Return-Path: <linux-kernel+bounces-222049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E3A90FC17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1441C230E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A85F2C684;
	Thu, 20 Jun 2024 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL67l15s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC737E;
	Thu, 20 Jun 2024 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718859813; cv=none; b=FtxnZA9bY74Ec926A6yomdB3ElYZcXWmAWjSj637ErOZ3zKHHboUK9octOySPLXrmn+Y9MfhmBjRNCy9CxVDYlQKm4YQ5F3FBYeK/96cb/1iTA6Lk6gj225a5hUvf9aDEzmdTLcSbL6XwDCv6hOIOEx2WmCMnS2z6pIzPGvTs2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718859813; c=relaxed/simple;
	bh=um6EzRG9rDhQ70hgDPX52v6t9bSpMx3cOEYUndWjFL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScyLxT0BXrZ6tsNKjWKESxxV6JTJgLifcobiMlAtLxtUwhLr61OpkHAyW+Kw0EctBPGT1rABHpob7G/BNo5P1K7d9flIA7Q526ongBJlf1QpDPtfay70PHFCbq0eF2rPx9tQBShf7fXd0q2esKenxehQ27yJfq1sHCbR+6321KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL67l15s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFDAC2BD10;
	Thu, 20 Jun 2024 05:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718859812;
	bh=um6EzRG9rDhQ70hgDPX52v6t9bSpMx3cOEYUndWjFL0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JL67l15sZBWcbTDbpNV9MiSZRqIaG79TZUqutfE/7Bjkx4e/5x5vV4kveA+/xvV9S
	 wESqiZ43/u8R5dcMOcMpWhE19HSUgNaig07G+CrOfv+/vIq+cwVu6EpKcTt+LuQ+zd
	 ssPFmpc5ug99NwmLKPlKGlD6IidbhGHTXRcZzGjHcuiKAQT81ofNungDgxtHLGsgty
	 YsKkD+uLq8TQ5LbC5S4DTB1j9dR+ofXp0y+Vq6qsb3blvlQ/hlyJshwuINVvbzY54z
	 P2SKTRkiutnldKng15WtA5u+ir0AvWoy4Ytw56HIIDAeJAj7pknzgzpRsxw9wfHu2u
	 Y6KCLSlo6zE/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5E24DCE0F65; Wed, 19 Jun 2024 22:03:32 -0700 (PDT)
Date: Wed, 19 Jun 2024 22:03:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2024.06.18a 20/34]
 kernel/time/clocksource.c:136:25: error:
 'CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US' undeclared
Message-ID: <0fa70ce4-afa6-42e8-b6ab-e32dcbabb56e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202406201116.d69O9imA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406201116.d69O9imA-lkp@intel.com>

On Thu, Jun 20, 2024 at 11:16:36AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.06.18a
> head:   f29bcafffef0ecc8a5d2cdc1bbef9a6889225263
> commit: 5800c05045dbfeb8c9e571c6b47e8d7dd0d0691d [20/34] clocksource: Take advantage of always-defined CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
> config: arc-randconfig-002-20240620 (https://download.01.org/0day-ci/archive/20240620/202406201116.d69O9imA-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406201116.d69O9imA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406201116.d69O9imA-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/time/clocksource.c: In function '__clocksource_update_freq_scale':
> >> kernel/time/clocksource.c:136:25: error: 'CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US' undeclared (first use in this function)
>      136 | #define MAX_SKEW_USEC   CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/clocksource.c:137:28: note: in expansion of macro 'MAX_SKEW_USEC'
>      137 | #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
>          |                            ^~~~~~~~~~~~~
>    kernel/time/clocksource.c:1167:50: note: in expansion of macro 'WATCHDOG_MAX_SKEW'
>     1167 |                 if (cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW)
>          |                                                  ^~~~~~~~~~~~~~~~~
>    kernel/time/clocksource.c:136:25: note: each undeclared identifier is reported only once for each function it appears in
>      136 | #define MAX_SKEW_USEC   CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/clocksource.c:137:28: note: in expansion of macro 'MAX_SKEW_USEC'
>      137 | #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
>          |                            ^~~~~~~~~~~~~
>    kernel/time/clocksource.c:1167:50: note: in expansion of macro 'WATCHDOG_MAX_SKEW'
>     1167 |                 if (cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW)
>          |                                                  ^~~~~~~~~~~~~~~~~
> 

I have dropped this patch, and thank you for your testing!

								Thanx, Paul

> vim +/CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US +136 kernel/time/clocksource.c
> 
> 2e27e793e280ff1 Paul E. McKenney 2021-05-27  119  
> 2e27e793e280ff1 Paul E. McKenney 2021-05-27  120  /*
> 2e27e793e280ff1 Paul E. McKenney 2021-05-27  121   * Maximum permissible delay between two readouts of the watchdog
> 2e27e793e280ff1 Paul E. McKenney 2021-05-27  122   * clocksource surrounding a read of the clocksource being validated.
> 2e27e793e280ff1 Paul E. McKenney 2021-05-27  123   * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
> 2e27e793e280ff1 Paul E. McKenney 2021-05-27  124   * a lower bound for cs->uncertainty_margin values when registering clocks.
> c37e85c135cead4 Paul E. McKenney 2022-12-06  125   *
> c37e85c135cead4 Paul E. McKenney 2022-12-06  126   * The default of 500 parts per million is based on NTP's limits.
> c37e85c135cead4 Paul E. McKenney 2022-12-06  127   * If a clocksource is good enough for NTP, it is good enough for us!
> ababe5f6bfbf3eb Borislav Petkov  2024-06-12  128   *
> ababe5f6bfbf3eb Borislav Petkov  2024-06-12  129   * In other words, by default, even if a clocksource is extremely
> ababe5f6bfbf3eb Borislav Petkov  2024-06-12  130   * precise (for example, with a sub-nanosecond period), the maximum
> ababe5f6bfbf3eb Borislav Petkov  2024-06-12  131   * permissible skew between the clocksource watchdog and the clocksource
> ababe5f6bfbf3eb Borislav Petkov  2024-06-12  132   * under test is not permitted to go below the 500ppm minimum defined
> ababe5f6bfbf3eb Borislav Petkov  2024-06-12  133   * by MAX_SKEW_USEC.  This 500ppm minimum may be overridden using the
> ababe5f6bfbf3eb Borislav Petkov  2024-06-12  134   * CLOCKSOURCE_WATCHDOG_MAX_SKEW_US Kconfig option.
> 2e27e793e280ff1 Paul E. McKenney 2021-05-27  135   */
> fc153c1c58cb8c3 Waiman Long      2021-12-05 @136  #define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
> fc153c1c58cb8c3 Waiman Long      2021-12-05  137  #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
> 2e27e793e280ff1 Paul E. McKenney 2021-05-27  138  
> 
> :::::: The code at line 136 was first introduced by commit
> :::::: fc153c1c58cb8c3bb3b443b4d7dc3211ff5f65fc clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW
> 
> :::::: TO: Waiman Long <longman@redhat.com>
> :::::: CC: Paul E. McKenney <paulmck@kernel.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


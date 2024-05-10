Return-Path: <linux-kernel+bounces-176128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 249458C2A55
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00291F2491A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7D745C10;
	Fri, 10 May 2024 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AriWi0Pn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E3446A2;
	Fri, 10 May 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368143; cv=none; b=XDQ5N8x3lT1QiA0nbw1r0rE3WQvQJsyhInnfQFIpLQmD3w9hkOOsQrfvvUl9vGH5Riti1+jSJoxgPXawUddPrqmRyMWeSoe7/4DDwP2KzyxKPF5LQBPv7KPrNQI4972LMggi4qbPfeBQvOdEp5HML/g7W7adfYbYMNTVklUKtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368143; c=relaxed/simple;
	bh=4d4FPzlG/14LXvcQZFsMO/vCafAekLxTYuyoBpzdTOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4gdR5zuvkunF1Q07A3apLWEg4U6V9B8LuYAwIXT1q8jNdbpIVkn1bLwtudNVaZ2+dkJhQB0HbL60sfAbyctsh6HZ61kfi/uns4B2bpdwxwx1GZ13n5UFUUZMumndzUwrtGcLK0YTZaOQ7IcYredTBm3R14qskbfMngZVEWDfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AriWi0Pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0287AC113CC;
	Fri, 10 May 2024 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715368143;
	bh=4d4FPzlG/14LXvcQZFsMO/vCafAekLxTYuyoBpzdTOo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AriWi0PnTrc5Rah5N74KFrkWzv+SXY8gX4UJ0cr/IUsjEI/nnSpGgijmK81LvxojS
	 6sFjydisY6H7iCv2nxknyB5JQ5J5S0Co8VHYNYJHd+n0j6JkMMSUtN7QerI+QRTq1g
	 //l9IMJMc0+7JrTZRXNdiGD8u9NYCuWDm1iaXovJduZ5P05e8hhaSdJmw19cPsX/Sr
	 jNsp3GRLh2Me83wxGAUV5zMJG41KqIlKLmRo9LhTW22GgZQ3YvXkRkOVFaXDrszrKr
	 mSepjHl2/0u0k86bX82tJg5P69LFdLqVUHLnDjBgyaeCb/tyr5biDRBqWQ2/h2vmWE
	 28Z0IkWaENCwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9F36CCE094C; Fri, 10 May 2024 12:09:02 -0700 (PDT)
Date: Fri, 10 May 2024 12:09:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: ERROR: modpost: vmlinux: local symbol
 'rcu_set_jiffies_lazy_flush' was exported
Message-ID: <965221ae-620a-497a-9a80-5725e3fe3f7b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202405110230.vcpgN5vz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405110230.vcpgN5vz-lkp@intel.com>

On Sat, May 11, 2024 at 02:53:06AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f4345f05c0dfc73c617e66f3b809edb8ddd41075
> commit: 499d7e7e83d25fcf0fa1a8c0be6857a84cbf6a4a rcu: Rename jiffies_till_flush to jiffies_lazy_flush
> date:   3 months ago
> config: riscv-randconfig-r021-20230817 (https://download.01.org/0day-ci/archive/20240511/202405110230.vcpgN5vz-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405110230.vcpgN5vz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405110230.vcpgN5vz-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: vmlinux: local symbol 'rcu_set_jiffies_lazy_flush' was exported
> >> ERROR: modpost: vmlinux: local symbol 'rcu_get_jiffies_lazy_flush' was exported

These do not look to me to be local:

	void rcu_set_jiffies_lazy_flush(unsigned long jif)
	{
		jiffies_lazy_flush = jif;
	}
	EXPORT_SYMBOL(rcu_set_jiffies_lazy_flush);

	unsigned long rcu_get_jiffies_lazy_flush(void)
	{
		return jiffies_lazy_flush;
	}
	EXPORT_SYMBOL(rcu_get_jiffies_lazy_flush);

What am I missing here?

							Thanx, Paul


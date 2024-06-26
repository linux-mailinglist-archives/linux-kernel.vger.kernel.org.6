Return-Path: <linux-kernel+bounces-230672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB53918049
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D88B221E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7981802B2;
	Wed, 26 Jun 2024 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCw/7D+F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC1F17D37E;
	Wed, 26 Jun 2024 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402893; cv=none; b=bRZCgSMNFpMPEva2MkZTTBokCC2PYU0H6GgzUW+3vss/QWfFVfhtCJ23jTLYI9w3CBIphGTM9zap+k7N3SqjbA8R0c5eumnwLahXxguezg3t6105Xfi7k8xh27LfemeBagoFU84Cm8LyHJbqv5c1UFlDt7WXpEDmMDBd6Qeg+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402893; c=relaxed/simple;
	bh=Z4f5P14gfddhvoGI8bqxaeXaG2n8qogI/Lq5uB6zaFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECDgOlra6dUr30l2w+CcBmCKFtFtAVfG4BjqeTqvCPohbeUj+KuQDBbN8x4YvbS6/sYGTa4dbs8CQg4/CmNIDQ2wZ2WscGJ0+WacsmBHfSq44GrvSwGy6nWAXZfFcqFbkdY9SzluYHgMd9h4XrSnKNp/hmINOWTsI2QWGNnSetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCw/7D+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0699BC2BD10;
	Wed, 26 Jun 2024 11:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719402893;
	bh=Z4f5P14gfddhvoGI8bqxaeXaG2n8qogI/Lq5uB6zaFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCw/7D+FJeMBQGQgAiyUNaW8gT4NJwkSTC7qkbozoZjZjxnrBGUUTuoCmLk05nmy0
	 jyZGh7K/DJzogE/GhCJzNcz1mD6zZWequHuDQTK8KLE/iJBi/3Ft31FozXReiJbqMf
	 kojVpvBQFE/v7H6KxxOYQvo5RjP82WbsvxhHIu4TdwWD9a7ccTdhoZs0eoEUBjqzsk
	 N7cG2lKK705bycGl9KUKG93jetVCbKuKKoaHAtFVe+/YAPaQXafLCiGf1L0l5uQpam
	 g09wLAq7yBA0jmQYJ3tHjUgdm0FGsVefq8qEVnRJ6s41RrEJYK4fuYfFzkRPieIPeS
	 iofZQrp8UGc+w==
Date: Wed, 26 Jun 2024 19:40:48 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:irq/core 41/49] drivers/irqchip/irq-dw-apb-ictl.c:33:25:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before
 'dw_apb_ictl_handle_irq'
Message-ID: <Znv-QA4QM_JLZwo3@xhacker>
References: <202406250214.WZEjWnnU-lkp@intel.com>
 <87v81y6v6d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v81y6v6d.ffs@tglx>

On Mon, Jun 24, 2024 at 08:40:42PM +0200, Thomas Gleixner wrote:
> On Tue, Jun 25 2024 at 02:06, kernel test robot wrote:
> > Hi Jisheng,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> > head:   f2605e1715dd28e8943b557453fed3a40421d3b5
> > commit: 7cc4f309c933ec5d64eea31066fe86bbf9e48819 [41/49] irqchip/dw-apb-ictl: Support building as module
> > config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240625/202406250214.WZEjWnnU-lkp@intel.com/config)
> > compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240625/202406250214.WZEjWnnU-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202406250214.WZEjWnnU-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >>> drivers/irqchip/irq-dw-apb-ictl.c:33:25: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'dw_apb_ictl_handle_irq'
> >       33 | static void __irq_entry dw_apb_ictl_handle_irq(struct pt_regs *regs)
> >          |                         ^~~~~~~~~~~~~~~~~~~~~~
> 
> That's because the drivers is now selectable via Kconfig, so
> allmodconfig sets it to M and builds it which does not work on a x86
> build unsurprisingly.

Yes, I didn't take care this.

> 
> Jisheng, please send a delta fix ASAP. Otherwise I have to revert it.

I missed it. I will send a v2. Even if it's too late, it can be picked
up in next development window.


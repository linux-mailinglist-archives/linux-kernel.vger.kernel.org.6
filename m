Return-Path: <linux-kernel+bounces-321942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C859721B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926D31C226D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4201891C7;
	Mon,  9 Sep 2024 18:13:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33B188CC1;
	Mon,  9 Sep 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905601; cv=none; b=NaWGLBImetbOfQxN4JzgJ+C+MTJcYH9o5SME12+stk+Ffnl5RThMn/quSVM95kCSB8HoRblnz+NENup36qxkvzqSZglpUZG+GKS91t8Btzd4x10aCmqXPGIR/KLdvLrdzXxab+V7qzo8/AQWErbHs3SAGudxJl0yBQ6xn/3XmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905601; c=relaxed/simple;
	bh=cjChyxikLoCWWFepuL/NLO2G96k6sIj8Hqa8RXTNUbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeRKwQU7wQSDZaapQZbdE+EuuPXHnywdU4myeFIi7jPab2vHoySdaGw0pHokJHKdZsWjTPLB1bhH1UFEHp7EV+I1DCf+qOyK8P/UZFipOBNE1xvlQLmId9qY1rLRa5zvEhwZ47FWiH3TIdLWoBTFPEoITlRDbKK1h6xPhv31c7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B97C4CEC5;
	Mon,  9 Sep 2024 18:13:20 +0000 (UTC)
Date: Mon, 9 Sep 2024 14:13:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: ERROR: start_text address is c000000000000700, should be
 c000000000000200
Message-ID: <20240909141319.0cd59cef@gandalf.local.home>
In-Reply-To: <202409100106.A8692079-lkp@intel.com>
References: <202409100106.A8692079-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 02:05:29 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   da3ea35007d0af457a0afc87e84fddaebc4e0b63
> commit: 6e2fdceffdc6bd7b8ba314a1d1b976721533c8f9 tracing: Use refcount for trace_event_file reference counter
> date:   5 weeks ago
> config: powerpc64-randconfig-003-20240908 (https://download.01.org/0day-ci/archive/20240910/202409100106.A8692079-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100106.A8692079-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409100106.A8692079-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: start_text address is c000000000000700, should be c000000000000200  
>    ERROR: try to enable LD_HEAD_STUB_CATCH config option
>    ERROR: see comments in arch/powerpc/tools/head_check.sh
> 

How is the associated commit anywhere close to being the cause of this bug?

-- Steve


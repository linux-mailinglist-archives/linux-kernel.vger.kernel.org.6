Return-Path: <linux-kernel+bounces-567385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C621A68556
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B00C189F2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECFD24EF6A;
	Wed, 19 Mar 2025 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0jNYPkH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5824E4CB;
	Wed, 19 Mar 2025 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367484; cv=none; b=BpK6rYjCp6udoF1LNIo0eq9CW70KEZSjTAAcGCg3ltuHWBPhqBOC30ZVdGyBaVQnWN0TjgOiiUL642XMTRpYDQJKT6peXdw175eeKgegAWkz+/Tmm8mEDWNhDS4nj6eSy28eKk7tAOLNf6GQKxRMZdNzBvHNuxo1B978LTJZkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367484; c=relaxed/simple;
	bh=+LoVCkol41SOi+76en0yBf4ct41zyO59XLM32BPVIwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS3m/UTmGwTNFCQ5px6x8AvXbf8lI04/1J7moB/yx/SJZ6JQagE43yjE/3FCvIwPCkLY1hhahdQCkdtfqIu0gHrz/2iVDimdoHaazaKcR75qvUF7JomY7Bw6tglzNMCFUwQMSGgaURugf3ap47uRvVD0wzmgCr5uNx38GxRkihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0jNYPkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63210C4CEED;
	Wed, 19 Mar 2025 06:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742367483;
	bh=+LoVCkol41SOi+76en0yBf4ct41zyO59XLM32BPVIwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0jNYPkHcsRWTIN1hcM0J0aF1Dakt/IFZdUxuFl8SQceQc6nMhqCUMQX4d53zWW9+
	 MRWQ8PBDsXtqHfneRwLDdsljYqhpyiFyUlmE8cd/1P6SEUd+zL0q+RsUraSSzaAuzf
	 Yo22OjiM1ulriWM8S1NlnZE8G3Tea68sDwC6MURY9gor+KD+cEWPAFgi3HYlWAjcdq
	 tTszItP4MfQI42Mcjl0YgBxxDzu5+93iLG3iClJ6IDsLsRpH4KBJmji5kgMBHrESgm
	 iAlEImKVp8uD8NjlLKWXSZG6jXpT0b/C0NIEOqXKFII4gBmUVvhv2nZwAhQA04cC+/
	 +LoBAFi2zoizw==
Date: Tue, 18 Mar 2025 23:58:00 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: vmlinux.o: warning: objtool: snd_rme96_capture_getrate+0x84:
 return with modified stack frame
Message-ID: <lmqrapilznvh5eb77umjvcbfu6sakjnwxxv4ksdkhykf7pavtm@rhe42usyouz7>
References: <202503171547.LlCTJLQL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202503171547.LlCTJLQL-lkp@intel.com>

On Mon, Mar 17, 2025 at 03:36:46PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4701f33a10702d5fc577c32434eb62adde0a1ae1
> commit: 3724062ca2b1364f02cf44dbea1a552227844ad1 objtool: Ignore dangling jump table entries
> date:   5 weeks ago
> config: x86_64-randconfig-r051-20250316 (https://download.01.org/0day-ci/archive/20250317/202503171547.LlCTJLQL-lkp@intel.com/config)
> compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250317/202503171547.LlCTJLQL-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503171547.LlCTJLQL-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

LTO+UBSAN fun.

>    vmlinux.o: warning: objtool: SiS_GetCRT2Ptr+0x1ad: stack state mismatch: cfa1=4+8 cfa2=5+16
>    vmlinux.o: warning: objtool: .text.nvmet_ctrl_state_show: unexpected end of section
>    vmlinux.o: warning: objtool: .text.cyapa_update_fw_store: unexpected end of section

I have fixes for these, will post soon.

>    vmlinux.o: warning: objtool: ___bpf_prog_run+0x1f: sibling call from callable instruction with modified stack frame
> >> vmlinux.o: warning: objtool: snd_rme96_capture_getrate+0x84: return with modified stack frame
> >> vmlinux.o: warning: objtool: .text.wcd934x_slim_irq_handler: unexpected end of section

Haven't been able to recreate these yet, will try clang 20.

-- 
Josh


Return-Path: <linux-kernel+bounces-189308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A08CEE3B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E55F1C20B77
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 08:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742A171CC;
	Sat, 25 May 2024 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g5WYrvgx"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A411CA0
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716625931; cv=none; b=jaG5byhkQZ0uM9g1PiUwuOdFXCKYbnrDVkMXKpMVlD0pNHsj16F9by500do7/ZGw+215HoTgdj5uwd+Ny4ISe2uhFMoNByj9emHCq5Xhi4sx3Izvt06o2YRdy6TJAGxvvONp9KkQgcjmHlpCnpjGziuj9IxSVXM4OzOrRNT+t7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716625931; c=relaxed/simple;
	bh=hcw5pZWbSFXCHqThJ5IaouqprfaR9MI2ld8Q2uaN7hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOienBnQrPdwXNpZFSwKAhEuChfvnVTxTSuBCQHjaC3TGfbOiw9k5oBdNYtSX+XRhrBpMwu6nNOZPMqw+xDiHzO3FCssszYL8rU2OhecBz/GrRzxve3ZozCbvubHaTuC11nZAVEcD+snpFebKZsYTehfGcGSHhTAcIDgNzDHqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g5WYrvgx; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: philip.li@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716625926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVOKLNS5bleQgasiPS65AwbAWNrFEBXBiff/dOJcxsA=;
	b=g5WYrvgxAdCRVnihnye7dwKpP4H4j5ijmCmn+yDsxUgUSzSw3b06zXKhmTSo9IWISHtTbY
	D5u2271kk1AMEGEYABf7YKksCoZHM05dnUUghqItj+iHYz64cXnvDtQJee9OJaTgBvc/Lq
	Yw6t3qv81guqUwbx8/LUlaT3z6UkhUo=
X-Envelope-To: lkp@intel.com
X-Envelope-To: surenb@google.com
X-Envelope-To: oe-kbuild-all@lists.linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
Date: Sat, 25 May 2024 04:32:03 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>, 
	Suren Baghdasaryan <surenb@google.com>, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: include/asm-generic/percpu.h:31:40: error: implicit declaration
 of function 'raw_smp_processor_id'
Message-ID: <2b5jetp5exc7jwjqhdvwnrttp3b7gge4pqq6jjvjc7aj6zzqtk@5aghxx2x4u6q>
References: <202405210052.DIrMXJNz-lkp@intel.com>
 <d5ldg2u6kqgpiv7p42al7yp7zn2bpd3qrwmv76ccmzbvw5ag6x@enbx3xdtry4s>
 <ZlGcfHD3ZCNKWDdr@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlGcfHD3ZCNKWDdr@rli9-mobl>
X-Migadu-Flow: FLOW_OUT

On Sat, May 25, 2024 at 04:08:28PM +0800, Philip Li wrote:
> On Fri, May 24, 2024 at 11:58:30AM -0400, Kent Overstreet wrote:
> > On Tue, May 21, 2024 at 12:31:18AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   eb6a9339efeb6f3d2b5c86fdf2382cdc293eca2c
> > > commit: 24e44cc22aa3112082f2ee23137d048c73ca96d5 mm: percpu: enable per-cpu allocation tagging
> > > date:   4 weeks ago
> > > config: mips-randconfig-r133-20240520 (https://download.01.org/0day-ci/archive/20240521/202405210052.DIrMXJNz-lkp@intel.com/config)
> > > compiler: mips-linux-gcc (GCC) 13.2.0
> > > reproduce: (https://download.01.org/0day-ci/archive/20240521/202405210052.DIrMXJNz-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202405210052.DIrMXJNz-lkp@intel.com/
> > 
> > I have a fix I'm testing for this but it's going to need a lot of
> > randconfig build testing on all archs.
> > 
> > Philip, could 0day help out with that? I don't know how you schedule
> 
> Got it, we will cover this branch with randconfig build tests.
> 
> > which branches for which testing, and previously the memory allocation
> > profiling didn't get enough build testing before Andrew merged it.
> 
> Sorry about this, we really need extend the test number to generate
> more randconfigs.

It was getting caught by 0day in Andrew's tree, I think it may have just
been a timing thing. This is (one of the reasons) why I'm hoping to get
you a dashboard (and maybe get some test infrastructure consolidation
going, too) - right now I just have no way of knowing how long the
randconfig tests take or when they're finished.


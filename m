Return-Path: <linux-kernel+bounces-274112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12818947383
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0777B20BC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027B13C820;
	Mon,  5 Aug 2024 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VG5JVEME"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADE1FA1;
	Mon,  5 Aug 2024 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826845; cv=none; b=Pe5HEu5rDFj9USGl79wa4u1IYNvsW/Ai3SA4W91EWlHMdU1Df92wZUHLURCLDjD0xfwL+JFdNa/eGdDdBNWXxzDuzqUlEu8jlq6oZpDUHugSWwtwT96eTKHXnS0SBQu06FZ+w3Ky8PRvN5lbTTsKCC45XjUEqlk5i7eUJirPSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826845; c=relaxed/simple;
	bh=5WOwwX41bg9jUkw5aLZTaElQmfmRJJ1nHSdt7Fih1t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW4dusYbmEfam3MXM99iKkwvSheAp6Jm1LKKb6pDKywAvRIjHIaOIdSvWKDxBiWcX5ii+iwsXM/NUbcXupWniiVXn/CTBf5zcJ+1Y+3i9MnUn10Rm8UD5B/QXzkJnYVA79exScWvjLooLA9OgQNW2tOYBYf6sgONIAjew9ASfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VG5JVEME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C0DC32786;
	Mon,  5 Aug 2024 03:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722826845;
	bh=5WOwwX41bg9jUkw5aLZTaElQmfmRJJ1nHSdt7Fih1t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VG5JVEMEhpbFp9IzTJAGC3a4brcKHXUrZehXzrWK76ry1PadAU3HsbPc0AdSsoVW2
	 Hm7ErmVB12JoQRHm/uex4Jep+F7IGUDxr2qAmOyYJx4QNY2QHiqPrs7YbqCwkbnUqV
	 nTNtlJujikH7p59/D9jU4ERTjQNBsTCAUHJoENuj7hscxaCQEy2C2pQAh2GnoUWUto
	 MJ7Xl5Ff1w724pdydZr3JS9m4vifG3ZzjgxO7ZCMOygy9zax0qZA5buljT9Fx3eNj6
	 klPVftONJs7rff4AtPP0iY/aKZYJVYWCKoyOE0H+5pmVN0R5EdebEpvgazy6a4BMP0
	 bfexZQX58RKMw==
Date: Sun, 4 Aug 2024 20:00:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Gow <davidgow@google.com>
Subject: Re: ERROR: modpost: "__popcountdi2"
 [lib/kunit/kunit-example-test.ko] undefined!
Message-ID: <20240805030043.GA3417507@thelio-3990X>
References: <202408041932.EzITeEV4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408041932.EzITeEV4-lkp@intel.com>

On Sun, Aug 04, 2024 at 07:13:11PM +0800, kernel test robot wrote:
> Hi Michal,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   17712b7ea0756799635ba159cc773082230ed028
> commit: ee5f8cc2770b2f0f7cfefb5bf7534e2859e39485 kunit: Reset test status on each param iteration
> date:   11 months ago
> config: riscv-randconfig-001-20240804 (https://download.01.org/0day-ci/archive/20240804/202408041932.EzITeEV4-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240804/202408041932.EzITeEV4-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408041932.EzITeEV4-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
...
> >> ERROR: modpost: "__popcountdi2" [lib/kunit/kunit-example-test.ko] undefined!
> ERROR: modpost: "__popcountdi2" [lib/test_hexdump.ko] undefined!

Sorry for the noise, this appears to be a regression with tip of tree
LLVM:

https://github.com/llvm/llvm-project/pull/101786#issuecomment-2268077506

Cheers,
Nathan


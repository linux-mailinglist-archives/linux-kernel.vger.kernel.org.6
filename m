Return-Path: <linux-kernel+bounces-299855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647FB95DB07
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 05:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891781C216BE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B5D29CEB;
	Sat, 24 Aug 2024 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seNG/zyH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F9EEB1;
	Sat, 24 Aug 2024 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724470348; cv=none; b=rK9vsbP/vDbAP8/TJIAQc1T2/UUB0BvKuOi7dm4umZWXuRff/jlS2MNOZ09cI9ELFMD9GC2DqFqF1aB5M+MjFtHdkvZnzq6YPsMwVnDvqZh/TgljnalCku3csJxWMyu142A7beJJNl/DU2d09L1er5wEdmlGKpOzuc9dYTWgbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724470348; c=relaxed/simple;
	bh=P8OUrwb6qdsilJULGUiZLBTPqjy8rYsIhHeRsrhKmtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr/NCdLdap+KujQZeTbAchZc/MOI4I/ZwDjkh0hiiX7UGJTWNiiZojKzorhpp4gCLB8lm3Oys9Hy0/o9i/J1jxbtifyb+MAk2olwX2hVXawLKu+dqNnzPYY+6KmqjvlHDwEPKHXj5q3miQ6ZfGf1CzoqaaG8gxKezaz8O7H8vzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seNG/zyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5C9C32781;
	Sat, 24 Aug 2024 03:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724470347;
	bh=P8OUrwb6qdsilJULGUiZLBTPqjy8rYsIhHeRsrhKmtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seNG/zyHkwLlNy6gAqv5YoyT/jmcl4EWfrqmtg3EXXF+g/0+1sfEo6ZX0Dbb9kNSH
	 MVq5APyc2zZVosqb0+/w6hDA6YeAun9SNGPT+fzd3DjvDN2q6OvLzGBQH+DgH89b1y
	 0T1tkKkjupRnt582sH2AZwRuwN58LJ2FFq4DM/okGCtpjuhRTuPvlBKVcf3Ff6oyCA
	 AvCIOaFJGr/dN08RBUdILpe8EvuDM5AbPrEi2WNbE1QYFeoePJXltobrfCu1ejTKll
	 o6KkOcIIi4GhMlPFJIwHkKhj+3lwL7JpTk5HQAJvP2Jd+AW28Zw3Tb3jqlZtTUi2ti
	 lPbAMTOrPhvuQ==
Date: Fri, 23 Aug 2024 20:32:25 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Yuntao Liu <liuyuntao12@huawei.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 imx7d_enet_init+0x18 (section: .text.unlikely.imx7d_enet_init) ->
 imx7d_enet_clk_sel (section: .init.text)
Message-ID: <20240824033225.GB1733394@thelio-3990X>
References: <202408232129.sx7nsk3e-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408232129.sx7nsk3e-lkp@intel.com>

On Fri, Aug 23, 2024 at 09:56:36PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3d5f968a177d468cd13568ef901c5be84d83d32b
> commit: ed0f941022515ff40473ea5335769a5dc2524a3f ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> date:   2 months ago
> config: arm-randconfig-002-20240823 (https://download.01.org/0day-ci/archive/20240823/202408232129.sx7nsk3e-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240823/202408232129.sx7nsk3e-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408232129.sx7nsk3e-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> >> WARNING: modpost: vmlinux: section mismatch in reference: imx7d_enet_init+0x18 (section: .text.unlikely.imx7d_enet_init) -> imx7d_enet_clk_sel (section: .init.text)

This is caused by a recent LLVM change, I sent
https://lore.kernel.org/r/20240822-imx7d-mark-imx7d_enet_init-as-init-v1-1-8dfadee3bed4@kernel.org
for it.

Cheers,
Nathan


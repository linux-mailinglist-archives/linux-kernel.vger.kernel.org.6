Return-Path: <linux-kernel+bounces-341723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE239988449
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9201F1F22BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B3C18C358;
	Fri, 27 Sep 2024 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbRBYys+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF418C00D;
	Fri, 27 Sep 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439955; cv=none; b=Enax4uVHVsf6rFq/fazDNvK7BHGSb1HBUwb9N6OZdDzabGiVyoOHHtz7nb5LsjkjOhvpoAytIc2rBNHaspaaDOJKBZ8BGwo4BrJYfce9KeGxVvbItGuc6aHO2zv8B8xEyDcDF5PGOUVdNur1CujJjjFzviIkf1NMi48KDFrLWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439955; c=relaxed/simple;
	bh=IQf9GUnWrj7+PD8nWtxubTalVQMxM3Gh3fWaK1K4aKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uARO5DokuGTx4nKnYnMmrp5g9s5j5DAwC5TmjIxQkHhz+23FDahPXzoIcfPZGk1rieNmkmbD+0Qsuc/wE2KF2dHhOcgYS9DBlfSLxI+xXQJb1brrdVZdQBkxLE3h/Avi9dUAIc5Hn1nCtQSt1le0nPT58TgDQqXCvwnPmF6fWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbRBYys+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ADEC4CEC4;
	Fri, 27 Sep 2024 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727439955;
	bh=IQf9GUnWrj7+PD8nWtxubTalVQMxM3Gh3fWaK1K4aKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbRBYys+o8twWjQhq8cBIHOMgwv68ngMeqpInSUPLAZNICRksymA5v25mH3ywtKag
	 LUD3Epw8F3ml+mxIKCPhkfSDdv0QBgorZOrMoSQMJJ2vyy4bOkiyfxw09yFbytU30k
	 6sBMiQLnq7YpaDzy4KlzykpPHkLmRLNbvCWbZCSduhOiMdE8ZpEyL0uweIGZDnLIi3
	 E0iL9LBkFPQGfA4ZEqZN5Icr3CBKn3TjkixFZL3RRdeQQtD0kbNoRYc03i9Em0PAuk
	 lFDOeke+8Im6huNjeFUhlY1YMCCYTGQJaTHj+erlgyHN/turASHCMRjixyz45M7HZu
	 imM8QDrhN88+g==
Date: Fri, 27 Sep 2024 05:25:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: ld.lld: error: unknown argument '--ppc476-workaround'
Message-ID: <20240927122553.GA908795@thelio-3990X>
References: <202409251512.QHl7WqZN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409251512.QHl7WqZN-lkp@intel.com>

On Wed, Sep 25, 2024 at 03:54:20PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   684a64bf32b6e488004e0ad7f0d7e922798f65b6
> commit: e3a9ee963ad8ba677ca925149812c5932b49af69 kbuild: Fix changing ELF file type for output of gen_btf for big endian
> date:   7 months ago
> config: powerpc-randconfig-002-20240925 (https://download.01.org/0day-ci/archive/20240925/202409251512.QHl7WqZN-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409251512.QHl7WqZN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409251512.QHl7WqZN-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: unknown argument '--ppc476-workaround'

I supppose LLD does not have this workaround flag. Perhaps this could be
encoded in Kconfig to avoid this?

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 35a1f4b9f827..3c6c7c774d89 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -301,6 +301,7 @@ config APM821xx
 
 config 476FPE_ERR46
 	depends on 476FPE
+	depends on $(ld-option,--ppc476-workaround)
 	bool "Enable linker work around for PPC476FPE errata #46"
 	help
 	  This option enables a work around for an icache bug on 476


Return-Path: <linux-kernel+bounces-335796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E197EADD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176A91F22302
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8169A78C93;
	Mon, 23 Sep 2024 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o7uGGs9l"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184B1EEE6
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091503; cv=none; b=NQV31ycXA/HscLhWpwUhsugOaxBt0gu31LeE7kOY652lMoXpLoIHYnfyuDpLhPc7tnNM2s/fEq9i8KvZbkriZzkAVRsho5k4bHhBiBe0C1sFUzPSiCwjnase6H7Mn6PUwrDoLmw1tDhszgtUzx/2nHcZEvUQ2vgZraQDAc7ggWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091503; c=relaxed/simple;
	bh=YAiSWhUrR5JiO5lE7ztvPXTh44kgCnezoatX9mIcItQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtV92OlUpFp7uPeVBZB+sX4z9+Rxc0qLxDZWbMz7VE9GBal0Ek8BPidVYr2aRyvusLffLinTxClVishXZNU0OFaJsw80cC9wJ/OGTKVwe6zd7Qyj/yk1yk9+DD0WHziVDrTIyxAZRcxD97o/XcEEOSJwZ3npManka1cYtAoOm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o7uGGs9l; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78EB2E0003;
	Mon, 23 Sep 2024 11:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727091499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRKDM+ERUy1fSPEQ1Q6yO9Gip+sAL3A0aurt/1j4xGQ=;
	b=o7uGGs9lpH6VLWwwk7hGi1ntl6GKyYUpWlRW6wk+CjI0XAFwTaO2uph14Va5rzSjp7B4Z6
	4oD9vF9aVltKHYDLbtruUsTOoG+1U1ul3CUiY85lCBGdQb4bzdDaSAeqDGjkHpGR7q8tqg
	H36/BKoesVY9laJS8sc7a5GKv8TpJWkL37Ep08tdN3MyxmwZdgHfGBFQU+20BwrRGD/H2j
	wlfchnbjJ6nw2i3aQ7QjAiBugsHLsut+750suFyEK/49O2mBJwXGFJanLbIXOfK8g4H6Ut
	WKXGz5mRUweAvR9/j0f9Ev2ieu4kSAqas5CD8gTJxucpUUu+6bKsTNX8MkCtuQ==
Date: Mon, 23 Sep 2024 13:38:18 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>
Subject: Re: drivers/soc/fsl/qe/qmc.c:2002:30: warning: unused variable
 'qmc_data_qe'
Message-ID: <20240923133818.03cc9327@bootlin.com>
In-Reply-To: <202409231229.EFlvN9m0-lkp@intel.com>
References: <202409231229.EFlvN9m0-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

On Mon, 23 Sep 2024 12:53:23 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   de5cb0dcb74c294ec527eddfe5094acfdb21ff21
> commit: eb680d563089e55b20cb7730ed881638fe4425b7 soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementation
> date:   3 weeks ago
> config: powerpc-randconfig-r054-20240923 (https://download.01.org/0day-ci/archive/20240923/202409231229.EFlvN9m0-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409231229.EFlvN9m0-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409231229.EFlvN9m0-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/soc/fsl/qe/qmc.c:12:
>    In file included from include/linux/dma-mapping.h:11:
>    In file included from include/linux/scatterlist.h:8:
>    In file included from include/linux/mm.h:2228:
>    include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
> >> drivers/soc/fsl/qe/qmc.c:2002:30: warning: unused variable 'qmc_data_qe' [-Wunused-const-variable]  
>     2002 | static const struct qmc_data qmc_data_qe = {
>          |                              ^~~~~~~~~~~
>    2 warnings generated.
> 
> 
> vim +/qmc_data_qe +2002 drivers/soc/fsl/qe/qmc.c
> 
>   2001	
> > 2002	static const struct qmc_data qmc_data_qe = {  
>   2003		.version = QMC_QE,
>   2004		.tstate = 0x30000000,
>   2005		.rstate = 0x30000000,
>   2006		.zistate = 0x00000200,
>   2007		.zdstate_hdlc = 0x80FFFFE0,
>   2008		.zdstate_transp = 0x003FFFE2,
>   2009		.rpack = 0x80000000,
>   2010	};
>   2011	
> 

This issue has been already detected:
  https://lore.kernel.org/oe-kbuild-all/202409071707.ou2KFNKO-lkp@intel.com/
and a patch has been already sent to fix it:
  https://lore.kernel.org/lkml/20240909121129.57067-1-herve.codina@bootlin.com/

Best regards,
Hervé


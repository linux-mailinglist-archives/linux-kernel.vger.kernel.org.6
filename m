Return-Path: <linux-kernel+bounces-168963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63108BC038
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265511F216E0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F4171A5;
	Sun,  5 May 2024 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="OuGIFNRH"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E2111A8
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714907885; cv=none; b=Aull+9UUWwkYuydRG159bbwATrvFH6rfbAC3DcQtA4ujFbPK3a6mHmNopHiF36gFb73MqYhkkdpTTiU4shTzSj2fdsMQzRKBCuYf96qg5Udbyit3xKPK1x8ZWvW6t8+RroJi4sNueSL0cLdNTT3KHXQW254+po3udVqCMP7adIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714907885; c=relaxed/simple;
	bh=ru7fMimQdej2rZlpz1llHVTGQwDFG6DuHrBFcI9/v7g=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=RTfkj8ggyrdgjwlCZ2sQuSvfNekdGG7ebwRjoyTEhHeeaX/+3j61dpYxlLd/Y6xSDgMkq0VAE5r1x4DF7+8v6Uyn9TgJnrOkz48cxm+fXuI6tSU9F+XTJzdPlyBHwcHjYi1uPWXIirQwwyoFh6qYKDFjkhAiuj/iVBnLHwYAYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=OuGIFNRH; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yZOSHiPoDXg5BRuJhBvEzO5qE3MrmYzEHwcoLAo9s4s=;
  b=OuGIFNRHPgF5RalHmd3KO4xsmAfZlMdLa8ltCv3pTAzCrYz5Wv95uTvm
   BScMftIndrE1QWY9b54luXrz4pQqAiP4+phHv5CaMvuDaS6F/1owZCFnz
   2cSiRx3fCiXmXmZH1P6DcA10oPpzL07WjUHBO8gew5aPcY/2XtuL1XU6e
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,256,1708383600"; 
   d="scan'208";a="164543578"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 13:17:59 +0200
Date: Sun, 5 May 2024 13:17:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Lucas De Marchi <lucas.demarchi@intel.com>
cc: Matt Roper <matthew.d.roper@intel.com>, linux-kernel@vger.kernel.org, 
    oe-kbuild-all@lists.linux.dev
Subject: drivers/gpu/drm/xe/xe_guc_ads.c:103:21-27: WARNING use flexible-array
 member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
 (fwd)
Message-ID: <alpine.DEB.2.22.394.2405051317090.3397@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Can a flexible array be used at the end of this structure?

julia

---------- Forwarded message ----------
Date: Sun, 5 May 2024 19:06:22 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/gpu/drm/xe/xe_guc_ads.c:103:21-27: WARNING use flexible-array
    member instead
    (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-
    and-one-element-arrays)

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Matt Roper <matthew.d.roper@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7367539ad4b0f8f9b396baf02110962333719a48
commit: 237412e45390805e14a6936fb998d756c4eac9d8 drm/xe: Enable 32bits build
date:   3 months ago
:::::: branch date: 2 days ago
:::::: commit date: 3 months ago
config: i386-randconfig-054-20240505 (https://download.01.org/0day-ci/archive/20240505/202405051824.AmjAI5Pg-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202405051824.AmjAI5Pg-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/xe/xe_guc_ads.c:103:21-27: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

vim +103 drivers/gpu/drm/xe/xe_guc_ads.c

dd08ebf6c3525a Matthew Brost 2023-03-30   53
dd08ebf6c3525a Matthew Brost 2023-03-30   54  /*
dd08ebf6c3525a Matthew Brost 2023-03-30   55   * The Additional Data Struct (ADS) has pointers for different buffers used by
dd08ebf6c3525a Matthew Brost 2023-03-30   56   * the GuC. One single gem object contains the ADS struct itself (guc_ads) and
dd08ebf6c3525a Matthew Brost 2023-03-30   57   * all the extra buffers indirectly linked via the ADS struct's entries.
dd08ebf6c3525a Matthew Brost 2023-03-30   58   *
dd08ebf6c3525a Matthew Brost 2023-03-30   59   * Layout of the ADS blob allocated for the GuC:
dd08ebf6c3525a Matthew Brost 2023-03-30   60   *
dd08ebf6c3525a Matthew Brost 2023-03-30   61   *      +---------------------------------------+ <== base
dd08ebf6c3525a Matthew Brost 2023-03-30   62   *      | guc_ads                               |
dd08ebf6c3525a Matthew Brost 2023-03-30   63   *      +---------------------------------------+
dd08ebf6c3525a Matthew Brost 2023-03-30   64   *      | guc_policies                          |
dd08ebf6c3525a Matthew Brost 2023-03-30   65   *      +---------------------------------------+
dd08ebf6c3525a Matthew Brost 2023-03-30   66   *      | guc_gt_system_info                    |
dd08ebf6c3525a Matthew Brost 2023-03-30   67   *      +---------------------------------------+
dd08ebf6c3525a Matthew Brost 2023-03-30   68   *      | guc_engine_usage                      |
dd08ebf6c3525a Matthew Brost 2023-03-30   69   *      +---------------------------------------+
dd08ebf6c3525a Matthew Brost 2023-03-30   70   *      | guc_um_init_params                    |
dd08ebf6c3525a Matthew Brost 2023-03-30   71   *      +---------------------------------------+ <== static
dd08ebf6c3525a Matthew Brost 2023-03-30   72   *      | guc_mmio_reg[countA] (engine 0.0)     |
dd08ebf6c3525a Matthew Brost 2023-03-30   73   *      | guc_mmio_reg[countB] (engine 0.1)     |
dd08ebf6c3525a Matthew Brost 2023-03-30   74   *      | guc_mmio_reg[countC] (engine 1.0)     |
dd08ebf6c3525a Matthew Brost 2023-03-30   75   *      |   ...                                 |
dd08ebf6c3525a Matthew Brost 2023-03-30   76   *      +---------------------------------------+ <== dynamic
dd08ebf6c3525a Matthew Brost 2023-03-30   77   *      | padding                               |
dd08ebf6c3525a Matthew Brost 2023-03-30   78   *      +---------------------------------------+ <== 4K aligned
dd08ebf6c3525a Matthew Brost 2023-03-30   79   *      | golden contexts                       |
dd08ebf6c3525a Matthew Brost 2023-03-30   80   *      +---------------------------------------+
dd08ebf6c3525a Matthew Brost 2023-03-30   81   *      | padding                               |
dd08ebf6c3525a Matthew Brost 2023-03-30   82   *      +---------------------------------------+ <== 4K aligned
dd08ebf6c3525a Matthew Brost 2023-03-30   83   *      | capture lists                         |
dd08ebf6c3525a Matthew Brost 2023-03-30   84   *      +---------------------------------------+
dd08ebf6c3525a Matthew Brost 2023-03-30   85   *      | padding                               |
dd08ebf6c3525a Matthew Brost 2023-03-30   86   *      +---------------------------------------+ <== 4K aligned
dd08ebf6c3525a Matthew Brost 2023-03-30   87   *      | UM queues                             |
dd08ebf6c3525a Matthew Brost 2023-03-30   88   *      +---------------------------------------+
dd08ebf6c3525a Matthew Brost 2023-03-30   89   *      | padding                               |
dd08ebf6c3525a Matthew Brost 2023-03-30   90   *      +---------------------------------------+ <== 4K aligned
dd08ebf6c3525a Matthew Brost 2023-03-30   91   *      | private data                          |
dd08ebf6c3525a Matthew Brost 2023-03-30   92   *      +---------------------------------------+
dd08ebf6c3525a Matthew Brost 2023-03-30   93   *      | padding                               |
dd08ebf6c3525a Matthew Brost 2023-03-30   94   *      +---------------------------------------+ <== 4K aligned
dd08ebf6c3525a Matthew Brost 2023-03-30   95   */
dd08ebf6c3525a Matthew Brost 2023-03-30   96  struct __guc_ads_blob {
dd08ebf6c3525a Matthew Brost 2023-03-30   97  	struct guc_ads ads;
dd08ebf6c3525a Matthew Brost 2023-03-30   98  	struct guc_policies policies;
dd08ebf6c3525a Matthew Brost 2023-03-30   99  	struct guc_gt_system_info system_info;
dd08ebf6c3525a Matthew Brost 2023-03-30  100  	struct guc_engine_usage engine_usage;
dd08ebf6c3525a Matthew Brost 2023-03-30  101  	struct guc_um_init_params um_init_params;
dd08ebf6c3525a Matthew Brost 2023-03-30  102  	/* From here on, location is dynamic! Refer to above diagram. */
dd08ebf6c3525a Matthew Brost 2023-03-30 @103  	struct guc_mmio_reg regset[0];
dd08ebf6c3525a Matthew Brost 2023-03-30  104  } __packed;
dd08ebf6c3525a Matthew Brost 2023-03-30  105

:::::: The code at line 103 was first introduced by commit
:::::: dd08ebf6c3525a7ea2186e636df064ea47281987 drm/xe: Introduce a new DRM driver for Intel GPUs

:::::: TO: Matthew Brost <matthew.brost@intel.com>
:::::: CC: Rodrigo Vivi <rodrigo.vivi@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


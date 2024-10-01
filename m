Return-Path: <linux-kernel+bounces-346725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E098C804
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5122E285DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B41CEE90;
	Tue,  1 Oct 2024 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGPFmMJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5A19F48D;
	Tue,  1 Oct 2024 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821036; cv=none; b=VoNsht+ZGFTJN7MOAHLfjZ+VdhceQ4zzZUzfo9cfG1tM1zsh4DXQZGmfp60x+BTuEJxUD3HPS35Sr/dFo3y1TEIz+vn+GTvs0xb+f9eD8h0LIO3HpfVHMQYmCg1QlpXXmJ1hGHwX86yAHi54+/QkqwU19KRKzswCNjGHbFVTdvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821036; c=relaxed/simple;
	bh=B1PBJr7njXRyT+R9WjJy0fTYxQ4nzz6kMODoYtlLRnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLnjIywln02BNVdqPqyqrorELGXuU2ww6TFafjGV1XBZc/CKrQH2yVz7cHUFpc3jRJOG29KHORqQ/ZspILRYrejbCw+h+HM+1g0aHhW1shU3nP/+2Iq/zM07uzKTsgquUYkhVxX4Z9M6jvs5Ur15u7Ofs9MzkEOViz0QpmPPIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGPFmMJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273FBC4CECD;
	Tue,  1 Oct 2024 22:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727821036;
	bh=B1PBJr7njXRyT+R9WjJy0fTYxQ4nzz6kMODoYtlLRnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGPFmMJqhkovVhVD13Kq3X7nNVou7KDomOnFwy5ftHjKvdSAuHiTWzIxB15WZ3rE+
	 9C2QFiwI2jkkaiorX1oETNV13bNNxpTshO6zt+qn6yB+n8Jqu4uYgX9qeDWwEe98SX
	 s7Tct0rXAVcZSDjky1M17NRN+q97uWqJ4cPzaSCDJhiVh8WNJZnwu2mDlBM5+ECRae
	 ErOWUrZXzqu7ZtNSFeyDJzY5apaNzk953Gg62UKvLb6sibPAURQ+H1UE1CK46svPZc
	 pSWnWIuYaF4TGzYLWw7k0bNccmuTaPHAjmF9X6z55W4nIikZJRLq2Cv/3/26UwMeZB
	 WK7j1geR88duQ==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: sj@kernel.org,
	oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/damon/reclaim.c:252:15: error: implicit declaration of function 'damon_commit_ctx'
Date: Tue,  1 Oct 2024 15:17:12 -0700
Message-Id: <20241001221712.88016-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202410020227.oOh0SBIj-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: sj@kernel.org


Hi Robot,

On Wed, 2 Oct 2024 02:09:06 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> commit: 11ddcfc257a3e8d7b13b42148ee7e783f4876da4 mm/damon/reclaim: use damon_commit_ctx()
> date:   3 months ago
> config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410020227.oOh0SBIj-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020227.oOh0SBIj-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410020227.oOh0SBIj-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
[...]
    mm/damon/reclaim.c:247:15: error: implicit declaration of function 'damon_set_region_biggest_system_ram_default' [-Werror=implicit-function-declaration]
>      247 |         err = damon_set_region_biggest_system_ram_default(param_target,
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> mm/damon/reclaim.c:252:15: error: implicit declaration of function 'damon_commit_ctx' [-Werror=implicit-function-declaration]
>      252 |         err = damon_commit_ctx(ctx, param_ctx);
>          |               ^~~~~~~~~~~~~~~~
> >> mm/damon/reclaim.c:254:9: error: implicit declaration of function 'damon_destroy_ctx'; did you mean 'mm_destroy_cid'? [-Werror=implicit-function-declaration]
>      254 |         damon_destroy_ctx(param_ctx);
>          |         ^~~~~~~~~~~~~~~~~
>          |         mm_destroy_cid
>    mm/damon/reclaim.c: In function 'damon_reclaim_turn':
>    mm/damon/reclaim.c:263:23: error: implicit declaration of function 'damon_stop' [-Werror=implicit-function-declaration]
>      263 |                 err = damon_stop(&ctx, 1);
>          |                       ^~~~~~~~~~
>    mm/damon/reclaim.c:273:15: error: implicit declaration of function 'damon_start' [-Werror=implicit-function-declaration]
>      273 |         err = damon_start(&ctx, 1, true);
>          |               ^~~~~~~~~~~
>    cc1: some warnings being treated as errors

Thank you for reporting.  I tried to reproduce the issue following the kind
reproducer, but I was unable to get the error.  Maybe something in testing
setup is wrong?  Please let me know if I'm missing something.

    $ make W=1 O=../linux.out.kbuild/ ARCH=x86_64 SHELL=/bin/bash drivers/iio/accel/ drivers/iio/chemical/ drivers/iio/dac/ drivers/input/touchscreen/ drivers/mfd/ drivers/usb/host/ mm/damon/
    [...]
      CC      mm/damon/sysfs.o
      CC      mm/damon/modules-common.o
      CC      mm/damon/reclaim.o
      CC      mm/damon/lru_sort.o
      AR      mm/damon/built-in.a
    [...]


Thanks,
SJ

[...]


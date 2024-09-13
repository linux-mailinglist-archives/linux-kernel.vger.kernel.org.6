Return-Path: <linux-kernel+bounces-327484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D15C977698
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3F1B23C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE08F47;
	Fri, 13 Sep 2024 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlsFXUGI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C34A21;
	Fri, 13 Sep 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192470; cv=none; b=b5ShlNIbXR0yk5e35IKnGNdA1hdxXJuiHsDJ8aSrV96pL2VbSvFJYIpGXMp3LnTfGyWZbalxugdV/6Xid0u81SyHEcFmXEM3oagYWu14tNItqboAB4Yf4P/mwbddKt9A+i3JN2NZJVut4JMAfPhGNjN2d0byo+BIrOweOnAxsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192470; c=relaxed/simple;
	bh=mft9FtluiUsNO+9kFzODvOo8dIa6ktLqqwZBmeJrdcs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O3TLymhI4ABD5bkXlHkEKBusVvQ1N5zHMb19GiphA9I3qNPc0cOCQYRY/HmJAhxfwN9dPQsKY0e0TYfl5daQBqFTBoSpiw2mE8jkp9Q4PANiRd6RVTUU+JhdRovgB6l6bEedi3B3vhVhfTqJc4WSusHR4Am5GUtNH7o8Ot7ryj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlsFXUGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA799C4CEC3;
	Fri, 13 Sep 2024 01:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726192469;
	bh=mft9FtluiUsNO+9kFzODvOo8dIa6ktLqqwZBmeJrdcs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GlsFXUGINl89AIv1C6rvqRudlda4DMG0gy1hhRbPY8zpkptnxahawEGtsr/tDOAxi
	 E8lMCwkX9L7OUg3gUL/Hq0puQxMunt/1RBm92n8Su9c8kn7uBqlnRqeDWEpVp9uTFt
	 R5/rivfTLGYXW8n2hgC2gKG4ridkZYUNc7dxgA7X0uFw9TfuoC0WbKuJ3MttKnGcJk
	 e1QKrCA1pD8zP4unHxAmfPkJ/WNxG8g+EiSkH6yk+5AcPm384HIvf8rJ2PoRiPr42g
	 y7u22WxFtns0P+OXWapXkGwpIPiKx5z6Q/57Fc8e9QHjXJNqH+v8eGZheL2bT5tXqL
	 S5fG2aRK1/LSg==
Message-ID: <f617ac0c-5ac8-439d-8283-41a68086ff63@kernel.org>
Date: Fri, 13 Sep 2024 09:54:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Barry Song <v-songbaohua@oppo.com>, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [linus:master] [f2fs] 5c8764f867: xfstests.generic.091.fail
To: kernel test robot <oliver.sang@intel.com>
References: <202409122131.d6e2f8c1-oliver.sang@intel.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <202409122131.d6e2f8c1-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/12 21:50, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "xfstests.generic.091.fail" on:
> 
> commit: 5c8764f8679e659c5cb295af7d32279002d13735 ("f2fs: fix to force buffered IO on inline_data inode")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Can you please try below fix for xfstests?

https://lore.kernel.org/fstests/20240911035333.364961-1-chao@kernel.org/

Thanks,

> 
> in testcase: xfstests
> version: xfstests-x86_64-b1465280-1_20240909
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: f2fs
> 	test: generic-091
> 
> 
> 
> compiler: gcc-12
> test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409122131.d6e2f8c1-oliver.sang@intel.com
> 
> 2024-09-11 03:13:26 export TEST_DIR=/fs/sda1
> 2024-09-11 03:13:26 export TEST_DEV=/dev/sda1
> 2024-09-11 03:13:26 export FSTYP=f2fs
> 2024-09-11 03:13:26 export SCRATCH_MNT=/fs/scratch
> 2024-09-11 03:13:26 mkdir /fs/scratch -p
> 2024-09-11 03:13:26 export SCRATCH_DEV=/dev/sda4
> 2024-09-11 03:13:26 export MKFS_OPTIONS="-f"
> 2024-09-11 03:13:27 echo generic/091
> 2024-09-11 03:13:27 ./check generic/091
> FSTYP         -- f2fs
> PLATFORM      -- Linux/x86_64 lkp-skl-d01 6.10.0-rc3-00027-g5c8764f8679e #1 SMP PREEMPT_DYNAMIC Wed Sep 11 10:37:47 CST 2024
> MKFS_OPTIONS  -- -f /dev/sda4
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch
> 
> generic/091       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/091.out.bad)
>      --- tests/generic/091.out	2024-09-09 16:31:23.000000000 +0000
>      +++ /lkp/benchmarks/xfstests/results//generic/091.out.bad	2024-09-11 03:14:07.468026185 +0000
>      @@ -1,7 +1,55 @@
>       QA output created by 091
>       fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>      -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>      -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>      -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>      -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>      -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
>      ...
>      (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/091.out /lkp/benchmarks/xfstests/results//generic/091.out.bad'  to see the entire diff)
> Ran: generic/091
> Failures: generic/091
> Failed 1 of 1 tests
> 
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240912/202409122131.d6e2f8c1-oliver.sang@intel.com
> 
> 
> 



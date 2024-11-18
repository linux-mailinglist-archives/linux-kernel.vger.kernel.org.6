Return-Path: <linux-kernel+bounces-413068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E998B9D12F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6CE1F22190
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B01AA1D8;
	Mon, 18 Nov 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="c6Az+eMu"
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5A1A08B5;
	Mon, 18 Nov 2024 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.142.107.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940119; cv=none; b=a35A/l6Z/bq7AeVy9S6HpNZPDEhmBN0f/sAS4PjWH6nHOkB9KYu9PBgxGIIAsfVRiZzaqO5BASlEzYAtwrklFpK/bnZNuHuRgeiyDseLUZ0u1xdZCzVn86qe5WF22Z5ivlmR5/j6wgFNiBUl5p4nw0vEbQJzsXj/sVbt7bypRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940119; c=relaxed/simple;
	bh=eeRE83745VD8rPDBtoV0l/h7YftdStgBIrua0HDhRJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdDGnoA0SmGMm7J4+xUs7vK7y+RpDc7VpbcKzNjtx1yO4424dvaT7d18Ookn+UaqP8ftQL+dZO3uqaHuby5b2b1/05CD4HobbfMvUQXJF60vZkRiQsKuXS+WM4I2eU5NqhS/JL1zj1f9N0fUElSk1Atn6V2cnChoQBJm0KsHbYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com; spf=pass smtp.mailfrom=lechnology.com; dkim=pass (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b=c6Az+eMu; arc=none smtp.client-ip=98.142.107.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lechnology.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XVCoynHZIH/9Waxkwf4j85iyaFmxEKNj6ZCvqwFYLbs=; b=c6Az+eMulVAWd9WxxEK7drmtW2
	xzMfqvomC0zfJEVQPA6AeX4DQ+5ti4jgHsxa85bHd1KDRyjrfc67Pu1QBGwJIj03Y+3ujfYj+qN1w
	If5wbvpgYlL2gd7cM4OAqio6co8L+pwwhEsxVq9U3MuXM4UPu/Fu1z/re/+ObgMmQKaMDgIZsZyHI
	Dde/HlkQkieDAOx3KVBOF8IuV3CDb0Mxxm+Y8EtFz6m3e2+rAWrBeVplRplPl758tM/7Uyw3A6k3s
	iPywKfSAaUcpbWgdg4qqC7UqhodhQRsdlnDZ/ScGce4ulIFMVc3QRq8y9uCkLhZNOUNOlqo0h6Dzi
	1pcu7S7A==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:50026 helo=[192.168.0.142])
	by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <david@lechnology.com>)
	id 1tD2ke-0008AE-24;
	Mon, 18 Nov 2024 09:28:26 -0500
Message-ID: <2c7789dd-9583-4daa-918a-1bf14635f62e@lechnology.com>
Date: Mon, 18 Nov 2024 08:28:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/clk/davinci/psc.c:281:10: error: incompatible integer to
 pointer conversion returning 'int' from a function with result type 'struct
 davinci_lpsc_clk *' [-Wint-conversion]
To: Stephen Boyd <sboyd@kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 clang-built-linux <llvm@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
Cc: hanchunchao@inspur.com, Michael Turquette <mturquette@baylibre.com>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYs+gwu67Y0Tm2FHfNuUA5eLxT2FAWkfKvYrEbXJUXXiiA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <david@lechnology.com>
Autocrypt: addr=david@lechnology.com; keydata=
 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
In-Reply-To: <CA+G9fYs+gwu67Y0Tm2FHfNuUA5eLxT2FAWkfKvYrEbXJUXXiiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 11/18/24 7:10 AM, Naresh Kamboju wrote:
> The davinci_all_defconfig and multi_v5_defconfig builds failed with clang-19 and
> clang-nightly on the Linux next-20241115 tag for the arm architectures.
> Same build pass with gcc-13.
> 
> First seen on Linux next-20241118 tag.
>   Good: next-20241115
>   Bad:  next-20241118
> 
> arm
> * arm, build
>   - clang-19-davinci_all_defconfig
>   - clang-19-multi_v5_defconfig
>   - clang-19-multi_v5_defconfig-65236a87
>   - clang-nightly-davinci_all_defconfig
>   - clang-nightly-multi_v5_defconfig
>   - clang-nightly-multi_v5_defconfig-65236a87
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build error:
> ---------
> drivers/clk/davinci/psc.c:281:10: error: incompatible integer to
> pointer conversion returning 'int' from a function with result type
> 'struct davinci_lpsc_clk *' [-Wint-conversion]
>   281 |                 return -ENOMEM;
>       |                        ^~~~~~~
> 1 error generated.
> make[6]: *** [scripts/Makefile.build:200: drivers/clk/davinci/psc.o] Error 1
> 
> Build image:
> -----------
> - https://storage.tuxsuite.com/public/linaro/lkft/builds/2p15j4StPnjuuRXu3qgndSTbahH/
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241118/testrun/25881399/suite/build/test/clang-19-davinci_all_defconfig/history/
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241118/testrun/25881399/suite/build/test/clang-19-davinci_all_defconfig/details/
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241118/testrun/25881399/suite/build/test/clang-19-davinci_all_defconfig/log
> 
> Steps to reproduce:
> ------------
> - # tuxmake --runtime podman --target-arch arm --toolchain clang-19
> --kconfig davinci_all_defconfig LLVM=1 LLVM_IAS=1
> 
> metadata:
> ----
>   git describe: next-20241118
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git sha: ae58226b89ac0cffa05ba7357733776542e40216
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2p15j4StPnjuuRXu3qgndSTbahH/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2p15j4StPnjuuRXu3qgndSTbahH/
>   toolchain: clang-19
>   config: davinci_all_defconfig and multi_v5_defconfig
>   arch: arm
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

Hi Stephen,

This is caused by [1]. I looked at it again and the patch is wrong.
Can you drop it from your tree or should we send another patch to
fix the bad patch?

[1]: https://lore.kernel.org/linux-clk/20241114091422.75412-1-hanchunchao@inspur.com/


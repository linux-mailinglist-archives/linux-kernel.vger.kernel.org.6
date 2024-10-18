Return-Path: <linux-kernel+bounces-371343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75D9A39D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C592328562D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A5B19046E;
	Fri, 18 Oct 2024 09:22:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE79192B94;
	Fri, 18 Oct 2024 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243322; cv=none; b=L2WdhZjw72CVHeWFFsqVUyP5Ag7fWs9YiMdK9xDdd5Nca2ynCN7WhGRx4bM5NSqQI/lmbIBl3cA6ZdAs1OSvWrwbvIsZM2TKrxuopDFDZ9+NhQXLErDOfg6k3tJgwKZT8WM+MstmQrocPL3/fScpIarM4wleLlXYvBgOGUYUIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243322; c=relaxed/simple;
	bh=e5K0kGJKpNk6+ZK0ECN3b21eaHBvlRlaVa8jtJgIE5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMUW5MC+HcuLLsz4+/zsObvAUaYVO7s5yrHaxVZRjWXIBO52CxTXf5lwvdCiKNata3NTX0crL3Jvc39lBilArmnRJ2bnzdIJwzZsuzVy9AeEqUhpUPNR8a0i6s4gXeFpRdLnScH0tFxkyfcl41S/U3y2H3rCiWFRPfpG9q7RHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF5DC4CEC3;
	Fri, 18 Oct 2024 09:22:00 +0000 (UTC)
Date: Fri, 18 Oct 2024 10:21:57 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	qemu-devel@nongnu.org, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm64 with Linux next-20241017 tag
Message-ID: <ZxIotWFxJf8H9bYX@arm.com>
References: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>

On Fri, Oct 18, 2024 at 12:56:01PM +0530, Naresh Kamboju wrote:
> The QEMU-arm64 boot has failed with the Linux next-20241017 tag.
> The boot log is incomplete, and no kernel crash was detected.
> However, the system did not proceed far enough to reach the login prompt.
> 
> Please find the incomplete boot log links below for your reference.
> The Qemu version is 9.0.2.
> The arm64 devices boot pass.
> 
> This is always reproducible.
> First seen on Linux next-20241017 tag.
>   Good: next-20241016
>   Bad: next-20241017
> 
> qemu-arm64-protected:
>   boot:
>     * clang-19-lkftconfig
>     * gcc-13-lkftconfig
>     * clang-nightly-lkftconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Boot log:
> ---------
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> [    0.000000] Linux version 6.12.0-rc3-next-20241017
> (tuxmake@tuxmake) (Debian clang version 19.1.2
> (++20241001023520+d5498c39fe6a-1~exp1~20241001143639.51), Debian LLD
> 19.1.2) #1 SMP PREEMPT @1729156545
> [    0.000000] KASLR enabled
> [    0.000000] random: crng init done
> [    0.000000] Machine model: linux,dummy-virt
> [    0.000000] efi: UEFI not found.
> [    0.000000] Capping linear region to 51 bits for KVM in nVHE mode
> on LVA capable hardware.
> ...
> [    0.000000] Kernel command line: console=ttyAMA0,115200 rootwait
> root=/dev/vda debug verbose console_msg_format=syslog
> systemd.log_level=warning rw kvm-arm.mode=protected earlycon
> ...
> <6>[    0.305549] SME: maximum available vector length 256 bytes per vector
> <6>[    0.306214] SME: default vector length 32 bytes per vector
> **
> ERROR:target/arm/internals.h:923:regime_is_user: code should not be reached
> Bail out! ERROR:target/arm/internals.h:923:regime_is_user: code should
> not be reached
> <nothing after this>

Qemu bug. See this email from Peter:

https://lore.kernel.org/r/CAFEAcA8uJL1t2MDjaJL7u5oW4ns23_E+sk7987x4gAcs3dSZOw@mail.gmail.com

-- 
Catalin


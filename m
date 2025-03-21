Return-Path: <linux-kernel+bounces-571280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B44A6BB48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A08918889DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E71F229B0C;
	Fri, 21 Mar 2025 12:57:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D901C2DB2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561866; cv=none; b=IMXLvpao44Yr4pJc5t8/oXal+Qi8a1UPr4RBqHZ4ZgE+GRrh0LjPxTsk8kft8sa2mkSPMnDChVYRI6hWi2z+26VBaYVkwaKgY7opiJuZHWvAh+vwIzVM29SLxvRMyceBa5RpwKQyHP6G6UECfhUVxxAPzkb355eIy59cxBlPMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561866; c=relaxed/simple;
	bh=9V5F+5KE+QgZzg0jOhP26TdHasnAHrPxMgAE6T3UHpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cd5HQJLMtWatn82EMhsdob6G3/SwSWiHff4yoQ5DGDAPS5PT2pcg9UfpMV43fAQ5Iwflf10/L3Vnmcn4JJL3GYW/kfmwm7zDB7NbIAhbaFF9imqb5XMCv07vpU3cdATd2hVIdOJojAxKzqfmEhYqeYL/Tfm+5/OU6hFqv5L7gYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 408B5106F;
	Fri, 21 Mar 2025 05:57:50 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC44A3F63F;
	Fri, 21 Mar 2025 05:57:40 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:57:32 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, open list
 <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, kvmarm@lists.linux.dev, Anshuman
 Khandual <anshuman.khandual@arm.com>, Rob Herring <robh@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
 Aishwarya TCV <aishwarya.tcv@arm.com>, Anders Roxell
 <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>
Subject: Re: Fast model boot failure with Linux next-20250312
Message-ID: <20250321125732.6def5eca@donnerap.manchester.arm.com>
In-Reply-To: <CA+G9fYuw_jXCz07Dsk46QXQr3+y5-NfkC30ZNh+XmyeWgibQhA@mail.gmail.com>
References: <CA+G9fYvPu+MQKhYyPZSSDpAn-zhRGmeHQ8hJksT_cdDdxfbB-g@mail.gmail.com>
	<Z9ra3I2axii2HRVb@J2N7QTR9R3>
	<CA+G9fYuw_jXCz07Dsk46QXQr3+y5-NfkC30ZNh+XmyeWgibQhA@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 16:03:32 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

Hi,

> On Wed, 19 Mar 2025 at 20:25, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 08:07:47PM +0530, Naresh Kamboju wrote:  
> > > Regressions on the arm64 Fast Model (FVP-AEMvA) caused boot failures starting
> > > with Linux next-20250312 and persisting through next-20250319.
> > >
> > > First seen on the next-20250312
> > >  Good: next-20250311
> > >  Bad:  next-20250312 .. next-20250319
> > >
> > > Regressions found on FVP:
> > >  - boot
> > >
> > > Regression Analysis:
> > >  - New regression? Yes
> > >  - Reproducible? Yes
> > >
> > > Boot regression: Fast model boot failure with Linux next-20250312
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Anders bisected this to this commit id,
> > >
> > > # first bad commit:
> > >   [858c7bfcb35e1100b58bb63c9f562d86e09418d9]
> > >   arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
> > >
> > > NOTE:
> > >   LKFT is currently running FVP Fast Models version 11.24.
> > >   Planned upgrade to the Fast Models version 11.28 in this sprint.  
> >
> > What firmware (and version therof) are you running within the model?  
> 
> Fast Models [11.24.11 (Nov 29 2023)]
> Booting Trusted Firmware
> BL1: v2.9(release):v2.9.0
> BL2: v2.9(release):v2.9.0
> BL31: v2.9(release):v2.9.0
> UEFI firmware (version  built at 22:31:25 on May 26 2023)
> UEFI v2.70 (EDK II, 0x00010000)
> 
> We need to update the firmware version at our end.

Oh yes, please, v2.9.0 is quite old by now, especially for a moving target
like the FVP, and when enabling new architecture features.
FWIW, after Anshuman pointed me the problem, I made a patch for TF-A to
enable PMUv3p9:
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/35884
You would need that for this Linux commit here to work.
FEAT_FGT2 should be enabled already by default for the FVP.

Please feel free to leave a comment at the TF-A gerrit, stating that you
need the patch, that should accelerate the upstream process.

Cheers,
Andre

> > For example, if the EL3 firmware lacks support for FEAT_FGT2 or
> > FEAT_PMUv3p9, the kernel will trap to EL3 early during boot and die.
> >
> > It would be really helpful if you could capture that in the report in
> > future.
> >
> > Mark.
> >  
> > >
> > > ## Boot log
> > >   <No crash log on the console>
> > >
> > > ## Source
> > > * Kernel version: 6.14.0-rc7
> > > * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > * Git sha: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
> > > * Git describe: next-20250319
> > > * Project details:
> > > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319
> > > * DUT: arm64 Fast Model (FVP-AEMvA)
> > > * Toolchains: gcc-13 and clang-20
> > >
> > > ## Build
> > > * Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675691/suite/boot/test/gcc-13-lkftconfig/log
> > > * Build history:
> > > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675685/suite/boot/test/gcc-13-lkftconfig/history/
> > > * Build details:
> > > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675691/suite/boot/test/gcc-13-lkftconfig/
> > > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2EtC2pQdmVZ7ccoyhoi01Yy0/
> > > * Kernel config:
> > > https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2EtC2pQdmVZ7ccoyhoi01Yy0/config
> > >
> > > --
> > > Linaro LKFT
> > > https://lkft.linaro.org
> > >  
> 
> - Naresh
> 



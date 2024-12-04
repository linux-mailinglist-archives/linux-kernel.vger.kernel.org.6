Return-Path: <linux-kernel+bounces-431986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1076C9E437E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F1F163AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A581A8F76;
	Wed,  4 Dec 2024 18:35:05 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0712391AC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337305; cv=none; b=UnOAEJElt2rs5a9ZyyhFAIPWkAyB/hIhyzmX13eownMtute7Rwl9faUNc+WC8WcpUxT9OS8kNpPybFAa0Nrfq5AlqxtM7nm0Lwro6u3brGkJQBJs2tzX5ZQplc10ulurNF853iKyYDRg7v/djnXxzFJVmVB6fOKdBEZJD26PzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337305; c=relaxed/simple;
	bh=5tCSkI1GOvtc1a3P60vamTzDYZEZZeQf2B+W9eETBVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNrYs7e4S910+dVQu2FTTyMzT2Ue+unM0V1ZmpHfeyGFv5+JhxeNQPtT7zr/54ps6u3gGrBu4aBRUh+SSqWIDD5+RalzsEpaWM3nuqSIHsZJJ98de2uPRKADK1vEjiE5ikr6bweIlWVGGjQvb/aAwTOH3TLDVlFyuBfN3WWnJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 17BE472C97E;
	Wed,  4 Dec 2024 21:34:54 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 060EF36D0178;
	Wed,  4 Dec 2024 21:34:54 +0300 (MSK)
Date: Wed, 4 Dec 2024 21:34:53 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Will Deacon <will@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Message-ID: <20241204182231.ovvj6rpvcs2f5gv7@altlinux.org>
References: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
 <20241202153618.GA6834@willie-the-truck>
 <86ttbmt71k.wl-maz@kernel.org>
 <20241202155940.p267a3tz5ypj4sog@altlinux.org>
 <86ser6t6fs.wl-maz@kernel.org>
 <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
 <20241203092721.j473dthkbq6wzez7@altlinux.org>
 <1847e34fa7724d28aeb22d93752f64f2@huawei.com>
 <20241203221453.mwh6sozyczi4ec2k@altlinux.org>
 <87jzcfsuep.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <87jzcfsuep.wl-maz@kernel.org>

Marc,

On Wed, Dec 04, 2024 at 08:51:26AM +0000, Marc Zyngier wrote:
> On Tue, 03 Dec 2024 22:14:53 +0000,
> Vitaly Chikunov <vt@altlinux.org> wrote:
> > 
> > Shameer, Marc, Oliver, Will,
> > 
> > On Tue, Dec 03, 2024 at 10:03:11AM +0000, Shameerali Kolothum Thodi wrote:
> > > > -----Original Message-----
> > > > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> > > > Behalf Of Vitaly Chikunov
> > > > Sent: Tuesday, December 3, 2024 9:27 AM
> > > > To: Marc Zyngier <maz@kernel.org>
> > > > Cc: Will Deacon <will@kernel.org>; james.morse@arm.com; linux-arm-
> > > > kernel@lists.infradead.org; Catalin Marinas <catalin.marinas@arm.com>;
> > > > linux-kernel@vger.kernel.org; oliver.upton@linux.dev;
> > > > mark.rutland@arm.com
> > > > Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
> > > > 0000000002000000 [#1] SMP
> > > > 
> > > > Marc,
> > > > 
> > > > On Tue, Dec 03, 2024 at 01:31:19AM +0300, Vitaly Chikunov wrote:
> > > > > On Mon, Dec 02, 2024 at 04:07:03PM +0000, Marc Zyngier wrote:
> > > > > > On Mon, 02 Dec 2024 15:59:40 +0000,
> > > > > > Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > > > >
> > > > > > > Marc,
> > > > > > >
> > > > > > > On Mon, Dec 02, 2024 at 03:53:59PM +0000, Marc Zyngier wrote:
> > > > > > > >
> > > > > > > > What the log doesn't say is what the host is. Is it 6.13-rc1 as well?
> > > > > > >
> > > > > > > No, host is 6.6.60.
> > > > > >
> > > > > > Right. I wouldn't be surprised if:
> > > > > >
> > > > > > - this v6.6 kernel doesn't hide the MPAM feature as it should (and
> > > > > >   that's proably something we should backport)
> > > > >
> > > > > How to confirm this? Currently I cannot find any (case-insensitive)
> > > > > "MPAM" files in /sys, nor mpam string in /proc/cpuinfo, nor MPAM
> > > > > strings in `strace -v` (as it decodes some KVM ioctls) of qemu process.
> > > > >
> > > > > >
> > > > > > - you get a nastygram in the host log telling you that the guest has
> > > > > >   executed something it shouldn't (you'll get the encoding of the
> > > > > >   instruction)
> > > > >
> > > > > I requested admins of the box for dmesg output since I don't have root
> > > > > access myself and nowadays dmesg is not accessible for a user.
> > > > 
> > > > This is what they reported:
> > > > 
> > > >   kvm [2502822]: Unsupported guest sys_reg access at: ffff80008003e9f0
> > > > [000000c5]
> > > >                    { Op0( 3), Op1( 0), CRn(10), CRm( 4), Op2( 4), func_read },
> > > > 
> > > 
> > > As Will pointed out I think this is access to MPAMIDR_EL1 and is from this
> > > code here,
> > > 
> > > +++ b/arch/arm64/kernel/cpuinfo.c
> > > @@ -478,6 +478,9 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
> > >  	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
> > >  		__cpuinfo_store_cpu_32bit(&info->aarch32);
> > >  
> > > +	if (id_aa64pfr0_mpam(info->reg_id_aa64pfr0))
> > > +		info->reg_mpamidr = read_cpuid(MPAMIDR_EL1);
> > > +
> > >  	cpuinfo_detect_icache_policy(info);
> > >  }
> > > 
> > > I did manage to boot my setup in 6.6 and this is what happens,
> > > 
> > > Host kernel 6.6
> > > Guest Kernel 6.13-rc1
> > > 
> > > [    0.195392] smp: Brought up 1 node, 8 CPUs
> > > [    0.219000] SMP: Total of 8 processors activated.
> > > [    0.219629] CPU: All CPU(s) started at EL1
> > > ...
> > > [    0.223212] CPU features: detected: RAS Extension Support
> > > [    0.223927] CPU features: detected: Memory Partitioning And Monitoring
> > > [    0.224796] CPU features: detected: Memory Partitioning And Monitoring Virtualisation
> > > [    0.225961] alternatives: applying system-wide alternatives
> > > ...
> > > 
> > > Guest detects MPAM and boots fine.
> > > 
> > > Host kernel 6.13-rc1
> > > Guest Kernel 6.13-rc1
> > > 
> > > [    0.196625] smp: Brought up 1 node, 8 CPUs
> > > [    0.222093] SMP: Total of 8 processors activated.
> > > [    0.222769] CPU: All CPU(s) started at EL1
> > > ...
> > > [    0.226620] CPU features: detected: RAS Extension Support
> > > [    0.227453] alternatives: applying system-wide alternatives
> > > 
> > > MPAM is not visible to Guest in this case.
> > > 
> > > So as I pointed out earlier could it be a case where the ID register reports MPAM support
> > > but the firmware has not enabled MPAM?
> > > 
> > > James seems to be mentioning that case here,
> > > 
> > > " (If you have a boot failure that bisects here its likely your CPUs
> > > advertise MPAM in the id registers, but firmware failed to either enable
> > > or MPAM, or emulate the trap as if it were disabled)"
> > 
> > I tried to verify that MPAM is advertised with qemu+gdb method, as
> > suggested by Oliver, but ID_AA64PFR0_EL1 register is not there.
> > 
> >   (gdb) i r ID_AA64PFR0_EL1
> >   Invalid register `ID_AA64PFR0_EL1'
> 
> Then there is a bug in either QEMU or the GDB stubs. This register
> exists, or you wouldn't be here.


In case this is useful:

  builder@aarch64:/.in$ qemu-system-aarch64 --version
  QEMU emulator version 9.1.1 (qemu-9.1.1-alt2)
  Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
  builder@aarch64:/.in$ gdb --version
  GNU gdb (GDB) 14.1.0.56.d739d4fd457-alt1 (ALT Sisyphus)
  Copyright (C) 2023 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.

Is there way to get content of this register with these possible gdb/qemu bugs?
Perhaps, we can add some debugging print in guest kernel.

> > 
> > Are there other suggestions?
> 
> Mark has described what the problem is likely to be. 6.6-stable needs
> to have 6685f5d572c22e10 backported, and it probably should have been
> Cc: to stable. Can you please apply the following patch to your *host*
> machine and retest?

Unfortunately I cannot. But I can apply patches to the guest kernel. [I
will try to convince admins of the server to apply the patch, though, but
this can take time, and they can refuse since this is production build
server and it's update procedure is complicated.]

> > > https://lore.kernel.org/all/20241030160317.2528209-4-joey.gouly@arm.com/
> > > 
> > > Is there a way you can find out the BIOS version on that board?
> > 
> > Unfortunately, admins of the server do not provide me with this
> > info.
> 
> This doesn't really help, I'm afraid.

They provided me with this dmicedcode output:

  Handle 0x0000, DMI type 0, 26 bytes
  BIOS Information
	  Vendor: Huawei Corp.
	  Version: 1.25
	  Release Date: 01/17/2020
	  Address: 0x5F000
	  Runtime Size: 644 kB
	  ROM Size: 6 MB

  Handle 0x0001, DMI type 1, 27 bytes
  System Information
	  Manufacturer: Huawei
	  Product Name: TaiShan 200 (Model 2280)

Admins said they are in process of requesting firmware upgrade from
manufacturer.

> 
> > For such cases, when MPAM is incorrectly advertised, can we have kernel
> > command line parameter like mpam=0 to override it's detection?
> 
> We could, but only when we can confirm what the problem is.
> 
> > I think with "If you have a boot failure that bisects here" it's
> > acknowledged possibility and it's confirmed by our server.
> 
> Not really. This talks about firmware. We are debugging the hypervisor
> here. This might be closely related, but these are not the same
> things.

Understandable.
Thanks,

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.


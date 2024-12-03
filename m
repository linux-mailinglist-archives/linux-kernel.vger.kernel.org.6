Return-Path: <linux-kernel+bounces-429205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D980A9E18B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F613281BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B451E04BD;
	Tue,  3 Dec 2024 10:03:22 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBC1DF74D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220201; cv=none; b=j2tvmEwu2P0gHpDfZYJbTsLJUtcfXqTpTG3XAEZv2l2pqIlcHw4wEf06g++ByhwzvfSbj+p24cfPOwUMpksFZD8pqWzv0Sfqi7m7hmbfFOwrRcTZGsMe8d5FMtu9G6AP3Aiw+Fnu9nE9Uj4i9Wlul/HwHXBQPXzlRpue7869Bsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220201; c=relaxed/simple;
	bh=5Im7cUQ4VUeG+OaMrKILQk7ltgVSuzZzDouqRBNIKvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cGOouM2DH6O6752PBy58imZc3P6C9vpHGTsBKEwXhUa10YAXb2b8gNLlNk/iM4PrN6T6VVQotOAcPCJ/aWNgQBelC5qyiwS0Km1mJRqApJIDVFqsm9CjoPbcrw8oUwbz69zjzpV2cTSB5BGf2D73S3lUHkJcQxBJHNKlpKs/Jhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y2bkK1mxQzPpwx;
	Tue,  3 Dec 2024 18:00:25 +0800 (CST)
Received: from kwepemd100010.china.huawei.com (unknown [7.221.188.107])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B397140444;
	Tue,  3 Dec 2024 18:03:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 kwepemd100010.china.huawei.com (7.221.188.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 3 Dec 2024 18:03:13 +0800
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 3 Dec 2024 11:03:11 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Vitaly Chikunov <vt@altlinux.org>, Marc Zyngier <maz@kernel.org>
CC: Will Deacon <will@kernel.org>, "james.morse@arm.com"
	<james.morse@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Catalin Marinas
	<catalin.marinas@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: RE: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Thread-Topic: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Thread-Index: AQHbRHc1pIGPV7SGf0u8eV81r8P21rLTBiuAgAAE74CAAAGXAIAAAhCAgABrXYCAALdLgIAAGCGA
Date: Tue, 3 Dec 2024 10:03:11 +0000
Message-ID: <1847e34fa7724d28aeb22d93752f64f2@huawei.com>
References: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
 <20241202153618.GA6834@willie-the-truck> <86ttbmt71k.wl-maz@kernel.org>
 <20241202155940.p267a3tz5ypj4sog@altlinux.org> <86ser6t6fs.wl-maz@kernel.org>
 <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
 <20241203092721.j473dthkbq6wzez7@altlinux.org>
In-Reply-To: <20241203092721.j473dthkbq6wzez7@altlinux.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of Vitaly Chikunov
> Sent: Tuesday, December 3, 2024 9:27 AM
> To: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>; james.morse@arm.com; linux-arm-
> kernel@lists.infradead.org; Catalin Marinas <catalin.marinas@arm.com>;
> linux-kernel@vger.kernel.org; oliver.upton@linux.dev;
> mark.rutland@arm.com
> Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
> 0000000002000000 [#1] SMP
>=20
> Marc,
>=20
> On Tue, Dec 03, 2024 at 01:31:19AM +0300, Vitaly Chikunov wrote:
> > On Mon, Dec 02, 2024 at 04:07:03PM +0000, Marc Zyngier wrote:
> > > On Mon, 02 Dec 2024 15:59:40 +0000,
> > > Vitaly Chikunov <vt@altlinux.org> wrote:
> > > >
> > > > Marc,
> > > >
> > > > On Mon, Dec 02, 2024 at 03:53:59PM +0000, Marc Zyngier wrote:
> > > > >
> > > > > What the log doesn't say is what the host is. Is it 6.13-rc1 as w=
ell?
> > > >
> > > > No, host is 6.6.60.
> > >
> > > Right. I wouldn't be surprised if:
> > >
> > > - this v6.6 kernel doesn't hide the MPAM feature as it should (and
> > >   that's proably something we should backport)
> >
> > How to confirm this? Currently I cannot find any (case-insensitive)
> > "MPAM" files in /sys, nor mpam string in /proc/cpuinfo, nor MPAM
> > strings in `strace -v` (as it decodes some KVM ioctls) of qemu process.
> >
> > >
> > > - you get a nastygram in the host log telling you that the guest has
> > >   executed something it shouldn't (you'll get the encoding of the
> > >   instruction)
> >
> > I requested admins of the box for dmesg output since I don't have root
> > access myself and nowadays dmesg is not accessible for a user.
>=20
> This is what they reported:
>=20
>   kvm [2502822]: Unsupported guest sys_reg access at: ffff80008003e9f0
> [000000c5]
>                    { Op0( 3), Op1( 0), CRn(10), CRm( 4), Op2( 4), func_re=
ad },
>=20

As Will pointed out I think this is access to MPAMIDR_EL1 and is from this
code here,

+++ b/arch/arm64/kernel/cpuinfo.c
@@ -478,6 +478,9 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *i=
nfo)
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
 		__cpuinfo_store_cpu_32bit(&info->aarch32);
=20
+	if (id_aa64pfr0_mpam(info->reg_id_aa64pfr0))
+		info->reg_mpamidr =3D read_cpuid(MPAMIDR_EL1);
+
 	cpuinfo_detect_icache_policy(info);
 }

I did manage to boot my setup in 6.6 and this is what happens,

Host kernel 6.6
Guest Kernel 6.13-rc1

[    0.195392] smp: Brought up 1 node, 8 CPUs
[    0.219000] SMP: Total of 8 processors activated.
[    0.219629] CPU: All CPU(s) started at EL1
...
[    0.223212] CPU features: detected: RAS Extension Support
[    0.223927] CPU features: detected: Memory Partitioning And Monitoring
[    0.224796] CPU features: detected: Memory Partitioning And Monitoring V=
irtualisation
[    0.225961] alternatives: applying system-wide alternatives
...

Guest detects MPAM and boots fine.

Host kernel 6.13-rc1
Guest Kernel 6.13-rc1

[    0.196625] smp: Brought up 1 node, 8 CPUs
[    0.222093] SMP: Total of 8 processors activated.
[    0.222769] CPU: All CPU(s) started at EL1
...
[    0.226620] CPU features: detected: RAS Extension Support
[    0.227453] alternatives: applying system-wide alternatives

MPAM is not visible to Guest in this case.

So as I pointed out earlier could it be a case where the ID register report=
s MPAM support
but the firmware has not enabled MPAM?

James seems to be mentioning that case here,

" (If you have a boot failure that bisects here its likely your CPUs
advertise MPAM in the id registers, but firmware failed to either enable
or MPAM, or emulate the trap as if it were disabled)"

https://lore.kernel.org/all/20241030160317.2528209-4-joey.gouly@arm.com/

Is there a way you can find out the BIOS version on that board?

Thanks,
Shameer



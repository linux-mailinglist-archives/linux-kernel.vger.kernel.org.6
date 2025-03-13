Return-Path: <linux-kernel+bounces-559271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79352A5F1B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB9B7A8A24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC1226462C;
	Thu, 13 Mar 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="hI6+nZG/"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6271FC0E4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863264; cv=none; b=qewWw4yEOvxp4Km8a8u6h4Q6rKH2i5ka2fb7IflgKigBWECKpgKvIERgextUXlmcsveROkUYr/1EvHHF/fQxizZfwVkErBnzs/F/sEqL0hvKO7k0FjcPgEdkb7mL1kGEJV16zKlWMcMA5fjoq+kdfJDLrqu/SSjasO6HFVO+bS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863264; c=relaxed/simple;
	bh=m3sOUfi8MzT+7PYkHKmoRsBfnrRHhVuDIJKqfpncpBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPxesMfSQE7nxB/JdtPBo4pokYe7k5L2qKsWxcMb11IZNeOpgHUTey9ehJFl+nCXEp9OAfJ7IrBo14o4ev/lnV2RiG0rj3stoXlMn/4MqGX6SATTMe9fqdH4viJJ5ebD+u78NOj5Pw86PE+/1vqL7nGquanAxIQLfmvYVAhLm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=hI6+nZG/; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741863216; x=1742468016; i=spasswolf@web.de;
	bh=zEnIjABEOUy0KOS73+4IpE8FfHaRXDtgeIkZMeYW+RM=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hI6+nZG/5+mRRwVpWuOOl0F5pkuYaPpKaWw+tG1EheGCZeRIv85sMaoyxIahnV9c
	 6OWB1yHb8ESE1qxnGe+7A1l95HzW5Iua+Ozn2o0lDU1aK6f+TR39jU4Q86b9xkcCE
	 5duMmtMkyCRzTKEWJiikPBUPo3ZRMB7IRKxSNh+r0fYDO+8AySMvfrYBNaaSyceET
	 sqc+57cbq9bIs5uYPJ2pp/XJFin7z3i8aRQqQmdPYreo3GotTAFEAUxXldOEqb4x2
	 tw7pbJyOpNKlEr0mU6pEQ3p9SvphRR1mGT4QGH+XSaEvXg3SmsW4ci46KTnVA5Me+
	 BjO/zaLYkkmyKOoMPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXGOI-1tiFH72ab8-00VwXs; Thu, 13
 Mar 2025 11:53:36 +0100
Message-ID: <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	spasswolf@web.de
Date: Thu, 13 Mar 2025 11:53:34 +0100
In-Reply-To: <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
References: <20250310112206.4168-1-spasswolf@web.de>
	 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
	 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
	 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
	 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
	 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
	 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
	 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
	 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
	 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:merI4X8p8hDF71LY2JohJGS61nT0QW9BfuAUNSaGUtj/Rdpt7uX
 OSRQAWQhO99UjRJUdtjVxKwkAaDAtY6NIaLQ6M5Uj55N+TfhdVUgC52VOdCdeHLujdxvhLd
 eLUIxPOGSEErQRj3A80SSBfXkgHRzuEaQ/o3C32P7cXxUo+40Zgbm2Czb5BOjxgUti4N4r8
 tiqn6c3smra7pdFXVc0Cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NpJpHCUXedA=;UPAM9Z1RFevACAkNs20uKq+UaXz
 4YUcDUbAllpk/s0Ao3US5IZDirVawVod/5aXva5Ny4BrnIJLo4Dp7oXLuY2ZNbd3QO02r8bmc
 ThU+oV50EENR/+zeO6Hegd9OKzZOJYXae8kWOgxizESkXtxGgKCF81PM0N03Mds+ldEoM22c2
 +oVZmLOaIvWAWtcdZoNPxWl/YxlhoLouOBTV5xraEJzlZ28Mii9UlqlZIU1+QJHHGpcQTxtWz
 /FsReGXVFDGexQU9FbGboGCa+MYEB3rbm0gPrZAXnTNxInUgrCflIF8CMOFw26PM5bcqQtQir
 mlZ+2OrEaXqjxjzi+kL+CUibcye79B7TwkKiTx6B8fZnQFeCZo9Ic54/wn0TYOwy6q4Zzdqb2
 nKrmXbiqwrPyCyvtKH11QpjEyvSqc4lyo9ZlXWL00dRAkIyGazN1aRBqWj+JfNjFgA8NZDkiK
 Fm/8VH9a7agpmUdnd13ajQZO6F4WGfownxqo6CBorUiIlKDlOySGutj9wP10aQWPPP4eLC1s9
 QsvIOd6QaMPPUZyt/MJxh9vXJwjxkLidV6Rob7Znc+FoeyPae/AetbDERTmvTJxBRrJ6cDcwK
 9TnnHxbpINpyYseKYP9vczveel52HTwtxt6+7xIi21KmrgI2hQPsNkeqTbfdY3dTAWLsEE+zd
 RaphhBCHLwQvLzPgWD6v84y3PHK2hC4PRotnfTvsMAy7Hdt201XoCnD3LsLjU9VM3ex8GFtEN
 H/+9CN6soVQkeNdIOe1USIzG11t3yzIVzIB1bpuRsezHSmxhfOIjVUebFX2O6hADjCqhgSMjd
 AeDccSkIwakXisi7xPKcAyMVhE+VF5cTMc+vmcO0kCeR6BlsM109atY7xm3PKE4/165uuml1c
 Qq0MfH/+9Lpo6NfcuXCW6F7v8sv0QTW534Ure8giaE1ofZLIFoeXVAom8cJqEPr3A2QZ1JWc0
 gWCUzGTJNptAMwsw+EmXAa6x6wxDXNIOy3pJXPEOF8B391utvtlibpruEdxUTG+h5AKpyv6zg
 XtRD9BsURBAKAbwmdLXyzXc0KEN/4/uMRr9XkDG5mAN8Xno56qhXKS0mhFyVlpNlPbPus40VV
 2SvcBLCLy/CvVjJz+3M3AfSLouiqF4kAtgBcrV3RDiwLEBdRxUq8a5NNH9IFRfiCN0QmUOV3i
 OGLSa/CvKeclmf2Tc2FCczq0nbLo7v9m8fBHk3/YOM6S3ViIyvo9pJAh9aFJEq7vQ2u2AMUIQ
 ZPsevXRzfq36SfbRbM4FOkZFvZ17oHcvq8oFCPiEC9eQh0XWO7JPXAOI2BncAL310Q/eAeAyt
 XFxSMy69hznbzhKC5M/2BZtZZXiniySrVrcU2oNRFKkr6pFizzfN2aQn0bq78NaS92Z+0Rhyn
 n5Or/USOSESAzLkhMRPVObejGV1UuFsYCapfblQkq55W2Ii8NpCfxZGvs6RY7saveBVTX9BqQ
 uxMK9N2ahnAvpSO+dYfHid+0X2lY=

Am Donnerstag, dem 13.03.2025 um 21:40 +1100 schrieb Balbir Singh:
> On 3/13/25 20:22, Bert Karwatzki wrote:
> > Am Mittwoch, dem 12.03.2025 um 12:24 +1100 schrieb Balbir Singh:
> > > > >
> > > > > >
> > > > > > As a sidenote, I've tested several kernel with nokaslr as comm=
and line parameter
> > > > > > (6.1.128, 6.8.12, 6.12.17 (the debian sid distributional kerne=
l)) and nokaslr is
> > > > > > not recognized as a command line parameter in any of them
> > > > > >
> > > > >
> > > > > Please see my comment above about booting. How did you check if =
nokaslr is being
> > > > > recognized, is it via looking up dmesg?
> > > > >
> > > > When I boot with nokaslr I get the following messages in dmesg
> > > > [    T0] Unknown kernel command line parameters "nokaslr
> > > > BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc5-next-20250307-master", will =
be passed to
> > > > user space.
> > > >
> > > > This also happens when I use the debian kernel with standard .conf=
ig
> > >
> > > That is quite strange, I can see nokaslr handling in choose_random_l=
ocation() in
> > > arch/x86/boot/compressed/kaslr.c (which depends on CONFIG_RANDOMIZE_=
BASE)
> > >
> > > Thanks,
> > > Balbir
> >
> > The command line parameter nokaslr does actually work, I tested that b=
y booting
> > the kernel with and without nokaslr and checked /proc/iomem for the ph=
ysical
> > address of the kernel. With nokalsr it's always at 0x1200000.
> >
> > The warning message in the code
> > 	if (cmdline_find_option_bool("nokaslr")) {
> > 		warn("KASLR disabled: 'nokaslr' on cmdline.");
> > 		return;
> > 	}
> > on the other hand is not shown, because warn is basically __putstr() w=
hich
> > outputs to the serial console and the screen, not the log buffer (Whic=
h we do
> > not have this early in boot anyway, I assume).
> >
> > So with this solved I tested stellaris with a kernel without CONFIG_PC=
I_P2PDMA
> > and nokaslr and found the same buggy behaviour (i.e. laggy input while=
 stellaris
> > is running).
> >
> Thanks, the system/game is not working correctly accessing memory at 64 =
TiB
>
> I am beginning to wonder what your physical address bits are set to?
> I can't figure out from lspci, the capabilities of the iommu on your lap=
top
>
> Could you please share your full dmesg/lspci before and after the patch/=
nokaslr
> command line.
>
> Here is the what I know so far and based on some search I did, I could f=
ind
> your laptop might have a CPU like this one
> https://openbenchmarking.org/s/AMD+Ryzen+7+3750H
>
> It has 43 bits of physical address and sev supported and IIRC sev can ch=
ange the
> amount of physical memory accessible, but I am surprised to see that 0xa=
ff...
> which is the 10TiB range is accessible (44 bits) and the 64 TiB may not =
be.
> I am keen to know if the system works or is it just the game that is slu=
ggiesh?
> Does graphics work in general, do other games work?
>
> The arch/x86/mm code assumes we have 46 or 52 bits of physically address=
able
> bits. There are experts who can correct me if I missed anything in my
> analysis.
>
> It seems like kaslr has been hiding the issue that exists on your laptop=
.
>
> Balbir
>
> PS: We could try some other experiments once we have the full dmesg and =
also get
> help from other experts.

According to /proc/cpuinfo my CPU has 48 phsical address bits:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 25
model		: 80
model name	: AMD Ryzen 7 5800H with Radeon Graphics
stepping	: 0
microcode	: 0xa50000c
cpu MHz		: 2288.915
cache size	: 512 KB
physical id	: 0
siblings	: 16
core id		: 0
cpu cores	: 8
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 16
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb =
rdtscp
lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid extd_apicid aper=
fmperf
rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe popcn=
t aes
xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a
misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core
perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba i=
brs
ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a rds=
eed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru
wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushb=
yasid
decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctr=
l umip
pku ospke vaes vpclmulqdq rdpid overflow_recov succor smca fsrm debug_swap
bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso
ibpb_no_ret
bogomips	: 6387.97
TLB size	: 2560 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

This is the dmesg,lspci and /proc/iomem from v6.14-rc6 (without
CONFIG_PCI_P2PDMA) booted with nokaslr:

$ dmesg
[    T0] Linux version 6.14.0-rc6-nop2pdma (bert@lisa) (gcc (Debian 14.2.0=
-17)
14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #566 SMP PREEMPT_RT Wed Mar=
 12
21:44:08 CET 2025
[    T0] Command line: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc6-nop2pdma noka=
slr
root=3DUUID=3D73e0f015-c115-4eb2-92cb-dbf7da2b6112 ro clocksource=3Dhpet
amdgpu.noretry=3D0
[    T0] BIOS-provided physical RAM map:
[    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    T0] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    T0] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfefff] usable
[    T0] BIOS-e820: [mem 0x0000000009bff000-0x000000000a000fff] reserved
[    T0] BIOS-e820: [mem 0x000000000a001000-0x000000000a1fffff] usable
[    T0] BIOS-e820: [mem 0x000000000a200000-0x000000000a20efff] ACPI NVS
[    T0] BIOS-e820: [mem 0x000000000a20f000-0x00000000e9e1ffff] usable
[    T0] BIOS-e820: [mem 0x00000000e9e20000-0x00000000eb33efff] reserved
[    T0] BIOS-e820: [mem 0x00000000eb33f000-0x00000000eb39efff] ACPI data
[    T0] BIOS-e820: [mem 0x00000000eb39f000-0x00000000eb556fff] ACPI NVS
[    T0] BIOS-e820: [mem 0x00000000eb557000-0x00000000ed1fefff] reserved
[    T0] BIOS-e820: [mem 0x00000000ed1ff000-0x00000000edffffff] usable
[    T0] BIOS-e820: [mem 0x00000000ee000000-0x00000000f7ffffff] reserved
[    T0] BIOS-e820: [mem 0x00000000fd000000-0x00000000fdffffff] reserved
[    T0] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    T0] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    T0] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    T0] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    T0] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    T0] BIOS-e820: [mem 0x00000000fedc4000-0x00000000fedc9fff] reserved
[    T0] BIOS-e820: [mem 0x00000000fedcc000-0x00000000fedcefff] reserved
[    T0] BIOS-e820: [mem 0x00000000fedd5000-0x00000000fedd5fff] reserved
[    T0] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    T0] BIOS-e820: [mem 0x0000000100000000-0x0000000fee2fffff] usable
[    T0] BIOS-e820: [mem 0x0000000fee300000-0x000000100fffffff] reserved
[    T0] NX (Execute Disable) protection: active
[    T0] APIC: Static calls initialized
[    T0] e820: update [mem 0xe5e58018-0xe5e65857] usable =3D=3D> usable
[    T0] extended physical RAM map:
[    T0] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] u=
sable
[    T0] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff]
reserved
[    T0] reserve setup_data: [mem 0x0000000000100000-0x0000000009bfefff] u=
sable
[    T0] reserve setup_data: [mem 0x0000000009bff000-0x000000000a000fff]
reserved
[    T0] reserve setup_data: [mem 0x000000000a001000-0x000000000a1fffff] u=
sable
[    T0] reserve setup_data: [mem 0x000000000a200000-0x000000000a20efff] A=
CPI
NVS
[    T0] reserve setup_data: [mem 0x000000000a20f000-0x00000000e5e58017] u=
sable
[    T0] reserve setup_data: [mem 0x00000000e5e58018-0x00000000e5e65857] u=
sable
[    T0] reserve setup_data: [mem 0x00000000e5e65858-0x00000000e9e1ffff] u=
sable
[    T0] reserve setup_data: [mem 0x00000000e9e20000-0x00000000eb33efff]
reserved
[    T0] reserve setup_data: [mem 0x00000000eb33f000-0x00000000eb39efff] A=
CPI
data
[    T0] reserve setup_data: [mem 0x00000000eb39f000-0x00000000eb556fff] A=
CPI
NVS
[    T0] reserve setup_data: [mem 0x00000000eb557000-0x00000000ed1fefff]
reserved
[    T0] reserve setup_data: [mem 0x00000000ed1ff000-0x00000000edffffff] u=
sable
[    T0] reserve setup_data: [mem 0x00000000ee000000-0x00000000f7ffffff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fd000000-0x00000000fdffffff]
reserved
[    T0] reserve setup_data: [mem 0x00000000feb80000-0x00000000fec01fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fed40000-0x00000000fed44fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed8ffff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fedc4000-0x00000000fedc9fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fedcc000-0x00000000fedcefff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fedd5000-0x00000000fedd5fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff]
reserved
[    T0] reserve setup_data: [mem 0x0000000100000000-0x0000000fee2fffff] u=
sable
[    T0] reserve setup_data: [mem 0x0000000fee300000-0x000000100fffffff]
reserved
[    T0] efi: EFI v2.7 by American Megatrends
[    T0] efi: ACPI=3D0xeb540000 ACPI 2.0=3D0xeb540014 TPMFinalLog=3D0xeb50=
c000
SMBIOS=3D0xed020000 SMBIOS 3.0=3D0xed01f000 MEMATTR=3D0xe6fa0018 ESRT=3D0x=
e87cb898
INITRD=3D0xe5e66518 RNG=3D0xeb351018 TPMEventLog=3D0xeb341018
[    T0] random: crng init done
[    T0] efi: Remove mem54: MMIO range=3D[0xf0000000-0xf7ffffff] (128MB) f=
rom e820
map
[    T0] e820: remove [mem 0xf0000000-0xf7ffffff] reserved
[    T0] efi: Remove mem55: MMIO range=3D[0xfd000000-0xfdffffff] (16MB) fr=
om e820
map
[    T0] e820: remove [mem 0xfd000000-0xfdffffff] reserved
[    T0] efi: Remove mem56: MMIO range=3D[0xfeb80000-0xfec01fff] (0MB) fro=
m e820
map
[    T0] e820: remove [mem 0xfeb80000-0xfec01fff] reserved
[    T0] efi: Not removing mem57: MMIO range=3D[0xfec10000-0xfec10fff] (4K=
B) from
e820 map
[    T0] efi: Not removing mem58: MMIO range=3D[0xfed00000-0xfed00fff] (4K=
B) from
e820 map
[    T0] efi: Not removing mem59: MMIO range=3D[0xfed40000-0xfed44fff] (20=
KB) from
e820 map
[    T0] efi: Not removing mem60: MMIO range=3D[0xfed80000-0xfed8ffff] (64=
KB) from
e820 map
[    T0] efi: Not removing mem61: MMIO range=3D[0xfedc4000-0xfedc9fff] (24=
KB) from
e820 map
[    T0] efi: Not removing mem62: MMIO range=3D[0xfedcc000-0xfedcefff] (12=
KB) from
e820 map
[    T0] efi: Not removing mem63: MMIO range=3D[0xfedd5000-0xfedd5fff] (4K=
B) from
e820 map
[    T0] efi: Remove mem64: MMIO range=3D[0xff000000-0xffffffff] (16MB) fr=
om e820
map
[    T0] e820: remove [mem 0xff000000-0xffffffff] reserved
[    T0] SMBIOS 3.3.0 present.
[    T0] DMI: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, B=
IOS
E158LAMS.107 11/10/2021
[    T0] DMI: Memory slots populated: 2/2
[    T0] tsc: Fast TSC calibration using PIT
[    T0] tsc: Detected 3194.072 MHz processor
[    T0] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> reserved
[    T0] e820: remove [mem 0x000a0000-0x000fffff] usable
[    T0] last_pfn =3D 0xfee300 max_arch_pfn =3D 0x400000000
[    T0] MTRR map: 5 entries (3 fixed + 2 variable; max 20), built from 9
variable MTRRs
[    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    T0] e820: update [mem 0xf0000000-0xffffffff] usable =3D=3D> reserved
[    T0] last_pfn =3D 0xee000 max_arch_pfn =3D 0x400000000
[    T0] esrt: Reserving ESRT space from 0x00000000e87cb898 to
0x00000000e87cb8d0.
[    T0] e820: update [mem 0xe87cb000-0xe87cbfff] usable =3D=3D> reserved
[    T0] Using GB pages for direct mapping
[    T0] Secure boot disabled
[    T0] RAMDISK: [mem 0xdc45f000-0xded61fff]
[    T0] ACPI: Early table checksum verification disabled
[    T0] ACPI: RSDP 0x00000000EB540014 000024 (v02 MSI_NB)
[    T0] ACPI: XSDT 0x00000000EB53F728 000114 (v01 MSI_NB MEGABOOK 0107200=
9 AMI
01000013)
[    T0] ACPI: FACP 0x00000000EB390000 000114 (v06 MSI_NB MEGABOOK 0107200=
9 AMI
00010013)
[    T0] ACPI: DSDT 0x00000000EB383000 00C50C (v02 MSI_NB MEGABOOK 0107200=
9 INTL
20190509)
[    T0] ACPI: FACS 0x00000000EB50A000 000040
[    T0] ACPI: SLIC 0x00000000EB39E000 000176 (v01 MSI_NB MEGABOOK 0107200=
9 AMI
01000013)
[    T0] ACPI: SSDT 0x00000000EB396000 0072B0 (v02 AMD    AmdTable 0000000=
2 MSFT
04000000)
[    T0] ACPI: IVRS 0x00000000EB395000 0001A4 (v02 AMD    AmdTable 0000000=
1 AMD
00000000)
[    T0] ACPI: SSDT 0x00000000EB391000 003A21 (v01 AMD    AMD AOD  0000000=
1 INTL
20190509)
[    T0] ACPI: FIDT 0x00000000EB382000 00009C (v01 MSI_NB MEGABOOK 0107200=
9 AMI
00010013)
[    T0] ACPI: ECDT 0x00000000EB381000 0000C1 (v01 MSI_NB MEGABOOK 0107200=
9 AMI.
00010013)
[    T0] ACPI: MCFG 0x00000000EB380000 00003C (v01 MSI_NB MEGABOOK 0107200=
9 MSFT
00010013)
[    T0] ACPI: HPET 0x00000000EB37F000 000038 (v01 MSI_NB MEGABOOK 0107200=
9 AMI
00000005)
[    T0] ACPI: VFCT 0x00000000EB371000 00D884 (v01 MSI_NB MEGABOOK 0000000=
1 AMD
31504F47)
[    T0] ACPI: BGRT 0x00000000EB370000 000038 (v01 MSI_NB MEGABOOK 0107200=
9 AMI
00010013)
[    T0] ACPI: TPM2 0x00000000EB36F000 00004C (v04 MSI_NB MEGABOOK 0000000=
1 AMI
00000000)
[    T0] ACPI: SSDT 0x00000000EB369000 005354 (v02 AMD    AmdTable 0000000=
1 AMD
00000001)
[    T0] ACPI: CRAT 0x00000000EB368000 000EE8 (v01 AMD    AmdTable 0000000=
1 AMD
00000001)
[    T0] ACPI: CDIT 0x00000000EB367000 000029 (v01 AMD    AmdTable 0000000=
1 AMD
00000001)
[    T0] ACPI: SSDT 0x00000000EB366000 000149 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB364000 00148E (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB362000 00153F (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB361000 000696 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB35F000 001A56 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB35E000 0005DE (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB35A000 0036E9 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: WSMT 0x00000000EB359000 000028 (v01 MSI_NB MEGABOOK 0107200=
9 AMI
00010013)
[    T0] ACPI: APIC 0x00000000EB358000 0000DE (v03 MSI_NB MEGABOOK 0107200=
9 AMI
00010013)
[    T0] ACPI: SSDT 0x00000000EB357000 00008D (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB356000 0008A8 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB355000 0001B7 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB354000 0007B1 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB353000 00097D (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: FPDT 0x00000000EB352000 000044 (v01 MSI_NB A M I    0107200=
9 AMI
01000013)
[    T0] ACPI: Reserving FACP table memory at [mem 0xeb390000-0xeb390113]
[    T0] ACPI: Reserving DSDT table memory at [mem 0xeb383000-0xeb38f50b]
[    T0] ACPI: Reserving FACS table memory at [mem 0xeb50a000-0xeb50a03f]
[    T0] ACPI: Reserving SLIC table memory at [mem 0xeb39e000-0xeb39e175]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb396000-0xeb39d2af]
[    T0] ACPI: Reserving IVRS table memory at [mem 0xeb395000-0xeb3951a3]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb391000-0xeb394a20]
[    T0] ACPI: Reserving FIDT table memory at [mem 0xeb382000-0xeb38209b]
[    T0] ACPI: Reserving ECDT table memory at [mem 0xeb381000-0xeb3810c0]
[    T0] ACPI: Reserving MCFG table memory at [mem 0xeb380000-0xeb38003b]
[    T0] ACPI: Reserving HPET table memory at [mem 0xeb37f000-0xeb37f037]
[    T0] ACPI: Reserving VFCT table memory at [mem 0xeb371000-0xeb37e883]
[    T0] ACPI: Reserving BGRT table memory at [mem 0xeb370000-0xeb370037]
[    T0] ACPI: Reserving TPM2 table memory at [mem 0xeb36f000-0xeb36f04b]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb369000-0xeb36e353]
[    T0] ACPI: Reserving CRAT table memory at [mem 0xeb368000-0xeb368ee7]
[    T0] ACPI: Reserving CDIT table memory at [mem 0xeb367000-0xeb367028]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb366000-0xeb366148]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb364000-0xeb36548d]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb362000-0xeb36353e]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb361000-0xeb361695]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35f000-0xeb360a55]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35e000-0xeb35e5dd]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35a000-0xeb35d6e8]
[    T0] ACPI: Reserving WSMT table memory at [mem 0xeb359000-0xeb359027]
[    T0] ACPI: Reserving APIC table memory at [mem 0xeb358000-0xeb3580dd]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb357000-0xeb35708c]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb356000-0xeb3568a7]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb355000-0xeb3551b6]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb354000-0xeb3547b0]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb353000-0xeb35397c]
[    T0] ACPI: Reserving FPDT table memory at [mem 0xeb352000-0xeb352043]
[    T0] Zone ranges:
[    T0]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    T0]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    T0]   Normal   [mem 0x0000000100000000-0x0000000fee2fffff]
[    T0]   Device   empty
[    T0] Movable zone start for each node
[    T0] Early memory node ranges
[    T0]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    T0]   node   0: [mem 0x0000000000100000-0x0000000009bfefff]
[    T0]   node   0: [mem 0x000000000a001000-0x000000000a1fffff]
[    T0]   node   0: [mem 0x000000000a20f000-0x00000000e9e1ffff]
[    T0]   node   0: [mem 0x00000000ed1ff000-0x00000000edffffff]
[    T0]   node   0: [mem 0x0000000100000000-0x0000000fee2fffff]
[    T0] Initmem setup node 0 [mem 0x0000000000001000-0x0000000fee2fffff]
[    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    T0] On node 0, zone DMA: 96 pages in unavailable ranges
[    T0] On node 0, zone DMA32: 1026 pages in unavailable ranges
[    T0] On node 0, zone DMA32: 15 pages in unavailable ranges
[    T0] On node 0, zone DMA32: 13279 pages in unavailable ranges
[    T0] On node 0, zone Normal: 8192 pages in unavailable ranges
[    T0] On node 0, zone Normal: 7424 pages in unavailable ranges
[    T0] ACPI: PM-Timer IO Port: 0x808
[    T0] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    T0] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
[    T0] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 24-55
[    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    T0] ACPI: Using ACPI (MADT) for SMP configuration information
[    T0] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    T0] e820: update [mem 0xe62ee000-0xe63e1fff] usable =3D=3D> reserved
[    T0] CPU topo: Max. logical packages:   1
[    T0] CPU topo: Max. logical dies:       1
[    T0] CPU topo: Max. dies per package:   1
[    T0] CPU topo: Max. threads per core:   2
[    T0] CPU topo: Num. cores per package:     8
[    T0] CPU topo: Num. threads per package:  16
[    T0] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    T0] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x0000=
0fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000f=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0x09bff000-0x0a00=
0fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a20=
efff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xe5e58000-0xe5e5=
8fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xe5e65000-0xe5e6=
5fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xe62ee000-0xe63e=
1fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xe87cb000-0xe87c=
bfff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xe9e20000-0xeb33=
efff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xeb33f000-0xeb39=
efff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xeb39f000-0xeb55=
6fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xeb557000-0xed1f=
efff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xee000000-0xefff=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfec0=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0xfec1=
0fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0xfecf=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed0=
0fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed3=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed40000-0xfed4=
4fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed45000-0xfed7=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed8=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed90000-0xfedc=
3fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedc4000-0xfedc=
9fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedca000-0xfedc=
bfff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedcc000-0xfedc=
efff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedcf000-0xfedd=
4fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedd5000-0xfedd=
5fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedd6000-0xffff=
ffff]
[    T0] [mem 0xf0000000-0xfec0ffff] available for PCI devices
[    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffff=
ffff,
max_idle_ns: 1910969940391419 ns
[    T0] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node=
_ids:1
[    T0] percpu: Embedded 50 pages/cpu s166512 r8192 d30096 u262144
[    T0] pcpu-alloc: s166512 r8192 d30096 u262144 alloc=3D1*2097152
[    T0] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 =
15
[    T0] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc6-nop2pd=
ma
nokaslr root=3DUUID=3D73e0f015-c115-4eb2-92cb-dbf7da2b6112 ro clocksource=
=3Dhpet
amdgpu.noretry=3D0
[    T0] Unknown kernel command line parameters "nokaslr
BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc6-nop2pdma", will be passed to user sp=
ace.
[    T0] printk: log buffer data + meta data: 131072 + 458752 =3D 589824 b=
ytes
[    T0] Dentry cache hash table entries: 8388608 (order: 14, 67108864 byt=
es,
linear)
[    T0] Inode-cache hash table entries: 4194304 (order: 13, 33554432 byte=
s,
linear)
[    T0] Built 1 zonelists, mobility grouping on.  Total pages: 16616111
[    T0] mem auto-init: stack:off, heap alloc:off, heap free:off
[    T0] software IO TLB: area num 16.
[    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, Nodes=
=3D1
[    T0] Dynamic Preempt: lazy
[    T0] rcu: Preemptible hierarchical RCU implementation.
[    T0] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    T0] rcu: 	RCU_SOFTIRQ processing moved to rcuc kthreads.
[    T0] 	No expedited grace period (rcu_normal_after_boot).
[    T0] 	Trampoline variant of Tasks RCU enabled.
[    T0] 	Tracing variant of Tasks RCU enabled.
[    T0] rcu: RCU calculated value of scheduler-enlistment delay is 100 ji=
ffies.
[    T0] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=3D1
rcu_task_cpu_ids=3D16.
[    T0] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adju=
st=3D1
rcu_task_cpu_ids=3D16.
[    T0] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
[    T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    T0] Console: colour dummy device 80x25
[    T0] printk: legacy console [tty0] enabled
[    T0] ACPI: Core revision 20240827
[    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 133484873504 ns
[    T0] APIC: Switch to symmetric I/O mode setup
[    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:0xa0
[    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:0xa0
[    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:0xa0
[    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:0xa0
[    T0] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade, EFR2:0x0
[    T0] x2apic enabled
[    T0] APIC: Switched APIC routing to: cluster x2apic
[    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
[    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:
0x2e0a6a27d99, max_idle_ns: 440795219115 ns
[    T0] Calibrating delay loop (skipped), value calculated using timer
frequency.. 6388.14 BogoMIPS (lpj=3D3194072)
[    T0] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    T0] LVT offset 1 assigned for vector 0xf9
[    T0] LVT offset 2 assigned for vector 0xf4
[    T0] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    T0] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    T0] process: using mwait in idle threads
[    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user poin=
ter
sanitization
[    T0] Spectre V2 : Mitigation: Retpolines
[    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on c=
ontext
switch
[    T0] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    T0] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    T0] Spectre V2 : mitigation: Enabling conditional Indirect Branch
Prediction Barrier
[    T0] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    T0] Speculative Store Bypass: Mitigation: Speculative Store Bypass di=
sabled
via prctl
[    T0] Speculative Return Stack Overflow: IBPB-extending microcode not
applied!
[    T0] Speculative Return Stack Overflow: WARNING: See
https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitig=
ation
options.
[    T0] Speculative Return Stack Overflow: Vulnerable: Safe RET, no micro=
code
[    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point regi=
sters'
[    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    T0] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User
registers'
[    T0] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User regis=
ters'
[    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    T0] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    T0] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    T0] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes=
,
using 'compacted' format.
[    T0] Freeing SMP alternatives memory: 32K
[    T0] pid_max: default: 32768 minimum: 301
[    T0] LSM: initializing lsm=3Dcapability,apparmor
[    T0] AppArmor: AppArmor initialized
[    T0] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes,
linear)
[    T0] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 by=
tes,
linear)
[    T1] smpboot: CPU0: AMD Ryzen 7 5800H with Radeon Graphics (family: 0x=
19,
model: 0x50, stepping: 0x0)
[    T1] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    T1] ... version:                0
[    T1] ... bit width:              48
[    T1] ... generic registers:      6
[    T1] ... value mask:             0000ffffffffffff
[    T1] ... max period:             00007fffffffffff
[    T1] ... fixed-purpose events:   0
[    T1] ... event mask:             000000000000003f
[    T1] signal: max sigframe size: 3376
[    T1] rcu: Hierarchical SRCU implementation.
[    T1] rcu: 	Max phase no-delay instances is 400.
[    T1] Timer migration: 2 hierarchy levels; 8 children per group; 2 cros=
snode
level
[   T11] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    T1] smp: Bringing up secondary CPUs ...
[    T1] smpboot: x86: Booting SMP configuration:
[    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1  #3  #=
5  #7
#9 #11 #13 #15
[    T1] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    T1] smp: Brought up 1 node, 16 CPUs
[    T1] smpboot: Total of 16 processors activated (102210.30 BogoMIPS)
[  T147] node 0 deferred pages initialised in 57ms
[    T1] Memory: 65175916K/66464444K available (12095K kernel code, 1193K
rwdata, 4296K rodata, 2024K init, 752K bss, 1274508K reserved, 0K cma-rese=
rved)
[    T1] devtmpfs: initialized
[    T1] x86/mm: Memory block size: 128MB
[    T1] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20efff]
(61440 bytes)
[    T1] ACPI: PM: Registering ACPI NVS region [mem 0xeb39f000-0xeb556fff]
(1802240 bytes)
[    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 1911260446275000 ns
[    T1] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    T1] pinctrl core: initialized pinctrl subsystem
[    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    T1] audit: initializing netlink subsys (disabled)
[  T165] audit: type=3D2000 audit(1741857009.000:1): state=3Dinitialized
audit_enabled=3D0 res=3D1
[    T1] thermal_sys: Registered thermal governor 'fair_share'
[    T1] thermal_sys: Registered thermal governor 'bang_bang'
[    T1] thermal_sys: Registered thermal governor 'step_wise'
[    T1] thermal_sys: Registered thermal governor 'user_space'
[    T1] thermal_sys: Registered thermal governor 'power_allocator'
[    T1] cpuidle: using governor ladder
[    T1] cpuidle: using governor teo
[    T1] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    T1] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000000) for domai=
n 0000
[bus 00-7f]
[    T1] PCI: Using configuration type 1 for base access
[    T1] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    T1] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    T1] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    T1] ACPI: Added _OSI(Module Device)
[    T1] ACPI: Added _OSI(Processor Device)
[    T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    T1] ACPI: 16 ACPI AML tables successfully acquired and loaded
[    T1] ACPI: EC: EC started
[    T1] ACPI: EC: interrupt blocked
[    T1] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    T1] ACPI: EC: Boot ECDT EC used to handle transactions
[    T1] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    T1] ACPI: Interpreter enabled
[    T1] ACPI: PM: (supports S0 S4 S5)
[    T1] ACPI: Using IOAPIC for interrupt routing
[    T1] PCI: Using host bridge windows from ACPI; if necessary, use "pci=
=3Dnocrs"
and report a bug
[    T1] PCI: Using E820 reservations for host bridge windows
[    T1] ACPI: Enabled 1 GPEs in block 00 to 1F
[    T1] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    T1] ACPI: \_SB_.PCI0.GPP0.SWUS.M237: New power resource
[    T1] ACPI: \_SB_.PCI0.GPP0.SWUS.SWDS.M237: New power resource
[    T1] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resource
[    T1] ACPI: \_SB_.PCI0.GP17.XHC0.P3U0: New power resource
[    T1] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resource
[    T1] ACPI: \_SB_.PCI0.GP17.XHC1.P3U1: New power resource
[    T1] ACPI: \_SB_.PCI0.GPP6.P0NV: New power resource
[    T1] ACPI: \_SB_.PCI0.GPP5.P0NX: New power resource
[    T1] ACPI: \_SB_.PRWB: New power resource
[    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    T1] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
Segments MSI HPX-Type3]
[    T1] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    T1] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER
PCIeCapability]
[    T1] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf0000000-0xf7ffffff=
] for
domain 0000 [bus 00-7f] only partially covers this bridge
[    T1] PCI host bridge to bus 0000:00
[    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    T1] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    T1] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff win=
dow]
[    T1] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfcffffff win=
dow]
[    T1] pci_bus 0000:00: root bus resource [mem 0x1010000000-0xffffffffff
window]
[    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    T1] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600 conventional=
 PCI
endpoint
[    T1] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:01.1: [1022:1633] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    T1] pci 0000:00:01.1:   bridge window [mem 0xfca00000-0xfccfffff]
[    T1] pci 0000:00:01.1:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    T1] pci 0000:00:02.1:   bridge window [mem 0xfe30300000-0xfe304fffff =
64bit
pref]
[    T1] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    T1] pci 0000:00:02.2:   bridge window [io  0xf000-0xffff]
[    T1] pci 0000:00:02.2:   bridge window [mem 0xfcf00000-0xfcffffff]
[    T1] pci 0000:00:02.2: enabling Extended Tags
[    T1] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:02.3: [1022:1634] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    T1] pci 0000:00:02.3:   bridge window [mem 0xfce00000-0xfcefffff]
[    T1] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:02.4: [1022:1634] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    T1] pci 0000:00:02.4:   bridge window [mem 0xfcd00000-0xfcdfffff]
[    T1] pci 0000:00:02.4: enabling Extended Tags
[    T1] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    T1] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    T1] pci 0000:00:08.1:   bridge window [mem 0xfc500000-0xfc9fffff]
[    T1] pci 0000:00:08.1:   bridge window [mem 0xfe20000000-0xfe301fffff =
64bit
pref]
[    T1] pci 0000:00:08.1: enabling Extended Tags
[    T1] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional=
 PCI
endpoint
[    T1] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.0: [1022:166a] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.1: [1022:166b] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.2: [1022:166c] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.3: [1022:166d] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.4: [1022:166e] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.5: [1022:166f] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.6: [1022:1670] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.7: [1022:1671] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400 PCIe Switch
Upstream Port
[    T1] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfcc03fff]
[    T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    T1] pci 0000:01:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
[    T1] pci 0000:01:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limited b=
y 8.0
GT/s PCIe x8 link at 0000:00:01.1 (capable of 126.024 Gb/s with 16.0 GT/s =
PCIe
x8 link)
[    T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    T1] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400 PCIe Switch
Downstream Port
[    T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    T1] pci 0000:02:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
[    T1] pci 0000:02:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    T1] pci 0000:03:00.0: [1002:73ff] type 00 class 0x038000 PCIe Legacy
Endpoint
[    T1] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdffffffff 64bit pref=
]
[    T1] pci 0000:03:00.0: BAR 2 [mem 0xfe00000000-0xfe0fffffff 64bit pref=
]
[    T1] pci 0000:03:00.0: BAR 5 [mem 0xfca00000-0xfcafffff]
[    T1] pci 0000:03:00.0: ROM [mem 0xfcb00000-0xfcb1ffff pref]
[    T1] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    T1] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwidth, limited b=
y 8.0
GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 Gb/s with 16.0 GT/s =
PCIe
x16 link)
[    T1] pci 0000:03:00.1: [1002:ab28] type 00 class 0x040300 PCIe Legacy
Endpoint
[    T1] pci 0000:03:00.1: BAR 0 [mem 0xfcb20000-0xfcb23fff]
[    T1] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    T1] pci 0000:04:00.0: [14c3:0608] type 00 class 0x028000 PCIe Endpoin=
t
[    T1] pci 0000:04:00.0: BAR 0 [mem 0xfe30300000-0xfe303fffff 64bit pref=
]
[    T1] pci 0000:04:00.0: BAR 2 [mem 0xfe30400000-0xfe30403fff 64bit pref=
]
[    T1] pci 0000:04:00.0: BAR 4 [mem 0xfe30404000-0xfe30404fff 64bit pref=
]
[    T1] pci 0000:04:00.0: supports D1 D2
[    T1] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    T1] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000 PCIe Endpoin=
t
[    T1] pci 0000:05:00.0: BAR 0 [io  0xf000-0xf0ff]
[    T1] pci 0000:05:00.0: BAR 2 [mem 0xfcf04000-0xfcf04fff 64bit]
[    T1] pci 0000:05:00.0: BAR 4 [mem 0xfcf00000-0xfcf03fff 64bit]
[    T1] pci 0000:05:00.0: supports D1 D2
[    T1] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    T1] pci 0000:06:00.0: [2646:5013] type 00 class 0x010802 PCIe Endpoin=
t
[    T1] pci 0000:06:00.0: BAR 0 [mem 0xfce00000-0xfce03fff 64bit]
[    T1] pci 0000:06:00.0: 31.504 Gb/s available PCIe bandwidth, limited b=
y 8.0
GT/s PCIe x4 link at 0000:00:02.3 (capable of 63.012 Gb/s with 16.0 GT/s P=
CIe x4
link)
[    T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    T1] pci 0000:07:00.0: [c0a9:2263] type 00 class 0x010802 PCIe Endpoin=
t
[    T1] pci 0000:07:00.0: BAR 0 [mem 0xfcd00000-0xfcd03fff 64bit]
[    T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    T1] pci 0000:08:00.0: [1002:1638] type 00 class 0x030000 PCIe Legacy
Endpoint
[    T1] pci 0000:08:00.0: BAR 0 [mem 0xfe20000000-0xfe2fffffff 64bit pref=
]
[    T1] pci 0000:08:00.0: BAR 2 [mem 0xfe30000000-0xfe301fffff 64bit pref=
]
[    T1] pci 0000:08:00.0: BAR 4 [io  0xe000-0xe0ff]
[    T1] pci 0000:08:00.0: BAR 5 [mem 0xfc900000-0xfc97ffff]
[    T1] pci 0000:08:00.0: enabling Extended Tags
[    T1] pci 0000:08:00.0: PME# supported from D1 D2 D3hot D3cold
[    T1] pci 0000:08:00.1: [1002:1637] type 00 class 0x040300 PCIe Legacy
Endpoint
[    T1] pci 0000:08:00.1: BAR 0 [mem 0xfc9c8000-0xfc9cbfff]
[    T1] pci 0000:08:00.1: enabling Extended Tags
[    T1] pci 0000:08:00.1: PME# supported from D1 D2 D3hot D3cold
[    T1] pci 0000:08:00.2: [1022:15df] type 00 class 0x108000 PCIe Endpoin=
t
[    T1] pci 0000:08:00.2: BAR 2 [mem 0xfc800000-0xfc8fffff]
[    T1] pci 0000:08:00.2: BAR 5 [mem 0xfc9ce000-0xfc9cffff]
[    T1] pci 0000:08:00.2: enabling Extended Tags
[    T1] pci 0000:08:00.3: [1022:1639] type 00 class 0x0c0330 PCIe Endpoin=
t
[    T1] pci 0000:08:00.3: BAR 0 [mem 0xfc700000-0xfc7fffff 64bit]
[    T1] pci 0000:08:00.3: enabling Extended Tags
[    T1] pci 0000:08:00.3: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:08:00.4: [1022:1639] type 00 class 0x0c0330 PCIe Endpoin=
t
[    T1] pci 0000:08:00.4: BAR 0 [mem 0xfc600000-0xfc6fffff 64bit]
[    T1] pci 0000:08:00.4: enabling Extended Tags
[    T1] pci 0000:08:00.4: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:08:00.5: [1022:15e2] type 00 class 0x048000 PCIe Endpoin=
t
[    T1] pci 0000:08:00.5: BAR 0 [mem 0xfc980000-0xfc9bffff]
[    T1] pci 0000:08:00.5: enabling Extended Tags
[    T1] pci 0000:08:00.5: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:08:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoin=
t
[    T1] pci 0000:08:00.6: BAR 0 [mem 0xfc9c0000-0xfc9c7fff]
[    T1] pci 0000:08:00.6: enabling Extended Tags
[    T1] pci 0000:08:00.6: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:08:00.7: [1022:15e4] type 00 class 0x118000 PCIe Endpoin=
t
[    T1] pci 0000:08:00.7: BAR 2 [mem 0xfc500000-0xfc5fffff]
[    T1] pci 0000:08:00.7: BAR 5 [mem 0xfc9cc000-0xfc9cdfff]
[    T1] pci 0000:08:00.7: enabling Extended Tags
[    T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    T1] pci_bus 0000:00: on NUMA node 0
[    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    T1] Low-power S0 idle used by default for system suspend
[    T1] ACPI: EC: interrupt unblocked
[    T1] ACPI: EC: event unblocked
[    T1] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    T1] ACPI: EC: GPE=3D0x3
[    T1] ACPI: \_SB_.PCI0.SBRG.EC__: Boot ECDT EC initialization complete
[    T1] ACPI: \_SB_.PCI0.SBRG.EC__: EC: Used to handle transactions and e=
vents
[    T1] iommu: Default domain type: Passthrough
[    T1] EDAC MC: Ver: 3.0.0
[    T1] efivars: Registered efivars operations
[    T1] PCI: Using ACPI for IRQ routing
[    T1] PCI: pci_cache_line_size set to 64 bytes
[    T1] e820: reserve RAM buffer [mem 0x09bff000-0x0bffffff]
[    T1] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    T1] e820: reserve RAM buffer [mem 0xe5e58018-0xe7ffffff]
[    T1] e820: reserve RAM buffer [mem 0xe62ee000-0xe7ffffff]
[    T1] e820: reserve RAM buffer [mem 0xe87cb000-0xebffffff]
[    T1] e820: reserve RAM buffer [mem 0xe9e20000-0xebffffff]
[    T1] e820: reserve RAM buffer [mem 0xee000000-0xefffffff]
[    T1] e820: reserve RAM buffer [mem 0xfee300000-0xfefffffff]
[    T1] pci 0000:08:00.0: vgaarb: setting as boot VGA device
[    T1] pci 0000:08:00.0: vgaarb: bridge control possible
[    T1] pci 0000:08:00.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[    T1] vgaarb: loaded
[    T1] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    T1] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    T1] clocksource: Switched to clocksource hpet
[    T1] AppArmor: AppArmor Filesystem Enabled
[    T1] pnp: PnP ACPI init
[    T1] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    T1] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    T1] system 00:04: [io  0x040b] has been reserved
[    T1] system 00:04: [io  0x04d6] has been reserved
[    T1] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    T1] system 00:04: [io  0x0c14] has been reserved
[    T1] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    T1] system 00:04: [io  0x0c52] has been reserved
[    T1] system 00:04: [io  0x0c6c] has been reserved
[    T1] system 00:04: [io  0x0c6f] has been reserved
[    T1] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    T1] system 00:04: [io  0x0800-0x089f] has been reserved
[    T1] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    T1] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    T1] system 00:04: [io  0x0900-0x090f] has been reserved
[    T1] system 00:04: [io  0x0910-0x091f] has been reserved
[    T1] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    T1] system 00:04: [mem 0xfec01000-0xfec01fff] could not be reserved
[    T1] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    T1] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    T1] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    T1] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    T1] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    T1] pnp: PnP ACPI: found 5 devices
[    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_id=
le_ns:
2085701024 ns
[    T1] NET: Registered PF_INET protocol family
[    T1] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, li=
near)
[    T1] tcp_listen_portaddr_hash hash table entries: 32768 (order: 8, 131=
0720
bytes, linear)
[    T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes,
linear)
[    T1] TCP established hash table entries: 524288 (order: 10, 4194304 by=
tes,
linear)
[    T1] TCP bind hash table entries: 65536 (order: 10, 5242880 bytes, vma=
lloc
hugepage)
[    T1] TCP: Hash tables configured (established 524288 bind 65536)
[    T1] MPTCP token hash table entries: 65536 (order: 9, 3670016 bytes, l=
inear)
[    T1] UDP hash table entries: 32768 (order: 10, 5242880 bytes, vmalloc
hugepage)
[    T1] UDP-Lite hash table entries: 32768 (order: 10, 5242880 bytes, vma=
lloc
hugepage)
[    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    T1] NET: Registered PF_XDP protocol family
[    T1] pci 0000:00:01.1: bridge window [io  0x1000-0x0fff] to [bus 01-03=
]
add_size 1000
[    T1] pci 0000:00:01.1: bridge window [io  0x1000-0x1fff]: assigned
[    T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    T1] pci 0000:02:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
[    T1] pci 0000:02:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    T1] pci 0000:01:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
[    T1] pci 0000:01:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    T1] pci 0000:00:01.1:   bridge window [io  0x1000-0x1fff]
[    T1] pci 0000:00:01.1:   bridge window [mem 0xfca00000-0xfccfffff]
[    T1] pci 0000:00:01.1:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    T1] pci 0000:00:02.1:   bridge window [mem 0xfe30300000-0xfe304fffff =
64bit
pref]
[    T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    T1] pci 0000:00:02.2:   bridge window [io  0xf000-0xffff]
[    T1] pci 0000:00:02.2:   bridge window [mem 0xfcf00000-0xfcffffff]
[    T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    T1] pci 0000:00:02.3:   bridge window [mem 0xfce00000-0xfcefffff]
[    T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    T1] pci 0000:00:02.4:   bridge window [mem 0xfcd00000-0xfcdfffff]
[    T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    T1] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    T1] pci 0000:00:08.1:   bridge window [mem 0xfc500000-0xfc9fffff]
[    T1] pci 0000:00:08.1:   bridge window [mem 0xfe20000000-0xfe301fffff =
64bit
pref]
[    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    T1] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    T1] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    T1] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    T1] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    T1] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfcffffff window]
[    T1] pci_bus 0000:00: resource 10 [mem 0x1010000000-0xffffffffff windo=
w]
[    T1] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    T1] pci_bus 0000:01: resource 1 [mem 0xfca00000-0xfccfffff]
[    T1] pci_bus 0000:01: resource 2 [mem 0xfc00000000-0xfe0fffffff 64bit =
pref]
[    T1] pci_bus 0000:02: resource 1 [mem 0xfca00000-0xfcbfffff]
[    T1] pci_bus 0000:02: resource 2 [mem 0xfc00000000-0xfe0fffffff 64bit =
pref]
[    T1] pci_bus 0000:03: resource 1 [mem 0xfca00000-0xfcbfffff]
[    T1] pci_bus 0000:03: resource 2 [mem 0xfc00000000-0xfe0fffffff 64bit =
pref]
[    T1] pci_bus 0000:04: resource 2 [mem 0xfe30300000-0xfe304fffff 64bit =
pref]
[    T1] pci_bus 0000:05: resource 0 [io  0xf000-0xffff]
[    T1] pci_bus 0000:05: resource 1 [mem 0xfcf00000-0xfcffffff]
[    T1] pci_bus 0000:06: resource 1 [mem 0xfce00000-0xfcefffff]
[    T1] pci_bus 0000:07: resource 1 [mem 0xfcd00000-0xfcdfffff]
[    T1] pci_bus 0000:08: resource 0 [io  0xe000-0xefff]
[    T1] pci_bus 0000:08: resource 1 [mem 0xfc500000-0xfc9fffff]
[    T1] pci_bus 0000:08: resource 2 [mem 0xfe20000000-0xfe301fffff 64bit =
pref]
[    T1] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    T1] pci 0000:08:00.1: D0 power state depends on 0000:08:00.0
[    T1] pci 0000:08:00.3: extending delay after power-on from D3hot to 20=
 msec
[    T1] pci 0000:08:00.4: extending delay after power-on from D3hot to 20=
 msec
[    T1] PCI: CLS 64 bytes, default 64
[    T1] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[  T158] Trying to unpack rootfs image as initramfs...
[    T1] pci 0000:00:00.0: Adding to iommu group 0
[    T1] pci 0000:00:01.0: Adding to iommu group 1
[    T1] pci 0000:00:01.1: Adding to iommu group 2
[    T1] pci 0000:00:02.0: Adding to iommu group 3
[    T1] pci 0000:00:02.1: Adding to iommu group 4
[    T1] pci 0000:00:02.2: Adding to iommu group 5
[    T1] pci 0000:00:02.3: Adding to iommu group 6
[    T1] pci 0000:00:02.4: Adding to iommu group 7
[    T1] pci 0000:00:08.0: Adding to iommu group 8
[    T1] pci 0000:00:08.1: Adding to iommu group 9
[    T1] pci 0000:00:14.0: Adding to iommu group 10
[    T1] pci 0000:00:14.3: Adding to iommu group 10
[    T1] pci 0000:00:18.0: Adding to iommu group 11
[    T1] pci 0000:00:18.1: Adding to iommu group 11
[    T1] pci 0000:00:18.2: Adding to iommu group 11
[    T1] pci 0000:00:18.3: Adding to iommu group 11
[    T1] pci 0000:00:18.4: Adding to iommu group 11
[    T1] pci 0000:00:18.5: Adding to iommu group 11
[    T1] pci 0000:00:18.6: Adding to iommu group 11
[    T1] pci 0000:00:18.7: Adding to iommu group 11
[    T1] pci 0000:01:00.0: Adding to iommu group 12
[    T1] pci 0000:02:00.0: Adding to iommu group 13
[    T1] pci 0000:03:00.0: Adding to iommu group 14
[    T1] pci 0000:03:00.1: Adding to iommu group 15
[    T1] pci 0000:04:00.0: Adding to iommu group 16
[    T1] pci 0000:05:00.0: Adding to iommu group 17
[    T1] pci 0000:06:00.0: Adding to iommu group 18
[    T1] pci 0000:07:00.0: Adding to iommu group 19
[    T1] pci 0000:08:00.0: Adding to iommu group 20
[    T1] pci 0000:08:00.1: Adding to iommu group 21
[    T1] pci 0000:08:00.2: Adding to iommu group 22
[    T1] pci 0000:08:00.3: Adding to iommu group 23
[    T1] pci 0000:08:00.4: Adding to iommu group 24
[    T1] pci 0000:08:00.5: Adding to iommu group 25
[    T1] pci 0000:08:00.6: Adding to iommu group 26
[    T1] pci 0000:08:00.7: Adding to iommu group 27
[    T1] AMD-Vi: Extended features (0x206d73ef22254ade, 0x0): PPR X2APIC N=
X GT
IA GA PC GA_vAPIC
[    T1] AMD-Vi: Interrupt remapping enabled
[    T1] AMD-Vi: X2APIC enabled
[    T1] AMD-Vi: Virtual APIC enabled
[    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    T1] software IO TLB: mapped [mem 0x00000000e1e58000-0x00000000e5e5800=
0]
(64MB)
[    T1] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms o=
vfl
timer
[    T1] RAPL PMU: hw unit of domain package 2^-16 Joules
[    T1] RAPL PMU: hw unit of domain core 2^-16 Joules
[    T1] LVT offset 0 assigned for vector 0x400
[    T1] perf: AMD IBS detected (0x000003ff)
[   T26] amd_uncore: 4 amd_df counters detected
[   T26] amd_uncore: 6 amd_l3 counters detected
[    T1] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    T1] Initialise system trusted keyrings
[    T1] workingset: timestamp_bits=3D46 max_order=3D24 bucket_order=3D0
[    T1] Key type asymmetric registered
[    T1] Asymmetric key parser 'x509' registered
[    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 2=
51)
[    T1] io scheduler bfq registered
[    T1] pcieport 0000:00:01.1: PME: Signaling with IRQ 43
[    T1] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- Att=
nInd-
PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    T1] pcieport 0000:00:02.1: PME: Signaling with IRQ 44
[    T1] pcieport 0000:00:02.2: PME: Signaling with IRQ 45
[    T1] pcieport 0000:00:02.3: PME: Signaling with IRQ 46
[    T1] pcieport 0000:00:02.4: PME: Signaling with IRQ 47
[    T1] pcieport 0000:00:08.1: PME: Signaling with IRQ 48
[    T1] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: =
no)
[    T1] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:13/LNXVIDEO:00/input/in=
put0
[   T26] Monitor-Mwait will be used to enter C-1 state
[    T1] Estimated ratio of average max frequency by base frequency (times
1024): 1226
[    T1] thermal LNXTHERM:00: registered as thermal_zone0
[    T1] ACPI: thermal: Thermal Zone [THRM] (52 C)
[    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    T1] ACPI: bus type drm_connector registered
[    T1] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0=
x64
irq 1,12
[    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[    T1] serio: i8042 AUX port at 0x60,0x64 irq 12
[    T1] mousedev: PS/2 mouse device common for all mice
[    T1] rtc_cmos 00:01: RTC can wake from S4
[    T1] rtc_cmos 00:01: registered as rtc0
[    T1] rtc_cmos 00:01: setting system clock to 2025-03-13T09:10:09 UTC
(1741857009)
[    T1] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[    T1] efifb: probing for efifb
[    T1] efifb: framebuffer at 0xfe20000000, using 8100k, total 8100k
[    T1] efifb: mode is 1920x1080x32, linelength=3D7680, pages=3D1
[    T1] efifb: scrolling: redraw
[    T1] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[   T11] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input1
[    T1] Console: switching to colour frame buffer device 240x67
[    T1] fb0: EFI VGA frame buffer device
[    T1] NET: Registered PF_INET6 protocol family
[  T158] Freeing initrd memory: 41996K
[    T1] Segment Routing with IPv6
[    T1] In-situ OAM (IOAM) with IPv6
[    T1] mip6: Mobile IPv6
[    T1] NET: Registered PF_PACKET protocol family
[    T1] mpls_gso: MPLS GSO support
[    T1] microcode: Current revision: 0x0a50000c
[    T1] resctrl: L3 allocation detected
[    T1] resctrl: MB allocation detected
[    T1] resctrl: L3 monitoring detected
[    T1] IPI shorthand broadcast: enabled
[    T1] sched_clock: Marking stable (540008745, 1214342)->(557200604, -
15977517)
[    T1] registered taskstats version 1
[    T1] Loading compiled-in X.509 certificates
[    T1] Key type .fscrypt registered
[    T1] Key type fscrypt-provisioning registered
[    T1] AppArmor: AppArmor sha256 policy hashing enabled
[  T159] pci_bus 0000:03: Allocating resources
[    T1] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GP17.M=
P2],
AE_NOT_FOUND (20240827/psargs-332)
[    T1] ACPI Error: Aborting method \_SB.GPIO._EVT due to previous error
(AE_NOT_FOUND) (20240827/psparse-529)
[    T1] clk: Disabling unused clocks
[    T1] PM: genpd: Disabling unused power domains
[    T1] Freeing unused kernel image (initmem) memory: 2024K
[    T1] Write protecting the kernel read-only data: 18432k
[    T1] Freeing unused kernel image (text/rodata gap) memory: 192K
[    T1] Freeing unused kernel image (rodata/data gap) memory: 1848K
[    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    T1] Run /init as init process
[    T1]   with arguments:
[    T1]     /init
[    T1]     nokaslr
[    T1]   with environment:
[    T1]     HOME=3D/
[    T1]     TERM=3Dlinux
[    T1]     BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc6-nop2pdma
[  T377] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revisio=
n 0
[  T377] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port sele=
ction
[  T377] i2c i2c-1: Successfully instantiated SPD at 0x50
[  T377] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb2=
0
[  T389] hid: raw HID events driver (C) Jiri Kosina
[  T364] pcie_mp2_amd 0000:08:00.7: enabling device (0000 -> 0002)
[  T378] r8169 0000:05:00.0 eth0: RTL8168h/8111h, d8:bb:c1:ab:dd:5e, XID 5=
41,
IRQ 52
[  T378] r8169 0000:05:00.0 eth0: jumbo features [frames: 9194 bytes, tx
checksumming: ko]
[  T150] nvme 0000:06:00.0: platform quirk: setting simple suspend
[  T152] nvme 0000:07:00.0: platform quirk: setting simple suspend
[  T152] nvme nvme1: pci function 0000:07:00.0
[  T150] nvme nvme0: pci function 0000:06:00.0
[  T388] ACPI: bus type USB registered
[  T388] usbcore: registered new interface driver usbfs
[  T388] usbcore: registered new interface driver hub
[  T388] usbcore: registered new device driver usb
[  T152] nvme nvme1: missing or invalid SUBNQN field.
[  T150] nvme nvme0: D3 entry latency set to 10 seconds
[  T150] nvme nvme0: 16/0/0 default/read/poll queues
[  T152] nvme nvme1: 15/0/0 default/read/poll queues
[  T154]  nvme0n1: p1 p2 p3 p4
[  T159]  nvme1n1: p1
[  T341] hid-generic 0020:1022:0001.0001: hidraw0: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T341] hid-generic 0020:1022:0001.0002: hidraw1: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T341] hid-generic 0020:1022:0001.0003: hidraw2: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T341] hid-generic 0020:1022:0001.0004: hidraw3: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T341] hid-generic 0020:1022:0001.0005: hidraw4: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T341] hid-generic 0020:1022:0001.0006: hidraw5: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T161] input: PNP0C50:0e 06CB:7E7E Mouse as /devices/platform/AMDI0010:0=
3/i2c-
0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input5
[  T161] input: PNP0C50:0e 06CB:7E7E Touchpad as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0007/input/input6
[  T161] hid-generic 0018:06CB:7E7E.0007: input,hidraw6: I2C HID v1.00 Mou=
se
[PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[  T387] r8169 0000:05:00.0 enp5s0: renamed from eth0
[  T342] hid-sensor-hub 0020:1022:0001.0001: hidraw0: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T342] hid-sensor-hub 0020:1022:0001.0002: hidraw1: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T348] xhci_hcd 0000:08:00.3: xHCI Host Controller
[  T348] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus numbe=
r 1
[  T348] xhci_hcd 0000:08:00.3: hcc params 0x0268ffe5 hci version 0x110 qu=
irks
0x0000020000000010
[  T342] hid-sensor-hub 0020:1022:0001.0003: hidraw2: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T342] hid-sensor-hub 0020:1022:0001.0004: hidraw3: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T348] xhci_hcd 0000:08:00.3: xHCI Host Controller
[  T348] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus numbe=
r 2
[  T348] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[  T342] hid-sensor-hub 0020:1022:0001.0005: hidraw4: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T348] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002=
,
bcdDevice=3D 6.14
[  T348] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNum=
ber=3D1
[  T348] usb usb1: Product: xHCI Host Controller
[  T348] usb usb1: Manufacturer: Linux 6.14.0-rc6-nop2pdma xhci-hcd
[  T348] usb usb1: SerialNumber: 0000:08:00.3
[  T342] hid-sensor-hub 0020:1022:0001.0006: hidraw5: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T348] hub 1-0:1.0: USB hub found
[  T348] hub 1-0:1.0: 4 ports detected
[  T348] usb usb2: We don't know the algorithms for LPM for this host, dis=
abling
LPM.
[  T348] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0003=
,
bcdDevice=3D 6.14
[  T348] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNum=
ber=3D1
[  T348] usb usb2: Product: xHCI Host Controller
[  T348] usb usb2: Manufacturer: Linux 6.14.0-rc6-nop2pdma xhci-hcd
[  T348] usb usb2: SerialNumber: 0000:08:00.3
[  T344] input: PNP0C50:0e 06CB:7E7E Mouse as /devices/platform/AMDI0010:0=
3/i2c-
0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input8
[  T344] input: PNP0C50:0e 06CB:7E7E Touchpad as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0007/input/input9
[  T348] hub 2-0:1.0: USB hub found
[  T348] hub 2-0:1.0: 2 ports detected
[  T344] hid-multitouch 0018:06CB:7E7E.0007: input,hidraw6: I2C HID v1.00 =
Mouse
[PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[  T348] xhci_hcd 0000:08:00.4: xHCI Host Controller
[  T348] xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus numbe=
r 3
[  T348] xhci_hcd 0000:08:00.4: hcc params 0x0268ffe5 hci version 0x110 qu=
irks
0x0000020000000010
[  T348] xhci_hcd 0000:08:00.4: xHCI Host Controller
[  T348] xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus numbe=
r 4
[  T348] xhci_hcd 0000:08:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[  T348] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=3D0002=
,
bcdDevice=3D 6.14
[  T348] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, SerialNum=
ber=3D1
[  T348] usb usb3: Product: xHCI Host Controller
[  T348] usb usb3: Manufacturer: Linux 6.14.0-rc6-nop2pdma xhci-hcd
[  T348] usb usb3: SerialNumber: 0000:08:00.4
[  T348] hub 3-0:1.0: USB hub found
[  T348] hub 3-0:1.0: 4 ports detected
[  T348] usb usb4: We don't know the algorithms for LPM for this host, dis=
abling
LPM.
[  T348] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=3D0003=
,
bcdDevice=3D 6.14
[  T348] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, SerialNum=
ber=3D1
[  T348] usb usb4: Product: xHCI Host Controller
[  T348] usb usb4: Manufacturer: Linux 6.14.0-rc6-nop2pdma xhci-hcd
[  T348] usb usb4: SerialNumber: 0000:08:00.4
[  T348] hub 4-0:1.0: USB hub found
[  T348] hub 4-0:1.0: 2 ports detected
[  T442] usb 1-2: new low-speed USB device number 2 using xhci_hcd
[  T232] usb 3-3: new high-speed USB device number 2 using xhci_hcd
[  T442] usb 1-2: New USB device found, idVendor=3D1bcf, idProduct=3D08a0,
bcdDevice=3D 1.04
[  T442] usb 1-2: New USB device strings: Mfr=3D0, Product=3D0, SerialNumb=
er=3D0
[  T204] tsc: Refined TSC clocksource calibration: 3193.983 MHz
[  T204] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e0a15cd=
8ea,
max_idle_ns: 440795247996 ns
[  T390] [drm] amdgpu kernel modesetting enabled.
[  T390] amdgpu: vga_switcheroo: detected switching method
\_SB_.PCI0.GP17.VGA_.ATPX handle
[  T390] amdgpu: ATPX version 1, functions 0x00000001
[  T390] amdgpu: ATPX Hybrid Graphics
[  T390] amdgpu: Virtual CRAT table created for CPU
[  T390] amdgpu: Topology: Add CPU node
[  T390] amdgpu 0000:03:00.0: enabling device (0000 -> 0002)
[  T390] [drm] initializing kernel modesetting (DIMGREY_CAVEFISH 0x1002:0x=
73FF
0x1462:0x1313 0xC3).
[  T390] [drm] register mmio base: 0xFCA00000
[  T390] [drm] register mmio size: 1048576
[  T232] usb 3-3: New USB device found, idVendor=3D0e8d, idProduct=3D0608,
bcdDevice=3D 1.00
[  T232] usb 3-3: New USB device strings: Mfr=3D5, Product=3D6, SerialNumb=
er=3D7
[  T232] usb 3-3: Product: Wireless_Device
[  T232] usb 3-3: Manufacturer: MediaTek Inc.
[  T232] usb 3-3: SerialNumber: 000000000
[  T442] usb 1-4: new high-speed USB device number 3 using xhci_hcd
[  T390] amdgpu 0000:03:00.0: amdgpu: detected ip block number 0 <nv_commo=
n>
[  T390] amdgpu 0000:03:00.0: amdgpu: detected ip block number 1 <gmc_v10_=
0>
[  T390] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <navi10_i=
h>
[  T390] amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp>
[  T390] amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu>
[  T390] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dm>
[  T390] amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <gfx_v10_=
0>
[  T390] amdgpu 0000:03:00.0: amdgpu: detected ip block number 7 <sdma_v5_=
2>
[  T390] amdgpu 0000:03:00.0: amdgpu: detected ip block number 8 <vcn_v3_0=
>
[  T390] amdgpu 0000:03:00.0: amdgpu: detected ip block number 9 <jpeg_v3_=
0>
[  T390] amdgpu 0000:03:00.0: amdgpu: ACPI VFCT table present but broken (=
too
short #2),skipping
[  T390] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from ROM BAR
[  T390] amdgpu: ATOM BIOS: SWBRT77181.001
[  T232] usb 3-4: new full-speed USB device number 3 using xhci_hcd
[  T390] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature di=
sabled
as experimental (default)
[  T390] [drm] GPU posting now...
[  T390] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragme=
nt
size is 9-bit
[  T390] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 -
0x00000081FEFFFFFF (8176M used)
[  T390] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 -
0x000000001FFFFFFF
[  T390] [drm] Detected VRAM RAM=3D8176M, BAR=3D8192M
[  T390] [drm] RAM width 128bits GDDR6
[  T390] [drm] amdgpu: 8176M of VRAM memory ready
[  T390] [drm] amdgpu: 31853M of GTT memory ready.
[  T390] [drm] GART: num cpu pages 131072, num gpu pages 131072
[  T390] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[  T442] usb 1-4: New USB device found, idVendor=3D30c9, idProduct=3D0042,
bcdDevice=3D 0.03
[  T442] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, SerialNumb=
er=3D3
[  T442] usb 1-4: Product: Integrated Camera
[  T442] usb 1-4: Manufacturer: S1F0009330LB620L420004LP
[  T442] usb 1-4: SerialNumber: SunplusIT Inc
[  T379] input: HID 1bcf:08a0 Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-2/1-
2:1.0/0003:1BCF:08A0.0008/input/input11
[  T379] input: HID 1bcf:08a0 Keyboard as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-2/1-
2:1.0/0003:1BCF:08A0.0008/input/input12
[  T232] usb 3-4: New USB device found, idVendor=3D1462, idProduct=3D1563,
bcdDevice=3D 2.00
[  T232] usb 3-4: New USB device strings: Mfr=3D1, Product=3D2, SerialNumb=
er=3D3
[  T232] usb 3-4: Product: MysticLight MS-1563 v0001
[  T232] usb 3-4: Manufacturer: MSI
[  T232] usb 3-4: SerialNumber: 2064386A5430
[  T232] hid-generic 0003:1462:1563.0009: hiddev0,hidraw7: USB HID v1.11 D=
evice
[MSI MysticLight MS-1563 v0001] on usb-0000:08:00.4-4/input0
[  T379] input: HID 1bcf:08a0 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-2/1-
2:1.0/0003:1BCF:08A0.0008/input/input13
[  T379] hid-generic 0003:1BCF:08A0.0008: input,hiddev1,hidraw8: USB HID v=
1.10
Mouse [HID 1bcf:08a0] on usb-0000:08:00.3-2/input0
[  T379] usbcore: registered new interface driver usbhid
[  T379] usbhid: USB HID core driver
[  T390] amdgpu 0000:03:00.0: amdgpu: STB initialized to 2048 entries
[  T390] [drm] Loading DMUB firmware via PSP: version=3D0x02020020
[  T390] [drm] use_doorbell being set to: [true]
[  T390] [drm] use_doorbell being set to: [true]
[  T390] [drm] Found VCN firmware Version ENC: 1.33 DEC: 4 VEP: 0 Revision=
: 3
[  T390] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[  T390] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[  T390] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[  T390] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[  T390] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[  T390] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[  T390] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[  T390] [drm] Display Core v3.2.316 initialized on DCN 3.0.2
[  T390] [drm] DP-HDMI FRL PCON supported
[  T390] [drm] DMUB hardware initialized: version=3D0x02020020
[  T390] [drm] kiq ring mec 2 pipe 1 q 0
[  T390] amdgpu: HMM registered 8176MB device memory
[  T390] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[  T390] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[  T390] amdgpu: Virtual CRAT table created for GPU
[  T390] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[  T390] kfd kfd: amdgpu: added device 1002:73ff
[  T390] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8,
active_cu_number 28
[  T390] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[  T390] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[  T390] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[  T390] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[  T390] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[  T390] amdgpu 0000:03:00.0: amdgpu: Using BOCO for runtime pm
[  T390] [drm] Initialized amdgpu 3.61.0 for 0000:03:00.0 on minor 0
[  T390] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[  T390] [drm] pre_validate_dsc:1601 MST_DSC dsc precompute is not needed
[  T390] amdgpu 0000:08:00.0: enabling device (0006 -> 0007)
[  T390] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1638
0x1462:0x1313 0xC5).
[  T390] [drm] register mmio base: 0xFC900000
[  T390] [drm] register mmio size: 524288
[  T390] amdgpu 0000:08:00.0: amdgpu: detected ip block number 0 <soc15_co=
mmon>
[  T390] amdgpu 0000:08:00.0: amdgpu: detected ip block number 1 <gmc_v9_0=
>
[  T390] amdgpu 0000:08:00.0: amdgpu: detected ip block number 2 <vega10_i=
h>
[  T390] amdgpu 0000:08:00.0: amdgpu: detected ip block number 3 <psp>
[  T390] amdgpu 0000:08:00.0: amdgpu: detected ip block number 4 <smu>
[  T390] amdgpu 0000:08:00.0: amdgpu: detected ip block number 5 <dm>
[  T390] amdgpu 0000:08:00.0: amdgpu: detected ip block number 6 <gfx_v9_0=
>
[  T390] amdgpu 0000:08:00.0: amdgpu: detected ip block number 7 <sdma_v4_=
0>
[  T390] amdgpu 0000:08:00.0: amdgpu: detected ip block number 8 <vcn_v2_0=
>
[  T390] amdgpu 0000:08:00.0: amdgpu: detected ip block number 9 <jpeg_v2_=
0>
[  T390] amdgpu 0000:08:00.0: amdgpu: Fetched VBIOS from VFCT
[  T390] amdgpu: ATOM BIOS: 113-CEZANNE-018
[  T390] Console: switching to colour dummy device 80x25
[  T390] amdgpu 0000:08:00.0: vgaarb: deactivate vga console
[  T390] amdgpu 0000:08:00.0: amdgpu: Trusted Memory Zone (TMZ) feature en=
abled
[  T390] amdgpu 0000:08:00.0: amdgpu: MODE2 reset
[  T390] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragme=
nt
size is 9-bit
[  T390] amdgpu 0000:08:00.0: amdgpu: VRAM: 512M 0x000000F400000000 -
0x000000F41FFFFFFF (512M used)
[  T390] amdgpu 0000:08:00.0: amdgpu: GART: 1024M 0x0000000000000000 -
0x000000003FFFFFFF
[  T390] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
[  T390] [drm] RAM width 128bits DDR4
[  T390] [drm] amdgpu: 512M of VRAM memory ready
[  T390] [drm] amdgpu: 31853M of GTT memory ready.
[  T390] [drm] GART: num cpu pages 262144, num gpu pages 262144
[  T390] [drm] PCIE GART of 1024M enabled.
[  T390] [drm] PTB located at 0x000000F41FC00000
[  T390] [drm] Loading DMUB firmware via PSP: version=3D0x0101002B
[  T390] [drm] Found VCN firmware Version ENC: 1.24 DEC: 8 VEP: 0 Revision=
: 3
[  T390] amdgpu 0000:08:00.0: amdgpu: reserve 0x400000 from 0xf41f800000 f=
or PSP
TMR
[  T390] amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[  T390] amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode is not
available
[  T390] amdgpu 0000:08:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[  T390] amdgpu 0000:08:00.0: amdgpu: SMU is initialized successfully!
[  T390] [drm] Display Core v3.2.316 initialized on DCN 2.1
[  T390] [drm] DP-HDMI FRL PCON supported
[  T390] [drm] DMUB hardware initialized: version=3D0x0101002B
[  T390] [drm] kiq ring mec 2 pipe 1 q 0
[  T390] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[  T390] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[  T390] amdgpu: Virtual CRAT table created for GPU
[  T390] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[  T390] kfd kfd: amdgpu: added device 1002:1638
[  T390] amdgpu 0000:08:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8,
active_cu_number 8
[  T390] amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[  T390] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on=
 hub 0
[  T390] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on=
 hub 0
[  T390] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on=
 hub 0
[  T390] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on=
 hub 0
[  T390] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on=
 hub 0
[  T390] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on=
 hub 0
[  T390] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on=
 hub 0
[  T390] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 o=
n hub
0
[  T390] amdgpu 0000:08:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 =
on hub
0
[  T390] amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub =
8
[  T390] amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hu=
b 8
[  T390] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on h=
ub 8
[  T390] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on h=
ub 8
[  T390] amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on h=
ub 8
[  T390] amdgpu 0000:08:00.0: amdgpu: Runtime PM not available
[  T390] [drm] Initialized amdgpu 3.61.0 for 0000:08:00.0 on minor 1
[  T390] fbcon: amdgpudrmfb (fb0) is primary device
[  T390] Console: switching to colour frame buffer device 240x67
[  T390] amdgpu 0000:08:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[  T522] PM: Image not found (code -22)
[  T535] EXT4-fs (nvme0n1p2): mounted filesystem 73e0f015-c115-4eb2-92cb-
dbf7da2b6112 ro with ordered data mode. Quota mode: disabled.
[  T591] pstore: Using crash dump compression: deflate
[  T591] pstore: Registered efi_pstore as persistent store backend
[  T593] fuse: init (API version 7.42)
[  T609] EXT4-fs (nvme0n1p2): re-mounted 73e0f015-c115-4eb2-92cb-dbf7da2b6=
112
r/w. Quota mode: disabled.
[  T597] cfg80211: Loading compiled-in X.509 certificates for regulatory
database
[  T597] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  T597] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600=
'
[  T233] cfg80211: loaded regulatory.db is malformed or signature is
missing/invalid
[  T597] mt7921e 0000:04:00.0: enabling device (0000 -> 0002)
[  T597] mt7921e 0000:04:00.0: ASIC revision: 79610010
[  T177] mt7921e 0000:04:00.0: HW/SW Version: 0x8a108a10, Build Time:
20241106151007a
[  T177]
[  T177] mt7921e 0000:04:00.0: WM Firmware Version: ____010000, Build Time=
:
20241106151045
[  T679] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:33/PNP0C09:00/PNP0C0D:0=
0/inpu
t/input14
[  T679] ACPI: button: Lid Switch [LID0]
[  T679] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input15
[  T679] ACPI: button: Power Button [PWRB]
[  T679] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input16
[  T679] ACPI: button: Sleep Button [SLPB]
[  T678] ACPI: AC: AC Adapter [ADP1] (on-line)
[  T733] ccp 0000:08:00.2: enabling device (0000 -> 0002)
[  T733] ccp 0000:08:00.2: tee enabled
[  T733] ccp 0000:08:00.2: psp enabled
[  T723] MCE: In-kernel MCE decoding enabled.
[  T691] mc: Linux media interface: v0.10
[  T758] Adding 75497468k swap on /dev/nvme0n1p3.  Priority:-2 extents:1
across:75497468k SS
[  T152] ACPI: battery: Slot [BAT1] (battery present)
[  T688] input: MSI WMI hotkeys as /devices/virtual/input/input17
[  T720] snd_rn_pci_acp3x 0000:08:00.5: enabling device (0000 -> 0002)
[  T691] videodev: Linux video capture interface: v2.00
[  T691] usb 1-4: Found UVC 1.00 device Integrated Camera (30c9:0042)
[  T674] Bluetooth: Core ver 2.22
[  T674] NET: Registered PF_BLUETOOTH protocol family
[  T674] Bluetooth: HCI device and connection manager initialized
[  T674] Bluetooth: HCI socket layer initialized
[  T674] Bluetooth: L2CAP socket layer initialized
[  T674] Bluetooth: SCO socket layer initialized
[  T717] snd_hda_intel 0000:03:00.1: enabling device (0000 -> 0002)
[  T717] snd_hda_intel 0000:03:00.1: Handle vga_switcheroo audio client
[  T717] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[  T717] snd_hda_intel 0000:08:00.1: enabling device (0000 -> 0002)
[  T717] snd_hda_intel 0000:08:00.1: Handle vga_switcheroo audio client
[  T717] snd_hda_intel 0000:08:00.6: enabling device (0000 -> 0002)
[  T691] usbcore: registered new interface driver uvcvideo
[  T723] snd_hda_intel 0000:08:00.1: bound 0000:08:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[  T701] usbcore: registered new interface driver btusb
[  T723] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[  T211] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 202411061=
51414
[  T105] input: HD-Audio Generic HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input18
[  T207] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd1/input22
[  T105] input: HD-Audio Generic HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input19
[  T207] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd1/input23
[  T105] input: HD-Audio Generic HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input20
[  T207] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd1/input24
[  T105] input: HD-Audio Generic HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input21
[  T207] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd1/input25
[  T207] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd1/input26
[  T710] snd_hda_codec_realtek hdaudioC3D0: autoconfig for ALC233: line_ou=
ts=3D1
(0x14/0x0/0x0/0x0/0x0) type:speaker
[  T710] snd_hda_codec_realtek hdaudioC3D0:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[  T710] snd_hda_codec_realtek hdaudioC3D0:    hp_outs=3D1 (0x21/0x0/0x0/0=
x0/0x0)
[  T710] snd_hda_codec_realtek hdaudioC3D0:    mono: mono_out=3D0x0
[  T710] snd_hda_codec_realtek hdaudioC3D0:    inputs:
[  T710] snd_hda_codec_realtek hdaudioC3D0:      Mic=3D0x19
[  T799] input: HD-Audio Generic Mic as
/devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card3/input27
[  T799] input: HD-Audio Generic Headphone as
/devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card3/input28
[  T211] Bluetooth: hci0: Device setup in 148255 usecs
[  T211] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection comman=
d is
advertised, but not supported.
[  T877] EXT4-fs (nvme1n1p1): mounted filesystem 85e13cd1-3c57-4343-a1f5-
6209e530b640 r/w with ordered data mode. Quota mode: disabled.
[  T876] EXT4-fs (nvme0n1p4): mounted filesystem d21e6ad6-bc46-4b61-bc20-
e4d2f4bf719a r/w with ordered data mode. Quota mode: disabled.
[  T165] audit: type=3D1400 audit(1741857016.581:2): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"ch-run" pid=3D91=
8
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857016.581:3): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"busybox" pid=3D9=
15
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857016.581:4): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"Discord" pid=3D9=
08
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857016.581:5): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"chrome" pid=3D91=
9
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857016.581:6): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"ch-checkns" pid=
=3D917
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857016.581:7): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"balena-etcher" p=
id=3D912
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857016.581:8): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"vscode" pid=3D92=
1
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857016.581:9): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"buildah" pid=3D9=
14
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857016.581:10): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined"
name=3D4D6F6E676F444220436F6D70617373 pid=3D909 comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857016.581:11): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"cam" pid=3D916
comm=3D"apparmor_parser"
[   C14] clocksource: timekeeping watchdog on CPU14: Marking clocksource '=
tsc'
as unstable because the skew is too large:
[   C14] clocksource:                       'hpet' wd_nsec: 503998762 wd_n=
ow:
66cec85 wd_last: 5fecfac mask: ffffffff
[   C14] clocksource:                       'tsc' cs_nsec: 505705330 cs_no=
w:
16bb57ff20 cs_last: 165b11c8c0 mask: ffffffffffffffff
[   C14] clocksource:                       Clocksource 'tsc' skewed 17065=
68 ns
(1 ms) over watchdog 'hpet' interval of 503998762 ns (503 ms)
[   C14] clocksource:                       'hpet' (not 'tsc') is current
clocksource.
[   C14] tsc: Marking TSC unstable due to clocksource watchdog
[  T236] TSC found unstable after boot, most likely due to broken BIOS. Us=
e
'tsc=3Dunstable'.
[  T236] sched_clock: Marking unstable (7544040402, 1214342)<-(7562947003,=
 -
15977517)
[ T1069] nvme nvme0: using unchecked data buffer
[ T1153] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ T1153] Bluetooth: BNEP filters: protocol multicast
[ T1153] Bluetooth: BNEP socket layer initialized
[ T1046] Bluetooth: MGMT ver 1.23
[ T1156] Bluetooth: RFCOMM TTY layer initialized
[ T1156] Bluetooth: RFCOMM socket layer initialized
[ T1156] Bluetooth: RFCOMM ver 1.11
[ T1073] block nvme0n1: No UUID available providing old NGUID
[ T1120] Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY driver
(mii_bus:phy_addr=3Dr8169-0-500:00, irq=3DMAC)
[  T236] r8169 0000:05:00.0 enp5s0: Link is Down
[  T733] mt7921e 0000:04:00.0 wlp4s0: renamed from wlan0
[ T1752] ------------[ cut here ]------------
[ T1752] WARNING: CPU: 1 PID: 1752 at mm/util.c:674
__kvmalloc_node_noprof+0xa2/0xb0
[ T1752] Modules linked in: snd_seq_midi snd_seq_midi_event snd_rawmidi sn=
d_seq
snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_ctl_led
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component btusb
snd_hda_codec_hdmi btrtl btintel btbcm btmtk snd_hda_intel snd_intel_dspcf=
g
bluetooth snd_hda_codec snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn uvcvid=
eo
snd_soc_core snd_hwdep snd_hda_core videobuf2_vmalloc videobuf2_memops uvc
videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x
snd_acp_config videobuf2_common snd_timer snd_soc_acpi msi_wmi ecdh_generi=
c ecc
mc sparse_keymap edac_mce_amd wmi_bmof snd soundcore ccp snd_pci_acp3x k10=
temp
ac battery button joydev hid_sensor_prox hid_sensor_accel_3d hid_sensor_ma=
gn_3d
amd_pmc hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger
industrialio_triggered_buffer kfifo_buf industrialio evdev hid_sensor_iio_=
common
mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg=
80211
rfkill msr fuse nvme_fabrics efi_pstore
[ T1752]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp
i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched
drm_suballoc_helper drm_panel_backlight_quirks xhci_pci cec hid_sensor_hub
xhci_hcd drm_buddy mfd_core hid_multitouch hid_generic drm_display_helper
i2c_hid_acpi usbcore psmouse amd_sfh nvme i2c_hid drm_kms_helper hid serio=
_raw
nvme_core i2c_piix4 r8169 crc16 i2c_smbus usb_common i2c_designware_platfo=
rm
i2c_designware_core
[ T1752] CPU: 1 UID: 1000 PID: 1752 Comm: gst-plugin-scan Not tainted 6.14=
.0-
rc6-nop2pdma #566
[ T1752] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/=
MS-
158L, BIOS E158LAMS.107 11/10/2021
[ T1752] RIP: 0010:__kvmalloc_node_noprof+0xa2/0xb0
[ T1752] Code: 00 49 b9 63 01 00 00 00 00 00 80 68 00 04 00 00 4c 23 0d f9=
 1b ea
00 48 01 d1 e8 c9 af 03 00 48 83 c4 18 eb 9a 80 e7 20 75 95 <0f> 0b eb 91 =
66 2e
0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
[ T1752] RSP: 0018:ffffc90006fffcc0 EFLAGS: 00010246
[ T1752] RAX: 0000000000000000 RBX: 00000000000000c0 RCX: 0000000000000000
[ T1752] RDX: 0000000000000000 RSI: 0000000000000016 RDI: 0000000000052cc0
[ T1752] RBP: 00000003e7e9af80 R08: ffffc90006fffe00 R09: ffffc90006fffe10
[ T1752] R10: 0000000000000018 R11: 0000000000000000 R12: 00000000ffffffff
[ T1752] R13: ffff8881c1b80010 R14: 00000003e7e9af80 R15: ffffc90006fffd28
[ T1752] FS:  00007f90e4d22680(0000) GS:ffff888fae440000(0000)
knlGS:0000000000000000
[ T1752] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ T1752] CR2: 00007f90d4520720 CR3: 0000000142d7c000 CR4: 0000000000750ef0
[ T1752] PKRU: 55555554
[ T1752] Call Trace:
[ T1752]  <TASK>
[ T1752]  ? __warn.cold+0x90/0x9e
[ T1752]  ? __kvmalloc_node_noprof+0xa2/0xb0
[ T1752]  ? report_bug+0xfa/0x140
[ T1752]  ? handle_bug+0x53/0x90
[ T1752]  ? exc_invalid_op+0x17/0x70
[ T1752]  ? asm_exc_invalid_op+0x1a/0x20
[ T1752]  ? __kvmalloc_node_noprof+0xa2/0xb0
[ T1752]  ? amdgpu_bo_create_list_entry_array+0x38/0x150 [amdgpu]
[ T1752]  ? rt_spin_unlock+0x12/0x40
[ T1752]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1752]  ? amdgpu_bo_list_ioctl+0x47/0x340 [amdgpu]
[ T1752]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
[ T1752]  ? drm_ioctl_kernel+0xa3/0xf0
[ T1752]  ? drm_ioctl+0x25e/0x4c0
[ T1752]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
[ T1752]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1752]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1752]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1752]  ? amdgpu_drm_ioctl+0x46/0x80 [amdgpu]
[ T1752]  ? __x64_sys_ioctl+0x92/0xc0
[ T1752]  ? do_syscall_64+0x5f/0x1a0
[ T1752]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1752]  </TASK>
[ T1752] ---[ end trace 0000000000000000 ]---
[ T1121] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (local
address=3Dc8:94:02:c1:bd:69)
[  T152] pci_bus 0000:03: Allocating resources
[ T1121] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
[  T152] wlp4s0: authenticated
[  T152] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/3)
[  T152] wlp4s0: RX AssocResp from 54:67:51:3d:a2:d2 (capab=3D0x511 status=
=3D0
aid=3D1)
[  T152] wlp4s0: associated
[  T150] wlp4s0: deauthenticated from 54:67:51:3d:a2:d2 (Reason:
15=3D4WAY_HANDSHAKE_TIMEOUT)
[ T1121] wlp4s0: authenticate with 54:67:51:3d:a2:e0 (local
address=3Dc8:94:02:c1:bd:69)
[ T1121] wlp4s0: send auth to 54:67:51:3d:a2:e0 (try 1/3)
[  T152] wlp4s0: authenticated
[  T152] wlp4s0: associate with 54:67:51:3d:a2:e0 (try 1/3)
[  T152] wlp4s0: RX AssocResp from 54:67:51:3d:a2:e0 (capab=3D0x1411 statu=
s=3D17
aid=3D2)
[  T152] wlp4s0: 54:67:51:3d:a2:e0 denied association (code=3D17)
[ T1121] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (local
address=3Dc8:94:02:c1:bd:69)
[ T1121] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
[  T152] wlp4s0: authenticated
[  T152] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/3)
[  T159] wlp4s0: RX AssocResp from 54:67:51:3d:a2:d2 (capab=3D0x511 status=
=3D0
aid=3D1)
[  T159] wlp4s0: associated
[    T0] Linux version 6.14.0-rc6-nop2pdma (bert@lisa) (gcc (Debian 14.2.0=
-17)
14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #566 SMP PREEMPT_RT Wed Mar=
 12
21:44:08 CET 2025
[    T0] Command line: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc6-nop2pdma noka=
slr
root=3DUUID=3D73e0f015-c115-4eb2-92cb-dbf7da2b6112 ro clocksource=3Dhpet
amdgpu.noretry=3D0
[    T0] BIOS-provided physical RAM map:
[    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    T0] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    T0] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfefff] usable
[    T0] BIOS-e820: [mem 0x0000000009bff000-0x000000000a000fff] reserved
[    T0] BIOS-e820: [mem 0x000000000a001000-0x000000000a1fffff] usable
[    T0] BIOS-e820: [mem 0x000000000a200000-0x000000000a20efff] ACPI NVS
[    T0] BIOS-e820: [mem 0x000000000a20f000-0x00000000e9e1ffff] usable
[    T0] BIOS-e820: [mem 0x00000000e9e20000-0x00000000eb33efff] reserved
[    T0] BIOS-e820: [mem 0x00000000eb33f000-0x00000000eb39efff] ACPI data
[    T0] BIOS-e820: [mem 0x00000000eb39f000-0x00000000eb556fff] ACPI NVS
[    T0] BIOS-e820: [mem 0x00000000eb557000-0x00000000ed1fefff] reserved
[    T0] BIOS-e820: [mem 0x00000000ed1ff000-0x00000000edffffff] usable
[    T0] BIOS-e820: [mem 0x00000000ee000000-0x00000000f7ffffff] reserved
[    T0] BIOS-e820: [mem 0x00000000fd000000-0x00000000fdffffff] reserved
[    T0] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    T0] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    T0] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    T0] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    T0] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    T0] BIOS-e820: [mem 0x00000000fedc4000-0x00000000fedc9fff] reserved
[    T0] BIOS-e820: [mem 0x00000000fedcc000-0x00000000fedcefff] reserved
[    T0] BIOS-e820: [mem 0x00000000fedd5000-0x00000000fedd5fff] reserved
[    T0] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    T0] BIOS-e820: [mem 0x0000000100000000-0x0000000fee2fffff] usable
[    T0] BIOS-e820: [mem 0x0000000fee300000-0x000000100fffffff] reserved
[    T0] NX (Execute Disable) protection: active
[    T0] APIC: Static calls initialized
[    T0] e820: update [mem 0xe5e58018-0xe5e65857] usable =3D=3D> usable
[    T0] extended physical RAM map:
[    T0] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] u=
sable
[    T0] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff]
reserved
[    T0] reserve setup_data: [mem 0x0000000000100000-0x0000000009bfefff] u=
sable
[    T0] reserve setup_data: [mem 0x0000000009bff000-0x000000000a000fff]
reserved
[    T0] reserve setup_data: [mem 0x000000000a001000-0x000000000a1fffff] u=
sable
[    T0] reserve setup_data: [mem 0x000000000a200000-0x000000000a20efff] A=
CPI
NVS
[    T0] reserve setup_data: [mem 0x000000000a20f000-0x00000000e5e58017] u=
sable
[    T0] reserve setup_data: [mem 0x00000000e5e58018-0x00000000e5e65857] u=
sable
[    T0] reserve setup_data: [mem 0x00000000e5e65858-0x00000000e9e1ffff] u=
sable
[    T0] reserve setup_data: [mem 0x00000000e9e20000-0x00000000eb33efff]
reserved
[    T0] reserve setup_data: [mem 0x00000000eb33f000-0x00000000eb39efff] A=
CPI
data
[    T0] reserve setup_data: [mem 0x00000000eb39f000-0x00000000eb556fff] A=
CPI
NVS
[    T0] reserve setup_data: [mem 0x00000000eb557000-0x00000000ed1fefff]
reserved
[    T0] reserve setup_data: [mem 0x00000000ed1ff000-0x00000000edffffff] u=
sable
[    T0] reserve setup_data: [mem 0x00000000ee000000-0x00000000f7ffffff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fd000000-0x00000000fdffffff]
reserved
[    T0] reserve setup_data: [mem 0x00000000feb80000-0x00000000fec01fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fed40000-0x00000000fed44fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed8ffff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fedc4000-0x00000000fedc9fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fedcc000-0x00000000fedcefff]
reserved
[    T0] reserve setup_data: [mem 0x00000000fedd5000-0x00000000fedd5fff]
reserved
[    T0] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff]
reserved
[    T0] reserve setup_data: [mem 0x0000000100000000-0x0000000fee2fffff] u=
sable
[    T0] reserve setup_data: [mem 0x0000000fee300000-0x000000100fffffff]
reserved
[    T0] efi: EFI v2.7 by American Megatrends
[    T0] efi: ACPI=3D0xeb540000 ACPI 2.0=3D0xeb540014 TPMFinalLog=3D0xeb50=
c000
SMBIOS=3D0xed020000 SMBIOS 3.0=3D0xed01f000 MEMATTR=3D0xe6fa0018 ESRT=3D0x=
e87cb898
INITRD=3D0xe5e66518 RNG=3D0xeb351018 TPMEventLog=3D0xeb341018
[    T0] random: crng init done
[    T0] efi: Remove mem54: MMIO range=3D[0xf0000000-0xf7ffffff] (128MB) f=
rom e820
map
[    T0] e820: remove [mem 0xf0000000-0xf7ffffff] reserved
[    T0] efi: Remove mem55: MMIO range=3D[0xfd000000-0xfdffffff] (16MB) fr=
om e820
map
[    T0] e820: remove [mem 0xfd000000-0xfdffffff] reserved
[    T0] efi: Remove mem56: MMIO range=3D[0xfeb80000-0xfec01fff] (0MB) fro=
m e820
map
[    T0] e820: remove [mem 0xfeb80000-0xfec01fff] reserved
[    T0] efi: Not removing mem57: MMIO range=3D[0xfec10000-0xfec10fff] (4K=
B) from
e820 map
[    T0] efi: Not removing mem58: MMIO range=3D[0xfed00000-0xfed00fff] (4K=
B) from
e820 map
[    T0] efi: Not removing mem59: MMIO range=3D[0xfed40000-0xfed44fff] (20=
KB) from
e820 map
[    T0] efi: Not removing mem60: MMIO range=3D[0xfed80000-0xfed8ffff] (64=
KB) from
e820 map
[    T0] efi: Not removing mem61: MMIO range=3D[0xfedc4000-0xfedc9fff] (24=
KB) from
e820 map
[    T0] efi: Not removing mem62: MMIO range=3D[0xfedcc000-0xfedcefff] (12=
KB) from
e820 map
[    T0] efi: Not removing mem63: MMIO range=3D[0xfedd5000-0xfedd5fff] (4K=
B) from
e820 map
[    T0] efi: Remove mem64: MMIO range=3D[0xff000000-0xffffffff] (16MB) fr=
om e820
map
[    T0] e820: remove [mem 0xff000000-0xffffffff] reserved
[    T0] SMBIOS 3.3.0 present.
[    T0] DMI: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, B=
IOS
E158LAMS.107 11/10/2021
[    T0] DMI: Memory slots populated: 2/2
[    T0] tsc: Fast TSC calibration using PIT
[    T0] tsc: Detected 3193.985 MHz processor
[    T0] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> reserved
[    T0] e820: remove [mem 0x000a0000-0x000fffff] usable
[    T0] last_pfn =3D 0xfee300 max_arch_pfn =3D 0x400000000
[    T0] MTRR map: 5 entries (3 fixed + 2 variable; max 20), built from 9
variable MTRRs
[    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    T0] e820: update [mem 0xf0000000-0xffffffff] usable =3D=3D> reserved
[    T0] last_pfn =3D 0xee000 max_arch_pfn =3D 0x400000000
[    T0] esrt: Reserving ESRT space from 0x00000000e87cb898 to
0x00000000e87cb8d0.
[    T0] e820: update [mem 0xe87cb000-0xe87cbfff] usable =3D=3D> reserved
[    T0] Using GB pages for direct mapping
[    T0] Secure boot disabled
[    T0] RAMDISK: [mem 0xdc45f000-0xded61fff]
[    T0] ACPI: Early table checksum verification disabled
[    T0] ACPI: RSDP 0x00000000EB540014 000024 (v02 MSI_NB)
[    T0] ACPI: XSDT 0x00000000EB53F728 000114 (v01 MSI_NB MEGABOOK 0107200=
9 AMI
01000013)
[    T0] ACPI: FACP 0x00000000EB390000 000114 (v06 MSI_NB MEGABOOK 0107200=
9 AMI
00010013)
[    T0] ACPI: DSDT 0x00000000EB383000 00C50C (v02 MSI_NB MEGABOOK 0107200=
9 INTL
20190509)
[    T0] ACPI: FACS 0x00000000EB50A000 000040
[    T0] ACPI: SLIC 0x00000000EB39E000 000176 (v01 MSI_NB MEGABOOK 0107200=
9 AMI
01000013)
[    T0] ACPI: SSDT 0x00000000EB396000 0072B0 (v02 AMD    AmdTable 0000000=
2 MSFT
04000000)
[    T0] ACPI: IVRS 0x00000000EB395000 0001A4 (v02 AMD    AmdTable 0000000=
1 AMD
00000000)
[    T0] ACPI: SSDT 0x00000000EB391000 003A21 (v01 AMD    AMD AOD  0000000=
1 INTL
20190509)
[    T0] ACPI: FIDT 0x00000000EB382000 00009C (v01 MSI_NB MEGABOOK 0107200=
9 AMI
00010013)
[    T0] ACPI: ECDT 0x00000000EB381000 0000C1 (v01 MSI_NB MEGABOOK 0107200=
9 AMI.
00010013)
[    T0] ACPI: MCFG 0x00000000EB380000 00003C (v01 MSI_NB MEGABOOK 0107200=
9 MSFT
00010013)
[    T0] ACPI: HPET 0x00000000EB37F000 000038 (v01 MSI_NB MEGABOOK 0107200=
9 AMI
00000005)
[    T0] ACPI: VFCT 0x00000000EB371000 00D884 (v01 MSI_NB MEGABOOK 0000000=
1 AMD
31504F47)
[    T0] ACPI: BGRT 0x00000000EB370000 000038 (v01 MSI_NB MEGABOOK 0107200=
9 AMI
00010013)
[    T0] ACPI: TPM2 0x00000000EB36F000 00004C (v04 MSI_NB MEGABOOK 0000000=
1 AMI
00000000)
[    T0] ACPI: SSDT 0x00000000EB369000 005354 (v02 AMD    AmdTable 0000000=
1 AMD
00000001)
[    T0] ACPI: CRAT 0x00000000EB368000 000EE8 (v01 AMD    AmdTable 0000000=
1 AMD
00000001)
[    T0] ACPI: CDIT 0x00000000EB367000 000029 (v01 AMD    AmdTable 0000000=
1 AMD
00000001)
[    T0] ACPI: SSDT 0x00000000EB366000 000149 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB364000 00148E (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB362000 00153F (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB361000 000696 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB35F000 001A56 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB35E000 0005DE (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB35A000 0036E9 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: WSMT 0x00000000EB359000 000028 (v01 MSI_NB MEGABOOK 0107200=
9 AMI
00010013)
[    T0] ACPI: APIC 0x00000000EB358000 0000DE (v03 MSI_NB MEGABOOK 0107200=
9 AMI
00010013)
[    T0] ACPI: SSDT 0x00000000EB357000 00008D (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB356000 0008A8 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB355000 0001B7 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB354000 0007B1 (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: SSDT 0x00000000EB353000 00097D (v01 AMD    AmdTable 0000000=
1 INTL
20190509)
[    T0] ACPI: FPDT 0x00000000EB352000 000044 (v01 MSI_NB A M I    0107200=
9 AMI
01000013)
[    T0] ACPI: Reserving FACP table memory at [mem 0xeb390000-0xeb390113]
[    T0] ACPI: Reserving DSDT table memory at [mem 0xeb383000-0xeb38f50b]
[    T0] ACPI: Reserving FACS table memory at [mem 0xeb50a000-0xeb50a03f]
[    T0] ACPI: Reserving SLIC table memory at [mem 0xeb39e000-0xeb39e175]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb396000-0xeb39d2af]
[    T0] ACPI: Reserving IVRS table memory at [mem 0xeb395000-0xeb3951a3]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb391000-0xeb394a20]
[    T0] ACPI: Reserving FIDT table memory at [mem 0xeb382000-0xeb38209b]
[    T0] ACPI: Reserving ECDT table memory at [mem 0xeb381000-0xeb3810c0]
[    T0] ACPI: Reserving MCFG table memory at [mem 0xeb380000-0xeb38003b]
[    T0] ACPI: Reserving HPET table memory at [mem 0xeb37f000-0xeb37f037]
[    T0] ACPI: Reserving VFCT table memory at [mem 0xeb371000-0xeb37e883]
[    T0] ACPI: Reserving BGRT table memory at [mem 0xeb370000-0xeb370037]
[    T0] ACPI: Reserving TPM2 table memory at [mem 0xeb36f000-0xeb36f04b]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb369000-0xeb36e353]
[    T0] ACPI: Reserving CRAT table memory at [mem 0xeb368000-0xeb368ee7]
[    T0] ACPI: Reserving CDIT table memory at [mem 0xeb367000-0xeb367028]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb366000-0xeb366148]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb364000-0xeb36548d]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb362000-0xeb36353e]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb361000-0xeb361695]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35f000-0xeb360a55]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35e000-0xeb35e5dd]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb35a000-0xeb35d6e8]
[    T0] ACPI: Reserving WSMT table memory at [mem 0xeb359000-0xeb359027]
[    T0] ACPI: Reserving APIC table memory at [mem 0xeb358000-0xeb3580dd]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb357000-0xeb35708c]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb356000-0xeb3568a7]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb355000-0xeb3551b6]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb354000-0xeb3547b0]
[    T0] ACPI: Reserving SSDT table memory at [mem 0xeb353000-0xeb35397c]
[    T0] ACPI: Reserving FPDT table memory at [mem 0xeb352000-0xeb352043]
[    T0] Zone ranges:
[    T0]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    T0]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    T0]   Normal   [mem 0x0000000100000000-0x0000000fee2fffff]
[    T0]   Device   empty
[    T0] Movable zone start for each node
[    T0] Early memory node ranges
[    T0]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    T0]   node   0: [mem 0x0000000000100000-0x0000000009bfefff]
[    T0]   node   0: [mem 0x000000000a001000-0x000000000a1fffff]
[    T0]   node   0: [mem 0x000000000a20f000-0x00000000e9e1ffff]
[    T0]   node   0: [mem 0x00000000ed1ff000-0x00000000edffffff]
[    T0]   node   0: [mem 0x0000000100000000-0x0000000fee2fffff]
[    T0] Initmem setup node 0 [mem 0x0000000000001000-0x0000000fee2fffff]
[    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    T0] On node 0, zone DMA: 96 pages in unavailable ranges
[    T0] On node 0, zone DMA32: 1026 pages in unavailable ranges
[    T0] On node 0, zone DMA32: 15 pages in unavailable ranges
[    T0] On node 0, zone DMA32: 13279 pages in unavailable ranges
[    T0] On node 0, zone Normal: 8192 pages in unavailable ranges
[    T0] On node 0, zone Normal: 7424 pages in unavailable ranges
[    T0] ACPI: PM-Timer IO Port: 0x808
[    T0] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    T0] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
[    T0] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 24-55
[    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    T0] ACPI: Using ACPI (MADT) for SMP configuration information
[    T0] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    T0] e820: update [mem 0xe62ee000-0xe63e1fff] usable =3D=3D> reserved
[    T0] CPU topo: Max. logical packages:   1
[    T0] CPU topo: Max. logical dies:       1
[    T0] CPU topo: Max. dies per package:   1
[    T0] CPU topo: Max. threads per core:   2
[    T0] CPU topo: Num. cores per package:     8
[    T0] CPU topo: Num. threads per package:  16
[    T0] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    T0] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x0000=
0fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000f=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0x09bff000-0x0a00=
0fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a20=
efff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xe5e58000-0xe5e5=
8fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xe5e65000-0xe5e6=
5fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xe62ee000-0xe63e=
1fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xe87cb000-0xe87c=
bfff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xe9e20000-0xeb33=
efff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xeb33f000-0xeb39=
efff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xeb39f000-0xeb55=
6fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xeb557000-0xed1f=
efff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xee000000-0xefff=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfec0=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0xfec1=
0fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0xfecf=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed0=
0fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed3=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed40000-0xfed4=
4fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed45000-0xfed7=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed8=
ffff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfed90000-0xfedc=
3fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedc4000-0xfedc=
9fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedca000-0xfedc=
bfff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedcc000-0xfedc=
efff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedcf000-0xfedd=
4fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedd5000-0xfedd=
5fff]
[    T0] PM: hibernation: Registered nosave memory: [mem 0xfedd6000-0xffff=
ffff]
[    T0] [mem 0xf0000000-0xfec0ffff] available for PCI devices
[    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffff=
ffff,
max_idle_ns: 1910969940391419 ns
[    T0] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node=
_ids:1
[    T0] percpu: Embedded 50 pages/cpu s166512 r8192 d30096 u262144
[    T0] pcpu-alloc: s166512 r8192 d30096 u262144 alloc=3D1*2097152
[    T0] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 =
15
[    T0] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc6-nop2pd=
ma
nokaslr root=3DUUID=3D73e0f015-c115-4eb2-92cb-dbf7da2b6112 ro clocksource=
=3Dhpet
amdgpu.noretry=3D0
[    T0] Unknown kernel command line parameters "nokaslr
BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc6-nop2pdma", will be passed to user sp=
ace.
[    T0] printk: log buffer data + meta data: 131072 + 458752 =3D 589824 b=
ytes
[    T0] Dentry cache hash table entries: 8388608 (order: 14, 67108864 byt=
es,
linear)
[    T0] Inode-cache hash table entries: 4194304 (order: 13, 33554432 byte=
s,
linear)
[    T0] Built 1 zonelists, mobility grouping on.  Total pages: 16616111
[    T0] mem auto-init: stack:off, heap alloc:off, heap free:off
[    T0] software IO TLB: area num 16.
[    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, Nodes=
=3D1
[    T0] Dynamic Preempt: lazy
[    T0] rcu: Preemptible hierarchical RCU implementation.
[    T0] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    T0] rcu: 	RCU_SOFTIRQ processing moved to rcuc kthreads.
[    T0] 	No expedited grace period (rcu_normal_after_boot).
[    T0] 	Trampoline variant of Tasks RCU enabled.
[    T0] 	Tracing variant of Tasks RCU enabled.
[    T0] rcu: RCU calculated value of scheduler-enlistment delay is 100 ji=
ffies.
[    T0] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=3D1
rcu_task_cpu_ids=3D16.
[    T0] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adju=
st=3D1
rcu_task_cpu_ids=3D16.
[    T0] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
[    T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    T0] Console: colour dummy device 80x25
[    T0] printk: legacy console [tty0] enabled
[    T0] ACPI: Core revision 20240827
[    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 133484873504 ns
[    T0] APIC: Switch to symmetric I/O mode setup
[    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:0xa0
[    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:0xa0
[    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:0xa0
[    T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:0xa0
[    T0] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade, EFR2:0x0
[    T0] x2apic enabled
[    T0] APIC: Switched APIC routing to: cluster x2apic
[    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
[    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:
0x2e0a17df76d, max_idle_ns: 440795361822 ns
[    T0] Calibrating delay loop (skipped), value calculated using timer
frequency.. 6387.97 BogoMIPS (lpj=3D3193985)
[    T0] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    T0] LVT offset 1 assigned for vector 0xf9
[    T0] LVT offset 2 assigned for vector 0xf4
[    T0] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    T0] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    T0] process: using mwait in idle threads
[    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user poin=
ter
sanitization
[    T0] Spectre V2 : Mitigation: Retpolines
[    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on c=
ontext
switch
[    T0] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    T0] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    T0] Spectre V2 : mitigation: Enabling conditional Indirect Branch
Prediction Barrier
[    T0] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    T0] Speculative Store Bypass: Mitigation: Speculative Store Bypass di=
sabled
via prctl
[    T0] Speculative Return Stack Overflow: IBPB-extending microcode not
applied!
[    T0] Speculative Return Stack Overflow: WARNING: See
https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitig=
ation
options.
[    T0] Speculative Return Stack Overflow: Vulnerable: Safe RET, no micro=
code
[    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point regi=
sters'
[    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    T0] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User
registers'
[    T0] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User regis=
ters'
[    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    T0] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    T0] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    T0] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes=
,
using 'compacted' format.
[    T0] Freeing SMP alternatives memory: 32K
[    T0] pid_max: default: 32768 minimum: 301
[    T0] LSM: initializing lsm=3Dcapability,apparmor
[    T0] AppArmor: AppArmor initialized
[    T0] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes,
linear)
[    T0] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 by=
tes,
linear)
[    T1] smpboot: CPU0: AMD Ryzen 7 5800H with Radeon Graphics (family: 0x=
19,
model: 0x50, stepping: 0x0)
[    T1] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    T1] ... version:                0
[    T1] ... bit width:              48
[    T1] ... generic registers:      6
[    T1] ... value mask:             0000ffffffffffff
[    T1] ... max period:             00007fffffffffff
[    T1] ... fixed-purpose events:   0
[    T1] ... event mask:             000000000000003f
[    T1] signal: max sigframe size: 3376
[    T1] rcu: Hierarchical SRCU implementation.
[    T1] rcu: 	Max phase no-delay instances is 400.
[    T1] Timer migration: 2 hierarchy levels; 8 children per group; 2 cros=
snode
level
[   T11] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    T1] smp: Bringing up secondary CPUs ...
[    T1] smpboot: x86: Booting SMP configuration:
[    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1  #3  #=
5  #7
#9 #11 #13 #15
[    T1] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    T1] smp: Brought up 1 node, 16 CPUs
[    T1] smpboot: Total of 16 processors activated (102207.52 BogoMIPS)
[  T147] node 0 deferred pages initialised in 57ms
[    T1] Memory: 65176020K/66464444K available (12095K kernel code, 1193K
rwdata, 4296K rodata, 2024K init, 752K bss, 1274508K reserved, 0K cma-rese=
rved)
[    T1] devtmpfs: initialized
[    T1] x86/mm: Memory block size: 128MB
[    T1] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20efff]
(61440 bytes)
[    T1] ACPI: PM: Registering ACPI NVS region [mem 0xeb39f000-0xeb556fff]
(1802240 bytes)
[    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 1911260446275000 ns
[    T1] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    T1] pinctrl core: initialized pinctrl subsystem
[    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    T1] audit: initializing netlink subsys (disabled)
[  T165] audit: type=3D2000 audit(1741857110.214:1): state=3Dinitialized
audit_enabled=3D0 res=3D1
[    T1] thermal_sys: Registered thermal governor 'fair_share'
[    T1] thermal_sys: Registered thermal governor 'bang_bang'
[    T1] thermal_sys: Registered thermal governor 'step_wise'
[    T1] thermal_sys: Registered thermal governor 'user_space'
[    T1] thermal_sys: Registered thermal governor 'power_allocator'
[    T1] cpuidle: using governor ladder
[    T1] cpuidle: using governor teo
[    T1] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    T1] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000000) for domai=
n 0000
[bus 00-7f]
[    T1] PCI: Using configuration type 1 for base access
[    T1] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    T1] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    T1] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    T1] ACPI: Added _OSI(Module Device)
[    T1] ACPI: Added _OSI(Processor Device)
[    T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    T1] ACPI: 16 ACPI AML tables successfully acquired and loaded
[    T1] ACPI: EC: EC started
[    T1] ACPI: EC: interrupt blocked
[    T1] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    T1] ACPI: EC: Boot ECDT EC used to handle transactions
[    T1] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    T1] ACPI: Interpreter enabled
[    T1] ACPI: PM: (supports S0 S4 S5)
[    T1] ACPI: Using IOAPIC for interrupt routing
[    T1] PCI: Using host bridge windows from ACPI; if necessary, use "pci=
=3Dnocrs"
and report a bug
[    T1] PCI: Using E820 reservations for host bridge windows
[    T1] ACPI: Enabled 1 GPEs in block 00 to 1F
[    T1] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    T1] ACPI: \_SB_.PCI0.GPP0.SWUS.M237: New power resource
[    T1] ACPI: \_SB_.PCI0.GPP0.SWUS.SWDS.M237: New power resource
[    T1] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resource
[    T1] ACPI: \_SB_.PCI0.GP17.XHC0.P3U0: New power resource
[    T1] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resource
[    T1] ACPI: \_SB_.PCI0.GP17.XHC1.P3U1: New power resource
[    T1] ACPI: \_SB_.PCI0.GPP6.P0NV: New power resource
[    T1] ACPI: \_SB_.PCI0.GPP5.P0NX: New power resource
[    T1] ACPI: \_SB_.PRWB: New power resource
[    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    T1] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
Segments MSI HPX-Type3]
[    T1] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    T1] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER
PCIeCapability]
[    T1] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf0000000-0xf7ffffff=
] for
domain 0000 [bus 00-7f] only partially covers this bridge
[    T1] PCI host bridge to bus 0000:00
[    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    T1] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    T1] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff win=
dow]
[    T1] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfcffffff win=
dow]
[    T1] pci_bus 0000:00: root bus resource [mem 0x1010000000-0xffffffffff
window]
[    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    T1] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600 conventional=
 PCI
endpoint
[    T1] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:01.1: [1022:1633] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    T1] pci 0000:00:01.1:   bridge window [mem 0xfca00000-0xfccfffff]
[    T1] pci 0000:00:01.1:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    T1] pci 0000:00:02.1:   bridge window [mem 0xfe30300000-0xfe304fffff =
64bit
pref]
[    T1] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    T1] pci 0000:00:02.2:   bridge window [io  0xf000-0xffff]
[    T1] pci 0000:00:02.2:   bridge window [mem 0xfcf00000-0xfcffffff]
[    T1] pci 0000:00:02.2: enabling Extended Tags
[    T1] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:02.3: [1022:1634] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    T1] pci 0000:00:02.3:   bridge window [mem 0xfce00000-0xfcefffff]
[    T1] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:02.4: [1022:1634] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    T1] pci 0000:00:02.4:   bridge window [mem 0xfcd00000-0xfcdfffff]
[    T1] pci 0000:00:02.4: enabling Extended Tags
[    T1] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400 PCIe Root Po=
rt
[    T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    T1] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    T1] pci 0000:00:08.1:   bridge window [mem 0xfc500000-0xfc9fffff]
[    T1] pci 0000:00:08.1:   bridge window [mem 0xfe20000000-0xfe301fffff =
64bit
pref]
[    T1] pci 0000:00:08.1: enabling Extended Tags
[    T1] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional=
 PCI
endpoint
[    T1] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.0: [1022:166a] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.1: [1022:166b] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.2: [1022:166c] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.3: [1022:166d] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.4: [1022:166e] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.5: [1022:166f] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.6: [1022:1670] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:00:18.7: [1022:1671] type 00 class 0x060000 conventional=
 PCI
endpoint
[    T1] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400 PCIe Switch
Upstream Port
[    T1] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfcc03fff]
[    T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    T1] pci 0000:01:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
[    T1] pci 0000:01:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limited b=
y 8.0
GT/s PCIe x8 link at 0000:00:01.1 (capable of 126.024 Gb/s with 16.0 GT/s =
PCIe
x8 link)
[    T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    T1] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400 PCIe Switch
Downstream Port
[    T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    T1] pci 0000:02:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
[    T1] pci 0000:02:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    T1] pci 0000:03:00.0: [1002:73ff] type 00 class 0x038000 PCIe Legacy
Endpoint
[    T1] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdffffffff 64bit pref=
]
[    T1] pci 0000:03:00.0: BAR 2 [mem 0xfe00000000-0xfe0fffffff 64bit pref=
]
[    T1] pci 0000:03:00.0: BAR 5 [mem 0xfca00000-0xfcafffff]
[    T1] pci 0000:03:00.0: ROM [mem 0xfcb00000-0xfcb1ffff pref]
[    T1] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    T1] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwidth, limited b=
y 8.0
GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 Gb/s with 16.0 GT/s =
PCIe
x16 link)
[    T1] pci 0000:03:00.1: [1002:ab28] type 00 class 0x040300 PCIe Legacy
Endpoint
[    T1] pci 0000:03:00.1: BAR 0 [mem 0xfcb20000-0xfcb23fff]
[    T1] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    T1] pci 0000:04:00.0: [14c3:0608] type 00 class 0x028000 PCIe Endpoin=
t
[    T1] pci 0000:04:00.0: BAR 0 [mem 0xfe30300000-0xfe303fffff 64bit pref=
]
[    T1] pci 0000:04:00.0: BAR 2 [mem 0xfe30400000-0xfe30403fff 64bit pref=
]
[    T1] pci 0000:04:00.0: BAR 4 [mem 0xfe30404000-0xfe30404fff 64bit pref=
]
[    T1] pci 0000:04:00.0: supports D1 D2
[    T1] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    T1] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000 PCIe Endpoin=
t
[    T1] pci 0000:05:00.0: BAR 0 [io  0xf000-0xf0ff]
[    T1] pci 0000:05:00.0: BAR 2 [mem 0xfcf04000-0xfcf04fff 64bit]
[    T1] pci 0000:05:00.0: BAR 4 [mem 0xfcf00000-0xfcf03fff 64bit]
[    T1] pci 0000:05:00.0: supports D1 D2
[    T1] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    T1] pci 0000:06:00.0: [2646:5013] type 00 class 0x010802 PCIe Endpoin=
t
[    T1] pci 0000:06:00.0: BAR 0 [mem 0xfce00000-0xfce03fff 64bit]
[    T1] pci 0000:06:00.0: 31.504 Gb/s available PCIe bandwidth, limited b=
y 8.0
GT/s PCIe x4 link at 0000:00:02.3 (capable of 63.012 Gb/s with 16.0 GT/s P=
CIe x4
link)
[    T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    T1] pci 0000:07:00.0: [c0a9:2263] type 00 class 0x010802 PCIe Endpoin=
t
[    T1] pci 0000:07:00.0: BAR 0 [mem 0xfcd00000-0xfcd03fff 64bit]
[    T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    T1] pci 0000:08:00.0: [1002:1638] type 00 class 0x030000 PCIe Legacy
Endpoint
[    T1] pci 0000:08:00.0: BAR 0 [mem 0xfe20000000-0xfe2fffffff 64bit pref=
]
[    T1] pci 0000:08:00.0: BAR 2 [mem 0xfe30000000-0xfe301fffff 64bit pref=
]
[    T1] pci 0000:08:00.0: BAR 4 [io  0xe000-0xe0ff]
[    T1] pci 0000:08:00.0: BAR 5 [mem 0xfc900000-0xfc97ffff]
[    T1] pci 0000:08:00.0: enabling Extended Tags
[    T1] pci 0000:08:00.0: PME# supported from D1 D2 D3hot D3cold
[    T1] pci 0000:08:00.1: [1002:1637] type 00 class 0x040300 PCIe Legacy
Endpoint
[    T1] pci 0000:08:00.1: BAR 0 [mem 0xfc9c8000-0xfc9cbfff]
[    T1] pci 0000:08:00.1: enabling Extended Tags
[    T1] pci 0000:08:00.1: PME# supported from D1 D2 D3hot D3cold
[    T1] pci 0000:08:00.2: [1022:15df] type 00 class 0x108000 PCIe Endpoin=
t
[    T1] pci 0000:08:00.2: BAR 2 [mem 0xfc800000-0xfc8fffff]
[    T1] pci 0000:08:00.2: BAR 5 [mem 0xfc9ce000-0xfc9cffff]
[    T1] pci 0000:08:00.2: enabling Extended Tags
[    T1] pci 0000:08:00.3: [1022:1639] type 00 class 0x0c0330 PCIe Endpoin=
t
[    T1] pci 0000:08:00.3: BAR 0 [mem 0xfc700000-0xfc7fffff 64bit]
[    T1] pci 0000:08:00.3: enabling Extended Tags
[    T1] pci 0000:08:00.3: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:08:00.4: [1022:1639] type 00 class 0x0c0330 PCIe Endpoin=
t
[    T1] pci 0000:08:00.4: BAR 0 [mem 0xfc600000-0xfc6fffff 64bit]
[    T1] pci 0000:08:00.4: enabling Extended Tags
[    T1] pci 0000:08:00.4: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:08:00.5: [1022:15e2] type 00 class 0x048000 PCIe Endpoin=
t
[    T1] pci 0000:08:00.5: BAR 0 [mem 0xfc980000-0xfc9bffff]
[    T1] pci 0000:08:00.5: enabling Extended Tags
[    T1] pci 0000:08:00.5: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:08:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoin=
t
[    T1] pci 0000:08:00.6: BAR 0 [mem 0xfc9c0000-0xfc9c7fff]
[    T1] pci 0000:08:00.6: enabling Extended Tags
[    T1] pci 0000:08:00.6: PME# supported from D0 D3hot D3cold
[    T1] pci 0000:08:00.7: [1022:15e4] type 00 class 0x118000 PCIe Endpoin=
t
[    T1] pci 0000:08:00.7: BAR 2 [mem 0xfc500000-0xfc5fffff]
[    T1] pci 0000:08:00.7: BAR 5 [mem 0xfc9cc000-0xfc9cdfff]
[    T1] pci 0000:08:00.7: enabling Extended Tags
[    T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    T1] pci_bus 0000:00: on NUMA node 0
[    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    T1] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    T1] Low-power S0 idle used by default for system suspend
[    T1] ACPI: EC: interrupt unblocked
[    T1] ACPI: EC: event unblocked
[    T1] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    T1] ACPI: EC: GPE=3D0x3
[    T1] ACPI: \_SB_.PCI0.SBRG.EC__: Boot ECDT EC initialization complete
[    T1] ACPI: \_SB_.PCI0.SBRG.EC__: EC: Used to handle transactions and e=
vents
[    T1] iommu: Default domain type: Passthrough
[    T1] EDAC MC: Ver: 3.0.0
[    T1] efivars: Registered efivars operations
[    T1] PCI: Using ACPI for IRQ routing
[    T1] PCI: pci_cache_line_size set to 64 bytes
[    T1] e820: reserve RAM buffer [mem 0x09bff000-0x0bffffff]
[    T1] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    T1] e820: reserve RAM buffer [mem 0xe5e58018-0xe7ffffff]
[    T1] e820: reserve RAM buffer [mem 0xe62ee000-0xe7ffffff]
[    T1] e820: reserve RAM buffer [mem 0xe87cb000-0xebffffff]
[    T1] e820: reserve RAM buffer [mem 0xe9e20000-0xebffffff]
[    T1] e820: reserve RAM buffer [mem 0xee000000-0xefffffff]
[    T1] e820: reserve RAM buffer [mem 0xfee300000-0xfefffffff]
[    T1] pci 0000:08:00.0: vgaarb: setting as boot VGA device
[    T1] pci 0000:08:00.0: vgaarb: bridge control possible
[    T1] pci 0000:08:00.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[    T1] vgaarb: loaded
[    T1] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    T1] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    T1] clocksource: Switched to clocksource hpet
[    T1] AppArmor: AppArmor Filesystem Enabled
[    T1] pnp: PnP ACPI init
[    T1] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    T1] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    T1] system 00:04: [io  0x040b] has been reserved
[    T1] system 00:04: [io  0x04d6] has been reserved
[    T1] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    T1] system 00:04: [io  0x0c14] has been reserved
[    T1] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    T1] system 00:04: [io  0x0c52] has been reserved
[    T1] system 00:04: [io  0x0c6c] has been reserved
[    T1] system 00:04: [io  0x0c6f] has been reserved
[    T1] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    T1] system 00:04: [io  0x0800-0x089f] has been reserved
[    T1] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    T1] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    T1] system 00:04: [io  0x0900-0x090f] has been reserved
[    T1] system 00:04: [io  0x0910-0x091f] has been reserved
[    T1] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    T1] system 00:04: [mem 0xfec01000-0xfec01fff] could not be reserved
[    T1] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    T1] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    T1] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    T1] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    T1] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    T1] pnp: PnP ACPI: found 5 devices
[    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_id=
le_ns:
2085701024 ns
[    T1] NET: Registered PF_INET protocol family
[    T1] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, li=
near)
[    T1] tcp_listen_portaddr_hash hash table entries: 32768 (order: 8, 131=
0720
bytes, linear)
[    T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes,
linear)
[    T1] TCP established hash table entries: 524288 (order: 10, 4194304 by=
tes,
linear)
[    T1] TCP bind hash table entries: 65536 (order: 10, 5242880 bytes, vma=
lloc
hugepage)
[    T1] TCP: Hash tables configured (established 524288 bind 65536)
[    T1] MPTCP token hash table entries: 65536 (order: 9, 3670016 bytes, l=
inear)
[    T1] UDP hash table entries: 32768 (order: 10, 5242880 bytes, vmalloc
hugepage)
[    T1] UDP-Lite hash table entries: 32768 (order: 10, 5242880 bytes, vma=
lloc
hugepage)
[    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    T1] NET: Registered PF_XDP protocol family
[    T1] pci 0000:00:01.1: bridge window [io  0x1000-0x0fff] to [bus 01-03=
]
add_size 1000
[    T1] pci 0000:00:01.1: bridge window [io  0x1000-0x1fff]: assigned
[    T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    T1] pci 0000:02:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
[    T1] pci 0000:02:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    T1] pci 0000:01:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
[    T1] pci 0000:01:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    T1] pci 0000:00:01.1:   bridge window [io  0x1000-0x1fff]
[    T1] pci 0000:00:01.1:   bridge window [mem 0xfca00000-0xfccfffff]
[    T1] pci 0000:00:01.1:   bridge window [mem 0xfc00000000-0xfe0fffffff =
64bit
pref]
[    T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    T1] pci 0000:00:02.1:   bridge window [mem 0xfe30300000-0xfe304fffff =
64bit
pref]
[    T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    T1] pci 0000:00:02.2:   bridge window [io  0xf000-0xffff]
[    T1] pci 0000:00:02.2:   bridge window [mem 0xfcf00000-0xfcffffff]
[    T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    T1] pci 0000:00:02.3:   bridge window [mem 0xfce00000-0xfcefffff]
[    T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    T1] pci 0000:00:02.4:   bridge window [mem 0xfcd00000-0xfcdfffff]
[    T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    T1] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    T1] pci 0000:00:08.1:   bridge window [mem 0xfc500000-0xfc9fffff]
[    T1] pci 0000:00:08.1:   bridge window [mem 0xfe20000000-0xfe301fffff =
64bit
pref]
[    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    T1] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    T1] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    T1] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    T1] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    T1] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfcffffff window]
[    T1] pci_bus 0000:00: resource 10 [mem 0x1010000000-0xffffffffff windo=
w]
[    T1] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    T1] pci_bus 0000:01: resource 1 [mem 0xfca00000-0xfccfffff]
[    T1] pci_bus 0000:01: resource 2 [mem 0xfc00000000-0xfe0fffffff 64bit =
pref]
[    T1] pci_bus 0000:02: resource 1 [mem 0xfca00000-0xfcbfffff]
[    T1] pci_bus 0000:02: resource 2 [mem 0xfc00000000-0xfe0fffffff 64bit =
pref]
[    T1] pci_bus 0000:03: resource 1 [mem 0xfca00000-0xfcbfffff]
[    T1] pci_bus 0000:03: resource 2 [mem 0xfc00000000-0xfe0fffffff 64bit =
pref]
[    T1] pci_bus 0000:04: resource 2 [mem 0xfe30300000-0xfe304fffff 64bit =
pref]
[    T1] pci_bus 0000:05: resource 0 [io  0xf000-0xffff]
[    T1] pci_bus 0000:05: resource 1 [mem 0xfcf00000-0xfcffffff]
[    T1] pci_bus 0000:06: resource 1 [mem 0xfce00000-0xfcefffff]
[    T1] pci_bus 0000:07: resource 1 [mem 0xfcd00000-0xfcdfffff]
[    T1] pci_bus 0000:08: resource 0 [io  0xe000-0xefff]
[    T1] pci_bus 0000:08: resource 1 [mem 0xfc500000-0xfc9fffff]
[    T1] pci_bus 0000:08: resource 2 [mem 0xfe20000000-0xfe301fffff 64bit =
pref]
[    T1] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    T1] pci 0000:08:00.1: D0 power state depends on 0000:08:00.0
[    T1] pci 0000:08:00.3: extending delay after power-on from D3hot to 20=
 msec
[    T1] pci 0000:08:00.4: extending delay after power-on from D3hot to 20=
 msec
[    T1] PCI: CLS 64 bytes, default 64
[    T1] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[  T150] Trying to unpack rootfs image as initramfs...
[    T1] pci 0000:00:00.0: Adding to iommu group 0
[    T1] pci 0000:00:01.0: Adding to iommu group 1
[    T1] pci 0000:00:01.1: Adding to iommu group 2
[    T1] pci 0000:00:02.0: Adding to iommu group 3
[    T1] pci 0000:00:02.1: Adding to iommu group 4
[    T1] pci 0000:00:02.2: Adding to iommu group 5
[    T1] pci 0000:00:02.3: Adding to iommu group 6
[    T1] pci 0000:00:02.4: Adding to iommu group 7
[    T1] pci 0000:00:08.0: Adding to iommu group 8
[    T1] pci 0000:00:08.1: Adding to iommu group 9
[    T1] pci 0000:00:14.0: Adding to iommu group 10
[    T1] pci 0000:00:14.3: Adding to iommu group 10
[    T1] pci 0000:00:18.0: Adding to iommu group 11
[    T1] pci 0000:00:18.1: Adding to iommu group 11
[    T1] pci 0000:00:18.2: Adding to iommu group 11
[    T1] pci 0000:00:18.3: Adding to iommu group 11
[    T1] pci 0000:00:18.4: Adding to iommu group 11
[    T1] pci 0000:00:18.5: Adding to iommu group 11
[    T1] pci 0000:00:18.6: Adding to iommu group 11
[    T1] pci 0000:00:18.7: Adding to iommu group 11
[    T1] pci 0000:01:00.0: Adding to iommu group 12
[    T1] pci 0000:02:00.0: Adding to iommu group 13
[    T1] pci 0000:03:00.0: Adding to iommu group 14
[    T1] pci 0000:03:00.1: Adding to iommu group 15
[    T1] pci 0000:04:00.0: Adding to iommu group 16
[    T1] pci 0000:05:00.0: Adding to iommu group 17
[    T1] pci 0000:06:00.0: Adding to iommu group 18
[    T1] pci 0000:07:00.0: Adding to iommu group 19
[    T1] pci 0000:08:00.0: Adding to iommu group 20
[    T1] pci 0000:08:00.1: Adding to iommu group 21
[    T1] pci 0000:08:00.2: Adding to iommu group 22
[    T1] pci 0000:08:00.3: Adding to iommu group 23
[    T1] pci 0000:08:00.4: Adding to iommu group 24
[    T1] pci 0000:08:00.5: Adding to iommu group 25
[    T1] pci 0000:08:00.6: Adding to iommu group 26
[    T1] pci 0000:08:00.7: Adding to iommu group 27
[    T1] AMD-Vi: Extended features (0x206d73ef22254ade, 0x0): PPR X2APIC N=
X GT
IA GA PC GA_vAPIC
[    T1] AMD-Vi: Interrupt remapping enabled
[    T1] AMD-Vi: X2APIC enabled
[    T1] AMD-Vi: Virtual APIC enabled
[    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    T1] software IO TLB: mapped [mem 0x00000000e1e58000-0x00000000e5e5800=
0]
(64MB)
[    T1] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms o=
vfl
timer
[    T1] RAPL PMU: hw unit of domain package 2^-16 Joules
[    T1] RAPL PMU: hw unit of domain core 2^-16 Joules
[    T1] LVT offset 0 assigned for vector 0x400
[    T1] perf: AMD IBS detected (0x000003ff)
[   T26] amd_uncore: 4 amd_df counters detected
[   T26] amd_uncore: 6 amd_l3 counters detected
[    T1] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    T1] Initialise system trusted keyrings
[    T1] workingset: timestamp_bits=3D46 max_order=3D24 bucket_order=3D0
[    T1] Key type asymmetric registered
[    T1] Asymmetric key parser 'x509' registered
[    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 2=
51)
[    T1] io scheduler bfq registered
[    T1] pcieport 0000:00:01.1: PME: Signaling with IRQ 43
[    T1] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- Att=
nInd-
PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    T1] pcieport 0000:00:02.1: PME: Signaling with IRQ 44
[    T1] pcieport 0000:00:02.2: PME: Signaling with IRQ 45
[    T1] pcieport 0000:00:02.3: PME: Signaling with IRQ 46
[    T1] pcieport 0000:00:02.4: PME: Signaling with IRQ 47
[    T1] pcieport 0000:00:08.1: PME: Signaling with IRQ 48
[    T1] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: =
no)
[    T1] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:13/LNXVIDEO:00/input/in=
put0
[   T26] Monitor-Mwait will be used to enter C-1 state
[    T1] Estimated ratio of average max frequency by base frequency (times
1024): 1226
[    T1] thermal LNXTHERM:00: registered as thermal_zone0
[    T1] ACPI: thermal: Thermal Zone [THRM] (54 C)
[    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    T1] ACPI: bus type drm_connector registered
[    T1] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0=
x64
irq 1,12
[    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[    T1] serio: i8042 AUX port at 0x60,0x64 irq 12
[    T1] mousedev: PS/2 mouse device common for all mice
[    T1] rtc_cmos 00:01: RTC can wake from S4
[    T1] rtc_cmos 00:01: registered as rtc0
[    T1] rtc_cmos 00:01: setting system clock to 2025-03-13T09:11:51 UTC
(1741857111)
[    T1] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[    T1] efifb: probing for efifb
[    T1] efifb: framebuffer at 0xfe20000000, using 8100k, total 8100k
[    T1] efifb: mode is 1920x1080x32, linelength=3D7680, pages=3D1
[    T1] efifb: scrolling: redraw
[    T1] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[  T175] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input1
[    T1] Console: switching to colour frame buffer device 240x67
[    T1] fb0: EFI VGA frame buffer device
[    T1] NET: Registered PF_INET6 protocol family
[  T150] Freeing initrd memory: 41996K
[    T1] Segment Routing with IPv6
[    T1] In-situ OAM (IOAM) with IPv6
[    T1] mip6: Mobile IPv6
[    T1] NET: Registered PF_PACKET protocol family
[    T1] mpls_gso: MPLS GSO support
[    T1] microcode: Current revision: 0x0a50000c
[    T1] resctrl: L3 allocation detected
[    T1] resctrl: MB allocation detected
[    T1] resctrl: L3 monitoring detected
[    T1] IPI shorthand broadcast: enabled
[    T1] sched_clock: Marking stable (533009848, 1219781)->(551429975, -
17200346)
[    T1] registered taskstats version 1
[    T1] Loading compiled-in X.509 certificates
[    T1] Key type .fscrypt registered
[    T1] Key type fscrypt-provisioning registered
[    T1] AppArmor: AppArmor sha256 policy hashing enabled
[  T154] pci_bus 0000:03: Allocating resources
[    T1] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GP17.M=
P2],
AE_NOT_FOUND (20240827/psargs-332)
[    T1] ACPI Error: Aborting method \_SB.GPIO._EVT due to previous error
(AE_NOT_FOUND) (20240827/psparse-529)
[    T1] clk: Disabling unused clocks
[    T1] PM: genpd: Disabling unused power domains
[    T1] Freeing unused kernel image (initmem) memory: 2024K
[    T1] Write protecting the kernel read-only data: 18432k
[    T1] Freeing unused kernel image (text/rodata gap) memory: 192K
[    T1] Freeing unused kernel image (rodata/data gap) memory: 1848K
[    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    T1] Run /init as init process
[    T1]   with arguments:
[    T1]     /init
[    T1]     nokaslr
[    T1]   with environment:
[    T1]     HOME=3D/
[    T1]     TERM=3Dlinux
[    T1]     BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc6-nop2pdma
[  T390] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revisio=
n 0
[  T390] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port sele=
ction
[  T390] i2c i2c-1: Successfully instantiated SPD at 0x50
[  T390] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb2=
0
[  T353] hid: raw HID events driver (C) Jiri Kosina
[  T152] nvme 0000:06:00.0: platform quirk: setting simple suspend
[  T150] nvme 0000:07:00.0: platform quirk: setting simple suspend
[  T152] nvme nvme0: pci function 0000:06:00.0
[  T150] nvme nvme1: pci function 0000:07:00.0
[  T150] nvme nvme1: missing or invalid SUBNQN field.
[  T152] nvme nvme0: D3 entry latency set to 10 seconds
[  T345] r8169 0000:05:00.0 eth0: RTL8168h/8111h, d8:bb:c1:ab:dd:5e, XID 5=
41,
IRQ 56
[  T345] r8169 0000:05:00.0 eth0: jumbo features [frames: 9194 bytes, tx
checksumming: ko]
[  T364] pcie_mp2_amd 0000:08:00.7: enabling device (0000 -> 0002)
[  T150] nvme nvme1: 15/0/0 default/read/poll queues
[  T152] nvme nvme0: 16/0/0 default/read/poll queues
[  T348] ACPI: bus type USB registered
[  T348] usbcore: registered new interface driver usbfs
[  T348] usbcore: registered new interface driver hub
[  T348] usbcore: registered new device driver usb
[  T156]  nvme1n1: p1
[  T151]  nvme0n1: p1 p2 p3 p4
[  T361] hid-generic 0020:1022:0001.0001: hidraw0: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T361] hid-generic 0020:1022:0001.0002: hidraw1: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T363] r8169 0000:05:00.0 enp5s0: renamed from eth0
[  T361] hid-generic 0020:1022:0001.0003: hidraw2: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T361] hid-generic 0020:1022:0001.0004: hidraw3: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T361] hid-generic 0020:1022:0001.0005: hidraw4: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T361] hid-generic 0020:1022:0001.0006: hidraw5: SENSOR HUB HID v0.00 De=
vice
[hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T152] input: PNP0C50:0e 06CB:7E7E Mouse as /devices/platform/AMDI0010:0=
3/i2c-
0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input5
[  T152] input: PNP0C50:0e 06CB:7E7E Touchpad as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0007/input/input6
[  T152] hid-generic 0018:06CB:7E7E.0007: input,hidraw6: I2C HID v1.00 Mou=
se
[PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[  T344] xhci_hcd 0000:08:00.3: xHCI Host Controller
[  T344] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus numbe=
r 1
[  T344] xhci_hcd 0000:08:00.3: hcc params 0x0268ffe5 hci version 0x110 qu=
irks
0x0000020000000010
[  T374] hid-sensor-hub 0020:1022:0001.0001: hidraw0: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T344] xhci_hcd 0000:08:00.3: xHCI Host Controller
[  T344] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus numbe=
r 2
[  T344] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[  T344] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002=
,
bcdDevice=3D 6.14
[  T344] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNum=
ber=3D1
[  T344] usb usb1: Product: xHCI Host Controller
[  T344] usb usb1: Manufacturer: Linux 6.14.0-rc6-nop2pdma xhci-hcd
[  T344] usb usb1: SerialNumber: 0000:08:00.3
[  T344] hub 1-0:1.0: USB hub found
[  T374] hid-sensor-hub 0020:1022:0001.0002: hidraw1: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T344] hub 1-0:1.0: 4 ports detected
[  T374] hid-sensor-hub 0020:1022:0001.0003: hidraw2: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T374] hid-sensor-hub 0020:1022:0001.0004: hidraw3: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T344] usb usb2: We don't know the algorithms for LPM for this host, dis=
abling
LPM.
[  T344] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0003=
,
bcdDevice=3D 6.14
[  T344] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNum=
ber=3D1
[  T344] usb usb2: Product: xHCI Host Controller
[  T344] usb usb2: Manufacturer: Linux 6.14.0-rc6-nop2pdma xhci-hcd
[  T344] usb usb2: SerialNumber: 0000:08:00.3
[  T344] hub 2-0:1.0: USB hub found
[  T344] hub 2-0:1.0: 2 ports detected
[  T374] hid-sensor-hub 0020:1022:0001.0005: hidraw4: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T374] hid-sensor-hub 0020:1022:0001.0006: hidraw5: SENSOR HUB HID v0.00
Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[  T370] input: PNP0C50:0e 06CB:7E7E Mouse as /devices/platform/AMDI0010:0=
3/i2c-
0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input8
[  T370] input: PNP0C50:0e 06CB:7E7E Touchpad as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0007/input/input9
[  T370] hid-multitouch 0018:06CB:7E7E.0007: input,hidraw6: I2C HID v1.00 =
Mouse
[PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[  T344] xhci_hcd 0000:08:00.4: xHCI Host Controller
[  T344] xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus numbe=
r 3
[  T344] xhci_hcd 0000:08:00.4: hcc params 0x0268ffe5 hci version 0x110 qu=
irks
0x0000020000000010
[  T344] xhci_hcd 0000:08:00.4: xHCI Host Controller
[  T344] xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus numbe=
r 4
[  T344] xhci_hcd 0000:08:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[  T344] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=3D0002=
,
bcdDevice=3D 6.14
[  T344] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, SerialNum=
ber=3D1
[  T344] usb usb3: Product: xHCI Host Controller
[  T344] usb usb3: Manufacturer: Linux 6.14.0-rc6-nop2pdma xhci-hcd
[  T344] usb usb3: SerialNumber: 0000:08:00.4
[  T344] hub 3-0:1.0: USB hub found
[  T344] hub 3-0:1.0: 4 ports detected
[  T344] usb usb4: We don't know the algorithms for LPM for this host, dis=
abling
LPM.
[  T344] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=3D0003=
,
bcdDevice=3D 6.14
[  T344] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, SerialNum=
ber=3D1
[  T344] usb usb4: Product: xHCI Host Controller
[  T344] usb usb4: Manufacturer: Linux 6.14.0-rc6-nop2pdma xhci-hcd
[  T344] usb usb4: SerialNumber: 0000:08:00.4
[  T344] hub 4-0:1.0: USB hub found
[  T344] hub 4-0:1.0: 2 ports detected
[   T11] usb 1-2: new low-speed USB device number 2 using xhci_hcd
[  T339] tsc: Refined TSC clocksource calibration: 3193.988 MHz
[  T339] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e0a1a75=
d94,
max_idle_ns: 440795268383 ns
[    T9] usb 3-3: new high-speed USB device number 2 using xhci_hcd
[   T11] usb 1-2: New USB device found, idVendor=3D1bcf, idProduct=3D08a0,
bcdDevice=3D 1.04
[   T11] usb 1-2: New USB device strings: Mfr=3D0, Product=3D0, SerialNumb=
er=3D0
[  T357] [drm] amdgpu kernel modesetting enabled.
[  T357] amdgpu: vga_switcheroo: detected switching method
\_SB_.PCI0.GP17.VGA_.ATPX handle
[  T357] amdgpu: ATPX version 1, functions 0x00000001
[  T357] amdgpu: ATPX Hybrid Graphics
[    T9] usb 3-3: New USB device found, idVendor=3D0e8d, idProduct=3D0608,
bcdDevice=3D 1.00
[    T9] usb 3-3: New USB device strings: Mfr=3D5, Product=3D6, SerialNumb=
er=3D7
[    T9] usb 3-3: Product: Wireless_Device
[    T9] usb 3-3: Manufacturer: MediaTek Inc.
[    T9] usb 3-3: SerialNumber: 000000000
[   T11] usb 1-4: new high-speed USB device number 3 using xhci_hcd
[  T357] amdgpu: Virtual CRAT table created for CPU
[  T357] amdgpu: Topology: Add CPU node
[  T357] amdgpu 0000:03:00.0: enabling device (0000 -> 0002)
[  T357] [drm] initializing kernel modesetting (DIMGREY_CAVEFISH 0x1002:0x=
73FF
0x1462:0x1313 0xC3).
[  T357] [drm] register mmio base: 0xFCA00000
[  T357] [drm] register mmio size: 1048576
[  T357] amdgpu 0000:03:00.0: amdgpu: detected ip block number 0 <nv_commo=
n>
[  T357] amdgpu 0000:03:00.0: amdgpu: detected ip block number 1 <gmc_v10_=
0>
[  T357] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <navi10_i=
h>
[  T357] amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp>
[  T357] amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu>
[  T357] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dm>
[  T357] amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <gfx_v10_=
0>
[  T357] amdgpu 0000:03:00.0: amdgpu: detected ip block number 7 <sdma_v5_=
2>
[  T357] amdgpu 0000:03:00.0: amdgpu: detected ip block number 8 <vcn_v3_0=
>
[  T357] amdgpu 0000:03:00.0: amdgpu: detected ip block number 9 <jpeg_v3_=
0>
[  T357] amdgpu 0000:03:00.0: amdgpu: ACPI VFCT table present but broken (=
too
short #2),skipping
[    T9] usb 3-4: new full-speed USB device number 3 using xhci_hcd
[   T11] usb 1-4: New USB device found, idVendor=3D30c9, idProduct=3D0042,
bcdDevice=3D 0.03
[   T11] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, SerialNumb=
er=3D3
[   T11] usb 1-4: Product: Integrated Camera
[   T11] usb 1-4: Manufacturer: S1F0009330LB620L420004LP
[   T11] usb 1-4: SerialNumber: SunplusIT Inc
[  T357] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from ROM BAR
[  T357] amdgpu: ATOM BIOS: SWBRT77181.001
[  T357] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature di=
sabled
as experimental (default)
[  T357] [drm] GPU posting now...
[  T357] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragme=
nt
size is 9-bit
[  T357] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 -
0x00000081FEFFFFFF (8176M used)
[  T357] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 -
0x000000001FFFFFFF
[  T357] [drm] Detected VRAM RAM=3D8176M, BAR=3D8192M
[  T357] [drm] RAM width 128bits GDDR6
[  T357] [drm] amdgpu: 8176M of VRAM memory ready
[  T357] [drm] amdgpu: 31853M of GTT memory ready.
[  T357] [drm] GART: num cpu pages 131072, num gpu pages 131072
[  T357] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[  T370] input: HID 1bcf:08a0 Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-2/1-
2:1.0/0003:1BCF:08A0.0008/input/input11
[  T370] input: HID 1bcf:08a0 Keyboard as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-2/1-
2:1.0/0003:1BCF:08A0.0008/input/input12
[    T9] usb 3-4: New USB device found, idVendor=3D1462, idProduct=3D1563,
bcdDevice=3D 2.00
[    T9] usb 3-4: New USB device strings: Mfr=3D1, Product=3D2, SerialNumb=
er=3D3
[    T9] usb 3-4: Product: MysticLight MS-1563 v0001
[    T9] usb 3-4: Manufacturer: MSI
[    T9] usb 3-4: SerialNumber: 2064386A5430
[    T9] hid-generic 0003:1462:1563.0009: hiddev0,hidraw7: USB HID v1.11 D=
evice
[MSI MysticLight MS-1563 v0001] on usb-0000:08:00.4-4/input0
[  T370] input: HID 1bcf:08a0 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-2/1-
2:1.0/0003:1BCF:08A0.0008/input/input13
[  T370] hid-generic 0003:1BCF:08A0.0008: input,hiddev1,hidraw8: USB HID v=
1.10
Mouse [HID 1bcf:08a0] on usb-0000:08:00.3-2/input0
[  T370] usbcore: registered new interface driver usbhid
[  T370] usbhid: USB HID core driver
[  T357] amdgpu 0000:03:00.0: amdgpu: STB initialized to 2048 entries
[  T357] [drm] Loading DMUB firmware via PSP: version=3D0x02020020
[  T357] [drm] use_doorbell being set to: [true]
[  T357] [drm] use_doorbell being set to: [true]
[  T357] [drm] Found VCN firmware Version ENC: 1.33 DEC: 4 VEP: 0 Revision=
: 3
[  T357] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[  T357] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[  T357] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[  T357] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[  T357] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[  T357] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[  T357] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[  T357] [drm] Display Core v3.2.316 initialized on DCN 3.0.2
[  T357] [drm] DP-HDMI FRL PCON supported
[  T357] [drm] DMUB hardware initialized: version=3D0x02020020
[  T357] [drm] kiq ring mec 2 pipe 1 q 0
[  T357] amdgpu: HMM registered 8176MB device memory
[  T357] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[  T357] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[  T357] amdgpu: Virtual CRAT table created for GPU
[  T357] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[  T357] kfd kfd: amdgpu: added device 1002:73ff
[  T357] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8,
active_cu_number 28
[  T357] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[  T357] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[  T357] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[  T357] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[  T357] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[  T357] amdgpu 0000:03:00.0: amdgpu: Using BOCO for runtime pm
[  T357] [drm] Initialized amdgpu 3.61.0 for 0000:03:00.0 on minor 0
[  T357] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[  T357] [drm] pre_validate_dsc:1601 MST_DSC dsc precompute is not needed
[  T357] amdgpu 0000:08:00.0: enabling device (0006 -> 0007)
[  T357] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1638
0x1462:0x1313 0xC5).
[  T357] [drm] register mmio base: 0xFC900000
[  T357] [drm] register mmio size: 524288
[  T357] amdgpu 0000:08:00.0: amdgpu: detected ip block number 0 <soc15_co=
mmon>
[  T357] amdgpu 0000:08:00.0: amdgpu: detected ip block number 1 <gmc_v9_0=
>
[  T357] amdgpu 0000:08:00.0: amdgpu: detected ip block number 2 <vega10_i=
h>
[  T357] amdgpu 0000:08:00.0: amdgpu: detected ip block number 3 <psp>
[  T357] amdgpu 0000:08:00.0: amdgpu: detected ip block number 4 <smu>
[  T357] amdgpu 0000:08:00.0: amdgpu: detected ip block number 5 <dm>
[  T357] amdgpu 0000:08:00.0: amdgpu: detected ip block number 6 <gfx_v9_0=
>
[  T357] amdgpu 0000:08:00.0: amdgpu: detected ip block number 7 <sdma_v4_=
0>
[  T357] amdgpu 0000:08:00.0: amdgpu: detected ip block number 8 <vcn_v2_0=
>
[  T357] amdgpu 0000:08:00.0: amdgpu: detected ip block number 9 <jpeg_v2_=
0>
[  T357] amdgpu 0000:08:00.0: amdgpu: Fetched VBIOS from VFCT
[  T357] amdgpu: ATOM BIOS: 113-CEZANNE-018
[  T357] Console: switching to colour dummy device 80x25
[  T357] amdgpu 0000:08:00.0: vgaarb: deactivate vga console
[  T357] amdgpu 0000:08:00.0: amdgpu: Trusted Memory Zone (TMZ) feature en=
abled
[  T357] amdgpu 0000:08:00.0: amdgpu: MODE2 reset
[  T357] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragme=
nt
size is 9-bit
[  T357] amdgpu 0000:08:00.0: amdgpu: VRAM: 512M 0x000000F400000000 -
0x000000F41FFFFFFF (512M used)
[  T357] amdgpu 0000:08:00.0: amdgpu: GART: 1024M 0x0000000000000000 -
0x000000003FFFFFFF
[  T357] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
[  T357] [drm] RAM width 128bits DDR4
[  T357] [drm] amdgpu: 512M of VRAM memory ready
[  T357] [drm] amdgpu: 31853M of GTT memory ready.
[  T357] [drm] GART: num cpu pages 262144, num gpu pages 262144
[  T357] [drm] PCIE GART of 1024M enabled.
[  T357] [drm] PTB located at 0x000000F41FC00000
[  T357] [drm] Loading DMUB firmware via PSP: version=3D0x0101002B
[  T357] [drm] Found VCN firmware Version ENC: 1.24 DEC: 8 VEP: 0 Revision=
: 3
[  T357] amdgpu 0000:08:00.0: amdgpu: reserve 0x400000 from 0xf41f800000 f=
or PSP
TMR
[  T357] amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[  T357] amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode is not
available
[  T357] amdgpu 0000:08:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[  T357] amdgpu 0000:08:00.0: amdgpu: SMU is initialized successfully!
[  T357] [drm] Display Core v3.2.316 initialized on DCN 2.1
[  T357] [drm] DP-HDMI FRL PCON supported
[  T357] [drm] DMUB hardware initialized: version=3D0x0101002B
[  T357] [drm] kiq ring mec 2 pipe 1 q 0
[  T357] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[  T357] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[  T357] amdgpu: Virtual CRAT table created for GPU
[  T357] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[  T357] kfd kfd: amdgpu: added device 1002:1638
[  T357] amdgpu 0000:08:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8,
active_cu_number 8
[  T357] amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[  T357] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on=
 hub 0
[  T357] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on=
 hub 0
[  T357] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on=
 hub 0
[  T357] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on=
 hub 0
[  T357] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on=
 hub 0
[  T357] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on=
 hub 0
[  T357] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on=
 hub 0
[  T357] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 o=
n hub
0
[  T357] amdgpu 0000:08:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 =
on hub
0
[  T357] amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub =
8
[  T357] amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hu=
b 8
[  T357] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on h=
ub 8
[  T357] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on h=
ub 8
[  T357] amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on h=
ub 8
[  T357] amdgpu 0000:08:00.0: amdgpu: Runtime PM not available
[  T357] [drm] Initialized amdgpu 3.61.0 for 0000:08:00.0 on minor 1
[  T357] fbcon: amdgpudrmfb (fb0) is primary device
[  T357] Console: switching to colour frame buffer device 240x67
[  T357] amdgpu 0000:08:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[  T522] PM: Image not found (code -22)
[  T535] EXT4-fs (nvme0n1p2): mounted filesystem 73e0f015-c115-4eb2-92cb-
dbf7da2b6112 ro with ordered data mode. Quota mode: disabled.
[  T591] pstore: Using crash dump compression: deflate
[  T591] pstore: Registered efi_pstore as persistent store backend
[  T592] fuse: init (API version 7.42)
[  T598] cfg80211: Loading compiled-in X.509 certificates for regulatory
database
[  T607] EXT4-fs (nvme0n1p2): re-mounted 73e0f015-c115-4eb2-92cb-dbf7da2b6=
112
r/w. Quota mode: disabled.
[  T598] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  T598] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600=
'
[  T619] cfg80211: loaded regulatory.db is malformed or signature is
missing/invalid
[   T81] psmouse serio1: Failed to deactivate mouse on isa0060/serio1: -71
[  T598] mt7921e 0000:04:00.0: enabling device (0000 -> 0002)
[  T598] mt7921e 0000:04:00.0: ASIC revision: 79610010
[   T81] psmouse serio1: Failed to enable mouse on isa0060/serio1
[  T311] mt7921e 0000:04:00.0: HW/SW Version: 0x8a108a10, Build Time:
20241106151007a
[  T311]
[  T311] mt7921e 0000:04:00.0: WM Firmware Version: ____010000, Build Time=
:
20241106151045
[  T649] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:33/PNP0C09:00/PNP0C0D:0=
0/inpu
t/input14
[  T649] ACPI: button: Lid Switch [LID0]
[  T649] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input15
[  T649] ACPI: button: Power Button [PWRB]
[  T649] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input16
[  T649] ACPI: button: Sleep Button [SLPB]
[  T659] ACPI: AC: AC Adapter [ADP1] (on-line)
[  T701] ccp 0000:08:00.2: enabling device (0000 -> 0002)
[  T701] ccp 0000:08:00.2: tee enabled
[  T701] ccp 0000:08:00.2: psp enabled
[  T650] MCE: In-kernel MCE decoding enabled.
[  T656] mc: Linux media interface: v0.10
[  T152] ACPI: battery: Slot [BAT1] (battery present)
[  T686] input: MSI WMI hotkeys as /devices/virtual/input/input17
[  T642] snd_rn_pci_acp3x 0000:08:00.5: enabling device (0000 -> 0002)
[  T727] Adding 75497468k swap on /dev/nvme0n1p3.  Priority:-2 extents:1
across:75497468k SS
[  T656] videodev: Linux video capture interface: v2.00
[  T656] usb 1-4: Found UVC 1.00 device Integrated Camera (30c9:0042)
[  T693] Bluetooth: Core ver 2.22
[  T693] NET: Registered PF_BLUETOOTH protocol family
[  T693] Bluetooth: HCI device and connection manager initialized
[  T693] Bluetooth: HCI socket layer initialized
[  T693] Bluetooth: L2CAP socket layer initialized
[  T693] Bluetooth: SCO socket layer initialized
[  T652] snd_hda_intel 0000:03:00.1: enabling device (0000 -> 0002)
[  T652] snd_hda_intel 0000:03:00.1: Handle vga_switcheroo audio client
[  T652] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[  T652] snd_hda_intel 0000:08:00.1: enabling device (0000 -> 0002)
[  T652] snd_hda_intel 0000:08:00.1: Handle vga_switcheroo audio client
[  T652] snd_hda_intel 0000:08:00.6: enabling device (0000 -> 0002)
[  T693] usbcore: registered new interface driver btusb
[  T210] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 202411061=
51414
[  T696] snd_hda_intel 0000:08:00.1: bound 0000:08:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[  T696] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[  T622] input: HD-Audio Generic HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input18
[  T656] usbcore: registered new interface driver uvcvideo
[  T622] input: HD-Audio Generic HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input19
[   T97] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd0/input22
[  T622] input: HD-Audio Generic HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input20
[   T97] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd0/input23
[  T622] input: HD-Audio Generic HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input21
[   T97] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd0/input24
[   T97] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd0/input25
[   T97] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/so=
und/ca
rd0/input26
[  T780] snd_hda_codec_realtek hdaudioC2D0: autoconfig for ALC233: line_ou=
ts=3D1
(0x14/0x0/0x0/0x0/0x0) type:speaker
[  T780] snd_hda_codec_realtek hdaudioC2D0:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[  T780] snd_hda_codec_realtek hdaudioC2D0:    hp_outs=3D1 (0x21/0x0/0x0/0=
x0/0x0)
[  T780] snd_hda_codec_realtek hdaudioC2D0:    mono: mono_out=3D0x0
[  T780] snd_hda_codec_realtek hdaudioC2D0:    inputs:
[  T780] snd_hda_codec_realtek hdaudioC2D0:      Mic=3D0x19
[  T176] input: HD-Audio Generic Mic as
/devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card2/input27
[  T176] input: HD-Audio Generic Headphone as
/devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card2/input28
[  T210] Bluetooth: hci0: Device setup in 148198 usecs
[  T210] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection comman=
d is
advertised, but not supported.
[  T150] pci_bus 0000:03: Allocating resources
[  T842] EXT4-fs (nvme1n1p1): mounted filesystem 85e13cd1-3c57-4343-a1f5-
6209e530b640 r/w with ordered data mode. Quota mode: disabled.
[  T841] EXT4-fs (nvme0n1p4): mounted filesystem d21e6ad6-bc46-4b61-bc20-
e4d2f4bf719a r/w with ordered data mode. Quota mode: disabled.
[  T165] audit: type=3D1400 audit(1741857118.668:2): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"ch-checkns" pid=
=3D873
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857118.668:3): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"ch-run" pid=3D87=
4
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857118.668:4): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"buildah" pid=3D8=
70
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857118.668:5): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"1password" pid=
=3D863
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857118.668:6): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"crun" pid=3D878
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857118.668:7): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"vscode" pid=3D87=
7
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857118.668:8): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"cam" pid=3D872
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857118.668:9): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined"
name=3D4D6F6E676F444220436F6D70617373 pid=3D865 comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857118.668:10): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"Discord" pid=3D8=
64
comm=3D"apparmor_parser"
[  T165] audit: type=3D1400 audit(1741857118.668:11): apparmor=3D"STATUS"
operation=3D"profile_load" profile=3D"unconfined" name=3D"QtWebEngineProce=
ss" pid=3D866
comm=3D"apparmor_parser"
[   T81] input: PS/2 Generic Mouse as
/devices/platform/i8042/serio1/input/input4
[   T81] psmouse serio1: Failed to enable mouse on isa0060/serio1
[ T1090] nvme nvme0: using unchecked data buffer
[ T1160] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ T1160] Bluetooth: BNEP filters: protocol multicast
[ T1160] Bluetooth: BNEP socket layer initialized
[ T1076] Bluetooth: MGMT ver 1.23
[ T1162] Bluetooth: RFCOMM TTY layer initialized
[ T1162] Bluetooth: RFCOMM socket layer initialized
[ T1162] Bluetooth: RFCOMM ver 1.11
[  T698] mt7921e 0000:04:00.0 wlp4s0: renamed from wlan0
[ T1126] Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY driver
(mii_bus:phy_addr=3Dr8169-0-500:00, irq=3DMAC)
[ T1094] block nvme0n1: No UUID available providing old NGUID
[  T443] r8169 0000:05:00.0 enp5s0: Link is Down
[    C1] clocksource: timekeeping watchdog on CPU1: Marking clocksource 't=
sc' as
unstable because the skew is too large:
[    C1] clocksource:                       'hpet' wd_nsec: 495031631 wd_n=
ow:
7b3da9f wd_last: 747b34f mask: ffffffff
[    C1] clocksource:                       'tsc' cs_nsec: 496730299 cs_no=
w:
3201b46560 cs_last: 31a3238e80 mask: ffffffffffffffff
[    C1] clocksource:                       Clocksource 'tsc' skewed 16986=
68 ns
(1 ms) over watchdog 'hpet' interval of 495031631 ns (495 ms)
[    C1] clocksource:                       'hpet' (not 'tsc') is current
clocksource.
[    C1] tsc: Marking TSC unstable due to clocksource watchdog
[  T174] TSC found unstable after boot, most likely due to broken BIOS. Us=
e
'tsc=3Dunstable'.
[  T174] sched_clock: Marking unstable (9039095117, 1219781)<-(9059243699,=
 -
17200346)
[ T1761] ------------[ cut here ]------------
[ T1761] WARNING: CPU: 9 PID: 1761 at mm/util.c:674
__kvmalloc_node_noprof+0xa2/0xb0
[ T1761] Modules linked in: snd_seq_midi snd_seq_midi_event snd_rawmidi sn=
d_seq
snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_ctl_led
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component
snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbc=
m
snd_hda_codec btmtk snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn snd_hwdep
bluetooth snd_soc_core uvcvideo snd_hda_core videobuf2_vmalloc videobuf2_m=
emops
uvc videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm videobuf2_co=
mmon
snd_rn_pci_acp3x snd_timer snd_acp_config msi_wmi snd_soc_acpi ecdh_generi=
c ecc
sparse_keymap snd mc wmi_bmof edac_mce_amd soundcore k10temp snd_pci_acp3x=
 ccp
battery ac button joydev hid_sensor_prox hid_sensor_als hid_sensor_accel_3=
d
hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_trigger
industrialio_triggered_buffer kfifo_buf industrialio amd_pmc
hid_sensor_iio_common evdev mt7921e mt7921_common mt792x_lib mt76_connac_l=
ib
mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
[ T1761]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp
i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched
drm_suballoc_helper drm_panel_backlight_quirks cec hid_sensor_hub hid_mult=
itouch
drm_buddy xhci_pci mfd_core hid_generic xhci_hcd drm_display_helper i2c_hi=
d_acpi
usbcore amd_sfh i2c_hid psmouse drm_kms_helper nvme hid r8169 serio_raw cr=
c16
nvme_core i2c_piix4 usb_common i2c_smbus i2c_designware_platform
i2c_designware_core
[ T1761] CPU: 9 UID: 1000 PID: 1761 Comm: gst-plugin-scan Not tainted 6.14=
.0-
rc6-nop2pdma #566
[ T1761] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/=
MS-
158L, BIOS E158LAMS.107 11/10/2021
[ T1761] RIP: 0010:__kvmalloc_node_noprof+0xa2/0xb0
[ T1761] Code: 00 49 b9 63 01 00 00 00 00 00 80 68 00 04 00 00 4c 23 0d f9=
 1b ea
00 48 01 d1 e8 c9 af 03 00 48 83 c4 18 eb 9a 80 e7 20 75 95 <0f> 0b eb 91 =
66 2e
0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
[ T1761] RSP: 0018:ffffc9000701bcc0 EFLAGS: 00010246
[ T1761] RAX: 0000000000000000 RBX: 00000000000000c0 RCX: 0000000000000000
[ T1761] RDX: 0000000000000000 RSI: 0000000000000017 RDI: 0000000000052cc0
[ T1761] RBP: 000000055f5f8600 R08: ffffc9000701be00 R09: ffffc9000701be10
[ T1761] R10: 0000000000000018 R11: 0000000000000000 R12: 00000000ffffffff
[ T1761] R13: ffff88810fd00010 R14: 000000055f5f8600 R15: ffffc9000701bd28
[ T1761] FS:  00007fbb01ee4680(0000) GS:ffff888fae640000(0000)
knlGS:0000000000000000
[ T1761] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ T1761] CR2: 00007fbaf07f450b CR3: 000000010b3ae000 CR4: 0000000000750ef0
[ T1761] PKRU: 55555554
[ T1761] Call Trace:
[ T1761]  <TASK>
[ T1761]  ? __warn.cold+0x90/0x9e
[ T1761]  ? __kvmalloc_node_noprof+0xa2/0xb0
[ T1761]  ? report_bug+0xfa/0x140
[ T1761]  ? handle_bug+0x53/0x90
[ T1761]  ? exc_invalid_op+0x17/0x70
[ T1761]  ? asm_exc_invalid_op+0x1a/0x20
[ T1761]  ? __kvmalloc_node_noprof+0xa2/0xb0
[ T1761]  ? amdgpu_bo_create_list_entry_array+0x38/0x150 [amdgpu]
[ T1761]  ? rt_spin_unlock+0x12/0x40
[ T1761]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1761]  ? amdgpu_bo_list_ioctl+0x47/0x340 [amdgpu]
[ T1761]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
[ T1761]  ? drm_ioctl_kernel+0xa3/0xf0
[ T1761]  ? drm_ioctl+0x25e/0x4c0
[ T1761]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
[ T1761]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1761]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1761]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1761]  ? amdgpu_drm_ioctl+0x46/0x80 [amdgpu]
[ T1761]  ? __x64_sys_ioctl+0x92/0xc0
[ T1761]  ? do_syscall_64+0x5f/0x1a0
[ T1761]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1761]  </TASK>
[ T1761] ---[ end trace 0000000000000000 ]---
[ T1127] wlp4s0: authenticate with 54:67:51:3d:a2:e0 (local
address=3Dc8:94:02:c1:bd:69)
[ T1127] wlp4s0: send auth to 54:67:51:3d:a2:e0 (try 1/3)
[  T150] wlp4s0: authenticated
[  T150] wlp4s0: associate with 54:67:51:3d:a2:e0 (try 1/3)
[  T150] wlp4s0: RX AssocResp from 54:67:51:3d:a2:e0 (capab=3D0x1411 statu=
s=3D0
aid=3D1)
[  T150] wlp4s0: associated
[  T150] wlp4s0: Limiting TX power to 20 (20 - 0) dBm as advertised by
54:67:51:3d:a2:e0
[  T152] pci_bus 0000:03: Allocating resources
[ T1373] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T1373] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T1373] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T1373] [drm] kiq ring mec 2 pipe 1 q 0
[ T1373] [drm] DMUB hardware initialized: version=3D0x02020020
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T2903] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T2903] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T2903] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T2903] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T2903] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T2903] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T2903] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T2903] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T2903] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T2903] [drm] kiq ring mec 2 pipe 1 q 0
[ T2903] [drm] DMUB hardware initialized: version=3D0x02020020
[ T2903] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T2903] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T2903] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T1373] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T1373] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T1373] [drm] kiq ring mec 2 pipe 1 q 0
[ T1373] [drm] DMUB hardware initialized: version=3D0x02020020
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1127] wlp4s0: disconnect from AP 54:67:51:3d:a2:e0 for new auth to
54:67:51:3d:a2:d2
[ T1127] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (local
address=3Dc8:94:02:c1:bd:69)
[ T1127] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
[  T151] wlp4s0: authenticated
[  T151] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/3)
[  T151] wlp4s0: RX ReassocResp from 54:67:51:3d:a2:d2 (capab=3D0x511 stat=
us=3D0
aid=3D1)
[  T151] wlp4s0: associated
[  T151] wlp4s0: deauthenticated from 54:67:51:3d:a2:d2 (Reason:
15=3D4WAY_HANDSHAKE_TIMEOUT)
[ T1127] wlp4s0: authenticate with 54:67:51:3d:a2:e0 (local
address=3Dc8:94:02:c1:bd:69)
[ T1127] wlp4s0: send auth to 54:67:51:3d:a2:e0 (try 1/3)
[  T151] wlp4s0: authenticated
[  T151] wlp4s0: associate with 54:67:51:3d:a2:e0 (try 1/3)
[  T151] wlp4s0: RX AssocResp from 54:67:51:3d:a2:e0 (capab=3D0x1411 statu=
s=3D17
aid=3D2)
[  T151] wlp4s0: 54:67:51:3d:a2:e0 denied association (code=3D17)
[ T1127] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (local
address=3Dc8:94:02:c1:bd:69)
[ T1127] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
[  T151] wlp4s0: authenticated
[  T151] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/3)
[  T151] wlp4s0: RX AssocResp from 54:67:51:3d:a2:d2 (capab=3D0x511 status=
=3D0
aid=3D1)
[  T151] wlp4s0: associated
[ T1373] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T1373] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T1373] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T1373] [drm] kiq ring mec 2 pipe 1 q 0
[ T1373] [drm] DMUB hardware initialized: version=3D0x02020020
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T1373] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T1373] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T1373] [drm] kiq ring mec 2 pipe 1 q 0
[ T1373] [drm] DMUB hardware initialized: version=3D0x02020020
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T1373] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T1373] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T1373] [drm] kiq ring mec 2 pipe 1 q 0
[ T1373] [drm] DMUB hardware initialized: version=3D0x02020020
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[  T636] ACPI Error: No handler for Region [VRTC] (000000007cb89767)
[SystemCMOS] (20240827/evregion-131)
[  T636] ACPI Error: Region SystemCMOS (ID=3D5) has no handler (20240827/e=
xfldio-
261)
[  T636] ACPI Error: Aborting method \_SB.PCI0.SBRG.EC._Q9A due to previou=
s
error (AE_NOT_EXIST) (20240827/psparse-529)
[ T1373] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T1373] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T1373] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T1373] [drm] kiq ring mec 2 pipe 1 q 0
[ T1373] [drm] DMUB hardware initialized: version=3D0x02020020
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[  T165] kauditd_printk_skb: 117 callbacks suppressed
[  T165] audit: type=3D1400 audit(1741860329.933:129): apparmor=3D"DENIED"
operation=3D"open" class=3D"file" profile=3D"/usr/sbin/cupsd" name=3D"/etc=
/paperspecs"
pid=3D7466 comm=3D"cupsd" requested_mask=3D"r" denied_mask=3D"r" fsuid=3D0=
 ouid=3D0
[  T165] audit: type=3D1400 audit(1741860329.936:130): apparmor=3D"DENIED"
operation=3D"capable" class=3D"cap" profile=3D"/usr/sbin/cupsd" pid=3D7466=
 comm=3D"cupsd"
capability=3D12  capname=3D"net_admin"
[ T7610] SCSI subsystem initialized
[ T7616] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T7616] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T7616] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T7616] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T7616] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T7616] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T7616] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T7616] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T7616] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T7616] [drm] kiq ring mec 2 pipe 1 q 0
[ T7616] [drm] DMUB hardware initialized: version=3D0x02020020
[ T7616] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T7616] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T7616] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T5890] pci_bus 0000:03: Allocating resources
[ T3865] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T3865] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T3865] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T3865] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T3865] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T3865] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T3865] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T3865] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T3865] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T3865] [drm] kiq ring mec 2 pipe 1 q 0
[ T3865] [drm] DMUB hardware initialized: version=3D0x02020020
[ T3865] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T3865] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T3865] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T3670] pci_bus 0000:03: Allocating resources
[ T3668] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T3668] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T3668] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T3668] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T3668] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T3668] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T3668] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T3668] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T3668] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T3668] [drm] kiq ring mec 2 pipe 1 q 0
[ T3668] [drm] DMUB hardware initialized: version=3D0x02020020
[ T3668] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T3668] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T3668] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T7385] pci_bus 0000:03: Allocating resources
[ T1050] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T1050] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T1050] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T1050] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T1050] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T1050] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T1050] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T1050] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T1050] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T1050] [drm] kiq ring mec 2 pipe 1 q 0
[ T1050] [drm] DMUB hardware initialized: version=3D0x02020020
[ T1050] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T1050] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T1050] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T1373] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T1373] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T1373] [drm] kiq ring mec 2 pipe 1 q 0
[ T1373] [drm] DMUB hardware initialized: version=3D0x02020020
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1750] warning: `Socket Thread' uses wireless extensions which will stop
working for Wi-Fi 7 hardware; use nl80211
[ T8199] pci_bus 0000:03: Allocating resources
[ T7808] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T7808] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T7808] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T7808] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T7808] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T7808] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T7808] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T7808] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T7808] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T7808] [drm] kiq ring mec 2 pipe 1 q 0
[ T7808] [drm] DMUB hardware initialized: version=3D0x02020020
[ T7808] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T7808] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T7808] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T8199] pci_bus 0000:03: Allocating resources
[  T577] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[  T577] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[  T577] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[  T577] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[  T577] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[  T577] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[  T577] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[  T577] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[  T577] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[  T577] [drm] kiq ring mec 2 pipe 1 q 0
[  T577] [drm] DMUB hardware initialized: version=3D0x02020020
[  T577] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[  T577] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[  T577] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[  T577] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[  T577] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[  T577] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[  T577] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[T72068] pci_bus 0000:03: Allocating resources
[T85206] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[T85206] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T5890] pci_bus 0000:03: Allocating resources
[T85206] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[T85206] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[T85206] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[T85206] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[T85206] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[T85206] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[T85206] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[T85206] [drm] kiq ring mec 2 pipe 1 q 0
[T85206] [drm] DMUB hardware initialized: version=3D0x02020020
[T85206] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[T85206] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[T85206] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[T85206] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[T85206] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[T85206] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[T85206] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[ T1373] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[ T1373] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ T1373] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[ T1373] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ T1373] [drm] kiq ring mec 2 pipe 1 q 0
[ T1373] [drm] DMUB hardware initialized: version=3D0x02020020
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[ T1373] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[ T1373] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[T85442] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
[T85442] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[T85442] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 f=
or PSP
TMR
[T85442] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not
available
[T85442] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucod=
e is
not available
[T85442] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[T85442] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000f=
, smu fw
if version =3D 0x00000013, smu fw program =3D 0, version =3D 0x003b3100 (5=
9.49.0)
[T85442] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[T85442] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[T85442] [drm] kiq ring mec 2 pipe 1 q 0
[T85442] [drm] DMUB hardware initialized: version=3D0x02020020
[T85442] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[T85442] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on =
hub 0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on =
hub 0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on=
 hub 0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on=
 hub 0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on=
 hub 0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on=
 hub 0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on=
 hub 0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on=
 hub 0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 o=
n hub
0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 o=
n hub
0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 =
on hub
0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub=
 0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub=
 0
[T85442] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on =
hub 8
[T85442] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 o=
n hub
8
[T85442] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 o=
n hub
8
[T85442] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on h=
ub 8
[T85442] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes

$ lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Roo=
t
Complex
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root
Complex
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 0

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 255
	Capabilities: [40] Secure device <?>
	Capabilities: [64] MSI: Enable- Count=3D1/4 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [74] HyperTransport: MSI Mapping Enable+ Fixed+

00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy =
Host
Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 1

00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bri=
dge
(prog-if 00 [Normal decode])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 43
	IOMMU group: 2
	Bus: primary=3D00, secondary=3D01, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 1000-1fff [size=3D4K] [16-bit]
	Memory behind bridge: fca00000-fccfffff [size=3D3M] [32-bit]
	Prefetchable memory behind bridge: fc00000000-fe0fffffff [size=3D8448M]
[32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x8, ASPM L1, Exit
Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
		LnkSta:	Speed 8GT/s, Width x8
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt+
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surprise+
			Slot #0, PowerLimit 75W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power-
Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp-
ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Micro-Star International Co., Ltd. [MSI]
Device 1313
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [370 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
			  PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D150us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=3D0us LTR1.2_Threshold=3D32768ns
		L1SubCtl2: T_PwrOn=3D10us
	Kernel driver in use: pcieport

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy =
Host
Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 3

00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP
Bridge (prog-if 00 [Normal decode])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 44
	IOMMU group: 4
	Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
	Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
	Prefetchable memory behind bridge: fe30300000-fe304fffff [size=3D2M] [32-
bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #3, Speed 8GT/s, Width x1, ASPM L1, Exit
Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
		LnkSta:	Speed 5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
			Slot #0, PowerLimit 75W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power-
Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp-
ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Micro-Star International Co., Ltd. [MSI]
Device 1313
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [370 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
			  PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D150us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=3D10us LTR1.2_Threshold=3D166912ns
		L1SubCtl2: T_PwrOn=3D150us
	Kernel driver in use: pcieport

00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP
Bridge (prog-if 00 [Normal decode])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 45
	IOMMU group: 5
	Bus: primary=3D00, secondary=3D05, subordinate=3D05, sec-latency=3D0
	I/O behind bridge: f000-ffff [size=3D4K] [16-bit]
	Memory behind bridge: fcf00000-fcffffff [size=3D1M] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
[disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #4, Speed 8GT/s, Width x1, ASPM L1, Exit
Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
			Slot #0, PowerLimit 75W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power-
Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp-
ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Micro-Star International Co., Ltd. [MSI]
Device 1313
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [370 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
			  PortCommonModeRestoreTime=3D150us
PortTPowerOnTime=3D150us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=3D150us LTR1.2_Threshold=3D306176ns
		L1SubCtl2: T_PwrOn=3D150us
	Kernel driver in use: pcieport

00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP
Bridge (prog-if 00 [Normal decode])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 46
	IOMMU group: 6
	Bus: primary=3D00, secondary=3D06, subordinate=3D06, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
	Memory behind bridge: fce00000-fcefffff [size=3D1M] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
[disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 512 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit
Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
		LnkSta:	Speed 8GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
			Slot #0, PowerLimit 75W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power-
Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp-
ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd+
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Micro-Star International Co., Ltd. [MSI]
Device 1313
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [370 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
			  PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D150us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=3D10us LTR1.2_Threshold=3D236544ns
		L1SubCtl2: T_PwrOn=3D220us
	Kernel driver in use: pcieport

00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP
Bridge (prog-if 00 [Normal decode])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 47
	IOMMU group: 7
	Bus: primary=3D00, secondary=3D07, subordinate=3D07, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
	Memory behind bridge: fcd00000-fcdfffff [size=3D1M] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
[disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x4, ASPM L1, Exit
Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
		LnkSta:	Speed 8GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
			Slot #0, PowerLimit 75W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power-
Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp-
ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Micro-Star International Co., Ltd. [MSI]
Device 1313
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [370 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
			  PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D150us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=3D10us LTR1.2_Threshold=3D166912ns
		L1SubCtl2: T_PwrOn=3D150us
	Kernel driver in use: pcieport

00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy =
Host
Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 8

00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCI=
e GPP
Bridge to Bus (prog-if 00 [Normal decode])
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP
Bridge to Bus
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 48
	IOMMU group: 9
	Bus: primary=3D00, secondary=3D08, subordinate=3D08, sec-latency=3D0
	I/O behind bridge: e000-efff [size=3D4K] [16-bit]
	Memory behind bridge: fc500000-fc9fffff [size=3D5M] [32-bit]
	Prefetchable memory behind bridge: fe20000000-fe301fffff [size=3D258M]
[32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot-), IntMsgNum 0
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
		LnkSta:	Speed 8GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 4
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp-
ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir
Internal PCIe GPP Bridge to Bus
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [400 v1] Data Link Feature <?>
	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [440 v1] Lane Margining at the Receiver
		PortCap: Uses Driver-
		PortSta: MargReady- MargSoftReady-
	Kernel driver in use: pcieport

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (re=
v 51)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 10
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev=
 51)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	IOMMU group: 10

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 11

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 1
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 11

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 11

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 3
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 11
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 4
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 11

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 11

00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 6
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 11

00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 7
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 11

01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upst=
ream
Port of PCI Express Switch (rev c3) (prog-if 00 [Normal decode])
	Physical Slot: 0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 49
	IOMMU group: 12
	Region 0: Memory at fcc00000 (32-bit, non-prefetchable) [size=3D16K]
	Bus: primary=3D01, secondary=3D02, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
	Memory behind bridge: fca00000-fcbfffff [size=3D2M] [32-bit]
	Prefetchable memory behind bridge: fc00000000-fe0fffffff [size=3D8448M]
[32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Upstream Port, IntMsgNum 0
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit
75W TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+
AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 16GT/s, Width x8, ASPM L1, Exit
Latency L1 <64us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (downgraded), Width x8
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 4
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [150 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [320 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [400 v1] Data Link Feature <?>
	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [440 v1] Lane Margining at the Receiver
		PortCap: Uses Driver-
		PortSta: MargReady- MargSoftReady-
	Kernel driver in use: pcieport

02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Down=
stream
Port of PCI Express Switch (prog-if 00 [Normal decode])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downstream
Port of PCI Express Switch
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 50
	IOMMU group: 13
	Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
	Memory behind bridge: fca00000-fcbfffff [size=3D2M] [32-bit]
	Prefetchable memory behind bridge: fc00000000-fe0fffffff [size=3D8448M]
[32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Express (v2) Downstream Port (Slot-), IntMsgNum 0
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+ TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 16GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
		LnkSta:	Speed 16GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 4
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: EgressBlck-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD/ATI]
Navi 10 XL Downstream Port of PCI Express Switch
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [150 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [400 v1] Data Link Feature <?>
	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [440 v1] Lane Margining at the Receiver
		PortCap: Uses Driver-
		PortSta: MargReady+ MargSoftReady-
	Kernel driver in use: pcieport

03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
[Radeon RX 6600/6600 XT/6600M] (rev c3)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 107
	IOMMU group: 14
	Region 0: Memory at fc00000000 (64-bit, prefetchable) [size=3D8G]
	Region 2: Memory at fe00000000 (64-bit, prefetchable) [size=3D256M]
	Region 5: Memory at fca00000 (32-bit, non-prefetchable) [size=3D1M]
	Expansion ROM at fcb00000 [disabled] [size=3D128K]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-
,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [64] Express (v2) Legacy Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 16GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 16GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Form Factor Dev Specific,
EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn+
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [150 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [200 v1] Physical Resizable BAR
		BAR 0: current size: 8GB, supported: 256MB 512MB 1GB 2GB 4GB
8GB
		BAR 2: current size: 256MB, supported: 2MB 4MB 8MB 16MB 32MB
64MB 128MB 256MB
	Capabilities: [240 v1] Power Budgeting <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [2d0 v1] Process Address Space ID (PASID)
		PASIDCap: Exec+ Priv+, Max PASID Width: 10
		PASIDCtl: Enable+ Exec- Priv-
	Capabilities: [320 v1] Latency Tolerance Reporting
		Max snoop latency: 1048576ns
		Max no snoop latency: 1048576ns
	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [440 v1] Lane Margining at the Receiver
		PortCap: Uses Driver-
		PortSta: MargReady+ MargSoftReady-
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu

03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21/23 HD=
MI/DP
Audio Controller
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21/23 HDMI/DP
Audio Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 129
	IOMMU group: 15
	Region 0: Memory at fcb20000 (32-bit, non-prefetchable) [size=3D16K]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-
,D1+,D2+,D3hot+,D3cold+)
		Status: D3 NoSoftRst+ PME-Enable+ DSel=3D0 DScale=3D0 PME-
	Capabilities: [64] Express (v2) Legacy Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 16GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 16GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Form Factor Dev Specific,
EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [150 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
	Subsystem: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 110
	IOMMU group: 16
	Region 0: Memory at fe30300000 (64-bit, prefetchable) [size=3D1M]
	Region 2: Memory at fe30400000 (64-bit, prefetchable) [size=3D16K]
	Region 4: Memory at fe30404000 (64-bit, prefetchable) [size=3D4K]
	Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 75W TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <2us, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix-
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer-
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [e0] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
		Address: 00000000fee00000  Data: 0000
		Masking: fffffffe  Pending: 00000000
	Capabilities: [f8] Power Management version 3
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=3D1556 Rev=3D1
Len=3D008 <?>
	Capabilities: [108 v1] Latency Tolerance Reporting
		Max snoop latency: 1048576ns
		Max no snoop latency: 1048576ns
	Capabilities: [110 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
			  PortCommonModeRestoreTime=3D3us PortTPowerOnTime=3D28us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=3D0us LTR1.2_Threshold=3D166912ns
		L1SubCtl2: T_PwrOn=3D150us
	Capabilities: [200 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Kernel driver in use: mt7921e
	Kernel modules: mt7921e

05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 51
	IOMMU group: 17
	Region 0: I/O ports at f000 [size=3D256]
	Region 2: Memory at fcf04000 (64-bit, non-prefetchable) [size=3D4K]
	Region 4: Memory at fcf00000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, IntMsgNum 1
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 75W TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+
AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#,
ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer-
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [b0] MSI-X: Enable+ Count=3D4 Masked-
		Vector table: BAR=3D4 offset=3D00000000
		PBA: BAR=3D4 offset=3D00000800
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
	Capabilities: [170 v1] Latency Tolerance Reporting
		Max snoop latency: 1048576ns
		Max no snoop latency: 1048576ns
	Capabilities: [178 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
			  PortCommonModeRestoreTime=3D150us
PortTPowerOnTime=3D150us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=3D0us LTR1.2_Threshold=3D306176ns
		L1SubCtl2: T_PwrOn=3D150us
	Kernel driver in use: r8169
	Kernel modules: r8169

06:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc.
KC3000/FURY Renegade NVMe SSD [E18] (rev 01) (prog-if 02 [NVM Express])
	Subsystem: Kingston Technology Company, Inc. KC3000/FURY Renegade NVMe
SSD [E18]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 52
	IOMMU group: 18
	Region 0: Memory at fce00000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 75W TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 512 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit
Latency L1 <64us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (downgraded), Width x4
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix-
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: Upstream Port
	Capabilities: [d0] MSI-X: Enable+ Count=3D33 Masked-
		Vector table: BAR=3D0 offset=3D00002000
		PBA: BAR=3D0 offset=3D00003000
	Capabilities: [e0] MSI: Enable- Count=3D1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [f8] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [100 v1] Latency Tolerance Reporting
		Max snoop latency: 1048576ns
		Max no snoop latency: 1048576ns
	Capabilities: [110 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
			  PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D220us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=3D0us LTR1.2_Threshold=3D236544ns
		L1SubCtl2: T_PwrOn=3D220us
	Capabilities: [128 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [1e0 v1] Data Link Feature <?>
	Capabilities: [200 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 04000001 0000200f 06010000 dd80aa39
	Capabilities: [290 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [2a0 v1] Power Budgeting <?>
	Capabilities: [300 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [340 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [378 v1] Lane Margining at the Receiver
		PortCap: Uses Driver-
		PortSta: MargReady- MargSoftReady-
	Kernel driver in use: nvme
	Kernel modules: nvme

07:00.0 Non-Volatile memory controller: Micron/Crucial Technology P1 NVMe =
PCIe
SSD[Frampton] (rev 03) (prog-if 02 [NVM Express])
	Subsystem: Micron/Crucial Technology P1 NVMe PCIe SSD[Frampton]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 53
	IOMMU group: 19
	Region 0: Memory at fcd00000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] MSI: Enable- Count=3D1/8 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 75W TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+
AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit
Latency L1 <8us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [b0] MSI-X: Enable+ Count=3D16 Masked-
		Vector table: BAR=3D0 offset=3D00002000
		PBA: BAR=3D0 offset=3D00002100
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [158 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [178 v1] Latency Tolerance Reporting
		Max snoop latency: 1048576ns
		Max no snoop latency: 1048576ns
	Capabilities: [180 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
			  PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D10us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=3D0us LTR1.2_Threshold=3D166912ns
		L1SubCtl2: T_PwrOn=3D150us
	Kernel driver in use: nvme
	Kernel modules: nvme

08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5) (prog-if=
 00
[VGA controller])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort+ <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 98
	IOMMU group: 20
	Region 0: Memory at fe20000000 (64-bit, prefetchable) [size=3D256M]
	Region 2: Memory at fe30000000 (64-bit, prefetchable) [size=3D2M]
	Region 4: I/O ports at e000 [size=3D256]
	Region 5: Memory at fc900000 (32-bit, non-prefetchable) [size=3D512K]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-
,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [64] Express (v2) Legacy Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+
2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=3D1/4 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=3D4 Masked-
		Vector table: BAR=3D5 offset=3D00042000
		PBA: BAR=3D5 offset=3D00043000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [2b0 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable+, Smallest Translation Unit: 00
	Capabilities: [2c0 v1] Page Request Interface (PRI)
		PRICtl: Enable+ Reset-
		PRISta: RF- UPRGI- Stopped+ PASID-
		Page Request Capacity: 00000100, Page Request Allocation:
00000020
	Capabilities: [2d0 v1] Process Address Space ID (PASID)
		PASIDCap: Exec+ Priv+, Max PASID Width: 10
		PASIDCtl: Enable+ Exec- Priv-
	Capabilities: [400 v1] Data Link Feature <?>
	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [440 v1] Lane Margining at the Receiver
		PortCap: Uses Driver-
		PortSta: MargReady- MargSoftReady-
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu

08:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon=
 High
Definition Audio Controller
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon High
Definition Audio Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 128
	IOMMU group: 21
	Region 0: Memory at fc9c8000 (32-bit, non-prefetchable) [size=3D16K]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-
,D1+,D2+,D3hot+,D3cold+)
		Status: D3 NoSoftRst- PME-Enable+ DSel=3D0 DScale=3D0 PME-
	Capabilities: [64] Express (v2) Legacy Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

08:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 1=
7h
(Models 10h-1fh) Platform Security Processor
	Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-
1fh) Platform Security Processor
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 109
	IOMMU group: 22
	Region 2: Memory at fc800000 (32-bit, non-prefetchable) [size=3D1M]
	Region 5: Memory at fc9ce000 (32-bit, non-prefetchable) [size=3D8K]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=3D1/2 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=3D2 Masked-
		Vector table: BAR=3D5 offset=3D00000000
		PBA: BAR=3D5 offset=3D00001000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: ccp
	Kernel modules: ccp

08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne =
USB
3.1 (prog-if 30 [XHCI])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 88
	IOMMU group: 23
	Region 0: Memory at fc700000 (64-bit, non-prefetchable) [size=3D1M]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=3D1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=3D8 Masked-
		Vector table: BAR=3D0 offset=3D000fe000
		PBA: BAR=3D0 offset=3D000ff000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

08:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne =
USB
3.1 (prog-if 30 [XHCI])
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 98
	IOMMU group: 24
	Region 0: Memory at fc600000 (64-bit, non-prefetchable) [size=3D1M]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=3D1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=3D8 Masked-
		Vector table: BAR=3D0 offset=3D000fe000
		PBA: BAR=3D0 offset=3D000ff000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

08:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 126
	IOMMU group: 25
	Region 0: Memory at fc980000 (32-bit, non-prefetchable) [size=3D256K]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-
,D3hot+,D3cold+)
		Status: D3 NoSoftRst+ PME-Enable+ DSel=3D0 DScale=3D0 PME-
	Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: snd_rn_pci_acp3x
	Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x

08:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h/1a=
h HD
Audio Controller
	DeviceName: HD Audio Controller
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 130
	IOMMU group: 26
	Region 0: Memory at fc9c0000 (32-bit, non-prefetchable) [size=3D32K]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-
,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

08:00.7 Signal processing controller: Advanced Micro Devices, Inc. [AMD] S=
ensor
Fusion Hub
	Subsystem: Advanced Micro Devices, Inc. [AMD] Sensor Fusion Hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort+ <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 88
	IOMMU group: 27
	Region 2: Memory at fc500000 (32-bit, non-prefetchable) [size=3D1M]
	Region 5: Memory at fc9cc000 (32-bit, non-prefetchable) [size=3D8K]
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1,
Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable-
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=3D1/2 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable- Count=3D2 Masked-
		Vector table: BAR=3D5 offset=3D00000000
		PBA: BAR=3D5 offset=3D00001000
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
Len=3D010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcie_mp2_amd
	Kernel modules: amd_sfh

$ cat /proc/iomem
00000000-00000fff : Reserved
00001000-0009ffff : System RAM
000a0000-000fffff : Reserved
  000a0000-000dffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-09bfefff : System RAM
  01200000-01dcff56 : Kernel code
  01e00000-02231fff : Kernel rodata
  02400000-0252a4ff : Kernel data
  02744000-027fffff : Kernel bss
09bff000-0a000fff : Reserved
0a001000-0a1fffff : System RAM
0a200000-0a20efff : ACPI Non-volatile Storage
0a20f000-e5e58017 : System RAM
e5e58018-e5e65857 : System RAM
e5e65858-e62edfff : System RAM
e62ee000-e63e1fff : Reserved
e63e2000-e87cafff : System RAM
e87cb000-e87cbfff : Reserved
e87cc000-e9e1ffff : System RAM
e9e20000-eb33efff : Reserved
  eb31e000-eb321fff : MSFT0101:00
  eb322000-eb325fff : MSFT0101:00
eb33f000-eb39efff : ACPI Tables
eb39f000-eb556fff : ACPI Non-volatile Storage
eb557000-ed1fefff : Reserved
ed1ff000-edffffff : System RAM
ee000000-efffffff : Reserved
f0000000-fcffffff : PCI Bus 0000:00
  f0000000-f7ffffff : PCI ECAM 0000 [bus 00-7f]
    f0000000-f7ffffff : pnp 00:00
  fc500000-fc9fffff : PCI Bus 0000:08
    fc500000-fc5fffff : 0000:08:00.7
      fc500000-fc5fffff : pcie_mp2_amd
    fc600000-fc6fffff : 0000:08:00.4
      fc600000-fc6fffff : xhci-hcd
    fc700000-fc7fffff : 0000:08:00.3
      fc700000-fc7fffff : xhci-hcd
    fc800000-fc8fffff : 0000:08:00.2
      fc800000-fc8fffff : ccp
    fc900000-fc97ffff : 0000:08:00.0
    fc980000-fc9bffff : 0000:08:00.5
      fc980000-fc9bffff : AMD ACP3x audio
        fc980000-fc990200 : acp_pdm_iomem
    fc9c0000-fc9c7fff : 0000:08:00.6
      fc9c0000-fc9c7fff : ICH HD audio
    fc9c8000-fc9cbfff : 0000:08:00.1
      fc9c8000-fc9cbfff : ICH HD audio
    fc9cc000-fc9cdfff : 0000:08:00.7
    fc9ce000-fc9cffff : 0000:08:00.2
      fc9ce000-fc9cffff : ccp
  fca00000-fccfffff : PCI Bus 0000:01
    fca00000-fcbfffff : PCI Bus 0000:02
      fca00000-fcbfffff : PCI Bus 0000:03
        fca00000-fcafffff : 0000:03:00.0
        fcb00000-fcb1ffff : 0000:03:00.0
        fcb20000-fcb23fff : 0000:03:00.1
          fcb20000-fcb23fff : ICH HD audio
    fcc00000-fcc03fff : 0000:01:00.0
  fcd00000-fcdfffff : PCI Bus 0000:07
    fcd00000-fcd03fff : 0000:07:00.0
      fcd00000-fcd03fff : nvme
  fce00000-fcefffff : PCI Bus 0000:06
    fce00000-fce03fff : 0000:06:00.0
      fce00000-fce03fff : nvme
  fcf00000-fcffffff : PCI Bus 0000:05
    fcf00000-fcf03fff : 0000:05:00.0
    fcf04000-fcf04fff : 0000:05:00.0
      fcf04000-fcf04fff : r8169
fd300000-fd37ffff : amd_iommu
fec00000-fec003ff : IOAPIC 0
fec01000-fec013ff : IOAPIC 1
fec10000-fec10fff : Reserved
  fec10000-fec10fff : pnp 00:04
fed00000-fed00fff : Reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed40000-fed44fff : Reserved
fed80000-fed8ffff : Reserved
  fed81200-fed812ff : AMDI0030:00
  fed81500-fed818ff : AMDI0030:00
    fed81500-fed818ff : AMDI0030:00 AMDI0030:00
fedc0000-fedc0fff : pnp 00:04
fedc4000-fedc9fff : Reserved
  fedc5000-fedc5fff : AMDI0010:03
    fedc5000-fedc5fff : AMDI0010:03 AMDI0010:03
fedcc000-fedcefff : Reserved
fedd5000-fedd5fff : Reserved
fee00000-fee00fff : pnp 00:04
ff000000-ffffffff : pnp 00:04
100000000-fee2fffff : System RAM
fee300000-100fffffff : Reserved
1010000000-ffffffffff : PCI Bus 0000:00
  fc00000000-fe0fffffff : PCI Bus 0000:01
    fc00000000-fe0fffffff : PCI Bus 0000:02
      fc00000000-fe0fffffff : PCI Bus 0000:03
        fc00000000-fdffffffff : 0000:03:00.0
        fe00000000-fe0fffffff : 0000:03:00.0
  fe20000000-fe301fffff : PCI Bus 0000:08
    fe20000000-fe2fffffff : 0000:08:00.0
    fe30000000-fe301fffff : 0000:08:00.0
  fe30300000-fe304fffff : PCI Bus 0000:04
    fe30300000-fe303fffff : 0000:04:00.0
      fe30300000-fe303fffff : 0000:04:00.0
    fe30400000-fe30403fff : 0000:04:00.0
    fe30404000-fe30404fff : 0000:04:00.0
3ffe00000000-3fffffffffff : 0000:03:00.0


Bert Karwatzki


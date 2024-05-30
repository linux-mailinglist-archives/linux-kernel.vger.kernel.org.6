Return-Path: <linux-kernel+bounces-194992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E88D45AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79BA1F2226C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3313DABF3;
	Thu, 30 May 2024 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusipp.de header.i=osmanx@heusipp.de header.b="pts2MKZz"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7A3207;
	Thu, 30 May 2024 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052309; cv=none; b=JbxVhRa3NE8R05skAAuIX8yvo2CQGNzy3cQUFjmvm1opxlxdcmt2YzwbgeRRCB5GcZL9x/XkEsUAYkUOTaj5cY9y81+DQvljsCFvxfRkUEQ6tPAfTypuunFdglLk+4QdIlQJK6sfMPXZ0uKMOEqred7BdkkyRZ1fL/v1Wpi/IB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052309; c=relaxed/simple;
	bh=Q24j6yIH7s08CTSE4qObX2dFfjNPZkJG7EUnZrGtF0U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hU+iq/QN3Yj/ugpStFGlVDPVwpYQoLmEo/tLJrB5g2Rnl24Z9/PNfDCstiNHWIwKAUeduVXQ8QbURZQZM9c8LJa5gBky85KhiMJLEeVZxbw7kcNsxNxrAVEmaYoz9PIKPNRCBr9nyGYfF3oooQzA2bLr5o90wvxT82RxXbk/rUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusipp.de; spf=pass smtp.mailfrom=heusipp.de; dkim=pass (2048-bit key) header.d=heusipp.de header.i=osmanx@heusipp.de header.b=pts2MKZz; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusipp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusipp.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusipp.de;
	s=s1-ionos; t=1717052242; x=1717657042; i=osmanx@heusipp.de;
	bh=Fo4BgflZWecJohsoS79xT7lDDfQyodBVtxTcq1PAzfA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pts2MKZz7kgcjx/+PpTkwVyEyaENacX88nmTaPrTl0svtDcftQIy3U46LZLGcW1i
	 4KGv2H79iKqVxO9sfEOfsoAd6ZXOv7OdJT9y59slx05lfPWoONy1M+JCUd3gzV2F3
	 EO1L+G4fdq/hFZjCPNreZbx32jnADVGsboGua96exMPfkWJatRToVOLTQQR/vdiec
	 ri3iK9RdNSvRJ/qb0u6YGDhOL2rROOx7LKGXne4xTbJQAkiC7blU8lUr9cdaYHK6Y
	 aUfxz2BxP/Wl/EfEFdrkyfHklhP7iKD7n6j33QZr5amhDd6weAj2Hj352h8Hunn1a
	 2isTqJjQRJuya5E5MQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.90] ([91.62.108.110]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8VkX-1sZ2MV0MRF-014XdX; Thu, 30 May 2024 08:57:22 +0200
Message-ID: <ebb0791c-60a5-4fe3-bc85-4921ad026605@heusipp.de>
Date: Thu, 30 May 2024 08:55:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Adam Dunlap <acdunlap@google.com>, 1071378@bugs.debian.org
From: =?UTF-8?Q?J=C3=B6rn_Heusipp?= <osmanx@heusipp.de>
Subject: [REGRESSION] commit fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6 (Linux
 6.7+) crashes during boot
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HffBv4SMVjsPC+qpltN+HG0UCXLrEFrT9hOmGHmZckVal2wYApV
 pk1CkSDYgc0pEZayWbhZtJHFANw3ey+7NozjuMzWScgZYOWVmSPXdFhnEE+p8SOTtB7HIkS
 Puqg4Vmap1LuSa/zKxkFFCy3egvI1N7a35fLLb+9WbG9MXEZRs+jsmw5kWfaYw9CZpAl9OR
 j2x8kVoNazCCoIV2J5bvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dfsbd70IDLU=;bJEONB2t5aj0mJ3rRr+FJ/BPcrI
 +xO+kz2X4aYkMFJFH1cI7jzpUVi3b47moV6reiWuta4e3UW8Cw0eyVDRjVUWmxCTT9N5fRTPD
 VYup0w7HcKrTS9biM4JtRNegD9ZlqW5h7CYTx286YzOAVBqGwLQCQlLf9iXbe3tgpNl5vNfVK
 A1l3eF8xiKy1S9A2EzvULZpEaZtW6sv+e3h8UfKzCYlUVt3ycdpmgRUJ95aY9ai6TXgfbMyFW
 AQT2wdvuGitXK/XjYWsz6ALAj4DwB/i7+31tzvsBHG8A+mweGPCLSQ/k0LPz7OMKzrARFDZBB
 j/GOSP04jOwjDGsfIeKMRVzQJqjGfqV9Ui5fQNlqTNXgdQGeA+ZnzB/y35Vt+xh50K1gessPU
 AaVYiufpWmXzOHzT6C/BjIPzeJDszYM/2VtwFZ5umvs+MUaGUcWQ/LtEtmWzzLcvnMuKW9EaZ
 cgHzf37oMq01MFEuKSpI2H0BF9tu87UMx0LHUwc9lpfDDeXzd2wj7dPwNtnNGmX6BvB5Tc0fA
 KB+U0eLaBuLn4Fm3rZLLGiNrcZIGBBYsj3P3k15sFg9XhDtp6jP/w8QwrG+EpQtEDnS1OwESD
 KvKa8q2se5LA2jdkN8OFv6HXMro7NjLmTi+F+IMmBDNrbKirdcq4CNPGnhGMdyugC/SzXsdlw
 D0YFKmvpxjoqAluO2fgV/HtSRMgm/Ffycw8cDuQis2Z/Bty+WyWHb8rvfOO50xu3bkhRmyr07
 0OU9Mfdx2cemZbgatzbk1BZCwvdnEfPGjOA98pfYDvglxW1AB8cR+g=


Hello x86 maintainers!


commit fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6 ("x86/sev-es: Set
x86_virt_bits to the correct value straight away, instead of a two-phase
approach") crashes during boot for me on this 32bit x86 system.

Updating a Debian testing system resulted in a hang during boot before
printing anything, with any 6.7 or later kernel. With 'earlyprintk=3Dvga',
I managed to capture the crash on video and stitched it together as an
image [1].
Trimmed transcription (might contain typos) of the crash from Debian
kernel 6.7.12-1:
=3D=3D=3D
BUG: kernel NULL pointer dereference, address: 00000010
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
Oops: 0002 [#1] PREEMPT SMP NOPTI
[...]
EIP: __ring_buffer_alloc+0x32/0x194
[...]
show_regs
__die
page_fault_oops
kernelmode_fixup_or_oops.constprop
__bad_area_nosemaphore.constprop
bad_area_nosemaphore
do_user_addr_fault
prb_read_valid
exc_page_fault
pvclock_clocksource_read_nowd
handle_exception
pvclock_clocksource_read_nowd
__ring_buffer_alloc
pvclock_clocksource_read_nowd
__ring_buffer_alloc
early_trace_init
start_kernel
i386_start_kernel
startup_32_smp
[...]
=3D=3D=3D
I could transcribe all of it or capture it again from latest git and
decode the symbols, if truely really needed, but I figured the type of
crash and the trace itself could maybe be sufficient. It looks identical
to me for all later crashing kernel versions.

I bisected this down to commit fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6.

The kernel config [2] I used is 'make olddefconfig' based on Debian's
config-6.8.11-686-pae [3].

I also tested 6.9.2 and 6.10-rc1, both also still crash in the same way.

cpuinfo:
=3D=3D=3D
manx@caesar:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Duron(tm)
stepping        : 1
cpu MHz         : 1798.331
cache size      : 64 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow cpuid
3dnowprefetch vmmcall
bugs            : fxsave_leak sysret_ss_attrs spectre_v1 spectre_v2
spec_store_bypass
bogomips        : 3596.66
clflush size    : 32
cache_alignment : 32
address sizes   : 34 bits physical, 32 bits virtual
power management: ts
=3D=3D=3D

dmesg from a successful boot (Debian kernel 6.6.15-2) is here [4].

This particular system has been running all Debian testing kernels since
at least the 2.6.32 days and is currently running 6.6.15-2 completely
fine, thus this is an obvious regression.

The original Debian bug is #1071378 [5].


#regzbot introduced: fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6

[1] https://manx.datengang.de/temp/linux-6.7-crash/6.7.12-1-crash.png
[2] https://manx.datengang.de/temp/linux-6.7-crash/config
[3] https://manx.datengang.de/temp/linux-6.7-crash/config-6.8.11-686-pae
[4] https://manx.datengang.de/temp/linux-6.7-crash/dmesg-6.6.15-2.txt
[5] https://bugs.debian.org/1071378


Best regards,
J=C3=B6rn


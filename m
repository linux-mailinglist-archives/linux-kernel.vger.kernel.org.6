Return-Path: <linux-kernel+bounces-527945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C3BA41181
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A261894F24
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126EE2376E0;
	Sun, 23 Feb 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="qmb8NIHU"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF6212D83
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740341890; cv=none; b=r1MMJWRY66dYrKbsUrMm4dAyYwLWezqcZQYZGnZRdkZ3gZ58etGTWvqsPyZ3tWdnEHbOT/1F5MbM4x7zEv+qCFrfKjBhwvxYP20h7RQIe8FcssgwYKkhRaY0TAhapxNP2LxhY+xnU640ffCdCGyKEGXkcdYC2uH2jat+whR/Kcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740341890; c=relaxed/simple;
	bh=4BJvl/8+hR+6RQDBtK5wsgvXTrjzi19D1tCM9BvePWk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=AGO+oXIDRL0Bi8mYGhhBm+CYYec+Q6c/sB7+8hPxXSoBxOyJKkfXIyZIIgLHVmSkfdqYf0F8rWOSNe2ZHxTKekP5tbKvQe9M1+G1vMeibWHc7sTJai9+kD0vJsXTxRKDjcwggVCX+RNTh/tkcDqvDlO4vA0aXX9AhznkHkvFxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=qmb8NIHU; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740341884; x=1740946684; i=aros@gmx.com;
	bh=2lmC/2XVV5Z2ZAro3++vlKH/pISFafHg45X9Ftkcs4E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qmb8NIHUJASJ080R3nZ4vmoxOmjQPDmw88il/xMtuw5bCZX1ywZ4BTedXFU/uQvt
	 B9zlnzSR1pgEhRcCS7xcFKMhfa65+FYweyuiEzoVL5FsBb+bxE+lPyT3hzJZ0ycjD
	 NB0X+Q3LFnVoJmDCzQEwym85Dr2vlnKMISnGQp+fGdNBUtQIIBjvvKtyD39vEflXe
	 GUP9I0DzGWo3udqJwRTqN8LLJC470lctkO24ukfRGHcUeCkzXPVoyGeSevnlVn8ye
	 dA5iBzaagjlrfDR5icO5jCmmMBEIlWmK3Aza61BsOl3rXtbgjcBe2fM3Y4wmd2RmA
	 Z2ZE3yI0RhiGQKyCAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.10.19.7] ([98.159.234.93]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIwz4-1u1Di20o26-00Tn8b for
 <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 21:18:04 +0100
Message-ID: <0fc0f185-f85e-4246-8f2e-f89f63536ee3@gmx.com>
Date: Sun, 23 Feb 2025 20:18:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: Oops right on boot from 6.12.12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0YvoMNW3MfBp7/BHBzoaDZin5OhMS/Wsd3OxqLbRIjHuWEq2Luz
 KxD2IcbXA1amn5Stqhjfm/vF1x6Htc/kACB0SFdxWvdMfRoPHI6WX2lZ2eZZ6cSGjMESHgy
 5GcuBfARURQCCI+6MvleLgYVpwCj83nvgEL3q2LXnuC6Kf2pJexqmfqIMhXj3wggb4QWISi
 ooHKx1ApNEdHNY1lQrxXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DVxC9/VRFvE=;Rm/2Qr/rldeZGPav+QSIq+7BK4Q
 8gLsTPYKWJ9BMrqMwGNSvQ3SLIgpoN5+pRx15ImFFaYLFmdqpexaJtWrDEDIyh8Xmcgcj6/fq
 8QEyWrjZD7ZuE31UHrQJlnOxF80QZAXi/fHHotjLXCyOBr1fLniBjYDAGD6lD8+kaMEXpkYGL
 NepCOimDaEftkZqP+9H97Sp1f92s+ysb7Mg+2TyfvndvaE+u+ROFngclbXyU+id3KBNXr6Jta
 lzH7xM98ok8udWcbA8dEuQhEoyW59M77+3m5T+dm3iUXWXqJg3qbXZypORj4xdZM9oLLI8922
 cl3+0r1jZtONe/xXkJbIYNoAkJ+AVNvNaNobnZyyWlQ3Wg0WVt+71uIUyUJxDgu3M3vwutz2u
 MbEq20vkVDztj5PNPQXwLJvkF1+s7XZ9GURY+adwF98R91rUE1HV9Wf2DojtUlEo3uBn9UFvh
 C5Fyo/eC0oxfQCU1kYjbo7GbkwLGUDlY16jzijzesRnVKgNIh5lCXC0s+VaEPVI3WgEiXcnjr
 bAt/Ocex1HJ+K05oQeDRkG/cisLi9I+RGGqS3XUSMheD3Mua4EbAnINVIW2CoA+VxyUTbv4hY
 3lDE08zXYRk1rvYhpPn3QtRnk/o15EjplwbVI9cAJ/alg8piPiJIp0GjB1e5Zz3bV7yTzKazm
 Mj/dVpQISB0HTn9qibXlx7Q+1eknaTLnJLA7ZVv5u4UkQDf1vdaR0kevpxFgPBzr9bcc0rmJc
 1OqzZDjwkaXtMdeiJ2787d/xRAgsE21Xm8vDNecxi06ltLTctdKfcDUWLgkyiCIBQGEmsq+83
 5sclrWshpJNq8p26BS0eVORnLBAOXOcT3xxgh4I+L3+QMNmLdeTBn9wElZh6VBna3FYCJnw/Q
 pSz2btn3b9x1cVD0tpLAh1SB7nvCpBcXRy3dSiFivjMClVGp/Qrno+iJdf/VZDo51xYj+FwC4
 S3fZ7a2QQ7ibQJmC0gZEmKbq/Ih/PltcrYpdUk3polpvS1GBZmePUWbm4giiH1pYp86aDx8BO
 o3DUSX2wvpx93e516+KYobwfuPU7iVLtn4HC8kUuS64s9JXWZLKimy/rbOyBF5/mBFoY/ji3P
 oqhB3/PybR75R2YWnppUyLa+AeBtFXA5H7HTrBbMuQaRU5k1ajrJpaunAEdt5j/7PtVzETrlN
 zidbOeOYI9nbHlNp1i069wrNJD4lwcgmFn2HncvNxHXID8z3aJGCaIWlShDljgCc3ACR6K3Fh
 1gwuul2dW3vo959H9ds8s1eAaWgULsLXoJqogpnwzQqG+QsvDYbRJR00g/kkmTLIPggcn1s2V
 v6Cn5QQmb2d0o2eDrMaQl2ZKoMBMoS1jfveMA8vHwE3VwRxGoiC/U/w/bV+tYFr+uqUXD6Cvy
 QEkAH/f9yQOD5j+CfY+td7BB7tZT8GGsK+dqhkB9lHzcZb4yhRFm33IpUwM+aMvouY2OEWnO/
 PLAmDtQ==

Hello,

I've not been able to find anything in regard to this, but kernel
6.12.12 boots with oopses before any other messages. I've never seen
this before, I don't remember this happening with 6.12.4 either.

This is dmesg as is:

Linux version 6.12.12-200.fc41.x86_64
(mockbuild@705a0f43f2254ed2aafbd5bf2b9db346) (gcc (GCC) 14.2.1 20250110
(Red Hat 14.2.1-7), GNU ld version 2.43.1-5.fc41) #1 SMP PREEMPT_DYNAMIC
Sat Feb  1 19:02:08 UTC 2025
=2D-----------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/static_call_inline.c:153
__static_call_update+0x18c/0x1f0
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.12-200.fc41.x86_64 #1
RIP: 0010:__static_call_update+0x18c/0x1f0
Code: 80 3d 4b 77 88 02 00 0f 85 7b ff ff ff 4c 89 f6 48 c7 c7 70 28 e7
af c6 05 34 77 88 02 01 e8 9b 69 d8 ff 0f 0b e9 5e ff ff ff <0f> 0b 48
c7 c7 40 62 a0 b0 e8 46 14 eb 00 48 8b 44 24 28 65 48 2b
RSP: 0000:ffffffffb0803e28 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: ffffffffaf229658 RCX: 0000000059b7e3e9
RDX: 0000000000000000 RSI: ffffffffb1774a70 RDI: ffffffffb0872100
RBP: ffffffffb0aa9d30 R08: 00000000ff59b7e3 R09: 2038303a32303a39
R10: 3220435455203830 R11: 3a32303a39312031 R12: ffffffffaf6d4150
R13: 0000000000000002 R14: ffffffffae7c4e40 R15: 000000000e9f0000
FS:  0000000000000000(0000) GS:ffffffffb1291000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88800ce2e000 CR3: 00000002f33a4000 CR4: 00000000000000b0
Call Trace:
  <TASK>
  ? __static_call_update+0x18c/0x1f0
  ? __warn.cold+0x93/0xfa
  ? __static_call_update+0x18c/0x1f0
  ? report_bug+0xff/0x140
  ? __pfx_lockdown_is_locked_down+0x10/0x10
  ? early_fixup_exception+0x5d/0xb0
  ? __SCT__lsm_static_call_bpf_token_capable_9+0x8/0x8
  ? early_idt_handler_common+0x2f/0x3a
  ? __pfx_lockdown_is_locked_down+0x10/0x10
  ? __SCT__lsm_static_call_bpf_token_capable_9+0x8/0x8
  ? __static_call_update+0x18c/0x1f0
  ? __static_call_update+0x7e/0x1f0
  ? __pfx_lockdown_is_locked_down+0x10/0x10
  ? security_add_hooks+0xb8/0x120
  ? lockdown_lsm_init+0x21/0x30
  ? initialize_lsm+0x34/0x60
  ? early_security_init+0x3d/0x50
  ? start_kernel+0x66/0xa00
  ? x86_64_start_reservations+0x24/0x30
  ? x86_64_start_kernel+0xed/0xf0
  ? common_startup_64+0x13e/0x141
  </TASK>
=2D--[ end trace 0000000000000000 ]---
=2D-----------[ cut here ]------------
static_key_enable_cpuslocked(): static key
'security_hook_active_locked_down_0+0x0/0x10' used before call to
jump_label_init()
WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:199
static_key_enable_cpuslocked+0x8c/0x90
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G        W
6.12.12-200.fc41.x86_64 #1
Tainted: [W]=3DWARN
RIP: 0010:static_key_enable_cpuslocked+0x8c/0x90
Code: ff c7 03 01 00 00 00 48 c7 c7 e0 8d a0 b0 5b e9 2a fb e8 00 48 89
fa 48 c7 c6 e0 70 67 af 48 c7 c7 78 2d e7 af e8 54 50 d6 ff <0f> 0b eb
86 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0000:ffffffffb0803e70 EFLAGS: 00010086 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: ffffffffb19285e0 RCX: 000000000000007e
RDX: 000000000000007e RSI: 00000000ffffe02a RDI: ffffffffb0803d20
RBP: ffffffffaff68498 R08: 0000000020646573 R09: 0000000000000000
R10: 6a206f74206c6c61 R11: 0000000000000000 R12: ffffffffaf6d4150
R13: 0000000000000002 R14: 0000000000000001 R15: 000000000e9f0000
FS:  0000000000000000(0000) GS:ffffffffb1291000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88800ce2e000 CR3: 00000002f33a4000 CR4: 00000000000000b0
Call Trace:
  <TASK>
  ? static_key_enable_cpuslocked+0x8c/0x90
  ? __warn.cold+0x93/0xfa
  ? static_key_enable_cpuslocked+0x8c/0x90
  ? report_bug+0xff/0x140
  ? early_fixup_exception+0x5d/0xb0
  ? early_idt_handler_common+0x2f/0x3a
  ? static_key_enable_cpuslocked+0x8c/0x90
  ? static_key_enable+0x1a/0x20
  ? security_add_hooks+0xc9/0x120
  ? lockdown_lsm_init+0x21/0x30
  ? initialize_lsm+0x34/0x60
  ? early_security_init+0x3d/0x50
  ? start_kernel+0x66/0xa00
  ? x86_64_start_reservations+0x24/0x30
  ? x86_64_start_kernel+0xed/0xf0
  ? common_startup_64+0x13e/0x141
  </TASK>
=2D--[ end trace 0000000000000000 ]---
=2D-----------[ cut here ]------------
static_key_enable_cpuslocked(): static key
'security_hook_active_lock_kernel_down_0+0x0/0x10' used before call to
jump_label_init()
WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:199
static_key_enable_cpuslocked+0x8c/0x90
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G        W
6.12.12-200.fc41.x86_64 #1
Tainted: [W]=3DWARN
RIP: 0010:static_key_enable_cpuslocked+0x8c/0x90
Code: ff c7 03 01 00 00 00 48 c7 c7 e0 8d a0 b0 5b e9 2a fb e8 00 48 89
fa 48 c7 c6 e0 70 67 af 48 c7 c7 78 2d e7 af e8 54 50 d6 ff <0f> 0b eb
86 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0000:ffffffffb0803e70 EFLAGS: 00010086 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: ffffffffb1928540 RCX: 00000000000000ed
RDX: 0000000000000083 RSI: 00000000ffffe04f RDI: ffffffffb0803d20
RBP: ffffffffaff684b0 R08: 0000000020646573 R09: 0000000000000000
R10: 6a206f74206c6c61 R11: 0000000000000000 R12: ffffffffaf6d4150
R13: 0000000000000002 R14: 0000000000000002 R15: 000000000e9f0000
FS:  0000000000000000(0000) GS:ffffffffb1291000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88800ce2e000 CR3: 00000002f33a4000 CR4: 00000000000000b0
Call Trace:
  <TASK>
  ? static_key_enable_cpuslocked+0x8c/0x90
  ? __warn.cold+0x93/0xfa
  ? static_key_enable_cpuslocked+0x8c/0x90
  ? report_bug+0xff/0x140
  ? early_fixup_exception+0x5d/0xb0
  ? early_idt_handler_common+0x2f/0x3a
  ? static_key_enable_cpuslocked+0x8c/0x90
  ? static_key_enable+0x1a/0x20
  ? security_add_hooks+0xc9/0x120
  ? lockdown_lsm_init+0x21/0x30
  ? initialize_lsm+0x34/0x60
  ? early_security_init+0x3d/0x50
  ? start_kernel+0x66/0xa00
  ? x86_64_start_reservations+0x24/0x30
  ? x86_64_start_kernel+0xed/0xf0
  ? common_startup_64+0x13e/0x141
  </TASK>
=2D--[ end trace 0000000000000000 ]---
Command line: BOOT_IMAGE=3Dvmlinuz-6.12.12-200.fc41.x86_64 root=3D ro quie=
t
transparent_hugepage=3Dalways amdgpu.dcdebugmask=3D0x10
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x0000000009efffff] usable
BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
BIOS-e820: [mem 0x0000000009f3c000-0x000000000ce24fff] usable
BIOS-e820: [mem 0x000000000ce25000-0x000000000ce2dfff] ACPI data
BIOS-e820: [mem 0x000000000ce2e000-0x0000000025078fff] usable
BIOS-e820: [mem 0x0000000025079000-0x0000000028df3fff] reserved
BIOS-e820: [mem 0x0000000028df4000-0x00000000294f3fff] ACPI NVS
BIOS-e820: [mem 0x00000000294f4000-0x0000000029573fff] ACPI data
BIOS-e820: [mem 0x0000000029574000-0x000000003d56bfff] usable
BIOS-e820: [mem 0x000000003d56c000-0x000000003d56efff] reserved
BIOS-e820: [mem 0x000000003d56f000-0x0000000044011fff] usable
BIOS-e820: [mem 0x0000000044012000-0x0000000044012fff] reserved
BIOS-e820: [mem 0x0000000044013000-0x000000004401afff] usable
BIOS-e820: [mem 0x000000004401b000-0x000000004401bfff] reserved
BIOS-e820: [mem 0x000000004401c000-0x0000000057ffffff] usable
BIOS-e820: [mem 0x0000000058000000-0x000000005bffffff] reserved
BIOS-e820: [mem 0x000000005d790000-0x000000005fffffff] reserved
BIOS-e820: [mem 0x00000000c0300000-0x00000000c03fffff] reserved
BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
BIOS-e820: [mem 0x00000000fedf1000-0x00000000fedf1fff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000079e2fffff] usable
BIOS-e820: [mem 0x000000079e300000-0x00000008c01fffff] reserved
BIOS-e820: [mem 0x000000fd00000000-0x000000fd01ffffff] reserved
NX (Execute Disable) protection: active
APIC: Static calls initialized
e820: update [mem 0x0ce20018-0x0ce24257] usable =3D=3D> usable
extended physical RAM map:
reserve setup_data: [mem 0x0000000000000000-0x000000000009efff] usable
reserve setup_data: [mem 0x000000000009f000-0x000000000009ffff] reserved
reserve setup_data: [mem 0x0000000000100000-0x0000000009efffff] usable
reserve setup_data: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
reserve setup_data: [mem 0x0000000009f3c000-0x000000000ce20017] usable
reserve setup_data: [mem 0x000000000ce20018-0x000000000ce24257] usable
reserve setup_data: [mem 0x000000000ce24258-0x000000000ce24fff] usable
reserve setup_data: [mem 0x000000000ce25000-0x000000000ce2dfff] ACPI data
reserve setup_data: [mem 0x000000000ce2e000-0x0000000025078fff] usable
reserve setup_data: [mem 0x0000000025079000-0x0000000028df3fff] reserved
reserve setup_data: [mem 0x0000000028df4000-0x00000000294f3fff] ACPI NVS
reserve setup_data: [mem 0x00000000294f4000-0x0000000029573fff] ACPI data
reserve setup_data: [mem 0x0000000029574000-0x000000003d56bfff] usable
reserve setup_data: [mem 0x000000003d56c000-0x000000003d56efff] reserved
reserve setup_data: [mem 0x000000003d56f000-0x0000000044011fff] usable
reserve setup_data: [mem 0x0000000044012000-0x0000000044012fff] reserved
reserve setup_data: [mem 0x0000000044013000-0x000000004401afff] usable
reserve setup_data: [mem 0x000000004401b000-0x000000004401bfff] reserved
reserve setup_data: [mem 0x000000004401c000-0x0000000057ffffff] usable
reserve setup_data: [mem 0x0000000058000000-0x000000005bffffff] reserved
reserve setup_data: [mem 0x000000005d790000-0x000000005fffffff] reserved
reserve setup_data: [mem 0x00000000c0300000-0x00000000c03fffff] reserved
reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
reserve setup_data: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
reserve setup_data: [mem 0x00000000fedf1000-0x00000000fedf1fff] reserved
reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
reserve setup_data: [mem 0x0000000100000000-0x000000079e2fffff] usable
reserve setup_data: [mem 0x000000079e300000-0x00000008c01fffff] reserved
reserve setup_data: [mem 0x000000fd00000000-0x000000fd01ffffff] reserved
efi: EFI v2.7 by HP
...


Regards,
Artem


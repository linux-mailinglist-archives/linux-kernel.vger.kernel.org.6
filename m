Return-Path: <linux-kernel+bounces-300249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F050395E102
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C10D1F21AAC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC812A1CF;
	Sun, 25 Aug 2024 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="RjetoFah";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="XJbJMqnN"
Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A422F11
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724559302; cv=none; b=Y2mDRd+vfleEP3/WjwYKMuyyziLqTwxD54kuFm4K365bBgiuK4ZcRgmgeVDcpoIW7yDLC1DSkw74C05umwrmXYJ+rcYLtxDpqhjBdr4zuYNTh/ciPy1ETh7ZJcEXUds1Ad4N/ctC5l2Afr13lZf/9StGlUWWh/7jCLPJxqN/fZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724559302; c=relaxed/simple;
	bh=L4pwj5e/Du/ZHfMerLHq/vRTblg6mzfiuz1IZooeInk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dIjJOW+GEBxbiClZxWW9CwCTPis31TqKlV7HZKy6XHT+dU1XCZz3T1Imrh53h9lTgww1wvfyQ16/fFpjSfWzpKbugLMK4V9VJn6d3ei6eAInK7FPDGqqvNglUelkj+xfeet4oJzmN1k9msIKiZfidvMAWyHWreFi/8ZECl36MB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=RjetoFah; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=XJbJMqnN; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724559301; x=1756095301;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:content-transfer-encoding:
   x-cse-connectionguid:x-cse-msgguid;
  bh=L4pwj5e/Du/ZHfMerLHq/vRTblg6mzfiuz1IZooeInk=;
  b=RjetoFah+1EK1deHgSw0AH8Sy9diKfkLroiyLITTgyzkUQM5GcybLBLu
   LKKxGnvcPmd6SfKzToqYoJI322ZIKxuSw4lzcbTq5+kNO6sXewWyKDz/N
   vcM/wyEi6sBTu1Hc7yZAu+Z4UZFB1N6PMDOLlm+2RwzHQGQm+lkxK+kWk
   OSji1ENikVcyRiXrXKJYDYYzmtj7IcB1z9SipPK3eVG/Eo88K8/vhlnh4
   mmQZEHbxKxCvFxJFcL+UHcQQ/QGq/wIJegtaUY6JXjApqRVfyf+TkdfHg
   GekQsznbIbWInuLAwmcWskkQCah1aJkxJ7jb0nDOZcizl5/yt/yrG6okX
   w==;
X-CSE-ConnectionGUID: 4NxA608bQNK+vhyGQgYUwQ==
X-CSE-MsgGUID: tGv8XmENR+WUNw/+8uAFtQ==
Received: from mail-ot1-f72.google.com ([209.85.210.72])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 21:15:00 -0700
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7094845f368so5120024a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 21:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724559299; x=1725164099; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JHLAS9LFKUJx31SZDetF9WNVyX8R0blvVKxB0DviL8=;
        b=XJbJMqnNcC8OxMrlB2Hut708nxV25bHyQj9Kts/2N5MVw9JAS7Y/a6CFlIm2UpXM+u
         zg5SejD4Rm2nWEo5z6UEpxTVYQHy8/UsNNHSJNHubVusNs4S/T/iVkJ4R9140zJ9J35J
         P5GomhE7ley+0hswbIG4qVRewT1kNDhH9eTXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724559299; x=1725164099;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JHLAS9LFKUJx31SZDetF9WNVyX8R0blvVKxB0DviL8=;
        b=eh5aQMc4B/3es/DC25zOrZoCv+km2Up5nYS8i/bhX7NoVxz378BVG5MpzmAufdL61V
         5ED7Tnmc29pwNNV1VUInife7jD0a0xYAPrfIgTiakTdgggFU4DDgMh6DCV7hw0R4SEy3
         5FtVR/HRziRJlrZKhHhYV2zl8EcmNWUyoq+hiaB9XSCyDl6gph7WK+IAb3Nfk9ljc810
         pwVRwu0BXDtM0yDyjIH7m2Uu0MULxBXxb/3oJC9vs+9yqlUkBnjZLzwEnzkbnzrqLLJ3
         BU7Ofws950WVTmlpbmuo4bSFRRMIzw6oTM6x6Tfr6aMpU+X3pHIFzG2LgPGiOIzbPzKO
         OALw==
X-Forwarded-Encrypted: i=1; AJvYcCUThlGt67goCVcdrjybRpDd7tmlb5rQ5Wl+L2UnZJ7A1w5I/aHWc2N8uDJQhZ5RScEaHmwjRx0EbrBG6XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPrYi8VH2wTnMTqR8Cxp4YPAPVVfBbeDGWmgt0Q0m9RNHR9MvN
	FGjba/IFKC+Wek+MSLGfQE21GfJRrl6bJjqiJtWv6XExhwhm2nJfCx9jd2izSq2tShbxSH7YpeI
	1kFcqxJlztU4qr3NFxv0EMWvVIg/k82K8497Hf8EJNvdexzMjfHsbMo36DJGjBmffqnXIcW1kTp
	jsXjY08qEd4J9T7ZoZvLtLME7i5zzyF4bBGtWRpw==
X-Received: by 2002:a05:6830:4989:b0:703:6641:cea5 with SMTP id 46e09a7af769-70e0eb37e5bmr8708477a34.16.1724559299005;
        Sat, 24 Aug 2024 21:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxPHBCKI46nI/OXfg8etlSxv0aFfYfimbk9eAadzbb0zpTySvht50sBxkQI4YKVHEE0cb9T1zzLhMZjNP8G3Y=
X-Received: by 2002:a05:6830:4989:b0:703:6641:cea5 with SMTP id
 46e09a7af769-70e0eb37e5bmr8708459a34.16.1724559298687; Sat, 24 Aug 2024
 21:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 21:14:48 -0700
Message-ID: <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
Subject: BUG: general protection fault in batadv_bla_del_backbone_claims
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, 
	sven@narfation.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	b.a.t.m.a.n@lists.open-mesh.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We found a bug in Linux 6.10 using syzkaller. It is probably a null
pointer dereference bug.
In line 307 of net/batman-adv/bridge_loop_avoidance, when executing
"hash =3D backbone_gw->bat_priv->bla.claim_hash;", it does not check if
"backbone_gw->bat_priv=3D=3DNULL".

The bug report and syzkaller reproducer are as follows:

bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc000000004a: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000250-0x0000000000000257]
CPU: 0 PID: 45 Comm: kworker/u4:3 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: bat_events batadv_bla_periodic_work
RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360
net/batman-adv/bridge_loop_avoidance.c:307
Code: 18 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89
df e8 01 72 33 f7 bd 50 02 00 00 48 03 2b 48 89 e8 48 c1 e8 03 <42> 80
3c 20 00 74 08 48 89 ef e8 e3 71 33 f7 48 8b 6d 00 48 85 ed
RSP: 0018:ffffc9000090f9b0 EFLAGS: 00010202
RAX: 000000000000004a RBX: ffff88802cd7c018 RCX: ffff888015370000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88802cd7c000
RBP: 0000000000000250 R08: ffffffff8ac0433d R09: 1ffff110059af805
R10: dffffc0000000000 R11: ffffed10059af806 R12: dffffc0000000000
R13: ffff88802cd7c008 R14: 00000000ffffcf80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556956047f2c CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 batadv_bla_purge_backbone_gw+0x285/0x4c0
net/batman-adv/bridge_loop_avoidance.c:1254
 batadv_bla_periodic_work+0xc3/0xa80 net/batman-adv/bridge_loop_avoidance.c=
:1445
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360
net/batman-adv/bridge_loop_avoidance.c:307
Code: 18 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89
df e8 01 72 33 f7 bd 50 02 00 00 48 03 2b 48 89 e8 48 c1 e8 03 <42> 80
3c 20 00 74 08 48 89 ef e8 e3 71 33 f7 48 8b 6d 00 48 85 ed
RSP: 0018:ffffc9000090f9b0 EFLAGS: 00010202
RAX: 000000000000004a RBX: ffff88802cd7c018 RCX: ffff888015370000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88802cd7c000
RBP: 0000000000000250 R08: ffffffff8ac0433d R09: 1ffff110059af805
R10: dffffc0000000000 R11: ffffed10059af806 R12: dffffc0000000000
R13: ffff88802cd7c008 R14: 00000000ffffcf80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556956047f2c CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 18 48 83             sbb    %cl,-0x7d(%rax)
   3: c3                   ret
   4: 18 48 89             sbb    %cl,-0x77(%rax)
   7: d8 48 c1             fmuls  -0x3f(%rax)
   a: e8 03 42 80 3c       call   0x3c804212
   f: 20 00                 and    %al,(%rax)
  11: 74 08                 je     0x1b
  13: 48 89 df             mov    %rbx,%rdi
  16: e8 01 72 33 f7       call   0xf733721c
  1b: bd 50 02 00 00       mov    $0x250,%ebp
  20: 48 03 2b             add    (%rbx),%rbp
  23: 48 89 e8             mov    %rbp,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 20 00       cmpb   $0x0,(%rax,%r12,1) <-- trapping instructi=
on
  2f: 74 08                 je     0x39
  31: 48 89 ef             mov    %rbp,%rdi
  34: e8 e3 71 33 f7       call   0xf733721c
  39: 48 8b 6d 00           mov    0x0(%rbp),%rbp
  3d: 48 85 ed             test   %rbp,%rbp


Syzkaller reproducer:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
Sandbox:none SandboxArg:0 Leak:false NetInjection:false
NetDevices:true NetReset:false Cgroups:false BinfmtMisc:true
CloseFDs:true KCSAN:false DevlinkPCI:false NicVF:false USB:true
VhciInjection:false Wifi:true IEEE802154:false Sysctl:false Swap:true
UseTmpDir:true HandleSegv:true Trace:false
LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
write$syz_spec_1342568572_346(0xffffffffffffffff,
&(0x7f0000000080)=3D{{0x0, 0x4, 0x6}, {0x5, 0x0, 0x111, 0xe,
"c2beae5c4e"}}, 0x20)
write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
&(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658026b81bf26=
4340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a0772b12=
ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6be6a3=
00916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c53bc4=
14539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400",
0xb4)
r0 =3D syz_open_dev$sg(&(0x7f0000000180), 0x0, 0x109400)
ioctl$syz_spec_1724254976_2866(r0, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
[0x85, 0x8, 0x15, 0xd]})
ioctl$TIOCSTI(0xffffffffffffffff, 0x5412, 0x0)
openat$ttynull(0xffffffffffffff9c, &(0x7f00000000c0), 0x109841, 0x0)
r1 =3D openat$ttynull(0xffffffffffffff9c, 0x0, 0x109841, 0x0)
ioctl$TIOCSTI(r1, 0x5412, 0x0)
syz_open_dev$tty20(0xc, 0x4, 0x1)
write$syz_spec_1342568572_233(0xffffffffffffffff, 0x0, 0x0)
ioctl$syz_spec_1101043199_396(0xffffffffffffffff, 0x80104d12, 0x0)
ioctl$syz_spec_1342803520_149(0xffffffffffffffff, 0x5501, 0xf9d)
write$syz_spec_18446744073706268967_8(0xffffffffffffffff,
&(0x7f00000002c0)=3D0xfd80, 0xfffffc34)
ioctl$syz_spec_18446744073707301390_3197(0xffffffffffffffff, 0xc0a85320, 0x=
0)
ioctl$syz_spec_18446744073707301390_3092(0xffffffffffffffff, 0x40a85321, 0x=
0)
openat$ppp(0xffffffffffffff9c, &(0x7f0000000100), 0x200, 0x0)
mmap$IORING_OFF_SQ_RING(&(0x7f00003ff000/0xc00000)=3Dnil, 0xc00000, 0xe,
0x9a172, 0xffffffffffffffff, 0x0)
mmap$IORING_OFF_SQES(&(0x7f0000000000/0xc00000)=3Dnil, 0xc00000,
0x1000019, 0x42832, 0xffffffffffffffff, 0x10000000)




--=20
Yours sincerely,
Xingyu


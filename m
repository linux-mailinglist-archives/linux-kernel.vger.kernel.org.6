Return-Path: <linux-kernel+bounces-243408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 848939295E7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A4D1C20C4D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5E481BA;
	Sat,  6 Jul 2024 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MGu/4hdM"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26B1386A7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720308535; cv=none; b=sUWPVb842JZeIVn0I4S5/FwaIN4T9nEcwnZNKu6li5H2034/CA7oNr2DiUQWjjNppp0DSiC3w9gY6AfIIqIm+xfO1Ng3wBWugJEHHSNFd/SSkNtURbQwEfAitJCJD8bW/5/oph/2NhuEW1lkj/Fd25NnYaZGpy1G0vOihuB5t6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720308535; c=relaxed/simple;
	bh=NqM8u/B8IpPzeM7YoTPCwbh+0lHUk3qGxl88MC2YW2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TJWU6ymzaWTx/LL5NdQNfRyl6ArhXWG+2ouTQnMHdh7qDNO5ZL7ggf1qvvZ+Uqj2pxKgIo9TZWT0mGrxe6nXBfIxOM2JopTbLxGHG2x/mdJe18Ez69wYZVUpAMT6zD4zwittC/UQq01rP5LaSAIKKhoJVbzJP/JUTt3RjD0Vz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=MGu/4hdM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720308531;
	bh=MZPrrz50Q58iHN+nAhEHGrx3MePXgnyuTKmR8fmWfbE=;
	h=From:To:Cc:Subject:Date:From;
	b=MGu/4hdMEq1NfRSrcEM5BBzs52X1JsfoSUUAH8Ghd/LxT95qE/s8hpDIOoCYaaUDx
	 /u/V/s0Zo1fx1BZkBzwfO3r6x1vBmBDnZg5RQeu6TrmmLS1blJ/TxHZdBpIfEtMCti
	 Z/JDW9VqrdC7o98vIDmsQhE/TIaITFGyj0lBPutAVZ0E4HO4Iimm1fYgn0DSKpctrL
	 Rh03tpgPNKg0behZHP23t/78uUs7mH2t5giXo0ApIMuiVaMPW+bnFGZBaQpaQBiUHo
	 yal2y8bgas+KhoEmpuNEsW94ayLWciiTrl3RgYBYM5LoIHUETLRaKesFVcf2yEmsgb
	 m1R6deEBdTc7w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WGmmL75HJz4xNg;
	Sun,  7 Jul 2024 09:28:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: anjalik@linux.ibm.com, ganeshgr@linux.ibm.com, jinglin.wen@shingroup.cn,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.10-4 tag
Date: Sun, 07 Jul 2024 09:28:50 +1000
Message-ID: <87wmly2j7x.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.10:

The following changes since commit a986fa57fd81a1430e00b3c6cf8a325d6f894a63:

  KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group() (2024-06-16 10:20:11 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-4

for you to fetch changes up to 8b7f59de92ac65aa21c7d779274dbfa577ae2d2c:

  selftests/powerpc: Fix build with USERCFLAGS set (2024-07-06 22:10:14 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.10 #4

 - Fix unnecessary copy to 0 when kernel is booted at address 0.

 - Fix usercopy crash when dumping dtl via debugfs.

 - Avoid possible crash when PCI hotplug races with error handling.

 - Fix kexec crash caused by scv being disabled before other CPUs call-in.

 - Fix powerpc selftests build with USERCFLAGS set.

Thanks to: Anjali K, Ganesh Goudar, Gautam Menghani, Jinglin Wen, Nicholas
Piggin, Sourabh Jain, Srikar Dronamraju, Vishal Chourasia.

- ------------------------------------------------------------------
Anjali K (1):
      powerpc/pseries: Whitelist dtl slub object for copying to userspace

Ganesh Goudar (1):
      powerpc/eeh: avoid possible crash when edev->pdev changes

Jinglin Wen (1):
      powerpc/64s: Fix unnecessary copy to 0 when kernel is booted at address 0

Michael Ellerman (1):
      selftests/powerpc: Fix build with USERCFLAGS set

Nicholas Piggin (1):
      powerpc/pseries: Fix scv instruction crash with kexec


 arch/powerpc/kernel/eeh_pe.c             |  7 +++++--
 arch/powerpc/kernel/head_64.S            |  5 +++--
 arch/powerpc/kexec/core_64.c             | 11 +++++++++++
 arch/powerpc/platforms/pseries/kexec.c   |  8 --------
 arch/powerpc/platforms/pseries/pseries.h |  1 -
 arch/powerpc/platforms/pseries/setup.c   |  5 ++---
 tools/testing/selftests/powerpc/flags.mk |  5 +----
 7 files changed, 22 insertions(+), 20 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmaJ0hYACgkQUevqPMjh
pYB1uBAAhxsR3VV+XLbJTkhEARgUdzZt+8AMk4oc7dzPx1xUIavXJqaMGdoCGDcu
0atvYlyel2CAFHbjRkaIzOxg2ZUtXdOvio4udeFvb48DCnaaH0WsOdG70OIThtX0
Zl+lkRgRy5SM1KPJUa+o9ygvi90ZNbOV358h/ar9l4O7EULmOqZwlZYAhlEYr25B
MtvX6ZONGOgl5SxVr9+55vLm0/g97OzuGmi343XHEdHjBhH5HkcKi8Z5XkwYFGOt
cExZFVtWnayM+PsUkympt3o5Zchb+oc1EUAJWUILQJQMHx89atc9Q0pxZyi7XXA/
tT8mq0O78+iZbK1UuQ3qgE1/YPrHCdX8Glo0AmGoSem8P41HlWyamK28U4aK6VWd
iqJCb25EZmKs5uo4Z0F10jswjc9QOgFftzgM74GCLkZ74vx3ubw9vKacRb/SkdLi
vQz0M0Gh73tqwfjN0W3gRwWblCim3kCoHVBb8CmiB0YeDoq7nu2+ow94WFrhlvs+
/HFOQ5NgnMhjzytmeAzWOk0s/xOXPCwbrEUjfRxRg5cZCWXUuO6XmeO547pZy2Ke
JwBWO+Hi9b5jwC/5LEQZ3wJ2rjSCJwDKT8MwqvcSSsEXvpGvsjMCi4mTqVVlbRkQ
qz/lv0PozyavP/AUPamX0wZ0k5df/XDkX1qxoxyG/x1HXlwDhJ4=
=7pyj
-----END PGP SIGNATURE-----


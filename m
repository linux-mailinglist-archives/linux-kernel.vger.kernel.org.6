Return-Path: <linux-kernel+bounces-198053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BA8D72E0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6594B1C20A9A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D49A4AEE9;
	Sat,  1 Jun 2024 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DFSOrQ4T"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B81EA91
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717286258; cv=none; b=CClJik5DNoeoiitZ5blHiTkMU51POv27fOsTq65yty7m/3eVoOw5DxVrOT5j/0ZsSB3vOIUFCdhkslKWll7pgfLbEiM4wMgS3egd58k/oYO6SJ45vtWZ8ID3QCJcgUlEg8Hk8Ml355wm/q1ENxl5ayQR9tBGLQ3XScikKpvxagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717286258; c=relaxed/simple;
	bh=DHUWMTgVZ0Lq2zg7Hme+2hVronFLVwTgL2f1SdiQGPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QRNaJpkpqzxIURh9olJ6rkr6m3iqkDDlACjitDwDfPIZU+E7AiMDC64nhyHEI4YjoBFUGsEfC9AOh5Tm3NdPNVa93aKGA/wS4Kwzh0fytTwCxqv85+LL8nzS82lSyf8ArgS47VlDCZfm+3+EQ4Qj0RM1en2OAa4/jhGnjnuOtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=DFSOrQ4T; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1717286254;
	bh=D2MP2e8VMlG4JO4CXpIHI0rEQHY0ay7+BGfxfkpwVfE=;
	h=From:To:Cc:Subject:Date:From;
	b=DFSOrQ4Tm4bISxpfZo1YwLJxtYsdTdRjjVqP/IQoqfdeSGz37aU87T3X2YMgBOtcQ
	 uUqTpoKNNXb3n6IDkfwWgL++SfjbFscji/XmXjFXo9ncEEYocsNekIxvvz/RX+BOXs
	 6KTemgKQJa0Gshv/iOCi4H5dbAzRST9M0YWvDriVafz1woye2OX46pT0FzZ89cHGcx
	 +ifqBQ/xxAmL0obuqW0BtDndhY6k/+O+2/2D8DwLZID3VA0TOvqC4p2smQ0RSmstqZ
	 +PlMW5ANnf5SBOEjOKabf+Wvt5xkSJfJRp5kMEYCWUwXOKTodcRdclWHGcdfZyGxlu
	 ChxHyo17gjYPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VsH3f0dnxz4xFB;
	Sun,  2 Jun 2024 09:57:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nathanl@linux.ibm.com, puranjay@kernel.org, samuel.holland@sifive.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.10-2 tag
Date: Sun, 02 Jun 2024 09:57:33 +1000
Message-ID: <87jzj82p3m.fsf@mail.lhotse>
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

Please pull powerpc fixes for 6.10:

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-2

for you to fetch changes up to be2fc65d66e0406cc9d39d40becaecdf4ee765f3:

  powerpc: Limit ARCH_HAS_KERNEL_FPU_SUPPORT to PPC64 (2024-05-30 22:57:27 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.10 #2

 - Enforce full ordering for ATOMIC operations with BPF_FETCH.

 - Fix uaccess build errors seen with GCC 13/14.

 - Fix build errors on ppc32 due to ARCH_HAS_KERNEL_FPU_SUPPORT.

 - Drop error message from lparcfg guest name lookup.

Thanks to: Christophe Leroy, Guenter Roeck, Nathan Lynch, Naveen N Rao, Puranjay
Mohan, Samuel Holland.

- ------------------------------------------------------------------
Michael Ellerman (2):
      powerpc/uaccess: Fix build errors seen with GCC 13/14
      powerpc/uaccess: Use YZ asm constraint for ld

Nathan Lynch (1):
      powerpc/pseries/lparcfg: drop error message from guest name lookup

Puranjay Mohan (1):
      powerpc/bpf: enforce full ordering for ATOMIC operations with BPF_FETCH

Samuel Holland (1):
      powerpc: Limit ARCH_HAS_KERNEL_FPU_SUPPORT to PPC64


 arch/powerpc/Kconfig                     |  2 +-
 arch/powerpc/include/asm/uaccess.h       | 27 ++++++++++++++++++++
 arch/powerpc/net/bpf_jit_comp32.c        | 12 +++++++++
 arch/powerpc/net/bpf_jit_comp64.c        | 12 +++++++++
 arch/powerpc/platforms/pseries/lparcfg.c |  4 +--
 5 files changed, 54 insertions(+), 3 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmZbtSIACgkQUevqPMjh
pYALTQ//YkCAb17EW6iQfmcuaq7Amhz5QUDUU3TFhfcmmuDd3Fw3bh9sppF+so0S
UsZpBRgY9C6xFkOqpyrqj9KOSXNsWE5m46Hp0Cl7BlkdeM2c68T77BxN5pEcnI4i
so64UHaLDI0miirQE25ihA4BdmtzAfw6PL6vubcBoLrlSWktXDQXBZb0EkOeYNiR
QI+4EnwfkUiw+55eXEHoWIwWuyW7oMd2px8wXEnb9daOxu7NqDhKINVYN8g0If8u
m90egWk56gq1A/ei43zeqPQAKi8hvQe93+tkmCI7NkJCx+YrYmUStqIC/4/iZlJd
XMaUre8mckU6eWRfUL5G28BDETtNm3t2TlflJ+GK1XvLd0LOj2SEk0f5i2bXA6ey
o1ISDVE3dRbS3CzfiZw8S7QvJiCeqBU1d3gMjNge+c1iSG0rgd20tMA17+SEKaHn
W2tSZev6P9vbpF+9R0kxvyCRQ3EmPeOReSk0XIXU+X0V2NFIEIzQJMS/2NL2Mro8
O5tj3elpRbqSa/rEUUQymUpQ3qEkTfoFrIAiCkFvu+OcAtq26OL18olxWo0RF9Fg
8ElHjsGLMDNPyTrBIIIegcgsX+/fvGbwg5NpQlXOD564Y0cMfYi8kYwgU6Z9ism1
YfKFgvrj1akmTMrZobqZ1N0tCjXZVbRP+ykyT6uUtG7ut4v4d8U=
=+3xo
-----END PGP SIGNATURE-----


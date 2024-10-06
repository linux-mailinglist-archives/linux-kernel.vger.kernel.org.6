Return-Path: <linux-kernel+bounces-352282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAAC991CE7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 09:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0001C216C9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 07:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73D15C128;
	Sun,  6 Oct 2024 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NDyjSmwy"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A10249F9
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728198182; cv=none; b=KQ7+3LYdyKInOpd6lWnTOXosqyGtEeeWlEXp8EUeX5OI80arSdbECrG581xnlirE8KKQkXD9o27Ci3X5zeeoga4pSR+lKL2sru0l8lOOqtJrC05n6+mi4N76JXhWcCsFREuT39jsQE28JJz1IXdtYqlVqbZURYckp6f64cxNrV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728198182; c=relaxed/simple;
	bh=LwqthR418ERMyg7GU3ftN84xU6eVCN5PGkoaY1oIgBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fac6r7DOeSkP49zl5CkaHgxpobWohfPb6KbBFmNXrG1CT3q1jNP5GzEZ7LWOnNLw/W9gH2Pzsh7GWxT1txuo2HnBtVe0Nz9BmHM6+TcbEUxFee9kYoJXw1AoD7RGWDdaTaYfwCp65K3W7lEz7aUqTMaCCr+Nd6H1GAqiu8v/ioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=NDyjSmwy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728198170;
	bh=U/EQGoaL7JZxS1pYk6j6uqf8Pcy74sEy3785WNTe6kg=;
	h=From:To:Cc:Subject:Date:From;
	b=NDyjSmwygkBHYeM0t5dP7EbGHj7aulY8BHUVRL4ZvqCxaK1jhSjsmBtqcbOvR9tpg
	 oeguSOCC6QB03S2bQOVJB2QUwFkq6OIP/5Tc3/yB5OWdoqdApDxxm/sV3f7WDH8g7Z
	 OdpLNlH/a4FmR05cF+4dLq8xT0DL9SdawmAlAHNv2jFBAh4nteMQ58g7R1/KIrBntK
	 Psn2gkR5WvZqXOOZVt47dPUh5Fy5Inu2f9Rid2fri0F+3lTaiHjjMdbkdcSNvFTAKV
	 YoIxXiXzg5XKSjV2taATHU0h9t06nJYA/oRj8pBmBsEW4K5z7I0Zv78TBcZMedYA1+
	 jC0Fb3TSaYh3g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XLtX92kbRz4wxx;
	Sun,  6 Oct 2024 18:02:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason@zx2c4.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-3 tag
Date: Sun, 06 Oct 2024 18:02:46 +1100
Message-ID: <87bjzxlnmx.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull some more powerpc fixes for 6.12:

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-3

for you to fetch changes up to 4b058c9f281f5b100efbf665dd5a1a05e1654d6d:

  powerpc/vdso: allow r30 in vDSO code generation of getrandom (2024-09-30 19:19:43 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.12 #3

 - Allow r30 to be used in vDSO code generation of getrandom.

Thanks to: Jason A. Donenfeld.

- ------------------------------------------------------------------
Jason A. Donenfeld (1):
      powerpc/vdso: allow r30 in vDSO code generation of getrandom


 arch/powerpc/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRjvi15rv0TSTaE+SIF0oADX8seIQUCZwI15wAKCRAF0oADX8se
Ia03AP9Wmr2WQ9B2Ei8oQMJBIZkPxkdnqG+K98O3ggFZv8Qz3QD+NgQXIYs+Gvay
5Ql5F5hp1D+KepgXmJJsGVhql2vrMgI=
=vwqi
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel+bounces-362648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD48699B7AD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A801F21356
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 23:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86BE1487ED;
	Sat, 12 Oct 2024 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="INMHSXTR"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55942A8E
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728775177; cv=none; b=O/i00zTtNQB0pCwLitqov1PH1CPjzUO/dr0zP7nfb79IY9WdHZjQ7vIzwWBlXxAE3lrFwvKirIOfpyqkHD+xox2AOnR7lXVLbsm+jv56kncbukqMqJ3KBEd2au+i5MT0ilsv4FTa0kYUxV0Nmkizs2vsTz46yuxajAKA0aS+VS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728775177; c=relaxed/simple;
	bh=/Et6MeuY7EpIZdnZNyj+l5TOWOl0OlqEDpHKXlMWZd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXaffvBYKPnLzPbK2Jt2GCuTc0YLsexucnYh3L4VSMlG3YIdswGh3Mrxcy5gddmKufEyqx/5aMWW6ZSuo1ebHszVJd0bcZx7hA0w85OWWON9VEzMHg9XGbvNSl6fscGrd0c1rX0qH87hCuOPO0ADxl4THAsI0CHOA25sh0embtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=INMHSXTR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728775172;
	bh=iPe6bARDbmutmL/3UO+PHaMpdoI/drRBAgwzRmjlJxw=;
	h=From:To:Cc:Subject:Date:From;
	b=INMHSXTRcx1fU9CHXGZGhH70HQ1sy0kCKGE0AtZJyVnnwhwJu03JaXfh/Rb3apAuI
	 nJZ7wtjyob94jH6RSzZ2xkcoWgie8SioGYgGoRrxHzofY7gK/tJHlX64ylPd4rm/+X
	 p4YiCSctCucgN/CeB4e77OnlcPPv0ZeK2vGNJSo9IsIHWIgt+HjHP8+rffBg0YIot6
	 QNG3eBulue8sfk9C2Oeq5V0Eaw9BaszRawvsCSqSfuW/FrLntg1+To6ZuhFo2lKgY2
	 ssHiaorVKP7tb4VEJSskNyJ5XPosXEVUd4pL75sUUMY1+V/2Z/nmY0Swl/vw97A0Pc
	 3TIYrTvbiWB6w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XQzwN1KN0z4xG8;
	Sun, 13 Oct 2024 10:19:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-4 tag
Date: Sun, 13 Oct 2024 10:19:32 +1100
Message-ID: <87ldys6ha3.fsf@mail.lhotse>
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

Please pull another powerpc fix for 6.12:

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-4

for you to fetch changes up to 8956c582ac6b1693a351230179f898979dd00bdf:

  powerpc/8xx: Fix kernel DTLB miss on dcbz (2024-10-11 15:53:06 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.12 #4

 - Fix crash in memcpy on 8xx due to dcbz workaround since recent changes.

Thanks to: Christophe Leroy.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/8xx: Fix kernel DTLB miss on dcbz


 arch/powerpc/kernel/head_8xx.S | 1 +
 1 file changed, 1 insertion(+)
-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRjvi15rv0TSTaE+SIF0oADX8seIQUCZwsDnwAKCRAF0oADX8se
IUiFAPwIQZD7X3Mpo3dgmVEJCGf+Nlk2ClikbZYQ4ylWKDt1GwEAplRpNFLhXioN
J1Jxc6kZ6s42alDWXfj0xVTo1/hsnwI=
=xWuO
-----END PGP SIGNATURE-----


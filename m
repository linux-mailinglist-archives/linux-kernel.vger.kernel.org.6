Return-Path: <linux-kernel+bounces-225910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C9E91374B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC191F2264C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 02:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6218E79DF;
	Sun, 23 Jun 2024 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MucHfsGs"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD9322E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719108457; cv=none; b=mpZYOwWV7ggcTXGZTye7mdG4pLGeh7B0wsfBZ+7E/c9eSj4sK4KnnC9kwmQYH6V2NKAwArM7Y3UOLK5yO33gVZPzcGpgwnROaKxNjkawXbjgaSYz2Dac7i5nnHeZhERNZE3vJEKh5b9F6gKiPsOsG1MEwF7bVEvETaGsJAlntTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719108457; c=relaxed/simple;
	bh=DL7ijj4f0JYdB7gx4ydP45fcJcjUOSJiftZ6sUEXcNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/XaevrC5oVVfFavYx9BuH2VH9zCQHtEXJ0rXcsHVNPtXOTyd+EbGb21+8DehQ9OUczxf0SOAzcs577MVg+XauULhLRJcapH6j5swtugHTUrCi1m4Ww4ywovFAZXfpNJoFNz2KP+ST+UckPi0nUfFRpQdPQuKfR1C0Tgd0PmBTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=MucHfsGs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719108451;
	bh=wjZLuNgx9By6ZqOtH117HEBJ1w7wnHQvmaXPVGYIMZc=;
	h=From:To:Cc:Subject:Date:From;
	b=MucHfsGsSlsy8pXHPmu849QMMmGwTUwAx0FD9y5+oYzCL5dRetg2UnjJkaT6LQep3
	 Z/fn3rR/oYPHhZ93WSFHzFx6EqMHlfYCluG0DuLME0o4ahRsQFwxL+CkQ+dqLQ+thc
	 Eiw6gU8ZZWjEQEtFmIcMhDIk3T3x1HIHTnr7QmYlK36swNcKf7isqo6cPXQGX/au10
	 5A86YS75PYtPmmJ3Ciopdfn3/6DYLyAHV4DaRCAdB8/jqoyiaCtVdFCX0oLfPQ6+U4
	 ZbMJ7tDNTLwoCtxNLB+pljkgL15xOCnVZY6pSAqtnBjFJRMzkClCH59vkqf7LuSQXB
	 o8alUAztcfQNQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W6Dxt3cBSz4wbh;
	Sun, 23 Jun 2024 12:07:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nathanl@linux.ibm.com, viro@zeniv.linux.org.uk
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.10-3 tag
Date: Sun, 23 Jun 2024 12:07:28 +1000
Message-ID: <87sex4csyn.fsf@mail.lhotse>
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

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-3

for you to fetch changes up to a986fa57fd81a1430e00b3c6cf8a325d6f894a63:

  KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group() (2024-06-16 10:20:11 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.10 #3

 - Prevent use-after-free in 64-bit KVM VFIO

 - Add generated Power8 crypto asm to .gitignore

Thanks to: Al Viro, Nathan Lynch.

- ------------------------------------------------------------------
Michael Ellerman (1):
      KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group()

Nathan Lynch (1):
      powerpc/crypto: Add generated P8 asm to .gitignore


 arch/powerpc/crypto/.gitignore   |  2 ++
 arch/powerpc/kvm/book3s_64_vio.c | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmZ3gucACgkQUevqPMjh
pYC25xAAsSnTIzbZpHdg3Bdb0vqdgzQimS9TbXGm5Qnea6rZawXYcSEoLuUABWZY
ZkNDoezJoL9nks7JGO1lbTICUNFKleFSlBLye4WgRn7NQBlgFP2GYiH1hXJIlE0C
qNyqY8k9uhJQor6CYt4eygskVwjpdX6oeIcHcUNWQy7/p1jID48DFS7QHib0WWm+
wwuiPhdqBwlbJCQUO0zBmDgg8rAhPmeGSR1iHWJxk69CIcEOoXK8sxv1ZTKuE0YN
clOKeAPrlZ3dz2jDojcMUzckFxg9J/Wlozk+m4LVl4XVj5hV7TqBpT4BVJNoMk1i
qWV00bVg7sEWXQ9CGR71NKpdeE4pIeiN4EAEkW+nSmlJ0x9htadNychode+9cakb
E0U/fb/rB6T32UJsEUAFF2Dq8dG5wWXHPqn0rHh9v63tPvnteUisSFM9DN7Be9a4
UziItFANSmt3AK0uvBMgoYk8HM2USLb4WvigWdqtW9j6AGmO5NYPl1PgrLCDkFBA
Feevx5TAIs6GeGKrzbE5s9QHMAwtVhsN1g8lJgbCPZJfh9wcynIyrPI4K/Vu5J9A
tpNbRXGsfk/MCsNF6kgm+pAoseavXUwjsSNteFwq7eMSqZUgeG5a1hx/36b5mHdW
+YANpMmzS3Ae2HscZ6E8xTGxzfmmWmr6SczN0i0lBCR5cjUo7Cw=
=oWyE
-----END PGP SIGNATURE-----


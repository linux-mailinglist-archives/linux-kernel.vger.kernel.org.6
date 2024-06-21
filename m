Return-Path: <linux-kernel+bounces-224344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D2791211F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B846D28155C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49C81AC6;
	Fri, 21 Jun 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpEEAGkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488342AA0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963213; cv=none; b=kgFn8dkixGoIhziKZ9bFPERjuMbflnlxEy/q7o7Pio4kH2dFBE922KOvfYMXPaWZa/ZZwKWwb4VrW/SBdv+j1fZVcKFlVeOZNMXP8l64nzconyMx8tvFvX1TkuQtiMA23aywCmnGU9UHFOCcS99QT+Jl3jQeBG6D9oxxPQC9MgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963213; c=relaxed/simple;
	bh=jKBzzFJgP4KGZzGVeyg+1aMf2D+AkSK2i7HSacskoWs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oUIxZGZKxFrKq0PFDT83q+pXMDPsnCyjmPTrDLONwhPOO+FTUI4ie4+TpNY7W+6TF8KYvi6k3nKFzyNkdMFcjQR/bOT13ina3bnWznlEWWCyuN6H64ii2HG7ZL2V1TJDicu1tgZFOfm8WvTBwhz37NL3cWLqnRcGaDzDO3A3mvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpEEAGkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54661C2BBFC;
	Fri, 21 Jun 2024 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718963212;
	bh=jKBzzFJgP4KGZzGVeyg+1aMf2D+AkSK2i7HSacskoWs=;
	h=Date:From:To:Cc:Subject:From;
	b=bpEEAGkKPvS3woD/fde1frxnhvxNw/jTA6ZZx4AJtZrYFJB/eYJM1itc6Df1Ve/Y2
	 z1b7aclAlvQ7R3EhVPmYcVFx/5iFMbH/CbIBkUMZ57C5MBeNTW26tZURx+Yiwq6FEz
	 jPg/i65bh90jKxf9ZuV7/iCZu+KFgQYhW5svNgmTJcKHz5c0wt/Rb8RjC9gW78oszh
	 4NjKAG+4evw9EJ7EZ81GguE0sgzALFYmHA7SxVyPNAXq+yUibNBaPNeplP28Zz5RQB
	 lD0irnWvn/3TSYiPnOtvFWstXaszYIiVqDQWq+1Vo5bRDtRZfUnXyhuAickaXdFdsy
	 ALeNAytRZbcEA==
Date: Fri, 21 Jun 2024 15:16:48 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire fixes for v6.10
Message-ID: <ZnVMCAG3F5JLdl5I@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PNvFnR5VwBpONmnf"
Content-Disposition: inline


--PNvFnR5VwBpONmnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive single fix for soundwire subsystem.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.10-fixes

for you to fetch changes up to e2d8ea0a066a6db51f31efd2710057271d685d2e:

  soundwire: fix usages of device_get_named_child_node() (2024-06-03 17:35:=
24 +0530)

----------------------------------------------------------------
soundwire fixes for 6.10

 - Single fix for calling fwnode_handle_put() on the
   returned fwnode pointer

----------------------------------------------------------------
Pierre-Louis Bossart (1):
      soundwire: fix usages of device_get_named_child_node()

 drivers/soundwire/amd_manager.c     |  3 +++
 drivers/soundwire/intel_auxdevice.c |  6 +++++-
 drivers/soundwire/mipi_disco.c      | 30 ++++++++++++++++++++++++------
 3 files changed, 32 insertions(+), 7 deletions(-)

--=20
~Vinod

--PNvFnR5VwBpONmnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmZ1TAgACgkQfBQHDyUj
g0cvug//TjZqGCsgeijXKVyhhrMKbf+SpZaRK+TboAtFnegzfAa/BkoGQsXxFNo4
b5+cQtxvVMl63vYZTeIdkvMFibCYgsyn+yfOIPCkgXmqKaHYKE0nqDDCRVf4UfRy
PJe3QtfN5l4X89oiOc+TLH4S/yVXP2NSoEbbmqgrmNG16KrwA40xKxDaRkmua4V7
/kiZUvYtn63Q6La6FIRQLQlHf3ENKCx83AD4tIOMOU+nKNY3xIyuEfegy30uvsGP
OCT8OFyZG9TsRnXlGd69PBMJkZogEf48cNXXHwwpkbTq+/mIBKl9Gs/sfotQ36eI
loFwMJbyQv1qHfHeFKtKAJaCxPPg0g2RqBR2I2Tl3GagXYWKWQALvLHSGw5gx7Ps
W/68Me0Wqyw1JqCD8Ba8Jnw+opLF8ENnjg1rFoXT6keW3MBAzaeXN6TpVnpdUEQ9
pgZ/NTdmKHNIwK8VjIgQPfDZmsLmPB/bQJYgUtVOyon1ro6P5BPByp8K3/39VEAq
raY71Bks26E4ys8kqCRsiSclxzQkhVwww7TQ+saA67nWn8r1SkS52O3mEPOsx0NG
332pSKrmv+72aTENa9KGMkCEgcDCK+PtSuPuvwXMmD37Kdjl/pIEmfTgXvMFBMiZ
BoCgP6PPRi3BRmDqIo3fsYCuwu4oqTqCIqD5/zwZrorHsbv3CqM=
=rcFK
-----END PGP SIGNATURE-----

--PNvFnR5VwBpONmnf--


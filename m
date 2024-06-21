Return-Path: <linux-kernel+bounces-224357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BCB91214A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B867928A001
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B348A16F90D;
	Fri, 21 Jun 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch4OYZr+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F816F8FD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963577; cv=none; b=pqMQ1lr9LqLti4vShWZtr1IKc4RodJVb8BxD1TqNYml19eSyk6KbizjvKt0SH3T71+vUMnGssN461+g4pgaDPmIvlaHqgBq5ZHxjaPiWydLfAVfpmH4HMCZY8Nc/k7WrmgIo1Nu9B5R+bxfIcUANg9gDZBRUz/JbiYgxIyao98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963577; c=relaxed/simple;
	bh=aRY+qgqUwiW2JOvEt+RUdinz7ixmJElWqRx1gZHJrqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WZrqELeAPj6Vs6xxUD4Tnf8vOFnwznTFAHkzXa8O+C85EgDpBFWPIosbP5AHBOZVgw8AhWZEi9KdasWGVFLzD9Ne+6aPib5FRor2YHSQafxrQQljI+5CXVbGKlIpG7MRUFGICycSMTRtBkoj6+RT/9/EDt8LHPY7GwX8SH/rwW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch4OYZr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041D4C4AF0A;
	Fri, 21 Jun 2024 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718963576;
	bh=aRY+qgqUwiW2JOvEt+RUdinz7ixmJElWqRx1gZHJrqQ=;
	h=Date:From:To:Cc:Subject:From;
	b=ch4OYZr+r0uq0iV1Ljp6JoG7LtkOQqe78xN25bITv1HgnnDk7g828yvZHtX0ZX2Z7
	 M6qX8LAReFAZqcjSOuUnlyG8Yb/ZxSsSqGIQud4A19q08FutaOWuqZtYyQqk9GmoZL
	 mWNYRK7IdaCGR2TMxTd/P/HSqa4hTNZYrd/KojE1wBn3zGPe7V0cyjxNRa9m2g9rg+
	 Yf+TefneKyYvHnH17Rn1vu4/FnuOf1tWfu1+T0wZCQnkcxQH6351MbSK0Ff2htLJCX
	 iypwVIldDL4DdAartJcI4pLwd3cbLTo7uQvH19QKPBEhZluNViMr4r0sLvgu0HRbVC
	 ANTByprG8xsRQ==
Date: Fri, 21 Jun 2024 15:22:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.10
Message-ID: <ZnVNdBGN49EjDfM_@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YsqsVmZDKh5QYdL9"
Content-Disposition: inline


--YsqsVmZDKh5QYdL9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Last one for the day, please pull to receiev few driver fixes for
dmaengine subsystem.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.10

for you to fetch changes up to 5422145d0b749ad554ada772133b9b20f9fb0ec8:

  dmaengine: ioatdma: Fix missing kmem_cache_destroy() (2024-06-11 23:39:26=
 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.10

Driver fixes for:
 - kmemleak, error path handling and missing kmem_cache_destroy() fixes
   for ioatdma driver
 - after use fix for idxd driver
 - data synchronisation fix for xdma isr handling
 - fsl driver channel constraints and linking two fsl module fixes

----------------------------------------------------------------
Arnd Bergmann (1):
      dmaengine: fsl-edma: avoid linking both modules

Krzysztof Kozlowski (1):
      dt-bindings: dma: fsl-edma: fix dma-channels constraints

Li RongQing (1):
      dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list

Louis Chauvet (1):
      dmaengine: xilinx: xdma: Fix data synchronisation in xdma_channel_isr=
()

Nikita Shubin (4):
      dmaengine: ioatdma: Fix leaking on version mismatch
      dmaengine: ioatdma: Fix error path in ioat3_dma_probe()
      dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
      dmaengine: ioatdma: Fix missing kmem_cache_destroy()

Siddharth Vadapalli (1):
      dmaengine: ti: k3-udma-glue: Fix of_k3_udma_glue_parse_chn_by_id()

 .../devicetree/bindings/dma/fsl,edma.yaml          |  4 +-
 drivers/dma/Kconfig                                |  2 +-
 drivers/dma/idxd/irq.c                             |  4 +-
 drivers/dma/ioat/init.c                            | 55 ++++++++++++------=
----
 drivers/dma/ti/k3-udma-glue.c                      |  5 +-
 drivers/dma/xilinx/xdma.c                          |  4 +-
 6 files changed, 39 insertions(+), 35 deletions(-)


--=20
~Vinod

--YsqsVmZDKh5QYdL9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmZ1TXQACgkQfBQHDyUj
g0egWBAA0gYNvMyBNJSdXJordRJc2GhLxMGYIAQ3hRNIa68olgJVkrGnFkn4Pb3k
OJVRpD4qg2BRCXGFkZYCj/jL+nHfOqPdHFwPXIvA+w0OeVvEz5MTrzIgOzTgeA/q
5fxSwkLftr4OdpxkZNNnzq7D+modXXE2pnHXHknXrbXiOk2fLjS47ZxkalUgg0JP
fr1CxiwUP83fOixW0LtMsi2Fcad0411unvI/yDmmGTPqnEwOzDJaT/XtyASJlB1c
3kEzzwVrm0ecO0Ve8rfxdFDFsbqMG5Tg+jHmAfWK7GMRbBaJAW19zqIg9M/DL0oj
igU4ZTe3puqJTOiaJ9MiSn0dgRR0B2yZW/TgSw8relyMADSuiosTSQa4xXF1BYXz
/Qo6SuZsT9Korcxzoyp6r4pHGVL7I5z3T6mmPp1ddy+r1WrPzi5eayGbxi78pgie
6lb6GKpkfIP7V/TocSoVl9wlmJmg5zR19cDvYFw6eqsN1a+nKgscPZ3FNHjQGZ93
BtJ+Q34ISpZjk3fvcGBwWNoV7JIPwsnoIpmAvNUA7QgjEv9ssJ+Zg70HIV+KvSlx
Awun/D4YODaThfUhz4lQ//eqJvkbBW853KxyEjji6CZcB5ZL9UX8HYmtVgM94IrX
1hsj91ty6PVDGmLEaNrw5eEfQ8EAi5kZGrrN1ac0599zoXgNVI0=
=mA1k
-----END PGP SIGNATURE-----

--YsqsVmZDKh5QYdL9--


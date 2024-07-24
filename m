Return-Path: <linux-kernel+bounces-260718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF92593AD5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27451C22068
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E474409;
	Wed, 24 Jul 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayGfvahP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8217F46B91
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807154; cv=none; b=abMvgKcknDpxLebcSz0TS5kRNd16LMKAz6UWNfms0d2vTPLy839IYzoA39Vb5paU5Kv5OCphqsHpV0+VJ02w7/b4HPcNBmrsQo76AkemPgbGkIbPEhFh2BxcljBZeFHDB3XouGLhdnxqyYdlK80zp6zwGR+hYDWB52/p2QZi86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807154; c=relaxed/simple;
	bh=1TI1fpzfc0L6zLg5Wh0c4bq/CVN32q1jt2EZOerbiFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qCCBSkx83CgQ0ssLkn8sH12mz4Qo8O+9CFXJKz/A9r15w7hTuyAoMDn0Q0mqQnf72aZ32BtrYjeM45E8cAD7YOe4+3GfkDfe3lYq0I8gcaN3Q+zgD5lahkXQ0rcuMzvEs/XMtxvraViSnkYPQ0ypUxBQ2j2ePDQwW2oxEVxdoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayGfvahP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE75C32782;
	Wed, 24 Jul 2024 07:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721807154;
	bh=1TI1fpzfc0L6zLg5Wh0c4bq/CVN32q1jt2EZOerbiFg=;
	h=Date:From:To:Cc:Subject:From;
	b=ayGfvahPhBsdZWIhmcCSTo918MWQogyWuAbcWWWVlEk2oOTcwQp1rbMRiSMSbksIE
	 V1taVCoXbjGdxbDJiRTtcX88306tu7INh8EI/q60BvE7YifBUKAlM1fv0is52sw9iP
	 BDVQ09mb8FksgARN8CupNbvIqE2MAVljK08y+rpiUCyo0zVQyVxnuDHRxipwe7gn6C
	 SdcKld03Nzn6Zw4wuJGTYr57WWwKQgr3lULPHNJcHZ59pMjq4bHtOH7nWG7F33GicL
	 bxKNFJul3M49iM84lXxieJAWwzU6oVG9rHbanXWYZN3Y0tp3A4fR6PT8FIGxzWKr7b
	 qXGvcDT+AnPUw==
Date: Wed, 24 Jul 2024 13:15:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.11
Message-ID: <ZqCxLa9FL9iXFOFz@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fRE79iUECku18urW"
Content-Disposition: inline


--fRE79iUECku18urW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive dmaengine updates for this cycle. A new dmaengine
API with its user is the key feature of this request along with yaml
conversion and updates to bunch of drivers.

Please note that the tag dmaengine_topic_dma_vec was pulled into the iio
tree so you might have recieved that or might receive it from iio
people.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.11-rc1

for you to fetch changes up to b8ec9dba02a74797421c52b1226b23a4302362a6:

  dt-bindings: fsl-qdma: fix interrupts 'if' check logic (2024-07-10 15:42:=
40 +0530)

----------------------------------------------------------------
dmaengine updates for v6.11

 New support:
  - New dmaengine_prep_peripheral_dma_vec() to support transfers using dma
    vectors and documentation and user in AXI dma
  - STMicro STM32 DMA3 support and new capabilities of cyclic dma

 Updates:
  - Yaml conversion for Freescale imx dma and qdma bindings, sprd sc9860 dma
    binding
  - Altera msgdma updates for descriptor management

----------------------------------------------------------------
Amelie Delaunay (11):
      dt-bindings: dma: New directory for STM32 DMA controllers bindings
      dmaengine: stm32: New directory for STM32 DMA controllers drivers
      MAINTAINERS: Add entry for STM32 DMA controllers drivers and document=
ation
      dt-bindings: dma: Document STM32 DMA3 controller bindings
      dmaengine: Add STM32 DMA3 support
      dmaengine: stm32-dma3: add DMA_CYCLIC capability
      dmaengine: stm32-dma3: add DMA_MEMCPY capability
      dmaengine: stm32-dma3: add device_pause and device_resume ops
      dmaengine: stm32-dma3: improve residue granularity
      dmaengine: add channel device name to channel registration
      dmaengine: stm32-dma3: defer channel registration to specify channel =
name

Animesh Agarwal (1):
      dt-bindings: dma: fsl,imx-dma: Convert to dtschema

Biju Das (1):
      dmaengine: sh: rz-dmac: Fix lockdep assert warning

Dan Carpenter (1):
      dmaengine: qcom: gpi: clean up the IRQ disable/enable in gpi_reset_ch=
an()

Dr. David Alan Gilbert (2):
      dmaengine: moxart-dma: remove unused struct 'moxart_filter_data'
      dmaengine: qcom: gpi: remove unused struct 'reg_info'

Frank Li (4):
      dmaengine: fsl-edma: request per-channel IRQ only when channel is all=
ocated
      dmaengine: fsl-edma: remove redundant "idle" field from fsl_chan
      dt-bindings: fsl-qdma: Convert to yaml format
      dt-bindings: fsl-qdma: fix interrupts 'if' check logic

Jeff Johnson (6):
      dmaengine: add missing MODULE_DESCRIPTION() macros
      dmaengine: qcom: add missing MODULE_DESCRIPTION() macros
      dmaengine: virt-dma: add missing MODULE_DESCRIPTION() macro
      dmaengine: ti: cppi41: add missing MODULE_DESCRIPTION() macro
      dmaengine: ti: add missing MODULE_DESCRIPTION() macros
      dmaengine: fsl-dpaa2-qdma: add missing MODULE_DESCRIPTION() macro

Joy Zou (1):
      dmaengine: fsl-edma: change the memory access from local into remote =
mode in i.MX 8QM

Krzysztof Kozlowski (1):
      dmaengine: ti: k3-udma: fix module autoloading

Lucas Stach (2):
      firmware: add nowarn variant of request_firmware_nowait()
      dmaengine: imx-sdma: don't print warning when firmware is absent

Olivier Dautricourt (3):
      dmaengine: altera-msgdma: use irq variant of spin_lock/unlock while i=
nvoking callbacks
      dmaengine: altera-msgdma: cleanup after completing all descriptors
      dmaengine: altera-msgdma: properly free descriptor in msgdma_free_des=
criptor

Paul Cercueil (3):
      dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
      dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
      Documentation: dmaengine: Document new dma_vec API

Stanislav Jakubek (1):
      dt-bindings: dma: sprd,sc9860-dma: convert to YAML

Vignesh Raghavendra (1):
      dmaengine: ti: k3-udma: Fix BCHAN count with UHC and HC channels

Vinod Koul (1):
      Merge tag 'dmaengine_topic_dma_vec' into next

 .../devicetree/bindings/dma/fsl,imx-dma.yaml       |   56 +
 .../devicetree/bindings/dma/fsl-imx-dma.txt        |   50 -
 Documentation/devicetree/bindings/dma/fsl-qdma.txt |   58 -
 .../devicetree/bindings/dma/fsl-qdma.yaml          |  132 ++
 .../devicetree/bindings/dma/sprd,sc9860-dma.yaml   |   92 +
 Documentation/devicetree/bindings/dma/sprd-dma.txt |   44 -
 .../bindings/dma/{ =3D> stm32}/st,stm32-dma.yaml     |    4 +-
 .../bindings/dma/stm32/st,stm32-dma3.yaml          |  135 ++
 .../bindings/dma/{ =3D> stm32}/st,stm32-dmamux.yaml  |    4 +-
 .../bindings/dma/{ =3D> stm32}/st,stm32-mdma.yaml    |    4 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |    2 +-
 Documentation/driver-api/dmaengine/client.rst      |    9 +
 Documentation/driver-api/dmaengine/provider.rst    |   10 +
 MAINTAINERS                                        |    9 +
 drivers/base/firmware_loader/main.c                |  106 +-
 drivers/dma/Kconfig                                |   34 +-
 drivers/dma/Makefile                               |    4 +-
 drivers/dma/altera-msgdma.c                        |   16 +-
 drivers/dma/dma-axi-dmac.c                         |   40 +
 drivers/dma/dmaengine.c                            |   16 +-
 drivers/dma/dmatest.c                              |    1 +
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c                |    1 +
 drivers/dma/fsl-edma-common.c                      |   24 +-
 drivers/dma/fsl-edma-common.h                      |    4 +-
 drivers/dma/fsl-edma-main.c                        |   34 +-
 drivers/dma/idxd/dma.c                             |    2 +-
 drivers/dma/idxd/init.c                            |    1 +
 drivers/dma/imx-sdma.c                             |    5 +-
 drivers/dma/ioat/init.c                            |    1 +
 drivers/dma/mcf-edma-main.c                        |    2 -
 drivers/dma/moxart-dma.c                           |    5 -
 drivers/dma/qcom/gpi.c                             |   11 +-
 drivers/dma/qcom/hidma.c                           |    1 +
 drivers/dma/qcom/hidma_mgmt.c                      |    1 +
 drivers/dma/sh/rz-dmac.c                           |    2 +-
 drivers/dma/stm32/Kconfig                          |   47 +
 drivers/dma/stm32/Makefile                         |    5 +
 drivers/dma/{ =3D> stm32}/stm32-dma.c                |    2 +-
 drivers/dma/stm32/stm32-dma3.c                     | 1847 ++++++++++++++++=
++++
 drivers/dma/{ =3D> stm32}/stm32-dmamux.c             |    0
 drivers/dma/{ =3D> stm32}/stm32-mdma.c               |    2 +-
 drivers/dma/ti/cppi41.c                            |    1 +
 drivers/dma/ti/k3-psil.c                           |    1 +
 drivers/dma/ti/k3-udma-glue.c                      |    1 +
 drivers/dma/ti/k3-udma.c                           |    6 +-
 drivers/dma/ti/omap-dma.c                          |    1 +
 drivers/dma/virt-dma.c                             |    1 +
 include/linux/dmaengine.h                          |   36 +-
 include/linux/firmware.h                           |   12 +
 49 files changed, 2592 insertions(+), 290 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/sprd,sc9860-dma.y=
aml
 delete mode 100644 Documentation/devicetree/bindings/dma/sprd-dma.txt
 rename Documentation/devicetree/bindings/dma/{ =3D> stm32}/st,stm32-dma.ya=
ml (97%)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32/st,stm32-dm=
a3.yaml
 rename Documentation/devicetree/bindings/dma/{ =3D> stm32}/st,stm32-dmamux=
=2Eyaml (90%)
 rename Documentation/devicetree/bindings/dma/{ =3D> stm32}/st,stm32-mdma.y=
aml (96%)
 create mode 100644 drivers/dma/stm32/Kconfig
 create mode 100644 drivers/dma/stm32/Makefile
 rename drivers/dma/{ =3D> stm32}/stm32-dma.c (99%)
 create mode 100644 drivers/dma/stm32/stm32-dma3.c
 rename drivers/dma/{ =3D> stm32}/stm32-dmamux.c (100%)
 rename drivers/dma/{ =3D> stm32}/stm32-mdma.c (99%)


--=20
~Vinod

--fRE79iUECku18urW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmagsS0ACgkQfBQHDyUj
g0fgQhAAjRuTDIRV8uazVkPT7HeuWXNapu8CA7z8BnAHKD49YSfO3JD0C+vymrIE
ly6a4G+4tssVa2xOFPzLuol1+umVI9xPqpoII4X3zQRgIxqUGEi7p/bQUC64EuLb
gVWGJmd2RpE+jq6cy7DshR2ha2BVfuiz62kptb7lCjGZ/PrDkkWTFsozm+kH9u8f
jrExdufi8CbSk4fRBPIv+W6FuoNhLLgcjkz1aBhPsrqvP1FKoOprouDpD8eu4A0I
O8IOqe1uSTscGoDD0q2w1ojkr7ZHzQhanvIfDUgVTb9/p5cwUjGj9y1kaHHRzv3G
NBr5jXyg9IfA3MjpBnM2stc/RpR1bDi09vyyf2OmJJW+qtYc+uHZ5ATjjUHRE60E
167sFob2S02AU58unN8p+oo1WOR0+rJcDkC3GumBecz8uaVUTLlhylLc4XlU4q8H
HVDYwGnppUYDmzkt9tcD2OK6SoeqkuPbflk7946ergyZ8VRrL5OdgFA39P70I0Ah
reeaOuMJKgKfJ6T1p85YqCp3uI5ab3jZKw8h7E7h1KOs7dLMmFHs48sfknGadke9
5DxTzSFnw+znR9941/2teC1UZcZ8gKRFj0er8FS9D+oEYziwslv7z6WEMlYxleGA
CZH2mLpfZS2NzyvrESAw6k/AFn6PdHWbj/sXc7kGhJBu8gcNs+g=
=5906
-----END PGP SIGNATURE-----

--fRE79iUECku18urW--


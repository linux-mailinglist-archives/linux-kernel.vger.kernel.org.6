Return-Path: <linux-kernel+bounces-184568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987248CA8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC972811CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F155D50277;
	Tue, 21 May 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIwUPfqh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C017BA4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276658; cv=none; b=ahunwdGE0U52qlnCUIkvXdG1mFn4y6Jbve/FMPtpJMC0tn2sd/raerZWg1Kx/nQ+cEmxNZtTeDaEsHEfNsy+lnfsmtl6ziO44XRPx3Se8tXoOAgZuFWE9dUK6ghnaPur0NhndHfVs+A3GcOlRktfoZfkE2XnB3yw9jIuHsOxdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276658; c=relaxed/simple;
	bh=SnF23GOaDcRK71+h88Eqd4LUvUO/WlsaCrWdu7H+bpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WBvwBl3fMAYG4TQ3Dpcc8wHDVDfHZGICs82ouUyGdNMkhBUSMxqPe4xihDYq6e0Ua0UkRJ8BpOzbaRU3AIUDrNWHMFrGhlkSe7zB6PVdTSCm8L5YzoIxuWmF79/RC1qtVISE5TwzCYnybGyU+7+UDYHMVshIK+eUfY6Jm/vVoJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIwUPfqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167FEC2BD11;
	Tue, 21 May 2024 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716276657;
	bh=SnF23GOaDcRK71+h88Eqd4LUvUO/WlsaCrWdu7H+bpE=;
	h=Date:From:To:Cc:Subject:From;
	b=aIwUPfqhXrQA/EwlL1vanNfFaANsQFEn92+tk3dgok+YDiqEilcvL7FXrLPjhJYgZ
	 WsT9dLxFEZIrU6dkF0DRgy3gpvlcexDjGuxqntsOfs20o3TqcrWAIO8n/Elyj/VwvP
	 ePkt/+8vrmHAsI/AAjCiBf4AjTURZqxGJLgS4w4W9bgjVaoyUK7kVlqZ6CiOfwdOZN
	 DKq2MR4IoamdhZ+9R6+sNOyD3K89alRX2lNHlPsWKppU1keT0R7BxQtInGTwfLKBZi
	 sb1470vNfnOhjuxNadUxp5x5+/HDpMJHU93alR2mE9ibpTGaEeIjf8xU3saeCFv2fB
	 IuYhWZRkNlFDg==
Date: Tue, 21 May 2024 13:00:53 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.10
Message-ID: <ZkxNrbkVaSGSWSA_@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QXtt0r7IPz6BO5L0"
Content-Disposition: inline


--QXtt0r7IPz6BO5L0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Back from Linaro Connect, time to send the pull requests. Here is the
first one for dmaengine subsystem.
This one has couple of new device support and updates in drivers

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.10-rc1

for you to fetch changes up to 28059ddbee0eb92730931a652e16a994499a7858:

  MAINTAINERS: Update role for IDXD driver (2024-05-04 18:13:33 +0530)

----------------------------------------------------------------
dmaengine updates for v6.10

 New support:
  - Freescale i.MX8ULP edma support in edma driver
  - StarFive JH8100 DMA support in Synopsis axi-dmac driver

 Updates:
 - Tracing support for freescale edma driver, updates to dpaa2 driver
 - Remove unused QCom hidma DT support
 - Support for i2c dma in imx-sdma
 - Maintainers update for idxd and edma drivers

----------------------------------------------------------------
Baruch Siach (1):
      dma: dw-axi-dmac: support per channel interrupt

Chen Ni (1):
      dmaengine: idma64: Add check for dma_set_max_seg_size

Colin Ian King (1):
      dmaengine: pch_dma: remove unused function chan2parent

Dave Jiang (1):
      MAINTAINERS: Update role for IDXD driver

Erick Archer (1):
      dmaengine: pl08x: Use kcalloc() instead of kzalloc()

Fenghua Yu (1):
      dmaengine: idxd: Avoid unnecessary destruction of file_ida

Frank Li (15):
      dmaengine: fsl-edma: remove 'slave_id' from fsl_edma_chan
      dmaengine: fsl-edma: add safety check for 'srcid'
      dmaengine: fsl-edma: clean up chclk and FSL_EDMA_DRV_HAS_CHCLK
      dmaengine: fsl-dpaa2-qdma: clean up unused macro
      dmaengine: fsl-dpaa2-qdma: Remove unused function dpdmai_create()
      dmaengine: fsl-dpaa2-qdma: Add dpdmai_cmd_open
      dmaengine: fsl-edma: fix miss mutex unlock at an error return path
      dmaengine: fsl-dpaa2-qdma: Update DPDMAI interfaces to version 3
      dt-bindings: fsl-imx-sdma: Add I2C peripheral types ID
      dmaengine: imx-sdma: utilize compiler to calculate ADDRS_ARRAY_SIZE_V=
<n>
      dmaengine: fsl-dpaa2-qdma: Fix kernel-doc check warning
      dt-bindings: dma: fsl-edma: remove 'clocks' from required
      dt-bindings: dma: fsl-edma: allow 'power-domains' property
      dmaengine: fsl-edma: add trace event support
      dmaengine: fsl-edma: use _Generic to handle difference type

Jerry Snitselaar (1):
      dmaengine: idxd: Check for driver name match before sva user feature

Joao Pinto (1):
      Avoid hw_desc array overrun in dw-axi-dmac

Joy Zou (4):
      dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma compatible string
      dmaengine: fsl-edma: add i.MX8ULP edma support
      dmaengine: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible str=
ing
      dt-bindings: fsl-dma: fsl-edma: clean up unused "fsl,imx8qm-adma" com=
patible string

Krzysztof Kozlowski (1):
      dmaengine: xilinx: xdma: fix module autoloading

Manivannan Sadhasivam (1):
      MAINTAINERS: Drop Gustavo Pimentel as EDMA Reviewer

Nicolin Chen (1):
      dmaengine: imx-sdma: Support allocate memory from internal SRAM (iram)

Nuno Sa (2):
      dmaengine: axi-dmac: fix possible race in remove()
      dmaengine: axi-dmac: move to device managed probe

Rob Herring (1):
      dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width schema

Rob Herring (Arm) (2):
      dmaengine: qcom: Drop hidma DT support
      dt-bindings: dma: Drop unused QCom hidma binding

Robin Gong (1):
      dmaengine: imx-sdma: Add i2c dma support

Sean Anderson (2):
      dma: xilinx_dpdma: Remove unnecessary use of irqsave/restore
      dma: Add lockdep asserts to virt-dma

Shengjiu Wang (2):
      dmaengine: imx-sdma: Support 24bit/3bytes for sg mode
      dmaengine: imx-sdma: support dual fifo for DEV_TO_DEV

Tan Chun Hau (2):
      dt-bindings: dma: snps,dw-axi-dmac: Add JH8100 support
      dmaengine: dw-axi-dmac: Add support for StarFive JH8100 DMA

 .../devicetree/bindings/dma/fsl,edma.yaml          | 139 ++++++++++++++---=
----
 .../devicetree/bindings/dma/fsl,imx-sdma.yaml      |   1 +
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  95 --------------
 .../bindings/dma/snps,dma-spear1340.yaml           |  42 +++----
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  |   1 +
 MAINTAINERS                                        |   3 +-
 drivers/dma/Makefile                               |   6 +-
 drivers/dma/amba-pl08x.c                           |   4 +-
 drivers/dma/dma-axi-dmac.c                         |  78 +++++-------
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  38 ++++--
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |   3 +-
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |  14 +--
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h            |   5 +-
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c                | 113 +++++++----------
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h                |  61 +++++----
 drivers/dma/fsl-edma-common.c                      |  25 ++--
 drivers/dma/fsl-edma-common.h                      | 110 ++++++++--------
 drivers/dma/fsl-edma-main.c                        |  50 +++++---
 drivers/dma/fsl-edma-trace.c                       |   4 +
 drivers/dma/fsl-edma-trace.h                       | 132 +++++++++++++++++=
++
 drivers/dma/idma64.c                               |   4 +-
 drivers/dma/idxd/cdev.c                            |  18 +--
 drivers/dma/imx-sdma.c                             |  97 +++++++++++---
 drivers/dma/mcf-edma-main.c                        |   4 +-
 drivers/dma/pch_dma.c                              |   5 -
 drivers/dma/qcom/hidma.c                           |  11 --
 drivers/dma/qcom/hidma_mgmt.c                      | 109 +---------------
 drivers/dma/virt-dma.h                             |  10 ++
 drivers/dma/xilinx/xdma.c                          |   1 +
 drivers/dma/xilinx/xilinx_dpdma.c                  |  10 +-
 include/linux/dma/imx-dma.h                        |   1 +
 31 files changed, 620 insertions(+), 574 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.t=
xt
 create mode 100644 drivers/dma/fsl-edma-trace.c
 create mode 100644 drivers/dma/fsl-edma-trace.h

--=20
~Vinod

--QXtt0r7IPz6BO5L0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmZMTa0ACgkQfBQHDyUj
g0dtABAApJwuJgEKic6pOOEVlce1+m/njin7L2IGCbpzkpT3uC3RMMTUudCe7PmM
1JyeyE7vXdMsia1tXOt0GJlUNyq2Bzyg4QNiL/DGocXV+aiKtO4tn+q5aeR5I02t
ZDgeUhErDCAVWULeNh6dZicHwmzRtEVJksNyrB2oJzLHv6GI4QK/DZOfp2QSVequ
AC+J0K+M6bn6kkBhUT1gqIztZfXgId/Db0wJBeFp9zxE4+ZtWquBPPRg0G1STnwu
EOssmHGC6v/06e3TwQD244VdSyqXbiVVi30NjyifH5YZhfSQlzZ52UD+WvtBZAq5
XrzED7foJemfIf266CLQiR4/Ow21owUZ774a58IiW4rC+EPbjr6XEIbVrXrxPvVz
rZUTimiTB53RVZV57v4A0NSzdsFC/B5NLa8SwYJLrFs9HdyFGTJvU2LvPQnMTKZn
Qo9fjjD+PtbkGsGeeCkQn9F+0XMock+jQQKvy1sLuWD3jF5bJQY39pTyyjStFzME
zOXsF8eO8Jy7W69AMV9xTCoSNj26L7rQlzMpteG+fqsZLUEG77T47m5ZWsxTNJRX
XRZQMwvYEfQ02S7xodZViMRdb9iMQtqFvqxisQFY1jJ724hbYFPpgEjuSiiX2+1T
qJ3av9YZUd615B2XEuib9RC3Fku52D6mJd+1NquweD/BlRxnBbc=
=B8tC
-----END PGP SIGNATURE-----

--QXtt0r7IPz6BO5L0--


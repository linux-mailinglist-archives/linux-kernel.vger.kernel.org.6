Return-Path: <linux-kernel+bounces-312228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5349693CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC701B22841
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1321D319D;
	Tue,  3 Sep 2024 06:36:46 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D182E3EB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345405; cv=none; b=U6OZN6spka2c/Zd38l/aE4JxwRvHUvKQCcRB+wo9QtXg4A6r5gLBhkWuWJtbkrfePuUAalVJn4YdlCZ9b4sXD/vQzjYzj7otOzNNLVNJomKtLkyGeMYDPCFEX7WmEilxBVlYSvAg+kCO+VhsUqjuWAGax+jdeM7YdUQAXN9UeGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345405; c=relaxed/simple;
	bh=yg24vRONR2mLZ0z7yDQa4hEfXzegR5chkg8PG+m4V7E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=L93qamBWMdKK4VSkV3B2MaJ/wABDeD/DCQccvcQWlGmorJqiGzmeNd1aAnjnNnKKvBpZjr6RjhLs/DyGjHh+s6gXipLhtgygV4KtSQwN/7+FHlflL2KXnLyy34DBsmHdvCntAGqLfObv1dMuDz5b9DFNumJWV6Vs+VZPza1DCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WybWF5HjZz9sSH;
	Tue,  3 Sep 2024 08:36:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PdnbsYL7xth; Tue,  3 Sep 2024 08:36:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WybWF4Jw0z9sSC;
	Tue,  3 Sep 2024 08:36:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 822B98B76E;
	Tue,  3 Sep 2024 08:36:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 8n4_MCluhO-u; Tue,  3 Sep 2024 08:36:41 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4EAAC8B768;
	Tue,  3 Sep 2024 08:36:41 +0200 (CEST)
Message-ID: <326d9a7d-7674-4c28-aa40-dd2c190244dd@csgroup.eu>
Date: Tue, 3 Sep 2024 08:36:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [GIT PULL] SOC FSL for 6.12 (retry)
To: soc@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Herve Codina <herve.codina@bootlin.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Language: fr-FR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arnd,

Please pull the following Freescale Soc Drivers changes for 6.12

There are no conflicts with latest linux-next tree.

Thanks
Christophe

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

   https://github.com/chleroy/linux.git tags/soc_fsl-6.12-2

for you to fetch changes up to 7a99b1c0bce5cf8c554ceecd29ad1e8085557fd3:

   Merge branch 'support-for-quicc-engine-tsa-and-qmc' (2024-09-03 
07:51:34 +0200)

----------------------------------------------------------------
- A series from HervÃ© Codina that bring support for the newer version
of QMC (QUICC Multi-channel Controller) and TSA (Time Slots Assigner)
found on MPC 83xx micro-controllers.

- Misc changes for qbman freescale drivers for removing a redundant
warning and using iommu_paging_domain_alloc()

----------------------------------------------------------------
Christophe Leroy (1):
       Merge branch 'support-for-quicc-engine-tsa-and-qmc'

Herve Codina (36):
       soc: fsl: cpm1: qmc: Update TRNSYNC only in transparent mode
       soc: fsl: cpm1: qmc: Enable TRNSYNC only when needed
       soc: fsl: cpm1: tsa: Fix tsa_write8()
       soc: fsl: cpm1: tsa: Use BIT(), GENMASK() and FIELD_PREP() macros
       soc: fsl: cpm1: tsa: Fix blank line and spaces
       soc: fsl: cpm1: tsa: Add missing spinlock comment
       dt-bindings: soc: fsl: cpm_qe: Add QUICC Engine (QE) TSA controller
       soc: fsl: cpm1: tsa: Remove unused registers offset definition
       soc: fsl: cpm1: tsa: Use ARRAY_SIZE() instead of hardcoded 
integer values
       soc: fsl: cpm1: tsa: Make SIRAM entries specific to CPM1
       soc: fsl: cpm1: tsa: Introduce tsa_setup() and its CPM1 
compatible version
       soc: fsl: cpm1: tsa: Isolate specific CPM1 part from 
tsa_serial_{dis}connect()
       soc: fsl: cpm1: tsa: Introduce tsa_version
       soc: fsl: cpm1: tsa: Add support for QUICC Engine (QE) implementation
       MAINTAINERS: Add QE files related to the Freescale TSA controller
       soc: fsl: cpm1: tsa: Introduce tsa_serial_get_num()
       soc: fsl: cpm1: qmc: Rename QMC_TSA_MASK
       soc: fsl: cpm1: qmc: Use BIT(), GENMASK() and FIELD_PREP() macros
       soc: fsl: cpm1: qmc: Fix blank line and spaces
       soc: fsl: cpm1: qmc: Remove unneeded parenthesis
       soc: fsl: cpm1: qmc: Fix 'transmiter' typo
       soc: fsl: cpm1: qmc: Add missing spinlock comment
       dt-bindings: soc: fsl: cpm_qe: Add QUICC Engine (QE) QMC controller
       soc: fsl: cpm1: qmc: Introduce qmc_data structure
       soc: fsl: cpm1: qmc: Re-order probe() operations
       soc: fsl: cpm1: qmc: Introduce qmc_init_resource() and its CPM1 
version
       soc: fsl: cpm1: qmc: Introduce qmc_{init,exit}_xcc() and their 
CPM1 version
       soc: fsl: cpm1: qmc: Rename qmc_chan_command()
       soc: fsl: cpm1: qmc: Handle RPACK initialization
       soc: fsl: cpm1: qmc: Rename SCC_GSMRL_MODE_QMC
       soc: fsl: cpm1: qmc: Introduce qmc_version
       soc: fsl: qe: Add resource-managed muram allocators
       soc: fsl: qe: Add missing PUSHSCHED command
       soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementation
       soc: fsl: cpm1: qmc: Handle QUICC Engine (QE) soft-qmc firmware
       MAINTAINERS: Add QE files related to the Freescale QMC controller

Lu Baolu (1):
       soc: fsl: qbman: Use iommu_paging_domain_alloc()

Xiaolei Wang (1):
       soc: fsl: qbman: Remove redundant warnings

  .../bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml        | 210 +++++++
  .../bindings/soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml    | 197 ++++++
  MAINTAINERS                                        |   3 +
  drivers/soc/fsl/qbman/qman_ccsr.c                  |   2 -
  drivers/soc/fsl/qbman/qman_portal.c                |   5 +-
  drivers/soc/fsl/qe/Kconfig                         |  18 +-
  drivers/soc/fsl/qe/qe_common.c                     |  80 +++
  drivers/soc/fsl/qe/qmc.c                           | 667 
++++++++++++++++-----
  drivers/soc/fsl/qe/tsa.c                           | 659 
+++++++++++++++-----
  drivers/soc/fsl/qe/tsa.h                           |   3 +
  include/dt-bindings/soc/qe-fsl,tsa.h               |  13 +
  include/soc/fsl/qe/qe.h                            |  23 +-
  12 files changed, 1552 insertions(+), 328 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml
  create mode 100644 
Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml
  create mode 100644 include/dt-bindings/soc/qe-fsl,tsa.h


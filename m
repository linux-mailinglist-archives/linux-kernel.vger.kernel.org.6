Return-Path: <linux-kernel+bounces-205646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083968FFE6B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C776B238CF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2C15B15C;
	Fri,  7 Jun 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="F2pzSoWj"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DA615B150
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750284; cv=none; b=VhlXSB3UY+JfpP6IvvFprHX7m5MNW7Jae/bVPcP4tjeS4rRAMjAlP7TmTsu168+SCPBJ2WHkmFPEJ/j8Ex1rT8scghJDIN+SyTqrLKjnQpDNAOsFG5zB4RXt2G8Lrkkvw3FxXAvcf40xJ4vSe7YfulvdJ0J9Y93zI4JyXRlAdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750284; c=relaxed/simple;
	bh=20qPAHxgHw2m0YF3MooU4EHuwN7JhQ7wiuoPVIhylLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sBwt/d+SkSpPIJZNWf1cVNBI7gvY+QO9bcemcVr/meU+W6blIUXBBt6P1LJ7R52PmRXGK/qqOYlzP0RkdG2+RsQwTlHRirQtaZhL1y8F9xOdm2PnN6Ybtkumro+BuDn+UBj0IK7LA5O+TBe2ezgrMIrU5HLX1MpXUvMQmXN2NrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=F2pzSoWj; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 61B311C7D6A;
	Fri,  7 Jun 2024 10:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717750275;
	bh=20qPAHxgHw2m0YF3MooU4EHuwN7JhQ7wiuoPVIhylLA=;
	h=Date:From:To:Cc:Subject:From;
	b=F2pzSoWjkIcu6FUPws3u9UC95Z9Ei8YVejgkOXIXsW6LWoxrUCgur/HVGLyduwNvu
	 CX53t/kYOoPHMKntfyPKA44ncpYdmXNFUQXoDgKiwAL+t4qHp3fbG8qP2PW/bDBaPz
	 PaUIR6ug+QjbcXOmVS9LvqFX/iBe4XmgLZzfaov+RCEAFdPH8rHRqcw8TC4yuVS+Bc
	 Ammy+F81XjFp4YkSL4OYNsZ0wyEklN9A/dJ+Zj6MpVPRLfEKrfDEeMaeAql11wW1Cb
	 bBI0K0xmQskX5lAnoA86kLTU26/cmarU+fSF3uvNqyPA4Xj4/Vdx6NPLUxndi3MkcK
	 NXOKYOIbKxUsg==
Date: Fri, 7 Jun 2024 10:51:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.10-rc2
Message-ID: <ZmLKAr7RYbL_wP3F@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.10-rc2

for you to fetch changes up to 526606b0a1998b0791b42c199d53550c3ba724b5:

  iommu/amd: Fix Invalid wait context issue (2024-06-04 14:00:59 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.10-rc2

Including:

	- Core:
	  - Make iommu-dma code recognize 'force_aperture' again
	  - Fix for potential NULL-ptr dereference from iommu_sva_bind_device()
	    return value

	- AMD IOMMU fixes:
	  - Fix lockdep splat for invalid wait context
	  - Add feature bit check before enabling PPR
	  - Make workqueue name fit into buffer
	  - Fix memory leak in sysfs code

----------------------------------------------------------------
Kun(llfl) (1):
      iommu/amd: Fix sysfs leak in iommu init

Lu Baolu (1):
      iommu: Return right value in iommu_sva_bind_device()

Robin Murphy (1):
      iommu/dma: Fix domain init

Vasant Hegde (3):
      iommu/amd: Fix workqueue name
      iommu/amd: Check EFR[EPHSup] bit before enabling PPR
      iommu/amd: Fix Invalid wait context issue

 drivers/iommu/amd/amd_iommu.h |  3 ++-
 drivers/iommu/amd/init.c      |  9 ++++++++
 drivers/iommu/amd/iommu.c     | 48 +++++++++++++++++++++----------------------
 drivers/iommu/amd/ppr.c       | 25 +++++-----------------
 drivers/iommu/dma-iommu.c     |  8 ++++----
 include/linux/iommu.h         |  2 +-
 6 files changed, 45 insertions(+), 50 deletions(-)

Please pull.

Thanks,

	Joerg


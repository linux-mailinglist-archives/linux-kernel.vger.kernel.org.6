Return-Path: <linux-kernel+bounces-175606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60C8C2278
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA361F2227D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7DD16C69C;
	Fri, 10 May 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="aAjLnxGq"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618CF15EFD6
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338239; cv=none; b=OzyykmL4pFJpZLZDzyeUx9vMk/JZizfGUb6G6o0dMmw761BLL0h1cvvKYIva1WyaAvFErJsPj275zoxRDYp+onsSpkHPVksox3cwxuPo1D/FX/HBbqIsOusLBlnMqwcnIheW/SoAPK1OVKEsd2rVHv03gKs0yExW3hgTVBkKDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338239; c=relaxed/simple;
	bh=r97e7uhR/Kfrrnx7lqzxjaL+lDzyA1QpoWxvjKLPYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X8YUlLUrI85puoOJMMNqv7KGm/sy50Xqs4kmQkESVICYBGuRfDuINokheSbnMtZ0O3ItLd5ImhyYp0Q54cx1VGk+y5rHwuVzMXsXz/TSJiio5VnAFeRYZoIpBZ8Ux5rC6IigY0Sk02nfZa2P/zHS7OLaJ4cgMf8RFRg37DjfOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=aAjLnxGq; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 06AB01C45FB;
	Fri, 10 May 2024 12:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1715338235;
	bh=r97e7uhR/Kfrrnx7lqzxjaL+lDzyA1QpoWxvjKLPYF0=;
	h=Date:From:To:Cc:Subject:From;
	b=aAjLnxGq+JXzDWHlJB9shqiehp03uSY9q3D8F8gK4B5p2ahV4D7Z5DZeOwwtD5OYI
	 0gsc8bXrPkhUnvJr35U2HHmsV9Br2P2KJ82yVcJcgJcGFQjc1UGXp30++FD+PFfI8V
	 PzSdQQLvuU6Tr9RnqJiKuTdmGrSz3JprQH1Ozp/tj7YAqQml7pU1krbiu7FvcQI3kU
	 29bJefUbzE8TVp0nRKh5pGm4eKFYUMecD2J/Kx0DRwqhGpUl5kjw6sFd6HTLB+qYR/
	 Il3q6sR7CjDkjv2WH79bIrBebVEHLy5OWrGQmAftUDW4Qkszp1+YX2ONssyp+K9wJ9
	 JTFnMKon274Yg==
Date: Fri, 10 May 2024 12:50:33 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.9-rc5
Message-ID: <Zj37-X8iMR81fNZa@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc7

for you to fetch changes up to 65ade5653f5ab5a21635e51d0c65e95f490f5b6f:

  iommu/arm-smmu: Use the correct type in nvidia_smmu_context_fault() (2024-05-10 09:09:55 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.9-rc7:

Including:

	- Fix offset miscalculation on ARM-SMMU driver

	- AMD IOMMU fix for initializing state of untrusted devices

----------------------------------------------------------------
Jason Gunthorpe (1):
      iommu/arm-smmu: Use the correct type in nvidia_smmu_context_fault()

Vasant Hegde (1):
      iommu/amd: Enhance def_domain_type to handle untrusted device

 drivers/iommu/amd/iommu.c                    | 4 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

Please pull.

Thanks,

	Joerg


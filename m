Return-Path: <linux-kernel+bounces-215055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8811908DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465D8B25474
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC781182B2;
	Fri, 14 Jun 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ZKQKzyCq"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F217BCA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376905; cv=none; b=jIuGz2iYkGAYftCsk8Z5ZLi9YjFJ3QcVfl4VbRbOMLHxqsovwz9IWKWSgcljDSosG6WJ2t81SGom4aLju2H5GA+ZjZOsYQo8276SXOKrR8eLJiY9r22HucwHq6AZ6IjiwgpWTTUo0SKeErprC2BnxK3NDO9DotCpv62sK5vFvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376905; c=relaxed/simple;
	bh=f17+SUwo19p30IJ9Aeu41ZeelWnoAOsHYBEBfgI+G80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S3VYKlOo/XLxhMB6Rue4gPADeqI8kTidpTvIOLpCLPU2nsByYfV4pzD5O465qBTZoU7iqltfV8kSibSkcrKitC+U1MuF0lPYSksxOIv3HJ7L9OPv9T8lesnhSiEYYjNXT0Z/M6Z9jBqVmR2KcMn2hKQdktTIbc8SmzuVifIsO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ZKQKzyCq; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 32DB31C0BD3;
	Fri, 14 Jun 2024 16:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1718376902;
	bh=f17+SUwo19p30IJ9Aeu41ZeelWnoAOsHYBEBfgI+G80=;
	h=Date:From:To:Cc:Subject:From;
	b=ZKQKzyCqCP2RP96i6wIfxautV6v++FgBLJU1uGOLOjUq4NN8Q09FKVGTOk4beLY9S
	 /45j7GJ8U01ffjovzuZe4lABbTIZ2Vfg8wqAnCBafxjaiKpInw3WID4OLnJWhHZL0b
	 VElRWhy+TLr0+fhqmlStH7kjCLJXjg2unuQCmf0EZCQPJ12mBbqL46MRo705Kitr+Z
	 9LQfEXmWSw2rzINRBKvBq3K2ATpw307N6uDJ2sv+FpsIADpKQG7p2uUsKITLVESVNO
	 X+hCA3bXPdVMQM+bAmlUx9CWU/EihEZV7I4w9fa22cSWtDBVhCDhUFFV08Cf7D6vip
	 Mmzr4NHM7tF4g==
Date: Fri, 14 Jun 2024 16:55:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.10-rc3
Message-ID: <ZmxZxT-j1B71PHQp@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Sorry for sending a single patch, I missed that one last week and it
fixes a regression which several people reported.

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.10-rc3

for you to fetch changes up to 12243a8115f8583a6bcada7717c01fb164e23c89:

  iommu/amd: Fix panic accessing amd_iommu_enable_faulting (2024-06-13 11:16:05 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v6.10-rc3

	AMD-Vi: Fix regression causing panics

----------------------------------------------------------------
Dimitri Sivanich (1):
      iommu/amd: Fix panic accessing amd_iommu_enable_faulting

 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg


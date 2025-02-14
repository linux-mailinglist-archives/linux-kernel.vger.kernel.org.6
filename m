Return-Path: <linux-kernel+bounces-514579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12480A358CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704073A9A79
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085B22256A;
	Fri, 14 Feb 2025 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="QEbj09st"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25E215F50
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521413; cv=none; b=jNUDl9ZATfZNkarQGdIRNRmf9WfdjqOd6JTjALk90YjknU9fcBvGhwX6mnaIc9dtRf2bM9U3DlE45glZSj62IefHDyc3HQ1wmD/eIwBpOI3AUzCGbO29lM0BocjOlHaJiOdtS7MAj8aeUYKeWGgFD+jJ4k1G+I5Uw4siGpjrBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521413; c=relaxed/simple;
	bh=qvFBY/ul/T4cd0niS8APL8lRg56RjBde+ysVevfbY1s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tZRlYkHMzjmWy1wIgtQWNIECFPccDRBw7IxDtnHtf0PFDubDXFNpLr8EhbazSzNUiR78y5JbdLjszThliPP8WrLBQPJOQa+5jpog8veRJ7e6eN3XN172XGDir69LoF0cnn1c0n15nWuitir9wUlOW1buzIv8slEB57zVxLI0vCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=QEbj09st; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 56414407D5;
	Fri, 14 Feb 2025 09:23:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1739521410;
	bh=qvFBY/ul/T4cd0niS8APL8lRg56RjBde+ysVevfbY1s=;
	h=Date:From:To:Cc:Subject:From;
	b=QEbj09sth7FN247L1gMpMmpgM05lJVqNEywWPiC7ssDawtxnvYRP7VJiTPEq99ujP
	 U0n29rGnVKHTw7sB8ShJSdAyM+do+S/n743vtTwqG57/OBPH7T+l/f7oUm4RmFpZr7
	 JlSiyJ92iZPqP/gOR82AzKP//gwE/q88iD4vhX2DQ92nO49nPhHjBD1gzyHyaMCvvF
	 hh7xp4pgHrn7m2/ZXYwp1yToo9lUmeFMlQeuRCCrRQl0Vcrd6nxAnPDjFQY/MUY5H2
	 9eNZwHvzX9JXGGdch8Jtj4J0D5pszEMp0W40lp8/3xQ8ps8B4pvqZVxVeYw6c+VpOk
	 KtIdDq5Dz6orQ==
Date: Fri, 14 Feb 2025 09:23:29 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.14-rc2
Message-ID: <Z679gV-O0JsPQNOb@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.14-rc2

for you to fetch changes up to add43c4fbc92f8b48c1acd64e953af3b1be4cd9c:

  iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover faults for RID (2025-02-14 09:12:47 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.14-rc2

Including:

	- Core: Fix potential memory leak in iopf_queue_remove_device().

	- Intel VT-d: Handle faults correctly in
	  intel_iommu_drain_pasid_prq().

	- AMD-Vi: Fix faults happening in resume path.

	- Typo and spelling fixes.

----------------------------------------------------------------
Andrew Kreimer (1):
      iommu/exynos: Fix typos

Easwar Hariharan (1):
      iommu: Fix a spelling error

Lu Baolu (2):
      iommu: Fix potential memory leak in iopf_queue_remove_device()
      iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover faults for RID

Vasant Hegde (1):
      iommu/amd: Expicitly enable CNTRL.EPHEn bit in resume path

 drivers/iommu/amd/amd_iommu_types.h | 1 +
 drivers/iommu/amd/init.c            | 4 ++++
 drivers/iommu/exynos-iommu.c        | 6 +++---
 drivers/iommu/intel/prq.c           | 4 +++-
 drivers/iommu/io-pgfault.c          | 1 +
 drivers/iommu/iommu.c               | 2 +-
 6 files changed, 13 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg


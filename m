Return-Path: <linux-kernel+bounces-538876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21A9A49E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72AC16AFBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375021B4250;
	Fri, 28 Feb 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Z+R3T1B+"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68BB14885B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758291; cv=none; b=e5I/+oF/CIZFlH79Vc0eSyuL/IaKpD3gPwmUvXjBy9i1dBPZWEeCrCZcD4QIXHjiIjPe9Jk0VMpU0eaPuYaTIzWi+NIIwItTQ/H8tawT710JcVwOJMF8QIgXho77yvIiYtDQgfAW48u3rZfczmo8iiFZgSEmQ14W8b2JcMgfGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758291; c=relaxed/simple;
	bh=w7UwFFDfTzn/blFmQltq0BDs2swJG9iTW4bJSf2HOh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tjOgwlyByUb9uaGtPgZH3/MBsB9vAs5Eewjv6S38mvsqN3I7MJWjIVdHDOnBXcdfcfKiCF58WLqodJIyzYnbaIdorR/nAgYqUh2iPviq0UoqSGUCpiOGl4RS4rtYasejXXn4zkQPfXvLKoygeDTsrZZIQdB7z2KnjeAhDzto3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Z+R3T1B+; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 75FA741861;
	Fri, 28 Feb 2025 16:58:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740758288;
	bh=w7UwFFDfTzn/blFmQltq0BDs2swJG9iTW4bJSf2HOh4=;
	h=Date:From:To:Cc:Subject:From;
	b=Z+R3T1B+b1y7VOEIn/9Ik1CyvsARwovuLlCE9onxwNRT5WnZE7gR7ubS4ZynjFKk+
	 Eu3k4t8SHatp8qq/aV+EproFOsEKzxecbAWx/d4wWMqX20iyZUJh0UwoDOKUNCVzM+
	 KtF2dU/nVBOFcp8wTmskA7GaKWB6k/lHhLdDJe8F2vgcaSJABW4VdppfAHrUuyZYie
	 OxZhHcSNw9+NldsimQww0ZiAjd73GYMKEKI28u6HS4huBzLJtducQNzcKHdgm+H3Pw
	 bQIden6ANlGo9q/HtB499+rSX+SaTKtC77PyQ7237JXE5fwTCZKmFaW1Jk1V+5U2Zi
	 uGVMWVz7JIu7w==
Date: Fri, 28 Feb 2025 16:58:07 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.14-rc4
Message-ID: <Z8HdD3MdUViUc0eo@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.14-rc4

for you to fetch changes up to b150654f74bf0df8e6a7936d5ec51400d9ec06d8:

  iommu/vt-d: Fix suspicious RCU usage (2025-02-28 12:19:01 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.14-rc4:

Including:

	- Intel VT-d fixes:
	  - Fix suspicious RCU usage splat.
	  - Fix passthrough for devices under PCIe-PCI bridge.

	- AMD-Vi fix:
	  - Fix to preserve bits when updating device table entries.

----------------------------------------------------------------
Alejandro Jimenez (1):
      iommu/amd: Preserve default DTE fields when updating Host Page Table Root

Jerry Snitselaar (1):
      iommu/vt-d: Remove device comparison in context_setup_pass_through_cb

Lu Baolu (1):
      iommu/vt-d: Fix suspicious RCU usage

 drivers/iommu/amd/iommu.c   |  4 ++--
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 10 +++++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg


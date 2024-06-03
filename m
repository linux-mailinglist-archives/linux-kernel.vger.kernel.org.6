Return-Path: <linux-kernel+bounces-199297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CB58D8516
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4250128342E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3312EBEC;
	Mon,  3 Jun 2024 14:32:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC057C9A;
	Mon,  3 Jun 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425152; cv=none; b=O2mViTCiCXBmOXGAS3/SU6Bug5qkTWypzR7PwabGr1OgT48b6zxaFHk8R7CRXPE1KvgMDV46jT7JPzTInRFNaiEnGgAKfPFDqrIDDP0qEH3PHvCY4JFjrdLmzPtwOIVhpdndMtKyl9gDTDHguWxIWyNeM9AIb3y8zOvegjBHe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425152; c=relaxed/simple;
	bh=UoCaPevIx3Dxi4FPfP1x19N4RUjXMfRcWhSQxhfe4R8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrSehntfAWySeSyRlnzgAQ7zsqhn8V4yFjz4hZYcm2wn+TtI5tDGYZUo7By6HrtQ+vJ9KM705mCIgzwYnzOIRnTr/oJBFKJmHFAxD5ePIGjTzXBWXJEmg6vKzOorTqdRgXF60sVTZbQYRz1F5HHZGsYJcXcE2G1+9jednBCkNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3783C4AF0C;
	Mon,  3 Jun 2024 14:32:29 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.10-rc3
Date: Mon,  3 Jun 2024 22:31:57 +0800
Message-ID: <20240603143158.2625704-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.10-1

for you to fetch changes up to eb36e520f4f1b690fd776f15cbac452f82ff7bfa:

  LoongArch: Fix GMAC's phy-mode definitions in dts (2024-06-03 15:45:53 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.10-rc3

Some bootloader interface fixes, a dts fix, and a trivial cleanup.
----------------------------------------------------------------
Huacai Chen (1):
      LoongArch: Fix GMAC's phy-mode definitions in dts

Jiaxun Yang (4):
      LoongArch: Fix built-in DTB detection
      LoongArch: Add all CPUs enabled by fdt to NUMA node 0
      LoongArch: Fix entry point in kernel image header
      LoongArch: Override higher address bits in JUMP_VIRT_ADDR

Tiezhu Yang (1):
      LoongArch: Remove CONFIG_ACPI_TABLE_UPGRADE in platform_init()

 arch/loongarch/boot/dts/loongson-2k0500-ref.dts |  4 ++--
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts |  4 ++--
 arch/loongarch/boot/dts/loongson-2k2000-ref.dts |  2 +-
 arch/loongarch/include/asm/numa.h               |  1 +
 arch/loongarch/include/asm/stackframe.h         |  2 +-
 arch/loongarch/kernel/head.S                    |  2 +-
 arch/loongarch/kernel/setup.c                   |  6 ++----
 arch/loongarch/kernel/smp.c                     |  5 ++++-
 arch/loongarch/kernel/vmlinux.lds.S             | 10 ++++++----
 drivers/firmware/efi/libstub/loongarch.c        |  2 +-
 10 files changed, 21 insertions(+), 17 deletions(-)


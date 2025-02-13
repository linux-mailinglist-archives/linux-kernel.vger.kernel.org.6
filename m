Return-Path: <linux-kernel+bounces-513150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B07EA34244
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C871886083
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165B02222B3;
	Thu, 13 Feb 2025 14:32:04 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7102222CD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457123; cv=none; b=EY4A5qVT+ws7tyaK5Ihhn8dmlAt7peIP2jQalvKMTqI4rzM2SNEay8R/1Ioh4iD5WLsdfZVETKmiFokCXqxCacGA5IIMIPmxV1gy9ysQNmX9QLxh96PsBGc+CrnGDRTb8y0Yl70ic+JflgbphnRk2+r87whn2uf/IyaweVveitM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457123; c=relaxed/simple;
	bh=MbKSHc6S9QS5zxVP19dlAsVUWqhbyd3VguIpTvCey6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAyjavZ0Z2cCkTIcRMXMekgwSxB1Fdpbqd+4YxIwTrYuDvHeSAuXI9HJ7j8U5+XJU7YU75M/LdvYdxkD9kWSEGFBHNAR/f5ZPfsHfgBM8yojWxASMOpDwbnq9/aF1/XGn/TzZD7ihUoRwiagoQvlcu5FsBvPeHRlgZ19Ec1YHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.156])
	by gateway (Coremail) with SMTP id _____8AxWXFfAq5n1EN0AA--.5453S3;
	Thu, 13 Feb 2025 22:31:59 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.156])
	by front1 (Coremail) with SMTP id qMiowMAxSsRbAq5nLSUQAA--.1557S2;
	Thu, 13 Feb 2025 22:31:58 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.14-rc3
Date: Thu, 13 Feb 2025 22:31:48 +0800
Message-ID: <20250213143148.1450556-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxSsRbAq5nLSUQAA--.1557S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF4UGrW5GrWfZr17KF17Arc_yoW8CFW3pr
	y3urnxJr45GrW3X3Zrt347Wr1DXr1xGr1IqF1ay348AF1UZr1UXr18WrykXFyUJ34rJr1F
	qF1rJw1qqF1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jepB-UUUUU=

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.14-1

for you to fetch changes up to 3011b29ec5a33ec16502e687c4264d57416a8b1f:

  LoongArch: KVM: Set host with kernel mode when switch to VM mode (2025-02-13 12:02:56 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.14-rc3

Fix bugs about idle, kernel_page_present(), IP checksum and KVM, plus
some trival cleanups.
----------------------------------------------------------------
Bibo Mao (3):
      LoongArch: KVM: Fix typo issue about GCFG feature detection
      LoongArch: KVM: Remove duplicated cache attribute setting
      LoongArch: KVM: Set host with kernel mode when switch to VM mode

Huacai Chen (1):
      LoongArch: Fix kernel_page_present() for KPRANGE/XKPRANGE

Marco Crivellari (1):
      LoongArch: Fix idle VS timer enqueue

Yuli Wang (3):
      LoongArch: Use str_yes_no() helper function for /proc/cpuinfo
      LoongArch: Remove the deprecated notifier hook mechanism
      LoongArch: csum: Fix OoB access in IP checksum code for negative lengths

 arch/loongarch/include/asm/cpu-info.h | 21 ---------------------
 arch/loongarch/include/asm/smp.h      |  2 ++
 arch/loongarch/kernel/genex.S         | 28 +++++++++++++++-------------
 arch/loongarch/kernel/idle.c          |  3 +--
 arch/loongarch/kernel/proc.c          | 29 +++--------------------------
 arch/loongarch/kernel/reset.c         |  6 +++---
 arch/loongarch/kvm/main.c             |  4 ++--
 arch/loongarch/kvm/switch.S           |  2 +-
 arch/loongarch/kvm/vcpu.c             |  3 ---
 arch/loongarch/lib/csum.c             |  2 +-
 arch/loongarch/mm/pageattr.c          |  3 ++-
 11 files changed, 30 insertions(+), 73 deletions(-)



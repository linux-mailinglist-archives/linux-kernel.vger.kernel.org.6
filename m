Return-Path: <linux-kernel+bounces-552424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38434A579BE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352293B080F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0B91B043E;
	Sat,  8 Mar 2025 10:24:53 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB751953A1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741429493; cv=none; b=bszmU1xPog5UcZMvijnJI2eSfpcbJOLekHA4vY8s3yYAqZdG5TskJB+9h21o0bbYfzE19L/w1rRhQK+N6kwLbSf62ATmXuUhn/GCTss3k9p3ZPKTvMG+J3O+f525VSp/+2Lkpoq4eI6zyeyaWFFWyLwT6Z4jsBv9w254GcYbY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741429493; c=relaxed/simple;
	bh=yuHqUZKAMZAMTIbjaRmiWha9srQx/kUYPRC2ncRQ/TI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LaNZMxOAQjQGibRXdA+FGh+ilbOpMHRDaXZXfNExbV07a8N0nfJKefqXOBamVQMDSSO2huAsWvTIrohRnFF5mz4f/+Kb2ePbG5RTBgGevWMwWP0A7t4NJ4y3qTqCTqvMNAjWW2mwbm98X261KuG6DFLsEMUxJvzRKEm0bM8Cpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.156])
	by gateway (Coremail) with SMTP id _____8CxvnLvGsxn7e6OAA--.47660S3;
	Sat, 08 Mar 2025 18:24:47 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.156])
	by front1 (Coremail) with SMTP id qMiowMCxasTmGsxnMyE+AA--.15162S2;
	Sat, 08 Mar 2025 18:24:46 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.14-rc6
Date: Sat,  8 Mar 2025 18:24:16 +0800
Message-ID: <20250308102416.3722203-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxasTmGsxnMyE+AA--.15162S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4kZFWxGF4xur4rZr4rtFc_yoW8Ww1fpr
	yakFsxJr45JrnxJwnxt34Uurn8XryxG347XF4akry8Cr4UAr1UJry8WrWkXFyUt34rJr10
	qr1rJw4jgF1UJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxU4s2-UUUUU

The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git loongarch-fixes-6.14-2

for you to fetch changes up to 6bdbb73dc8d99fbb77f5db79dbb6f108708090b4:

  LoongArch: KVM: Fix GPA size issue about VM (2025-03-08 13:52:04 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.14-rc6

Fix bugs about kernel build, hibernation, memory management and KVM.
----------------------------------------------------------------
Bibo Mao (5):
      LoongArch: Set max_pfn with the PFN of the last page
      LoongArch: Set hugetlb mmap base address aligned with pmd size
      LoongArch: KVM: Add interrupt checking for AVEC
      LoongArch: KVM: Reload guest CSR registers after sleep
      LoongArch: KVM: Fix GPA size issue about VM

Huacai Chen (1):
      LoongArch: Use polling play_dead() when resuming from hibernation

Tiezhu Yang (1):
      LoongArch: Convert unreachable() to BUG()

Yuli Wang (1):
      LoongArch: Eliminate superfluous get_numa_distances_cnt()

 arch/loongarch/kernel/acpi.c          | 12 ---------
 arch/loongarch/kernel/machine_kexec.c |  4 +--
 arch/loongarch/kernel/setup.c         |  3 +++
 arch/loongarch/kernel/smp.c           | 47 ++++++++++++++++++++++++++++++++++-
 arch/loongarch/kvm/exit.c             |  6 +++++
 arch/loongarch/kvm/main.c             |  7 ++++++
 arch/loongarch/kvm/vcpu.c             |  2 +-
 arch/loongarch/kvm/vm.c               |  6 ++++-
 arch/loongarch/mm/mmap.c              |  6 ++++-
 9 files changed, 75 insertions(+), 18 deletions(-)



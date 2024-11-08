Return-Path: <linux-kernel+bounces-401328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4149C18E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6D11C217A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033E31E0DAC;
	Fri,  8 Nov 2024 09:16:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F51D1519;
	Fri,  8 Nov 2024 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057365; cv=none; b=lHfHc9PpI2vkWTL+75ecHbBtA+NjgN88gytWddrlcpcSbaZKUjf/IE6JvdMA0CN8ENnYRqgHDP8fOkG6IJ837JXNcdpD33Mavl+OqtoYzeD8+bHanHnFSvqsPo7lpagSeHKsAJRfQiRGbawq1bu4FQ7IMWUt0dMM+2TeRQnCcGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057365; c=relaxed/simple;
	bh=fsr3qmsrtjSPgPHF0+7cGoOGyCTPieysg3nhWfIKD/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WcdI/vrPJnsKmef2vvT86QdbM/HvtyKSIN50prEB1CqisXF6LL1IlFy+USp2YuhPhPw4IEoOLE9G73hFwu583JDSpYb2fwntQV/xdH3Y4ZH6Tqbl96LsMIax34R1U2BUgSCGTgV1586saEDhrE3TEoR+YRbIADIEDu8T4ns3Tog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ABBC4CECD;
	Fri,  8 Nov 2024 09:16:02 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 0/3] LoongArch: Add PREEMPT_RT support
Date: Fri,  8 Nov 2024 17:15:42 +0800
Message-ID: <20241108091545.4182229-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add PREEMPT_RT support for LoongArch.

With the recent printk changes, the last known road block has been
addressed. The main architectural preparation we need is selecting
HAVE_POSIX_CPU_TIMERS_TASK_WORK to allow PREEMPT_RT coexist with KVM.
Then we can also enable PREEMPT_RT as X86, ARM64 and RISC-V.

Huacai Chen(3):
 LoongArch: Reduce min_delta for the arch clockevent device.
 LoongArch: Select HAVE_POSIX_CPU_TIMERS_TASK_WORK.
 LoongArch: Allow to enable PREEMPT_RT.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig       | 2 ++
 arch/loongarch/kernel/time.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
---
2.27.0



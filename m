Return-Path: <linux-kernel+bounces-525267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C617A3ED56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF2C3BD0A2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6581C1FECDB;
	Fri, 21 Feb 2025 07:32:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC6B18C936
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123177; cv=none; b=q3Zlwn81prCA+ujG+ARAL43GG37rPOOtMqUX+qJZ8SjrTgPr3TQsQj9qGUd2wpR9+VaEKVpsow/+SNShDKH8vFjP3cU+5ApUBa4Nd4N98Wg5rZ+fuEyhUiiZyvfnljO4lFxePZgRLnXFwWXI3f5wyJ2g8TnHgf6ZjRW+2dm1Dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123177; c=relaxed/simple;
	bh=JQ2DkHZ1wO7MxFcvVF9Kiz9eG9MClhkznifbcLI1faw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r7z2afb4BHiyhhqjesFrfj05A/EvnRIwt3bUziRz7TuU99pDCTcvJI8BbNvMdfufDwb76pRsHKfXXrvwuKKKY2PBN6e8g7n/WMannBw6GYRoY3W9syzorVKI9u8xIWcU9U0wBJwOB3eACCf1zycInmLuhzqgdiR96cHdESjNUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxbeIiLLhnxh99AA--.46459S3;
	Fri, 21 Feb 2025 15:32:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDxH+UhLLhny9YfAA--.55053S2;
	Fri, 21 Feb 2025 15:32:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Remove unused option with HAVE_VIRT_CPU_ACCOUNTING_GEN
Date: Fri, 21 Feb 2025 15:32:49 +0800
Message-Id: <20250221073249.481731-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxH+UhLLhny9YfAA--.55053S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Option HAVE_VIRT_CPU_ACCOUNTING_GEN is selected by default in kconfig file
arch/Kconfig. It is meaningless in file arch/loongarch/Kconfig, and on the
contrast it may bring out misunderstanding. Here remove it on arch
specified kconfig file.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2b8bd27a852f..7fd5708fe14a 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -175,7 +175,6 @@ config LOONGARCH
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_TIF_NOHZ
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
 	select IRQ_FORCED_THREADING
 	select IRQ_LOONGARCH_CPU
 	select LOCK_MM_AND_FIND_VMA
-- 
2.39.3



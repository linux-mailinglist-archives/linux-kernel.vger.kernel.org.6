Return-Path: <linux-kernel+bounces-176471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907A18C307D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11181C20BC2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6423E54646;
	Sat, 11 May 2024 10:01:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922D2D600;
	Sat, 11 May 2024 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715421681; cv=none; b=K5wIrboru5sAFjQ30qw4nJj93952D1x+ouRq+Ld4JNL2zHwUGZ5hWuCgYfFSjo1s/6KhZ3dByI95TWx7BburfKza2geI9oMyEtnppdKIebid36GGzpnHAvc9ihXaVatX6MtJeoj40dfBK3+iF78fpyQuef4cjP7aHMBfvqTj+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715421681; c=relaxed/simple;
	bh=tz2bqVg84OHNsrluO2Ojp3gIZJKwGxkDAKcS9LJ/I9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHYBPCYlqept4FJMhikNUDbM393NcNsrAvHXRflC6g7euspaAdJm/ohntV7altZHmjH70liOG9n3bXg9k69tBIrMC2azSt/J7oCjWAJfBBXWDdiFLyl4QEaClyW+rH/MRIyXOpfNOmVn0q6CltpPZ0D0zjEHO2vjLyatQU+eNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52B1C2BBFC;
	Sat, 11 May 2024 10:01:17 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Select ARCH_WANT_DEFAULT_BPF_JIT
Date: Sat, 11 May 2024 18:01:05 +0800
Message-ID: <20240511100105.2334509-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF JIT has better performance and more secure than BPF interpreter, so
enable it by default, as most other architectures done.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 335a98b28167..24bce573dc2b 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -65,6 +65,7 @@ config LOONGARCH
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
-- 
2.43.0



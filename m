Return-Path: <linux-kernel+bounces-188256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13FF8CDFC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B2B1F21BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634D82F50A;
	Fri, 24 May 2024 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KutrFRiR"
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2ADBA42;
	Fri, 24 May 2024 03:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521739; cv=none; b=MgA1zZAcqxwoySUoXMHL+oZx8ts2GbxUE9QDQNUnyMrWnDiH7IDAImy6asUerODqthxzeVJo+ZcNgbxYApxw22wdWYJDYmBfxCkUtbEavgWTLIXcxCNYCYcQg0PT6Np4q3Awdm3XRLeLN8NVViNxzX/VRd1JLx+UD6f/i8TxNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521739; c=relaxed/simple;
	bh=v/etBkosMFj4M2oPaBJKAHkK2i4tRVWfz7TuY2sG3uk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=e63eTffiRpJqx4INJJzKLOoGhp3T175wWsun/W84MV1Hhdm3NI7Jg3lJGw8uxMy3puWbZ1pJf+VNImarBkwFWDPzoziaSum7W+Vr78vVDdCWmXBfAcDPgfnd6+/U6DozPRywId+D715rAThDCf2eEcyTDLjSL2WAaLvBlbp4E1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KutrFRiR; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716521719; bh=53Bt51sNUYf9oOYR2CzwqoJVUCqj8xxRiJcxNZztIWA=;
	h=From:To:Cc:Subject:Date;
	b=KutrFRiR1X/ofcm+XqPcgrPU6EZsmVdZgvWzWwMhAURDpHNQY3VFYQJ/bbDx3uVA8
	 M7xmY/c42ahI+ZABBiKzYrhap8CJ/KLJwQCGQVS1j591E+26+YEMkrHqUp5l2Nieqw
	 IrzcLVXkEf05K8sXnhK1cQX44AKnUpinwHiuz47E=
Received: from cyy-pc.lan ([240e:379:2259:4c00:b652:79f2:d4c3:c8a8])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 8CA030B5; Fri, 24 May 2024 11:35:10 +0800
X-QQ-mid: xmsmtpt1716521710tp2bocgn8
Message-ID: <tencent_1E3506F09D08066B8F3BAEE136C4F887540A@qq.com>
X-QQ-XMAILINFO: NPETcIssjKadSb3TOwqMbhYICRRXdt1F3cf1iEHrJeUzI+PTele0wDCTw2XHJH
	 zXOCoHIJJKmKD7ovYOdGALY2ZHUMk8Te1K7k3dshNmyxRvmWsgeR3SU/iOeIqKRfj0xcH/X/iwy+
	 Fz3jNl8VaTc1Vq70mxxx9cwX87fKpHP8bWzMSdcRCPGaqWDq95O/a4oytnPyqzIrv9WZqsYTAdVJ
	 QMP3JbyE5N1PT6ZWcOYaYFKBEuFztQQQ4Y6acWpkOhk4kB/JUzovKuBVSxqlGOzE2r4Gthw8I+vi
	 gvFCV//CODEHA6qPuPUG7URzaO9570CQaX5k6Uk8OKi2szJ4dRQHeJuOrKUFY53Imxvyapn6KCo8
	 pOihMEZYdbA6KyqpqRUyYnoSQqSPdie0H5u7Mv83ww1WA4YWqjuzYnooY0D6AyNXbFG6UMBEsB5G
	 llo+26MVDnw9r6hgXuWQpTTgy621+nWKJxoMlGBCyRatqfGTFEmiz42l37LT7Y/ISyFADXqHdkZQ
	 +b1RzVUkEDRPBAI3Bd6Sob223c/loF9SZfFFqlHGDxXkjmQwzeHZbI19V+9L0chfDPA6z50NVXhp
	 l5gzJ3E3TIMfJol+K2QT9ifr3luXK1oNpmkWFihgNdxMvFv0nVPOxdNXzdsabeINzAC+v6iFOrEm
	 hFCkOXq3rPvVIdCcezJDId/cfcZlhXpgZm/WqyJLJbt8c1mrNLfHpbCCa3AlRhsUi884IgUnb+bv
	 rZU35bdVfdzRFjnX2+kQezOLFAlAC6ghz6K9H65il8W/7ooLSn1ZlXW+SAqdbh4TncEpD0e9S7Fe
	 44ooOJK5LEsrKcA+cnnz+wmuWSalYqV4tRDvXHhALI2ydmpAOjvHLNpblEQuxZBpLLhq1Z5H+QE1
	 ZKda4sqtaNjjBB3isrHQJaIDh7sPqGv+VL1J/efyC9AkvLSZMa79h0zA9eqvD0AOXM0hEIwGxS8S
	 j3DtsD9UTy61cpAw2N5F+KftLPo5aA/54R+f3Nf+z0tQ7JJn8naWF9u+G89xO824+g3Eow0Awy9c
	 lH9xbcow==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Elliott Hughes <enh@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Evan Green <evan@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 0/3] docs: riscv: Some clarifies on hwprobe misaligned performance
Date: Fri, 24 May 2024 11:34:50 +0800
X-OQ-MSGID: <20240524033450.298658-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset clarifies some unclear things about hwprobe's misaligned
performance. Including:

- hwprobe misaligned performance is only applied to scalar from patch [1]
- The defined keys of RISCV_HWPROBE_MISALIGNED_* are values not bitmasks

I cherry-picked [1] rather than write dependency because the original patch
was submitted with lines wrapped to 80 characters. We can't directly apply
that patch using `git am` .

Changes in v2:
- Add fixes to the code in arch/riscv/and include/asm/hwprobe.h

v1: https://lore.kernel.org/linux-riscv/tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com/

[1] https://lore.kernel.org/linux-riscv/CAJgzZorn5anPH8dVPqvjVWmLKqTi5bkLDR=FH-ZAcdXFnNe8Eg@mail.gmail.com/

Yangyu Chen (2):
  docs: riscv: hwprobe: Clarify misaligned keys are values not bitmasks
  RISC-V: hwprobe: not treat KEY_CPUPERF_0 as bitmask

enh (1):
  docs: riscv: Clarify risc-v hwprobe RISCV_HWPROBE_MISALIGNED_* docs.

 Documentation/arch/riscv/hwprobe.rst | 31 ++++++++++++++++------------
 arch/riscv/include/asm/hwprobe.h     |  1 -
 2 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.45.1



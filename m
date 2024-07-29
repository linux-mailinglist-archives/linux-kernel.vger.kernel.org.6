Return-Path: <linux-kernel+bounces-265545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9225593F2A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4B71C2170A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0539144304;
	Mon, 29 Jul 2024 10:26:45 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E4D143C7E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248805; cv=none; b=GF9X+lSo3thSR+LREBiw8DAdaDyKqdARgDPHVKQPkOHHcWyxnWk7FOB2ympQf6tjTtyJkYXwBJXV4jOPIG6uC4pH1E1hjPmdipLPYS79wroMjhUSZuPvdFZJj9WoAy5if7W9zYqYbXsWKZFmHim9upumhtYyn9Yy8GTqQksFwJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248805; c=relaxed/simple;
	bh=pQPTrVcqhdpxz1kgC6r/s/cwXI/n+SgZNAs+GOaTAyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F3Orbt1TD5gzaafRsXFEhQU5tkpihE4TTrsTsU62l4aiRISIHWJgDA3QxZsbXTLD7TXlJwwOPO8Sz7bb8b0A+1jEQkzC7zl7Qs5aufAoKqelkCAPdriAzrPVh7xrYJpuP/1s7daxqI48CDHYkv0Zk3SUcJ4HxHZlqbynWwSM+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:4441:3808:f850:4280])
	by xavier.telenet-ops.be with bizsmtp
	id tNSa2C00Q0ZURL201NSa21; Mon, 29 Jul 2024 12:26:34 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYNZz-003tB8-Hb;
	Mon, 29 Jul 2024 12:26:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYNaM-00B9bz-Ik;
	Mon, 29 Jul 2024 12:26:34 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.11-rc1
Date: Mon, 29 Jul 2024 12:26:33 +0200
Message-Id: <bfe0530e290cee9d350f89c4d41436f3de7cb2a5.1722248695.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  - Drop CONFIG_CRYPTO_SM2=m (removed in commit 46b3ff73afc815f1
    ("crypto: sm2 - Remove sm2 algorithm")),
  - Drop CONFIG_TEST_USER_COPY=m (replaced by auto-modular
    CONFIG_USERCOPY_KUNIT_TEST in commit cf6219ee889fb304 ("usercopy:
    Convert test_user_copy to KUnit test")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v6.12 branch.
---
 arch/m68k/configs/amiga_defconfig    | 2 --
 arch/m68k/configs/apollo_defconfig   | 2 --
 arch/m68k/configs/atari_defconfig    | 2 --
 arch/m68k/configs/bvme6000_defconfig | 2 --
 arch/m68k/configs/hp300_defconfig    | 2 --
 arch/m68k/configs/mac_defconfig      | 2 --
 arch/m68k/configs/multi_defconfig    | 2 --
 arch/m68k/configs/mvme147_defconfig  | 2 --
 arch/m68k/configs/mvme16x_defconfig  | 2 --
 arch/m68k/configs/q40_defconfig      | 2 --
 arch/m68k/configs/sun3_defconfig     | 2 --
 arch/m68k/configs/sun3x_defconfig    | 2 --
 12 files changed, 24 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 9a084943a68a4bbf..d01dc47d52ea2ffd 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -559,7 +559,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -636,7 +635,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 58ec725bf392f140..46808e581d7b4709 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -516,7 +516,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -593,7 +592,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 78c19113b2bea5e9..f09d1d687d0779a2 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -550,7 +550,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -629,7 +628,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index ca40744eec60000a..c0719322c0283751 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -508,7 +508,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -585,7 +584,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 77bcc6faf468cdbf..8d429e63f8f21471 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -518,7 +518,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -595,7 +594,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index e73d4032b659197a..bafd33da27c1101a 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -535,7 +535,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -612,7 +611,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 638df8442c988637..6f5ca3f85ea16028 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -621,7 +621,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -698,7 +697,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 2248db4260816b5b..d16b328c71363f51 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -507,7 +507,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -584,7 +583,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 2975b66521f6e3e9..80f6c15a5ed5c8f8 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -508,7 +508,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -585,7 +584,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 0a0e32344033bffb..0e81589f0ee26d76 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -525,7 +525,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -602,7 +601,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index f16f1a99c2badb70..8cd785290339db25 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -506,7 +506,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -582,7 +581,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 667bd61ae9b39537..78035369f60f1b4b 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -506,7 +506,6 @@ CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_ECDH=m
 CONFIG_CRYPTO_ECDSA=m
 CONFIG_CRYPTO_ECRDSA=m
-CONFIG_CRYPTO_SM2=m
 CONFIG_CRYPTO_CURVE25519=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_AES_TI=m
@@ -583,7 +582,6 @@ CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_IDA=m
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
-CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_FIND_BIT_BENCHMARK=m
-- 
2.34.1



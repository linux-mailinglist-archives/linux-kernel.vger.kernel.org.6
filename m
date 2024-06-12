Return-Path: <linux-kernel+bounces-211237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A50B904EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF87028A64F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C001016D9C0;
	Wed, 12 Jun 2024 09:12:54 +0000 (UTC)
Received: from hust.edu.cn (unknown [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A44E16D330;
	Wed, 12 Jun 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183574; cv=none; b=oxwlQwbXQC39iaSkAuz7vRHGl0NFngdJ6K1cuUIYt5eXd650djf6TXWcFT/KVPpDQXGkPHYzgtzx2cubE1VuUt63BYooaTpfPVylK957HVVDXj+NKLhVYisPeEQYtARyr6XGMywWl8vDQWm33DI6Ec34NosBN0NJvjwh0ev9AoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183574; c=relaxed/simple;
	bh=ZdqUF5DaEHTIFp35HA7dqT6Bt+xdWH0EB+TlXD4LNWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JfObkncCdI+8haUavKp9ydg9J42hPcBMRMV5mgcE4PH8nO1N09OigdE8RXlwSdnXTEEQoVlSRpkrVi4GDghaB4QpdFlvkslQM9f03Jo4UUexz6Iafaw5DfHFoKUL7kihrotBTo/qvYCujdl90kFVqd6yBC0GfYs7YV1pw+05NhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrABXWildZmlmtQ+_Bw--.45975S2;
	Wed, 12 Jun 2024 17:11:57 +0800 (CST)
Received: from pride-poweredge-r740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDn7sZbZmlmyd4IAQ--.8915S2;
	Wed, 12 Jun 2024 17:11:56 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs/zh_CN: Update the translation of dev-tools/testing-overview
Date: Wed, 12 Jun 2024 17:11:52 +0800
Message-Id: <20240612091155.38866-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrABXWildZmlmtQ+_Bw--.45975S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWruF17ZF4DtF4xXr43tw1rXrb_yoW8JF1Upr
	yvgryxKF1xZr1UG340gF17KF1I9F97Ww4UGF1xt3WSqrn0yFsakrsxtrn0gasxXrWIvFW3
	ZF1rKFy09340k3JanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQSb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVYhFDUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 42fb9cfd5b18 ("Documentation: dev-tools:
Add link to RV docs")

Reviewed-by: Alex Shi <alexs@kernel.org>
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/translations/zh_CN/dev-tools/testing-overview.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
index c91f9b60f9f1..286ed6b01f65 100644
--- a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
@@ -99,6 +99,8 @@ Documentation/dev-tools/kcov.rst 是能够构建在内核之中，用于在每
   参阅 Documentation/dev-tools/kfence.rst
 * lockdep是一个锁定正确性检测器。参阅
   Documentation/locking/lockdep-design.rst
+* 运行时确认（Runtime Verification）支持检查给定子系统的特定行为。参阅
+  Documentation/trace/rv/runtime-verification.rst。
 * 除此以外，在内核中还有一些其它的调试工具，大多数能在
   lib/Kconfig.debug 中找到。
 
-- 
2.34.1



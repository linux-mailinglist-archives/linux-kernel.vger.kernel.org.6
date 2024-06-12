Return-Path: <linux-kernel+bounces-211904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04995905897
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898CB2854B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F0C181D04;
	Wed, 12 Jun 2024 16:19:41 +0000 (UTC)
Received: from hust.edu.cn (unknown [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD20E180A9C;
	Wed, 12 Jun 2024 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209180; cv=none; b=dJUSGrXEbiYXeoI/LQ5daNIEXAFgWo3/q5hNihMoEAdMt5Tp9cnBYdvfQahsLH9jnWjzssTh45jzFGQujVPvTLCTMDax41MISnehIIbx9NI1F2DlJLachMKzKTUjEfzGIbp76R6rweJ/APH33PX5r9IrKNVMVWp/4XB/wsKWtOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209180; c=relaxed/simple;
	bh=SGt12UU+KpiUHKlDhDGy8jBtpG3BwXdIN9I/4hIxvOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oinFVytvsmswTicya0Mj3umt8WhUzQ+OlVIOeH0ZA58+QlWKBoJue+pDVVKieQGOv8mxf8A1wyhSKmqCHfEgMshuN++mmR1xAF2lmcMs5QJAtXw9uEhmdzrM8uvQInPdGV+wqhwyYc1868fhZwCWG6Dibehv1Hu4G2B+SasUTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAAnLvpgymlmQPRvAQ--.26353S2;
	Thu, 13 Jun 2024 00:18:40 +0800 (CST)
Received: from pride-poweredge-r740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wB3UUZeymlmfhAbAA--.28972S2;
	Thu, 13 Jun 2024 00:18:39 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Haoyang Liu <tttturtleruss@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Vegard Nossum <vegard.nossum@oracle.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: Update dev-tools/index.rst
Date: Thu, 13 Jun 2024 00:18:32 +0800
Message-Id: <20240612161835.18931-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAAnLvpgymlmQPRvAQ--.26353S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr43GFy3Gryxur15tw1DKFg_yoWfAFb_Gw
	s7XFWvyry3XFyIqr1rAr1kZrnYvF4Fgw18Ars0ya98J34UCwsrGFyDX34DZFW5WFWa9rW3
	CrWkur9aqrn2yjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbmkYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
	87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0XVy3UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 8c88bc5b489e ("docs: dev-tools: Add UAPI checker
documentation")

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/translations/zh_CN/dev-tools/index.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
index fa900f5beb68..c540e4a7d5db 100644
--- a/Documentation/translations/zh_CN/dev-tools/index.rst
+++ b/Documentation/translations/zh_CN/dev-tools/index.rst
@@ -20,18 +20,22 @@ Documentation/translations/zh_CN/dev-tools/testing-overview.rst
 
    testing-overview
    sparse
+   kcov
    gcov
    kasan
-   kcov
    ubsan
    kmemleak
    gdb-kernel-debugging
 
 Todolist:
 
+ - checkpatch
  - coccinelle
+ - kmsan
  - kcsan
  - kfence
  - kgdb
  - kselftest
  - kunit/index
+ - ktap
+ - checkuapi
-- 
2.34.1



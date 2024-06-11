Return-Path: <linux-kernel+bounces-209255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072ED902F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922F9B21534
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C2216FF5A;
	Tue, 11 Jun 2024 04:44:23 +0000 (UTC)
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259528488;
	Tue, 11 Jun 2024 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718081062; cv=none; b=hZNWNo2T6fLJAB8LGZ64tVIBBFVx+81oDO7ngfJ3S2a3A99CWiwpc10LMgSQy+d5ZSpjoBN2eESwa+yEvYZlMJ4d4M2JCDCoy09bxK+/0F0odfY5VButvlDDn/ww4RRv6wYC813Pl3PjRc9j2Cs+ughvtoIplOmjLQaBpD0DDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718081062; c=relaxed/simple;
	bh=JQDNUB4MPCgvUTSY6N7FlEkArwSpi5ZJluvqklqh7/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l3WywY/MJETAB39qMZu8WwPTSvOSShpfzrFTXHtoJW+YWs1dGzmOs8c+ck6GlfssX8rBJkK+NRuqSpFS36H2JHSBQZHmx4wRHvknMJdn0FxM+dJBvowe1vOOPzs7N6sEh753A5ShkMRjgEXKhK6Dc3wzfeS2So4Af4Q78a0GjWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrACXmikR1mdmRe6tBw--.18346S2;
	Tue, 11 Jun 2024 12:44:01 +0800 (CST)
Received: from pride-poweredge-r740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wBnfyUQ1mdmb6sBAQ--.9264S2;
	Tue, 11 Jun 2024 12:44:01 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: Update the translation of dev-tools/testing-overview
Date: Tue, 11 Jun 2024 12:43:55 +0800
Message-Id: <20240611044358.25689-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrACXmikR1mdmRe6tBw--.18346S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWruF17ZF48ZFWfJrWrZw4fXwb_yoWktFg_Aw
	s3JF4kAF43try0qrs5AF1kAFn3ua1rKr18AF4qyFs8A3sxGa97Ga4DX3sYva45WF43urW3
	CrWkZrsaqrs2yjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbmxYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUAV
	WUtwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr
	1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Cr0_Gr1UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04
	k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVWSoDUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 42fb9cfd5b18 ("Documentation: dev-tools:
Add link to RV docs")

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/translations/zh_CN/dev-tools/testing-overview.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
index c91f9b60f9f1..d89d0ec1d4cc 100644
--- a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
@@ -99,6 +99,8 @@ Documentation/dev-tools/kcov.rst 是能够构建在内核之中，用于在每
   参阅 Documentation/dev-tools/kfence.rst
 * lockdep是一个锁定正确性检测器。参阅
   Documentation/locking/lockdep-design.rst
+* Runtime Verification (RV) 支持检查给定子系统的特定行为。参阅
+  Documentation/trace/rv/runtime-verification.rst。
 * 除此以外，在内核中还有一些其它的调试工具，大多数能在
   lib/Kconfig.debug 中找到。
 
-- 
2.34.1



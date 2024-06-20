Return-Path: <linux-kernel+bounces-223078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE667910D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172ACB28F14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7D1B140F;
	Thu, 20 Jun 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK5gOOuq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5520B35
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901564; cv=none; b=r1yLxVADv+VQ+XRfphyGbMmggc32GQxv+cBEXjTYu4RwGka5cPBD38YE+BfMz8fj0ugvSiBLZvdnAxqmOszm5mQpEbbbsGI7bnOqX07wXAhOtXqP5TiajY4Y0G5jqSuIxc1aNYlpubwZZa+CRSmhW6HrSi/nmKggkRipZTOAzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901564; c=relaxed/simple;
	bh=+nkXL3P/5DPH/xfvYqRAS9Wj743LfFVRx9tm+MReJXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAiXHoqE7ZbLoCPE6gUj/Fpd3vA3pRvTxfu9u5/fSGlKlhmwOLUM2g2Lkl8yplshAYc1utLj8fWE5qwtLoxwGMR+LvOvF91aoxj4YH+OvRygMImcR7LYTPZ6Qprvv99ZCQukva6gemQMBuvy+kP2Cuo3O4AHOAD8K8JjuLisN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK5gOOuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98988C4AF07;
	Thu, 20 Jun 2024 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718901564;
	bh=+nkXL3P/5DPH/xfvYqRAS9Wj743LfFVRx9tm+MReJXY=;
	h=From:To:Cc:Subject:Date:From;
	b=uK5gOOuqE8Nei77RwTiqIzX71xq/tU0kO3iRAvDigjOEMu6r3YyzYdHBgbAwxn1wy
	 +RGvoiG6xNdVFVeLk+vv35+1WUuBz2hY7hzxfSK24Yq4j7vTLkVDSZsQdU6y6xOJn9
	 TG8MFXVTheqsIxAUvBXDes0cZeOOco7F83VBSueRhpPmPprc4zfeq0W1H4jZfswWL+
	 yquWgzTcMm6xS2ZSwRaN8lQ6DUuFph91xn819CKDgMKxBXp6uIxGDvcSpoePzKLQaI
	 bkyDaoyay6jTWHB7gNPByiy3+8oQBOJg8lbrqlzTirFO/KEo84ZDHNMfEnOqsMghAV
	 5DrBju4ZOJm9Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: thead: update Maintainer
Date: Fri, 21 Jun 2024 00:25:22 +0800
Message-ID: <20240620162522.386-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to personal reasons, I can't maintain T-Head SoCs any more. At the
same time, I would nominate Drew Fustini as Maintainer. Drew contributed
the sdhci support of TH1520 in the past, and is working on the clk
parts. I believe he will look after T-Head SoCs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..b5f5506815d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19315,7 +19315,7 @@ F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
 RISC-V THEAD SoC SUPPORT
-M:	Jisheng Zhang <jszhang@kernel.org>
+M:	Drew Fustini <drew@pdp7.com>
 M:	Guo Ren <guoren@kernel.org>
 M:	Fu Wei <wefu@redhat.com>
 L:	linux-riscv@lists.infradead.org
-- 
2.43.0



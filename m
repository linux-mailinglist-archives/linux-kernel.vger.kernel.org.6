Return-Path: <linux-kernel+bounces-393246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE779B9E3D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62743282D24
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCDD16191B;
	Sat,  2 Nov 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jyroBerk"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2714A630;
	Sat,  2 Nov 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730539937; cv=none; b=imaz2pS02g9I85d5kwHCegcb1i+7v093E2lh+Nabxm30BpDJOBjryz/mY+GHn/5v+LKTuRfQtywA78ypZyEAYr8ENKLjfF2hTh5X0cW/twSSwpT8F/svcKJziOL35AYjWHRu8sEyPNbmIGu5F0k4qfLBpFCvKcbmP3qIum1uePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730539937; c=relaxed/simple;
	bh=TmnT3GC3r7FgnH2ANSmaEiX32iilG5769/fFcdkBrts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEAGJDb887k4G4ZqE5qbdLdeQeKKd55ixUnORfa9cwrNucqQlT0gScRFMnTk5cTzGbIFqyBU+BeX99aCYH/BdRoqLH6ccoLrBZ4yAu2FbpbmFiNkMkEqMpO31n/5FOL+NcMHUHI9a4RO8+moK3KOtJYvVUIiJwEotxR3Oe+qsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jyroBerk; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 7AUHtgS0WmZVQ7AUItwjdI; Sat, 02 Nov 2024 10:32:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730539927;
	bh=5G8l6uISjGX4JalG3k0wxBKl63QcKXpkCMWjBHZEmZU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jyroBerktCqh+z7jnXCldQgaNVGooCi0y13c9w+P6yoRHq0iM+BE1VJ+nCV7hfVkL
	 21YZAZciwqwajHUl9gR0ylgvTH6/4G5+X+S38ZvfqDSC82t+dGaFnm4nDfD6sK8a9B
	 6lYTEeuayGvnj1ZbE/f4sUPF8EuNfKCidrTuaCU8bYQGorNObjl0igQULmzDXMIFhE
	 NJhi7uMkZL+GkagIDo+U9sIWwrYVt+PMSOFLXqm/X4FhcASmnJ0cSUm9FDUW9bF1+2
	 QykMA6SM7mFj7V3XzLUGlVVvs9pXhBfFkZj0AJVTuP3j9q4N7yNUrMHcQMZTfZYo1e
	 k+JPI91u6GM3A==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Nov 2024 10:32:07 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64/fpsimd: Fix a typo
Date: Sat,  2 Nov 2024 10:31:54 +0100
Message-ID: <2cbcb42615e9265bccc9b746465d7998382e605d.1730539907.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/FPSMID/FPSIMD/
M and I inversted. Fix it

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/arm64/kernel/fpsimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 77006df20a75..cd7d71fe1fda 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -386,7 +386,7 @@ static void task_fpsimd_load(void)
 			 * fpsimd_save_user_state() or memory corruption, we
 			 * should always record an explicit format
 			 * when we save. We always at least have the
-			 * memory allocated for FPSMID registers so
+			 * memory allocated for FPSIMD registers so
 			 * try that and hope for the best.
 			 */
 			WARN_ON_ONCE(1);
-- 
2.47.0



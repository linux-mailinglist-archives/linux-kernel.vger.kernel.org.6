Return-Path: <linux-kernel+bounces-546838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B0CA4FF5E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981641895B8E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486A3248884;
	Wed,  5 Mar 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLrh+BqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815B246326
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179663; cv=none; b=OdXsGjoLcRvid3bksHB0RKn+Yd2C51TaoSllUUbF7OGph9/w7eZB59OI9J/e0gz+oZV6glPKGjxE1RW9F3K2Zm6JPHw/M07k4ReNIiGs2oHkfk3VLZzK7AgfLl2EaUxsLqtKQeSPF2+LBBBJxRf5e//x+u0Kq2JDEqTyUd/OXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179663; c=relaxed/simple;
	bh=rLC1csFLpPbsBGmpTzEtCZcjoj6fGUUt+jbAO4S9frI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqbZ/RtkABwxtkvMLxSqMhogKVShNt0aoic6Xa1I5t4H9vbZEtLKU8sXAVQsvttQKuy130dVuSVRyxepQWTEgcsDf/I5sQkmurOkOGu/ZRqkPnG0pFPwceBiUMfiHzFO7VPFjRbEEkI8S38ZOt89gCBi3+H60TrEFRNrQYLK6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLrh+BqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FFC1C4CEE9;
	Wed,  5 Mar 2025 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741179663;
	bh=rLC1csFLpPbsBGmpTzEtCZcjoj6fGUUt+jbAO4S9frI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nLrh+BqDGh4kF5UD7LaRIsZjcFXDd7YHQ1IeFElGsWYPGOOXTUmEL7NcCYZNPJmfB
	 CrqYIu9PsEu2VFnWDpBvUDR4qhI4tzeb29hMFfbhPNIE0FpdtPzzdGiiUKhLVLfpCT
	 R4ZDO+tw7tWpGS7b+6tw9yUlm+lVOjt/9hapWrjkAisxfNZCVDadrGXo5Ycb51haaA
	 RURj5k+pEcPjXrr6ziLl5ex+urWBDb5pjiAR0QJOh+S4WqKOWr82cual0PH/EtOUie
	 K+PEX6AIPV9eHd5trPNgLWLRwE9ryw5KSqfNICYbkTaCHkrTJ8XhhntnKGB+SSQCRv
	 LlHe1Xv0IzMDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFC8C282EC;
	Wed,  5 Mar 2025 13:01:03 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Wed, 05 Mar 2025 22:00:13 +0900
Subject: [PATCH v4 1/8] bits: fix typo 'unsigned __init128' -> 'unsigned
 __int128'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-fixed-type-genmasks-v4-1-1873dcdf6723@wanadoo.fr>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
In-Reply-To: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
To: Yury Norov <yury.norov@gmail.com>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>, 
 David Laight <David.Laight@ACULAB.COM>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=880;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=OwRhvflyURxATxZcko1vxuJdGFTknPZsp+6vhXZr8YE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOknvL7N+3ySo8NTU7DScMITxwmchcZbm/4cihU4M8dPw
 mvSidVTOkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAExEX4Phf2T/rL9/Pv794nb5
 +Ua+T2lfdugeviDXEML4ROTLXFa/vSsYGTadUTy/IEmr81Rqja7Fn7SrpqdXHIr6aLihs8v7/jI
 HBhYA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

"int" was misspelled as "init" in GENMASK_U128() comments. Fix the typo.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 61a75d3f294bfa96267383b5e2fd2a5d4593fcee..14fd0ca9a6cd17339dd2f69e449558312a8a001b 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -40,7 +40,7 @@
  * Missing asm support
  *
  * __GENMASK_U128() depends on _BIT128() which would not work
- * in the asm code, as it shifts an 'unsigned __init128' data
+ * in the asm code, as it shifts an 'unsigned __int128' data
  * type instead of direct representation of 128 bit constants
  * such as long and unsigned long. The fundamental problem is
  * that a 128 bit constant will get silently truncated by the

-- 
2.45.3




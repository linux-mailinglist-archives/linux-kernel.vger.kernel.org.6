Return-Path: <linux-kernel+bounces-518285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A1CA38CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2C31888B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4A2376ED;
	Mon, 17 Feb 2025 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="wswrQ0W1"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57222B8BC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822326; cv=none; b=ieJyidn9rpL5hI/ufaDeQZWwaTB2W0WeoD7pa0XAqBAhnw22AtYHsuzkHOCiSMYd1sesjyaquTyQyu5Wozm9ZearshsFxRVX5aIOqPqIbr/3MDpnFZU/GNbf+E3Ih9bq/wQe3JnqMtpNjguBvAR4wpwJFzoAwoKrBgkHla9gmWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822326; c=relaxed/simple;
	bh=2azF0+jA5HmB//VJzs+kgEZuuyVQ9RBu08lOIfwuSOU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dagEfW5ITqeyqwxLaGwLPf3Kt2+K8kHOlFgSNBuiLmhiL6hVN6cLqaCqfbJ3tu00jgr/oTavyAs4VmGpZBgmFP+u4X+LzCQGliFIB0iLbfZoaQwRcvmG1s1K7ArOjpev1t3Q+FGrylZbGCaTHJVWrg8snJWsN/zAIuGHCePMQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=wswrQ0W1; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=wswrQ0W15EsNXofBkD/a7weqF4ypSd3Pq9sQUTYE3UhDhTNId8BI2QZ63UqNdWuYEiMrlgKbeawNowwSEQREa/LFQ670/D0zjQIgas96uaMPxvXPQUrgq5DhO61O+0crTkziFGXNZmmwMHkkpclelgZfVaLZryizpMmboPyZP6k1lOpmdLH+oR2iCY4SRlfC5RdBLP33URQWbjpRFpLfcAn6yqxp19cD7mJR0Z0k8ksNCZgxuxQ0bNDukCk5svuhbJkYq+NxGWPKERehUodh0+oK0F0TilResz/4wMGioAfnZYevy65W7TlM9w/dd8uRqicyF4NNma0xNzDeZj7GLA==; s=purelymail3; d=purelymail.com; v=1; bh=2azF0+jA5HmB//VJzs+kgEZuuyVQ9RBu08lOIfwuSOU=; h=Feedback-ID:Received:From:Subject:Date:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 234657940;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Feb 2025 19:58:16 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Subject: [PATCH v2 0/2] watchdog: Exynos990 WDT enablement
Date: Mon, 17 Feb 2025 20:57:37 +0100
Message-Id: <20250217-exynos990-wdt-v2-0-3eb4fbc113f4@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALGUs2cC/3XMQQqDMBCF4avIrJsyCU3LdNV7iIuoow5oUhKxi
 nj3pu67/B+8b4fEUTjBs9gh8iJJgs9hLgU0g/M9K2lzg0Fj0eiH4nXzIRGh+rSzQiaNyI3tiCB
 /3pE7WU+vrHIPkuYQt5Nf9G/9Jy1aoaL6Rm1njb3X+JrYz24ct+Q8T078KJ5juobYQ3UcxxdjI
 GGWuwAAAA==
X-Change-ID: 20250217-exynos990-wdt-0e9100ec5f99
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739822294; l=1058;
 i=igor.belwon@mentallysanemainliners.org; s=20241206;
 h=from:subject:message-id; bh=2azF0+jA5HmB//VJzs+kgEZuuyVQ9RBu08lOIfwuSOU=;
 b=bPAzZrijVSBL2oVtt27dGqMGNZwzy1RtTjDOwJ67eR0lOkYgzT2PxTEBA7QwDQONaga1/KadI
 zRzPxaN846oDSxaReqgD106G9nJ1VWb+Wt7vw0V9O0Nxufy2ZaKW4HW
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=qKAuSTWKTaGQM0vwBxV0p6hPKMN4vh0CwZ+bozrG5lY=

Hi all!
This series enables the two clusters of the Exynos990 watchdog timer
to be used. Weirdly enough, this SoC is missing the cl1 cluster, it has
the cl0 cluster and then jumps over to cl2. As such, new cluster index
code has been added to accomodate this oddity.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
Changes in v2:
- bindings: Fix cluster-index limiting
- Link to v1: https://lore.kernel.org/r/20250217-exynos990-wdt-v1-0-9b49df5256b0@mentallysanemainliners.org

---
Igor Belwon (2):
      dt-bindings: watchdog: samsung-wdt: Add exynos990-wdt compatible
      watchdog: s3c2410_wdt: Add exynos990-wdt compatible data

 .../devicetree/bindings/watchdog/samsung-wdt.yaml  | 11 +++---
 drivers/watchdog/s3c2410_wdt.c                     | 39 +++++++++++++++++++++-
 2 files changed, 45 insertions(+), 5 deletions(-)
---
base-commit: 253c82b3a2cec22bf9db65645f934fbe095899a3
change-id: 20250217-exynos990-wdt-0e9100ec5f99

Best regards,
-- 
Igor Belwon <igor.belwon@mentallysanemainliners.org>



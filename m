Return-Path: <linux-kernel+bounces-213746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5819079D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF10B24B69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEC814A091;
	Thu, 13 Jun 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxdSTFVM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C8149C6C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299674; cv=none; b=fjFK5toF9wb1cwvSNXHFP4ZVq54y6suDot5L4CGndJaMV1nquJc6mbBkT/pgyo7zECNwrVv+3wR0kckvOlRtU2HruQnxtZp/T/b+24SAAc+qflc4wDgfc1Wb/Tm50p4lumr83/o0GMhyKqS2IWavnagjjUdztiisuWV6TVXVECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299674; c=relaxed/simple;
	bh=tJafdiuoSF5FWzE3YJZ6ugllWSgfv+v86xNhgWuOJDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPKZDvFDkySixfYyKr0jNXLkKFYOACirlkIGfrskKOcdUk/u8bmVAnjAN1ZxIAqO+Z8ucU4P4C84AlaUkh2W/VoxtviKH5Wh7O1TeRmegsQyINtLX2Ofn5nYTICDvxcSlTTS+LSfYuiP3u+tt/AfSwiXXMRi+3Tmx9MQrKvzU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxdSTFVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C12C3277B;
	Thu, 13 Jun 2024 17:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718299673;
	bh=tJafdiuoSF5FWzE3YJZ6ugllWSgfv+v86xNhgWuOJDo=;
	h=From:To:Cc:Subject:Date:From;
	b=FxdSTFVM6G2ZIXtc3ru1LbIRBIkpWyHFoTI+Mb2SDSpD2+4pkyu5vV8YeqjMw1erU
	 gB5hDxq8NOlFEgiwuJjdsaNyM0e3Qq/UKf6b2HkxalE5JRtm5m6/8visp3BQ6dh06z
	 3UhXy+Xv3enkiosocusWz69cqCUZM/rC2cFCWn054czGiOZz+K1p/dbmJWsXRStQhc
	 hL11nw0RoW4+i7Wl6A+/sijcydz3suuzfnJb0LvUfC2W094jiwMohfcE7AEruEDPM3
	 OOSKDUp2xn1DMSwEVE4B3ARKOyGse38YdtE1L3tt62bEa57Z8IyZZRfG8/WNhlOPqO
	 xb58kZ+zkRrbw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/1] MAINTAINERS: Update LED's active maintainer tree
Date: Thu, 13 Jun 2024 18:27:36 +0100
Message-ID: <20240613172736.2735856-1-lee@kernel.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pavel's repo hasn't been used actively for quite some time.

Let's make it official.

Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..2163abd9bc1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12490,7 +12490,7 @@ M:	Pavel Machek <pavel@ucw.cz>
 M:	Lee Jones <lee@kernel.org>
 L:	linux-leds@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git
 F:	Documentation/devicetree/bindings/leds/
 F:	Documentation/leds/
 F:	drivers/leds/
-- 
2.45.2.627.g7a2c4fd464-goog



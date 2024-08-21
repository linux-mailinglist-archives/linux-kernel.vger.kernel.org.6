Return-Path: <linux-kernel+bounces-296024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4708095A48B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD673B21F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F5A1B3B3E;
	Wed, 21 Aug 2024 18:13:45 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBBE1D1311;
	Wed, 21 Aug 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264024; cv=none; b=hVXt2AO4RHucJ6KnSB4+O0JbUWmMNAakAeaJhEwstpVjx7mrAND83GfzijHXAquERRqQgmthSmeZpe5k0xh+HQGVs3iuuEjA0kNzvPU6JXArAOkUlJRAMLNXHgrB6Njy05Obd1gT9xpFB7coGdL9XNC11ZjzQvnBFJpQAQ8ZfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264024; c=relaxed/simple;
	bh=Vft8koIXuZYsb0jH/GLwu7VfHTQMuG3deCjwwrK0+g0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fYaLiiE7ECmsiK1Qbbz8f2qHg9xQWxgOQr7SRCYKYf5HaSSU7xr8BMOaRYWDppwA6QL645L63XklFco54IF1wrblOWM6dRMpQQbA4VGEvNuNGNGHtzhJxHlF2Q7LmYOmtDDSkUJfK/ZcM79qf0EonyEfHxNMeD4EEgcfNCE+J0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-178-004-206-174.178.004.pools.vodafone-ip.de ([178.4.206.174] helo=martin-debian-3.kaiser.cx)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1sgppO-00227j-2y;
	Wed, 21 Aug 2024 20:13:02 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/2] hwrng: rockchip - two simple cleanups
Date: Wed, 21 Aug 2024 20:12:33 +0200
Message-Id: <20240821181235.22270-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two simple cleanups for the Rockchip RK3568 driver.

Martin Kaiser (2):
  hwrng: rockchip - rst is used only during probe
  hwrng: rockchip - handle devm_pm_runtime_enable errors

 drivers/char/hw_random/rockchip-rng.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.39.2



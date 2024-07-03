Return-Path: <linux-kernel+bounces-240178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D554A9269F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B57C28259E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A42515B0FE;
	Wed,  3 Jul 2024 21:05:46 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C5186E2D;
	Wed,  3 Jul 2024 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040745; cv=none; b=m2CPGTJ54mI2roh/AY6XbkbzocLhKXXlgrCSLJiCPefxvA6v3x8lFpIv3P5ENGTUJwqyLHiBSkXO/HHKYdC6RwfplM+ssLpXCAWNqgPjdLi1Hi8x/61uq0TZfMU2ne3B0Cf4/tCk1DhZhbSronaccjh0GfeqJ3mPb6TOKq6oIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040745; c=relaxed/simple;
	bh=Fe0xTZ/pZqs1np4QSRWoVH/JdV6Q5jUGKxLlMaKAnc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JrKaNF+QZWlxKKmIydlCrFNwcAYzvyLRSxRuoUf9VRhrDsls7jw0XgGr7q4wkBuVFO1tlvQuGL+9EIHBqcoJ8JBtMUBCMk/j4F7F3ochKPE/2vz4vxkVB3t+lJpkvIBq36wikmM17rqsSeKlMrjXvzU6zIWXJktm715JrUSVcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sP7AR-0000bE-HV; Wed, 03 Jul 2024 23:05:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Rock 5 ITX devicetree
Date: Wed,  3 Jul 2024 23:05:22 +0200
Message-Id: <20240703210524.776455-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic support for the Rock 5 ITX board.

After struggling a bit with the pcie3 ports, thankfully they seem to run
pretty nice now thanks to me finding the property for the shared-rx-clk
for the pcie3 phy.


Heiko Stuebner (2):
  dt-bindings: arm: rockchip: Add Rock 5 ITX board
  arm64: dts: rockchip: add rock5 itx board

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588-rock-5itx.dts    | 1188 +++++++++++++++++
 3 files changed, 1194 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5itx.dts

-- 
2.39.2



Return-Path: <linux-kernel+bounces-528937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE28BA41E30
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1589518942C3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464D02561C9;
	Mon, 24 Feb 2025 11:47:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D14D2561A1;
	Mon, 24 Feb 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397632; cv=none; b=lZjkScK9I4LYHovCP6ETN7vHkQc2gDoON4Hn3G5uwI9mSZn9e7HRlLL78bCY9S7Y1Aqz5TMyWR+Wu0HDhtkx4Zkb2tReBwmDasJqgB0gMzbgrv2HKaRwrRrIQ/oxxZPzczoO9kgJuHzeY2lAABHgotNj/fEYbVFeH5X5HDXibE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397632; c=relaxed/simple;
	bh=sHyfRukPY3Ldcys61ddPwDCp6mAQB4ZZFHUXAVGAiYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuUGjsS7h7faEEms/u0L92UB/u8tz1SPjSP2Bod8a9cbGmFQDBF6Csgq/hJK1DatC1BuJ5hNDhZUNrs7A8mzl413Ty2XMx2ZTjzI1RtATWOg0XCp75+DVKRQRdR9EPx3Fuwqw6e5CbtSQT67ARaenKKq43siKyFXJ/hdJIm5Zcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2D6F1756;
	Mon, 24 Feb 2025 03:47:27 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 712D23F6A8;
	Mon, 24 Feb 2025 03:47:09 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-sound@vger.kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] MAINTAINERS: Add Vincenzo Frascino as Xilinx Sound Driver Maintainer
Date: Mon, 24 Feb 2025 11:46:48 +0000
Message-ID: <20250224114648.1606184-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224114648.1606184-1-vincenzo.frascino@arm.com>
References: <20250224114648.1606184-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Vincenzo Frascino <vincenzo.frascino@arm.com> as Xilinx Sound Driver
Maintainer.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ff26fa94895..ffb3178fd53c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26012,6 +26012,14 @@ S:	Maintained
 F:	drivers/pwm/pwm-xilinx.c
 F:	include/clocksource/timer-xilinx.h
 
+XILINX SOUND DRIVERS
+M:	Vincenzo Frascino <vincenzo.frascino@arm.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
+F:	Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
+F:	Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
+F:	sound/soc/xilinx/*
+
 XILINX SD-FEC IP CORES
 M:	Derek Kiernan <derek.kiernan@amd.com>
 M:	Dragan Cvetic <dragan.cvetic@amd.com>
-- 
2.43.0



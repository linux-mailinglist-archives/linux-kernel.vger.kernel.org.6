Return-Path: <linux-kernel+bounces-422590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082379D9B97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5871168A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829481DD9AD;
	Tue, 26 Nov 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R53crlIB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54861DB53A;
	Tue, 26 Nov 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638868; cv=none; b=DTVIFn24G4blmJuGHkgK8EywQC5Z/da048xGGeLQDrGjNtJNMCaQH5nySHD14WD9cuRWEOq9To5MipgBWyszooqXJuco2PjA3YOPaMS7Zhu6m4NYO2gC8tBePqYxBd50P/eFXI5N7o43tdE8hgwOZHFLE3nJf40l3Ge88MfV9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638868; c=relaxed/simple;
	bh=h9Mb//jTwhw6dmAjiMzB+Z99YVN1LTkAwMywBD7EGYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UFZh4npfs8nHoOweu0YqkJNc76RZw9oyEpGmA1dHYpjaMay4jyOI677lNyWVXJSnjmXfBAr7r9xW8Ygp2e0evvM8nA8pXer+PN8U+wB7DZFvOOxv5I1WwteP7eiZo17LlyhODENIRuU0Z4mRfs+at0v29PzZZqHbldUwqhYF6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R53crlIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19122C4CEE3;
	Tue, 26 Nov 2024 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732638866;
	bh=h9Mb//jTwhw6dmAjiMzB+Z99YVN1LTkAwMywBD7EGYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R53crlIBLXpNPoUzF1cfZhqLHGSJhJQQvLwy0xoedGGOpRlJ4kVfNm5Cj4Z76LY00
	 y0hqHw0N3xobVuaj/xIiziOZb6r8+3RK/E5x27jDh3S2BOoNycrWr1HBiU2qREC2Es
	 zB07nbSFi9meld1YnrhrKomweAeXxyY6gr7BzFkgAmj7wCuI6NunKs2gDRdKexyT6o
	 UHFpXkHp+Fnp1XJ35RIwxnCSV5Z1anDTI8fZnKQ0fQ5yL7sAX6Pi8D+3D3STQzHZ7E
	 km0IoNtZyBQiTGhp+L+n1gcgpfSGdAc/L+o6Ia7D5FUE177tuDaw33faUteP/AfjHT
	 wSVfI73TTcfOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA12D65522;
	Tue, 26 Nov 2024 16:34:26 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Tue, 26 Nov 2024 17:34:24 +0100
Subject: [PATCH v2 5/5] MAINTAINERS: Add entries for touchbar display
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adpdrm-v2-5-c90485336c09@gmail.com>
References: <20241126-adpdrm-v2-0-c90485336c09@gmail.com>
In-Reply-To: <20241126-adpdrm-v2-0-c90485336c09@gmail.com>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732638864; l=1377;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=057O2QJ+HomyrdJxEs81SKNbrttf8RRSnPZG4/DJono=;
 b=fsafhQ9T/0iPVL1f2ug/lulQ4LAEiGM8pEMFL6tskRpMzrAEhThtjvm5FUNrO8cFEn+v+D617
 5KX46QgKejRCPaXEtpWa/PGqCGL9lCoVMHsJYdwzjBkEw2HKJsS1CvH
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add the MAINTAINERS entries for the driver

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7f0170977013889ca7c39b17727ba36d32e92dc..9a2fb7cd80e09f24932b91cd33d0cd2b3514b31c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2164,6 +2164,9 @@ F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
+F:	Documentation/devicetree/bindings/display/apple,h7-display-pipe-mipi.yaml
+F:	Documentation/devicetree/bindings/display/apple,h7-display-pipe.yaml
+F:	Documentation/devicetree/bindings/display/panel/apple,summit.yaml
 F:	Documentation/devicetree/bindings/dma/apple,admac.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
@@ -2183,6 +2186,8 @@ F:	drivers/bluetooth/hci_bcm4377.c
 F:	drivers/clk/clk-apple-nco.c
 F:	drivers/cpufreq/apple-soc-cpufreq.c
 F:	drivers/dma/apple-admac.c
+F:	drivers/gpu/drm/adp/
+F:	drivers/gpu/drm/panel/panel-summit.c
 F:	drivers/pmdomain/apple/
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c

-- 
2.47.1




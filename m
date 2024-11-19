Return-Path: <linux-kernel+bounces-414227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A459D24F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456101F2309D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DABF1CB31F;
	Tue, 19 Nov 2024 11:35:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3FA1C9EDA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016117; cv=none; b=e1GTPUIhGt38wO4emSh0sDczGqZzebTIOXUs9Q/oFGw1uLtIVW8bfhpnLj8podnb34S50YyjtNCTmnHkPRwa4mFjxzR8uZ2yg07Na6nvSU9UZ1sq14N6pPAlQ5jMG4qWPwwFFPSXRp8CQKqrL54p0s1jCFC9UmXPxV1FOw5achY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016117; c=relaxed/simple;
	bh=wqPg+2zGzXMOE7v3iue5M5sKKAsqwvM8FLNeVDTaVvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCzNkEGq08cTa2AyIqb+vjea3InINEapxgS1Nbpk3Y6eHP6gE8CFhgPl1oextyzPItYkvo/+vg5TBCPh4/AYxhtzq9ZVV5+YgVvXHRRya/zESlKNu5uvbXQziKwpleAtqWYJpLW+WeQYWiN90vfo3+g3BJ6KMMjeE4ySx+3XvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMVm-0004ie-F0
	for linux-kernel@vger.kernel.org; Tue, 19 Nov 2024 12:35:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMVl-001Yfw-1N
	for linux-kernel@vger.kernel.org;
	Tue, 19 Nov 2024 12:35:13 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1FC22377076
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:35:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1EBD5377039;
	Tue, 19 Nov 2024 11:35:10 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b585d42b;
	Tue, 19 Nov 2024 11:35:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 19 Nov 2024 12:35:01 +0100
Subject: [PATCH 4/6] dt-bindings: arm: stm32: add compatible strings for
 Linux Automation LXA TAC gen 3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241119-lxa-tac-gen3-v1-4-e0ab0a369372@pengutronix.de>
References: <20241119-lxa-tac-gen3-v1-0-e0ab0a369372@pengutronix.de>
In-Reply-To: <20241119-lxa-tac-gen3-v1-0-e0ab0a369372@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=OiGyC5hvkOyfhSJPitFX+JtgXZ73YWwikIJiBbUL5vE=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnPHfo83L1ffukhGKoWDoL8tjex0fmM2FuiA8BB
 3HMT7tDq/WJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZzx36AAKCRAoOKI+ei28
 b1XbCACWy17HQEJrXpAgn2wESy57lQ66WicbSnsYR9JWSmBp2ZxM9zyZ7dRca3v6b+4ddvmO2Io
 4l29BCkVvVMG2JHxWGL/6D0J6S2U2FiXNJT6vM1LOIzI3DWkjyt/zRArP3n+3095Tc43mKVl3rk
 DNLwzLYAVGWVgj0QbGaDiVmA9F4vHBxrEpAbwmBKDy9QYLd9qGaH2rjrHIkaz19EN/TL937XsiX
 NUDSoTydcE9hpbMKGAQ4DPxWqwr3AztBZObadH2/VyxJAwxEDgCd4Nq/zTzOCdWHubNpkykicTC
 qY2zYnaf/+alLbFoU3BPWPqc4XXlGQ0+sL+wBPjmuC+mhdcN
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Leonard Göhrs <l.goehrs@pengutronix.de>

The Linux Automation LXA TAC generation 3 is built around an
OSD32MP153x SiP with CPU, RAM, PMIC, Oscillator and EEPROM.

LXA TACs are a development tool for embedded devices with a focus on
embedded Linux devices.

Add compatible for the generation 3 based on the STM32MP153c.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 703d4b574398d2768924df8d4bd844e486aa5abf..b6c56d4ce6b9515565fc05348896ba9f400643f0 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -91,6 +91,13 @@ properties:
           - const: dh,stm32mp153c-dhcor-som
           - const: st,stm32mp153
 
+      - description: Octavo OSD32MP153 System-in-Package based boards
+        items:
+          - enum:
+              - lxa,stm32mp153c-tac-gen3 # Linux Automation TAC (Generation 3)
+          - const: oct,stm32mp153x-osd32
+          - const: st,stm32mp153
+
       - items:
           - enum:
               - shiratech,stm32mp157a-iot-box # IoT Box

-- 
2.45.2




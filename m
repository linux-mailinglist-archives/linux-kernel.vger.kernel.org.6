Return-Path: <linux-kernel+bounces-439210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C369EAC43
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9339F284490
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B401DC9B4;
	Tue, 10 Dec 2024 09:33:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30F1DC989
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823183; cv=none; b=efJnxtkf47ER5j/2kkl8IqmfCsHAnxQ49HUly1ad0h86ad5QXJ94wWPTX32rusRhsGYH/izKS5qAz30gZBddymZKxQuOWeGkQYT9mOdBfbKMxDrQbaxqJXRGfJZQyy9zyt3mqyQMpy5JBYTq/LM5k6qeo1uA4HbdNNdgyoXOdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823183; c=relaxed/simple;
	bh=c5wZgaapnS24Yt0Fhdr2wgyQHLr6dcD6pKXYz8xbVD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbJXZdS+EbrTbRQivbBNQCQkH/4U6O5ijwugyX7V6E8t3UFKc79XRGFkKRtk/xLCiuVmBTBBZ/FrJ/qnyxPmntegcrsujzEMNKq4PPXx3jp/jQHOhEn2qFsqotf37MWjenioleiElx30o+qWy9aDEtPS0kr3n6NV/UG8mGtD1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKwbt-00016J-Aa
	for linux-kernel@vger.kernel.org; Tue, 10 Dec 2024 10:32:53 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKwbs-002fKk-0k
	for linux-kernel@vger.kernel.org;
	Tue, 10 Dec 2024 10:32:53 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 72A5E38A555
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:32:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 71CCC38A531;
	Tue, 10 Dec 2024 09:32:49 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ab1b1a1b;
	Tue, 10 Dec 2024 09:32:48 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 10 Dec 2024 10:32:27 +0100
Subject: [PATCH stm32-next 1/2] dt-bindings: arm: stm32: add compatible
 strings for Linux Automation GmbH LXA FairyTux 2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-lxa-fairytux-v1-1-9aea01cdb83e@pengutronix.de>
References: <20241210-lxa-fairytux-v1-0-9aea01cdb83e@pengutronix.de>
In-Reply-To: <20241210-lxa-fairytux-v1-0-9aea01cdb83e@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=CjTHBR+MROHxR79/okvi7tDY+Vb+yOt4fEPRaYt9NAs=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnWAq6nuvrx7ZjBpHRG/Lu23Dp1lKKBfpQ/DIqV
 1oYAYh1IfGJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZ1gKugAKCRAoOKI+ei28
 b4b9B/oDqCmrtmOFjzFGKPqZbZUTQozlfYxc6QiIxoly2xegdgXLINaMqMYyr3G4/jI59NXEbWK
 nshIs34MqweozmtIxCR669HpAdqa8GFw8eciaESH7zvo15dmbs3gdziZHrUmAhefc8kyvD3Ib9D
 QpobzLY++plIq2fv6Um9hCxtzCp9lz9MNlW3y2OIGr3miZ4iK5AUlp0OeKtpsXwcd2WabClA6by
 APecPTC6fdaYSgOrEmg4i6D4IzA9VgkXzXK3OLXVzZOc0y+4/y9F2kIUoFDLyoW2QtWlPFY7ByY
 LnwFiBk67vD4OS+wPRM/0/DlMq2gjimbMKhzi55SGEQv8Z7P
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Leonard Göhrs <l.goehrs@pengutronix.de>

The Linux Automation GmbH FairyTux2 is a small Linux device based on
an Octavo Systems OSD32MP153c SiP, that occupies just two slots on a
DIN rail.

Add compatible for the generation 1 and 2 based on the STM32MP153c.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index b6c56d4ce6b9515565fc05348896ba9f400643f0..6825d965da3daf2b508fbd88e8c9d40e20ba1f59 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -94,6 +94,8 @@ properties:
       - description: Octavo OSD32MP153 System-in-Package based boards
         items:
           - enum:
+              - lxa,stm32mp153c-fairytux2-gen1 # Linux Automation FairyTux 2 (Generation 1)
+              - lxa,stm32mp153c-fairytux2-gen2 # Linux Automation FairyTux 2 (Generation 2)
               - lxa,stm32mp153c-tac-gen3 # Linux Automation TAC (Generation 3)
           - const: oct,stm32mp153x-osd32
           - const: st,stm32mp153

-- 
2.45.2




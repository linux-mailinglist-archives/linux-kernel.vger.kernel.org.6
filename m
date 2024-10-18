Return-Path: <linux-kernel+bounces-372224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A779A45D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021581C25685
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F852040A5;
	Fri, 18 Oct 2024 18:25:09 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFEB2038DF;
	Fri, 18 Oct 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275909; cv=none; b=FFcrLBGFP7K1MVi+y03kUDImfpbzN+4rVVXVdTTelub2KWQ3/NaD4kajIYuFR3s7zVyjoNuC+VDHH7YBqbEXObQ5KlW89EX5+ssZBDOi/o8U9U7NwLPRSrsYZxs9Qz+JDAnJJ9h2hxy7BOruZqG/jCXbZJgIG7vj2ESOSNLoT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275909; c=relaxed/simple;
	bh=onwGvS3r3htw3l/ddsVJHWR+6zdSCiatdZiYqQ4exSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GYt4BWg2Jm8ulNAcnHdn25MAgMbGc9oXVvSaCKiRvyuxDNI7Qu0cvO65BSojlvuMoMyN3ByT52l08t8vaxzXWs3xoSmH8IDaZils6L27rTVYt7Av3mkV1TjHmx/Y6GyJ0c2cQ0BDnWSa6Fnb9O0gxTC/HIGuHNdwdIRWC3KHO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1t1rep-0013QU-0O;
	Fri, 18 Oct 2024 18:25:03 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add Gateworks GW82XX-2x dev kit
Date: Fri, 18 Oct 2024 11:24:45 -0700
Message-Id: <20241018182444.817848-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds support for the Gateworks GW82XX-2X development kit
based on a GW82XX baseboard and a GW702X System On Module.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..93af4fb6296a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1082,6 +1082,7 @@ properties:
               - gateworks,imx8mp-gw73xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw75xx-2x # i.MX8MP Gateworks Board
+              - gateworks,imx8mp-gw82xx-2x # i.MX8MP Gateworks Board
               - skov,imx8mp-skov-revb-hdmi # SKOV i.MX8MP climate control without panel
               - skov,imx8mp-skov-revb-lt6 # SKOV i.MX8MP climate control with 7” panel
               - skov,imx8mp-skov-revb-mi1010ait-1cp1 # SKOV i.MX8MP climate control with 10.1" panel
-- 
2.25.1



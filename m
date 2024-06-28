Return-Path: <linux-kernel+bounces-233606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A9491BA24
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF79F2852DE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0C14D435;
	Fri, 28 Jun 2024 08:36:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E6322B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563765; cv=none; b=VD4LqPgU/hkwtI2H/Iuik/5n8hsE5EXcO6KY3eEk2P91xbFx653NN+mKzobD7QVMbIioaBzC6I9u5R9zqiU0VGb3MRlY/bTK1DPQv2TaM4AuX2Zewj5OfC+/JlDuG84jj8FfaUR8ksMX55oKpy1BPcp/RHFZiKUSsU8li7k+T+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563765; c=relaxed/simple;
	bh=vH1fp++601l8m8+CpdyZVk01Rgk1uREuDmwiUBp07mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uydis4C58l9KNBAzPYDYlvMpXT81J3VeUpBl6cpjjm6XDKXzfPIx46ld78PydiUfCpWmOfLzl00RX36O8/bYDuZFQZq5OScF559FqSpvzOUvlCQiB4NO2X+iAP6kIxvwK2n5ExI+pAiw8JST/F1eZ102VfKtGra6lFQdjFKHS1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sN75J-00079Y-Ej; Fri, 28 Jun 2024 10:35:57 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 28 Jun 2024 10:35:51 +0200
Subject: [PATCH v2 1/2] dt-bindings: input: touchscreen: exc3000: add
 EXC81W32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-input-exc3000-exc81w32-v2-1-c2b21a369c05@pengutronix.de>
References: <20240628-input-exc3000-exc81w32-v2-0-c2b21a369c05@pengutronix.de>
In-Reply-To: <20240628-input-exc3000-exc81w32-v2-0-c2b21a369c05@pengutronix.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14-dev
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add compatible for EXC81W32 touchscreen controllers.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
v2: new patch, split out of driver patch
---
 Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
index 9dc25d30a0a8..c299838e2680 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
@@ -18,6 +18,7 @@ properties:
       - eeti,exc3000
       - eeti,exc80h60
       - eeti,exc80h84
+      - eeti,exc81w32
   reg:
     const: 0x2a
   interrupts:

-- 
2.39.2



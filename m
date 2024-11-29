Return-Path: <linux-kernel+bounces-425419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74FF9DC1D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29904B238C4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2290C198E78;
	Fri, 29 Nov 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os7ZIXwR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFB1953A9;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874182; cv=none; b=U0Fmfe5p7mR8nLlDlY92yKdMBz8WEXKTYiaA41I0NgYYkYDY7oTHFw1cmaUZK3tdsp6P7YGfPZTCL2vUhdmtpV0+/AAHnnqpwNgGte9oNw9hVI3sZwnhaTYyj/DWBbiaCypfSaT2PGJ/s966pxjAw0MM+g7YJKUMm2BOxfpXqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874182; c=relaxed/simple;
	bh=pWkPl4JM05EAePGDkDwqJkBSfh29oeV888iEWBjvAJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZPuMACZhZu5pA/fQh0yz22mZTkxXQ32qU7r8QOeEnWL86iCe7vkx8Rg8AfDUrLWKpnHPFK6eD9ddCnVERlJ5+aiCcPpePDYCXsRNjsDeJ89JXD1K0dBT814/IasosMU3crgAtqWn8t/OtA3X1rbZdEQfjE36ixBoBvECp975OzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os7ZIXwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0EB8C4CEDA;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732874181;
	bh=pWkPl4JM05EAePGDkDwqJkBSfh29oeV888iEWBjvAJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Os7ZIXwRXd6DWs99axiHfAQYh8k7UZudtBTY0WdW2nP7UsPbp6Lxoqq9ZFGyXXa5U
	 yEMACLBVd9gTfgLh4mSoQeL5xOcROLcEBlVyDeB9Sy0qalh3nvvfXiZ0G+/dTxRcDA
	 pAURqmWdS2yGsdjBtpgJDwrU08VQxq3x3rtVyTGTdzpXDcyylfHLZlPQ4hqT/dT6jY
	 lfaiBAG/3YRFWxxVpt7phD8WHbF0JXVRmWlXPDv3FZszzlnuQwL7UFxH5SEknOJRAF
	 nVCZT+ISqUoaupP22fikNqNDsdzFMDQUScSgzSeWmrMvoU0joqR49ZOGK1gox6r3aR
	 s/XSnOd5jbHcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA609D6EBF7;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 29 Nov 2024 10:53:19 +0100
Subject: [PATCH v5 4/4] w1: ds2482: Fix datasheet URL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-ds2482-add-reg-v5-4-af8e83d41344@gmail.com>
References: <20241129-ds2482-add-reg-v5-0-af8e83d41344@gmail.com>
In-Reply-To: <20241129-ds2482-add-reg-v5-0-af8e83d41344@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732874180; l=803;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=03Cepzmlkc7S59f4WEx6i61KjUdKKkD9CK15GJyvMcE=;
 b=cZvdu2khzFLOnoIoOrBZMdoYPcaRapSWDZj40Vet1PUk+3E0akKvpgLeVkeXGxWNTlJirJyjE
 5IIm8UrEeKLAYuojpBV970HfHrLoJfKdyUZUT1dfJVocsPOnIUdyIR9
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

From: Kryštof Černý <cleverline1mc@gmail.com>

Current link does redirect to wrong place.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 drivers/w1/masters/ds2482.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 8c34c2e9a5a34e38ed097d7fbd965ec5b75e71d8..117a53d80ce88ebaffea3097079aa54e79d549d3 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -7,7 +7,7 @@
  * It is a I2C to 1-wire bridge.
  * There are two variations: -100 and -800, which have 1 or 8 1-wire ports.
  * The complete datasheet can be obtained from MAXIM's website at:
- *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/4382
+ *   https://www.analog.com/en/products/ds2482-100.html
  */
 
 #include <linux/module.h>

-- 
2.39.5




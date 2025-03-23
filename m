Return-Path: <linux-kernel+bounces-572836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BD5A6CF3E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BF77A40B0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAED746E;
	Sun, 23 Mar 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwGuvTTt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61A17E;
	Sun, 23 Mar 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742733502; cv=none; b=KNq/7uZRstkaxkaLbrrv1Frne8QU0tLkzMsq1Z+u1QsqzXikRoVhGzJW0I78QrUccv+6b6RQTM+fnKbf4/fpZ20qb5fgC73RDNsmmKZm6EIMTHOni6M9xWB0mCpDVYX1aT9yG6WZ/4auQz/CceJclxVyurtLYdwK32Icj1bArRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742733502; c=relaxed/simple;
	bh=qNL5zaQmZMh2NYS8anqdXQNeU2uo1FCGOXYyuJOoH/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7CfgcVou4gvO7Wx4afivd5yBRanK8XdtrSC4fwMXl4sxnSHhnqXJZgsTELFbbjOgZuhhqN7H24FZoIRNkPINCMImaimNsS00btRgXzgdCTmdzq/tAuW00k/M9L+ZF2BRAImAwEEdUnaSKS0l8uDx3R9ZW7gTVQ9OwpjHMvGm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwGuvTTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D3E9C4CEED;
	Sun, 23 Mar 2025 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742733502;
	bh=qNL5zaQmZMh2NYS8anqdXQNeU2uo1FCGOXYyuJOoH/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jwGuvTTtJZ9m0jZO5Ew6Cdmj/L0ze5hTuRyFtU8DX7f/cgPEDVu0w5AwiHV/igIXO
	 64qKKIjzMPJ0cqrf7HAtHpiPmKkP+ED2VApK6CfTxOSa8U1Ul2X+VYlWSUYwaRt5Sd
	 WSnZb6thzX0q0JjLXSMAHRXWOmiB3xuPJsWdRhRa2uBLz2tOgf+DDrNWkBXCyTZsTL
	 ymvcJ0zEczgs9sAE4arjM+BASR0c1OnWG2uAb4KLM7zwCZBxafcqd6rjKzOeyp2Nno
	 b61pr7on2SiI6fXd74Zxtf/cPlXg1EpLc1aK8QpTfmo7yGvFSeQ/thl2Qd3neUNvah
	 wBrTHgK7aKpMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3CEC36005;
	Sun, 23 Mar 2025 12:38:22 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 23 Mar 2025 13:37:50 +0100
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add TC
 Unterhaltungselektronik AG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-fernsehfee-v1-1-2621341cd37a@posteo.net>
References: <20250323-fernsehfee-v1-0-2621341cd37a@posteo.net>
In-Reply-To: <20250323-fernsehfee-v1-0-2621341cd37a@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742733500; l=959;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=uaz9m8VjNE4NEygLbUtmBG2+WbjOgy1rPMuQ4WTpnro=;
 b=XWEvZjys42PmDLa1n4FLTA9f2MmzxWu8uLr8Mzx4Mal4ZylyaFFdxjPKN+Az3yww8cB+aEWHj
 WpA+cD9U14/B0t2ta3oMhRBIPPX4SlIOX4/8AZbHcQA/4q2fxIr/B45
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

TC Unterhaltungselektronik is the company behind Fernsehfee branded
set-top boxes.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1e9e2b52312439e4b1d48b262200c..0019f6131bbfc11ba55f5a15a238825abf665aaf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1484,6 +1484,8 @@ patternProperties:
     description: Toby Churchill Ltd.
   "^tcs,.*":
     description: Shenzhen City Tang Cheng Technology Co., Ltd.
+  "^tcu,.*":
+    description: TC Unterhaltungselektronik AG
   "^tdo,.*":
     description: Shangai Top Display Optoelectronics Co., Ltd
   "^team-source-display,.*":

-- 
2.48.0.rc1.219.gb6b6757d772




Return-Path: <linux-kernel+bounces-572837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFFA6CF3F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A23C18995F7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CFE2E337C;
	Sun, 23 Mar 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEwcKSMV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA61B623;
	Sun, 23 Mar 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742733503; cv=none; b=WnfAj6MOWhBcd86oE3cRFCV4Pg0HKXBboA/P4I6khjlReh5zX5rGljFcmQ8wHlYmsumJ5dzYvCyKpQh/Y5Y08fwf7A1fq9p8xIbQiIHtqcgu1VXLwqPPzq2611Y8hMtVTUSaDaePVZpinb0xJjCHuBtiMeWTL7JTp6KL/Sh1XMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742733503; c=relaxed/simple;
	bh=DR7zJgdee++dv14xQ+dPhz4iEUH6k4tcSVxNuNHr0oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mY+0woxc3gWRq1ld+fZKZhRYy6BjoqEMldd1DbaJS/8HuIfac31GcHAyvY5rZkC6Q7hcmsl09HySk4EGfiwL4fzESdJKM1DIrPOgC8l3mdEe5z0E80FRLuvSTcuDjEmhEfE+Tukg/J5B4oWGqlICOAzEZPkIY0oinOel5hkvb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEwcKSMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BEB1C4AF09;
	Sun, 23 Mar 2025 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742733502;
	bh=DR7zJgdee++dv14xQ+dPhz4iEUH6k4tcSVxNuNHr0oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FEwcKSMV4fmnQEwkMOlxHhoNpJwzQ0XlHpANJpSC2s1qrPeEBWfbkWSaLkm2l0Xnj
	 mgh6V49Ocx7VDQZogxLUdL9DNbu22x9HjGzf/qghR6C/O73P2m17rlub0Be51z4B8a
	 LziCUGhgQdP84XrrrH7Lecqa355lEF3TJviRKUs/DTQBQRghiz/cN527VQVFwJfqij
	 PpQFwu6L38RnD6figtqobu9AbnwsPMHS5XWYWteOK1bKEbSOsL8voWVCWxNCZcnua9
	 TpEzBvwa/ip/1XOoEAwNqu5qTp1FPm9ylDtgpMHBlHYwC2i7WDGYtDSu1ppqJUtSsP
	 0x7vaUZAIkg9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB86C28B30;
	Sun, 23 Mar 2025 12:38:22 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 23 Mar 2025 13:37:51 +0100
Subject: [PATCH 2/3] dt-bindings: arm: amlogic: Add TCU Fernsehfee 3.0
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-fernsehfee-v1-2-2621341cd37a@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742733500; l=960;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=mrc3J8ytO/NiLhShyV41MfY6uhH+27AuqX1jMo8Sw34=;
 b=JIcizXwOKzMDmAcqEevcbaltakZu6TXCOFfO84zrLK4aNuIbn53bU4TPJqHkwiTu5Jd8xkxwL
 pgYiXOhP+FSBWRi5BZ9wJ5qw/AuURqMzwarOcqJ34hvQofeE3x2vvV0
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Fernsehfee ("TV fairy") 3.0 is a set-top box with HDMI input and output
ports. It originally ran Android 4.4 and a Linux 3.10 kernel.

  https://fernsehfee.de/  (German)
  https://telefairy.com/  (English)

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 0647851ae1f55a27bfb148252532bcf15ca905bf..f6f045528da32cf4625b30da59262ca21da860e6 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -27,6 +27,7 @@ properties:
         items:
           - enum:
               - minix,neo-x8
+              - tcu,fernsehfee3
           - const: amlogic,meson8
 
       - description: Boards with the Amlogic Meson8m2 SoC

-- 
2.48.0.rc1.219.gb6b6757d772




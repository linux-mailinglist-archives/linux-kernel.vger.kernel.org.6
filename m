Return-Path: <linux-kernel+bounces-560478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A7A6051F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD7119C4605
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85BF1F8BDF;
	Thu, 13 Mar 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3PDUsXS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3D1F8ADF;
	Thu, 13 Mar 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741907461; cv=none; b=NSgBYxzGN8UmpfZtTdeOiC5OKaXgCf5ByCWqV/naN/ZcjAk3qrdWX1Uq/PJdufH11px4HlzBjSqoTx45Jja8/UGqFWji8SXHT7kxd+Y+5wYQ+CIve6QjtxnppASVhTIpd3ftbQincdJ78KT+ra40YAtQpsDGxDX3j9NjPV1PR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741907461; c=relaxed/simple;
	bh=cXVyoRypaze7f+Lz1yx3qPNU5d4wDrkDtX8Re+XtxgY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KxTfybOAAhz8jJNp0cHL7S38xq3ZnKqOTvKqwkUQiAcTQyMwuql3vfxBkWvyRtKpdwN0PfD3TNxTAZjBY3DtCpoTHEem3KCzMMwu/Ki9J1G5Kz1YaXuJy7mbygX/FKo6gxoTZkoAoyNnM2AVsBogwKcIWUaUjqGCOVaXtP1kT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3PDUsXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16169C4CEDD;
	Thu, 13 Mar 2025 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741907461;
	bh=cXVyoRypaze7f+Lz1yx3qPNU5d4wDrkDtX8Re+XtxgY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=b3PDUsXSUn4yAJcNWG/UXUc0yTU2grWPne5L7CY4r0ziVQNimoEZalJ2v2D1Cnt+N
	 bhKxgn+aVCQC5eOV7Uf3JwFlm/FciXA2d2l6+pUxPGVmXGYzDh1l55RBi5m8CDSfqE
	 DCUgxvG26/YLBE/zb5B5wpt6LtjKQCabjMzo0AbxwoeH6xwc0zuummcpKf0oZ+MgVo
	 5Uyt3g8FLu4pX2d9g8yZcffGUWw5r9s/SXpSyPXasQVnKKaGqpPBAnqDGcEuQw6Ph8
	 KH4+eCerg5HuLf/l1KbNtF7iGJfDsQgz4Vsc+ulpURv6/gb/KUDc2id/+MHRLEOHKS
	 EtFQ5F/A+oJlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067F0C282DE;
	Thu, 13 Mar 2025 23:11:01 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v2 0/2] arm64: Device Tree for Ugoos AM3 board
Date: Fri, 14 Mar 2025 00:10:58 +0100
Message-Id: <20250314-ugoos-am3-v2-0-422104b0cec5@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAJm02cC/03MQQ6DIBCF4auYWZcGBlDrqvdoXKAdlUXBADVtD
 HcvtZsu/5eXb4dIwVKErtoh0Gaj9a4EnioYF+NmYvZeGpCj5ojInrP3kZmHZFPdKCHbmiupoPz
 XQJN9HdatL73YmHx4H/QmvutPkfzyp2yCcSbb0QzaqAb1cF19TOTPjhL0OecPNrVgyKMAAAA=
X-Change-ID: 20250222-ugoos-am3-f67413860434
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741907460; l=1015;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=cXVyoRypaze7f+Lz1yx3qPNU5d4wDrkDtX8Re+XtxgY=;
 b=EMJcVnU8xlRkgiTfuaF1TgDC/Cipw+ftS76kCrZ0lMvFf5GpTyGf5oOolGy6r7AhJM4pXhZCI
 yQvY8GnkHuzBGf7CLT58q9JRTOPS6BKhzJVs76y6QepwJkvBXX3UV/L
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

This patchset adds a device tree for Ugoos AM3, an Android TV box from
2018. Most hardware functionality has been tested, as noted in patch 2/2.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v2:
- fix vendor name in patch subjects
- fix mistake that made wifi not work
- apply Krzysztof's ACK to patch 1/2
- Link to v1: https://lore.kernel.org/r/20250309-ugoos-am3-v1-0-38cab5a4725b@posteo.net

---
J. Neuschäfer (2):
      dt-bindings: arm: amlogic: Add Ugoos AM3
      arm64: dts: amlogic: Add Ugoos AM3

 Documentation/devicetree/bindings/arm/amlogic.yaml |  1 +
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  2 +-
 .../arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts | 91 ++++++++++++++++++++++
 4 files changed, 94 insertions(+), 1 deletion(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250222-ugoos-am3-f67413860434

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>




Return-Path: <linux-kernel+bounces-211268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84D5904F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B68B2392C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AAD16DEB5;
	Wed, 12 Jun 2024 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Dr7DPNum"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234F16D9C2;
	Wed, 12 Jun 2024 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184590; cv=none; b=YFeip+A8zi7murcmsy07JfkZUjyiAzFjiF/xyYc4XXlC+7/edoGBE70JvNXxcZ9X5/Ov1d4On9y1ozaxPbU+eSZZlZ89W6rwCmFhd1/6Ps2CtRX4Ymhn/ABrmuFbFOSh9wNwcXO2E8+H2JHJ9U1UMHRL4IIk/8Z0U9boW22RXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184590; c=relaxed/simple;
	bh=rFs6324PNSNEr+KrQbB0/JC7iriAaHajaKyTasMSKrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=In2p/QxKSdcfT6yuy3em0j5/SQwX+LZxKFonROK3z63VBt8YFOVeeNNyAhjD0lFWgPO21TjphD4gr5BuTltV0/aCzj63vYKQPKcwDY/LmXKOUwxuiKhOaQK9sUo6lhjPqdU0x8HbOqzdjexC044gT32tY6ZK5liO5BvKQ4OR3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Dr7DPNum; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0BF551FCBE;
	Wed, 12 Jun 2024 11:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1718184585;
	bh=Uif8SokEBNPcdv/uzxFpcgOwjzaU/nH1FeWne+W/Rwo=; h=From:To:Subject;
	b=Dr7DPNum7Pp+kftR635PcT7EIqNtum6OeIOvfvfBUB6RzYu6jv2kVL6HBnvyoiJEK
	 +vTtNuU01DCsv9aXo7koOMDS6wRfbPF0Ejxsr5yYk7u8vWG5Yjxj2LJ4zerF+VUku/
	 rmFdBFvJmWmJdA1cMi/FM+sJu/fQ8e0C+JnN2uMbbTPdDyG4D4IOP5Pmc+dXIKgWi2
	 7S4uQ6vMM828Tk5Bn7PssZlbw2zOp8hurf7tx1RFCW3jq9ezSUDkKp0KyWrAtNYmAI
	 CtqUzRB2jf5BX+0HTB4NBfLwqho+w90WJfW6FIkiGSAF3AB+eFY0zA4NOsVWcYuGa2
	 VcuQDq1Gu8sLQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Eggers <ceggers@arri.de>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: eeprom: at25: add  fujitsu,mb85rs256 compatible
Date: Wed, 12 Jun 2024 11:29:34 +0200
Message-Id: <20240612092934.12282-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The fujitsu,mb85rs256 is a 256 Kbit SPI memory FRAM in the same family
as the two existing fujitsu,mb85rs* compatibles and at25 compatible.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
No changes in the driver is required for this to be used, a device tree
file using it will come in a later step. Sending to minimize work
slowdown because of TI DT maintainer requirements on DT bindings, see
https://lore.kernel.org/all/469be7c2-6865-40d4-bd06-15dc3a08b3e3@kernel.org/
for more details.
---
 Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
index 1715b0c9feea..c31e5e719525 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -28,6 +28,7 @@ properties:
               - anvo,anv32e61w
               - atmel,at25256B
               - fujitsu,mb85rs1mt
+              - fujitsu,mb85rs256
               - fujitsu,mb85rs64
               - microchip,at25160bn
               - microchip,25lc040
-- 
2.39.2



Return-Path: <linux-kernel+bounces-257067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE69374B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80ED1C216E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5B178C63;
	Fri, 19 Jul 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBirLaI7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E1482ED;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376492; cv=none; b=dN5ZxIxtkbixt6UcV7SKp5V/KG23PNd+Kp4VCvb4KiWSmP4eBpzoTLWJ6bdKe//k36Vbhjz8o4J4+CJU/4XAxAx+ioi8N2ufYd1/0WHxqBXMXVOla9q57Po8YLAHC7bYWm7izpwznqMFfy12QIHkipTqgIgiMIBahNlMVUspsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376492; c=relaxed/simple;
	bh=7LKVRVwmEVDYk3bjN/+0LigjRWWH8ffXzL4TdtBLFVA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iFKTte2aXlRP6Of0efom6iYKN6neOsfNs3Ir4iT8zSe+NWjYvh7LsqX2SBHi/9RcuDR84K+WJOwWS2ss2I3ifRcCLeewyaV1y+nZpwyeyAJXURTZ1jMDB9IHByrEUl/n34rg6bd7++wbID1xfA/hIFJnaLowsAONCUheFvLpXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBirLaI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17C2CC32782;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721376492;
	bh=7LKVRVwmEVDYk3bjN/+0LigjRWWH8ffXzL4TdtBLFVA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XBirLaI7c31+5jV0NjJ0Prrd8onZrRMdkVy+LnWcv+Up3IOUq2qnISSPM1wjejxRs
	 L57tecpbWZKUcI32elU2Ic7Ff1mzG+Kz7LLv6en8tC0eRjAdrp3C97CPqwi+NGM+2x
	 7k9EkGeDqZnKgX+4BhbdUKh9gsDYPj8+e5WQoF48aSsYMzKdk+69OzlgP8xnI1Yeuz
	 KQ4Wb3ZSl6sTiywuQ3+hZMkjZaKPrlZ52YmGCE6pvIiw0HQVMUe5U9aYZSifpQeTTo
	 WSUFvwg3KhAeiSypKCIn/XC6yA300CAmNNbIkw/ZBK8TmfCDTcLAm86G3KwRHfiYUW
	 /F+SvfDQOOjiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A0EC3DA59;
	Fri, 19 Jul 2024 08:08:11 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/6] Add new Amlogic SoCs info defines.
Date: Fri, 19 Jul 2024 16:08:08 +0800
Message-Id: <20240719-soc_info-v3-0-020a3b687c0c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOgemmYC/1WM0QqCMBhGX0V23WL719R51XtExNym/pAuthiF+
 O5NIbLL8/GdM5PoArpImmImwSWM6KcM4lAQM+ipdxRtZgIMTqzinEZvbjh1nlrGVV22wjqmSL4
 /guvwtaUu18wDxqcP762c+Lp+I/CLJE4ZZbLVSipQVuqzHu++R3M0fiRrJsFelTsVsipqUZraG
 Ki0/FeXZfkAoB1TKt0AAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721376490; l=1524;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=7LKVRVwmEVDYk3bjN/+0LigjRWWH8ffXzL4TdtBLFVA=;
 b=03k0kiFTbLlRWeqcsAMnewiqN5jSFCs+tiUCSgsdoOTbPtJmGTZXV0El9DLJOgqfbKM9MGQQp
 ULKorzEzZCuBze6G3TP98JjvNnVIe+9qKBT4r2qchDHIZfOkPpVE2Km
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add more Amlogic SoCs info defines, include S4, C3
T7, A4, A5.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v3:
- dt-binding: Delete full stop for subject and modify description.
- Link to v2: https://lore.kernel.org/r/20240715-soc_info-v2-0-3836c8cc27a5@amlogic.com

Changes in v2:
- Add S4,C3,T7,A4 ao-secure bindings.
- Modify ao_secure node using fallback to meson-gx.
- Link to v1: https://lore.kernel.org/r/20240712-soc_info-v1-0-05ba95929d5a@amlogic.com

---
Xianwei Zhao (6):
      dt-bindings: arm: amlogic: meson-gx-ao-secure: support more SoCs
      soc: amlogic: meson-gx-socinfo: add new SoCs id
      arm64: dts: amlogic: s4: add ao secure node
      arm64: dts: amlogic: c3: add ao secure node
      arm64: dts: amlogic: t7: add ao secure node
      arm64: dts: amlogic: a4: add ao secure node

 .../bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml | 16 ++++++++++++----
 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi       |  8 ++++++++
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi              |  7 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi              |  8 ++++++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi                |  8 ++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c                   | 10 ++++++++++
 6 files changed, 53 insertions(+), 4 deletions(-)
---
base-commit: db067bd17c0124228c31c5fdfa29ec65239e692a
change-id: 20240711-soc_info-d01986b3de09

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>




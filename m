Return-Path: <linux-kernel+bounces-250258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE7D92F5C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730E61F235CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B713E023;
	Fri, 12 Jul 2024 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHg69xax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4A13D539;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767290; cv=none; b=rktjOCG5Po4sdjvnbw9SXay8dF1DeFviUG5ngMOynsFAbT8fplsVeKFBxou9M9OYsxZcFAm1Jnz2QWQw6iBs9BRvUHau7D8+7iu+0vkrmETNM1HxV2etcc2FpZS9lpIZ94vcJluNp3kYS4TT7TFancpC8oLAMDz3tmaCegB9748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767290; c=relaxed/simple;
	bh=PvK+uz7Ai6tJ90bdUtIav76E5cwMtKsTobObKEyJQhk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Olummb4BvNNIdRx8eV4vhlYey+XqZrUOn+uhSOEr6ZYFS2/bQfxcXpYpMF9Gu4Vygc9MSAk6ef8X0VgvxtGf1FDWFAvUKwmA4DTA+8vH/j+4b6D4t1Jit9P1/Y9xb7jRBlYafLvptcX1o92fHjxTrRgrpRsdNnGyI8a+acm7IhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHg69xax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C2D6C3277B;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720767290;
	bh=PvK+uz7Ai6tJ90bdUtIav76E5cwMtKsTobObKEyJQhk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rHg69xaxLM/J32jgGt5q1pbpOF9juJ3jKFGqtxYVz4hKsMqntneRvGAZZTh4yogT2
	 nIhApYhFig289BkkZYoNKfJWbdazj2SApzCAOJbT3/+wDMddV47vmJ/ESdo9CLT3gv
	 ElWELYsB+Arx3FekQrJ6fe/WOaoFeOB9IcgWoNv0qAvKiOEJLz/xc+G7VMYtzieY5g
	 x8owpl4VE0C6d8+MAF7gdRIg+yMjqAQJtGF33hZlRPn9whBuZSLxUchzuKIMjuJL09
	 4vSM8jdPAAJuJDDYGis9ldzIMyNm0aQyI49+QD9ay3/Q8QMYs8+/aKGDaaVjE5z0CB
	 2O27zyYazFzNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97B9C2BD09;
	Fri, 12 Jul 2024 06:54:49 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/5] Add new Amlogic SoCs info defines.
Date: Fri, 12 Jul 2024 14:54:45 +0800
Message-Id: <20240712-soc_info-v1-0-05ba95929d5a@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADbTkGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0ND3eL85PjMvLR83RQDQ0sLsyTjlFQDSyWg8oKi1LTMCrBR0bG1tQD
 Ub+yRWgAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720767287; l=938;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=PvK+uz7Ai6tJ90bdUtIav76E5cwMtKsTobObKEyJQhk=;
 b=NmECD3n5GJMLXnwBCHt6/k7L51BVXiv4OchwVFfnVoJoGiaEYCLk71XPDxK+/TIduxCOZMyeR
 8+FcVI9DInaAGOcpSUys66zVV0HlDCWD/is96VDFnU1DWoP029LI/hd
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
Xianwei Zhao (5):
      soc: amlogic: meson-gx-socinfo: add new SoCs id
      arm64: dts: amlogic: s4: add ao secure node
      arm64: dts: amlogic: c3: add ao secure node
      arm64: dts: amlogic: t7: add ao secure node
      arm64: dts: amlogic: a4: add ao secure node

 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi |  6 ++++++
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        |  5 +++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi          |  6 ++++++
 drivers/soc/amlogic/meson-gx-socinfo.c             | 10 ++++++++++
 5 files changed, 33 insertions(+)
---
base-commit: db067bd17c0124228c31c5fdfa29ec65239e692a
change-id: 20240711-soc_info-d01986b3de09

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>




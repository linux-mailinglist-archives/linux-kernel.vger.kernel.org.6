Return-Path: <linux-kernel+bounces-572836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E215CA6CF3D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA46189960F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AACE6ADD;
	Sun, 23 Mar 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttew/u6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F1163;
	Sun, 23 Mar 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742733502; cv=none; b=uw0csZ7XOGc967+FOvtx8XDq4Cl6f2RJSX8A4chaJVs67uxmy30hK9o4TjguqH+4HDx1ezxIG+0Y3jql+xx3ARt0Cc05I9pipEmv5ly9ZGcM/JKjQMHg4qrzX0zZskB/9zL8zLlHY+iL4hAbSrbKv46hc6ZGHZEXz7uwPPInMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742733502; c=relaxed/simple;
	bh=jd9wYHpyu6ZnNxDkrFxMFeP4lePw1I2neHhddWVkDjo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rfpF1t1m9EiyL1g6vX+RxLFLPJIHjL4j2+Jg+LIJm7l3TzyTUCiUg2ehYy69iFUrXJDrxOrVsBNl0xqzqv01IYFshSzHPrPYePt+VKzjgg+HJQ1UOKO44OFvDIt38URJmWVnrua64RN/x3YKPTsFn4q7/3xzMb/ycX1pV29dxKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttew/u6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C6A9C4CEE2;
	Sun, 23 Mar 2025 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742733502;
	bh=jd9wYHpyu6ZnNxDkrFxMFeP4lePw1I2neHhddWVkDjo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ttew/u6nQgjsmZc1H9mSur13NYjaBgIn/ReJVcimK3/wybUxVdwjM+4wEHv6fXxy7
	 41Azx/0Crxal6TbG2QQSK7seb3qVxRoOqMohF+VdrA7LwxcUmBlQmF6L93enqmsEKT
	 /J4fd6wk+/R+ysOrgjgjM/Yk00vsWJT4KGNQ7DpGZd4BFCIzLX4o8bYhxuY1Wzrd7G
	 Y1Fi5w0w4NLZ4FKC2z/d5RcpfkG6KWoC1OkjmWPIAFUyReMHOiXFkQawmt0JOe1wwL
	 SFo3J3FMzl7HYh+KE/wq7If7jAwL/WC7aJLsOLm1+hujELvwg5ogLO4EmzpTBb/35j
	 Bvr4bY11Zk3TA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24762C36002;
	Sun, 23 Mar 2025 12:38:22 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/3] Board support for Fernsehfee 3.0
Date: Sun, 23 Mar 2025 13:37:49 +0100
Message-Id: <20250323-fernsehfee-v1-0-2621341cd37a@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ0A4GcC/x3MQQqAIBRF0a3IHydoIlFbiQZmz/wTC4UIxL0nD
 c/g3koFmVFoEZUyHi58pQ49CPLRpROSj24a1WiV0VYG5FQQAyB36xBmo7ybQD24MwK//2zdWvs
 Ay4jP+1wAAAA=
X-Change-ID: 20250315-fernsehfee-b5aef930ca7e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742733500; l=1063;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=jd9wYHpyu6ZnNxDkrFxMFeP4lePw1I2neHhddWVkDjo=;
 b=AMu+SEgV81icPPkhvIuoyn3r3e/kUZ9XHrbb3+w4UrKlZvVcnjOaV72cWbnRxz1Tq+ff46kXf
 HnZqH8mi1+GCDMiKMW7SNQtuKWKX4QVY/VSCHW+Icx2oN8iNGjFWRtI
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

Fernsehfee[1] ("TV fairy") is a family of set-top boxes marketed as
ad-blocking appliances. This patchset adds board support in the form of
a device tree for the third generation, Fernsehfee 3.0.

[1]: https://fernsehfee.de/ (German), https://www.telefairy.com/ (English)

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (3):
      dt-bindings: vendor-prefixes: Add TC Unterhaltungselektronik AG
      dt-bindings: arm: amlogic: Add TCU Fernsehfee 3.0 board
      ARM: dts: amlogic: Add TCU Fernsehfee 3.0

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/boot/dts/amlogic/Makefile                 |   1 +
 arch/arm/boot/dts/amlogic/meson8-fernsehfee3.dts   | 219 +++++++++++++++++++++
 arch/arm/boot/dts/amlogic/meson8.dtsi              |  18 ++
 5 files changed, 241 insertions(+)
---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250315-fernsehfee-b5aef930ca7e

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>




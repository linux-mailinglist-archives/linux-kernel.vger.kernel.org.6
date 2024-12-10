Return-Path: <linux-kernel+bounces-439208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B949EAC45
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DAC16AF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD91DC9A2;
	Tue, 10 Dec 2024 09:33:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCFF1DC986
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823182; cv=none; b=UrppUOZ2LoAGLE6z2pZgDNxqazGLVK3/FPhziNu/86vl0EmoTxFqH0U255PMZ5iOq5m/C/nvBopE6rkjojxhG/yLVU/aakb35jAfW6wZmxXv7YfW2IURFEEmKN6fXYaNEro8lAGsuukZQhFrL0bChcydThzW1chzevDUmcm2UZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823182; c=relaxed/simple;
	bh=HKiruRlQ8GHPPhhFC5ESR04Rr/ImqoZPslgdTnFndnk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m27vmk11izxYFxoc3if2xxNp6CaO+ALy8cOjDQn9HcyWx+C5lVKATkYM9s1yuoaKeM6kWwmu6Q8TcVUSUZGKoYD1vBo6q5YsA2WVQX/3Bi6V/ikqtJqJVM3DIlgkT0aEcJHRCKHDtx7947QFAF/dAno/BUOqty+Gb7cAU5b5zfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKwbt-00016M-Cm
	for linux-kernel@vger.kernel.org; Tue, 10 Dec 2024 10:32:53 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKwbs-002fKj-0k
	for linux-kernel@vger.kernel.org;
	Tue, 10 Dec 2024 10:32:53 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 573ED38A554
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:32:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5601D38A530;
	Tue, 10 Dec 2024 09:32:49 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 03d2ec73;
	Tue, 10 Dec 2024 09:32:48 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH stm32-next 0/2] ARM: dts: stm32: lxa-fairytux2: add
 gen{1,2} boards
Date: Tue, 10 Dec 2024 10:32:26 +0100
Message-Id: <20241210-lxa-fairytux-v1-0-9aea01cdb83e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKoKWGcC/x3MTQqAIBBA4avErBvwJ4i6SrSQHGugLNTCiO6et
 PwW7z0QKTBF6KsHAl0cefcFsq5gWoyfCdkWgxKqkUoKXLNBZzjc6cxIrRZd21lttYOSHIEc538
 3QEybVugpJxjf9wMafIQVagAAAA==
X-Change-ID: 20241210-lxa-fairytux-e730979d3d3f
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HKiruRlQ8GHPPhhFC5ESR04Rr/ImqoZPslgdTnFndnk=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnWAq1AGU1iR460N/LjDVUHpWI3w+EBI35VdzKf
 PM2WBLZsg6JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZ1gKtQAKCRAoOKI+ei28
 b2GgB/sFExtFNFhwSfWjXlZxiBjMv07cQGhZOibWg9XfyOemOkjwBlOQbOjy8E/aNkUVNqKEo3Y
 dBVqILOuuE29FIriIHR05MNLeu6o6hu0feLq2QvOTs09S5xqMtBoCPMtO47NAnc8zYRTxz+YV0J
 +WRNNdQf71yzewgHgVq+6JLgXqqve0/YX9/Mav7/1SvVPY76+sV7qKc3c8typFC6FYvRAnkYU+D
 7fqcjMYxjzmcqHAcJoIsRcC5+7Qlo6eBPOz9zM/RS8kbsAB44lpoKigUDjqZuWK4GIzfzEUC7AZ
 LWVbINtO2I2u2LlR+TUtOl7r5Ph651mbwXVz+QcEHUZA/ZEX
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series adds support for the Linux Automation GmbH FairyTux2
boards generation 1 and 2.

The FairyTux2 is a small Linux device based on an Octavo Systems
OSD32MP153c SiP, that occupies just two slots on a DIN rail.

regards,
Marc

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Leonard Göhrs (2):
      dt-bindings: arm: stm32: add compatible strings for Linux Automation GmbH LXA FairyTux 2
      ARM: dts: stm32: lxa-fairytux2: add Linux Automation GmbH FairyTux 2

 .../devicetree/bindings/arm/stm32/stm32.yaml       |   2 +
 arch/arm/boot/dts/st/Makefile                      |   2 +
 .../boot/dts/st/stm32mp153c-lxa-fairytux2-gen1.dts | 101 ++++++
 .../boot/dts/st/stm32mp153c-lxa-fairytux2-gen2.dts | 146 ++++++++
 .../arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi | 394 +++++++++++++++++++++
 5 files changed, 645 insertions(+)
---
base-commit: 08d312c944095df2b73e9959c2bb16073820ecdd
change-id: 20241210-lxa-fairytux-e730979d3d3f

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>




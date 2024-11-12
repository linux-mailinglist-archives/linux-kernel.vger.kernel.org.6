Return-Path: <linux-kernel+bounces-406826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3338B9C64AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAB2283FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6060121C18F;
	Tue, 12 Nov 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="HcG30ugS"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BF21B42F;
	Tue, 12 Nov 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452477; cv=none; b=XAvjfTPxaPNFq5EamN8YH5wthxW505t5S3e5yQP7OYkY3eieaahAg2/PPYHwEvvKwIHA/6Izuu3O7sa/Ez9Bithc99ysThJ+oEJoFJhRcmTTKLmykSljc0nm/JyNDVESEH1ODkOee+L8Hngyb+//X9jiKP+2yEjT2bh+ZiONcuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452477; c=relaxed/simple;
	bh=VRtK1L9MXOutfyyDx+cVSqkmfeMV69EEUT6UlFNsfVQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtaSQzVjghh27FEQieUAQ8duEJeryadg60/FZYPvCYF7QdsC0v95keKUdYfLZNFMzmS3dQJ/9KvI42c0t24qJsRUL55IcM5qD1uCyPdKb6ssH//+9+Cb9ilQiO856pwYL7jPFeX3SZm++8yWZd3ZP4rppMZnhIZLOTfuLYla9O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=HcG30ugS; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9C924100005;
	Wed, 13 Nov 2024 02:01:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9C924100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731452463;
	bh=cXjF/08/uHuNwfsNL3HSBdbEnOMXo3XKzT0FEL1U4H0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=HcG30ugSU6t64rj37M6G2AX3xe2/J1fBvwQT5XW2Oyr2gJ6CjWYK0m10IIkNGlTSb
	 oCc9e4Se7xBpdHqsbH+S7v7jORY/Zy+YBR7ILOg114zXhgDX9QAiJDJpL88iHYFzCK
	 1DpHobygxLxhLPDfMKU6CbwQpU0sKXRsGuON7NQMHaylma792OaQMOUVkyVVh91zGO
	 0l2CQw6ZitCSKoPbhMjdiSJZ8vRKrg1GQb/PJm7NEW3vDY6hh/esPPIsaPDiEaKSyf
	 GJlwErA5Eqh/8FCxjvXZP6E5c9TlHpjPw8vpSDIW7TcN8ya3gQtE/Jey153S1Ckx3e
	 94FBbCbVBcMew==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 13 Nov 2024 02:01:03 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Rob
 Herring" <robh@kernel.org>
Subject: [PATCH 2/2] reset: amlogic: add support for A1 SoC in auxiliary reset driver
Date: Wed, 13 Nov 2024 02:00:56 +0300
Message-ID: <20241112230056.1406222-3-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112230056.1406222-1-jan.dakinevich@salutedevices.com>
References: <20241112230056.1406222-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189131 [Nov 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_smtp_not_equal_from}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/12 21:10:00 #26864167
X-KSMG-AntiVirus-Status: Clean, skipped

Add support for the reset controller present in the audio clock
controller of A1 SoC families, using the auxiliary bus.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/reset/amlogic/reset-meson-aux.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/reset/amlogic/reset-meson-aux.c b/drivers/reset/amlogic/reset-meson-aux.c
index dd8453001db9..4b422ae5fcd2 100644
--- a/drivers/reset/amlogic/reset-meson-aux.c
+++ b/drivers/reset/amlogic/reset-meson-aux.c
@@ -26,6 +26,18 @@ struct meson_reset_adev {
 #define to_meson_reset_adev(_adev) \
 	container_of((_adev), struct meson_reset_adev, adev)
 
+static const struct meson_reset_param meson_a1_audio_param = {
+	.reset_ops	= &meson_reset_toggle_ops,
+	.reset_num	= 32,
+	.level_offset	= 0x28,
+};
+
+static const struct meson_reset_param meson_a1_audio_vad_param = {
+	.reset_ops	= &meson_reset_toggle_ops,
+	.reset_num	= 6,
+	.level_offset	= 0x8,
+};
+
 static const struct meson_reset_param meson_g12a_audio_param = {
 	.reset_ops	= &meson_reset_toggle_ops,
 	.reset_num	= 26,
@@ -40,6 +52,12 @@ static const struct meson_reset_param meson_sm1_audio_param = {
 
 static const struct auxiliary_device_id meson_reset_aux_ids[] = {
 	{
+		.name = "a1-audio-clkc.rst-a1",
+		.driver_data = (kernel_ulong_t)&meson_a1_audio_param,
+	}, {
+		.name = "a1-audio-clkc.rst-a1-vad",
+		.driver_data = (kernel_ulong_t)&meson_a1_audio_vad_param,
+	}, {
 		.name = "axg-audio-clkc.rst-g12a",
 		.driver_data = (kernel_ulong_t)&meson_g12a_audio_param,
 	}, {
-- 
2.34.1



Return-Path: <linux-kernel+bounces-519899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D729A3A34F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453041890608
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E226FA4E;
	Tue, 18 Feb 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="JT7M3Vf8"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECB26F464;
	Tue, 18 Feb 2025 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897815; cv=none; b=bmPxlAahRi+IdH0Opn3jJBqpNqKIckPUVZ7A+RnovsaPPZnsmMW9igc4I6bwBo3xZPWej78AynC/RmGT+n06pEEGE+5BJdU1XsVdkeDQy48LCiKAADNgVqdwloD6GWFs7E2qk0QY5Nd2Jvo8I/wApJee0twnemkO3pOqgfGzKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897815; c=relaxed/simple;
	bh=1Z+E4K93ItU1vKD7N9kAJm1Yd2bIpepWNCurOWLgMFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lpw1J/uLFfgcGWihXIFZsPudxq8O6AieeylUbbIEFpXyGI80NfRw/GU7Wg5pLCDxImGFDbuGAVgz1b51iGbBG5JEbFFhp1XK2wGsDfGboChGlDg6jbc0bWu6ja9NcXlO9ypYoMQHUl1InyNI3MQn/LEp5I3zg+NVXQG08SGsOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=JT7M3Vf8; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 0F7CC1FDF4;
	Tue, 18 Feb 2025 17:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1739897806;
	bh=VTT5nixGLScMkP/ESGSGO/qN0E/oO+2nTyHJ2WATgu4=; h=From:To:Subject;
	b=JT7M3Vf8OD8GwmqxEQbrF6fC0Oq/4kh4pwAh+BNfikSUPNvIMjuJ7u71pXFbmSiuG
	 z9qHKCZQAVKtKpXFtvsv+9fjOgsNL3niWxEtu5vuwYAyGFkpb3JHV/dISd9xLY+YKo
	 a/1xOI4s+31JsMlf/pTqEy6xxXazid7x5kDbGQREpdX7U8bBSWGTIJpDT4RCVX045A
	 L4kWJShCN6KmjUQhus+kFfQ95wTFXzY1QbeCek7EYCetYrJgb4INa5v9PBd5gNwAg9
	 5rF8600qkxSYj9QdSDXV/iMrvcAvFRr3u6B5+jQGkGqndopWsouJstCuUyjGAPIiCF
	 lfWQX68RSUQaA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] hwmon: (amc6821) Add PWM polarity configuration with OF
Date: Tue, 18 Feb 2025 17:56:33 +0100
Message-Id: <20250218165633.106867-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218165633.106867-1-francesco@dolcini.it>
References: <20250218165633.106867-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add support to configure the PWM-Out pin polarity based on a device
tree property.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/hwmon/amc6821.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 1e3c6acd8974..1ea2d97eebca 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -845,7 +845,7 @@ static int amc6821_detect(struct i2c_client *client, struct i2c_board_info *info
 	return 0;
 }
 
-static int amc6821_init_client(struct amc6821_data *data)
+static int amc6821_init_client(struct i2c_client *client, struct amc6821_data *data)
 {
 	struct regmap *regmap = data->regmap;
 	int err;
@@ -864,6 +864,9 @@ static int amc6821_init_client(struct amc6821_data *data)
 		if (err)
 			return err;
 
+		if (of_property_read_bool(client->dev.of_node, "ti,pwm-inverted"))
+			pwminv = 1;
+
 		err = regmap_update_bits(regmap, AMC6821_REG_CONF1,
 					 AMC6821_CONF1_THERMOVIE | AMC6821_CONF1_FANIE |
 					 AMC6821_CONF1_START | AMC6821_CONF1_PWMINV,
@@ -916,7 +919,7 @@ static int amc6821_probe(struct i2c_client *client)
 				     "Failed to initialize regmap\n");
 	data->regmap = regmap;
 
-	err = amc6821_init_client(data);
+	err = amc6821_init_client(client, data);
 	if (err)
 		return err;
 
-- 
2.39.5



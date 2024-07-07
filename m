Return-Path: <linux-kernel+bounces-243745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A19299FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 00:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3A31C20AD1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 22:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B6673451;
	Sun,  7 Jul 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="KJdGAjuJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EABA2F;
	Sun,  7 Jul 2024 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720391860; cv=none; b=PgfxY8+4GnMlDtMWw30bWWaS3FxGeYmrE57A89L2D9o8S3cmwzvGErNYRMDrjJ6nYwjV5Nzwv+OSkIPRNCw58IPZZHEuO48dOzhiwcegWIJC4poWR7kv2XprxEdsG/0IEgCAXNJo/PPPvLZI5sW5AWEaJnnjTWTXvO3oxmG+kU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720391860; c=relaxed/simple;
	bh=JGRuPp5f7tdBTXkrWe9oHs1o3E3gbeMCdlehVi8h2jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKkVOCvCtHAVoaJNs65vYiJsZbFerK7NrcaEV+y1hMDnWrYK/9rgJ8vQDGWPuMKXT50k/Ua2jxl/lfM+2xdTktbNrKEwkgxGwKEuEWT6TANcNH9e80qvfIYatgQiXbmLibSY5s9+R7LrbfnlrOhcFBIlxUNVPj20RGdpYUt0aqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=KJdGAjuJ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720391851; x=1720996651; i=j.neuschaefer@gmx.net;
	bh=n2e88QE5epBSVSFicZ+xqo5ic/O/WtKAyeT8qBcSr5U=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KJdGAjuJXlaLEqB/olJSe4NX2VxaK5RCGYHZHR3WRiFnUAegjNdK/RvlHTm0f/tf
	 jphKzkot7QvbhNtfVwgsXdAg0AC1WNFh06HzHXgaE4hqoid+DD5RvRLIUj4I9snV8
	 b5os4qikT7jBMzg0T0DxnkMWWDw3YPNs66Br6nP1DoiYdEH6suDzTmqb+Oy/bT+EK
	 rPGb0QaplIYVY1nGyelLo325HYHbBO7Xr9x22o2/PvJSwnXtF2HYA7QHMvwclVpkV
	 Ozb8Q8epTiNl7hTKrSG1xjzqLNf4LFkiYr3OySN9PsDCaHQMZWiO5GYcWf0o3Ukkb
	 2avbtfebRX09ZqLuaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1sosgE3HLc-00URNO; Mon, 08
 Jul 2024 00:37:30 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Mon, 08 Jul 2024 00:37:15 +0200
Subject: [PATCH RESEND v12 2/6] clk: Introduce
 devm_clk_hw_register_divider_table_parent_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240708-wpcm-clk-v12-2-1afac539c37d@gmx.net>
References: <20240708-wpcm-clk-v12-0-1afac539c37d@gmx.net>
In-Reply-To: <20240708-wpcm-clk-v12-0-1afac539c37d@gmx.net>
To: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720391846; l=1760;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=VjLniaHS+bKcYFjCZNozqsTADYqMusOVNK5lpprhRBg=;
 b=rv01x0ZigBxViCJbV/XFzMikU4XwIA1huopJ6JjXnoERms/MWakBqqDwAG4ZFxZihfAVpXT5d
 Ga3re91UfEJCXrv1dsy0U5vSjPWIfg6htDOfG+0KerApP1NwE68AGl3
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:1Jc389Kojt8SzfnWbpW5lZPjQN2ceDAA16oAtax4xjmjn84Nm/b
 zPkTwh8LVVRwDoyP2P5cFDxsLv8xhWkzgoLgyV0qpTseGeckok15TOPyowZqVCd5auAMqhB
 5amQ5+0cwDohE5WL8pr7okh0cQ3B+aw37TxgfMYKjSbsC7Ch+xFCKQ9VYLsZS/fkvLNsAnJ
 RUHGvQRPe375M8R0DFheQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D74VmFvLRM4=;LZosBtBuPdECIBkLPqBbwVC1HfQ
 1y1/yvA5IB0jHsfybbxgkWzW+AFOD4iRW7PssOAXE14FL0KbrLpO+klZ9Wh26zYc7naWRYNk8
 yr9cdIK3CMj1e0ZqCdMYVdW1GCIZn0jouBfUNzRN5MCdYQsfxXDDjK4Wwv48bbdou6pv3oZ//
 kZGDZdWjeKkUBE9R1zQZ2W1VReTpLEQO5Z9mJ68pi7P4jbzRjdU8B5XogZyhjsDuS6zZ8MZ8F
 KCs965Vq76Bp6V5Bj7fC7iPy/dKIOCg1dN894UyldALAzRqOC4SlKfMheh+o4AyEJSoJ2EMvt
 P+0TWNEueKeSi+77zJFAxn4/20ZBJYxixCQxwwMVReeUt5OuFFuuAh+kZwh+qU1/PtEqqCyjt
 4xQGS+7nSKVqdptG0RkKQmKUorQEVI5DOnPF+ras2voNw41vlSsEVcQOptls6SMwiUThd3pqs
 +IYCXaeHazmzZS44jFkyxRqCxRr7US08f2gkMKUsjd+MVEG53VW3QM7gnP2J4zwS1AVibg6E0
 bG08QBL7SpJ+MKYZDIoZPGD/JYqVLXQEJZequ81OSomqXQvSfTjIKlW5BqX5gi/BzXvI9of18
 l79Ml2k5CXBFN2ryE4QYpTeKUEE/3oaAkfuK9X/CoX0dPaGM2HxlO4G4/gA8eyyqGvkfwxoE6
 JiBtGleLNKpOCvd4iztSj8Q7oS+1zdyMHaeaXHfbqoJuvXlG2DLwyYHFY5LyUMg6A2VpXVxAu
 ZR9CCbp/Eq+FottED286yF5MlLnAKiWIaJbaLe3jOGin3PavO1gkz4qLCTMxYH780l4Vc6PJ7
 5axIqQBPPoO9bhZ+pU+1xqHoCzD+5Xw6j0kxJiThazvAI=

Introduce the devm pendant to clk_hw_register_divider_table_parent_data.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/clk-provider.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 4a537260f6557d..5d537d0776a11f 100644
=2D-- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -932,6 +932,28 @@ struct clk *clk_register_divider_table(struct device =
*dev, const char *name,
 				       (width), (clk_divider_flags), (table), \
 				       (lock))

+/**
+ * devm_clk_hw_register_divider_table_parent_data - register a table base=
d divider clock
+ * with the clock framework (devres variant)
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_data: parent clk data
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @table: array of divider/value pairs ending with a div set to 0
+ * @lock: shared register lock for this clock
+ */
+#define devm_clk_hw_register_divider_table_parent_data(dev, name, parent_=
data, flags,   \
+						       reg, shift, width,               \
+						       clk_divider_flags, table, lock)  \
+	__devm_clk_hw_register_divider((dev), NULL, (name), NULL,               =
        \
+				       NULL, (parent_data), (flags), (reg), (shift),    \
+				       (width), (clk_divider_flags), (table),           \
+				       (lock))
+
 void clk_unregister_divider(struct clk *clk);
 void clk_hw_unregister_divider(struct clk_hw *hw);


=2D-
2.43.0



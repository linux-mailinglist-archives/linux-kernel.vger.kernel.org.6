Return-Path: <linux-kernel+bounces-328149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7959B977F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3657028AE54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287D1DB54F;
	Fri, 13 Sep 2024 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="N+Avhbhp"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC261DA0F5;
	Fri, 13 Sep 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229649; cv=none; b=iztcROJyi3+Bx6bcbFzj6NRloXhArFcuqDqyWQBE1j+UsRhmstN8wwh5iH0ccY8HxnJuWeA3j3yhBnzTXzJUCuMebD+34AH5B1g2EGCxcYwd4lK+G2KFZhNsMRSeXti0cvGWIrDwsitWGRNtoWfRk+ZWS1pAJhCZ6r2s6lYMQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229649; c=relaxed/simple;
	bh=i2Du9mw9yK4xJHzCM3GmoAp0Fx/Tme8q7/RpqMbHqDM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byJ20B60NX3HwevIUt4h9hGROojf7UEstXNpbHxYZDbxDYOwFKrlj3xAg77uaBw7SiloGbBiECnFdCo6jjIrALJawUBinkE7JMkYmhzEjWqVMjolikUxDCF8SNdLLOoCjMVXZPgm4Fy3iUhXvGgrDvrLc35pSzGPPPr2VfHwyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=N+Avhbhp; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 420FE12000B;
	Fri, 13 Sep 2024 15:14:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 420FE12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1726229643;
	bh=cY3K3FQ81SKp3EdwKgsF2p7UTyEFyh0HPwCNPtrZSZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=N+AvhbhprNJCsvYayYKolVYcK4EE93Mlff1jejsx50VtnsXFiWqqRLtWnTe3x1Exj
	 saeRC2XchKvxTOTjux/KhT+gruSv0eFcofJQO+RsVYDRbEfikBBamcgmMLAjaH+c/k
	 xNH2WlpDH0jhfBU+qdw0xyMwCCiF2E171rzcUGUOUQ7tSnpyVsGGYVAFj6JDfWryxF
	 0YyJrQ6T8X+VufuaGVpy17oTIv8z+/tAeElRPbfbfJo0wJ2Np42QHdviG0Ihw06EaF
	 K9i43telf6W9RECZplPAOXBgNj796dHIGyof4R1vX4vbtn5RWfJ71U1pe1ipwrog55
	 JhjsNX77CTadQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 13 Sep 2024 15:13:53 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH v4 2/5] clk: meson: axg: share the set of audio helper macro
Date: Fri, 13 Sep 2024 15:11:49 +0300
Message-ID: <20240913121152.817575-3-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
References: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 187732 [Sep 13 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_smtp_not_equal_from}, sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/13 10:05:00 #26575345
X-KSMG-AntiVirus-Status: Clean, skipped

These macro will be used in upcoming audio clock controller
for Meson A1 SoC.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/clk/meson/axg-audio.c   | 138 +-----------------------------
 drivers/clk/meson/meson-audio.h | 143 ++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 137 deletions(-)
 create mode 100644 drivers/clk/meson/meson-audio.h

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index beda86349389..0d911e06a29f 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 
 #include "meson-clkc-utils.h"
+#include "meson-audio.h"
 #include "axg-audio.h"
 #include "clk-regmap.h"
 #include "clk-phase.h"
@@ -23,52 +24,6 @@
 
 #include <dt-bindings/clock/axg-audio-clkc.h>
 
-#define AUD_GATE(_name, _reg, _bit, _pname, _iflags) {			\
-	.data = &(struct clk_regmap_gate_data){				\
-		.offset = (_reg),					\
-		.bit_idx = (_bit),					\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "aud_"#_name,					\
-		.ops = &clk_regmap_gate_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
-	},								\
-}
-
-#define AUD_MUX(_name, _reg, _mask, _shift, _dflags, _pdata, _iflags) {	\
-	.data = &(struct clk_regmap_mux_data){				\
-		.offset = (_reg),					\
-		.mask = (_mask),					\
-		.shift = (_shift),					\
-		.flags = (_dflags),					\
-	},								\
-	.hw.init = &(struct clk_init_data){				\
-		.name = "aud_"#_name,					\
-		.ops = &clk_regmap_mux_ops,				\
-		.parent_data = _pdata,					\
-		.num_parents = ARRAY_SIZE(_pdata),			\
-		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
-	},								\
-}
-
-#define AUD_DIV(_name, _reg, _shift, _width, _dflags, _pname, _iflags) { \
-	.data = &(struct clk_regmap_div_data){				\
-		.offset = (_reg),					\
-		.shift = (_shift),					\
-		.width = (_width),					\
-		.flags = (_dflags),					\
-	},								\
-	.hw.init = &(struct clk_init_data){				\
-		.name = "aud_"#_name,					\
-		.ops = &clk_regmap_divider_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = (_iflags),					\
-	},								\
-}
-
 #define AUD_PCLK_GATE(_name, _reg, _bit) {				\
 	.data = &(struct clk_regmap_gate_data){				\
 		.offset = (_reg),					\
@@ -82,97 +37,6 @@
 	},								\
 }
 
-#define AUD_SCLK_DIV(_name, _reg, _div_shift, _div_width,		\
-		     _hi_shift, _hi_width, _pname, _iflags) {		\
-	.data = &(struct meson_sclk_div_data) {				\
-		.div = {						\
-			.reg_off = (_reg),				\
-			.shift   = (_div_shift),			\
-			.width   = (_div_width),			\
-		},							\
-		.hi = {							\
-			.reg_off = (_reg),				\
-			.shift   = (_hi_shift),				\
-			.width   = (_hi_width),				\
-		},							\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "aud_"#_name,					\
-		.ops = &meson_sclk_div_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = (_iflags),					\
-	},								\
-}
-
-#define AUD_TRIPHASE(_name, _reg, _width, _shift0, _shift1, _shift2,	\
-		     _pname, _iflags) {					\
-	.data = &(struct meson_clk_triphase_data) {			\
-		.ph0 = {						\
-			.reg_off = (_reg),				\
-			.shift   = (_shift0),				\
-			.width   = (_width),				\
-		},							\
-		.ph1 = {						\
-			.reg_off = (_reg),				\
-			.shift   = (_shift1),				\
-			.width   = (_width),				\
-		},							\
-		.ph2 = {						\
-			.reg_off = (_reg),				\
-			.shift   = (_shift2),				\
-			.width   = (_width),				\
-		},							\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "aud_"#_name,					\
-		.ops = &meson_clk_triphase_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
-	},								\
-}
-
-#define AUD_PHASE(_name, _reg, _width, _shift, _pname, _iflags) {	\
-	.data = &(struct meson_clk_phase_data) {			\
-		.ph = {							\
-			.reg_off = (_reg),				\
-			.shift   = (_shift),				\
-			.width   = (_width),				\
-		},							\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "aud_"#_name,					\
-		.ops = &meson_clk_phase_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = (_iflags),					\
-	},								\
-}
-
-#define AUD_SCLK_WS(_name, _reg, _width, _shift_ph, _shift_ws, _pname,	\
-		    _iflags) {						\
-	.data = &(struct meson_sclk_ws_inv_data) {			\
-		.ph = {							\
-			.reg_off = (_reg),				\
-			.shift   = (_shift_ph),				\
-			.width   = (_width),				\
-		},							\
-		.ws = {							\
-			.reg_off = (_reg),				\
-			.shift   = (_shift_ws),				\
-			.width   = (_width),				\
-		},							\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "aud_"#_name,					\
-		.ops = &meson_clk_phase_ops,				\
-		.parent_names = (const char *[]){ #_pname },		\
-		.num_parents = 1,					\
-		.flags = (_iflags),					\
-	},								\
-}
-
 /* Audio Master Clocks */
 static const struct clk_parent_data mst_mux_parent_data[] = {
 	{ .fw_name = "mst_in0", },
diff --git a/drivers/clk/meson/meson-audio.h b/drivers/clk/meson/meson-audio.h
new file mode 100644
index 000000000000..cbcdbd487d4a
--- /dev/null
+++ b/drivers/clk/meson/meson-audio.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef __MESON_AUDIO_H__
+#define __MESON_AUDIO_H__
+
+#define AUD_GATE(_name, _reg, _bit, _pname, _iflags) {			\
+	.data = &(struct clk_regmap_gate_data){				\
+		.offset = (_reg),					\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = "aud_"#_name,					\
+		.ops = &clk_regmap_gate_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
+	},								\
+}
+
+#define AUD_MUX(_name, _reg, _mask, _shift, _dflags, _pdata, _iflags) {	\
+	.data = &(struct clk_regmap_mux_data){				\
+		.offset = (_reg),					\
+		.mask = (_mask),					\
+		.shift = (_shift),					\
+		.flags = (_dflags),					\
+	},								\
+	.hw.init = &(struct clk_init_data){				\
+		.name = "aud_"#_name,					\
+		.ops = &clk_regmap_mux_ops,				\
+		.parent_data = _pdata,					\
+		.num_parents = ARRAY_SIZE(_pdata),			\
+		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
+	},								\
+}
+
+#define AUD_DIV(_name, _reg, _shift, _width, _dflags, _pname, _iflags) { \
+	.data = &(struct clk_regmap_div_data){				\
+		.offset = (_reg),					\
+		.shift = (_shift),					\
+		.width = (_width),					\
+		.flags = (_dflags),					\
+	},								\
+	.hw.init = &(struct clk_init_data){				\
+		.name = "aud_"#_name,					\
+		.ops = &clk_regmap_divider_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = (_iflags),					\
+	},								\
+}
+
+#define AUD_SCLK_DIV(_name, _reg, _div_shift, _div_width,		\
+		     _hi_shift, _hi_width, _pname, _iflags) {		\
+	.data = &(struct meson_sclk_div_data) {				\
+		.div = {						\
+			.reg_off = (_reg),				\
+			.shift   = (_div_shift),			\
+			.width   = (_div_width),			\
+		},							\
+		.hi = {							\
+			.reg_off = (_reg),				\
+			.shift   = (_hi_shift),				\
+			.width   = (_hi_width),				\
+		},							\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = "aud_"#_name,					\
+		.ops = &meson_sclk_div_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = (_iflags),					\
+	},								\
+}
+
+#define AUD_TRIPHASE(_name, _reg, _width, _shift0, _shift1, _shift2,	\
+		     _pname, _iflags) {					\
+	.data = &(struct meson_clk_triphase_data) {			\
+		.ph0 = {						\
+			.reg_off = (_reg),				\
+			.shift   = (_shift0),				\
+			.width   = (_width),				\
+		},							\
+		.ph1 = {						\
+			.reg_off = (_reg),				\
+			.shift   = (_shift1),				\
+			.width   = (_width),				\
+		},							\
+		.ph2 = {						\
+			.reg_off = (_reg),				\
+			.shift   = (_shift2),				\
+			.width   = (_width),				\
+		},							\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = "aud_"#_name,					\
+		.ops = &meson_clk_triphase_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = CLK_DUTY_CYCLE_PARENT | (_iflags),		\
+	},								\
+}
+
+#define AUD_PHASE(_name, _reg, _width, _shift, _pname, _iflags) {	\
+	.data = &(struct meson_clk_phase_data) {			\
+		.ph = {							\
+			.reg_off = (_reg),				\
+			.shift   = (_shift),				\
+			.width   = (_width),				\
+		},							\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = "aud_"#_name,					\
+		.ops = &meson_clk_phase_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = (_iflags),					\
+	},								\
+}
+
+#define AUD_SCLK_WS(_name, _reg, _width, _shift_ph, _shift_ws, _pname,	\
+		    _iflags) {						\
+	.data = &(struct meson_sclk_ws_inv_data) {			\
+		.ph = {							\
+			.reg_off = (_reg),				\
+			.shift   = (_shift_ph),				\
+			.width   = (_width),				\
+		},							\
+		.ws = {							\
+			.reg_off = (_reg),				\
+			.shift   = (_shift_ws),				\
+			.width   = (_width),				\
+		},							\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = "aud_"#_name,					\
+		.ops = &meson_clk_phase_ops,				\
+		.parent_names = (const char *[]){ #_pname },		\
+		.num_parents = 1,					\
+		.flags = (_iflags),					\
+	},								\
+}
+
+#endif /* __MESON_AUDIO_H__ */
-- 
2.34.1



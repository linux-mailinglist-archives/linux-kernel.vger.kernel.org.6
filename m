Return-Path: <linux-kernel+bounces-363001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC099BC73
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 00:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE651F21516
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E72F153BD7;
	Sun, 13 Oct 2024 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="hIY9xGl/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="GX5if78X"
Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1E012DD88;
	Sun, 13 Oct 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728856849; cv=none; b=U+Tmq7pQ8mRrQz9KiG9z9tm3fBM1aZtNkjZdESXxdzUJtCZcGMSmUFIppRNmKItetJu1+dRrWnxV96GQu338DFWo6cA2cnwFKaiiibjw8AXlelnwATD1eS5FNIjZf4AA6++sOwBxbLx9so0HTysjek+BC1nD8uQTW4/erBpoHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728856849; c=relaxed/simple;
	bh=1ru/8GawJHh8A1Ww6eb4H2GuqQsPAxCqwN5ZhraaTVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdwsWlZFjBHuIb2GbgSZ9yUL00D+EZKjtKKAFwV6XEh8KQxD4XhYY6eRXeD4zLGa1cop5pRNfbS3n/zAeKq1ZxDuc8KIGIhmDrROjJX5+hlhxIr9YSyxioc4E6KglOLtcY5tZd9z5dIX0F/ISKd7xh/ydy6Z8GXxBlJn3v/pIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=hIY9xGl/; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=GX5if78X; arc=none smtp.client-ip=79.137.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=wTf6v2+TGd83Sp0nGCn6pq8XZPT4NIju7YdKdQGbVOE=;
	t=1728856846;x=1728946846; 
	b=hIY9xGl/g3BgKUBoRERpDwAwY+eb6Ka8DQlQ1VvJchijt7WeMASvaghn/dncX0dX9+4NxTPSXhdWVJ9BCHBaDdMQVxkz/8nB1TV2Hton/8YrhmABUYi3WQunwZCjx313lEZlG/KDO2e7ZR8ZPi/sJERtpDJT9Lq5J0tW2a0Zkhw=;
Received: from [10.113.224.111] (port=49898 helo=smtp47.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1t064f-001dMf-Ud; Mon, 14 Oct 2024 00:24:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=wTf6v2+TGd83Sp0nGCn6pq8XZPT4NIju7YdKdQGbVOE=; t=1728854665; x=1728944665; 
	b=GX5if78XbNC8pFmZkK7F8FMxy9qHqSbE5aRsTQa08bCUU8C0UbhBF0Qdu+obuNTPPVsTUTEUeIo
	DP3UiCsRc2X9RvVhlfpk0h7Okc4yLT6/U5mAlIDpzdONqczTT/jHMuz7yn/e9UymtRZ0Yl47SdnD8
	74T4WtgZusA1eLH4Q/4=;
Received: by exim-smtp-57f79c7799-ff99r with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1t064Q-00000000ArH-0s4h; Mon, 14 Oct 2024 00:24:10 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@mainlining.org,
	danila@jiaxyga.com
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Samsung AMS581VF01
Date: Mon, 14 Oct 2024 00:24:01 +0300
Message-ID: <20241013212402.15624-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241013212402.15624-1-danila@jiaxyga.com>
References: <20241013212402.15624-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9B01871A0ED523BBFE56F99792CC1187A2EC73447709F4BD8182A05F5380850406E7FB33D4B4328C83DE06ABAFEAF67055BC6F64EF08952066FE32FC68D7A262146CE9711DA951506
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE754E958D11587BC68EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370D3D68FCEFFDD9EA8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8D80433BF32B7D084B209FDF25BDF1A94BEAB23F424776338CC7F00164DA146DAFE8445B8C89999728AA50765F7900637CAEE156C82D3D7D9389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8B861051D4BA689FCF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C643FE6A0CAC512C7AD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3A56321EC42027325BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3B72D73EA5828B681DD303D21008E298D5E8D9A59859A8B64AAE2D1698E8717B75ECD9A6C639B01B78DA827A17800CE73CC03873634D8B89731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5D53DFCDFE1070C455002B1117B3ED6961826B60835AE4BFC8B25839F35DFE037823CB91A9FED034534781492E4B8EEADA2D5570B22232E1EC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF4DE2AA3320AD6A03222C191E1A294DB15BF9AA56AF1AAA199F0EFEEE4161720F614F3626C4CAF4337C85317C21026A4909E2A779DA5549DCE9F78341A6FF8F0F90528F950A47432C457F7985AD47CF5C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojTJ02HBIKT7LLFVMG8E5Mig==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981D35572ECED80C0D4A4C2FF93DD6D44FACBA524D8EFBCB867245DB624F8BFDAB12C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B42DA9BE0E4F7CCE4C920C9969AF7F7D5011794453575F640C049FFFDB7839CE9E3928B87FA8A99B442AE7A76241698217B44A80AA6BCE041B673800CA4E604211
X-7FA49CB5: 0D63561A33F958A520815084BF612BB56D63487BD8565A6B35B5EAECE2A4CD458941B15DA834481FA18204E546F3947CCEFAD8E628AF541FF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637D26DAE69EB993CAA389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3D8B0ABA717EF295735872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojTJ02HBIKT7KszZgF6fQGIg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

The Samsung AMS581VF01 is a 5.81 inch 1080x2340 MIPI-DSI CMD mode
OLED panel used in Google Pixel 4a (sm7150-google-sunfish)

Add a dt-binding for it.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../display/panel/samsung,ams581vf01.yaml     | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
new file mode 100644
index 000000000000..70dff9c0ef2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,ams581vf01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung AMS581VF01 SOFEF01-based 5.81" 1080x2340 MIPI-DSI Panel
+
+maintainers:
+  - Danila Tikhonov <danila@jiaxyga.com>
+
+description:
+  The Samsung AMS581VF01 is a 5.81 inch 1080x2340 MIPI-DSI CMD mode OLED panel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,ams581vf01
+
+  reg:
+    maxItems: 1
+
+  vdd3p3-supply:
+    description: 3.3V source voltage rail
+
+  vddio-supply:
+    description: I/O source voltage rail
+
+  vsn-supply:
+    description: Negative source voltage rail
+
+  vsp-supply:
+    description: Positive source voltage rail
+
+  reset-gpios: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vdd3p3-supply
+  - vddio-supply
+  - vsn-supply
+  - vsp-supply
+  - reset-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "samsung,ams581vf01";
+            reg = <0>;
+
+            vdd3p3-supply = <&vreg_l7c_3p0>;
+            vddio-supply = <&vreg_l13a_1p8>;
+            vsn-supply = <&vreg_ibb>;
+            vsp-supply = <&vreg_lab>;
+
+            reset-gpios = <&pm6150l_gpios 9 GPIO_ACTIVE_LOW>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.47.0



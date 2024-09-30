Return-Path: <linux-kernel+bounces-344827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C802C98AEA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47AD6B22707
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E951A0BD8;
	Mon, 30 Sep 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="uDxtQTNA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="ApjQNXjq"
Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E017BB38;
	Mon, 30 Sep 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729140; cv=none; b=cLoN7VObacqA0RwQ71a1s10F4LVvXLkS4pLrUJ9H+mv5qB0gawIWweDgcvmJZAJ8qv/MEeP8asLIjoNa0+/Yv3RP64Sp65O/0WQeB3dWcojr0E6Ki/WgiS2+tADjk7/TrsiShgzxWIbo8uhxJ1JC9O87+AjTG8OwkL18qVL0+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729140; c=relaxed/simple;
	bh=TsOnSevx4hMXfQvcvgRQLzIDi3ZqEpm4J8RmdBTglDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzO2vzTBX0kCzJbj5U84Dlz4VNOlLuEXNFVMAtBzh7afDG2hn7FyoFfbrHqEPJ6VTOP6IE8TKjfeJ6T9VyQLsPJOkjuS5Jf5OkspkS6rjgCR+WnkHGquot9b7fLhHC3QTlNns6fzVoNxiJVJvSHrJOyaJiOQcAB23O5pg/aSaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=uDxtQTNA; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=ApjQNXjq; arc=none smtp.client-ip=79.137.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=PxhCVGtUIuJ7J6cqVdVKr+Cm49KqIeWOvqPBYgYBa5k=;
	t=1727729137;x=1727819137; 
	b=uDxtQTNA8ar44w+Vm53c+011oqizKheoxgIClY4hZORHNM3Lhr6idKsyBX3ai9nW6lvTbnF7V7hWwZpe6QR/lj2e6cOdG6ygOyxTxIurNnOnXrz92QA31ReqbK1b2XHsk1vXHB8XQekLh25pyjb2pU6Ew1iccOaZj9p06zxKw6k=;
Received: from [10.12.4.21] (port=49798 helo=smtp42.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1svMxG-00Esp3-PP; Mon, 30 Sep 2024 23:25:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=PxhCVGtUIuJ7J6cqVdVKr+Cm49KqIeWOvqPBYgYBa5k=; t=1727727914; x=1727817914; 
	b=ApjQNXjqmNP5OPqVSsw1N3qLcy9N+IJjUrYUNWCRY4RI8h6rzHRmUTLGvxXCqRoW56pNLmR7vU2
	YIuVVzMM5OYIo6E3qEhuOEh6xRnvOyTvJaE+3zNGnAdLJQhLEfEBMxyiRNaWOMpndGx8aESCSuNjd
	bQIu7+gMJl0OfJJah9I=;
Received: by exim-smtp-69fb954d46-6fqd6 with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1svMx0-00000000HGp-3jGc; Mon, 30 Sep 2024 23:24:59 +0300
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
	adrian@travitia.xyz,
	degdagmohamed@gmail.com,
	linux@mainlining.org,
	Danila Tikhonov <danila@jiaxyga.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add Samsung AMS639RQ08
Date: Mon, 30 Sep 2024 23:24:47 +0300
Message-ID: <20240930202448.188051-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240930202448.188051-1-danila@jiaxyga.com>
References: <20240930202448.188051-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD964E86F54238FCC39B474B51A4E6CEF96B6E1A8C01776A3AB182A05F538085040C5079DD8336ADC963DE06ABAFEAF670525AE3DDD687D6CF81C5DC97C387795A5C252A97683EF5A77
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE768D1C4AD116E0413EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637652CD06254D2F21C8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8843912A15FB48208D31576F67790544C71592C162D32ECECCC7F00164DA146DAFE8445B8C89999728AA50765F7900637F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006370BDB19F53EE528DD389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637D72432E1BF4D7690D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE7E910352550E46763EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE793A5959F3D04F0182EB15956EA79C166176DF2183F8FC7C02686C055BC15B7FB725E5C173C3A84C3FE621C1A6B846BFC35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5BB2371B01055D4CB5002B1117B3ED6968D171F9D46A9DA6AC89B063BDC7FAC35823CB91A9FED034534781492E4B8EEAD3CCD70CEBBF18A22C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF539FB3CEAB1807D87F6407F29D2A09A721C1F27D838867DA33720CDAD78B4982614F3626C4CAF433A06F21331F7F71AF96F38EBABE2F3709DAB1623086507E5B48917B6C12D5565EF59F2EA2782EDE9C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojNqGc3Zc5qMlfFvWCV9/MZg==
X-Mailru-Sender: 0A26D9779F8DDEAB5292BC5C4A2F209382AEE2622AA5C0B8B951B70A5BD4BD8E03DEFA480B10434921401CF93FD6FA55210985D6C440852E55B4A2144138A88088F510C62CFD139357C462056C5AD9112068022A3E05D37EB4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4CB1E8E83197BFF842CA3A8D249ED4F83C5BD1728C4FF32B468F3CF0E9FE49B6959AB7659C5DDE2DEFA8A0982179D90B09DE3EEA89AEFE7D67F36B58840213823
X-7FA49CB5: 0D63561A33F958A5E32833A1BE94EB2968C820BE3BA284CAAC0D6620387F00AA8941B15DA834481FA18204E546F3947CE146BDB823D8AB78F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006379C15FCE41D14C6A4389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C39B1AFFD6BD8BDD3135872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojNqGc3Zc5qMluCHjjSWknlQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

The Samsung AMS639RQ08 is a 6.39 inch 1080x2340 MIPI-DSI CMD mode
AMOLED panel used in:
- Xiaomi Mi 9 Lite / CC9 (sdm710-xiaomi-pyxis)
- Xiaomi Mi 9T / Redmi K20 (sm7150-xiaomi-davinci)
- Xiaomi Mi 9T Pro / Redmi K20 Pro (sm8150-xiaomi-raphael)
Add a dt-binding for it.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../display/panel/samsung,ams639rq08.yaml     | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ams639rq08.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ams639rq08.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ams639rq08.yaml
new file mode 100644
index 000000000000..f5b6ecb96f99
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ams639rq08.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,ams639rq08.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung AMS639RQ08 EA8076-based 6.39" 1080x2340 MIPI-DSI Panel
+
+maintainers:
+  - Danila Tikhonov <danila@jiaxyga.com>
+  - Jens Reidel <adrian@travitia.xyz>
+
+description:
+  The Samsung AMS639RQ08 is a 6.39 inch 1080x2340 MIPI-DSI CMD mode AMOLED panel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,ams639rq08
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
+            compatible = "samsung,ams639rq08";
+            reg = <0>;
+
+            vdd3p3-supply = <&vreg_l18a_2p8>;
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
2.46.1



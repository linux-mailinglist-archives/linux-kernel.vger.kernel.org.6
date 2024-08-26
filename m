Return-Path: <linux-kernel+bounces-302326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A795FC99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC551F227A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D986819D082;
	Mon, 26 Aug 2024 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="T571HiBw"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5619CD1D;
	Mon, 26 Aug 2024 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710551; cv=none; b=ffjLjJJgicmZeRocVGAVx5YSB+sDcphf13ZNhcTolnxOvCKZRvZHWcC41qBBVQ8Gpqd2C2qYkMSGVpc8RjHGMYRjZ2sfJa8E7N3dyJpVWu9wkq8D1rFe3KswdAT9a7iXDc6Pw+BiSVrKgMSGI3VQhUBfzaGAJEnJWmpZ4pzToRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710551; c=relaxed/simple;
	bh=rfzqc55zCdpfzcYny2wFiR0kjfUF+JfoU3QQxX0h6dI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZspyjUUBPdSahfaznA9uZjkSDXkyPCIqVR2/FUhASM2VRVO7D8We1YKOjjJISjD1YpQlhPMtGp2mIeTyFajY019xxybbVAmTK4c42AQhc5BxdBDEFkF0Jst8MpuIlNBNnLW+TQLtoIghlzgl6Cjzsf/miMxtraCVoaEyTiNsSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=T571HiBw; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 67B391FB25;
	Tue, 27 Aug 2024 00:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724710547;
	bh=y5t2Q9VHKe5OHr6FJPldfu/x63AecBEgBtfvue7SvJU=; h=From:To:Subject;
	b=T571HiBwl1OMA0XBX15tuCfyDKJnrnn1ZM+hIbqQC0NLV1W+4mj7ITmyStc87c+IH
	 AJFa9Gs57aLIJKqx44MYOxyKF56LjFMU6J8uqPVAIDPt60WrcZiKfpzmX4rb3r3b7q
	 5NBimdY4mk+GmT4enBrjufjvMzT3L8HXoOTV5xbBmBdewy91mmN6o3qCtSEsCfmCM8
	 +KPBKnJi7J9vPATcyYMLFUeWVgzEuyYSmjY2W47HeiFocCWo6S7LbtlefbdxjLFbl1
	 WBGomGTU8mLvJ6KOWfaSOsCbS61+TKTrezoHK5LWMjhPCcJHngMCEOTmdcqWoP+A/f
	 QElho1ACDSXCg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/5] arm64: dts: imx8-apalis: Set thermal thresholds
Date: Tue, 27 Aug 2024 00:15:38 +0200
Message-Id: <20240826221541.15669-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826221541.15669-1-francesco@dolcini.it>
References: <20240826221541.15669-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Set critical/alert thermal thresholds for all relevant SOC
temperature trips to the IT value (max T_junction 105 degree
Celsius) in accordance with the IT grade of the SOM.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 160153853b68..e53683e49e03 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -239,6 +239,30 @@ &adc1 {
 
 /* TODO: Asynchronous Sample Rate Converter (ASRC) */
 
+&cpu_alert0 {
+	temperature = <95000>;
+};
+
+&cpu_alert1 {
+	temperature = <95000>;
+};
+
+&cpu_crit0 {
+	temperature = <105000>;
+};
+
+&cpu_crit1 {
+	temperature = <105000>;
+};
+
+&drc_alert0 {
+	temperature = <95000>;
+};
+
+&drc_crit0 {
+	temperature = <105000>;
+};
+
 /* Apalis ETH1 */
 &fec1 {
 	pinctrl-names = "default", "sleep";
@@ -285,6 +309,22 @@ &flexcan3 {
 
 /* TODO: Apalis HDMI1 */
 
+&gpu_alert0 {
+	temperature = <95000>;
+};
+
+&gpu_alert1 {
+	temperature = <95000>;
+};
+
+&gpu_crit0 {
+	temperature = <105000>;
+};
+
+&gpu_crit1 {
+	temperature = <105000>;
+};
+
 /* On-module I2C */
 &i2c1 {
 	pinctrl-names = "default";
-- 
2.39.2



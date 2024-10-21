Return-Path: <linux-kernel+bounces-374856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AAF9A7127
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87982282AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965AA1F4FD1;
	Mon, 21 Oct 2024 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="et37ahJ/"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3571EBA02;
	Mon, 21 Oct 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532234; cv=none; b=bIxqvHEka3va4kHlUrFumYP3Veiv26YxV4IMqx+ZrR9/6NQROgSzQN4Px+2NZTmdH3ZNB+c29XR78iJsQzE5tAme9ErpPBtbo/ZspgNF8ShE9jmOxfIYMoZbi3wR5eUzWvDaGlIbmPhH8T+/+6EsXnvkbl3GN28ZwxcNU7Uqq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532234; c=relaxed/simple;
	bh=6UrIP3x6Q4VvkyT70SfUcwoNeQTbMiQIeBKEpg8X6M0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SPAAXkHSx/ZXa9nt63QPOUlm8C+3aNclNpk63VzzUivjaCiNiDzNYi5cXfqZ0jQtZeswqYjPmAOK2nh84n+vGFA46V66d0DTISJdW3jQZ7nQfqlo1FwcqHBIINGANw4ktiZV17XKtmPLJ0H7BG5fgX6du8CXgGHYBIFc0FHMWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=et37ahJ/; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CCs37GV7vVuBh26VL6pxUZ05QQRqLswyJ0vwq4ol3vg=; b=et37ahJ/YgSY/9THd1KxieZ+If
	Qv33CctofhSfbbBH+kOgN9L1FTTNItsmaY/oQWhL29hVpYCNQgBmxNzqXNVHnLrX/K0VMFjhwuOO8
	sJFmiF7EBoxbfJ7k2wvdkoJF18s3uMKtdKkvQfV7KX1dG9Ex1UAsX1e1yVmxGTQ94WWsmiJEQuPWg
	dIqXSaBE1bhWjFctcO2FA9uAEsw5QQrpHi3t8gb49v+KZTxAy7nCBv/EPVqYMhnU2YKCsFla1p3+2
	EUZ2zwsqRB2oLws1jS0qdmCzNt9ryuRQ6do82Mu+1yvQBUI3Q/vZ+RKspFyF1+8l+PkUxlaFhhhCu
	1um1dPzg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/3] dt-bindings: arm: fsl: add compatible strings for Kobo Clara 2E
Date: Mon, 21 Oct 2024 19:36:29 +0200
Message-Id: <20241021173631.299143-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241021173631.299143-1-andreas@kemnade.info>
References: <20241021173631.299143-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds compatible strings for the Kobo Clara 2E eBook reader.
There are two variants differing in the EPD PMIC used.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177e..a78903076269b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -620,6 +620,14 @@ properties:
               - kobo,librah2o
           - const: fsl,imx6sll
 
+      - description: i.MX6SLL Kobo Clara 2e Rev. A/B
+        items:
+          - enum:
+              - kobo,clara2e-a
+              - kobo,clara2e-b
+          - const: kobo,clara2e
+          - const: fsl,imx6sll
+
       - description: i.MX6SX based Boards
         items:
           - enum:
-- 
2.39.5



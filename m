Return-Path: <linux-kernel+bounces-190425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6640E8CFE14
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17B41F233AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9D813AD1C;
	Mon, 27 May 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QYStvYcQ"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C013AD34;
	Mon, 27 May 2024 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805713; cv=none; b=quRiy5PXKrJqXwmqvvhQrLB6AKBqcJ5nuZxTwZN/d3lM7mNpNNEsyx61yK0xQxEadwvdmpFNjYjET84iGtY0TcLOofposWkf9voOyJY2y3g2F+/ENMpFQFl1Y08C73MfL2hR0PP5AaAPQx6b4q59wkvBnQobkV2pyklfdumUKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805713; c=relaxed/simple;
	bh=2P6D9YJKAp19eW39CzCjCrRS6ZRy7MT6CTnvK1alaas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0YgUvAo0dp4/hkpTQw9hdm+s6/laiNkkrY5zq7Ay9dh7kfMBdLa72uYdrQm7wvutzwOmXPz6fmFpWOvj4w3yjSE0OuMHS+HhpVDahJA28MiXGme3lzZbLSNT4f2D5/anyDd4DTC2CxcOLQUv/kqyIhqoSO4rkOnZMIUtrSKoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QYStvYcQ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 407AB20004;
	Mon, 27 May 2024 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716805704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIEgzuBJdhqAhnahZNc6Fk08hJUNP1Ejk2wU9brIDN8=;
	b=QYStvYcQNL+T1zB85n3Xv9hH8cegl1i2DojpgCQBqmgfu9LcRMRz0VDgCyp1AlIpmNhfhR
	GVoTkbnDkAV6lGRPKW/PtqPxOaR7+YNyOJUN2l4pMAqZhIjTswu6Jx4+fRAN0QWOR8z65V
	QcmlTKKBLIorkln4wbj/9bFS0TaocvQgl2jrQ2wamyw0+yrjSe4Pd8YFTpgct6Um9h1H12
	IBrEjCzu3LFCjO56fjhHbANTcw9J/1+7GCeB10UjPsrZbTVXMwqbCt6fW8xCVMx9r438Ee
	tsMF6YMF00WLljNQlUb40Gb0XIce3oij7fPG+TahMR1L/1UyqwOHFmA6SJnx9g==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Mon, 27 May 2024 12:28:17 +0200
Subject: [PATCH 1/5] dt-bindings: interrupt-controller: Add SOPHGO SG2002
 plic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-sg2002-v1-1-1b6cb38ce8f4@bootlin.com>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
In-Reply-To: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Chao Wei <chao.wei@sophgo.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

Add compatible string for SOPHGO SG2002 Platform-Level Interruter
Controller.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 709b2211276b..7e1451f9786a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -67,6 +67,7 @@ properties:
               - allwinner,sun20i-d1-plic
               - sophgo,cv1800b-plic
               - sophgo,cv1812h-plic
+              - sophgo,sg2002-plic
               - sophgo,sg2042-plic
               - thead,th1520-plic
           - const: thead,c900-plic

-- 
2.45.1



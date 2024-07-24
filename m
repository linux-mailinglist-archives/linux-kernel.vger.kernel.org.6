Return-Path: <linux-kernel+bounces-261046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D55A93B224
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E6CB219F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5A3158DD9;
	Wed, 24 Jul 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CjNAHb9j"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FBA1581F8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829439; cv=none; b=BGy46FkFBNFwdoCFHlnd1WrTISRHL8m37+keIYsCSXSd1Sj7uDzmwfnOkyurifFSUEcTNHUW9xYPcYwPbJ8F6jzw9BRjyDl1H2V9GJqe+QW4LNyC9Bc6fxl1Y22hoGvO+ls2PRH/3BNGitA95lguTbAuwbcXIS76pKzHYeMSI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829439; c=relaxed/simple;
	bh=jNXiq3bHpi7x4ktyjfwg/EmYOPE9tGdECULKfQhnK2k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZB0bBu1xolx4iDyC6u4/f/s0CGEtTFIF6e4y/4dWW0wuX3K7vm8zX6JQJKcVyOCh3sh913sFL4YyaWd7t3dZoT5cLcVIZyVwjN5nYcg6ivvBF0a+z0rkFEdQ4XBtqNnxGPnLAcxYHf+7IaGlOO0DaloG8MFXDhnZJ5maHP8uIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CjNAHb9j; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F96820005;
	Wed, 24 Jul 2024 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721829429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yly6NfpLbjWiRCDJngWf2bxxVL/Slx7j02LgXdWqJDg=;
	b=CjNAHb9jOtwQaM+QMLC3W1yxewGZxlj3A84Q23SAd4YP5cHhwlboy+aYgevmO6RejD9fnZ
	ZDFNQ1hsx4Z8rbAMZkcgZzIACVOamcWR6iilczmCv+4X4P2nRydYOMBQsjxMQ9DerxYRI7
	JG+UlcalJ2If42QpCQ8s/3fwyGNl1BvBPIW4M/vSCj7efuZm2nFaFE4l3ZnbUvM90KMG/p
	7uO1TvnP8EfETmM9ymmHDHmhW4q8Uoq8l0XmoJv4If+ruIzoeVN0KOEu/6udI35+1cMY8e
	AZdVAy6OmgRsLLLfjpzbCjkXt6AEuh5YGUbrF6W5fYyqgIlbXnLr+Cow7r0CLg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/3] nvmem: improvements to struct nvmem_config doc and
 rmem driver
Date: Wed, 24 Jul 2024 15:57:07 +0200
Message-Id: <20240724-nvmem-rmem-v1-0-d2e3a97349a0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADQIoWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyMT3byy3NRc3SIQYWphkZZknGKQamlsoQTUUFCUmpZZATYsOra2FgA
 r9vHrXAAAAA==
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

This series started from a fix looking exactly like:
28b008751aa2 ("nvmem: rmem: Fix return value of rmem_read()").

This is already merged but I have remaining lightweight patches
targeting the nvmem subsystem:
 - Try to avoid the same error by adding a mention in struct
   nvmem_config fields doc comment.
 - Simplify rmem's ->reg_read() implementation.
 - Remove an unused field inside the rmem private struct.

It is based upon v6.10. I am not seeing a more appropriate branch in the
nvmem tree. Hoping this was the right decision.

Have a nice day,
Théo

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (3):
      nvmem: specify ->reg_read/reg_write() expected return values
      nvmem: rmem: make ->reg_read() straight forward
      nvmem: rmem: remove unused .size field

 drivers/nvmem/rmem.c           | 17 ++++++-----------
 include/linux/nvmem-provider.h |  4 ++--
 2 files changed, 8 insertions(+), 13 deletions(-)
---
base-commit: 4b2fe699ae60b81654e1257c3183ad3ddba906c0
change-id: 20240724-nvmem-rmem-588fb3d0e938

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>



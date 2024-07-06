Return-Path: <linux-kernel+bounces-243196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F09292FA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E1A1C20F6D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE067149E04;
	Sat,  6 Jul 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OJ88jTM3"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07010146A63
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264914; cv=none; b=SRs0x0NIHv49+6mT42aMtiw9h24THLYt0aHAnICvesfSVbF7pGUbt7R/bSBomMHmbLfZPvT4MGbZ/OxjnP39TMu5DyjITncdgn3jXK/QIOAkhmvreeKIF2ewi8r1SaAFH8jGStv0a7XVusJLhQFR0lYTJ+4CEsUTJSrsV1EvRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264914; c=relaxed/simple;
	bh=dMnyEjp7+uX7hB8OvommDFSS9gTLs56lQaOKFfeWV80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRLU5Mn0a8CThpV5P/Y458hKbS+xGm0gei9whIbqPmg4anQv0rRA4/OOFz72+WQVHmf5tnS4HD74xRUxU2i1yY3PurdcsyURbysBHdQ37ehfPOL4QUfbIx9+IF9dpEEe6NdFiD29eOtM8NObgQJ6D5eLn467+ijUy6/ELBeZKrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OJ88jTM3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=WeKdycd1+D6KyJrGKsaIPUssvwvGfHywxfTsuw+6QZA=; b=OJ88jT
	M3XTQ+jEDbbGJ+iHvaV6rI1gd9OR5nHDY/sC35sFoXvTsi+Du6W7ZBnzGvcNcjqL
	cGYmmjv8mKx4OCaz7OcV0od1JJqHHTVzm6OMpPdiBAdva7pyxkQq9b859Bo4mjw5
	swkDZPZkwHG8D0pwyb3ulsY4c9o875gWvHzsgCd40NPkZRBFPj/sG0g4pUVS+miF
	X0A8qtxQ0Qsc9LprrJXw63EbNRE0WCYmg9XJfj1eim3OsZEETa/j+9ckvKNCPpRh
	w/Ysy/EPHf/hv010ES6BeEUjIJqA9uPOVv6NDucLYGZxRj5gnj3oG43JFnbol5Ru
	As1HX91l6Y6kSPuw==
Received: (qmail 3809969 invoked from network); 6 Jul 2024 13:21:36 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:36 +0200
X-UD-Smtp-Session: l3s3148p1@OS4QYpIcOIZQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/60] i2c: i801: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:20 +0200
Message-ID: <20240706112116.24543-21-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-i801.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 44e3e9bae5f1..328c0dab6b14 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -88,7 +88,7 @@
  * Block buffer				yes
  * Block process call transaction	yes
  * I2C block read transaction		yes (doesn't use the block buffer)
- * Slave mode				no
+ * Target mode				no
  * SMBus Host Notify			yes
  * Interrupt processing			yes
  *
@@ -1277,10 +1277,10 @@ static void register_dell_lis3lv02d_i2c_device(struct i801_priv *priv)
 	i2c_new_client_device(&priv->adapter, &info);
 }
 
-/* Register optional slaves */
-static void i801_probe_optional_slaves(struct i801_priv *priv)
+/* Register optional targets */
+static void i801_probe_optional_targets(struct i801_priv *priv)
 {
-	/* Only register slaves on main SMBus channel */
+	/* Only register targets on main SMBus channel */
 	if (priv->features & FEATURE_IDF)
 		return;
 
@@ -1307,7 +1307,7 @@ static void i801_probe_optional_slaves(struct i801_priv *priv)
 }
 #else
 static void __init input_apanel_init(void) {}
-static void i801_probe_optional_slaves(struct i801_priv *priv) {}
+static void i801_probe_optional_targets(struct i801_priv *priv) {}
 #endif	/* CONFIG_X86 && CONFIG_DMI */
 
 #ifdef CONFIG_I2C_I801_MUX
@@ -1777,7 +1777,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	/* We ignore errors - multiplexing is optional */
 	i801_add_mux(priv);
-	i801_probe_optional_slaves(priv);
+	i801_probe_optional_targets(priv);
 
 	pci_set_drvdata(dev, priv);
 
-- 
2.43.0



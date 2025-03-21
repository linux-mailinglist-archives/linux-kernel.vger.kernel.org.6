Return-Path: <linux-kernel+bounces-571332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B335BA6BBDA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07353AE2E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC222B8B2;
	Fri, 21 Mar 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embetrix.com header.i=@embetrix.com header.b="WR6gNkCe";
	dkim=permerror (0-bit key) header.d=embetrix.com header.i=@embetrix.com header.b="G3jS+lcY"
Received: from mailrelay4-3.pub.mailoutpod2-cph3.one.com (mailrelay4-3.pub.mailoutpod2-cph3.one.com [46.30.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753E216E01
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564473; cv=none; b=fVsaXRf8dSWR/5ts0EePaVF9kztwvxpU8lg12WdEmQHppHBXRNzbAb4lG7yam5pfF8dszDj8wcmImTjhWtr0cpmQ8QyC5Dh4bDNztyGc+wDHfgb9F5gFTH4hji/8ZLAm1WNX4oIlq8374Ve3gdtE7C1IPomK853CvEPnWaQAHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564473; c=relaxed/simple;
	bh=hnErctNf5x2CnxSNa17SxPTOIebbJDOSOM9UTJYuH+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRjGeWpyZKxfCehs3XAUp25M2RbhMcWkJ4u/RK/ro9s1MzTVyBmqd+/DtHQsxPv+XzuadYBuqvrckIsSJLWgSpqWxXgCI52Q4gigyRVqmE5uBoHd4W72hvxpDAFnremjerCfT8tklMYRz4ozd/JOuEOhkDDUN1Y8m7l8uLykZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embetrix.com; spf=none smtp.mailfrom=embetrix.com; dkim=pass (2048-bit key) header.d=embetrix.com header.i=@embetrix.com header.b=WR6gNkCe; dkim=permerror (0-bit key) header.d=embetrix.com header.i=@embetrix.com header.b=G3jS+lcY; arc=none smtp.client-ip=46.30.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=embetrix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742564399; x=1743169199;
	d=embetrix.com; s=rsa2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=/kalWy8J0iE790KhbrNqxh8cP5AFD6UvTxuEdRGyIKk=;
	b=WR6gNkCeOmYsk5IgHkOwpnAR/8Epg/ehW5AL6+N2v7/1t+Rq8sqY+73REP8g6VYmP1VDr5DBfKSUQ
	 cWxAHFwEno3Be96DJyKjBS3mGr3oFm/s01u5Kkod0g/QCGND0QIf6S3VUd380aV0ilH153Cd9iwRFc
	 smeeDGkS37nvVP1Y2WR8nh/xrp6QWj4bPbPlB6svzXQBVco/srCgODEVbQUsjQMiUPYQhgCx8Vdfc/
	 JYjdFmlXVgzK4pbW8t8FFzz5OjtMXdHZIfto5+f/VDUxYm2pFdLZF25dS3rkoLQakS1aEunn6aNFcZ
	 jl2kdPHfDLHwAgbQBCK+Iwv1FLEcZgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742564399; x=1743169199;
	d=embetrix.com; s=ed2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=/kalWy8J0iE790KhbrNqxh8cP5AFD6UvTxuEdRGyIKk=;
	b=G3jS+lcYQ9O6fuGy5S1cuS3dXSVu1auvDEgk57JHYkuz/EUGXp4lDtWGcmMv5n3FCK0UwsClbhnjK
	 gZGk61TCQ==
X-HalOne-ID: faf22edf-0659-11f0-b7bf-e77cec7da75b
Received: from xps-13.fritz.box (dynamic-2a02-3102-8c10-00a0-d7d6-6cc2-a3a5-69f6.310.pool.telefonica.de [2a02:3102:8c10:a0:d7d6:6cc2:a3a5:69f6])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id faf22edf-0659-11f0-b7bf-e77cec7da75b;
	Fri, 21 Mar 2025 13:39:59 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com,
	dwmw2@infradead.org,
	keyrings@vger.kernel.org,
	Ayoub Zaki <ayoub.zaki@embetrix.com>
Subject: [PATCH] sign-file,read_private_key_pkcs11: add pkcs11 provider PIN setting
Date: Fri, 21 Mar 2025 14:39:56 +0100
Message-ID: <20250321133956.154597-1-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in the same way as for PKCS11_ENGINE, add PKCS#11 token PIN injection
for PKCS11_PROVIDER from key_pass environment variable if set.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
 scripts/sign-file.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 7070245edfc1..bdd26e438ff6 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -31,6 +31,7 @@
 # define USE_PKCS11_PROVIDER
 # include <openssl/provider.h>
 # include <openssl/store.h>
+#include <openssl/ui.h>
 #else
 # if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
 #  define USE_PKCS11_ENGINE
@@ -107,19 +108,45 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
 	return pwlen;
 }
 
+#ifdef USE_PKCS11_PROVIDER
+int ui_get_pin(UI *ui, UI_STRING *uis)
+{
+	const char *pin = (const char *)UI_get0_user_data(ui);
+
+	if (pin == NULL)
+		return -1;
+
+	int ret = UI_set_result(ui, uis, pin);
+
+	return (ret == 0) ? 1 : -1;
+}
+#endif
+
 static EVP_PKEY *read_private_key_pkcs11(const char *private_key_name)
 {
 	EVP_PKEY *private_key = NULL;
 #ifdef USE_PKCS11_PROVIDER
 	OSSL_STORE_CTX *store;
+	UI_METHOD *ui_method = NULL;
 
 	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
 		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
 	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
 		ERR(1, "OSSL_PROVIDER_try_load(default)");
-
-	store = OSSL_STORE_open(private_key_name, NULL, NULL, NULL, NULL);
-	ERR(!store, "OSSL_STORE_open");
+	if (key_pass) {
+		ui_method = UI_create_method("PIN reader");
+		ERR(!ui_method, "UI_create_method");
+		if (UI_method_set_reader(ui_method, ui_get_pin) != 0)
+			ERR(1, "UI_method_set_reader");
+
+		store = OSSL_STORE_open_ex(private_key_name, NULL, NULL,
+									ui_method, (void *)key_pass,
+									NULL, NULL, NULL);
+		ERR(!store, "OSSL_STORE_open_ex");
+	} else {
+		store = OSSL_STORE_open(private_key_name, NULL, NULL, NULL, NULL);
+		ERR(!store, "OSSL_STORE_open");
+	}
 
 	while (!OSSL_STORE_eof(store)) {
 		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
-- 
2.43.0



Return-Path: <linux-kernel+bounces-200794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71468FB501
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B6F1C22CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E8171BA;
	Tue,  4 Jun 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="CKfwtdCw"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE329CFE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510552; cv=none; b=TK4BXboMWiU/+HC6lMy6IaslJThlHMfjXf3/YdmduIYW8cmN7F+x5frXEdm66mBM3saZ1dThnC9l/H1Ya15qGOuGzugIa7zIe0BiRpS76A6q6jcMxWrO/Kz8lMroncImJpNUmYAiIwNBDuJ3LcV7kQS6VaDVsDaiNNxaBTinnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510552; c=relaxed/simple;
	bh=eGS1Vsi5QG9dv+ynVH1vgHZQbhfvGoJaZLtnjmp2MVg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=J0DlgeGsHDMjKY2dc/bxSgAv6p7BFlFqe6FD7sGysS2VA8oS1EImp9RGIEllUag0Qn5ONZE3OVmFg2//vic7JjpAC8JtJ3IUaDut3te1D8yE0ihFgwn9x2xDrk5ujRHWC8qLyw1M/yAXm8Pl30v/KYJtldsq0wypgxxk6GaLrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=CKfwtdCw; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 511C9FC974;
	Tue,  4 Jun 2024 17:06:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1717509991; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=IBuooCDtyKHRQbL0BSwWXYG2t/9WVK1dkFV9raf2ZvY=;
	b=CKfwtdCwbZrMdw6VnDe6QW4eaNX86ggr7TqKXZAx6CJUYHCI5JNXvXjBqxvKdHMxxwu5vL
	4/d8Q6qDviKdtQhrDG7HAqOOqG0Wj6Qqg6yUCUrijFXFvaLNKPYoGDYE9GNzJDBmmH1AQu
	svCPglmyl1L3OY6k6iW+gw9FAr1XHZ1CHsvwXK9ctRfYFS42gSjcpDSooZsl/LW7Qlnl4V
	CM0pLhWJY0/wMTrNcoTcnEdb3EXdiWJ8KuyY8McjUxM0eOScLbk7uV86eT7T0mE6cnG0VI
	YVjQNJkJ0BJFoJ/ZHoyjky76iOofRxYiSiPeEsybmYIn85wOTE/8nUXi2jC4Uw==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH] soc: amlogic: meson-gx-socinfo: add new A113X SoC id
Date: Tue,  4 Jun 2024 17:04:51 +0300
Message-ID: <20240604140612.1179323-1-adeep@lexina.in>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add new definition for Amlogix A113X SoC found in JetHub D1/D1+ devices:

soc soc0: Amlogic Meson AXG (A113X) Revision 25:b (43:2) Detected

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>

---
This commit is applied on top of Christian Hewitt's commit with S905L SoC id.

--- 
 drivers/soc/amlogic/meson-gx-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 7e255acf5430..8809a948201a 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -63,6 +63,7 @@ static const struct meson_gx_package_id {
 	{ "962X", 0x24, 0x10, 0xf0 },
 	{ "962E", 0x24, 0x20, 0xf0 },
 	{ "A113X", 0x25, 0x37, 0xff },
+	{ "A113X", 0x25, 0x43, 0xff },
 	{ "A113D", 0x25, 0x22, 0xff },
 	{ "S905L", 0x26, 0, 0x0 },
 	{ "S905D2", 0x28, 0x10, 0xf0 },
-- 
2.45.2



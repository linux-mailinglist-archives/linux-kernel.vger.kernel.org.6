Return-Path: <linux-kernel+bounces-320064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EF89705CA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276C91F21D41
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7F136342;
	Sun,  8 Sep 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YTzUNxR4"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A186AFA
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725783973; cv=none; b=ufMCtVqqT1Vae1RPLGrIqAw7VJDokQ4EO0jlitWOPOYR/UvmbQFCvLVjpLQ59ecAi82NTHNGcIxSdLVLvOptBw1SomypgtZeeZtEW2GzK/pL1PZrG4JDROMGorCbUkLMfcVVoxRBE6ehCnK6lGKO769W9AtNcAijW5vAN8TsxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725783973; c=relaxed/simple;
	bh=DfkdlPUfDySCXQfllv/L5FJiiCumbjxKGF4SWK/9nKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9gQbcVFxneRIwhYlaupf7r3Q3I6wpSCZC6GvpQkiPpMh/AVEQxwwLfcaa0I3ExjcJgIGrCCKVnS8c2F5GwWeuSOnGkAh16suHHGxlJsvoMdFk/eX57NeHgPNdf5IDRDtZcN2QJW4uLGdE6fF4R1B2JDpSv+GdoeccorXPp9afA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YTzUNxR4; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nDFCsY7IoLYfJnDFCsQfT1; Sun, 08 Sep 2024 10:26:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725783963;
	bh=JTx9U7B4mTDpVstGREnAMeH1Gx0YQU+eDThFVipLUz0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=YTzUNxR45S4lTUa8vc5TcTKGOMk0fSKhrS2kJe6ov9oF7OI0IeYhwrgobDAyQ1Hxx
	 VHJflGEF2fYKM5ch27rMO9HKiy5IzsXsk/qhHfll98cpj0LZgfnWbXRyBlnXBjW9sf
	 Ho8Ni1KkcPbD5rwqFYzfatTIVu3NYnR1FREElQaKVb9C5uUKlFTP503XDWIgcolnr/
	 JYc8/BvZdKCCUKWJ6xAMtTyhMxA/jYJLGHhGj7zYQpoAFfncoq/tpkm48t7cERBuiB
	 C3vFxJLrwjkK0EDYNAoaIeIjr72Ckj9OjpG6K9Hcsj2K0BwW1mfbwDgERuGRY49qzL
	 k79v7L3wPRERQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Sep 2024 10:26:03 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Karel Balej <balejk@matfyz.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] regulator: 88pm886: Constify struct regulator_desc
Date: Sun,  8 Sep 2024 10:25:56 +0200
Message-ID: <0261f8b951a489859ee0fa41c584804b2e3f1557.1725783921.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct regulator_desc' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   3251	   6928	     16	  10195	   27d3	drivers/regulator/88pm886-regulator.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   9795	    360	     16	  10171	   27bb	drivers/regulator/88pm886-regulator.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
--
Compile tested only
---
 drivers/regulator/88pm886-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/88pm886-regulator.c b/drivers/regulator/88pm886-regulator.c
index a38bd4f312b7..68c83a4ebda8 100644
--- a/drivers/regulator/88pm886-regulator.c
+++ b/drivers/regulator/88pm886-regulator.c
@@ -56,7 +56,7 @@ static const struct linear_range pm886_buck_volt_ranges2[] = {
 	REGULATOR_LINEAR_RANGE(1600000, 80, 114, 50000),
 };
 
-static struct regulator_desc pm886_regulators[] = {
+static const struct regulator_desc pm886_regulators[] = {
 	{
 		.name = "LDO1",
 		.regulators_node = "regulators",
@@ -340,9 +340,9 @@ static struct regulator_desc pm886_regulators[] = {
 static int pm886_regulator_probe(struct platform_device *pdev)
 {
 	struct pm886_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	const struct regulator_desc *rdesc;
 	struct regulator_config rcfg = { };
 	struct device *dev = &pdev->dev;
-	struct regulator_desc *rdesc;
 	struct regulator_dev *rdev;
 	struct i2c_client *page;
 	struct regmap *regmap;
-- 
2.46.0



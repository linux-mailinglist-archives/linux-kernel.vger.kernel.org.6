Return-Path: <linux-kernel+bounces-320065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A328A9705CD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A361F21C30
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B03136351;
	Sun,  8 Sep 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Mp7Y8QGk"
Received: from msa.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F301366;
	Sun,  8 Sep 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725784372; cv=none; b=s/q+1j2FGNRfA5TP7pQfcWW03ci7Qb7RyFOjyvp+kq1DiXii3xWcTDYT1C6UFR7Q8C4fa/AZfg4oMkJ3M3kkNM/drJnMA55Ge83maW78MuyEU26ips/QCP5tehoDQ3/A0/sK/BJUCK4/QClU5A2Z/VbPNFx9ehAQKYNAryqVnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725784372; c=relaxed/simple;
	bh=zsZ0ys2e1oNlKEbWk9IGe/z9GanXVYq8rzb+eYVJNzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AV7t+nzuXmKd5lmxbvSVhcrnE4ljr5NvieBMmG3MvB4abVeHSEpeeRUa2s+BRQ2wqLYohL3S+E/4CX/FFNX0JadWsCOHSr4Fo/7zxUNiMj+H1FztZ6bCfqw9PL3rMRNkJ8iIC15UHCUZS6uW384bdVSEg9T3QaYkvHPVT5c7VwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Mp7Y8QGk; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nDLdsf6JjbNNsnDLdsCrGJ; Sun, 08 Sep 2024 10:32:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725784362;
	bh=OD7y2O6XhtERo4H6oeABbYtmnm3CLAfuszGvQrmB7Yo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Mp7Y8QGkofcivcaI6dpjIE1u/AWADIy+aC2QhspdwE7z1/4xe/5skkHtse+b9/nfq
	 01RD2V8/rpYmGUkyidg9+s742xLIhS7tLrml4EpQrwF5KhESjkg7Gzm3dIUQ1f+BW8
	 MFvzZlts97tPg9ydc+WBSoge1uTfVXHXC5MCH2ewOPW11I1dqIjEzPoaZWAB0iXErh
	 0dawff0MHo8s1NxQ8rpZ0EKFfAcVVQEROMC0CwG+VPOvnxyJ9PE1EtZnVjjFEef+oS
	 pVNd/0+r1u2hPjPoRXPwbvwbkiLD3xplmkV5LkDvYBfA3czHlQkd/GrfECgpJTzQhr
	 w1hQGROAtkEeQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Sep 2024 10:32:42 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Saravanan Sekar <sravanhome@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (pmbus/mpq7932) Constify struct regulator_desc
Date: Sun,  8 Sep 2024 10:32:38 +0200
Message-ID: <c0585a07547ec58d99a5bff5e02b398114bbe312.1725784343.git.christophe.jaillet@wanadoo.fr>
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

This also makes mpq7932_regulators_desc consistent with
mpq7932_regulators_desc_one which is already a "static const struct
regulator_desc".

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   3516	   2264	      0	   5780	   1694	drivers/hwmon/pmbus/mpq7932.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   5396	    384	      0	   5780	   1694	drivers/hwmon/pmbus/mpq7932.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
--
Compile tested only
---
 drivers/hwmon/pmbus/mpq7932.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
index 67487867c70f..2dcb6da853bd 100644
--- a/drivers/hwmon/pmbus/mpq7932.c
+++ b/drivers/hwmon/pmbus/mpq7932.c
@@ -35,7 +35,7 @@ struct mpq7932_data {
 };
 
 #if IS_ENABLED(CONFIG_SENSORS_MPQ7932_REGULATOR)
-static struct regulator_desc mpq7932_regulators_desc[] = {
+static const struct regulator_desc mpq7932_regulators_desc[] = {
 	PMBUS_REGULATOR_STEP("buck", 0, MPQ7932_N_VOLTAGES,
 			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
 	PMBUS_REGULATOR_STEP("buck", 1, MPQ7932_N_VOLTAGES,
-- 
2.46.0



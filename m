Return-Path: <linux-kernel+bounces-253506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4355A93223E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BA11F22B97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE0194C63;
	Tue, 16 Jul 2024 08:51:42 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0F41A8E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119902; cv=none; b=oxmwcexHMyzLb3Ifi+DZuC43hA96Mmz+Kf9aCnqIsM1/hyM3epxASL564JXLm5KFCx00f1vWIZcsnkJHMt6HOEai/Vj1iS/8Bku/pYa+cgaBD57aqFe2Rte7/3dxj2MYGJ7zIaCHevPqbRY09xjY1jKL2pismaAk+AAjrYgCFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119902; c=relaxed/simple;
	bh=PEeKnhZRmYTwfo31uEaLdK0VL6vEwPRaS/At/G4vrbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MV0mI6tnNbjKaUzDZxM8vEdWEmmywYcEOqSEEC1t6tJKmndlIAhfwRa35o8gT5DZTFDQoPNl/oVjo6q1mllPzuCTwC6owe4hXsuLKOc3Q6bCghQnsqu6OS2BNvo1i270rH7iYSIIYeW9dL2vaNN34W1/2H5++kMLUJCEoFtlVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADX3eWVNJZmf8SYAw--.51764S2;
	Tue, 16 Jul 2024 16:51:33 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	axel.lin@ingics.com,
	ckeepax@opensource.cirrus.com
Cc: patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] regulator: wm831x-isink: Convert comma to semicolon
Date: Tue, 16 Jul 2024 16:51:15 +0800
Message-Id: <20240716085115.1252817-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX3eWVNJZmf8SYAw--.51764S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1kXF1UKrWUJw1kKw47XFb_yoW8JFW7pr
	4fJrsrKay8tFyDXrs7Gr4DKwn5AFZrJa1v9ryqkw4xXr4fZFy7Jry0gryUtF48Grn7Ar4a
	vw4qywnaqFsrXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
	GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrcTPUUUU
	U==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: d48acfd0377f ("regulator: wm831x-isink: Convert to use regulator_set/get_current_limit_regmap")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/regulator/wm831x-isink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index ed5e191e8896..43f220cea21c 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -146,10 +146,10 @@ static int wm831x_isink_probe(struct platform_device *pdev)
 	isink->desc.ops = &wm831x_isink_ops;
 	isink->desc.type = REGULATOR_CURRENT;
 	isink->desc.owner = THIS_MODULE;
-	isink->desc.curr_table = wm831x_isinkv_values,
-	isink->desc.n_current_limits = ARRAY_SIZE(wm831x_isinkv_values),
-	isink->desc.csel_reg = isink->reg,
-	isink->desc.csel_mask = WM831X_CS1_ISEL_MASK,
+	isink->desc.curr_table = wm831x_isinkv_values;
+	isink->desc.n_current_limits = ARRAY_SIZE(wm831x_isinkv_values);
+	isink->desc.csel_reg = isink->reg;
+	isink->desc.csel_mask = WM831X_CS1_ISEL_MASK;
 
 	config.dev = pdev->dev.parent;
 	config.init_data = pdata->isink[id];
-- 
2.25.1



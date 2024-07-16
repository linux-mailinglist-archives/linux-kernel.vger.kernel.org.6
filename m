Return-Path: <linux-kernel+bounces-253503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA71F93222F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CB71F228E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE6B17D37B;
	Tue, 16 Jul 2024 08:47:25 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22386FBE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119645; cv=none; b=q3TIBlxy6TojncrlPF+1KYsvib/FFyKU7vQ3FkmUC9iEcLjAoWDUnMoJv5QTF7c72NfZAYKlK+4CSX8ffPvxXU337qDtsW2Qaax7UR96G01YF+XPOs4I67xMV/ZsGAkWiAkEI+XXt3ZJwBDAdVp5ygcbIZ8wfil3Anpgi+haIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119645; c=relaxed/simple;
	bh=AH+r8Xt3hRDDqk8FFRhC9SOm5berM+sibmSmLXQXK1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PL1DQ+sFf7X6raf7dyOigoAd4mw4CHZuCF5U9XVBZMytHgQaQBn5sTQu/EJlMZDbBapEmLqc0/fVsDx/B4wivJ5A3vP+0LoCX6buqZ3lSphjLwuWSJMS85+rPBegjdWaTf1PIqiw8NJgRE/l8kN88HQ5XWQKm4y5F48pG2+Ktvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACnr+eVM5ZmN6aYAw--.29807S2;
	Tue, 16 Jul 2024 16:47:17 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	cy_huang@richtek.com
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] regulator: rt5120: Convert comma to semicolon
Date: Tue, 16 Jul 2024 16:46:59 +0800
Message-Id: <20240716084659.1252690-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnr+eVM5ZmN6aYAw--.29807S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF1ruF4xWw1rAr1DZFb_yoWDurg_G3
	43W3WxJrsF9rs29w1Fv3Z0yry3AwnFga17JFs7KF98tr4rAF1DX34fGr9rAr4rJay3Gr9r
	JwsFva1xAw1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
	ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUn-eODUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: c0216c0e68f7 ("regulator: rt5120: Add PMIC regulator support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/regulator/rt5120-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rt5120-regulator.c b/drivers/regulator/rt5120-regulator.c
index a388ac70865f..f0d3efd160d4 100644
--- a/drivers/regulator/rt5120-regulator.c
+++ b/drivers/regulator/rt5120-regulator.c
@@ -245,8 +245,8 @@ static void rt5120_fillin_regulator_desc(struct regulator_desc *desc, int rid)
 		desc->n_voltages = RT5120_BUCK1_NUM_VOLT;
 		desc->min_uV = RT5120_BUCK1_MINUV;
 		desc->uV_step = RT5120_BUCK1_STEPUV;
-		desc->vsel_reg = RT5120_REG_CH1VID,
-		desc->vsel_mask = RT5120_CH1VID_MASK,
+		desc->vsel_reg = RT5120_REG_CH1VID;
+		desc->vsel_mask = RT5120_CH1VID_MASK;
 		desc->ops = &rt5120_buck1_ops;
 		break;
 	case RT5120_REGULATOR_BUCK2 ... RT5120_REGULATOR_BUCK4:
-- 
2.25.1



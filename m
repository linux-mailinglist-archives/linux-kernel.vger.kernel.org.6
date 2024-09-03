Return-Path: <linux-kernel+bounces-312048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F45969149
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDFF1F22EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25BC1CCEDD;
	Tue,  3 Sep 2024 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Zqj48fbM"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5990B1581E5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725329147; cv=none; b=aW/afUyf5t371qOahOlyU/NRHJQCPhYbowAJCAYBqtGzKk+/lbbMfYsZ+gckl2qVrUv/FJR0B7k5SoYWqTcBl9k9b9LvDYpqh+ceYHfw8LzteHgUQoCB+T+fL/kdmSPfYpMddsPITLfVjKRARpCojp+8GNKOEhAmRqPNWjwty2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725329147; c=relaxed/simple;
	bh=Ns+E8hrjd/ghEa5DY5olrRcrI4vwyq4CJUUyyiR/4Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H2cMTA9bdil/aztXYoh6Tm2+v3qark6VrcwOuAr5/ssyqHLwe2HSUiB+cC/0oYSwjmd5pCi2kX0WF0YlamlG0KCc93bVc3NSptrXQV3ZiQ+xnbJn5zOcQpkCThfRzI1B/BaZ4v+ISDjCtcYSb+LAqdShNHB30c131Q5bsDZPbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Zqj48fbM; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZyFV9
	yQfBbszpp7tI1HamkYKcyO0B0xhk9UbvaXQsOU=; b=Zqj48fbMs5WiskT7LadhY
	qqKDC+gUtS/beWq7TqFYl8+FwPq73vsbonwk4ggaPl0eCRUAT06XuJx3o/Mdkr/v
	tMp6SSjz3PbR8LrbUJlfZFTlJ+ZGTHp/OIyaltJqwZDjNqog6Do6LhMZL6Jql6VB
	FjPuGwOtLeiNp8zZQsUSgw=
Received: from debian.lan (unknown [36.33.36.240])
	by gzsmtp1 (Coremail) with SMTP id sCgvCgAX3z3NbtZmpC5_Ag--.62293S2;
	Tue, 03 Sep 2024 10:05:02 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] staging: rtl8723bs: Remove an unused struct in rtw_cmd.h
Date: Tue,  3 Sep 2024 09:44:02 +0800
Message-Id: <20240903014402.170750-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sCgvCgAX3z3NbtZmpC5_Ag--.62293S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr47uFykZF4rCF1fuw13XFb_yoW3Wwb_Ca
	y7tFn3Wr1DArn7Zr4UGF18AryvqF1xJw40qrn5KFZ8ZFsI9F15Jw1vqr47uFW5Wa17tr9x
	Z3WFqrySkr1rWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbLSdDUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYA5PamV4I+SUPgAAs7

struct getcountjudge_rsp is not used, just remove it.

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/staging/rtl8723bs/include/rtw_cmd.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
index fe1b03101203..cb44119ce9a9 100644
--- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
@@ -516,10 +516,6 @@ struct drvextra_cmd_parm {
 
 /*------------------- Below are used for RF/BB tuning ---------------------*/
 
-struct	getcountjudge_rsp {
-	u8 count_judge[MAX_RATES_LENGTH];
-};
-
 struct addBaReq_parm {
 	unsigned int tid;
 	u8 addr[ETH_ALEN];
-- 
2.39.2



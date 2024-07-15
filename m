Return-Path: <linux-kernel+bounces-252148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D28930EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908DB281406
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4BE16D320;
	Mon, 15 Jul 2024 07:41:49 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF63EA98;
	Mon, 15 Jul 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029309; cv=none; b=HRrQin5i10mXgmH4rZBa5JsgiwuOoN9p6YChWJ2fW93GHAbb2oMyXakw6KBrYGiQrdBVanYJmEPklsXyUS6qQBnBtkEuKKR52Rw/hqbaJpGQvqwNN/wT3aoyZfBlaP/4ZMHDy4TCCYNLz+bdCNHn5xL862E5YHOGrwLSEmlXdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029309; c=relaxed/simple;
	bh=+ngG0sf8DVROZxeHNSnraiS0QJDX2RWWNmGGuKghrho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TajjJNIMkC60qO5az2pYTxXBfRLpkPZVIsjCj1fzOM3rIjQuu4HRYjs9joRvDoyEP5QjhqmJsR++GLuZYd7ugfAzLECl0fRaNdBgmM44Tw73tYTaC2OdW8ErwrdyNfGadMWI9qStT1f8DS15KrT//Ci6ruyCPa0e0ilScxNFYRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAB3f7ek0pRmPwBoAw--.42734S2;
	Mon, 15 Jul 2024 15:41:24 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	johan+linaro@kernel.org,
	quic_kriskura@quicinc.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] usb: typec: ucsi: glink: Remove unnecessary semicolon
Date: Mon, 15 Jul 2024 15:39:47 +0800
Message-Id: <20240715073947.4028319-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3f7ek0pRmPwBoAw--.42734S2
X-Coremail-Antispam: 1UD129KBjvdXoW7WryUGFyUZryktr48Jr1UWrg_yoW3XFX_u3
	Z7WFsxGr1jkF95Kw1fXas0vr1akw4qv3WkWFnYqrZ5Ca47Aw1rW3yjvFWDXw1rK345AFn3
	Wrn8Xa4UGrWS9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
	CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmD73UUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolon at the end of the switch statement.
This is detected by coccinelle.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 16c328497e0b..459a5af02910 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -263,7 +263,7 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
 	case UC_UCSI_USBC_NOTIFY_IND:
 		schedule_work(&ucsi->notify_work);
 		break;
-	};
+	}
 }
 
 static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
-- 
2.25.1



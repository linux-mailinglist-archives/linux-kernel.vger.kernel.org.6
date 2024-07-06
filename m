Return-Path: <linux-kernel+bounces-243234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3865892934B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6943A1C21205
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646D817C7CD;
	Sat,  6 Jul 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DN7voEty"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166117B4EC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264945; cv=none; b=jRiGTz00XmJC7wZgb73J32NGnqPfJo0QXu7d96ZiEIePVEFarqeI4eUtxH3Xf+U7/4ZF0KkrvwM6kvDN0NM9CT693oMYoFMGZDTUtHeRJSwlIHIk9SdkP2wT4deJwVEt5D1M5VEhpiPEo9Btz9MuTB2q/r59kuZtixe4UtOixZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264945; c=relaxed/simple;
	bh=vzEuQ+lrXLbvmLq0c8x+vqbbovkHgUmGXYcgQ5Mx6HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFjxiKdcZxx8Dg4Wb99ehFeWy89PL5prsHVeeU8zdmL2Ztu7ICI0RIXfQLFpSVd35wrjIBpzaegbNCuFuQtHLgOpJ/FOKOqvPSNoTvrG78howeEfjseWhLaziF+v/2GpooWjXN3t4DM8p2Ilmgi1js5SGZpfDW85a+qSO3nvPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DN7voEty; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ScNZzVtjtJ+63j5oihnknDrh2WBe9TwtSoZSFqQwENY=; b=DN7voE
	ty/7aabzGyavJdkHYBlNKntFys/YSNOQWA9vHUlAYjzEyx+Zt2Gd3M/ISCbE72i3
	SZh0PZemLVp35B39fUoq+IStKhYRKj/wfEziAnC52wxjrspn/f1Lr8mfNk0WsGD0
	SJzXYLGtuQHUQyhcmLJSgTmc0s+6VRdkQSymfTnVducTD7GGPx06bk5nCtWbKFBn
	UZgVTXjJvStsGe1nLu7XIC7UG0if/YyGlGQwwe6bGKSkAqT7RST2GK/v8FC9btIf
	+nK0nE+H/DHDj4iA/eIlE+47HB8t/APzhnpjMnzWYd2wg+Qngv1jV6sYmFH2gpjy
	bjPneSU3CL1MbdBQ==
Received: (qmail 3811264 invoked from network); 6 Jul 2024 13:22:03 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:22:03 +0200
X-UD-Smtp-Session: l3s3148p1@FTyoY5IcwuFQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Conghui Chen <conghui.chen@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 58/60] i2c: virtio: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:58 +0200
Message-ID: <20240706112116.24543-59-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index c60ae531ba57..52ba1e0845ca 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -183,7 +183,7 @@ static u32 virtio_i2c_func(struct i2c_adapter *adap)
 }
 
 static struct i2c_algorithm virtio_algorithm = {
-	.master_xfer = virtio_i2c_xfer,
+	.xfer = virtio_i2c_xfer,
 	.functionality = virtio_i2c_func,
 };
 
-- 
2.43.0



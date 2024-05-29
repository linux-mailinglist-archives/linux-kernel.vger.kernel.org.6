Return-Path: <linux-kernel+bounces-193232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB758D28BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D7F1C242F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FFF13F441;
	Tue, 28 May 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KssyC0uG"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3116213C3CC;
	Tue, 28 May 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716939019; cv=none; b=GNpKhXDrQArI4e5wh04elki6Gu4E8EZwGYvzFyQ/A6hk5JRESNYlbq0BksbAEoTfGzTtiAduabRNgRQ9tVhnyatanL/dKBdjyPjZtojeELGYUWiw2ok5qma6VLLhQEIM/4gxWV1LdWh146UmaVNBCzTpj7tLTVbugGvRYlgbg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716939019; c=relaxed/simple;
	bh=qSjx/bsB/zVHhVAjJTymNFXtCgkyChbruLtJUDIzE9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIXEb4a1bLAGbDzWbwDBMNFf+yyQanReJxUokj1/9uaeK7sR8+XjMzKqvMmijkyKOxpRHFKCq7YnxCOfZ4CLWKpmT77W6+4usmRXecfR5jHaMygWUmQDN5sJX+Sd+jW+TFG+IuaN79JHwc27b0ANsdddPlaervpRjH4UaFRujME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KssyC0uG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=8AgdoNvg2vLBvOv+vufZaMaj67p6bwHQsF924AkCUf8=; b=KssyC0uGU9dkqlXX
	r2/LCXd6Qna+tAGdyzbmq3j3g5ONjdncsu24U3fQQmmDmoia3BXXzJg+LdSWkKBK5wZYdreOEJ9D/
	PZA4PUjE8c2jn5eDwv/AzCpb+ViRFo0pNE7WSr15n+dptLABGvlgLJ98b1y3STUuaTP/LqO6o1sBE
	bO47vcxzYt6SxXEffR0b81xpxN+Hzii5gNPfsjTu6FHUdPq8zk3WOmbTv8YR9fB7nbuNU6QOGm3RI
	4WUSJYlv1lQNQyUoZf/snsNobPA3eSeBd38tt5DwEaN7kSiNkXvxpEZej3MdUODof38sm8RnDwLF3
	va3bm61wgXL3yVqOxA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sC6Ge-00346V-35;
	Tue, 28 May 2024 23:30:09 +0000
From: linux@treblig.org
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] staging: iio: adt7316: remove unused struct 'adt7316_limit_regs'
Date: Wed, 29 May 2024 00:30:08 +0100
Message-ID: <20240528233008.191403-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'adt7316_limit_regs' has never been used since the original
commit 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9
driver").

The comment above it is a copy-and-paste from a different struct.

Remove both the struct and the comment.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/staging/iio/addac/adt7316.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 79467f056a05..23d036d2802c 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -209,14 +209,6 @@ struct adt7316_chip_info {
 #define ADT7316_TEMP_AIN_INT_MASK	\
 	(ADT7316_TEMP_INT_MASK)
 
-/*
- * struct adt7316_chip_info - chip specific information
- */
-
-struct adt7316_limit_regs {
-	u16	data_high;
-	u16	data_low;
-};
 
 static ssize_t adt7316_show_enabled(struct device *dev,
 				    struct device_attribute *attr,
-- 
2.45.1



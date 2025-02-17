Return-Path: <linux-kernel+bounces-516983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CB3A37A97
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F5C3AD4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A515382E;
	Mon, 17 Feb 2025 04:32:32 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB715C0;
	Mon, 17 Feb 2025 04:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739766751; cv=none; b=G9mPFMkg81xWbXGOFDc2Y2sh9P3ukqZpxQe1pLump6+o0EXCFc6TP13r2SreW282ZEFWkK4N38GAeIvkNhGramnrVB32e1eBo3yVaiQBWVkzMkTr5vshklhkg5z0JBM7rJ/i2DUC+4YnZlAtoqHMpEBrbxSpxDVzdq60xrzU67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739766751; c=relaxed/simple;
	bh=5z5piMPEs9n2Pqlr3VYVgUvga0fGL8oZ7szaXczF8pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+pG3LZPOtlB5iOVedah8CroBjivSu1R+6kFrFY+eGcl6odET/Fxg4pXHavYPi6Hb8EyspPlpCLJKSQHg3paNWmSSDYCicD9jYxB9NuTsOz/rCQyuz3H4HAn1nsYCDVCxAUlvmiEQKChCeV/3Pz8mSlvCl7i5wxPka9huEJGd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrADnyO2au7JnojqEAA--.2063S2;
	Mon, 17 Feb 2025 12:31:22 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wCXIO+Yu7JnnveMAA--.31239S2;
	Mon, 17 Feb 2025 12:31:21 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: [PATCH] MAINTAINERS: add reviewer for Chinese translations
Date: Mon, 17 Feb 2025 12:31:08 +0800
Message-ID: <20250217043109.3571459-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrADnyO2au7JnojqEAA--.2063S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWrtF15Kr4xKrWDtF13Cw17Wrg_yoW3trb_Ar
	48JFW2vryDJF1IqayvgF93Jr1Fvw48CF1kA3ZIk39rAa4DtayDXFyqg3s29r15G3yxuFy5
	Xas7J3sxWr9F9jkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbv8YjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw2
	8IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU0X_-JUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Dongliang Mu has translated a substantial portion of kernel documentation
into Chinese, developed scripts/checktransupdate.py utility to automate
tracking of translated content updates, and actively reviewed patches.

Thus, add Dongliang Mu as a reviewer for the translations of
Chinese Documentation.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..ae45135deb9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5405,6 +5405,7 @@ F:	Documentation/dev-tools/checkpatch.rst
 CHINESE DOCUMENTATION
 M:	Alex Shi <alexs@kernel.org>
 M:	Yanteng Si <siyanteng@loongson.cn>
+R:	Dongliang Mu <dzm91@hust.edu.cn>
 S:	Maintained
 F:	Documentation/translations/zh_CN/
 
-- 
2.43.0



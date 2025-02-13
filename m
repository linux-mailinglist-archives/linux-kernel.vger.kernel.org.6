Return-Path: <linux-kernel+bounces-512313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D150CA33768
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B133A7344
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D60206F0A;
	Thu, 13 Feb 2025 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUbgLWeo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98386325;
	Thu, 13 Feb 2025 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425351; cv=none; b=Yc8JI42886WAfzFA8qjXJd7hZHbwQHEp6EKoMf09tQLOfJ5XVK/GMDdvS75DHygxagaVzG0LI0MspgTzqJxeE0BH1fw/AbX/WKhDGX8OG9bxetDB5G7GrBiYMHejvWTyqT0PXpiDJdZLd9onm0t879ORdOCGUGQRtmb4VucswJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425351; c=relaxed/simple;
	bh=OMAF88mW0DbMb/Cbw2wyFI+BTWFfN75CmZJvWRlLJyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0D3gD17WNPRfZqtTyoZRTkN1hcSUoGr4py4jtP/J+cgLwMFjya5XRfxZGPO6DEckpLUX2y/Ej8FlmzJwOcU+Q5CX1gYgIAxibdsIIH0/3JaiTa+fCqrXB1PEJQ6AZPvLhVqx9N9SrgD2EC4PlZz/t6gHxBI4MJK5Tl2xXZTEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUbgLWeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D75C4CED1;
	Thu, 13 Feb 2025 05:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739425350;
	bh=OMAF88mW0DbMb/Cbw2wyFI+BTWFfN75CmZJvWRlLJyA=;
	h=From:To:Cc:Subject:Date:From;
	b=GUbgLWeoSmvEMjNj//Qig09maTQSCQM2Tbk+xu++cSZ6kFiq+g079P+M2VtQTGO3K
	 iNF2zT04FkmDIZciEWuaVBbkVwP41cvGRsAAYkdjVxJomfYx5wpXDVI7RftUQTcEPZ
	 +LNHatWVoh0N+pERxWYjNBPmTvSwM00jf442d+LtpgTQp153HQgyVdTvncLn5m/xj6
	 M2IkGlGewxctCpRZcPIhdVIToZuPuYn2z0b65HRLM8tqlrCd1Lw5gNeN10kmGtDUAT
	 bNx5IDyoUBHGBAx+KOq9c76QkzgC3RpO6oM7b/m2WyQFhF+zgSsQ93JrqTy8kShKsm
	 XveraTnI30UCg==
From: alexs@kernel.org
To: 
Cc: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] docs/zh_CN: add maintainer tree for Chinese doc pickup
Date: Thu, 13 Feb 2025 13:42:14 +0800
Message-ID: <20250213054222.21776-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

From now on, the Chinese translation doc should be aimed here for base.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn> 
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: linux-doc@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..dbb7f982e9c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5306,6 +5306,7 @@ F:	Documentation/dev-tools/checkpatch.rst
 CHINESE DOCUMENTATION
 M:	Alex Shi <alexs@kernel.org>
 M:	Yanteng Si <siyanteng@loongson.cn>
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git
 S:	Maintained
 F:	Documentation/translations/zh_CN/
 
-- 
2.43.0



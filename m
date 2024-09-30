Return-Path: <linux-kernel+bounces-343860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036AA98A069
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95DA281E33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D0E192D8B;
	Mon, 30 Sep 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="AzYlmFBG"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0CF19066D;
	Mon, 30 Sep 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695311; cv=none; b=c3jtD3RMDXu7GP+WT4oL9bzU4NMU4R/cgrIn2me+zmAD6g8peUNifSasiJD4ofuy4JJCSEj38nb5R3ZiyhbSH07D9/1B5C9REwV65EzYn0ESsDNSjVj4Y5+wJ32ykLfRQGoCwlo1Pwpvln8bEVhthpE/cczetcnFTBMdXyHj+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695311; c=relaxed/simple;
	bh=KeNXRa8R4YN81APmKpZQjZTJsDHnGimynVRNK+omai8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKEMxi1Z6pmK5BEb3dfLd3oRh4nYxdWRm/OtkV2b1feyKVCy2wCNoW71h2R4tmDUkafNW5ym4i+cYHDCWHJVEw66vIiwXNp6bbfrPFMK7gUKxsccDBssVMyqUb/682jKQxVGkvd+kxsmOie07eDqsW2FDQZYWnVpbhFuD50EHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=AzYlmFBG; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F1UZMtv5RWVGxdEQDN6gfxV9iWtaNrOlhgcnx8yrpEk=;
  b=AzYlmFBGFhwoVWnRvk3iv2HO529RrqgfwByAFqvN/b2VMMqlxKZu7/EJ
   uyMBvumNrvriUSuSxdBktgelLVq6fYFZkkqIRmasZEF8sG2MmzAffcP7r
   sO3A0ds6/h+uSnn2IHGYpCqwWA3AAbSB/6WZCwKD32Us3aVbECNi6Cvpx
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956884"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: kernel-janitors@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/35] mei: bus: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:59 +0200
Message-Id: <20240930112121.95324-14-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/misc/mei/bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 5576146ab13b..718ec5d81d94 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -145,8 +145,8 @@ ssize_t __mei_cl_send_timeout(struct mei_cl *cl, const u8 *buf, size_t length, u
  * @cl: host client
  * @buf: buffer to receive
  * @length: buffer length
- * @mode: io mode
  * @vtag: virtual tag
+ * @mode: io mode
  * @timeout: recv timeout, 0 for infinite timeout
  *
  * Return: read size in bytes of < 0 on error



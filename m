Return-Path: <linux-kernel+bounces-381103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD09AFA64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CB31C21F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE91B0F36;
	Fri, 25 Oct 2024 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ipvoAb7w"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C918E021
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839301; cv=none; b=I/Cc3MJOYgg0m9UsWnpJB4xv0RkIji6fKK+LkqirxU8T7SM1h7aZer13ETcLVxHxlEmPTtZvjeYSp9YiKYcJXAAI9cUnaOSb1GiJAMus0YndqvAVICRq3RHBwEXMw29nhZTHELnChm0L8K5oinpWDRTCy6Hp/e5Wx5XelusZuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839301; c=relaxed/simple;
	bh=tux+kVXoxeqatZsSvhUcOundmYXP9bd2WCJpZ0y15bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+WUK1zlpDuIq+lo6Ji+TeVGMGVA+OEnAYNJiannl28uZgdantmWRG8gQPzz6GdnOa4NP/JKrRGeTU05ULHowzNegqu3HvfYYdcJFLWC2W2sUgVi7A/XYrXUocBbTErQVoSyqwlFYCZ51xKJk8kox5acsZbx/gK8Mo90thvYf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ipvoAb7w; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729839296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utWPae6JOH6Gfwt6/OMxC57uOc92cN39G9Jp3wctaGM=;
	b=ipvoAb7wizNjLbnsMi5gnUC/2Kr5hGsx/CI0ySYYppvcYpqlTUz1B850F9inafyqCHXzXY
	E7DkHEaMgIrYY5RDQAZgpijc6GimwDDPw1Lz4E/aK0wvTtEMckswS67XU2Qo1fzsMF7QGG
	/XCQUFIUIWwLWVvd2uhykQ6kIGC1GUk=
From: George Guo <dongtai.guo@linux.dev>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	dongtai.guo@linux.dev,
	edumazet@google.com,
	guodongtai@kylinos.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com
Subject: [PATCH 1/1] add comment for doi_remove in struct netlbl_lsm_secattr
Date: Fri, 25 Oct 2024 14:54:41 +0800
Message-Id: <20241025065441.1001852-1-dongtai.guo@linux.dev>
In-Reply-To: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
References: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

---
 include/net/netlabel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 48106f910139..7091c8552fa1 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -209,6 +209,7 @@ struct netlbl_lsm_secattr {
  * struct netlbl_calipso_ops - NetLabel CALIPSO operations
  * @doi_add: add a CALIPSO DOI
  * @doi_free: free a CALIPSO DOI
+ * @doi_remove: remove a CALIPSO DOI
  * @doi_getdef: returns a reference to a DOI
  * @doi_putdef: releases a reference of a DOI
  * @doi_walk: enumerate the DOI list
-- 
2.34.1



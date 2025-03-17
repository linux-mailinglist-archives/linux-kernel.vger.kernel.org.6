Return-Path: <linux-kernel+bounces-563247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE141A63B12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6371A16D5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8171113C8F3;
	Mon, 17 Mar 2025 02:08:32 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6B199BC;
	Mon, 17 Mar 2025 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742177312; cv=none; b=EEP762rxlfuB1SYFvP1wed3W2+mwfTxmzZsA/F3KSSXhyeu254B4yZBgWoHZB4YR8i7aR+lPGo+E8PBPL7htPEB4PEpatxpiT28kuekJicCDjSQ42D/yWumrubn7dvbRSqxrWv1ZuC56KsNJmsC0dX9S/dbCZvhfUpNX2e+CeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742177312; c=relaxed/simple;
	bh=yPmiCRzGpPl2kZo59o7Bi1COBDNxBghe9zJSA/v5lsI=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=O4Tcn8wcqgQSG3rd5eI7ACaxke2cm+S1NssyeBioMYMVUOMd0/fM0U7ArgctkC5bt/LuP/08RuSoygrAd32EFIUPaLTpU6dBwW6aXthLSAXrNsCrbN+zJ7bnOHE2uKGcer8EgOgw3sanUt/d4NkxwU/mcoRRWsXqLk7cH8+ICDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGJKc1Jgwz8RTZT;
	Mon, 17 Mar 2025 10:08:20 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 52H2891F001068;
	Mon, 17 Mar 2025 10:08:09 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid31;
	Mon, 17 Mar 2025 10:08:11 +0800 (CST)
Date: Mon, 17 Mar 2025 10:08:11 +0800 (CST)
X-Zmail-TransId: 2afc67d7840b13c-1178e
X-Mailer: Zmail v1.0
Message-ID: <20250317100811126QvOaWRPxSgm2ttU5faitl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <si.yanteng@linux.dev>
Cc: <alexs@kernel.org>, <dzm91@hust.edu.cn>, <corbet@lwn.net>,
        <jiang.peng9@zte.com.cn>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkb2NzL3poX0NOOiBmaXggc3BlbGxpbmcgbWlzdGFrZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H2891F001068
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D78414.000/4ZGJKc1Jgwz8RTZT

From: Peng Jiang <jiang.peng9@zte.com.cn>

The word watermark was misspelled as "watemark".

Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
---
 Documentation/translations/zh_CN/mm/balance.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/mm/balance.rst b/Documentation/translations/zh_CN/mm/balance.rst
index 6fd79209c307..f877c0cfa39a 100644
--- a/Documentation/translations/zh_CN/mm/balance.rst
+++ b/Documentation/translations/zh_CN/mm/balance.rst
@@ -64,7 +64,7 @@ kswapd并不真正需要平衡高内存区，因为中断上下文并不请求
 如果从进程内存和shm中偷取页面可以减轻该页面节点中任何区的内存压力，而该区的内存压力
 已经低于其水位，则会进行偷取。

-watemark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd：
+watermark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd：
 这些是每个区的字段，用于确定一个区何时需要平衡。当页面数低于水位[WMARK_MIN]时，
 hysteric 的字段low_on_memory被设置。这个字段会一直被设置，直到空闲页数变成水位
 [WMARK_HIGH]。当low_on_memory被设置时，页面分配请求将尝试释放该区域的一些页面（如果
-- 
2.25.1


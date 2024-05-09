Return-Path: <linux-kernel+bounces-173963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876348C0859
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82761C210DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1181373;
	Thu,  9 May 2024 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="qReoNlXS"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26636C;
	Thu,  9 May 2024 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213752; cv=none; b=S01ce4y9B5Lieup+R9N1/zYPJSiKJD6srRdAzk84XhL6/SDLl0FOnJyawJcenPJegZ/+6KLszD30MVJV1DJVtpoxtCiVu+l7c+mUQkZOdbF6mCD2xw9aVI8EhMfW6aE2/KPWin+cuh7yHGymmEO1P3mW7nPlUGqfZ2vRPBywHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213752; c=relaxed/simple;
	bh=6vXRJoAQSDtzDhQsqX1drAJZ/gtmojMtCJOwd2W/7k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=In2m1icJ1RZzQ9FgVmpOJhvW6wywnbLPHKMhLiRijCsvlAy0a47DkEgBigcG7eE9bQXzJ9qfxZpwlr2rp/XugcZHnqAP/BKB89TFUWKOaJqdc0HMe3Mkr5NLxrnI8nIkG8gu05jM0tnkhL/4K+64TaZUAdzjfYD4YrdRJ5r65fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=qReoNlXS; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ibZmhWOcAPt5MRyyHxS6k6eiW0UrUpeBxWHVWTgQMZI=; b=qReoNlXSvSpRc1oG
	HKfjcTA3QJ6Fe4yfw9n71QiiNt1heHEfx/WBhH4boIUqgyxFgBtFn54/Qc3qYJ+Gn5jHdbKzQyPZ6
	SnsuWWWv13JZFBcRrs4tTID/RM25NN4WXlGJHLK32Z9K12T4WwHH/sW5kTPYsA5M1QF0WoHaQurZv
	Yo9XxLhn9XRO/vOCEc9w2EjpgCYcDCf+DkcHSa1/Vd+Cg5zWGdlXhW3OuizeS6+eCUSNT+O1lZ8bA
	LF78ovlTsEzf86SiuCPg7rCXjqCaUd1rjBVZcNe91+zxmH9Xr62MM3ZqjGCVfj4byM9RF1PT461HG
	DW5M61SBRRfo30L9/w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s4rRf-00074W-0w;
	Thu, 09 May 2024 00:15:35 +0000
From: linux@treblig.org
To: emilio@elopez.com.ar,
	mturquette@baylibre.com,
	wens@csie.org
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] clk: sunxi: Remove unused struct 'gates_data'
Date: Thu,  9 May 2024 01:14:52 +0100
Message-ID: <20240509001452.204929-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'gates_data' (and it's associated define) are unused since
Commit ee38b2698ae2 ("clk: sunxi: Add a simple gates driver").
Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 5fe7049ea693a..4999504f7e60d 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -852,17 +852,6 @@ CLK_OF_DECLARE(sun8i_axi, "allwinner,sun8i-a23-axi-clk",
 	       sun8i_axi_clk_setup);
 
 
-
-/*
- * sunxi_gates_clk_setup() - Setup function for leaf gates on clocks
- */
-
-#define SUNXI_GATES_MAX_SIZE	64
-
-struct gates_data {
-	DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
-};
-
 /*
  * sunxi_divs_clk_setup() helper data
  */
-- 
2.45.0



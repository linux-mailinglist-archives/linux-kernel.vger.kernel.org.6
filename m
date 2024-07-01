Return-Path: <linux-kernel+bounces-236884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6586891E83A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081881F23019
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095C316F907;
	Mon,  1 Jul 2024 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7V43KYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1816F83D;
	Mon,  1 Jul 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860720; cv=none; b=YBIvfIxkSokF4QAiTFxe3cGJ8U9UI+EJxFh7gYWFh0AJbPXFU+PTTkVXNDf1LP06e7yj1V+i35VmGiqqvXan9IE+JfAN/COnHQ4DcAoi+S9HQ4YX6Ns2P+hzAPy7O0u0X79xzjQPXZREJX5xAphCJpL/MKM9W02/2IOMOurKFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860720; c=relaxed/simple;
	bh=rKMcJwDzY3ZuJksWzSHVDhDaEID8BzH9D1KxvuRmlmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctgwN2EehdxCiWybVkPZiNkyiCsxnacFz8rqXdgNzE+zxjPZbReaVgJaeMX+7XcKosWgXeo1kTtRDv5vm80QKCwuAg/3ohUyjqVTHUYXziatxmolFGwr8enq6gfhPliz9mc7Wn7FRRU/horBYymgrRUSwE/QGbjirVaQBC97/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7V43KYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60542C116B1;
	Mon,  1 Jul 2024 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719860719;
	bh=rKMcJwDzY3ZuJksWzSHVDhDaEID8BzH9D1KxvuRmlmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7V43KYsH2R5cvdzJyDITL0e/NyhyNWt1Rg63WDxyYgnHtSV7YiMcUm2fecBl0eRB
	 QOO9o3MX07dA0NhzTgO6YBA4cGHgLK3xI+N77S6xGOALbtkSDJB13SctuGbgohycHo
	 4VbV1AcmL1IWBs+ZqUyKSq2KIWBTNFGb1oGs1IMkYL9mVEyTT02gkbuuKce6VKGDlq
	 dyXSB04HQjBH7r61rO9YeS/zY59IJ+IgLX8llwA2nFXxzpzMQJsAIzY1jacuirZqiT
	 rSUOJ4xpykCeB7KbfbxL0NBIpUlmwrcqN9ZPxn+1/BK2rBV4id9ywOu9Ip7RKrayP9
	 wW36ydYCUMdsA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Docs/mm/index: Remove 'Memory Management Guide' chapter marker
Date: Mon,  1 Jul 2024 12:05:10 -0700
Message-Id: <20240701190512.49379-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701190512.49379-1-sj@kernel.org>
References: <20240701190512.49379-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'Memory Management Guide' chapter aims to be not an additional chapter
of the document, but the ultimate single outline of the document.  In
the sense, marking it as a chapter under the document makes no sense,
and the rendered document looks odd.  Remove the chapter marker.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/index.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 48b9b559ca7b..5007815405f1 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -2,9 +2,6 @@
 Memory Management Documentation
 ===============================
 
-Memory Management Guide
-=======================
-
 This is a guide to understanding the memory management subsystem
 of Linux.  If you are looking for advice on simply allocating memory,
 see the :ref:`memory_allocation`.  For controlling and tuning guides,
-- 
2.39.2



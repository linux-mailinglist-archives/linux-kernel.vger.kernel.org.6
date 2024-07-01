Return-Path: <linux-kernel+bounces-236885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B191E83C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDE21F22AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49B17084B;
	Mon,  1 Jul 2024 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O06d+nZY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E316F903;
	Mon,  1 Jul 2024 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860720; cv=none; b=jraBq9NX9d4kYQVDNMDHpbVh33WsLlQgG7T+XMtrtB3bPxZp/W759M7valFyAWuMSJgN/Kz5Uny52SpfytJW+KuGLssrtqdMQhjRstcuOi11CCRLSqMlLwLQbq9fgoNiiYmEdhQLlJ3V7qmCMPLqn9Gu50FGotvoPoiu3XN6fpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860720; c=relaxed/simple;
	bh=bTyMdjkq+AKoAxGCqmfrGvEJ/bhfbC9NVbA58uF3Mcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QI4zN0YWrELZbssAeFpQRJvvKxL4jw/CUX/i4OsQTzmxfMT3LquMIncoiPCovGplUPxtiyUfP4avA4juFPFIeQJH4EblV4M5FGBxaaOcUoCFvu11Z3iDTXYy5NSVSOueHmJBtNZOYx5RulwPpsZRlkUQUjrx/HsdKvLW/pvNuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O06d+nZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BB2C32781;
	Mon,  1 Jul 2024 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719860720;
	bh=bTyMdjkq+AKoAxGCqmfrGvEJ/bhfbC9NVbA58uF3Mcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O06d+nZYXSie+R7axuFItnJh1jChfKyEno2jo+BIVJ3vTt+DaCGh7iPBH3zmoHkRt
	 o1scDSLXwcPP/2dXowFKicO1b1hpfwCXXPFQpjAsB4st1Va8D34ENoDjZ0pTosmdSd
	 4XT+NVgmYalVbax2MDnhyFaBtMrIoE0B9JcPp3I7jxptITyF1lC7BqRE5lawmCxtgi
	 yl2Oy2W2+6cpB0aNadUMsfo78oijYGjbMe4CjiV2RfGyytPpqSRb5zIFoO7ggv3apE
	 badyGrmnS28QV9Wrx07VGX4smRa+a77goPG3KmMdG+JxhCyqNazlJk1BaBRAZhKvQi
	 juEastP2T4mNQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Docs/mm/index: rename 'Legacy Documentation' to 'Unsorted Documentation'
Date: Mon,  1 Jul 2024 12:05:11 -0700
Message-Id: <20240701190512.49379-4-sj@kernel.org>
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

The intention of 'Legacy Documentation' chapter is to keep the old
documents that not yet sorted into the new outline, and encourage new
documents to be integrated in the new outline from the beginning.

However, the new outline will take some more time to be completed.  It
has started about two years ago, and still many parts are not yet
written.  Also, there is no clear guidline for placing each document for
all cases, for not only the 'legacy' documents, but also for new
documents.  For example, memory allocation profiling document has been
added to the bottom of the new outline.  Apparently it was not following
some well-defined guideliens or a result of a discussion.

Furthermore, the title ("legacy") makes people feel the documents on the
chapter might be outdated or not actively maintained.

Rename 'Legacy Documentation' to 'Unsorted Documentation' and remove the
description saying it is for 'older' documents.  After this change, new
documents that not clear enough where it should be placed on the new
outline can be added on the chapter while well-defined guidelines or
discussion for the new outline is made.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/index.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 5007815405f1..15614df2b989 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -25,14 +25,14 @@ see the :doc:`admin guide <../admin-guide/mm/index>`.
    oom
    allocation-profiling
 
-Legacy Documentation
-====================
+Unsorted Documentation
+======================
 
-This is a collection of older documents about the Linux memory management
-(MM) subsystem internals with different level of details ranging from
-notes and mailing list responses for elaborating descriptions of data
-structures and algorithms.  It should all be integrated nicely into the
-above structured documentation, or deleted if it has served its purpose.
+This is a collection of unsorted documents about the Linux memory management
+(MM) subsystem internals with different level of details ranging from notes and
+mailing list responses for elaborating descriptions of data structures and
+algorithms.  It should all be integrated nicely into the above structured
+documentation, or deleted if it has served its purpose.
 
 .. toctree::
    :maxdepth: 1
-- 
2.39.2



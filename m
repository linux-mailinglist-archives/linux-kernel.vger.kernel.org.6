Return-Path: <linux-kernel+bounces-186789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626848CC92B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806A51C2121D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE1B14901E;
	Wed, 22 May 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yo82asRq"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3C43147;
	Wed, 22 May 2024 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418056; cv=none; b=E4p1dc6a7PeH2XWMyTKQZvOF01YT8XPR9F15lYKobiwzsZyEF3oIK2SwusR1Nx8CiDOUxtpu5mmxuxHkgznzh6wkmTI3RNljfKNdqX4rtCnGWIPFjfNHnyE1eqaVzhxcxii1WQZCIY68HGiHBRUmFviF9UEIHwEsUqVU8C2lL4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418056; c=relaxed/simple;
	bh=1tQYnuBW0tCO/M95+qVez0oXwbjCD36YNuqAKFKPkjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVBC40/lG7c+MGhPmpD55kpmUOO6qYG8AwSyaOS4lBtLXbJXpL/MIHLwvFTvTwGW0A9qgD0xdD69hS3u/Zn4Z68b7YQFs41mN0TGVJwr/bA8ln4hbS0DLg4rCTEWqNsEqy7vWpTUwdunmUKtJzr2PUE5Y8qChRNa+Fx8Sb6HyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yo82asRq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=B60f+SkB/fbDXXMGfWZNp//l2iDgy3hxtoJM7FOinzM=; b=Yo82asRquTYyeclv+7EF8LGaaG
	pMOvX1SPnVTWRJLyLNRwEvL1LB47kuJjOfHrPGWXaoFmKgpvDgclHhWx5EKbO9VTeVtOM6jYUTYxQ
	Fc/za1ohTH4HajpKvuWGpIAPf0aGYy3YnqBs2N5lwv1QCGvZuemQgGlMw+uiJuH9YLMy74pVmh3c8
	8LxUAfugpEegadeIa3zBxgen+fIxXcNKlJ87/yNW7Rfu583c08VcMpWKc2jbHiK6Vj47furftaPbt
	pU0mQIEDOOydrrTMagpCZF/me1XkNw7eenGzWIw/dNXxa/x7I+bHXihApY0e2yO3c9Mub/I9TlcQD
	yXts3QyQ==;
Received: from [50.53.4.147] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9uk5-00000004K9L-1jjb;
	Wed, 22 May 2024 22:47:29 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] doc-guide: kernel-doc: document Returns: spelling
Date: Wed, 22 May 2024 15:47:26 -0700
Message-ID: <20240522224726.10498-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scripts/kernel-doc accepts "Return:" or "Returns:" for describing the
return value of a function or function-like macro, so document this
alternative spelling and use it in an example.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/doc-guide/kernel-doc.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -143,7 +143,7 @@ Return values
 ~~~~~~~~~~~~~
 
 The return value, if any, should be described in a dedicated section
-named ``Return``.
+named ``Return`` (or ``Returns``).
 
 .. note::
 
@@ -337,7 +337,7 @@ Typedefs with function prototypes can al
    * Description of the type.
    *
    * Context: Locking context.
-   * Return: Meaning of the return value.
+   * Returns: Meaning of the return value.
    */
    typedef void (*type_name)(struct v4l2_ctrl *arg1, void *arg2);
 


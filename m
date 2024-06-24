Return-Path: <linux-kernel+bounces-227803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 106EF9156B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B401F2334E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0201A08C5;
	Mon, 24 Jun 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaxY+8Iv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759761A073F;
	Mon, 24 Jun 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255204; cv=none; b=ZSoPhRLlaoHzSlSPHtslr5lPHaW0zuAKxDuy+MP3exhHpVTPCPFnIU4PjXH0y23DkEKVKMnx8g3R1pJsg2qyghaW6Oc0NMx3WKzMiBSKiBtbiaDb+W82aDPCdTPjXW7dguuExkVSYAnjnbRuECmz9ZafPtuXUeQfkHdx0+70DgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255204; c=relaxed/simple;
	bh=+nbEkWVL58PcOho777Tkey6NWbXPb+PkAn/m+4dnTYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3Dn0wf0fKcHQgPRIYE+XOM0km/EJpeRvh9HsQaxM4oykIPbxTcFQHR6k9IYUkdstDSKD6rJsDtOc9NsUptIVhiV9PLa/+5vtul7Hp1ZDMRGbPduFH752DnKsjQCpkjwTjbajlx7byGWLPwEybU7f7LerZa9wvXtJ6sHXUDN32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaxY+8Iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA8EC32789;
	Mon, 24 Jun 2024 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719255204;
	bh=+nbEkWVL58PcOho777Tkey6NWbXPb+PkAn/m+4dnTYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VaxY+8IvqTKVzCenWb5hO4ad6+tBvNH83oCkXB7OplNpVdE8feP9dblPCmV8ir10r
	 6oKdcG8OadxdxONI8lm18I9p8Hggbna6CC5Ugu23OVdjCXBNlotTHgJQs2zvMRlduu
	 2LScn4zeqB7/hn+2rbkvA2BfxIXUONOf4olLT5hGiDjbp4YYx6aW4eLeVVlsFoQUnG
	 gNygmFTlulSK3QXrxnDra60nlXvDyCNuq+Lt9Vhe7pl2x4AWGSKwu26afbtXWfBQnK
	 o3I+uEgI5Q9apQkXjMmzeTULvSf/NhLT8KWp8ws2TvIY3k8MygxiDH9wJafOaDbwzV
	 BZ4TJMNO2cmpg==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] Docs/process/index: Remove unsorted docs section
Date: Mon, 24 Jun 2024 11:53:10 -0700
Message-Id: <20240624185312.94537-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624185312.94537-1-sj@kernel.org>
References: <20240624185312.94537-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'Other material' section on 'process/index' is no more necessary since
we have 'staging/' directory.  Also all documents on the section has
moved to better places.  Remove the section.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/process/index.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 1827e73f6376..6455eba3ef0c 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -107,13 +107,6 @@ developers:
    kernel-docs
    deprecated
 
-These are some overall technical guides that have been put here for now for
-lack of a better place.
-
-.. toctree::
-   :maxdepth: 1
-
-
 .. only::  subproject and html
 
    Indices
-- 
2.39.2



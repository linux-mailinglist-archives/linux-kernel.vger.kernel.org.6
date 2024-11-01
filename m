Return-Path: <linux-kernel+bounces-392895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583AC9B995D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8871C2170E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F071D5AA3;
	Fri,  1 Nov 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtJ3lJcm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279C0155C9E;
	Fri,  1 Nov 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492594; cv=none; b=Q6vhkGzYT7JzeAD+oHMjcfIOuga/wt5DJ2aB2JYN7K0QdMkerIXohvb7DpzlDmhIvNbsn3Lg2EOjqLjxQ5cSicugPuKIKnKEloMXpMxldUGt8Iu39FkBOL5npUolHEpvBZkXh4jS8zGnnApUROAtcchfoT7CSNPC0dmZM5EqG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492594; c=relaxed/simple;
	bh=ihRrGAEmLNfS3eVwK7YGTki4LMg6195NsDFFwhalEI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ucInhx2H4MyqIr41Tano+2UxoTRa1T1cl2B9RpQ1hvxj8MsoL4V906jWBIbloOyEdxpyPaGlwkhHqSDlx95E6P5NKnOzWhofuyH5FaPKyO9Ia610rwYyyARStdFJ6zyCJEXNjbLrrrgvIDbpZuzdglnKl7+bvuLaVhlev3mKfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtJ3lJcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87F5C4CECE;
	Fri,  1 Nov 2024 20:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730492594;
	bh=ihRrGAEmLNfS3eVwK7YGTki4LMg6195NsDFFwhalEI0=;
	h=From:To:Cc:Subject:Date:From;
	b=TtJ3lJcmGwBAiapQR48vwD4rTGJj3VEHFzZcLCNEAdFr3a6i9Rpon8rqJSLWDrxi9
	 4UCWgreSkBnNFTgZ3p0EzZ9CDizVf5W6kxZsRNo1IR27IEFioZXT34oFfG0wrq4Mcj
	 5LFgrxEL9WD+0Sxr6WXB1pIP6l4M25X7A4inwQpib4CX1aCKmuWdxg+jEXDeEu478x
	 N0Gwty83mz1eX/wU7CEuEGL+s4I6qzIF4khuf3K5zNciKeLX8VsAzZirRTM75V9K5L
	 8G5julti7ytKFnvV6EN4+i8zAUGJgR8YQTAYydmKRQFqOjqMHpffLxSaRBnom5RH2E
	 ntgfXKdHuS0Ww==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] MAINTAINERS/MEMORY MANAGEMENT: add document files for mm
Date: Fri,  1 Nov 2024 13:23:10 -0700
Message-Id: <20241101202311.53935-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory managment subsystem documents ('admin-guide/mm/' and 'mm/' under
'Documentation/') are not marked as managed under memory management
subsystem.  This makes 'get_maintainer.pl' for changes to the documents
sub-optimal.  Mark the documents as part of mm subsystem on MAINTAINERS
file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a18c2e135cd..2a2e92129646 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14794,6 +14794,8 @@ S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
+F:	Documentation/admin-guide/mm/
+F:	Documentation/mm/
 F:	include/linux/gfp.h
 F:	include/linux/gfp_types.h
 F:	include/linux/memfd.h
-- 
2.39.5



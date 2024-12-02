Return-Path: <linux-kernel+bounces-427076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2619DFBFB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3BC163006
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6599B1F9A90;
	Mon,  2 Dec 2024 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="CjKJEw3o"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F81F9F5A;
	Mon,  2 Dec 2024 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128432; cv=none; b=Q1yvkv3BLhAFQoYzNJarsCCRDE1PXqwhbvOrxA5IuYiAzyNyiqYkXFG5ddNw/dgo1eEANP2IBHPlfhowlzuk/wjsrEtB+SKagMGZph1cZhxePJl9ZMBi0SCkx4Q/qAvSQ8FrRlKe4SBccqPX87uuK+z3ULZO9iCr3t3xvdP23FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128432; c=relaxed/simple;
	bh=99ArZTK7tcVLa5SaIkfWUlEPEOmChHqnidmycbO9cNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDbjy0IJcv4NzS6X1aKnucN2nCYoaWYgns5vpZkFW/toKtL32Ifi8RANzSCvrrqHRV2lCo5H6xtLPb+6h2OtTWr3ZyCR6cEAU8kVRfdmhIpMPvgXpjEr+CGeAcR+cQ6IiFXazJRqgqba55qKTdjDjJhRdZXXVtiywzRWTOxxzso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=CjKJEw3o; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FqKUmUiCl6s+B2b8EynyhbWkz9daCCSNfiIR5rKfjYk=; t=1733128431; x=1733560431; 
	b=CjKJEw3orbW5IZP52d8us2iK8i3wJuS3I7HoFo7zBmpZ5uOvI/nse8qgP3rUxt5CfGBtfsKietd
	w+laIbaAsuHfMrpj4Jaw10EMMrrd+LghUkeQ7vDJyj/p53egT5LRdidDuXHkFUmVyGLbT1jrZN+uy
	HBVN6e+Q4tIGI6bki/5xQtPpA3bApbPBffy2BdGumHLhzCx5ZAehzEivn8RWsoRnpFZAv74Z7HSjh
	SkOq3t3GWquA1WNl7vemyTvq8tDruF5GRNenciJigqjjev7FtFBe2OGNlbbUGyDOdp2yCnP+wtVA3
	4xE1Un/a0bH07+0Pt+Dej2EJGQJa8c6BpixA==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1tI1XY-0019mO-0J;
	Mon, 02 Dec 2024 09:12:20 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3] docs: 5.Posting: mentioned Suggested-by: tag
Date: Mon,  2 Dec 2024 09:12:19 +0100
Message-ID: <fbebad6605b02e372b24c2cfa1e05f789fed43d1.1733127086.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1733128431;68c22e5a;
X-HE-SMSGID: 1tI1XY-0019mO-0J

Mention the Suggested-by: tag in 5.Posting.rst in a way similar to
submitting-patches.rst, which according to the header of the latter is
the less detailed document of the two.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
v3:
- first version, split out from another patch-set that was at v2:
  https://lore.kernel.org/all/1609d461030094b294f08d0b4e208d32993ac799.1731749544.git.linux@leemhuis.info/
- add Reviewed-by: from Greg
---
 Documentation/process/5.Posting.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index b3eff03ea2491c..dbb763a8de901d 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -261,6 +261,10 @@ The tags in common use are:
    can be used instead of Closes: if the patch fixes a part of the issue(s)
    being reported.
 
+ - A Suggested-by: tag indicates that the patch idea is suggested by the person
+   named and ensures credit to the person for the idea. This will, hopefully,
+   inspire them to help us again in the future.
+
  - Cc: the named person received a copy of the patch and had the
    opportunity to comment on it.
 

base-commit: 83a474c11e8cb59e230a43365cb42fa00d3bddaa
-- 
2.45.0



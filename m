Return-Path: <linux-kernel+bounces-266057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3B793F9E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F1F1F23181
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8534A15B0FC;
	Mon, 29 Jul 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QOtotAsE"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E00D1E4A2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268682; cv=none; b=JWw3SHsztQdrP/ZLkpCMGKf15yiDKyAQRDnIXZ2UPrmWretYdLDg/fAAIUA/HkUdf7lFkJocQHWt1vvX7mmaN8tCQ8XxA+ScUxD2w+XFsIYtTJAYBRbdGECDwA+nVOzx8MLTH7a1ijDsjsnNrH1S3IoZZaxAJzxHmMIZszo7xmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268682; c=relaxed/simple;
	bh=H4Bk4m5w4iIxjvAzVKOX83OHjCju76goAppAcbiWJsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGsrHTg1mLmgfdD1p7tC5XcZj0ZA/U54V75FXNov/BBe+U+8NwjQa8lBPx7pztU0/CZiXDT2kaJPAaL2cDWgjKNdyX/fU716YxKSWwY1tF7p6KcLUdP4Uv1anhQhocBkMixZQTRgrxWoQmF9QegJ6oj4jKl1oWb1a0W8yzUcnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QOtotAsE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 397C1229;
	Mon, 29 Jul 2024 17:57:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722268632;
	bh=H4Bk4m5w4iIxjvAzVKOX83OHjCju76goAppAcbiWJsc=;
	h=From:To:Cc:Subject:Date:From;
	b=QOtotAsEUnu70g2KprH64dAgs7ghkPJZtylVECSHJ1cLfUJiUvw51JW6IiZ9DU6f1
	 0f9950ZTZgbzgIuHuQ7tlLSFiiiTs/i2KIpO5YieI7S4t37PXjKKFeMnThM1e0n3h4
	 BqM2N/+yaYvaBYzawL3CLvyDBFXp14O1VttOcYrs=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Alexey Dobriyan <adobriyan@sw.ru>,
	=?UTF-8?q?S=2E=C3=87a=C4=9Flar=20Onur?= <caglar@pardus.org.tr>
Subject: [PATCH] Remove *.orig pattern from .gitignore
Date: Mon, 29 Jul 2024 18:57:38 +0300
Message-ID: <20240729155738.29142-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3f1b0e1f2875 (".gitignore update") added *.orig and *.rej
patterns to .gitignore in v2.6.23. The commit message didn't give a
rationale. Later on, commit 1f5d3a6b6532 ("Remove *.rej pattern from
.gitignore") removed the *.rej pattern in v2.6.26, on the rationale that
*.rej files indicated something went really wrong and should not be
ignored.

The *.rej files are now shown by `git status`, which helps located
conflicts when applying patches and lowers the probability that they
will go unnoticed. It is however still easy to overlook the *.orig files
which slowly polute the source tree. That's not as big of a deal as not
noticing a conflict, but it's still not nice.

Drop the *.orig pattern from .gitignore to avoid this and help keep the
source tree clean.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
As this has been in the tree for so long and appears not to have botherd
anyone, I have a strong feeling I've overlooked something and this patch
will be rejected. I've actually had that feeling for a few years
already, and today I decided that maybe everybody else used the exact
same reasoning, explaining why the annoying *.orig pattern is still in
.gitignore.
---
 .gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 7902adf4f7f1..58fdbb35e2f1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -142,7 +142,6 @@ GTAGS
 # id-utils files
 ID
 
-*.orig
 *~
 \#*#
 

base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
Regards,

Laurent Pinchart



Return-Path: <linux-kernel+bounces-333405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E5D97C81A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9910E1C246B2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8919ABB4;
	Thu, 19 Sep 2024 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGzX053/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE0168BD
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742539; cv=none; b=fnEVz9vPuDsl0YVqQXp63nueGMtO5amtoN3jQYnCugUi/oRQ77XqLvm3E1iZl4FPV2UPhZ6vGoBjQb/SJy18Usqr32vd7rtybEeCnBKuee6z8eb2QYCels0nEG51UTBZmcujPiOnxdbnz8uSdNE+HqjKAnlEZ6xz05TAwiUgN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742539; c=relaxed/simple;
	bh=dsGKreUhg585i1GMTCc1aIriMbL6tNeRAhG/pt1htz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E2T/MxYMgA3kH2LZSFGVc+0wGtS9bbCY3yzPI30MoS98Zf5x5tGxOy23wjbcsQSVvVatJVHD5zofepN9brFFx1zQpA/uVTaUV8UG0gyMXSVzj+b7IeLdmYtHj7ugxAqxlYdxsUKfxI+VnW2D/R8vPr2xiavK8tLLIFR/DVQ89Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGzX053/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D1F5C4CEC4;
	Thu, 19 Sep 2024 10:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726742539;
	bh=dsGKreUhg585i1GMTCc1aIriMbL6tNeRAhG/pt1htz8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AGzX053/cx7BdD2Gye0lP7CEysrcBA3KdIgYP9/5ZZl5pvgKaPE3v1yKuzLVALsTk
	 gyEv6TLW0x5uhRg2e2DnPv4p1ReIyxX9Q5gG+A051nhRGGoJGcW3ttoaUaRxz62oep
	 AxAeOoix/Z4ONflljooLGtQle+je3gwc1IF0x5noqWYp6My1LU6MGqhCpgS2f3U+6c
	 rS52xhW9LkePtQPRCVmfKq9Yf22BUJZpYfF0Yrnyqf3gwJLz5oEFLHNLAl5lGl8b3J
	 7/NSJuGcEpvOaxvkrXeqkm9+vQsxzOgKykeXLAEV7WkToMVQ+6hWnLTlMCfON3R9HZ
	 NFS18dgRu03Gg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68AACE8D79;
	Thu, 19 Sep 2024 10:42:18 +0000 (UTC)
From: =?utf-8?q?T=C3=B3th_J=C3=A1nos_via_B4_Relay?= <devnull+gomba007.gmail.com@kernel.org>
Date: Thu, 19 Sep 2024 12:42:00 +0200
Subject: [PATCH] scripts: checkpatch: Check spaces in Makefiles.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240919-checkpatch-makefile-spaces-v1-1-f247fd2ba4cf@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPf/62YC/x3MQQqEMAxA0atI1gZsEbRzFXFRY7RBR0sjIoh3t
 7h8fPg3KCdhhV9xQ+JTVPYtw5QFUPDbzChjNtjK1pUzDikwLdEfFPDvF55kZdToiRWbmsxAo22
 tI8iDmHK+vnnXP88LqSXOx2wAAAA=
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726742538; l=1959;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=cj6gu4/UTXFzy6OsqnaOr/hYFlv40OHqBGK224ZRoTY=;
 b=6NtY27pxl6eurNqMk3Nvy0KrRMsJSNpoJaZdHfi8EJQAHiHbIxaMLrMPx5VDPQnPu34NEMeVQ
 o9QTsTXClT+AH7eafe5Yw8hFOgd/BxfLK6b6LlhKbifGe2RP+v8JLYq
X-Developer-Key: i=gomba007@gmail.com; a=ed25519;
 pk=iY9MjPCbud82ULS2PQJIq3QwjKyP/Sg730I6T2M8Y5U=
X-Endpoint-Received: by B4 Relay for gomba007@gmail.com/20230706 with
 auth_id=60
X-Original-From: =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
Reply-To: gomba007@gmail.com

From: Tóth János <gomba007@gmail.com>

I've found a Makefile that looked like this:
    obj-$(X)<tab><tab>+=<space>X.o
    obj-$(Y)<space><space>+=<space>Y.o

This patch allows checkpatch to detect this type of style error
in Makefiles. The check is disabled for the comment-only lines.

Signed-off-by: Tóth János <gomba007@gmail.com>
---
 scripts/checkpatch.pl | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..25b6f5b024c0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6,6 +6,7 @@
 # (c) 2007,2008, Andy Whitcroft <apw@uk.ibm.com> (new conditions, test suite)
 # (c) 2008-2010 Andy Whitcroft <apw@canonical.com>
 # (c) 2010-2018 Joe Perches <joe@perches.com>
+# (c) 2024 Tóth János <gomba007@gmail.com>
 
 use strict;
 use warnings;
@@ -3718,6 +3719,26 @@ sub process {
 			     "Use of $flag is deprecated, please use \`$replacement->{$flag} instead.\n" . $herecurr) if ($replacement->{$flag});
 		}
 
+		if ($realfile =~ /Makefile.*/ && $rawline !~ /^\+\#/) {
+			if ($rawline =~ /  /) {
+				my $herevet = "$here\n" . cat_vet($rawline) . "\n";
+				WARN("MULTIPLE_SPACES",
+				     "please, use tabs\n" . $herevet)
+			}
+
+			if ($rawline =~ / \t/) {
+				my $herevet = "$here\n" . cat_vet($rawline) . "\n";
+				WARN("SPACE_BEFORE_TAB",
+				     "please, no space before tabs, use tabs\n" . $herevet)
+			}
+
+			if ($rawline =~ /\t /) {
+				my $herevet = "$here\n" . cat_vet($rawline) . "\n";
+				WARN("TAB_BEFORE_SPACE",
+				     "please, no tab before spaces, use tabs\n" . $herevet)
+			}
+		}
+
 # check for DT compatible documentation
 		if (defined $root &&
 			(($realfile =~ /\.dtsi?$/ && $line =~ /^\+\s*compatible\s*=\s*\"/) ||

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240919-checkpatch-makefile-spaces-74c1bcd2829c

Best regards,
-- 
Tóth János <gomba007@gmail.com>




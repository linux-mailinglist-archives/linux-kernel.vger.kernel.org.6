Return-Path: <linux-kernel+bounces-382090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5AA9B0907
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED1C1F23AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB137082B;
	Fri, 25 Oct 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FO2p8gLK"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630470816
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872022; cv=none; b=sT0iWkpDF6yhKlHwGDKM4l3/7kXx1fEx2HvmI82N06AYD/aVF2o+uaySJzcz3ENSlIr4Ykj1Y+4Jq3Ub87s39y4k3M1CqCf+9JNi4twqCNKgxDtBdo54ObRHLTiuNeg+o9TmHgGDPqcy4H7Vq4FMOSd2W6aLqYnhfS8svnqqjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872022; c=relaxed/simple;
	bh=bc7z2TrjPCemYNFXMKTXgqZ9s5+UAL9PCibzgFBB7FM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UjBSuPy/VvjL1WYli0+ighCrZUwWBSoutuV8EfaxVLBmCq/QUaN1cPzdCBeuSZQ4Z310/vFdqLMEprkoLV5xkYHzVobQNdqwhycVuZ4T89Hfc4f/gzCYtwDHpJvgTGGKYAzyWZ/jn/3pdIABoNLBFV0VB60R24mChUH++9rBrHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FO2p8gLK; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729872012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A6VQYF4EfyDGrmwUI4CX6ZEqHhlwwOz819w7ZIjm6cY=;
	b=FO2p8gLKQJC/WBuX8HIm7hWRu/J2GiJjyF3zvzu/MWLF93O4tQksQ1JC0XM8siPxeKSAt4
	uKxobKzgU3qBorNkUZ2FcK1uq32V49QvrKbzGKXi0TNrDswLUZ6FdepLnwQn/mv005ZPpS
	9zgpxjiaFpi96xZZcihpDTXL2LHeq25gw81tkH8YylBTAFGgKlJSvDWTSvOgw8o4H7auPE
	r/Z81ucoqf6Q9Yqhk1K29qoL6dQ8v1RFx0psxFt0uafBgBaPY/YZAK3qxv0xmk/DWhEXbs
	rGZdieLNUwq0QaEVxZW/3Rjx+iyZQlipu+81+Az42i8ILyJvofiRBknX8kYoPA==
To: apw@canonical.com,
	joe@perches.com
Cc: dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	linux-kernel@vger.kernel.org,
	wens@csie.org,
	dsimic@manjaro.org
Subject: [PATCH] checkpatch: Make Helped-by tag supported
Date: Fri, 25 Oct 2024 18:00:06 +0200
Message-Id: <0e1ef28710e3e49222c966f07958a9879fa4e903.1729871544.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Providing a Helped-by tag fits well to indicate someone had helped with the
development of a patch, to the level that still doesn't warrant providing
a Co-developed-by tag, but is much more than it would've been indicated by
providing a Suggested-by tag.  The Helped-by tag been already used recently
a few times in accepted patches. [1]

With all this in mind, let's have Helped-by supported in checkpatch.pl.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=Helped-by

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..b89e62e9c2dd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -622,6 +622,7 @@ our $signature_tags = qr{(?xi:
 	Reviewed-by:|
 	Reported-by:|
 	Suggested-by:|
+	Helped-by:|
 	To:|
 	Cc:
 )};


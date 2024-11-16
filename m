Return-Path: <linux-kernel+bounces-411662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2909CFD83
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2FF1F24971
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4E195FD1;
	Sat, 16 Nov 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="doOIwu+2"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A631392;
	Sat, 16 Nov 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731749654; cv=none; b=W91h9ebGof5aB/KlGF8478jSDUdrrhb4edmc1SVDMXrgHh5wdi6dpBNedMj8z++jGgTzZI9kdQ9lN2bEVuYQLFcOecqPUpIEbC+io2XQz0ao3BxV+0ACU15la36igow0IExHV9YBi8fN9QsAUy6fz/QBP4DBO+6zApjLd4sxOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731749654; c=relaxed/simple;
	bh=fcyHdKBaaOcp4SOzcyohtK51LedxONG+91PAo9bYDXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLln1N/BZ0BGxWWw79/7+9cugaFTX0sYAAE4KKx+MzBLn/r/mJo5bw6vbTbRwTRpG07gdSGfnwCbVT4/7AjrU4p/O8Qa5X+/zlFPhQtSd1GU8fwjrTqs2TzsiXjv5oHe6viYZyRp0kOudPoQOa2WxkBN4q1WnbLItPz9QYv8Hkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=doOIwu+2; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ERpHHIlmOxKSD8uvST6R7aQ94mWDFC0AnszypSIVQN0=; t=1731749653;
	x=1732181653; b=doOIwu+2Z8j6KVwx1aTCi5iYEfBt32RoLm4FevUTVlD7mzr7CTCJY0gtWBbOw
	ASgoofROLB4i3aaCPWTcfW1beCCPnUdaa7Ufl4ZKAbKHknzsZ+tXASRbdL7dvL7kB9BTYLKcyoo1i
	8K8sadN6kkA4EKDDqtdt7asl3d48MnU0I0AhFBk4lYZ1aAHvINV96glTdPAf43kCpqN6/ZNS7dHkd
	f2kzoYmoS3MJTH1TpdknSCdQj8AkiatisN26hb5aRk09noDPrSHSZH0s0oW8tJ31rA3Lovh+Th4Ph
	0xuScY+CWHF9dNvKOVPpLMOrQJl9yhxcOVzqCu0k/WqToTwHqQ==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1tCFBo-0000BI-OX; Sat, 16 Nov 2024 10:34:00 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] docs: 5.Posting: mentioned Suggested-by: tag
Date: Sat, 16 Nov 2024 10:33:58 +0100
Message-ID: <1609d461030094b294f08d0b4e208d32993ac799.1731749544.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1731749544.git.linux@leemhuis.info>
References: <cover.1731749544.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1731749653;55500d11;
X-HE-SMSGID: 1tCFBo-0000BI-OX

Mentioned the Suggested-by: tag in 5.Posting.rst in a way similar to
submitting-patches.rst, which according to the header of the latter is
the less detailed document of the two.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
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
 
-- 
2.45.0



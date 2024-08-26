Return-Path: <linux-kernel+bounces-300648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4BF95E68B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9131F21288
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88476282F4;
	Mon, 26 Aug 2024 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfNyueGh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B72FC08;
	Mon, 26 Aug 2024 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637467; cv=none; b=KZGiql/C9+qs6bgP66comb/i1vJlZ5Q87pZm0P5kr+JX1JrvaOGZbIQq2DjbKiI41GKSsZ2lxJ24yFIRPd7FrY9twXzMTYj6Qdy4N5WVsj1vLdp+VYaOEOn7IGieuyT60JjvPrnBANT3bKhSWclkeLG7RcCBwYRMgIy25AizQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637467; c=relaxed/simple;
	bh=JVZ1e15QPo3CgnpjsPGBbluDVYbC60RWJ4aEogp07ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CsJwFaY0CxTqCSWWuE6soB+zqE6eTR8NVIBPXqYxZa/O3fpSctv5tnIxaZmPxKiGFJoUri43PSvnD4tooMFOaWGCrC4IOninw91uUmIykxOAD2J6bBnYCeBfw+4dcmwZacTQj/va/B6g3raqlWB6XzAxOAemD1mNsY1GYG9lZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfNyueGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BDAC4DDE7;
	Mon, 26 Aug 2024 01:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724637467;
	bh=JVZ1e15QPo3CgnpjsPGBbluDVYbC60RWJ4aEogp07ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfNyueGhx4LJPERlgBY/8ljixzNlYaP6x+v7mrQF3pEFh1vH2BH1uzIniEs9BONBa
	 +vRBGyd5q5EpPpmXk+HQry3XWD5rQM5gduU/chYoHMeAWKyS9/JdZfUW6BELZIwz8L
	 z01sJRGzJO61umKvrHWW9vuszhrsP/rDu1tcmxGM9rRFD4KIOgis54rqupDibMfbu4
	 73jczuSe17BeoPEh3O4dKZagTFD2PBOOvVZTGdmFf6etQgLmvSGHsTq9jfIe785d22
	 G1gnWWPVvFbSopKyYnKwLZrZfn1WNWNlkGwQbDb/YIcgT8QAE2gVCIT8F6cA5G395K
	 YM91Psts9QqJA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Docs/damon/maintainer-profile: add links in place
Date: Sun, 25 Aug 2024 18:57:40 -0700
Message-Id: <20240826015741.80707-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826015741.80707-1-sj@kernel.org>
References: <20240826015741.80707-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maintainer-profile.rst for DAMON separates the links and target
definitions.  It is not really necessary, and only makes the readability
worse.  At least the definitions need the section title (say,
"References").  Just add the links in place on the doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 84 ++++++++++---------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 048b78e6d989..3c1b42b062ea 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -7,23 +7,27 @@ The DAMON subsystem covers the files that are listed in 'DATA ACCESS MONITOR'
 section of 'MAINTAINERS' file.
 
 The mailing lists for the subsystem are damon@lists.linux.dev and
-linux-mm@kvack.org.  Patches should be made against the mm-unstable tree [1]_
-whenever possible and posted to the mailing lists.
+linux-mm@kvack.org.  Patches should be made against the mm-unstable `tree
+<https://git.kernel.org/akpm/mm/h/mm-unstable>` whenever possible and posted to
+the mailing lists.
 
 SCM Trees
 ---------
 
 There are multiple Linux trees for DAMON development.  Patches under
-development or testing are queued in damon/next [2]_ by the DAMON maintainer.
-Sufficiently reviewed patches will be queued in mm-unstable [1]_ by the memory
-management subsystem maintainer.  After more sufficient tests, the patches will
-be queued in mm-stable [3]_ , and finally pull-requested to the mainline by the
-memory management subsystem maintainer.
-
-Note again the patches for mm-unstable tree [1]_ are queued by the memory
+development or testing are queued in `damon/next
+<https://git.kernel.org/sj/h/damon/next>` by the DAMON maintainer.
+Sufficiently reviewed patches will be queued in `mm-unstable
+<https://git.kernel.org/akpm/mm/h/mm-unstable>` by the memory management
+subsystem maintainer.  After more sufficient tests, the patches will be queued
+in `mm-stable <https://git.kernel.org/akpm/mm/h/mm-stable>` , and finally
+pull-requested to the mainline by the memory management subsystem maintainer.
+
+Note again the patches for mm-unstable `tree
+<https://git.kernel.org/akpm/mm/h/mm-unstable>` are queued by the memory
 management subsystem maintainer.  If the patches requires some patches in
-damon/next tree [2]_ which not yet merged in mm-unstable, please make sure the
-requirement is clearly specified.
+damon/next `tree <https://git.kernel.org/sj/h/damon/next>` which not yet merged
+in mm-unstable, please make sure the requirement is clearly specified.
 
 Submit checklist addendum
 -------------------------
@@ -32,18 +36,27 @@ When making DAMON changes, you should do below.
 
 - Build changes related outputs including kernel and documents.
 - Ensure the builds introduce no new errors or warnings.
-- Run and ensure no new failures for DAMON selftests [4]_ and kunittests [5]_ .
+- Run and ensure no new failures for DAMON `selftests
+  <https://github.com/awslabs/damon-tests/blob/master/corr/run.sh#L49>` and
+  `kunittests
+  <https://github.com/awslabs/damon-tests/blob/master/corr/tests/kunit.sh>`.
 
 Further doing below and putting the results will be helpful.
 
-- Run damon-tests/corr [6]_ for normal changes.
-- Run damon-tests/perf [7]_ for performance changes.
+- Run `damon-tests/corr
+  <https://github.com/awslabs/damon-tests/tree/master/corr>` for normal
+  changes.
+- Run `damon-tests/perf
+  <https://github.com/awslabs/damon-tests/tree/master/perf>` for performance
+  changes.
 
 Key cycle dates
 ---------------
 
-Patches can be sent anytime.  Key cycle dates of the mm-unstable [1]_ and
-mm-stable [3]_ trees depend on the memory management subsystem maintainer.
+Patches can be sent anytime.  Key cycle dates of the `mm-unstable
+<https://git.kernel.org/akpm/mm/h/mm-unstable>` and `mm-stable
+<https://git.kernel.org/akpm/mm/h/mm-stable>` trees depend on the memory
+management subsystem maintainer.
 
 Review cadence
 --------------
@@ -58,16 +71,17 @@ Mailing tool
 
 Like many other Linux kernel subsystems, DAMON uses the mailing lists
 (damon@lists.linux.dev and linux-mm@kvack.org) as the major communication
-channel.  There is a simple tool called HacKerMaiL (``hkml``) [8]_ , which is
-for people who are not very familiar with the mailing lists based
-communication.  The tool could be particularly helpful for DAMON community
-members since it is developed and maintained by DAMON maintainer.  The tool is
-also officially announced to support DAMON and general Linux kernel development
-workflow.
-
-In other words, ``hkml`` [8]_ is a mailing tool for DAMON community, which
-DAMON maintainer is committed to support.  Please feel free to try and report
-issues or feature requests for the tool to the maintainer.
+channel.  There is a simple tool called `HacKerMaiL
+<https://github.com/damonitor/hackermail>` (``hkml``), which is for people who
+are not very familiar with the mailing lists based communication.  The tool
+could be particularly helpful for DAMON community members since it is developed
+and maintained by DAMON maintainer.  The tool is also officially announced to
+support DAMON and general Linux kernel development workflow.
+
+In other words, `hkml <https://github.com/damonitor/hackermail>` is a mailing
+tool for DAMON community, which DAMON maintainer is committed to support.
+Please feel free to try and report issues or feature requests for the tool to
+the maintainer.
 
 Community meetup
 ----------------
@@ -83,17 +97,7 @@ members including the maintainer.  The maintainer shares the available time
 slots, and attendees should reserve one of those at least 24 hours before the
 time slot, by reaching out to the maintainer.
 
-Schedules and available reservation time slots are available at the Google doc
-[9]_ .  DAMON maintainer will also provide periodic reminder to the mailing
-list (damon@lists.linux.dev).
-
-
-.. [1] https://git.kernel.org/akpm/mm/h/mm-unstable
-.. [2] https://git.kernel.org/sj/h/damon/next
-.. [3] https://git.kernel.org/akpm/mm/h/mm-stable
-.. [4] https://github.com/damonitor/damon-tests/blob/master/corr/run.sh#L49
-.. [5] https://github.com/damonitor/damon-tests/blob/master/corr/tests/kunit.sh
-.. [6] https://github.com/damonitor/damon-tests/tree/master/corr
-.. [7] https://github.com/damonitor/damon-tests/tree/master/perf
-.. [8] https://github.com/damonitor/hackermail
-.. [9] https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
+Schedules and available reservation time slots are available at the Google `doc
+<https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing>`.
+DAMON maintainer will also provide periodic reminder to the mailing list
+(damon@lists.linux.dev).
-- 
2.39.2



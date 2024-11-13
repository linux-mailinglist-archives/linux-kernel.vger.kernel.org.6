Return-Path: <linux-kernel+bounces-407235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB039C6A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C61F24492
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C924718A6D7;
	Wed, 13 Nov 2024 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gV+x6rQY"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CA11CBA;
	Wed, 13 Nov 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486913; cv=none; b=NgyFnTofXJ+03rBYxnfSCEP/0m50g2amQMXKTTgLG+mVu4GUDmIZoKkNzqu07n0tKRUXM6wVBJMnbadlcbhiFt+nJ5WEYg3J3tS60Mg0Umluz77vQFAidnAH+gIZbXl8y9L+WpeF81V6ltlaATxkNEfc1CNsyi7ZmuzY1TEtWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486913; c=relaxed/simple;
	bh=v3lJauUTkiWqBZm8jQROhHsIBpNGg1qum0mk+cCvVq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYQTsu+yt3dXVGonIwgtSJUMkaZcsVEMplfqIDflTTqwa2MoMyAIVDnR4uqp7bUtCbiYzOxhvxgk4LD5CCbIU6UcSUBHz7JpxbEhobuY5SYLnGceUldxZkJWaW1LTDpyUMmGSzppIDo9JBTjbLQDFjJtqJQab9SkBrIFWSugn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gV+x6rQY; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LGIJ3280W5sQQis0HSCFC1uEvXTxmlSRbX5MVkzinG0=; t=1731486910; x=1731918910;
	 b=gV+x6rQYeqm9WBMSJDtcVEzHmDw2ODgRjgNFDLqsXPmnd+wScUFCleHp9JXClQu3HPrrNNw1VR
	N9orXiRlBm0FkSHORwyeeh8lpI9zyfLOlwI3aeMPdZS4QIPYCl6P5hVb0FeM8u5IBJa1793XhnLQO
	5YDMnaNxVceZwbRE7qj9vpnhyJo+riMfy/xbPs4Ciko1uRPf1wQfAJnNbUzt962Udi15p67fviqNI
	itWjYYb3dryYdtYupT5+ku5k3859IQfTLC5z6GLSyH2GL8y1ioU/fgNdf8PPQCQFGVaGPlGUez/nE
	v+9ENnD5BHnU0/miS7Zmm8OoP9IgzhGkN3Rjw==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1tB8q7-0003Zl-UA; Wed, 13 Nov 2024 09:35:04 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] docs: reminder to not expose potentially private email addresses
Date: Wed, 13 Nov 2024 09:35:03 +0100
Message-ID: <f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1731486910;b159684b;
X-HE-SMSGID: 1tB8q7-0003Zl-UA

Remind developers to not expose private email addresses, as some people
become upset if their addresses end up in the lore archives or the Linux
git tree.

While at it, explicitly mention the dangers of our bugzilla instance
here, as it makes it easy to forget that email addresses visible there
are only shown to logged-in users.

These are not a theoretical issues, as one maintainer mentioned that
his employer received a EU GDPR (general data protection regulation)
complaint after exposuring a email address used in bugzilla through a
tag in a patch description.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
Note: this triggers a few checkpatch.pl complaints that are irrelevant
when when ti comes to changes like this.

v1:
- initial version
---
 Documentation/process/5.Posting.rst          | 17 +++++++++---
 Documentation/process/submitting-patches.rst | 27 +++++++++++++++++---
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index b3eff03ea2491c..1f6942948db349 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -264,10 +264,19 @@ The tags in common use are:
  - Cc: the named person received a copy of the patch and had the
    opportunity to comment on it.
 
-Be careful in the addition of tags to your patches, as only Cc: is appropriate
-for addition without the explicit permission of the person named; using
-Reported-by: is fine most of the time as well, but ask for permission if
-the bug was reported in private.
+Note, remember to respect other people's privacy when adding these tags:
+
+ - Only specify email addresses, if owners explicitly permitted their use or
+   are fine with exposing them to the public based on previous actions found in
+   the lore archives. In practice you therefore often will be unable to hastily
+   specify addresses for users of bug trackers, as those usually do expose the
+   email addresses at all or only to logged in users. The latter is the case
+   for bugzilla.kernel.org, whose privacy policy explicitly states that 'your
+   email address will never be displayed to logged out users'.
+
+ - Only Cc: is appropriate for addition without the explicit permission of the
+   person named; using Reported-by: is fine most of the time as well given the
+   above constraints, but ask for permission for bugs reported in private.
 
 
 Sending the patch
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 1518bd57adab50..3373ba3025d6d8 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -484,7 +484,9 @@ provided such comments, you may optionally add a ``Cc:`` tag to the patch.
 This is the only tag which might be added without an explicit action by the
 person it names - but it should indicate that this person was copied on the
 patch.  This tag documents that potentially interested parties
-have been included in the discussion.
+have been included in the discussion. Note, ensure owners of email addresses
+are fine with exposing their addresses in tags like this; see 'Privacy aspects
+when using tags...' below for details.
 
 Co-developed-by: states that the patch was co-created by multiple developers;
 it is used to give attribution to co-authors (in addition to the author
@@ -530,9 +532,10 @@ hopefully inspires them to help us again in the future. The tag is intended for
 bugs; please do not use it to credit feature requests. The tag should be
 followed by a Closes: tag pointing to the report, unless the report is not
 available on the web. The Link: tag can be used instead of Closes: if the patch
-fixes a part of the issue(s) being reported. Please note that if the bug was
-reported in private, then ask for permission first before using the Reported-by
-tag.
+fixes a part of the issue(s) being reported. Note, ensure owners of email
+addresses are fine with exposing their addresses in tags like this; see
+'Privacy aspects when using tags...' below for details. And if the bug was
+reported in private, ask for permission first before using the Reported-by-tag.
 
 A Tested-by: tag indicates that the patch has been successfully tested (in
 some environment) by the person named.  This tag informs maintainers that
@@ -600,6 +603,22 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
 patch candidates. For more information, please read
 Documentation/process/stable-kernel-rules.rst.
 
+Privacy aspects when using tags like Cc:, Reported-by:, Tested-by:, ...
+-----------------------------------------------------------------------
+
+Only specify email addresses, if owners explicitly permitted their use or
+are fine with exposing them to the public based on previous actions found in
+the lore archives. In practice you therefore often will be unable to blindly
+specify addresses for users of bug trackers, as those usually do expose the
+email addresses at all or only to logged in users. The latter is the case
+for bugzilla.kernel.org, whose privacy policy explicitly states that 'your
+email address will never be displayed to logged out users'.
+
+Furthermore note that only Cc: is appropriate for addition without the
+explicit permission of the person named; using Reported-by: is fine most of
+the time as well given the above constraints, but ask for permission for bugs
+reported in private.
+
 .. _the_canonical_patch_format:
 
 The canonical patch format

base-commit: 623e5747c680d3854b6b9882d9907096bc63580d
-- 
2.45.0



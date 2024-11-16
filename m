Return-Path: <linux-kernel+bounces-411660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89689CFD7E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B0F284CE6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339FA16D9DF;
	Sat, 16 Nov 2024 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="w9TIAMhe"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77071922F5;
	Sat, 16 Nov 2024 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731749653; cv=none; b=B9AA8MkzjkUbScPzFJfTQcnzHVREKApiCFnkzjHKLzAaPnFFHZuJjyDBX7LaSwuA3v5kOyAaoLyZchSk+tV6c332s6sMFX7o2A1CQhHOOzCLJzJ8HPB5isNKBoUDJ1ebFTcHpT9Zis21QvrnjZJ/8v7LbZ8UzibaGKfIhnwhKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731749653; c=relaxed/simple;
	bh=HWj87ekU+vA5avlrvqvWl7ph/CfrLfd0C+PHEammXno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taUb71jK3unPHlg9cpqzP6eJhB1HRxCCQbs5Z8dnwT55MLEFId2OTDtXh9usxCOUtq7iE03rdaHxKKwQ+gPT8KaZUe/KwcEr5rmgiNrOP+frh2p51TlpURixmxyH8aWz1t1aQL//bXwvHU4C7hEqVucbaPwpRVr3s5uV6h13o7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=w9TIAMhe; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=tfjhu8YZufcD+tfMa1mPGdPBQ0NG0YmgUqPmhdtDcLI=; t=1731749651;
	x=1732181651; b=w9TIAMheEhmc+auvV2GCgN2OhVjiwEcb7K47enwFv5l4zOmuGQ90X6sEMZJrl
	SkWhc1vXBLj+W/oKap1xegDY0JWBI2M3sKRqQf4ZHubLk9MA/WdrV80dpI0OUg0CvhfFZMKc8JB+O
	w5iv3Wfno1GPPQP/QCfRiXcY6kBFv1KsiHMcycsQcObM4wllsrLlgnPG5cKSLhAOr8h5alV0i7Fb4
	aJTaSS2pWsuYCCjFZ1Muugxxe61xw9vnK3Cwn/rk08sisldFocbrKhuPu6En7yve320EEMcq4fGCt
	S4PzbIz5gKjRpF6cX6KQyHRHlum+u7OeKPkHSqgvpkaoS7VgUw==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1tCFBp-0000BI-1m; Sat, 16 Nov 2024 10:34:01 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 2/2] docs: clarify rules wrt tagging other people
Date: Sat, 16 Nov 2024 10:33:59 +0100
Message-ID: <b7dce8b22a391c2f8f0d5a47bf23bc852eca4e71.1731749544.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1731749651;fe049c94;
X-HE-SMSGID: 1tCFBp-0000BI-1m

Point out that explicit permission is usually needed to tag other people
in changes, but mention that implicit permission can be sufficient in
certain cases. This fixes slight inconsistencies between Reported-by:
and Suggested-by: and makes the usage more intuitive.

While at it, explicitly mention the dangers of our bugzilla instance, as
it makes it easy to forget that email addresses visible there are only
shown to logged-in users.

The latter is not a theoretical issue, as one maintainer mentioned that
his employer received a EU GDPR (general data protection regulation)
complaint after exposing a email address used in bugzilla through a tag
in a patch description.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
Note: this triggers a few checkpatch.pl complaints that are irrelevant
when when to comes to changes like this.

v2:
- Retry differently. This slightly hardens the rule for Reported-by:
  while slightly lessening it for Suggested-by:. Those in the end are
  quite similar, so it does not make much sense to apply different ones.
  I considered using an approach along the lines of "if you reported it
  in pubic by mail, implicit permission to use in a tag is granted"; but
  I abstained from it, as I assume there are good reasons for the
  existing approach regarding Suggested-by:.
- CC all the people that provided feedback on the text changes in v1

v1: https://lore.kernel.org/all/f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info/
- initial version
---
 Documentation/process/5.Posting.rst          | 17 ++++++--
 Documentation/process/submitting-patches.rst | 44 ++++++++++++++------
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index dbb763a8de901d..b45c4f6d65ca95 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -268,10 +268,19 @@ The tags in common use are:
  - Cc: the named person received a copy of the patch and had the
    opportunity to comment on it.
 
-Be careful in the addition of tags to your patches, as only Cc: is appropriate
-for addition without the explicit permission of the person named; using
-Reported-by: is fine most of the time as well, but ask for permission if
-the bug was reported in private.
+Be careful in the addition of tags to your patches, as nearly all of them need
+explicit permission of the person named.
+
+The only exceptions are Cc:, Reported-by:, and Suggested-by:, as for them
+implicit permission is sufficient under the following circumstances: when the
+person named according to the lore archives or the commit history regularly
+contributes to the Linux kernel using that name and email address -- and in
+case of Reported-by: and Suggested-by: did the reporting or suggestion in
+public. For all other situations explicit permission is required to among
+others prevent exposing email addresses considered private. Especially ask for
+permission when it comes to bug trackers, as most only show addresses to logged
+in users; that includes bugzilla.kernel.org, whose privacy policy explicitly
+states that 'your email address will never be displayed to logged out users'.
 
 
 Sending the patch
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 1518bd57adab50..92b2dc6ae7304a 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -481,10 +481,10 @@ list archives.
 
 If a person has had the opportunity to comment on a patch, but has not
 provided such comments, you may optionally add a ``Cc:`` tag to the patch.
-This is the only tag which might be added without an explicit action by the
-person it names - but it should indicate that this person was copied on the
-patch.  This tag documents that potentially interested parties
-have been included in the discussion.
+This tag documents that potentially interested parties have been included in
+the discussion. Note, this is one of only three tags you might be able to use
+without explicit permission of the person named (see 'Tagging people requires
+permission below for details).
 
 Co-developed-by: states that the patch was co-created by multiple developers;
 it is used to give attribution to co-authors (in addition to the author
@@ -530,9 +530,9 @@ hopefully inspires them to help us again in the future. The tag is intended for
 bugs; please do not use it to credit feature requests. The tag should be
 followed by a Closes: tag pointing to the report, unless the report is not
 available on the web. The Link: tag can be used instead of Closes: if the patch
-fixes a part of the issue(s) being reported. Please note that if the bug was
-reported in private, then ask for permission first before using the Reported-by
-tag.
+fixes a part of the issue(s) being reported. Note, the Reported-by tag is one
+of only three tags you might be able to use without explicit permission of the
+person named (see 'Tagging people requires permission' below for details).
 
 A Tested-by: tag indicates that the patch has been successfully tested (in
 some environment) by the person named.  This tag informs maintainers that
@@ -582,11 +582,11 @@ Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
 in the patch changelog (after the '---' separator).
 
 A Suggested-by: tag indicates that the patch idea is suggested by the person
-named and ensures credit to the person for the idea. Please note that this
-tag should not be added without the reporter's permission, especially if the
-idea was not posted in a public forum. That said, if we diligently credit our
-idea reporters, they will, hopefully, be inspired to help us again in the
-future.
+named and ensures credit to the person for the idea: if we diligently credit
+our idea reporters, they will, hopefully, be inspired to help us again in the
+future. Note, this is one of only three tags you might be able to use without
+explicit permission of the person named (see 'Tagging people requires
+permission' below for details).
 
 A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
 is used to make it easy to determine where a bug originated, which can help
@@ -600,6 +600,26 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
 patch candidates. For more information, please read
 Documentation/process/stable-kernel-rules.rst.
 
+.. _tagging_people:
+
+Tagging people requires permission
+----------------------------------
+
+Be careful in the addition of tags to your patches, as nearly all of them need
+explicit permission of the person named.
+
+The only exceptions are Cc:, Reported-by:, and Suggested-by:, as for them
+implicit permission is sufficient under the following circumstances: when the
+person named according to the lore archives or the commit history regularly
+contributes to the Linux kernel using that name and email address -- and in
+case of Reported-by: and Suggested-by: did the reporting or suggestion in
+public. For all other situations explicit permission is required to among
+others prevent exposing email addresses considered private. Especially ask for
+permission when it comes to bug trackers, as most only show addresses to logged
+in users; that includes bugzilla.kernel.org, whose privacy policy explicitly
+states that 'your email address will never be displayed to logged out users'.
+
+
 .. _the_canonical_patch_format:
 
 The canonical patch format
-- 
2.45.0



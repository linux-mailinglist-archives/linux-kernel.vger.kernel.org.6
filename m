Return-Path: <linux-kernel+bounces-404351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A91AF9C42BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC53AB25484
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619D1A0BF8;
	Mon, 11 Nov 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HP5Y7Res"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20F39ACC;
	Mon, 11 Nov 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343046; cv=none; b=A5t081pyFHw5RNpM4d7+Ekd9bALyovGWrrIkMTUpwyf8v1SqZs8uJZkSkXWMB+ME/1BJp0ESV/vwk5Q8CB/gaglIj9Mbdc2luopOXrc64wewoAmVS+fmPKHdwJfF1CcyZvL8ga2d+V0UROw456etst51T65UIkJFSKMIajPzogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343046; c=relaxed/simple;
	bh=oHwjeeaU61MO6gUa1vCGM9RwoOm9d2EsLQhDBWf6xKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hDBjMJSaYubSp/EZvEkbfrHlAcQiR/73HYCgYbDONkuWGCxKqpH3rALzuBObuAgQpf6bIA8sHsqh6gj/fMDM1jXyUYI9WucC7lACeVRueylLC+2iUyQXj6mtVkbH+Oe7KreclcO7tpkYtyGUJoODcorrA3TWx2peKpg6r0kj8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HP5Y7Res; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6FCC4CECF;
	Mon, 11 Nov 2024 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731343045;
	bh=oHwjeeaU61MO6gUa1vCGM9RwoOm9d2EsLQhDBWf6xKc=;
	h=From:To:Cc:Subject:Date:From;
	b=HP5Y7ResNnnEPiNt/6jP56EmwDMIW/uCtoiPK0otJxUYD221O2A3UuON+rTc9dLsR
	 RzyeUHfDCjGt4ROBictnxcOir1bpiCQjfjN56NTcABrUZY6qe5e94/fNNgYcxIBfxA
	 nBCwC1dgjxWMfo/YihoIU/f2xEpAIj0iBstZL/xs=
From: Shuah Khan <skhan@linuxfoundation.org>
To: gregkh@linuxfoundation.org,
	corbet@lwn.net
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	workflows@vger.kernel.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2] Documentation/CoC: spell out enforcement for unacceptable behaviors
Date: Mon, 11 Nov 2024 09:37:23 -0700
Message-Id: <20241111163723.9002-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Code of Conduct committee's goal first and foremost is to bring about
change to ensure our community continues to foster respectful discussions.

In the interest of transparency, the CoC enforcement policy is formalized
for unacceptable behaviors.

Update the Code of Conduct Interpretation document with the enforcement
information.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jonathan Corbet <corbet@lwn.net>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---

Changes since v1:
- Updates Acks with Ted's ack.
- Fixes subsection formatting as per Randy's suggestion.
- Fixes a spelling error.

 .../code-of-conduct-interpretation.rst        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
index 66b07f14714c..ebddf218341d 100644
--- a/Documentation/process/code-of-conduct-interpretation.rst
+++ b/Documentation/process/code-of-conduct-interpretation.rst
@@ -156,3 +156,55 @@ overridden decisions including complete and identifiable voting details.
 Because how we interpret and enforce the Code of Conduct will evolve over
 time, this document will be updated when necessary to reflect any
 changes.
+
+Enforcement for Unacceptable Behavior Code of Conduct Violations
+----------------------------------------------------------------
+
+The Code of Conduct committee works to ensure that our community continues
+to be inclusive and fosters diverse discussions and viewpoints, and works
+to improve those characteristics over time. The Code of Conduct committee
+takes measures to restore productive and respectful collaboration when an
+unacceptable behavior has negatively impacted that relationship.
+
+Seek public apology for the violation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The Code of Conduct Committee publicly calls out the behavior in the
+setting in which the violation has taken place, seeking public apology
+for the violation.
+
+A public apology for the violation is the first step towards rebuilding
+the trust. Trust is essential for the continued success and health of the
+community which operates on trust and respect.
+
+Remedial measures if there is no public apology for the violation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The Code of Conduct Committee determines the next course of action
+to restore the healthy collaboration by recommending remedial measure(s)
+to the TAB for approval.
+
+- Ban violator from participating in the kernel development process for
+  a period of up to a full kernel development cycle. The Code of Conduct
+  Committee could require public apology as a condition for lifting the
+  ban.
+
+The scope of the ban for a period of time could include:
+
+    a. denying patch contributions and pull requests
+    b. pausing collaboration with the violator by ignoring their
+       contributions and/or blocking their email account(s)
+    c. blocking their access to kernel.org accounts and mailing lists
+
+Once the TAB approves one or more of the measures outlined in the scope of
+the ban by a two-thirds vote, the Code of Conduct Committee will enforce
+the TAB approved measure(s) in collaboration with the community, maintainers,
+sub-maintainers, and kernel.org administrators.
+
+The effectiveness of the remedial measure(s) approved by the TAB depends
+on the trust and cooperation from the community, maintainers, sub-maintainers,
+and kernel.org administrators in enforcing them.
+
+The Code of Conduct Committee sincerely hopes that unacceptable behaviors
+that require seeking public apologies continue to be exceedingly rare
+occurrences in the future.
-- 
2.40.1



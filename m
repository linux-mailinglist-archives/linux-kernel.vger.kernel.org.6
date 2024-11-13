Return-Path: <linux-kernel+bounces-408428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C99C7EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E52E281A41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D918CBF0;
	Wed, 13 Nov 2024 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tbKf4q9d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434718C01F;
	Wed, 13 Nov 2024 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731540360; cv=none; b=S9l/DlKScMrqeFft4KEbKjvo9ICJ8kVQqkbuPfrN1G3tallQq8TxZ61lv6ni8FBERBCaUgqq/g2CyTAHUSAuggTL/qzEmEz42a4hQsG6T+4xYOahu7x04JrTrx1U7OCaFwWLFSjhkFoyU5XitqGjGpjLozBywWBd/ZbRyEboSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731540360; c=relaxed/simple;
	bh=m+OGWa1oLTF8Q5wntzM+Lm392qhyyLzPvMTj+FgRcnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4e6ux8pctOtYK0Bw/3k97aexAGq48qetJZsMBEmccsEQK8GQYit7g24lXAf0uHHOWyh/yBHY+TzS9ehWlLOnzS+sEFY6/GYF5uwqQInC1bVECKjgccimVVlE0CyU3brTVu4MI0gHOnqTYJumK7RoxmHiywfZWUUC3MqxmET770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tbKf4q9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3562EC4CEC3;
	Wed, 13 Nov 2024 23:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731540359;
	bh=m+OGWa1oLTF8Q5wntzM+Lm392qhyyLzPvMTj+FgRcnE=;
	h=From:To:Cc:Subject:Date:From;
	b=tbKf4q9dI5UQ4ZCFAs8Bkx9Y4K0rhu6yxKTZXGZVJ8E7trYZ2SzX503MOS1x2VQLs
	 ZymFmLS9hui1glz8YhEDFTiY81kfoog21VW4NOFOND8A3KOOw14T3sXAVG9cboG/1O
	 7/RJcWAl3kme8XSGtOWSwJ7vxsXI3svMsmjQ9T0k=
From: Shuah Khan <skhan@linuxfoundation.org>
To: gregkh@linuxfoundation.org,
	corbet@lwn.net
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	daniel@ffwll.ch,
	laurent.pinchart@ideasonboard.com,
	broonie@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v3] Documentation/CoC: spell out enforcement for unacceptable behaviors
Date: Wed, 13 Nov 2024 16:25:57 -0700
Message-Id: <20241113232557.29854-1-skhan@linuxfoundation.org>
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

Changes since v2:
- Adds details on the process leading up to the proposed
  measures to seek public apology and bans for serious
  unacceptable behaviors.

- Hope this addresses your comments, Daniel Vetter,
  Laurent Pinchart, and Mark Brown.

- Would like to get this into 6.12 if at all possible.

Changes since v1:
- Updates Acks with Ted's ack.
- Fixes subsection formatting as per Randy's suggestion.
- Fixes a spelling error.

 .../code-of-conduct-interpretation.rst        | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
index 66b07f14714c..3727abdf4916 100644
--- a/Documentation/process/code-of-conduct-interpretation.rst
+++ b/Documentation/process/code-of-conduct-interpretation.rst
@@ -156,3 +156,89 @@ overridden decisions including complete and identifiable voting details.
 Because how we interpret and enforce the Code of Conduct will evolve over
 time, this document will be updated when necessary to reflect any
 changes.
+
+Enforcement for Unacceptable Behavior Code of Conduct Violations
+----------------------------------------------------------------
+
+The Code of Conduct committee works to ensure that our community continues
+to be inclusive and fosters diverse discussions and viewpoints, and works
+to improve those characteristics over time. A majority of the reports the
+Code of Conduct Committee receives stem from incorrect understanding regarding
+the development process and maintainers' roles, responsibilities, and their
+right to make decisions on code acceptance. These are resolved through
+clarification of the development process and the scope of the Code of Conduct.
+
+Unacceptable behaviors could interrupt respectful collaboration for a short
+period of time and negatively impact the health of the community longer term.
+Unacceptable behaviors often get resolved when individuals acknowledge their
+behavior and make amends for it in the setting the violation has taken place.
+
+The Code of Conduct Committee receives reports about unacceptable behaviors
+when they don't get resolved through community discussions. The Code of
+Conduct committee takes measures to restore productive and respectful
+collaboration when an unacceptable behavior has negatively impacted that
+relationship.
+
+The Code of Conduct Committee has the obligation to keep the reports and
+reporters' information private. Reports could come from injured parties
+and community members who are observers of unacceptable behaviors. The
+Code of Conduct Committee has the responsibility to investigate and resolve
+these reports, working with all involved parties.
+
+The Code of Conduct Committee works with the individual to bring about
+change in their understanding of the importance to repair the damage caused
+by their behavior to the injured party and the long term negative impact
+on the community.
+
+The goal is to reach a resolution which is agreeable to all parties. If
+working with the individual fails to bring about the desired outcome, the
+Code of Conduct Committee will evaluate other measures such as seeking
+public apology to repair the damage.
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
+The Code of Conduct Committee determines the next course of action to restore
+the healthy collaboration by recommending remedial measure(s) to the TAB for
+approval.
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
+The Code of Conduct Committee is mindful of the negative impact of seeking
+public apology and instituting ban could have on individuals. It is also
+mindful of the longer term harm to the community that could result from
+not taking action when such serious public violations occur.
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



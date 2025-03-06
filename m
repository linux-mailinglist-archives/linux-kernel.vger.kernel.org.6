Return-Path: <linux-kernel+bounces-549908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D25A55873
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596403B18D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9119A214A61;
	Thu,  6 Mar 2025 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ookv/SQJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4B2063EB;
	Thu,  6 Mar 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295554; cv=none; b=BLXqMCls0z2Zs7zE0zKPlnsyazSkMm9RzzX0NAQWeyL7JSValrrAEWSK4pdkOzrQN5eoqFBOidJR/3vsdx6Uo2YJ39O8vaoXVyyYB1BEDIKR9Zuhrq65iBcNDLbYHRpFPRkpVIACFssGy1AZ3c9jAl1GWSnvDYLSimVCuMzPn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295554; c=relaxed/simple;
	bh=Ld2j3ntSdCRsdZp0RQs+DWEbBhmg4SEAQbMBFbIaERc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXHb37qAs5BJm9fj8tpot6LDr2ZSf0H1r4x5IKzDofoLGfGHf8mEXqGm9VoRde3cGnNI9gsT3txkNFjM4XGDzzmm2V0vVZ4mhvzusQcrL1auuCpNP+HE/2ufG8D5AfPnGDPVVcj9abjuOcYDrKgfDcMKVZZDNuipI5Ln1Ms1lQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ookv/SQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061BCC4CEE0;
	Thu,  6 Mar 2025 21:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741295553;
	bh=Ld2j3ntSdCRsdZp0RQs+DWEbBhmg4SEAQbMBFbIaERc=;
	h=From:To:Cc:Subject:Date:From;
	b=ookv/SQJ02EbaBXv20RBZv8L1E4F/pdP7Hqp8ipcc1/J7OSQlqT8CokQoqNPeqYKH
	 MN99nYUt5Dr4Qv5UfzwDIuYtoVH8cLtDB2X6VLfTf4nnNCdmmFWJ+XCa9qhJ59swHo
	 ozht/YDmlx5jd9Qwe/fnVi71/batQEbrGH4ClKYYHi/E3wRY5TrcN1JRQOw+qhgBK5
	 2tE9rpGDH/miGZDllERkNF2kSdBxe2pzSRrsdVWcxsUsCIISY7zYKdE+o/U3N6earY
	 W46JgaS3SMiuljlGQdZcrG75lcsO4lWmLIVagnIwPpKtaVzwsl3d+1W5xjeFkVfcey
	 ijABptK/3Dl8g==
From: Shuah Khan <shuah@kernel.org>
To: gregkh@linuxfoundation.org,
	corbet@lwn.net
Cc: Shuah Khan <shuah@kernel.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	conduct@kernel.org,
	tab@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] Documentation/CoC: Spell out the TAB role in enforcement decisions
Date: Thu,  6 Mar 2025 14:12:31 -0700
Message-ID: <20250306211231.13154-1-shuah@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates the document to clearly describe the scope and role the TAB plays
in making decisions on unresolved violations. If and when the CoC has to
make a call on instituting a ban, it doesn't act without the TAB's approval
and only when the TAB approves it with 2/3 vote in favor of the measure.

These changes ensure that the TAB role and its oversight on CoC measures
is consistently described throughout the document.

Fixes: c818d5c64c9a8cc1 ("Documentation/CoC: spell out enforcement for unacceptable behaviors")

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Shuah Khan <shuah@kernel.org>
---
v1 - v2:
- Reword change log to better describe the changes and updates.
- Add Fixes tag

 .../process/code-of-conduct-interpretation.rst  | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
index 1d1150954be3..4cdef8360698 100644
--- a/Documentation/process/code-of-conduct-interpretation.rst
+++ b/Documentation/process/code-of-conduct-interpretation.rst
@@ -145,13 +145,16 @@ kernel community.
 
 Any decisions regarding enforcement recommendations will be brought to
 the TAB for implementation of enforcement with the relevant maintainers
-if needed.  A decision by the Code of Conduct Committee can be overturned
-by the TAB by a two-thirds vote.
+if needed.  Once the TAB approves one or more of the measures outlined
+in the scope of the ban by two-thirds of the members voting for the
+measures, the Code of Conduct Committee will enforce the TAB approved
+measures.  Any Code of Conduct Committee members serving on the TAB will
+not vote on the measures.
 
 At quarterly intervals, the Code of Conduct Committee and TAB will
 provide a report summarizing the anonymised reports that the Code of
 Conduct committee has received and their status, as well details of any
-overridden decisions including complete and identifiable voting details.
+TAB approved decisions including complete and identifiable voting details.
 
 Because how we interpret and enforce the Code of Conduct will evolve over
 time, this document will be updated when necessary to reflect any
@@ -227,9 +230,11 @@ The scope of the ban for a period of time could include:
        such as mailing lists and social media sites
 
 Once the TAB approves one or more of the measures outlined in the scope of
-the ban by a two-thirds vote, the Code of Conduct Committee will enforce
-the TAB approved measure(s) in collaboration with the community, maintainers,
-sub-maintainers, and kernel.org administrators.
+the ban by two-thirds of the members voting for the measures, the Code of
+Conduct Committee will enforce the TAB approved measure(s) in collaboration
+with the community, maintainers, sub-maintainers, and kernel.org
+administrators.  Any Code of Conduct Committee members serving on the TAB
+will not vote on the measures.
 
 The Code of Conduct Committee is mindful of the negative impact of seeking
 public apology and instituting ban could have on individuals. It is also
-- 
2.45.2



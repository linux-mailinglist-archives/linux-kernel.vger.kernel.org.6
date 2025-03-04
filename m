Return-Path: <linux-kernel+bounces-545492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5561FA4EDC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332A77A3981
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E6025F794;
	Tue,  4 Mar 2025 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKC3RaRV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8220A5C4;
	Tue,  4 Mar 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117697; cv=none; b=IDmmhRLcDR20UtNVlIAgMePaBat8k9qKHg0sq4tQJcCafa5lpOtKS7aYjkSAzYPKZDBwNpmX0awmE56MYQkppax9RFt380Fb5uacgpjkrHZnjq+YtPRGAPx/kj5vPLsXsPzDmTlLW5LGx5WDYAbt4uTj9rXyvXQcPthjlAmO+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117697; c=relaxed/simple;
	bh=z+f9cKz4OFkvfSJppyRq+XfvYVGbIdyW/SG2d9Va5Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lC981+MqoiNG4DNwf8Z3/c+5bk9U3/fFcoyFLp9kMFrSYiKzlrlSf6Xi4ZJ4SL1Peflc7wilPFCdxokc7mtdW+iToDGKh3vGPEA6mJUfm6nd9fRxkaLP+DZ9LOgFd6yJa59X9nF+AnQ2PyLcUoKrHHBFm4dlBcSYHxkaJz8jizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKC3RaRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C689BC4CEE5;
	Tue,  4 Mar 2025 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741117695;
	bh=z+f9cKz4OFkvfSJppyRq+XfvYVGbIdyW/SG2d9Va5Dg=;
	h=From:To:Cc:Subject:Date:From;
	b=qKC3RaRVoS7wFrpUO4SMwaNRgMiEeDvmkc+YGFm/nu15/YDRjUrl3rkRTBeXX7MvV
	 AvFwe4iVpEmI3131nAXxLmkDQPLLJ5KP4FyfyfTelB5kIbl+ypjNmD11b6fTnNDjG6
	 I97vbLQJSjMnEep9smlDUxNLwK4xCdZM1ncnY3juwX11um0GR8rHwX171qUtDweE+d
	 ZGLoX1yAgZHa6vd4MQmbjBwbOBuXe7dM9RTLx73FC17dsm0WBk+CYF6WHWkcErqRx2
	 BeAbr/0Dndhqyo3tzh/h4W9WRJlckUVF5UbGtY8HBt5KxtWI5wkattz0T2l/PGP3p8
	 2tuiHN0klCWww==
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
Subject: [PATCH] Documentation/CoC: Spell out the TAB role in enforcement decisions
Date: Tue,  4 Mar 2025 12:48:12 -0700
Message-ID: <20250304194813.11049-1-shuah@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates to clarify and spell out the TAB role in approving and overturning
enforcement measures for Code of Conduct violations.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Shuah Khan <shuah@kernel.org>
---
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



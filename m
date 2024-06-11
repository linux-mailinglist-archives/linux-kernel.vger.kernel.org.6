Return-Path: <linux-kernel+bounces-209376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768490338B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510C9B26E88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79051171E76;
	Tue, 11 Jun 2024 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ozq8jwn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ADD17554;
	Tue, 11 Jun 2024 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718090863; cv=none; b=gjGV8R3jBZuFLGGqUTlI5ICb8iCMzbSyqhgqririlxgnNeNdfiOKWjB2pwWFfsJAAsRpT5ar+/Q/8g4ujmTxJvaQyc0J8hJIbaoHbBfpob9yCnmZXd5ZbDn5wrZx+YWJ+/wu/zf8OBzEiVMecahVL9blLBsQlyro9FNPsTg7Y+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718090863; c=relaxed/simple;
	bh=ybjtdLWrtnoLW7hIFYeyWp46DqlzKqBE48jT2JWGv6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L6/SqVR68oL5jjIiX65NkKdw2pbRKx9Jg1Q/BSMEhWbIeINLy7c8mkHrOQvfiRlizFac5+NBmJQeSQP9s8UnaC2gCgiOEHJIcWUWF5zQSQzpDLDMuLT2AdDeN3bxalhVWVoWaL2yjud3cII7cvDFgWdBI6akLE9wSY2k6sY0qkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ozq8jwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B5CC2BD10;
	Tue, 11 Jun 2024 07:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718090863;
	bh=ybjtdLWrtnoLW7hIFYeyWp46DqlzKqBE48jT2JWGv6k=;
	h=From:To:Cc:Subject:Date:From;
	b=1ozq8jwnSqsNCBZsKHhofDpQnrjrjhau6mjljFLZ3Ao5/tAJ5XMrSLOoGrsG7WTvk
	 T8wUVm9OWUyogUNjQqMEO7+e/F0GmtNGkVmXhanl741U0AQML9rU+3M/Es2y9LjyX5
	 wCxoAAqDVi1pxJIgYPDrV6tDvngaExrMNr4tsmGo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danny Lin <danny@kdrag0n.dev>,
	=?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2] .editorconfig: remove trim_trailing_whitespace option
Date: Tue, 11 Jun 2024 09:27:38 +0200
Message-ID: <2024061137-jawless-dipped-e789@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines: 56
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=ybjtdLWrtnoLW7hIFYeyWp46DqlzKqBE48jT2JWGv6k=; b=owGbwMvMwCRo6H6F97bub03G02pJDGnpf7I42x2TSs93x/vYCybs6RWVu24/S1zywO0Pi6yMj KxivLk7YlkYBJkYZMUUWb5s4zm6v+KQopeh7WmYOaxMIEMYuDgFYCI7TBjmCvE7tW0OnbjwQ4B5 +UKFtoaELo0YhgXLjOW1ne/fWGJ8fGuHh5nz+Su5IbYA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Some editors (like the vim variants), when seeing "trim_whitespace"
decide to do just that for all of the whitespace in the file you are
saving, even if it is not on a line that you have modified.  This plays
havoc with diffs and is NOT something that should be intended.

As the "only trim whitespace on modified files" is not part of the
editorconfig standard yet, just delete these lines from the
.editorconfig file so that we don't end up with diffs that are
automatically rejected by maintainers for containing things they
shouldn't.

Cc: Danny Lin <danny@kdrag0n.dev>
Cc: Íñigo Huguet <ihuguet@redhat.com>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Fixes: 5a602de99797 ("Add .editorconfig file for basic formatting")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: - only remove the lines, don't move the whole file to Documentation
    - add Fixes: tag


 .editorconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.editorconfig b/.editorconfig
index 854773350cc5..29a30ccfc07b 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -5,7 +5,6 @@ root = true
 [{*.{awk,c,dts,dtsi,dtso,h,mk,s,S},Kconfig,Makefile,Makefile.*}]
 charset = utf-8
 end_of_line = lf
-trim_trailing_whitespace = true
 insert_final_newline = true
 indent_style = tab
 indent_size = 8
@@ -13,7 +12,6 @@ indent_size = 8
 [*.{json,py,rs}]
 charset = utf-8
 end_of_line = lf
-trim_trailing_whitespace = true
 insert_final_newline = true
 indent_style = space
 indent_size = 4
@@ -26,7 +24,6 @@ indent_size = 8
 [*.yaml]
 charset = utf-8
 end_of_line = lf
-trim_trailing_whitespace = unset
 insert_final_newline = true
 indent_style = space
 indent_size = 2
-- 
2.45.2



Return-Path: <linux-kernel+bounces-554078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 280BEA592B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6634016A759
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6645D220697;
	Mon, 10 Mar 2025 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Q7MDSz7T"
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ACD21E0BE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605838; cv=none; b=nxZNu1kmhs4N00ZFaEYNsF357wBCxFttV0JhW4ONMxiByEy0nzxx8ikZedBjuJ2rOHC5/DJetmKa/QQc0qQbE2YnE4zpgAgFoU45NanfcnJI/Rpk7VhJnmWbuZxrs9FCOxTFkCfDadkAUUJ0/tWeuk5CXrY9O/7AivpkrwsWyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605838; c=relaxed/simple;
	bh=wKISntxfKZCLCKAKO+8OeRVGz+AW4fz6x3QOe90BYFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmeeDZe3lLiOCoOq/h5xf3UsTr1mqfKRVXJ0Y7Jhm2NxDqL6YSqFaBB58y73BbOyF8XPN/NjdhUFJCaknffiCH/WrcTbemP3GH4mWp4KaNEqiH1GbmyQAFy+W43hc3rqOixU6cYVtzW0BWzcRdUbsiMAMM7zkmKAcdRq2OTicn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=Q7MDSz7T; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1741605766; bh=wKISntxfKZCLCKAKO+8OeRVGz+AW4fz6x3QOe90BYFE=;
	h=From:To:Cc:Subject:Date:From;
	b=Q7MDSz7TgWWNz6bfk9tPmhEFSUGronD3cPMw/YaloiKz6lgDVKVweKun5aL2vfBH4
	 TS/1yIhJ4YHVDoL+cPrShs9zfBNGADE7+lWpBG9myfjz6TwNQ15pnq4bLMDMEK42Zt
	 IdHmYvXDLzvb6cM3tdhgv9N/sOVSxebf9m5qylGY=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.52.1)
	(envelope-from <phahn-oss@avm.de>)
	id 67cecb86-1471-7f0000032729-7f000001d8f2-1
	for <multiple-recipients>; Mon, 10 Mar 2025 12:22:46 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 10 Mar 2025 12:22:46 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
To: linux-kernel@vger.kernel.org
Cc: Philipp Hahn <phahn-oss@avm.de>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Philipp Hahn <p.hahn@avm.de>
Subject: [PATCH] checkpatch: Describe --min-conf-desc-length
Date: Mon, 10 Mar 2025 12:22:27 +0100
Message-Id: <c71c170c90eba26265951e248adfedd3245fe575.1741605695.git.p.hahn@avm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: AVM GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1741605766-6FDC59D3-D1867036/0/0
X-purgate-type: clean
X-purgate-size: 2342
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Neither the warning nor the help message gives any hint on the unit for
length: Could be meters, inches, bytes, characters or ... lines.

Extend the output of `--help` to name the unit "lines" and the default:
-  --min-conf-desc-length=n   set the min description length, if shorter, warn
+  --min-conf-desc-length=n   set the minimum description length for config symbols
+                             in lines, if shorter, warn (default 4)

Include the minimum number of lines as other error messages already do:
- WARNING: please write a help paragraph that fully describes the config symbol
+ WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Philipp Hahn <p.hahn@avm.de>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..784912f570e9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -113,7 +113,8 @@ Options:
   --max-line-length=n        set the maximum line length, (default $max_line_length)
                              if exceeded, warn on patches
                              requires --strict for use with --file
-  --min-conf-desc-length=n   set the min description length, if shorter, warn
+  --min-conf-desc-length=n   set the minimum description length for config symbols
+                             in lines, if shorter, warn (default $min_conf_desc_length)
   --tab-size=n               set the number of spaces for tab (default $tabsize)
   --root=PATH                PATH to the kernel tree root
   --no-summary               suppress the per-file summary
@@ -3645,7 +3646,7 @@ sub process {
 			    $help_length < $min_conf_desc_length) {
 				my $stat_real = get_stat_real($linenr, $ln - 1);
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a help paragraph that fully describes the config symbol\n" . "$here\n$stat_real\n");
+				     "please write a help paragraph that fully describes the config symbol with at least $min_conf_desc_length lines\n" . "$here\n$stat_real\n");
 			}
 		}
 
-- 
2.34.1



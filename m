Return-Path: <linux-kernel+bounces-344432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342DD98A980
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6D7286B23
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0619309C;
	Mon, 30 Sep 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrRLEbkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DC192D68
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712663; cv=none; b=dkqtp0l+CELnfBZDwG7epwT0o6n9GBRvawTQgGfg5OaZL93rmPp8mq91CGKzkqw52uRCBbFk7q7kwA/cr8wIz7xKidjS4AOUTiwPuGc+H3QEgi1ww8X3QmI7Y7Yete7szs8B27aJX1ruIvb6kCOsft+iX8ppx+6vwhnaINoWbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712663; c=relaxed/simple;
	bh=aVwOkFKjEtowEpq+vv1o87FHrbCXOAj8TCEBM7b8Z5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GS7P+IbAvRNmvDb4zb8UcfV/ss5xQqti6qLi5a/r+vXtYDrYHdWdpHlT/6ZMVzG+TJw5Hnqp5XPHJDdk7CucI618o8i+WaTx64BYWFqk7/BYjFsj8GkyT/lhu9ycgrZpSQJHW0R9eqry5/fB8epzzKXbNkNmWVQovRL+2uBiYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrRLEbkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BFFC4CEC7;
	Mon, 30 Sep 2024 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727712662;
	bh=aVwOkFKjEtowEpq+vv1o87FHrbCXOAj8TCEBM7b8Z5I=;
	h=Date:From:To:Cc:Subject:From;
	b=TrRLEbkNDJnoe3K7r+YwMfvRWVQOKqQHpo/RpMG48CuxZYoBZ3VflpDd5+f/KdrAz
	 ats6qQjUQjMk9XGVTjytOlPC+r3mzYXy7YdoW/8vfEt5TnMinbzh1ipVVPXCHhUZhg
	 hfrB1a3Z+4n+7P+2Yd5712+SJ2q+SnnTU3Uw4Bz//ITvfo2xWGUzc4Q0reOYkFivqj
	 f22sOscfZLEPF6lQ//t7kl+xa+Ah7wH12ldveLwRfn8bgBUM6SeT/d97phMdac1A6o
	 FLAxI8G0oeUskvAWLxWs0pIjC+UKIhYeWXQZiGj4+jeB9OgneDUJms47YbMY+zIZL1
	 iI1wBFseNNRGg==
Date: Mon, 30 Sep 2024 13:11:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Simon Horman <horms@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync the linux/in.h with the
 kernel sources
Message-ID: <ZvrNlLdtXAZ1sIIj@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

Picking the changes from:

  70d0bb45fae87a3b ("net: Correct spelling in headers")

Just a comment fix, addressing this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Please see tools/include/uapi/README for details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index d358add1611cd13d..5d32d53508d99f86 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -141,7 +141,7 @@ struct in_addr {
  */
 #define IP_PMTUDISC_INTERFACE		4
 /* weaker version of IP_PMTUDISC_INTERFACE, which allows packets to get
- * fragmented if they exeed the interface mtu
+ * fragmented if they exceed the interface mtu
  */
 #define IP_PMTUDISC_OMIT		5
 
-- 
2.46.0



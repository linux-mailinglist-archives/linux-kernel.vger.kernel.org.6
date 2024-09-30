Return-Path: <linux-kernel+bounces-344436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031998A991
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466012836A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84DA192B99;
	Mon, 30 Sep 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lmg5vTvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566973BB24
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713024; cv=none; b=e4ZW4UUi29CNxPem1Ix3rettc2lBBGDBi7tXr0PLaZHbQHKrw5LMLMGZTaomIFOi3h6BRPbrXWz94x7e8rc2EEQL8wwO1OxF0xUEC05XZB+dl/BNENofduCFsIznba0DypHdrUKDkMrggAdpZWt4UyntlgIsZck9Xg3frAQIQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713024; c=relaxed/simple;
	bh=yv/NpqWspx2ikPukRsUnuTqKA0MMIfsopgGu6hrNcgI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y/L/PcSCAxH3V+5c/c9sfYxVqgfIhNh/SLoTq0w4PjD7zt3fp+V3j1agHrK7kPlIboIYbNFMEYddMlpa2cIHFBqqDKxCVEoFwgMyCXAw9FRRmAEmCrFWF/wE35w8I0NKqDG8lGNp0QpZVykb5SvtIUXeH9IBHrx9OjeuCOeBoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lmg5vTvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA2EC4CEC7;
	Mon, 30 Sep 2024 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727713023;
	bh=yv/NpqWspx2ikPukRsUnuTqKA0MMIfsopgGu6hrNcgI=;
	h=Date:From:To:Cc:Subject:From;
	b=Lmg5vTvCOBuRpPUIOJs8cQEWTeJqPIr7KdUwJOkKThzC7q88pz78ysWYpUK9ukPPP
	 8dALzd5vcrMLVBRf1o0MHb27h3ZzQpUoZoKXWbIk3I+zcWVvkixTjwBh//63f83tZz
	 7HgRq+fjuVU9i7DmHM/EB/rSw2buoXgpVcI0INMLYS2XGc1obcvw+mCzMyEgFUWzVB
	 TIqDYya10AqkquoLrYB2RDBjID7B1p1DgxvnTyidxpnIFL9PGRjWfvwP3xsFw7P7X2
	 /krvkkOg/hPw+FQznct4FG6OtVqJsdB3fvxC7yImtwaEUzjEd3ynIGVwbcewrXnrbb
	 yiQ28spV2cseQ==
Date: Mon, 30 Sep 2024 13:17:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Mina Almasry <almasrymina@google.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] perf beauty: Update copy of linux/socket.h with the
 kernel sources
Message-ID: <ZvrO_eT9e_41xrNv@x1>
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

To pick the changes in:

  8f0b3cc9a4c102c2 ("tcp: RX path for devmem TCP")

That don't result in any changes in the tables generated from that
header.

But while updating I noticed we need to support the new MSG_SOCK_DEVMEM
flag in the hard coded table for the msg flags table, add it.

This silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h

Please see tools/include/uapi/README for details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mina Almasry <almasrymina@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/linux/socket.h | 1 +
 tools/perf/trace/beauty/msg_flags.c            | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index df9cdb8bbfb88428..d18cc47e89bd0164 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -327,6 +327,7 @@ struct ucred {
 					  * plain text and require encryption
 					  */
 
+#define MSG_SOCK_DEVMEM 0x2000000	/* Receive devmem skbs as cmsg */
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
 #define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index ed3ff969b5465bbf..2da581ff0c802df8 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -11,6 +11,9 @@
 #ifndef MSG_BATCH
 #define MSG_BATCH		   0x40000
 #endif
+#ifndef MSG_SOCK_DEVMEM
+#define MSG_SOCK_DEVMEM		 0x2000000
+#endif
 #ifndef MSG_ZEROCOPY
 #define MSG_ZEROCOPY		 0x4000000
 #endif
@@ -57,6 +60,7 @@ static size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size,
 	P_MSG_FLAG(MORE);
 	P_MSG_FLAG(WAITFORONE);
 	P_MSG_FLAG(BATCH);
+	P_MSG_FLAG(SOCK_DEVMEM);
 	P_MSG_FLAG(ZEROCOPY);
 	P_MSG_FLAG(SPLICE_PAGES);
 	P_MSG_FLAG(FASTOPEN);
-- 
2.46.0



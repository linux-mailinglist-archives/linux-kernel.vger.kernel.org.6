Return-Path: <linux-kernel+bounces-191097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A48D0760
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E79B2807A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32CF73459;
	Mon, 27 May 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxbKH5C2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2A17E90A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824949; cv=none; b=taT28WgjIpo+O2pu7erR4wnRqJLb5DAI4+Tb+aWdPoodl5+gPvvHiNbTDG5ZFTBaNiHZRESjZ7dMXvW5cUU/XguZ1MxpnnW+WvP7rs8Hp216nYA/yxn6pNqlBcjDWMagpq7oTcfLQGnazKVG1MGTd2pEDBK4G9+sRD7wV+Lt5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824949; c=relaxed/simple;
	bh=PTOD43twZezS1LaJReRCBTqZRcQpJg3FNX+Bc7pvXxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XkRXPuXo2PeWM/Rfi5ksVzAfYMf7mXC1eiOMeWr0RTM7iPzAEhwBdUxRmt3AaYbYsBx1UTSC9ao+izFHOrpVWcLVf3K9e2ChHV3ZnwDLZfeQFrj034/sitP2aUYRCaWymZOb2tAPipANg1sEuLoMmTszHnnq4yiZnXf47I6iMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxbKH5C2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11313C4AF07;
	Mon, 27 May 2024 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716824948;
	bh=PTOD43twZezS1LaJReRCBTqZRcQpJg3FNX+Bc7pvXxE=;
	h=Date:From:To:Cc:Subject:From;
	b=IxbKH5C2BwSP+iOUIKaBS1SI3wXJKhKcDFUkIG4T9t9UPywfcjK5Ljk/qO0lPp55t
	 217DLLh6BUR0hOyEtCUHB0lf7exkGCiKr+9YxJmGO5fLPA34hVX8VImzpAQCBR6CoX
	 3dDifS/1vT/4ds3hUzCA3lkPy08MkQ6tSjCW8ySmYv3SeWfh3s8Ci8J5rsYJT1Ous9
	 BNuunDrH+Rx8SdQ6ny8IQbh0QkTc0TD/Co53IIuU4MpiEGueDMJXqkBJ7VI6p9hmlf
	 Aj3MOPUvSlG4SrPPa1gfFTwQturO3j1vm3XP/0PNgnwLybrgKjeddRuqUkpLBNsHrV
	 M9f6khanAmVbg==
Date: Mon, 27 May 2024 12:49:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jens Axboe <axboe@kernel.dk>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] perf beauty: Update copy of linux/socket.h with the
 kernel sources
Message-ID: <ZlSrceExgjrUiDb5@x1>
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

To pick up the fixes in:

  0645fbe760afcc53 ("net: have do_accept() take a struct proto_accept_arg argument")

That just changes a function prototype, not touching things used by the
perf scrape scripts such as:

  $ tools/perf/trace/beauty/sockaddr.sh | head -5
  static const char *socket_families[] = {
  	[0] = "UNSPEC",
  	[1] = "LOCAL",
  	[2] = "INET",
  	[3] = "AX25",
  $

This addresses this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/linux/socket.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 139c330ccf2c3bf9..89d16b90370bd412 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -16,6 +16,7 @@ struct cred;
 struct socket;
 struct sock;
 struct sk_buff;
+struct proto_accept_arg;
 
 #define __sockaddr_check_size(size)	\
 	BUILD_BUG_ON(((size) > sizeof(struct __kernel_sockaddr_storage)))
@@ -433,7 +434,7 @@ extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
 extern int __sys_sendto(int fd, void __user *buff, size_t len,
 			unsigned int flags, struct sockaddr __user *addr,
 			int addr_len);
-extern struct file *do_accept(struct file *file, unsigned file_flags,
+extern struct file *do_accept(struct file *file, struct proto_accept_arg *arg,
 			      struct sockaddr __user *upeer_sockaddr,
 			      int __user *upeer_addrlen, int flags);
 extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
-- 
2.45.1



Return-Path: <linux-kernel+bounces-344401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D5B98A91E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF101C22C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4301922DC;
	Mon, 30 Sep 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVG8TMXC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B418FDD8
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711591; cv=none; b=eLiG0B+cw0LZvhOGOa9PiLgZG+gsd8fQTVA+n2E+JT7B1sNEYbkj+QQyyCvHhgKc4s8V5dkCyTNYKMggkq4ijvIQ2vbqTvHgYxXbKLdxjgbMFVsmnGJNUo57Z9YgO7fDm9fGnwuDlv1XyyqxgAnZ5N6WYDq3S2hfg5JyMn+TCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711591; c=relaxed/simple;
	bh=AwaHZSWLoq9RhitcWfm4I5KvdRm+x7N/Oe9lgZWp5sU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DEJvX0eCpA26V1cmw5VoQHAAssSC6SQxjSLJzNYAH+sQD48uSD5tXhnKVUtYf1MO6Piw3q1mMNW7bsU7hmjegdqVCN4ER4RURwqOk9FoCLevU4s+2b+DoMu/579glBQhgfoPxrXnc3wslZC+6Sa0znobYot/wq25PatUHVuzQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVG8TMXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D415C4CEC7;
	Mon, 30 Sep 2024 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727711590;
	bh=AwaHZSWLoq9RhitcWfm4I5KvdRm+x7N/Oe9lgZWp5sU=;
	h=Date:From:To:Cc:Subject:From;
	b=bVG8TMXCsR7Gkn4tDw9RnsTdGkyEOCCoqJxIvI2p8MdAUIVhq2hAJMV61x9HhKkXG
	 BQWWMIBVEjMt0B7ws8NlBi2fzBMU1MfeXB29e4DYebJRuYhAjrlTNANgskJE6U1o+9
	 swU2d3Sw53mHjgMi90E8Pi3SCMJEkuW3lRjXsyH0jala6KpJOv1DqYYFT9ODBZPMYC
	 brfHhBh7mESYoUs0U+wCHnBiAe3WiP/xy6AwUUmwFVrAlynqGFx4Mp2GNMhOFDcxw/
	 rgfmrsSFFoPpy7E94kWp5P90tyVO/i4XK5hbJPVeSRls5HZL8agALQsJDG9Lu7cnO7
	 yIfH48NIiRIyw==
Date: Mon, 30 Sep 2024 12:53:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jithu Joseph <jithu.joseph@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <ZvrJY68Btx3a_yV4@x1>
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

To pick up the changes from these csets:

  0a3e4e94d137daac ("platform/x86/intel/ifs: Add SBAF test image loading support")

That cause no changes to tooling:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  $

Just silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jithu Joseph <jithu.joseph@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 82c6a4d350e09e6d..a7c06a46fb767d4a 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -247,6 +247,8 @@
 #define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
+#define MSR_INTEGRITY_CAPS_SBAF_BIT		8
+#define MSR_INTEGRITY_CAPS_SBAF			BIT(MSR_INTEGRITY_CAPS_SBAF_BIT)
 #define MSR_INTEGRITY_CAPS_SAF_GEN_MASK	GENMASK_ULL(10, 9)
 
 #define MSR_LBR_NHM_FROM		0x00000680
-- 
2.46.0



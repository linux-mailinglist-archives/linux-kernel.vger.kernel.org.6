Return-Path: <linux-kernel+bounces-344326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9433B98A858
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A0D283D04
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343BA1922F8;
	Mon, 30 Sep 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIqtgF6y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9E20B0F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709693; cv=none; b=d0jkMYGsGIwPofh6v+x5caF/xN/K8cJZ0uO9iIVXpUKFDLqQIg6l+dHUUobWzcgWxgK9+bGuhCCHELGztmHnOIrjpXicnfV6olLwXeCTqAUSsRXpWLlO0ky1TP2NHa+pT9zgBnJDCd7IaKXRrV+FiEWdEuOew/NjY99AQEMIiNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709693; c=relaxed/simple;
	bh=fd8tLFjZJebXSMnYyvV5Yt4ExQcv9S1k10svWjUJz0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lxQtsYB0Fu3EKAMya3DDds8XonGH5+VOHei1/LK6KBGeyE5XVHVxtHRkQdF60SkrZL84wBHwMe0pZPNbOVwmxfPyQh6QTYB6tcyLgw2n6hKx7gTgBeSpUT5QAkm21YlqJbnm7k7lNhjU3djV1NcEPMoDFMdFeZSCqB8IM6IMOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIqtgF6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC0EC4CEC7;
	Mon, 30 Sep 2024 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727709693;
	bh=fd8tLFjZJebXSMnYyvV5Yt4ExQcv9S1k10svWjUJz0M=;
	h=Date:From:To:Cc:Subject:From;
	b=OIqtgF6yEQjcCYS6hDawIypHAEvM+PoQSI5ONzzYksYWo3KECJ76PZx6pmDIUgPIM
	 sz66WMMsnLBtrcV3B8cxmSiQD+HtLj5leKixNtaRUGmeVtLylFM+ksbLFHZq4k9ONZ
	 iX8Q5i67/rHmC1xvpcaw+oqygjW7kzqF4Iu7zt6WMw8L70ULK9522Y2z9ExItPO/Vu
	 FBVHvGd6rrmAQ0bs361Z2D+HWyNbGfL98/y9qkW3U6ja1TvkrPsyPdzheYhhLx9d75
	 KC4ifyYRmYn+tMJ2XmigYpM1thtQTtXDCpL/R7IXQWcrmqNMNJfhuS93cGC//mhhX+
	 bpvg6Mx7usFPA==
Date: Mon, 30 Sep 2024 12:21:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync sound/asound.h copy with
 the kernel sources
Message-ID: <ZvrB-g_E7g2ArlYW@x1>
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

  37745918e0e7575b ("ALSA: timer: Introduce virtual userspace-driven timers")

Which entails no changes in the tooling side as it only introduces new
SNDRV_TIMER_IOCTL_ ioctls, and the ones tracked by scripts in
tools/perf/trace/beauty/ are only SNDRV_PCM_IOCTL_ and SNDRV_CTL_IOCTL_,
we still need to support SNDRV_TIMER_IOCTL_ ones, but that probably will
be one of the first for a BTF enumeration based approach :-)

This silences this perf tools build warning:

  diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../trace/beauty/include/uapi/sound/asound.h    | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/uapi/sound/asound.h b/tools/perf/trace/beauty/include/uapi/sound/asound.h
index 8bf7e8a0eb6f03a8..4cd513215bcd8f74 100644
--- a/tools/perf/trace/beauty/include/uapi/sound/asound.h
+++ b/tools/perf/trace/beauty/include/uapi/sound/asound.h
@@ -869,7 +869,7 @@ struct snd_ump_block_info {
  *  Timer section - /dev/snd/timer
  */
 
-#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 7)
+#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 8)
 
 enum {
 	SNDRV_TIMER_CLASS_NONE = -1,
@@ -894,6 +894,7 @@ enum {
 #define SNDRV_TIMER_GLOBAL_RTC		1	/* unused */
 #define SNDRV_TIMER_GLOBAL_HPET		2
 #define SNDRV_TIMER_GLOBAL_HRTIMER	3
+#define SNDRV_TIMER_GLOBAL_UDRIVEN	4
 
 /* info flags */
 #define SNDRV_TIMER_FLG_SLAVE		(1<<0)	/* cannot be controlled */
@@ -974,6 +975,18 @@ struct snd_timer_status {
 };
 #endif
 
+/*
+ * This structure describes the userspace-driven timer. Such timers are purely virtual,
+ * and can only be triggered from software (for instance, by userspace application).
+ */
+struct snd_timer_uinfo {
+	/* To pretend being a normal timer, we need to know the resolution in ns. */
+	__u64 resolution;
+	int fd;
+	unsigned int id;
+	unsigned char reserved[16];
+};
+
 #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
 #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
 #define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
@@ -990,6 +1003,8 @@ struct snd_timer_status {
 #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
 #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
 #define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
+#define SNDRV_TIMER_IOCTL_CREATE	_IOWR('T', 0xa5, struct snd_timer_uinfo)
+#define SNDRV_TIMER_IOCTL_TRIGGER	_IO('T', 0xa6)
 
 #if __BITS_PER_LONG == 64
 #define SNDRV_TIMER_IOCTL_TREAD SNDRV_TIMER_IOCTL_TREAD_OLD
-- 
2.46.0



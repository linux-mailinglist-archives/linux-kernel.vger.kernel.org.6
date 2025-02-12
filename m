Return-Path: <linux-kernel+bounces-511907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0838A33148
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8665C164299
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF458202F64;
	Wed, 12 Feb 2025 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGyc5+eW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20500202C48;
	Wed, 12 Feb 2025 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394493; cv=none; b=nNS5BNN/fF/fPHIjwgBvPOVqzcb6oKXAObM98DOboJ6nMB+qPBVrPdNijjashwf6bwMpFEEUqSp7U4IZGD5pV01oFZ57N6NDo+2EWy6KxRbVew4S1auiJHFb0jmiRdQ0ITbuSRcua0WIeZF3QfaeQjMlvLxSVt99Oxa4B11JCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394493; c=relaxed/simple;
	bh=ZlYS8/RGksFoYa5QMgx8JgmK5kqKi2Lgph+Ezj5n8ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDCqZK0dqYtsV9cXW5Zae+28iPBrgFpZCSa8o47HdWVRXh+XOHJ6u4JHJN/t0l16famDc9BAcEjAl9Uwi9jJJ4YQbf27UJQ/vEv8V9mm9XsOyIWUazri+jkSJxMddqK94+LZbMoJqwiJ4KeOb/oPCtfbo8Swz05RxORf/Pdhlj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGyc5+eW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F19C4CEDF;
	Wed, 12 Feb 2025 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739394492;
	bh=ZlYS8/RGksFoYa5QMgx8JgmK5kqKi2Lgph+Ezj5n8ss=;
	h=From:To:Cc:Subject:Date:From;
	b=qGyc5+eWU9kIbbAftm2vLK4+q2YikMe8+wWeTpZ3F7e/0X3GjHCwxkEMaPEg8P6ce
	 UaZyXrDlpIdGEwQl/zQtxLV+7cXEGklTefE+W/F0RyjpVM8E8dJHfkzIH3Qr+RjV+4
	 ks1FcCtlUN0raTSseThx4oQhN9YIwrh+JguCsCua/KQ6d0j8bx8JsOM7WZPBaGvip4
	 /tniNR0U5i7qCVQnhNoFIk2LRuQfCDI8RR6QsbeMTVNWkezyd77TASujG8vqDFrb4o
	 UNzqQ9eBirNAhHHzYxeRO77hnItCvm7lduK/wBOJq+JkrwI18Qmje5ITioXdFwsawp
	 FabsCFgxKcTUA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tiJxq-0000000AOWv-0jdE;
	Wed, 12 Feb 2025 22:08:10 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Stephen Rothwell" <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ABI: drop two duplicate symbols
Date: Wed, 12 Feb 2025 22:08:01 +0100
Message-ID: <c3dce809f577584cf9aedafc6c2a0d5a9ca909ac.1739394480.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As warned by get_abi.py, there are two symbols that are
defined twice:

WARNING: /sys/devices/system/cpu/cpuX/topology/physical_package_id is defined 2 times: \
	/new_devel/v4l/docs/Documentation/ABI/stable/sysfs-devices-system-cpu:27; \
	/new_devel/v4l/docs/Documentation/ABI/testing/sysfs-devices-system-cpu:70
WARNING: /sys/devices/system/cpu/cpuX/topology/ppin is defined 2 times: \
	/new_devel/v4l/docs/Documentation/ABI/stable/sysfs-devices-system-cpu:89; \
	/new_devel/v4l/docs/Documentation/ABI/testing/sysfs-devices-system-cpu:70

As the documentation at testing/sysfs-devices-system-cpu, drop
the duplicated one from stable.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/stable/sysfs-devices-system-cpu | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-system-cpu b/Documentation/ABI/stable/sysfs-devices-system-cpu
index 902392d7eddf..cf78bd99f6c8 100644
--- a/Documentation/ABI/stable/sysfs-devices-system-cpu
+++ b/Documentation/ABI/stable/sysfs-devices-system-cpu
@@ -24,12 +24,6 @@ Description:	Default value for the Data Stream Control Register (DSCR) on
 		If set by a process it will be inherited by child processes.
 Values:		64 bit unsigned integer (bit field)
 
-What:           /sys/devices/system/cpu/cpuX/topology/physical_package_id
-Description:    physical package id of cpuX. Typically corresponds to a physical
-                socket number, but the actual value is architecture and platform
-                dependent.
-Values:         integer
-
 What:           /sys/devices/system/cpu/cpuX/topology/die_id
 Description:    the CPU die ID of cpuX. Typically it is the hardware platform's
                 identifier (rather than the kernel's). The actual value is
@@ -86,10 +80,6 @@ What:           /sys/devices/system/cpu/cpuX/topology/die_cpus
 Description:    internal kernel map of CPUs within the same die.
 Values:         hexadecimal bitmask.
 
-What:           /sys/devices/system/cpu/cpuX/topology/ppin
-Description:    per-socket protected processor inventory number
-Values:         hexadecimal.
-
 What:           /sys/devices/system/cpu/cpuX/topology/die_cpus_list
 Description:    human-readable list of CPUs within the same die.
                 The format is like 0-3, 8-11, 14,17.
-- 
2.48.1



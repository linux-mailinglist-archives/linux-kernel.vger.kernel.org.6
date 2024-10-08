Return-Path: <linux-kernel+bounces-355332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CB59950B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E211C24FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCCD1DF995;
	Tue,  8 Oct 2024 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="CSW8mm42"
Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA101DF72E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395629; cv=none; b=cbNHjzCwEzricceJJq9MUnGdZt90G5s/q8VWys2HtozLH3FC5dSil4Uk6yNbyQJDkUb6ZxqpaKfsVxpeWLL6JWYxn26NjqTXOXFMhvm/+6WCn2PO0ufFdnHGt1WehJxjfSLkVItI8XnUhC5dFwQf8/MG206Zs4vzqE+5E3Ul+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395629; c=relaxed/simple;
	bh=CYhA1GI4rn88rQyo9rf4G11UGZijDVHRnPuIiZQG99U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ftNWeopnTJAujU7oNFLxFLNQ7lVnmyNjp8fXFMkaHaBDMwswfkXf83O6OT3qWyv1RxdL9bcXHllOhhTmJfNlossSg3zQsq8LerRifu8DuM+SMq8n+Qd/YPRR/Nma4eHRDRRilgYtGlXkqtIKCF77Zv/hNRGClf5b0Va/G1QXL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=CSW8mm42; arc=none smtp.client-ip=62.149.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id yAbisgixkbsngyAbisUWTp; Tue, 08 Oct 2024 15:50:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728395435; bh=CYhA1GI4rn88rQyo9rf4G11UGZijDVHRnPuIiZQG99U=;
	h=From:To:Subject:Date:MIME-Version;
	b=CSW8mm42rTdjwdVzWi+CoTAhs4rinHIujdKLQNBlrkSAm0WE8Rwgu4DthOmw98XWO
	 SsF2/rkP8RV5yxskoGQmuDBm2pMS4L0O1Ru6luVxHrrXODKYjFmRduSS3icFXChjeX
	 lSmbfP8F6nFPRW3J/3jSG/dTS6D5mpSSZxvWy6je/9teZ49VGgQpD06u/GSCZEty2j
	 ve95iLMz7dfJVzdRn1Uu8X8HwwFogxVKehCZE+uy/N3RyJp3iN5u1tINI9CkXuKntw
	 pfCBaEfPItYKB73ez1CH3XxOgEl7j2ts1pq2nBm94LZSWQnwIXecYS2cfygrQkxvGJ
	 guWYd8t0uafIg==
From: Rodolfo Giometti <giometti@enneenne.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <greg@kroah.com>,
	corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>,
	tglx@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	Dong Eddie <eddie.dong@intel.com>,
	N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [RFC 0/3] Add PPS generators
Date: Tue,  8 Oct 2024 15:50:30 +0200
Message-Id: <20241008135033.3171915-1-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfF/Qmdr6G8T33AgGhZuLqIgqQz6VWokfj+tGnhGFC4PfJu79EaLzZB+rVVOvtP1QDUqgYOx/eGmlCTmDa/50DCowPWXfKgC72pnHV/VPiQEu5w+/tAs1
 bUjkybR5QItOtyKjgt+3G+nFVxBU8pC2+B/upeTBulRXru6baf5lQbVTKxQLR5UYvBYBOWUFRq/m+7/AjYJ065UcPdrjXi7DTCk6+6QzoAjB0rhge2p+YetE
 YS5KT/pdkgjxOMDcqJT7vnoaPJ2gZnCdRy9TtUUVMYVBmDqLstUhioGhLYNzyoaYZUNkbK8or6w/cQGOBK2ruh4ygFuzZT3WfgBGLq/3WLrvsmlGdVcrrDGk
 2PAe762rrTRvQU7WhNPqbKxr+OBglRo8Z82IDYicvOuxlHqfL2thoTZXMqhJYPdRh/9aoio7CFUpKfOzooJZUxQf65n9sRlh+heH08GNCYi3XGT7rzO8r1zE
 IhI6apaSpt1CDMEn0F9o0RwIIR3nJQgXrIW7EDkay7R/B1Wzf7cT4+YQV593+y3EsnDnWzQoQTQcKCPnqziaFGiUg0iPCFwUL1pfE0/Z7CHtnOcZ/e/FN/fy
 gFldGCjUfGfw0CmnTPPeQnV/Saf0VHgMhabwPftwQ/Dbmm3SdkRlRr5RlG0sc5FK9WVGrH5zGlL8exKiYzUDtLVkjje9NyzoBVDMGLwOyVhgnlPDjSyCy965
 M5W4B0FgqMSE8HxMQFu6XgzSf+y8UfMI

PPS generators are special hardware which are able to produce PPS
(Pulse Per Second) signals.

This RFC patchset adds the class pps-gen to the kernel in order to get
feedback useful to produce a well-thought-out and well-defined
interface for these devices.

Rodolfo Giometti (3):
  drivers pps: add PPS generators support
  Documentation pps.rst: add PPS generators documentation
  Documentation ABI: add PPS generators documentaion

 Documentation/ABI/testing/sysfs-pps-gen |  44 ++++
 Documentation/driver-api/pps.rst        |  40 ++++
 drivers/pps/Makefile                    |   3 +-
 drivers/pps/generators/Kconfig          |  19 +-
 drivers/pps/generators/Makefile         |   4 +
 drivers/pps/generators/pps_gen-dummy.c  |  83 +++++++
 drivers/pps/generators/pps_gen.c        | 283 ++++++++++++++++++++++++
 drivers/pps/generators/sysfs.c          |  89 ++++++++
 include/linux/pps_gen_kernel.h          |  57 +++++
 include/uapi/linux/pps_gen.h            |  35 +++
 10 files changed, 655 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-pps-gen
 create mode 100644 drivers/pps/generators/pps_gen-dummy.c
 create mode 100644 drivers/pps/generators/pps_gen.c
 create mode 100644 drivers/pps/generators/sysfs.c
 create mode 100644 include/linux/pps_gen_kernel.h
 create mode 100644 include/uapi/linux/pps_gen.h

-- 
2.34.1



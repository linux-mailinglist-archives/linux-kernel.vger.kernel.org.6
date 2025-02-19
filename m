Return-Path: <linux-kernel+bounces-521696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799ABA3C0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0623189C996
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A041EFF85;
	Wed, 19 Feb 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGqe8Yj8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108381E8339;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973480; cv=none; b=usiiMjHH+nABzX93PSlE8HXToQ2m1R1qKbGnQjBX9LI3Vs7+bG5I3jk9ijHZTtZQ0oKaDcRbKDAILt6yRHoV+t9SMQpwnSMAADjdlvKLff3x5QaTBk3yQSVnX1t+sJrvQ7Yj0X4XhgrqBTTwajHMiibDZmL/B/j4GQZx5yubOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973480; c=relaxed/simple;
	bh=+zvcJdWEHzoEWzuYCy22rFH0TIPtIrbJ14DEL51h8cI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXMf8EUQQq2ERQjwx8ON0YmZUyp042qVxEVNdjoViM3aW0TIGvRmArK0TolUoDo4zE9sQNKWmRGKZ51T3BvgXlaIcUstHgClrv4ABYm8xfWW1mRM2p0mYwWWHYAzySXh8F7XET5nw6d7DmCGic+utB08gqqCO56Z6+2qHnb0CkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGqe8Yj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99591C4AF09;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973479;
	bh=+zvcJdWEHzoEWzuYCy22rFH0TIPtIrbJ14DEL51h8cI=;
	h=From:To:Cc:Subject:Date:From;
	b=bGqe8Yj8hiBMUwJXr2i70buhC7NV7XwoEJBPuuiAwYi+1R+Zqx/ufEqSJjnfkRTR5
	 IGdqaJ93+HXMbfwkzlMNlV+aLHciM0rtaOrCMHE7BQK9ugc7VRqMGAa+mRc7QxxzKn
	 c2YWuriOQZHJsz8rl2Yt2reAHHSZz7v0rEui9Z6/FaZ4bscVz6vq/jH6J1tSHb6CLs
	 Q1PGwCb5nBxs82eCebH1WVvZKdWlen+eHK2eF34Sruc99Eocv16SPTalqze7Deqm+B
	 H+MH6/w7+p2lrL9DGD1U0WXyRqt6Fx/5WQ5kQcTeJd8f+ggQjU37rOuwgKUs2HGzoC
	 KilevAcHac3ng==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkkaL-0000000H1jC-0QL8;
	Wed, 19 Feb 2025 14:57:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] additional fixes to kernel-doc.py
Date: Wed, 19 Feb 2025 14:57:35 +0100
Message-ID: <cover.1739972906.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

This series comes after:

https://lore.kernel.org/linux-doc/cover.1739952783.git.mchehab+huawei@kernel.org/T/#t

it basically contains:

- a regression fix when -none/--none parameter is used;
- some backward-compatibility fixes;
- a fix to KBUILD_BUILD_TIMESTAMP, which also drops
  importing dateutil (*);
- a cleanup related to man modulename.

(*) despite almost everybody has it installed, dateutil is actually not
    part of the official Python libraries, so using it would require an
    extra dependency check.

While our minimal Python version is 3.9, I opted to make it compatible with
Python 3.6, as the only issue preventing 3.6 was a single string function
(removesuffix) that can be also served by rstrip().

After those changes, support for 3.6 on kernel-doc.py comes almost for 
free: both man and ReST output works with just Python 3.6 installed without
any additional modules.

So, no need to change any dependencies at scripts/sphinx-pre-install.

Mauro Carvalho Chehab (6):
  scripts/kernel-doc.py: Set an output format for --none
  scripts/kernel-doc.py: adjust some coding style issues
  scripts/lib/kdoc/kdoc_parser.py: fix Python compat with < v3.13
  scripts/kernel-doc.py: move modulename to man class
  scripts/kernel-doc.py: properly handle KBUILD_BUILD_TIMESTAMP
  scripts/lib/kdoc/kdoc_parser.py: remove a python 3.9 dependency

 scripts/kernel-doc.py           |  8 ++-
 scripts/lib/kdoc/kdoc_files.py  | 19 ++-----
 scripts/lib/kdoc/kdoc_output.py | 97 ++++++++++++++++++++++++---------
 scripts/lib/kdoc/kdoc_parser.py | 15 ++---
 4 files changed, 83 insertions(+), 56 deletions(-)

-- 
2.48.1




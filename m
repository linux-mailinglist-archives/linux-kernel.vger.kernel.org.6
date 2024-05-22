Return-Path: <linux-kernel+bounces-186503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0858CC505
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDD7281007
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8D71420DB;
	Wed, 22 May 2024 16:42:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89161411E0
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396178; cv=none; b=K0mygZj8inGa/VxM0Qo2uFamKKT5svEuHFuhRcUlgkgjBuKo0bECszqnJmMurL3LNZIaiiMgOAxE1vqBaFc1DTOvTbel0o+s9KCUS9HQ3qRmadbY1pxQ8ZQWjY410jiN620MDJJ+z8Dx8C1HL0TpCvxYte9CeCYOPfVqjwkCJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396178; c=relaxed/simple;
	bh=3jkwUjyyYlg0dOMnGWfZbXslF711YEapCtp4zgOu1Rc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=te9fYs+zNZyK+e1mpFnL+L9CEUyEpJJxEO0eiXXputfsi4b0GFJPRpD5d2AkPcEYRWuT3zw3ZosFoXNg8yihgddnfsROUzEGl1YBKDgkqcubGY3gaH/N5rM7NyzNC8Uzvch5b4rb6fzJxw+xGqS9ykrLHyCyvl0wt9c/MQgEJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725ECC2BD11;
	Wed, 22 May 2024 16:42:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s9p41-00000006HEe-1FXc;
	Wed, 22 May 2024 12:43:41 -0400
Message-ID: <20240522164320.469785149@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 22 May 2024 12:43:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] tracefs: Some minor fixes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Steven Rostedt (Google) (2):
      eventfs: Keep the directories from having the same inode number as files
      tracefs: Update inode permissions on remount

----
 fs/tracefs/event_inode.c | 23 ++++++++++++++++++-----
 fs/tracefs/inode.c       | 15 ++++++++++++---
 2 files changed, 30 insertions(+), 8 deletions(-)


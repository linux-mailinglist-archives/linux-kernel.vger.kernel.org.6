Return-Path: <linux-kernel+bounces-228299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACC915DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AEDA1C21554
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B453513C9BD;
	Tue, 25 Jun 2024 04:53:37 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0F12E1D2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719291217; cv=none; b=KnlSYPNWW4Jlg7Vv2YMnK+UW8d5cgrXWLvHy+LhSKbT9i+KALBeYhKb2OIpS9s+0IxW6xCbQBSsay5KgK7ngb0MFEos1QJmagW/T2zQp6c8WKMsyOa/hhgNgw3JMCQuMnnSEtsUGNyK99uYl8AXLUzMGL7c1d81PTg2Wm2TTKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719291217; c=relaxed/simple;
	bh=owd6b2nSuj3DFGPRIOnFuMBpJnKHhgXcIN7IBIbHWes=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=jFGshHsx34xRVt7/qVyMrKckMr0072cwof1q9N/gyojuaiReBsC8RUgmgh5GZzJ9orodUnQ5xiKwW6bTQLJ/X5BawB6BEE8Pv1W3/JBrv2ZfFw7tT4+Tk1oYvLUxw0xSnIHK+JG6WiSmc8VUhFKugXxvc3/QSYoTyaxIvzK7gBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45P4rUgc018137;
	Tue, 25 Jun 2024 13:53:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Tue, 25 Jun 2024 13:53:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45P4rUVG018134
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 25 Jun 2024 13:53:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a2775599-67a8-4b4e-a9df-c0da021fe59c@I-love.SAKURA.ne.jp>
Date: Tue, 25 Jun 2024 13:53:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 0/2] orphaned fixes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These are orphaned patches which nobody can take (and as a result bugs
remain unfixed for years). These patches have been tested using linux-next
tree via my tomoyo tree since 20240611, and nobody found problems.

I send to you as per THE REST rule in MAINTAINERS file. Do you want me
to send these patches as a git pull request (or not worth creating tags
for pull requests) ?

  [PATCH 1/2] profiling: initialize prof_cpu_mask from profile_online_cpu()

    kernel/ksysfs.c  | 27 ++++++++++++++++++++++-----
    kernel/profile.c |  6 +++---
    2 files changed, 25 insertions(+), 8 deletions(-)

  [PATCH 2/2] Input: MT - limit max slots

    drivers/input/input-mt.c | 3 +++
    1 file changed, 3 insertions(+)


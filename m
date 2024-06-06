Return-Path: <linux-kernel+bounces-204502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B95078FF003
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2792B2EAAC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58971B14EF;
	Thu,  6 Jun 2024 14:40:24 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557C19E7F5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684824; cv=none; b=ONOIDOn9FTj7CYS+AMAk8WYB0mMPlCgnLbH82PVpSdbbkD+nHh2ZXemZ/Db/U7AAufjHjf7TmW0pcon5C3r4qnxfAOgFaHrM3w0e0UTBatnbsorc/SKiSQJp8zFu2hjp9MuNBFnaoxA38y2uM+QyTS4ezFFgdHdtZUNH7KWG0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684824; c=relaxed/simple;
	bh=tUMWsF78RNhMYX/UO7ZV4hcCMrXZN0eXQoDvU9LivP8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rIenbfOTxOcyhmeQiL3S3Eugl66gGYtk4+Y7WXqWtSwbA+o+Y2qEiV0T9lYmc/RdjwtWAlK2QMjNroSH4q4AThl6fk0Jv1hTCaMW2/kj/LkojHh71iAmG5DH5KMNRM5lU9QpVhUFi4xXrwQIjX4okyHlYRr30KUovu2ZnBIPNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 456EeBNA011132;
	Thu, 6 Jun 2024 23:40:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 06 Jun 2024 23:40:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 456EeBuq011129
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 6 Jun 2024 23:40:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c86f0ed7-4336-4bc8-a27c-8d7ccaaec5d8@I-love.SAKURA.ne.jp>
Date: Thu, 6 Jun 2024 23:40:08 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [GIT PULL] tomoyo update for v6.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit c6144a21169fe7d0d70f1a0dae6f6301e5918d30:

  tomoyo: update project links (2024-06-03 22:43:11 +0900)

are available in the Git repository at:

  git://git.code.sf.net/p/tomoyo/tomoyo.git

for you to fetch changes up to c6144a21169fe7d0d70f1a0dae6f6301e5918d30:

  tomoyo: update project links (2024-06-03 22:43:11 +0900)

----------------------------------------------------------------
Single patch, no behavior changes.

Tetsuo Handa (1):
  tomoyo: update project links

 Documentation/admin-guide/LSM/tomoyo.rst |   35 +++++++++----------------------
 MAINTAINERS                              |    2 -
 security/tomoyo/Kconfig                  |    2 -
 security/tomoyo/common.c                 |    2 -
 4 files changed, 14 insertions(+), 27 deletions(-)


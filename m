Return-Path: <linux-kernel+bounces-412429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893739D08F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F07280BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9504B13B2B4;
	Mon, 18 Nov 2024 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apqXlry7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C2101E6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907821; cv=none; b=Mcd+y1eOnxHyEODBIZ9xa/mH/PzplVQquKhEym8B9BAk9yTGHc3AAYAeY1ywpWsUSUUNkdc3pBvemswq91HsQR6HUolcZvdnVn1JreHbwr8NQ1IVV14PJW/ft1GEMkuBAGBGC8ByWZNgF3DWDd6coOZd9ycMT4D9M5MweivcMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907821; c=relaxed/simple;
	bh=TiwZMulBQyJvcePyrNdx0K3xKGcfv1t6OXUrt6ma3+Y=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=dOWcI2ltI2m4ZuYngC93j8/I1MunYKUz+zyrncAdgKDs3prTOlJd78wIwEvhBTPPf4qhSAa4lflCMplfZsYWIOTt2ivL59WCxd3CC+zQrxQklef+Gy35WZcfN43WMpkw1X+iIpde/Dw3ZemftdG9ZXXx+2u4Y2BO4oZfyZVWhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apqXlry7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5E5C4CECC;
	Mon, 18 Nov 2024 05:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731907820;
	bh=TiwZMulBQyJvcePyrNdx0K3xKGcfv1t6OXUrt6ma3+Y=;
	h=Date:From:To:Cc:Subject:From;
	b=apqXlry7Jv8HmfEu0vJ1vrPnB2DOikWY1iN4s1lxIXbfDwmF94bipPfXeZQc0PjGQ
	 bn8narQVo644Y3SKjVnqWnK2CcV48szbukL6SdGFlhss+OfErYfwAVEXRcB6W9oKXX
	 A+3oGyUZAuqBGakyAjAIa/H3bnuvWN82EUqzJ72VFLMatzivyANTs4jowTz66EIpEV
	 zKHlzu75KYMfzAwOnxQ2tdaQQFUk6I4MRkFyGYLZar8g+OD5CxwxfCuJ5R5DGcG2UE
	 SrOTIGaBW8dGWjn9XYUmIxnb2kv1JrivgKhyxwGIl3NiBzjMHLNOv6vkCCxt7xCirK
	 VLk8A+OLAyIwA==
Date: Mon, 18 Nov 2024 14:30:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Masami Hiramatsu (Google)
 <mhiramat@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Updates for v6.13
Message-Id: <20241118143016.c94b7c8ec5d9ed8ae29a66d5@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes update for v6.13:

Kprobes cleanups. Functionality does not change.
- kprobes: Cleanup the config comment
  Adjust #endif comments.
- kprobes: Cleanup collect_one_slot() and __disable_kprobe()
  Make fail fast to reduce code nested level.
- kprobes: Use struct_size() in __get_insn_slot()
  Use struct_size() to avoid special macro.
- x86/kprobes: Cleanup kprobes on ftrace code
  Use macro instead of direct field access/magic number, and avoid
  redundant instruction pointer setting.


Please pull the latest probes-v6.13 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.13

Tag SHA1: 5d620f418ef869a7cdceb38cd32bb7422cb6ae0e
Head SHA1: 4638d7ebeff5a741e22139cf00aaa9db0f668a8c


Jinjie Ruan (2):
      kprobes: Cleanup the config comment
      kprobes: Cleanup collect_one_slot() and __disable_kprobe()

Masami Hiramatsu (Google) (1):
      x86/kprobes: Cleanup kprobes on ftrace code

Nathan Chancellor (1):
      kprobes: Use struct_size() in __get_insn_slot()

----
 arch/x86/kernel/kprobes/ftrace.c | 19 +++++----
 kernel/kprobes.c                 | 91 +++++++++++++++++++---------------------
 2 files changed, 55 insertions(+), 55 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


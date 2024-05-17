Return-Path: <linux-kernel+bounces-181643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678418C7F13
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922381C214CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC6399;
	Fri, 17 May 2024 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhROpA8u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215CD384
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715904695; cv=none; b=uiVfB+Znx37LgfIBtCtMSNBwYyere4NbG9FaME5IK9AIvKt34EtWvXGvHfmMoF/sRXJz8VWXVYndGgvlmnN98PaFOYrBxSJJelaK29wB2VbpgIgTg37N7m69jLzHlJhPyUXZdRoURmYfKIbTAPDSeYttllmU6Ho7iuBD4baoc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715904695; c=relaxed/simple;
	bh=Q/tFnbJdJ8fmaWadhjceqddfmUU0SeM1LXnKQxk5GI4=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=Jiu3b7geWBFqmjRlxYY00+GGqb/skkQzYvdtT2zfSVLLs8lzYdEVhRZb/QRs5o1kyp5FFqcU8uuA5sn0I6vWEitiEFOCWDxty1vrg7HznzQk8+39FHpiJGHhpABXbskxbp0fZS1zk4udXoEipgB0pwCMuIITV2hYM/IJjDVJ7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhROpA8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA70C113CC;
	Fri, 17 May 2024 00:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715904694;
	bh=Q/tFnbJdJ8fmaWadhjceqddfmUU0SeM1LXnKQxk5GI4=;
	h=Date:From:To:Cc:Subject:From;
	b=YhROpA8u5J8rmQyKk3DM163f96Wrt9Q7bPri2rZdtGmOwVXeuW3A3zea9+9j49Y72
	 XESC2JJ4ucNi4ehiAXldnEAuIuWkidwB+5bxvqhEaPDnMhq1+9SbhUvIMCCZosUctM
	 LAI9m9zm7FDruB4pFICcBIgjMEuhaCYF9zz9+ZGqgeXOoeAIVpB0ZCsUWOVdqGrL7o
	 vGXEG9IdLmhiKabQLSvrnby6VXtc1xkcPRpKRZBI3gXEKwZ+moFoebxvSlr+hZtKQc
	 xtDncGhi49iooNrdgop0kn4wsXjgIbhn2+zSlqGpoyolIltav2KC+OwTlZ2piNK6MF
	 or6uX6IYrkI1Q==
Date: Fri, 17 May 2024 09:11:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Yuntao Wang
 <ytcoode@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] bootconfig: Updates for v6.10
Message-Id: <20240517091130.61db91a91838b856bb2f8c6e@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Bootconfig updates for v6.10:

- Do not put unneeded quotes on the extra command line items which was
  inserted from the bootconfig.
- Remove redundant spaces from the extra command line.


Please pull the latest bootconfig-v6.10 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
bootconfig-v6.10

Tag SHA1: 50d5a7465ca625b741bc63bdfe57ba5baf52ff63
Head SHA1: ddd53363f875eb23b6754362ce0a43f2214f0a83


Rasmus Villemoes (1):
      bootconfig: do not put quotes on cmdline items unless necessary

Yuntao Wang (3):
      init/main.c: Fix potential static_command_line memory overflow
      init/main.c: Remove redundant space from saved_command_line
      init/main.c: Minor cleanup for the setup_command_line() function

----
 init/main.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


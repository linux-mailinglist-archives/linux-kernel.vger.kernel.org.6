Return-Path: <linux-kernel+bounces-253977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA491932998
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886171F23577
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521AB19F47B;
	Tue, 16 Jul 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYDfJssx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919DA13CA99
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141091; cv=none; b=hguWo/YxlltNA4w6BpG4sKCgTy8ext19zl4gIwsZHYQHRiMty50GeoE8sJMjlSRk/w8i6bcitrnffpabZN4LtZOst+ognhIQvOCXV7cct8lEaNRsSOql8YQzaDvNXVvcexIpf9Q0O2rR+oshB5rPtG3eNnbRftSVE9jfKQu2z0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141091; c=relaxed/simple;
	bh=Se5qUQYR7cYTKFBZdQstOwUWrVaXBbEswbhGGH/eoh0=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=KMAZQ61lyXnR5PReIkKI3rC3x0rHXMjv0OYa6BCuXBlksgBt3z1HJlX/0zFxsSV4l+sSD/Sn1YALe0CqdBnxP+dGqj+fSyxpMPkadxrRCWhtbrxG9O/7p1g8r4cGvFrKmjBU+F1OcwB60UmBIId4fViF6bfkeXTN/ZNuCOmwhz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYDfJssx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7C9C4AF09;
	Tue, 16 Jul 2024 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721141091;
	bh=Se5qUQYR7cYTKFBZdQstOwUWrVaXBbEswbhGGH/eoh0=;
	h=Date:From:To:Cc:Subject:From;
	b=UYDfJssxVCknbaNi47/v6KEB43t6pYrEyErPGS+FGLJxY1+9njV3cJEmtKGOTmO7c
	 OQCjwjNKzGvjPrpKtggRCc2JA9I/9xD3zaescn3lqm2PBUvkr6qVpCAV7bKyfEZi34
	 JA1xyLzD7W2Xv4zuxBDObtU8mWo9tO8RVCCcQoehzZnhq6pG5GZsuesVZslbxxzAqF
	 8XB3bl5zsmNFGO9TYn04P9KhzPfsprEznalxEDcVlmm76yL2E8SSue7mpuUeXbb4+L
	 di4WIfGzASDvwpvftqbrkKs0Ktoo4TKkLW76dv2/CVo0cRkGAJAR3s8SIkzPSqIA0U
	 o1mZRLUp4bCfA==
Date: Tue, 16 Jul 2024 23:44:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] bootconfig: Updates for v6.11
Message-Id: <20240716234447.1971543e2c6f19d6e4b2092c@kernel.org>
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

Bootconfig updates for v6.11:

- Remove duplicate included header file linux/bootconfig.h from
  lib/bootconfig.c. This is a cleanup, no behavior change.


Please pull the latest bootconfig-v6.11 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
bootconfig-v6.11

Tag SHA1: d6e58de171c4cf10dda1fe69aeb7f925ced1936b
Head SHA1: 0d9c0a67b14401344183cc0f8239f8d1851637fd


Thorsten Blum (1):
      bootconfig: Remove duplicate included header file linux/bootconfig.h

----
 lib/bootconfig.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


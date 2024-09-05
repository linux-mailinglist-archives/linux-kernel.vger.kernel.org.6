Return-Path: <linux-kernel+bounces-316197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4996CC79
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4CE1F2622A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BF199B8;
	Thu,  5 Sep 2024 02:04:34 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3DEAF6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725501873; cv=none; b=ssL8MSgHi0ZAqC5Tw9rFkqlLuj1I6Wa+mJmH6M+1fomiHY56uzW2OWt43Iwg+iBnuTXaxlu7BL9YL00kCNA1dAAX/v6fqb2dRRThtGDD6uzjcLFMC8C+Jr4z/W4v2XoxDHUyolN6ShoMsEpHf+dY7fdOCSjoCmPTnzUN4KBUxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725501873; c=relaxed/simple;
	bh=kNQ7Mwk2uf8a/cem3BgB8VQdIXbBlpCEl5nav2AgZuU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nuaETHwscMeL4rrRF0DjLaEBR4148m5hVtl6pSxOULt+UFfTlD0T9t4s2YZL/EBT40CEkQDCK44YONetMyaFrrip26nP/NrfjqIvuVd4o+56/85VW6O7ABsknAmhhk2I7xdt7TvJbC7O32XdpV9qrfgUKFbW2nyQIsRg2U57JfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 9AB00121752;
	Thu,  5 Sep 2024 01:28:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id F3D1220025;
	Thu,  5 Sep 2024 01:28:21 +0000 (UTC)
Message-ID: <61936c29ad056ac72c142600f6414c6dba0b6136.camel@perches.com>
Subject: Re: [PATCH 10/15] checkpatch: Remove broken sleep/delay related
 checks
From: Joe Perches <joe@perches.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonathan
 Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>
Date: Wed, 04 Sep 2024 18:28:21 -0700
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-10-e98760256370@linutronix.de>
References: 
	<20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
	 <20240904-devel-anna-maria-b4-timers-flseep-v1-10-e98760256370@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: F3D1220025
X-Stat-Signature: e3s9eocsos4hkafnmzabf7jksa1xqdqm
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19iqdq+YW0yNRdLs6+Z/wtiOZ75Pv8O6EM=
X-HE-Tag: 1725499701-653848
X-HE-Meta: U2FsdGVkX1/5YnpmdE7YF+haWSWsy0s9vqfaBoomJILktJfVbgNQKbc6Rr7KnvHDvZAGfwx6PiO2ydm4x7YspU6t8/KJ6LqyKwEPT0gwgOBjfygwZ7MZkMSFS5NQx8+r0RyrRjLpUxDrQ+3LYss6X6BsEY0dO0IEudpahJ0TnOCoQEl1oAGWYv852oA9D+1f4hatMh/FzdJM4/4xsSWqxqAk/AnjHh9t33o5eBkHyKdWoLucB8EwRG5/AmBYpQJ37RLFTXlNwzk425XOK/I288hhXCJquMu8xZE6b1wFm3aO1BPzsqFkdYyUYFhZfAmo0Dmj95c0CLybcARUprT84Fm0KfdmqBFU1TPibrT2DqHZ6QIuLOtWcMpmZiS/kygFVYkYjAKXfhcm67UL28Wy6w==

On Wed, 2024-09-04 at 15:05 +0200, Anna-Maria Behnsen wrote:
> checkpatch.pl checks for several things related to sleep and delay
> functions. In all warnings the outdated documentation is referenced. All
> broken parts are listed one by one in the following with an explanation w=
hy
> this check is broken. For a basic background of those functions please al=
so
> refere to the updated function descriptions of udelay(), nsleep_range() a=
nd
> msleep().
[]
> - Check: ($1 < 20)
>   Message: "msleep < 20ms can sleep for up to 20ms;
>             see Documentation/timers/timers-howto.rst\n"
>   Why is the check broken: The message is simply wrong. msleep() will not
>                            sleep (and never did it before)

While it might have changed, the "never did it before" is
not correct.

https://lore.kernel.org/all/15327.1186166232@lwn.net/

> Remove all broken checks. Remove also no longer required checkpatch
> documentation section about USLEEP_RANGE.

It'd be useful to remove the appropriate now unnecessary
verbose sections from Documentation/dev-tools/checkpatch.rst


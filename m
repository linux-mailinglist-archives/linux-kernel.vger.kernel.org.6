Return-Path: <linux-kernel+bounces-554868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C0EA5A2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5541895CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA35230D0F;
	Mon, 10 Mar 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kCXUGGLZ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707222576A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630969; cv=none; b=er4H79YZXuKgSZo00Q8j8SR7u8KyQ9FWLycJ8Ig8tN0+OiPeTkEtjLQ+ijc53lg4TIfXmq3Ks1eEGRkssL6j1WwIe3NQ/bT26CHQHyJq9vqlXezi3+HauuwT2YsTjM13NZ5Dy0ZWkzXXYFm/QVfUr7o7EbNFZ8/UkpasG2VU2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630969; c=relaxed/simple;
	bh=UmxXhTzy9h0qJSNTG7IlXLTwXqZI4SJ+MJycH8hMpnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Emcn1o/hoEb6Eu3aVjamB6eEbQX9yaZtpJzSGB4ERK3EVJ5DpSikxoM5O61/0Yq6ABDk2oDBnbvs3HPQ/iIHG6iAWryMk66b+YBIrdgyxXCL8RjYjGenqJrRBwlVSYvsnOPL7OmfngPQ01qOuOmhAaQW4OKI88GjviE+FmGLwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kCXUGGLZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741630956;
	bh=UmxXhTzy9h0qJSNTG7IlXLTwXqZI4SJ+MJycH8hMpnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCXUGGLZYhDrHiNj4BvA012LnKz+GcVZe/yZTR5zxmlvQwSJErFpE/q8mx3vIY58i
	 3yQrfiXW8tAD2FbWzbQr6DvoUvmWUAjqzGxHllGIIJ8vC0Rejd8sSPjsNHv064OIYx
	 a9O4cnj1mKJqpl/Dgk5ojwBbNUW3FZB+MwZUTlOE=
Date: Mon, 10 Mar 2025 19:22:35 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc changes for v6.15
Message-ID: <3598f2c8-e04a-4e4a-ae1f-db2201fff802@t-8ch.de>
References: <25e1c397-d554-4334-b344-56ec252564c1@t-8ch.de>
 <00c760a8-0075-486f-9456-63ae07ecb341@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00c760a8-0075-486f-9456-63ae07ecb341@paulmck-laptop>

On 2025-03-10 10:09:49-0700, Paul E. McKenney wrote:
> On Sat, Mar 08, 2025 at 02:06:21PM +0100, Thomas Weißschuh wrote:
> > The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> > 
> >   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20250308-for-6.15-1
> > 
> > for you to fetch changes up to bceb73904c855c78402dca94c82915f078f259dd:
> > 
> >   tools/nolibc: don't use asm/ UAPI headers (2025-03-08 13:18:27 +0100)
> 
> Thank you, I have pulled this in and will expose it to -next testing.

Thanks!

> Results from "make run":
> 
> 198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> 
> Results from "make user":
> 
> 198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
> 
> I don't understand the "warning" given that the "run.out" file has all
> "OK" aside from the two "SKIPPED" tests.  Or maybe I am just forgetting
> how this works.  ;-)

A skipped test will mark the whole run as "warning".

Maybe we'll adopt the kselftest harness at some point and align with the
rest of the selftests.

<snip>


Thomas


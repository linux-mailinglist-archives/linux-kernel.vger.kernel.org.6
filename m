Return-Path: <linux-kernel+bounces-291326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9809560E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53E72820FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727171B7E4;
	Mon, 19 Aug 2024 01:30:53 +0000 (UTC)
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6C9460
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724031053; cv=none; b=HwL1k5reG+NILRZ6BoxVjtv1Top7I7sEvIu46AckxiHQUai5AAyHD1tY+JocxFa9WcmoF3M9+P+mItYa0akiu8F4zNcDhc83FzII4jKn0Y4LN4WFTRrqyT896kl+T0NlHmLoFkzGjOmx8hynJYB0jLtrfEGWTecUqrONd+CgOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724031053; c=relaxed/simple;
	bh=Az1ikj8FMke32Q2EjygpX1gks2KxTTiz3ypYudTXThQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MjJLqJC8cOiyLH8ejllrIoBrToE1XfLJfD9vg9Bfe89twwbgMU9pGJF1xeq/oEwKXcxDG3EqxJoUqOWxd0HvhouUSe6umwoh8DMdYViZ5APT3QaDIiOXEMin1Go3qiRW+Oni/AoqSboVE9pbgy3LR2IcXmzAhVi0LKOrdTMy1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTPS
	id fqblsLwC4MArNfrCrsUbff; Mon, 19 Aug 2024 01:29:13 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id frCqsRhtqKHV8frCqsKkHn; Mon, 19 Aug 2024 01:29:13 +0000
X-Authority-Analysis: v=2.4 cv=XeEqz555 c=1 sm=1 tr=0 ts=66c29fe9
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=M51BFTxLslgA:10 a=3I1X_3ewAAAA:8
 a=VwQbUJbxAAAA:8 a=CjRulRUbs8e48-67pewA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VG9N9RgkD3hcbI6YpJ1l:22 a=AjGcO6oz07-iQ99wixmX:22
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 47J1TAWF003546
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 18 Aug 2024 19:29:11 -0600
Date: Sun, 18 Aug 2024 19:29:00 -0600 (Mountain Daylight Time)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: Eric Sandeen <sandeen@redhat.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs show actual source in /proc/mounts
In-Reply-To: <0798a2cf-b43b-4c17-94a0-142314d80f5b@redhat.com>
Message-ID: <alpine.WNT.2.20.2408181925400.3116@CLUIJ>
References: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net> <2024081303-bakery-rewash-4c1a@gregkh> <0798a2cf-b43b-4c17-94a0-142314d80f5b@redhat.com>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfMUhD4DzdNiqozECGVAsybWYZCNyISs5E3e07nZQfalyGDS91IfD9uyr3X9ck6TXyAD958vpjeGjpJrmngTcE161ik+x3eAsjfj3s6+1mfvjQpaBXsTW
 axxsCAH8uIxFHDxo2EfxdAu+qTxQftBkeVheL756OSlLA5JeWX7zV3zCbGWnNJ0Y+Bm12HcGQiUl+bvbuvtv+l2lUjV2YI6gtU9dAl3wRZihFhDY02sX4V08
 jBvAI5YNrc4814x8io5F0pXcdmT51M17zobaJzHGvJBZ2TcgmgXOPVUeF/YYpBeoTaD7DCj78TzKkV4fJ9zDPBV9e6VPYCim00bBsQ7bKrmg9kQ/iQQNrMhd
 KqtafFBk

On Tue, 2024-Aug-13, Eric Sandeen wrote:
> On 8/13/24 4:54 AM, Greg Kroah-Hartman wrote:
>> On Sat, Aug 10, 2024 at 01:25:27PM -0600, Marc Aurèle La France wrote:
>>> After its conversion to the new mount API, debugfs displays "none" in
>>> /proc/mounts instead of the actual source.  Fix this by recognising its
>>> "source" mount option.

>>> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
>>> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
>>> Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
>>> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers

>> As this came from a fs tree, I'll let the vfs maintainer take it if they
>> think it is ok as I know nothing about the fs_parse stuff at the moment,
>> sorry.

> Hm, I guess this is OK, though it seems a little unexpected for debugfs
> to have to parse the trivial internal "source" option.

> This actually worked OK until

> 0c07c273a5fe debugfs: continue to ignore unknown mount options

> but after that commit, debugfs claims to parse "source" successfully even
> though it has not. So really, it Fixes: that commit, not the original
> conversion.

> I'm not sure of a better approach offhand, but maybe a comment about why
> Opt_source exists in debugfs would help future readers?

Meaning what?  I'd say you're in a better position to explain why debugfs
shouldn't follow other fs's in this regard.

Marc.


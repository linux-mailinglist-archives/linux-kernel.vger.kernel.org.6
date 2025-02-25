Return-Path: <linux-kernel+bounces-531618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CB9A442C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F9467A644A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B8269CF0;
	Tue, 25 Feb 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="Urj+lX3X"
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2626B09C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493646; cv=none; b=qU7TOhOwEmAPqrX7xYOh9Usd0TZ8lvyhN8B5/QiR7lo3rytuCV7ej9pD1iaFWadUQynkTCawSmCwLl3d7C/jjB7ceyJVmXu9TAt+6D04EZ3RzC/qO+V1W9DMOgcbt4e4dxhtI6GVNa+hC8HK9hDwvkfg8SLRue8wATa0kHKjHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493646; c=relaxed/simple;
	bh=Q1PAwSYP5N2acovyf6NbSeLosza1uVnYcw4+mKEx22I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uq2zkhhOIpGo9NN+MEXxueSHe+5lATWGEKxp0iBoFMjNxL8bRo0+ei8fT6T9iDkjzNEC+uCP22ubgeVMTMeWeWP0/zhoeNl3RXY7aFr53jPczlsy6JC0cvx/8SbSCjbsPIVNkfIRNQm9UHJXgR80RCEBE8NdXPUjzHjYh0uk0s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=Urj+lX3X; arc=none smtp.client-ip=62.149.156.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id mvr2tADX4S934mvr3tLfyb; Tue, 25 Feb 2025 15:24:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1740493453; bh=Q1PAwSYP5N2acovyf6NbSeLosza1uVnYcw4+mKEx22I=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=Urj+lX3XOgoF5r8UyKJBnvytqgZFIgFAle77rggZzJ1TVO9ak/r1fU30m5kRCeoD5
	 Ug8ms+xEeAhPoCxvAMWp7Pp6gBqPtkUj8UkcRrvjZgZtMsJXQRR7a6E7fhOITQkXtB
	 ko7jdVrJupKCxEB7onDWPrTG5oWfvH++dHPFMbicGUXy07R6JCbPgHrA/31YOzJT+e
	 U74vwUjiY3QY+G/Tcuqyx45KcdEZ3V4yWpeM9QlJu4aYRJb92pRVjyYuxo2WwDfuUZ
	 lgAD1pNcJOtOLwNbV3P9KAPW51fX/0+9+ugBNuToYwPIBeMXjDp8M4LyAy/vBXGgt2
	 v20VRmZEJY75g==
Message-ID: <a0f5aff2-3437-4b70-baa0-fe1555ec81e7@enneenne.com>
Date: Tue, 25 Feb 2025 15:24:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: add epoll support
Content-Language: en-US
To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <05ac823e44504921a6e864fe6fb283d6@diehl.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <05ac823e44504921a6e864fe6fb283d6@diehl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMus3A2SkhhuTmS+mVuI/mlCoA2xpL+S4kqrUhYYapOtC/S+ulAzxwrjoRGj80n0F6Y2OK138lqLQoBcuYfnnMQV2WXPal4YPg44Tg6tgXjzw8rju1p5
 s2+lyI9s62C2Z+76mxhZq+Gz8nq+V7g+AFh+L6e5MdP0VWND989FZhLEz+NH+17yQZ2fQK5eywyOEPu877OVS8XPsxOwHGJeHjG3EDos6I3nMODqnPcBNg5D
 gfoYssdUOjVKfnm3bg1irA==

On 25/02/25 14:39, Denis OSTERLAND-HEIM wrote:
> Hi,
> 
> I fixed-up s/pps->fetched_ev/pps->last_fetched_ev/ and tested it.
> 
> With one process it works well.
> 
> ```
> # cat /sys/class/pps/pps1/assert; PpsPollTest /dev/pps1; cat /sys/class/pps/pps1/assert
> 1520599383.268749168#29
> assert: 29
> time: 1520599383.268749168
> assert: 30
> time: 1520599384.292728352
> assert: 31
> time: 1520599385.316788416
> 1520599385.316788416#31
> ```

OK.

> If I start multiple user space programs data races are visible.
> 
> ```
> # for i in 0 1 2 3 4 5 6; do PpsPollTest /dev/pps1 > log$i & done
> # sleep 6
> # tail log*
> ==> log0 <==
> timeout
> assert: 196
> time: 1520599554.276752928
> assert: 197
> time: 1520599555.300692704

This is the same behavior we have when working with a serial port: if more than 
one process gets access to it, data is stolen.

>>From my point of view it would be great to fix this bug without such an limitation.

I disagree, it is not a limitation! It is like a normal char device work.

What we have to test now is if your initial goal has been addressed! That is, in 
an application that has more to do than just dealing with one PPS device, we can 
use poll()/select() in order to avoid using threads.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming



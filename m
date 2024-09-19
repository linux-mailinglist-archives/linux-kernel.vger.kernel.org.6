Return-Path: <linux-kernel+bounces-333122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAE997C428
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88F828325C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947EB17C7CE;
	Thu, 19 Sep 2024 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="aCFxzc/o"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981B17C224
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726726213; cv=none; b=jGa+1HeuGhqkNlP/BKS7m6Cscm2RT99dfJqX+0X4hSpy0ZiJoXgVaDpNmXYjHrDiXkOR/gOh047kq54sV7IQm3DHR5Q1/r2tHnGpXQeiBa8Yxz7jHY6IpR8nZW2BO4ealFKavxM5rHESxQ/DFLlojjNSe238RyQgRihF/fL27bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726726213; c=relaxed/simple;
	bh=BO1wYNJnaESUGIUwV/ECvxyO2g6zYEmyq5UCy8kYrgM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=piMspogeOF6OEX6nkLMKqELp4EEWYM7r7nzbsxPQWlQXsdDNktXgo1KIZYqjL3VYk6fLC8u/LbgCI4+A2D9UtAXXxn2q1tDO0au8u3GYHGeMZ/GZYH71L+GMimMofQP2luBkPGp3rHFALCjYgnjVkPfC3pt1/fdGx01lF7vk8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=aCFxzc/o; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726726189; x=1727330989; i=efault@gmx.de;
	bh=LJb5IgePZ4BgrdGP9a6NUaWhuwLLTGAN/jzME6Q2d6A=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aCFxzc/onYj6Q2SQ+7HbDo+qWKWNtDBRKEc16wA3v3YMUfnFjfDhdmbvQty+yV79
	 VE0Ukzbi9HUrt9Tm6FATyKLj8yif/6+nnorvEmqUqA6MSK4PfzIkxxVMyUcuNdZ9w
	 It4vlHnbfYhPEUfWmuOGuZk5x71e9vyBEYJcBJf98d/K22+EZHc6PKUpdeKEXxOM6
	 u3tfsVppI4EAS5jFx7GCZv1vm7uT1xrblLQir0QXiYUez0ldRU0lNy1HAG6qCfXGf
	 6o/GNdI4uy5buvi3F5J9TQGBTCBbvsg4q94quFsB8Vw8ku3VpdfU2sXuNd/Tjbw/l
	 KO9CiX6IlUfLgr5r1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKFu-1shqxC3d6g-004GNr; Thu, 19
 Sep 2024 08:09:48 +0200
Message-ID: <2fb24ab402d9de45e3cf16e6ba0ad23a7843e5c1.camel@gmx.de>
Subject: [patch] Re: [PowerPC][Linux-next][6.11.0-rc4-next-20240820] OOPs
 while running LTP FS Stress
From: Mike Galbraith <efault@gmx.de>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 peterz@infradead.org, vschneid@redhat.com, mingo@kernel.org,
 sfr@canb.auug.org.au
Date: Thu, 19 Sep 2024 08:09:47 +0200
In-Reply-To: <82b9c434-a0fd-4488-95be-a45b8cd4b6e6@linux.vnet.ibm.com>
References: <82b9c434-a0fd-4488-95be-a45b8cd4b6e6@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zXiz7bdk1O2092M+28wKsKOHNyhGwevFOgeHjWiyixY3kKbkF80
 q7f3jlBj+9u7JO6xwYWvhE7kaUeZxkf8JlcgwnNgFDoO9UY11S1Edb+4jGnS1KE+wgd0wB6
 pPLUV/aRLuksGSrm1dAQX7VWS8gyHsmugR3ml5/qrSO0psnhlsrz7gOvpw5fB7y+S92AZ8+
 jBnk5qcFCvDawigeur35w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z+Nj9qTZJMw=;wD4o8hBW5Z64TPZupDGKkXPTG1G
 kimdlcaS0RmmJaMxqu6iI5Gf/lmynmPnYHeugXSz7sJKMK1J94u1JxrGOLladWJ+qHa8zE7GI
 yj4ETh39AyOuXY0MRvEy5DAcGtpDMsZQHGb0P4v4qcBrHkZ/N2n+8pF4kR12pNvisVGXqJrbx
 AogthJbBcWoOuhMEnyc/m+WZs+hOvKJERm5lklAMjjqzmgdM9fSlKOj2UBCDpjHoIEdVHx+dk
 oYuVK1L96lCHlCfcKObFi+1dOKQ8An2THzExonzFsMevFJIkUKKfSfgAxePYIsv61fHLhm067
 jggkVFprDWjRNV1QGHHB9ld4xlARXlFO/11e7xjctwitXkT+hOKrFYbnhwurTo43T7anXKchI
 gViLFwTmfM6GVsllRZbSSfHRIzP+3x/nkyIKWfqOGt0L4OWT00dA5atl3+6DKpHsBkdnAP4GB
 8TJUb4qYH8L4mmNT6DxxRqXwsbgoA+ks8G8jgXyBp6JYSBHkOui3vBJ3dc1IpLixTbVD+5ZAZ
 qiLzEDlIa0L6rRIGCSqdBZYQ4FMpwzt6ASitigP4T5fcOdYmdxN5jUpzrhFxxpFYIL7P/40qV
 AD//q9u4V2iyjfX1V7vJkoyxy3azW5suTMYiqSUGMCMNE1AU9x8CSmn0zURo8eC8LNF3A0TMP
 mE4nlFHw5M9mLGCJ+6FHI2W1t5KSy92TaAUoQIDHJo6dFzNZLLMXd6xiQV0X+CGi0jb1pCwUd
 NdHCX3goTuRanl/7qDPYmN0GYam8JF4iL0YNSWfUxlZ/MfoXKW2D9pFD7e58mr2C4/MgMo538
 7DZW6fbtNepU6myjrvcvLqUw==

On Mon, 2024-09-16 at 12:00 +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!

Greetings,

> I am seeing below kernel crash from 6.11.0-rc4-next-20240820.
>
>
> Tried to do git bisect, but it didnt point to right patch. Attached is
> the bisect log.
>
> Any help in fixing this is much appriciated.

I met this, as well as other ways the wheels can fall off that turned
out to have the same root.  I gave Peter a heads up with diag offline,
but having now convinced myself that all is well, I'll go ahead and
post a patchlet.

At the very least it's worth putting out for wider testing.. and should
anyone have something prettier in mind, yeah, do that instead.

sched: Fix sched_delayed vs cfs_bandwidth

Meeting an unfinished DELAY_DEQUEUE treated entity in unthrottle_cfs_rq()
leads to a couple terminal scenarios.  Finish it first, so ENQUEUE_WAKEUP
can proceed as it would have sans DELAY_DEQUEUE treatment.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/sched/fair.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6049,10 +6049,14 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);

-		if (se->on_rq) {
-			SCHED_WARN_ON(se->sched_delayed);
-			break;
+		/* Handle any unfinished DELAY_DEQUEUE business first. */
+		if (unlikely(se->on_rq && se->sched_delayed)) {
+			int flags =3D DEQUEUE_SLEEP | DEQUEUE_SPECIAL;
+
+			dequeue_entity(qcfs_rq, se, flags | DEQUEUE_DELAYED);
 		}
+		if (se->on_rq)
+			break;
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);

 		if (cfs_rq_is_idle(group_cfs_rq(se)))



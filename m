Return-Path: <linux-kernel+bounces-215495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F089093A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702431F231C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB21482E0;
	Fri, 14 Jun 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH2KlBwT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D413A24B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399985; cv=none; b=eHXiuSSLj0knHMdIdbOinb/DXuFMTICQ4TteSyYK1ELRxgnyEtgLqB2c1ilurgy/iLqnzpLuv0yIIKbNWAUBkMq563uccByn/ky1tajem+/UrWPkoZRwN2yqoTejn9w/Bqt9FYNa8/T6lmfmTp5yzKPcL5sByT6MnrvJEwDfqY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399985; c=relaxed/simple;
	bh=2b7mYzRP7g6ajoPiM+/Nr1RGGYWsYfrbwO7Iesz242w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VkjnYblLXwkO5o4gxlK6HcUp+vq81ASk5Xj/+FsUQg9o3ym7uLw/lv+l1vm0gJVXpoafQle8SbAQ4L8M9H65H/GrkSEAZTSGFdLCO619XAK5EfFFR11QBXEPkBvRKrQfPrE+WcioglpO0qX1Ix3dDR327doyk/z0oz5ic9jWZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH2KlBwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C22EC2BD10;
	Fri, 14 Jun 2024 21:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718399984;
	bh=2b7mYzRP7g6ajoPiM+/Nr1RGGYWsYfrbwO7Iesz242w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KH2KlBwTp+iVyVOCf8bMm23ZapL9fp/nms3Y9gGMcziI+SMdILIF6Qyowne51KyE+
	 83lON8jfLMMeY/BpfVee9BQ+l2nHYG57p3lMQSVnwS9TSBbXJlPFDrf+hE1Iq+2rqz
	 4YHnGRxIJXyV4aAqyOoBFMRO9myGwrG3FmiVAdiSGyY0uijki5GgS8NqOEFtwAEary
	 NzAi11yIceax6Ulcx0qOiVpynpu8OObs4sMRr2ZncEzB41NbabfDct0WkITg87KB01
	 SEtbXlJccY85k3M3GdPKMImojf8HfQQ2hC1NS/8yWkp8CN/B0l4XNb/Mw9a3UjfFuj
	 KU9lcz0HMR7/g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat reminder and extending for office hour
Date: Fri, 14 Jun 2024 14:19:41 -0700
Message-Id: <20240614211941.90026-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240519163329.150340-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Sun, 19 May 2024 09:33:29 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > meeting series for DAMON community.
> > 
> > Important links and dates
> > -------------------------
> > 
> > Location: https://meet.google.com/ndx-evoc-gbu
> > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> 
[...]
> Firstly, I will regularly provide reminder of the series, probably 1-2 days
> before every instance.
> 
> Secondly, I'm extending this series for reservation-based office hour.  That
> is, I will reserve my time for 30 minutes every two weeks, keep the schedule
> public, and encourage people to reserve the time for discussion on a special
> topic for them.  The reservation should be made at least one day before the
> time slot, and will be first-come first-served basis.  In detail, I will
> reserve Monday afternoon or Tuesday morning of the group chat scheduled week.
> Note that this is not necessarily only time slot for such discussion.  You're
> still encouraged to schedule private meetings on your convenience.

So, yet another reminders.

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-06-18 (Tue) 09:30 PT (not yet reserved)
- 2024-07-01 (Mon) 18:00 PT (not yet reserved)
- 2024-07-16 (Tue) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the discussion.

Any-topic discussions
---------------------

Next two chat instance for any topic (no reservation is required) are scheduled
as below:

- 2024-06-17 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-07-02 (Tue) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)

You can also get the past schedules and upcoming chats any time on
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ

[...]


Return-Path: <linux-kernel+bounces-263954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EDB93DD16
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392C31F2399A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65424C9B;
	Sat, 27 Jul 2024 03:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXnJmNVU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B384A05
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722050745; cv=none; b=g0v+mbBipPIJQmtn7stqfsGlOa2yjQrQG+zcUu3nKc8QYlzyhajO0g3pKzG3NyilwFldx7MWBhBKydy7zjaZfEjDuJxK1RL9HpNjWUTw57mBxwAYJpjng9/YN0I6cw0XgyABt9cGyi3rjl4TuEr22z69wrovP7vt0rHQCjU56wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722050745; c=relaxed/simple;
	bh=w91TPZxrPsLeGlqQhW0PLg/jt9TLaAwIo3cgRjJDId0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alD//gjNHRqXK6peNZlV8bClv7DmgD21JKeRpPOpffaNnN1xdj42iqy2XjWq8Jt4ZHtaVau3P8KXdlOzsdObNzUMLj2eYE4Z0Cu8m49diSZY/oPCKb6gAgT3gjKmz8s1KQXK3W9Mcn+Nk4zToE8p1IBwZTbIYhGgqkpSwhAm0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXnJmNVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65736C32781;
	Sat, 27 Jul 2024 03:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722050744;
	bh=w91TPZxrPsLeGlqQhW0PLg/jt9TLaAwIo3cgRjJDId0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXnJmNVUzTa2/THaMDB+O+XHDPW1Uvfrm9w3kiaRn6s6vnvRCz8jNH0JG/8R3g8KK
	 uKqaClfuehITn6N9CSomcqqWgWbT12iDvXj3syrhTlUNbrj5e4KNJLtqnh8Ajo9Tez
	 5jmB0MPP0W+NZt67aaNKKuR0mXvzb2+90/XHC7kgk/e41+r4V73u1IN5tucMLSyfLw
	 er9q14gjURPO8rL+gQRGAS5F123pHWaWDJgxBMy+hG3u0gZO7LAY6EjHEFnhvX3M07
	 PXGKXWlsQvyXIt1a2Tag9f1MUJeJMh9PxOxRQwrw9wIe03X1PXEiuKr0R/6dax+sFV
	 xrLGPVyYHJTQQ==
Date: Sat, 27 Jul 2024 03:25:42 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: liujinbao1 <jinbaoliu365@gmail.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, liujinbao1 <liujinbao1@xiaomi.com>
Subject: Re: [PATCH] f2fs: sysfs: support atgc_enabled
Message-ID: <ZqRotoF2iDcx2MZF@google.com>
References: <20240221073249.1710026-1-jinbaoliu365@gmail.com>
 <a2bf5d3e-6727-44d7-b1a0-3b1bcc7edad1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2bf5d3e-6727-44d7-b1a0-3b1bcc7edad1@kernel.org>

On 07/26, Chao Yu wrote:
> On 2024/2/21 15:32, liujinbao1 wrote:
> > From: liujinbao1 <liujinbao1@xiaomi.com>
> > 
> > When we add "atgc" to the fstab table, ATGC is not immediately enabled.
> > There is a 7-day time threshold, and we can use "atgc_enabled" to
> > show whether ATGC is enabled.
> 
> Oh, I missed to reply on this patch, what about adding this readonly
> atgc_enabled sysfs entry into /sys/fs/f2fs/<dev>/stat/ directory?

It looks like not stat.

> 
> Thanks,
> 
> > 
> > Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> > ---
> >   Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
> >   fs/f2fs/sysfs.c                         | 8 ++++++++
> >   2 files changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > index 36c3cb547901..8597dfaef700 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -564,6 +564,12 @@ Description:	When ATGC is on, it controls age threshold to bypass GCing young
> >   		candidates whose age is not beyond the threshold, by default it was
> >   		initialized as 604800 seconds (equals to 7 days).
> > +What:		/sys/fs/f2fs/<disk>/atgc_enabled
> > +Date:		Feb 2024
> > +Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
> > +Description:	It represents whether ATGC is on or off. The value is 1 which
> > +               indicates that ATGC is on, and 0 indicates that it is off.
> > +
> >   What:		/sys/fs/f2fs/<disk>/gc_reclaimed_segments
> >   Date:		July 2021
> >   Contact:	"Daeho Jeong" <daehojeong@google.com>
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 417fae96890f..0915872abd97 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -143,6 +143,12 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
> >   				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
> >   }
> > +static ssize_t atgc_enabled_show(struct f2fs_attr *a,
> > +		struct f2fs_sb_info *sbi, char *buf)
> > +{
> > +	return sysfs_emit(buf, "%d\n", sbi->am.atgc_enabled ? 1 : 0);
> > +}
> > +
> >   static ssize_t gc_mode_show(struct f2fs_attr *a,
> >   		struct f2fs_sb_info *sbi, char *buf)
> >   {
> > @@ -1017,6 +1023,7 @@ F2FS_GENERAL_RO_ATTR(encoding);
> >   F2FS_GENERAL_RO_ATTR(mounted_time_sec);
> >   F2FS_GENERAL_RO_ATTR(main_blkaddr);
> >   F2FS_GENERAL_RO_ATTR(pending_discard);
> > +F2FS_GENERAL_RO_ATTR(atgc_enabled);
> >   F2FS_GENERAL_RO_ATTR(gc_mode);
> >   #ifdef CONFIG_F2FS_STAT_FS
> >   F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> > @@ -1144,6 +1151,7 @@ static struct attribute *f2fs_attrs[] = {
> >   	ATTR_LIST(atgc_candidate_count),
> >   	ATTR_LIST(atgc_age_weight),
> >   	ATTR_LIST(atgc_age_threshold),
> > +	ATTR_LIST(atgc_enabled),
> >   	ATTR_LIST(seq_file_ra_mul),
> >   	ATTR_LIST(gc_segment_mode),
> >   	ATTR_LIST(gc_reclaimed_segments),


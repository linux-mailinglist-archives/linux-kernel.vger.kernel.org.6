Return-Path: <linux-kernel+bounces-377796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322709AC6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2072B23927
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ACE197A8B;
	Wed, 23 Oct 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HLcWtUe6"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8037136357
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676825; cv=none; b=PbvbpxHoLQg6fv+w9BbMCTq8fyE1bysV6BhXadz/8iuu7PBG0MBZ0sso2atUkD2Rmv3Q+MtjbQUDmZ1J3mMGN1rkbD4hkRm/xathrLnDTccf9C6A8EnTCMD/CoOjhkZaKjXVueyfjitU3utPrgmY2/X7Q3Z6AUo9uvGcFAgCcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676825; c=relaxed/simple;
	bh=0W4sJD9AsasfHLYs59lV1xrUyt7o4Es2ghUZ5Nacg3k=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=WOb5QlwFQ+F5idBJduqMEpzxH86k8xuWPhpp+5OZJbgTvzsBE7ziXevM+AyoSQdsdbgcSB+tvaVlhy1TnPvmaQcQsxw9llculReOyk30IjMy56qfG1DDyVB52kQ/JQ/2mcZj0HitKPjS7c3ZYA00vj3ArcHaL9ZxFWv/jpxwin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HLcWtUe6; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241023094654epoutp03a03b9c1572e271c0e6ee553fd4e1a817~BC_YH4XRs2180121801epoutp03E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:46:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241023094654epoutp03a03b9c1572e271c0e6ee553fd4e1a817~BC_YH4XRs2180121801epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729676814;
	bh=bGpLoC3knzXadOWZtYKaVuF5uOI+14bGyUxz/W66kSI=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=HLcWtUe6xdWIfIfYobiGVYo6946fEOIVr1vHTfa9SmRWQzhkW+yWwnTzh+lO1Shaw
	 lACQdbg+eOiWLX6ieMtJ1ChtFbr8RvYmhSUa1PQxz4sCn8WHKTy5n6Rj47kT3++RTK
	 kjHmyJ/WzvKPApUVi3Jc9hqR24BoSUFCYngbbt1Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20241023094654epcas2p2ce40bff90e6e03b8a12b5d9b0e542a11~BC_X4DF5I3068730687epcas2p2G;
	Wed, 23 Oct 2024 09:46:54 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.91]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XYPMd4XTZz4x9Q8; Wed, 23 Oct
	2024 09:46:53 +0000 (GMT)
X-AuditID: b6c32a43-7b1b87000000216f-f3-6718c60d579a
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.54.08559.D06C8176; Wed, 23 Oct 2024 18:46:53 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [f2fs-dev] [PATCH v2] f2fs: fix to avoid potential deadlock in
 f2fs_record_stop_reason()
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: "chao@kernel.org" <chao@kernel.org>, "jaegeuk@kernel.org"
	<jaegeuk@kernel.org>
CC: "syzbot+be4a9983e95a5e25c8d3@syzkaller.appspotmail.com"
	<syzbot+be4a9983e95a5e25c8d3@syzkaller.appspotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, Daejun Park
	<daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20241022083623.2641434-1-chao@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241023094553epcms2p1c4b830a99a1f6b10cba8fd9bbcd8e2ac@epcms2p1>
Date: Wed, 23 Oct 2024 18:45:53 +0900
X-CMS-MailID: 20241023094553epcms2p1c4b830a99a1f6b10cba8fd9bbcd8e2ac
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTVJf3mES6wbMvShanp55lsnh5SNNi
	1YNwiyfrZzFbXFrkbnF51xw2i7+7brA5sHtsWtXJ5rF7wWcmj74tqxg9Zr5V8/i8SS6ANSrb
	JiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoBCWFssSc
	UqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaF
	DTNYC5ayVNxq2svYwPiAuYuRk0NCwETi/5ylTF2MXBxCAjsYJZ78fgzkcHDwCghK/N0hDFIj
	LJAusbBpMguILSSgJLH+4ix2iLiexK2HaxhBbDYBHYnpJ+6DxUUEQiSa7jaxgcxkFtjOJHGz
	+S/UMl6JGe1PWSBsaYnty7eCNXMKmEtM7N7BBBHXkPixrBeqXlTi5uq37DD2+2PzGSFsEYnW
	e2ehagQlHvzcDRWXlLg9dxNUfb7E/yvLoewaiW0H5kHZ+hLXOjaC3cAr4Cuxt+MKWJxFQFVi
	++dnULe5SDx8fRzMZhaQl9j+dg4zKEyYBTQl1u/SBzElBJQljtyCquCT6Dj8lx3mw4aNv7Gy
	d8x7AvWhmsS6n+uZJjAqz0IE9Cwku2Yh7FrAyLyKUSy1oDg3PTXZqMAQHrfJ+bmbGMGJUct5
	B+OV+f/0DjEycTAeYpTgYFYS4VUqEU0X4k1JrKxKLcqPLyrNSS0+xGgK9OVEZinR5Hxgas4r
	iTc0sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoHJ6jnjsRzV2Fdf8uY+
	6PuuGaCvmBJT4eBp/DpozYtrDX8u39lvK2bj6vOm50yXZsex5vQ0JyffrO/X6xmFjYS+ZjkK
	PPwVeVEtIK25kGFLWHfPt8PP9z61Lsjasyuv41n9TYklE7f8tNsolKPHp33vzarg4M8ntl3u
	/yLOnN29PXbZ+1dSkudm7Au/zTshL/Sf7frMJ4cNKj7ejzA1eX3hEc+ed+knt/28WdI981Gt
	r20UD1fL1tpDnY118/sTXoUuY5M+dOn3OpFmv7lxLrWlD0LOWX+oE9CyvzlhD1ti4xKTX5Mk
	WdW+1HB8TcwNzijqMb9ToxOd/vKrq8ylbXpOx+rSX4i7sZsZfQ6Zwq7EUpyRaKjFXFScCADi
	gECHFQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241022083741epcas2p3f9ca0827f9501134124fd47979e70cbc
References: <20241022083623.2641434-1-chao@kernel.org>
	<CGME20241022083741epcas2p3f9ca0827f9501134124fd47979e70cbc@epcms2p1>

Hi Chao Yu,

> ...
> 
> Let's always create an asynchronous task in f2fs_handle_critical_error()
> rather than calling f2fs_record_stop_reason() synchronously to avoid
> this potential deadlock issue.
> 
> Fixes: b62e71be2110 ("f2fs: support errors=remount-rocontinuepanic mountoption")
> Reported-by: syzbot+be4a9983e95a5e25c8d3@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6704d667.050a0220.1e4d62.0081.GAE@google.com
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Daejun Park <daejun7.park@samsung.com>


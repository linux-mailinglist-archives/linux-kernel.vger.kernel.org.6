Return-Path: <linux-kernel+bounces-297691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B720D95BC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB41F2320E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C71CDFBE;
	Thu, 22 Aug 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="geUY00H6"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809E1CCEF1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345900; cv=none; b=YAcqtUgK3EZZrGfXwpj+6RRIVyuqXvhxGd945rUSw4LPYYs2njRZ8V2HsgpRaBZPSVGkrhikJVVDXs2qkP71qbbKdX1VYBF0MabSQXAVd9xwNtOKTkBQ237oBriomxTsxqqZlV1vXHszKuNXYTVge7/7bAlvCjFZDoLPzb1umiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345900; c=relaxed/simple;
	bh=w3DZMlNp/ocxUtUd5l96XlZJQwqZyykgScZAlCAdsGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzOV+Mc7N2zlX6IDT+VnIWV7IjiX5edReS8fPF2jk4RHi4cem9BK1PXNU84qlLcZTVzbwho4Zsi2HJbmUklCJIXmHFB+Hxsy35Mgy5hWi8joJPc+rvdvb3LE/nPWXFUUZLbErJBeN0tJ38GS7YjvZMqR5alPh3pDncLIj20rU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=geUY00H6; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 12:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724345896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3DZMlNp/ocxUtUd5l96XlZJQwqZyykgScZAlCAdsGM=;
	b=geUY00H6OOzLfLQa9C0ULSDGapuYVIiFFs8oqMf/0+55Vx+4k+PqSv557x9TC2xaD3FT/i
	qWB1bI82uAZ36OEctN+50RgxAeZoOXnOU4hyJzQCQboVvvLuW4tJd+rtRer65KtmpXMkH+
	xn+YJj8oMitS7KmRBfNSzaJeLrqy+qM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+2c4fcb257ce2b6a29d0e@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_journal_replay
Message-ID: <taxrdom7abx44rzbiklsmtvn7ha5kahzrufb2xipwbpgtx6o6o@wmx25d64tz6p>
References: <0000000000005bad63061a89f2a1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005bad63061a89f2a1@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix replay_now_at() assert


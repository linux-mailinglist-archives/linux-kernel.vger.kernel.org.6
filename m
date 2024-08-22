Return-Path: <linux-kernel+bounces-297693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3471495BC92
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629871C230FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54E1CDFBF;
	Thu, 22 Aug 2024 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WGmpPqUl"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20461CDFA5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345974; cv=none; b=iUOiVOpAV7SXo6pEl1AcgZskdROIOlpjeJxz7lqVlWBzZ4dV7sTGAAa2Iec6w5q3QrUNF9S0bMJOkY3yhzBm1BesJfWDvqo7IzLnZypQ8eNSCWK8YyZgt+gI/LaRoIMEtmVHsKxvfKIuy9bVoJzfgH2GUhtrKuq/WcKQxVEMVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345974; c=relaxed/simple;
	bh=AW++XKit1WHfeU58FY8eMWTsW+yYqpgpPrvGly/aR+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=styAbbnUufw7/neG5y+rqIETtrpIXb9qFbUYoBFHCu9wz/vm/OUYj2m3lTL5D8yG6/IystioQQ+Sw83ERhqWHFNcdsVynhlsVOj5kTonzBW5AsaI88I6Pxa3YC/A0kFuSe/rW3aRZhcECCWf81WioJo+W/OGuBYrEYFjsBbeVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WGmpPqUl; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 12:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724345969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AW++XKit1WHfeU58FY8eMWTsW+yYqpgpPrvGly/aR+s=;
	b=WGmpPqUlieeJLFRWGMNic5Qoi/PkXH8JAgd0DDnL2g4lgnIzopg8Xex/8Rtx+sm6TrM62D
	lmkYwiJ4IhNITObTy2Nk005fUNgnjh8aGVtpZujjtDprw2bx+ldy2SihDWUWcx8jihCMlg
	eY3aYfBWDiBLKS7sJqXrNQNpJEIY5Us=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+4093905737cf289b6b38@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_journal_stop
Message-ID: <gtlnzycgrdx7ovjq3noy6tgg2kc23yu7id7cenbt6tkm24tloj@nlr47dbh7n65>
References: <000000000000a7d8f1061d69ebd5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a7d8f1061d69ebd5@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix warning in bch2_fs_journal_stop()


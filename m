Return-Path: <linux-kernel+bounces-297696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69D895BC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854642871CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6175B1CDFBF;
	Thu, 22 Aug 2024 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fbxplzCE"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3B26AC1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346015; cv=none; b=JnFRZ7IMuJo67PzsKAa6vJLQRG45sg+s+LnSz1bUb9O0tWk4UhQ+MMfDfQYisrpO88SLzwdj35BbTZ/wJT+2GNC6nGNPB0EX3jSDkXUeoEMG8m3Cr3zVpuhIRSRdj0jpfKZ/QhuBQ1DtlPwV6qHlC51LcxPxEYtbCAHBUB6gsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346015; c=relaxed/simple;
	bh=mr/sX7umIb1NorFxFJyX6FmPcEyAvkaZm68pgAWCk7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8f/ZT8m7gWrsGCf3alPiQa8n1BY7wkTcK52rBeWqN2/Vnarj637jYgz2/gMpexUs4A/wuC1L1Ag50G6maQ82I2Mwtmy+5LwU7Ag6wCsW33WeYr2Z/uNQ9x9stujrpLdIetRFQFflcuXUDB+eHLUbROjWnH/UwBl6OKVZ2+bN0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fbxplzCE; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 13:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724346011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mr/sX7umIb1NorFxFJyX6FmPcEyAvkaZm68pgAWCk7w=;
	b=fbxplzCEMKqXnF3Dpof48jxmQuRtZ8PstcxcYZldd3EoeZFRnhINJobC7ic8zEsz2WkU8A
	GIQyseXp1ip3wF71RrO8KfZpeIH+DujnyekPTROEaPquuIpoY9b6HCL5h0UEtQ2/FeIVBK
	MrHSIinRH90VgMOYfqbS2daNBGBCudI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+10b936c5eaee2819b49b@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_fs_journal_stop
Message-ID: <maqwa4yt2u62dbiyqvozfjplxlafrcwqqmvibnjoyazjqqzrsx@tudwer627hm4>
References: <0000000000009bc5fa06185a064d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009bc5fa06185a064d@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Change bch2_fs_journal_stop() BUG_ON() to warning


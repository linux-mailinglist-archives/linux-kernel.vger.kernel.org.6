Return-Path: <linux-kernel+bounces-290090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAB4954F48
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD68B289D47
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9B1C0DDB;
	Fri, 16 Aug 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XsGPhToj"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D56B1BF337
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826779; cv=none; b=c+rE2oGgC2NWDoyiJdbeF+3pxdAdFXIkXZsA8btN++K2pD+8H3zIstuf9PY5Uh/S3jHrqn4hRmw5XZx1mXrtWy29mZ1RrXBJNqNA7v3UfWH3UYB6lhhfqBh+OqFn+rJqjHcAt8tKEJsKwSMisb2SdZj1tsT0okA8x+ubQpav/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826779; c=relaxed/simple;
	bh=bU2IaS/hTCl1NmYRI7l6+I/h8qUdzwaDtTWZRiPJI+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPJDwnvOEvakUzUiSq3sSa0XytKI7KINfEVh54cAVoGEB6q6d5u279/R4OoUg8hWfCHJz26JNf3iCFMxyf1SBupxrh/zBKJoo+HKFkbgC7qYJrsy6FtIbjePA8cFGWpjU8q1dY4quGo31MPbFt5k8dARSUcxFTUsEswzLkyVLDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XsGPhToj; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Aug 2024 12:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723826776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bU2IaS/hTCl1NmYRI7l6+I/h8qUdzwaDtTWZRiPJI+Y=;
	b=XsGPhTojZfgEcRScZdykGS1iezva3QytiyTJtqHPtSXTW0BCamxSOI3Ob1ga0B82BZ8SVQ
	BroytceydKLC2qFteS6xEldn4hVCR20SDVdaZ6a6hN591z7zJnAaXBXW7d/duEu0Q95HDF
	mIN1aY9Xx0n1aTjG0O4vHKbVjRobP34=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+95e40eae71609e40d851@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in discard_new_inode
Message-ID: <g7rfawl5ehyevqoz6rscvf6wew5l5ds2bn4mfapivv2jtkrk7b@ytj5eldr43cu>
References: <0000000000005bb657061fc9e31e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005bb657061fc9e31e@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs fix incorrect i_state usage


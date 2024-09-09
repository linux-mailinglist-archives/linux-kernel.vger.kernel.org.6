Return-Path: <linux-kernel+bounces-320614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3612F970CC9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97531F225A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D9B17277F;
	Mon,  9 Sep 2024 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="bN8OB00/"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E83136A;
	Mon,  9 Sep 2024 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725857298; cv=none; b=GKeaaXXi4tYdjBelMYPLgV1O8Y7tn1GWRigb+t16apo+OLQsvBj/z+mdtNnYwcvvgy8LXOvRPGFnwgqtNfZ7NMLN7c6R5KwjviBaV4i36+q8nJPusF8faauO9fuFd9xoG+toj4Ias6NcrMEwjGDE3dl0jJv9xBlG2pgemQTxSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725857298; c=relaxed/simple;
	bh=JdC2s9reCpdh5GCXboPwMMIj7X0SAwyOF7XGfxe2r5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=NAAlbvM+DAPkoXUranVzMGUU+pDdW2l+ZQAG+Ia2HLdphQEz57i/SnL5WVMyNaCUG4C2XRXJzg6l570Z/6L8CCkok0gOsn0IlqU4P0cOI29XKveVKbT7RaRbqhGQ+OamfGj3Gh2N7gLdxJQbOHnGL2tp38MWfDLY1Gep/vn3GLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=bN8OB00/; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:From:References:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=qwEkeTcVc7zpbCn2RYLTfGsdfSlZzqQCcwvEwhFQqjg=;
	t=1725857296; x=1726289296; b=bN8OB00/yKYbFoPSz//AhCgJVai+mI//aD7C9WavvdhMUI+
	71eMSIHKocBvLTd6vkxR49qZocu01of98WEcgHATvgSOjJJhVlt8ooo4+POdVPob2Jr8r5UVefu54
	zBb/Oo5KyXqkdZGKQg6iRYAR2vcnWrv5whUs/ZGCGoUFDx/LJ40x+IBz2dLJzs+6KCngxKHUsk45t
	HD3jMjd14zxM3gl+D2Rf2C+8frD+JNjOoq9WDcJhokOxHNnuXGgIzMZkfNJtAnwpCB3JFC+qWcBqp
	HYDzWYGtwc6wDnS45WpsNU3eQajvONnP1+ctBPLGDUJ41q6s59RRQERb9iHxyMGg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1snWJy-0000ch-7S; Mon, 09 Sep 2024 06:48:14 +0200
Message-ID: <67481fc6-7eab-470b-8d5c-1d7a50782f66@leemhuis.info>
Date: Mon, 9 Sep 2024 06:48:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Can we get a bootable 6.11-rc kernel?
To: Bob Gill <gillb5@telus.net>
References: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-kernel@vger.kernel.org
In-Reply-To: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1725857296;d657008a;
X-HE-SMSGID: 1snWJy-0000ch-7S

On 09.09.24 06:04, Bob Gill wrote:
> Hi.  It would be nice to have a 6.11-rc kernel that doesn't crash.  I
> have an AMD video card.  I can boot into recovery, but any time I try to
> run "service lightdm start" or startx, I get a nice black screen, and a
> within a second or 2 my keyboard doesn't even let me type the caps-lock
> key.
> 
> My hardware: (taken from kernel 6.10.0)

So 6.10.y worked for you, but 6.11 did not? Can you please share the
dmesg output for both these kernels? FWIW, you might want to compare
them yourself, if you are luck that will already tell you what's wrong.

Ciao, Thorsten


Return-Path: <linux-kernel+bounces-344104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3198A49E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD393B22F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03018FDAB;
	Mon, 30 Sep 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a8TovYRU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14A17C22B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702147; cv=none; b=VCeajD+Ww8caEBOcqKHwZQja0ko/eQ/E9Umh76uFyvuJnlArmKHfSEg4Di7R4m49W0Jf25WlAdzoLUsOwBcZdAWUMY8OVvmG7utfKhckFGpfszmsIcNrLzVXZbNbIcw680dL8t/oUaYYgy88liM3s+MQlVou5el+nk5fxLH9fGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702147; c=relaxed/simple;
	bh=+EFJD6BkD6P7Mswfba9DytaeaQI1X7EjmdrFVAKTcVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RArFSLjH2RsMqbORe8ft2bp8BE2tMevJwiHn8vJhHNGuSlofeTyn4H9hwhur5G/yA7diB3OsKKsBCzoAQKDJXZyr3TIMM5A/R2+U5BKYro7g7YhVxmw/lybJcpW/gImaiJH9GqUDQ/7AwOs8Zqr9rVslKqnPGGTV88rFUE0DkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=a8TovYRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5833CC4CEC7;
	Mon, 30 Sep 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a8TovYRU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727702144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fs0KbTBraqXQQimGP3ss9Uukt5oyyTGBgvHqQ+F0wJU=;
	b=a8TovYRUCNIOt2bQ8UEhvDlDJKHQwdkfp03tfUNy9sSS0ml27OeQTAhxN69hrMxdMcudH9
	pjZ6DqGp88Sfc3AISOBVtQackbl37Y7p/BVd0To6ekk67x1zHymCqd76t6IJblgsBtCnGZ
	JKRADBYepsk/FMmYoN+bAAqFnUrsEbs=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 46897bba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 13:15:43 +0000 (UTC)
Date: Mon, 30 Sep 2024 15:15:41 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.12-rc1
Message-ID: <ZvqkfSM_8sxTSzz_@zx2c4.com>
References: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>

Pushed 5.12-rc1 too? Odd.

+ git fetch linus                                                                       remote: Enumerating objects: 54527, done.                                               remote: Counting objects: 100% (24190/24190), done.                                     remote: Compressing objects: 100% (314/314), done.
remote: Total 54527 (delta 24053), reused 23963 (delta 23876), pack-reused 30337        Receiving objects: 100% (54527/54527), 34.39 MiB | 2.53 MiB/s, done.                    Resolving deltas: 100% (44154/44154), completed with 9484 local objects.                From ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/torvalds/linux                     4a39ac5b7d62..9852d85ec9d4  master     -> linus/master
 * [new tag]                   v5.12-rc1  -> v5.12-rc1                                   * [new tag]                   v6.12-rc1  -> v6.12-rc1


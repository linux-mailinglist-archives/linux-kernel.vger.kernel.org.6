Return-Path: <linux-kernel+bounces-293255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E23957C95
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7551C23C07
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123613665A;
	Tue, 20 Aug 2024 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="U7d0m6ju"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C6131BAF;
	Tue, 20 Aug 2024 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724130235; cv=none; b=OyywFbcbr78ASf/LCBT2RmhbqQ9saTGS09M65kVp0VjEJ82cRp0pqE3r116edm4Dc5hn0zbUxK9IqaxY88NLspqWkaxjeG/RAubBzcCvgZXWehmm9+C6P50XgojvEqxNKQDnpaER4EJXN4A+95EfRvgDdTUmQP8XfWtRZ8w2n6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724130235; c=relaxed/simple;
	bh=HpkTuR8cRwLiGfTQ26yysE/hoKAvq3jtYhHIMXxR61c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZe/QABkvn6sTGJ/JQ9FBhWuHc+P2DW97NliJ6cfiq4ej76bcGQYbZFpX0JmIuQzpNeFTSBFnPkRmBAUu7UCUX6CG1RrYMjEwhmfRjpVw+tjDtizmb/TkXd0zXsTIiwL40mMkIDw38OzXhwfAVfT+BOfDBl8Z7oIoeADj+KdvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=U7d0m6ju; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=hOvXk6Q5IIJgxuprUNC0NbUryJuNJUXTfIC8mVZ6GAQ=; t=1724130234;
	x=1724562234; b=U7d0m6junqI4GX0s7GziJH2vPIzRuZtVuGSCB04QlpGwj/qtjRJ8zoabaXhES
	hi0n5ylq7q+6sN5dgTIKp6q9CdIUyT1b8muMOlre1Kp0Ypa+E+nek6gwMVL0GK+CCTTsN7LiQiUtX
	d5qRYNus9GkJJXZpib9lhGQc8esYGB85oSyY7+RFFWT8Ow3nddYXp/NF/a34jAs7jbRKgaboYBZ+U
	mf3Knc3hzYi/Z6qr6vTDR9g9g52V1x2KwG5D6h0VT9k9UppIcqmiDJ1CLU9r6+Rv2QQf91CKz9hAO
	khhBSxHZFCnFbL/64TYhUlYwXgfK0JPIrhaHtxfiVKsZ2jn2PA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sgH22-0008HB-6i; Tue, 20 Aug 2024 07:03:46 +0200
Message-ID: <b21aa149-fd70-4aa0-9b25-886c81ebfae2@leemhuis.info>
Date: Tue, 20 Aug 2024 07:03:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit *pidfd: prevent creation of pidfds for kthreads* causes
 `Failed to remount '/' read-only: Device or resource busy`
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <3a1c9e27-6dcb-4eec-85cb-c03271c61a37@molgen.mpg.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <3a1c9e27-6dcb-4eec-85cb-c03271c61a37@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1724130234;d2d5ec7c;
X-HE-SMSGID: 1sgH22-0008HB-6i

On 19.08.24 23:02, Paul Menzel wrote:
> #regzbot introduced: 3b5bbe798b24
> 
> Commit 3b5bbe798b24 (pidfd: prevent creation of pidfds for kthreads)
> causes a regression. On the Dell XPS 13 9360 with Debian sid/unstable
> and *systemd* 256.5-1, systemd is not able to unmount the root partition
> (LUKS encrypted) anymore.

Hi Paul! Thx for the report. FWIW, a revert to fix this is already
queued as 780d60bac21ebe ("Revert "pidfd: prevent creation of pidfds for
kthreads"") [next-20240820 (pending-fixes)] after Eric reported similar
problems recently:

https://lore.kernel.org/all/20240819-staudamm-rederei-cb7092f54e76@brauner/

Ciao, Thorsten

#regzbot fix: 780d60bac21ebe




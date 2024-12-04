Return-Path: <linux-kernel+bounces-430980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633C79E380D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D999AB2ED1C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422E11AA1EB;
	Wed,  4 Dec 2024 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=petrovitsch.priv.at header.i=@petrovitsch.priv.at header.b="cUQ3Kr6D"
Received: from esgaroth.petrovitsch.at (esgaroth.petrovitsch.at [78.47.184.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776842B9B7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.184.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308970; cv=none; b=l4rVtH5C9cisyTqPGu/FDJ/oVvu8lFJkoNP3AX3eThcgjlM0rUAkpxkDb3QIipDoLllkN27EGlT4xa8vmg1hrxN7t91GHqYdyv/nQda/L4XK0P0AGmCL570962wIB0tO1SJ/DxGJokrgM+yZ30DkBGRxiWNJBTFsmcfHSkbtaFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308970; c=relaxed/simple;
	bh=6Yw6q/+1dW9PkJ5KQC13bH+FI5One12gQxXC+bovsKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=nVfu+AbKbtWcAU//Pmd6N3iJa4RaIBDEz7gfmx44qKbI3gB6bbFxU5LvQrTZJiOrwnIO54rUd6poxAMC5TBMJgYwCANr+CVIXeKzSJl/zTStoMqspyVUlLqg0+vycvVqVMS/qYzAGsVByfLajIVC59Ny1K+zsoIF9cspwBBGO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=petrovitsch.priv.at; spf=pass smtp.mailfrom=petrovitsch.priv.at; dkim=pass (1024-bit key) header.d=petrovitsch.priv.at header.i=@petrovitsch.priv.at header.b=cUQ3Kr6D; arc=none smtp.client-ip=78.47.184.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=petrovitsch.priv.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=petrovitsch.priv.at
Received: from [172.16.0.14] (84-115-223-47.cable.dynamic.surfer.at [84.115.223.47])
	(authenticated bits=0)
	by esgaroth.petrovitsch.at (8.18.1/8.18.1) with ESMTPSA id 4B4AglDV2490962
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Wed, 4 Dec 2024 11:42:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 4B4AglDV2490962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=petrovitsch.priv.at;
	s=default; t=1733308969;
	bh=UgHIPEB0b7xf7+dfdXOJlt17omoNMiw4E3xM9IR7mL0=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=cUQ3Kr6D7L3lwcM5y112UigGeea17k9nLtIWDAcVfmIQVxgwm60J/JkX69011QuWt
	 PitDD+H4exx/KKd0fQWiLREfC6U6+umuSJ2+Ah7G8XneWQ+COP7EcBF3zZKL22R0E+
	 cTRMFGZhYa8/K2Ll2sKLg1/67X4JeRMqLhGlFATE=
Message-ID: <507f885d-8f81-4663-944d-d3d224747bdf@petrovitsch.priv.at>
Date: Wed, 4 Dec 2024 11:42:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Wislist for Linux from the mold linker's POV
To: Rui Ueyama <rui314@gmail.com>
References: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Content-Language: en-US
Cc: LKML <linux-kernel@vger.kernel.org>
BIMI-Selector: v=BIMI1; s=default
In-Reply-To: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC--Metrics: esgaroth.petrovitsch.priv.at 1102; Body=2 Fuz1=2 Fuz2=2
X-Virus-Scanned: clamav-milter 1.0.7 at smtp.tuxoid.at
X-Virus-Status: Clean
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]

Hi all!

On 28.11.24 03:52, Rui Ueyama wrote:
[...]
> After all, we just want a system-wide semaphore that is guaranteed to
> be released on process exit. But it seems like such a thing doesn't
> exist.

I use a socket for that purpose as they are closed with the end of
the process.

(SysV-)Semaphores cannot do that as they are separate entities with a
life independent of processes.

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
      There is NO CLOUD, just other people's computers. - FSFE
                      LUGA : http://www.luga.at


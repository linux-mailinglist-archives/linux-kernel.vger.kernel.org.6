Return-Path: <linux-kernel+bounces-396656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72FB9BD02D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEEA283541
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3921D27B1;
	Tue,  5 Nov 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=falaichte@mailfence.com header.b="gSoB2ZYC"
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D2224FA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819730; cv=none; b=M27xbSOf8jff2k3cn8zkT5ab3L+PsBn23u9AZy4T+zmHowk27Fk1f6nOEaP5fNUeDE8mZf8awl79vxGNHJi740KFMvqz17b4M4iXZkjxWTih8pfc+d4tqsW0eA9mxthF4A8QnmdARGuFnvnx6TGlk/xLVrxdmIxuLz7NRPbR/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819730; c=relaxed/simple;
	bh=KjnuzrgWUcvc0nhG4vjn4N5oeacqpuVJYtovJQnz7Iw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lKPUtMVbyl0dTcfl2Z3BXEYKdMwmFfe05MOk/H+G14YkZ4LNUT0jNoTY7d8VWjZH/EYibnrhR7UHQ8nF5Q6AY4d0237ll3VDDIyTvGqUCjKqZwSdN92vK6GRMY+1iZPG9tf9rINSKj1U6pCUvzbzN7DKmlnCLS1tfm7Vt3Kv/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com; spf=pass smtp.mailfrom=mailfence.com; dkim=pass (2048-bit key) header.d=mailfence.com header.i=falaichte@mailfence.com header.b=gSoB2ZYC; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailfence.com
Received: from fidget.co-bxl (fidget.co-bxl [10.2.0.33])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 85932FD8;
	Tue,  5 Nov 2024 16:15:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730819726;
	s=20240605-akrp; d=mailfence.com; i=falaichte@mailfence.com;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HB9bKtBRX6zME1N4RYkZJ1/hC68TAD6R4W/qrj/Q4Mw=;
	b=gSoB2ZYCkyuWwnlaQFvxKJ7djnLFBoAHibt4FzqyF8c7X+WqFwQd/9ECQQWOO5EY
	FbXpm9nayvz8rQWuYndxH9V6BGrveO7uQPZYGyPBhhRPJq9I4erpBgW1besZ/v6o3tg
	8eahiMxzso2mxSguR0jidOtFddfL8mUNzer9VGXQLZquk7RFmDLSuWfXpvyH6HFNHSG
	m7KTdC0XXN3JVTlHyz8AaIdl15p/ghtvy6vRCQLcM4DVaI2NkaKbSKt/aSjBh2JzszR
	iA5bdkEFT3zXVNsKmZi+WmRWMTZu0AspExVxyZF6PAgUCirw8IGryXyP1JE1hHS+jyD
	RbXVQc5UDA==
Date: Tue, 5 Nov 2024 16:15:23 +0100 (CET)
From: =?utf-8?Q?Dylan_=E2=80=8E_=E2=80=8E?= <falaichte@mailfence.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Message-ID: <237077017.130501.1730819723674@fidget.co-bxl>
In-Reply-To: <1552791356.130304.1730819601359@fidget.co-bxl>
References: <1116521637.127547.1730818127738@fidget.co-bxl> <1552791356.130304.1730819601359@fidget.co-bxl>
Subject: Re: Russians in the Kernel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:490142097

Hello everyone,

The recent stir about the removal of prominent contributors from the Linux kernel for nothing more than being Russian has prompted me, someone who has absolutely no business being in and around the kernel mailing list to compose a message and hopefully provide the prospective of an end-user of the Linux kernel. Some people feel blanket banning an entire group of people for the wrongdoing of a handful is rather unfair and not in keeping with the spirit of free and open source software. Rather than complain about the change and governmental overreach in community projects, I'd like to offer a technical solution that could ensure things continue as they have while adhering to sanctions.

Would it not be possible for the Russian kernel development community to pull together and continue working on the Linux kernel in their own tree and then have any patches sent back upstream by someone that is not a Russian citizen? I feel the solution would definitely help with making things right to the veteran contributors that have been working on the kernel for decades and allow patchsets to be more closely monitored for possible sabotage by having all patch submissions be sent through an intermediary that is easily identified as handling Russian code.

If sabotage by state actors is a concern for the Linux kernel, then the above solution should appease most people in that respect. Free and open source software is blind to the identity of people. Hopefully my proposed solution can help keep it that way.

*Apologies in advance for any duplicate emails sent to those CC'd.

-- 
Sent with https://mailfence.com  
Secure and private email


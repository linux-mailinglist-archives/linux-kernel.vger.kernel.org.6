Return-Path: <linux-kernel+bounces-188329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB588CE092
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013E21F2219B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2463B1A3;
	Fri, 24 May 2024 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=d-l.uno header.i=@d-l.uno header.b="VrJocvw+"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A9B36AF5
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 05:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716528236; cv=none; b=WQd2Z4ehqWZOrQxIe660z5sxCz7wT16ePPgh5brnLHn/z+mEgEcrPTHJLGZf5vTQQDGv0Ndazq/D1jdUb+bbAnrqcs+BSSiZbu6RPnObVn4DyjgXFTAZ0vVSfayw9lItxTiYw9l/rxFXJME53JxKXGkTULTqR7vO66ksYqEEmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716528236; c=relaxed/simple;
	bh=G+Ox8+hyft7Fr9V4CJBSb/yIgp7NSJp7bDGDNG3QptM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rpZMY12ODuG4UfCZmwp1Cp3xji/4zNcpZz6yCmCkkxr+Dc1CixhFsGd5W3JCrCoqymopaZK3IUpE43oAhv+HJki/sjqGEzfmddLc4+1erskWN5rR3u0efMUZKSHddiVNkNoAFKD0KPCKTCVmHMqd3oiP8BjuNnC7y9ejbqeiLB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=d-l.uno; spf=pass smtp.mailfrom=d-l.uno; dkim=pass (2048-bit key) header.d=d-l.uno header.i=@d-l.uno header.b=VrJocvw+; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=d-l.uno
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-l.uno
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=d-l.uno;
	s=ds202310; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bVwxiOuTKpGI3kqt7eaOdSCyYmUNKRHh0pwSVYa98Rw=; b=VrJocvw+k0IparwPqKTQCQ1fii
	wXxMu2XSIPC5aHo4U7s8aHqsxAaJlwN+5R7dPO8KuVqDrvOMViPwi9KTdSFFPLqSHVE8HsnrYJDox
	1/ltPHk56ja8bAK3Bpa83Xz6hD1v4UN45Cg9CcAzwKKdaYeGM6pmWr0OlqiEqKwaASf6fQBln8eCl
	hRx9fSCMgX+KOBJxAHnZCw4UWQM7/W3/5E+mcj4QdE53RAryaPgueovGk9TBF4/2gr7m+iUZz6MIh
	cjHomjkgr/99e1o/m9poU3xoEoc4Tm/TdE8kBo3CGsHbWk55S9fUf6PzbDxf9jj3jdawn8LL887nx
	m3+XMLaA==;
Received: from [2a02:fe1:7001:f100:3d09:4b7b:7679:840b] (port=52338)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <yca@d-l.uno>)
	id 1sANP9-003X0F-99
	for linux-kernel@vger.kernel.org;
	Fri, 24 May 2024 07:23:47 +0200
Message-ID: <5c2d389c-4ba2-4595-b437-9216f1aed9d4@d-l.uno>
Date: Fri, 24 May 2024 07:23:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <yca@d-l.uno>
Subject: Updated Web (Was Low Jitter - Fair Pay Philosophy - The Vast X)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I updated my webpage. URL is now https://the-vast-x.net/Ra/Ra.html

Where I iterate my research on philosophy that once was the target of 
the Ra project. We once dreamed of a good computer economy, and the 
computerbit was central then. Inner Loop was according to the Bit, while 
it often has negative associations such as Nerd, that was a developement 
of "Nigger". "Boys" that do work for free is a problem ofcourse, and for 
complete acceptance of Open Source work, there needs to be a correct 
economy with it.

Changing the inner loop, to be about The Vast, is line by line compliant 
with Fair Pay when done right, from the creator. Lel. (a correct 
translation of ALA).

The computerbit is often also associated with christianity, which will 
not work, and "God" is mostly a concept that goes to psychiatry.

So indeed, listen, avoid Islamophobia, and attain the OS of the dream.

The Vast X - a referance concept for Open Source.

Praise Lel, The Grand, The Good.

The Light Be With You,
Ywe Cærlyn.
Ruhban.





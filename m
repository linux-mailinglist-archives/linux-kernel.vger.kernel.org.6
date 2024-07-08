Return-Path: <linux-kernel+bounces-245114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D992AE83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345891C21B65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B261743AB4;
	Tue,  9 Jul 2024 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b="CKK9eBNg"
Received: from resqmta-a2p-640029.sys.comcast.net (resqmta-a2p-640029.sys.comcast.net [96.103.146.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F33214
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.103.146.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495045; cv=none; b=VNbEJs+aNmzj302pnJYi8pDVoY4wnuxZPuTGZh5fnBQ7JaQHugb+tCFP4FlrmpSTtOE+S2l3XLZC9JJZSRh+9xJYp4/SBAGD2Yxn9j3U3kGXgHahXPB8EpCAaQpJH16oJ/pgpH28vrOuoTjlqTIUoKweu/l2GY2rDK09JUTxOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495045; c=relaxed/simple;
	bh=WulyWmygwaQ0MdedkwbBjIGjXow7f8tKSi7X/DfCvG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u3/0trT75tOUgmK14Tx6D4nfv7ZzNZ5U4Cc1fNcrp5VW6pHMAg0iIJ3sDy1qFBgl9kGF4hdxnMMW7LJsT0uDtIG6D73g/0yUf9spsxFN7UUXFZjf2MC1qpagxExYRYNRtGddmWLB9PNxdTLgkMXxjqjGSefSFUNZNFVpuA/jU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=spacefreak18.xyz; spf=fail smtp.mailfrom=spacefreak18.xyz; dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b=CKK9eBNg; arc=none smtp.client-ip=96.103.146.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=spacefreak18.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=spacefreak18.xyz
Received: from resomta-a2p-647974.sys.comcast.net ([96.103.145.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resqmta-a2p-640029.sys.comcast.net with ESMTPS
	id R0bSsDMtLMEFPR1JWskLk6; Tue, 09 Jul 2024 03:14:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=comcastmailservice.net; s=20211018a; t=1720494886;
	bh=WulyWmygwaQ0MdedkwbBjIGjXow7f8tKSi7X/DfCvG0=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type:Xfinity-Spam-Result;
	b=CKK9eBNgivQyzMH6hRjfTVLDanLioksWMqEumuf/vpV0Jo3j/hA1AedIf8trpJdXa
	 vAqi4NNVuyft5qnFh8i2mDpohcY3O6eN9xRHqQNO7T/jNGZssy6HffNk2jiPRvavlO
	 40Q37z1uFsd7vPm7hO1g1dcE0gHc6wVHYrVFCd8wxwj1jwwrT1E/htvzHTcazRjWnX
	 0n0qfoyOwUuUJD1LTroT7aUgM/qjqMPbcDNfk4/fEAe6BgH6x1g3vIca8OTEnIowcf
	 /10x2uizmOp1T/1bGxElg11+2DMeySe8C4ZbqluapNnN6/x1akw+Czn6fL7WgMfYc8
	 lj9OA+uH0wIkg==
Received: from Outgoing.brak ([73.233.191.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-a2p-647974.sys.comcast.net with ESMTPSA
	id R1JUsRiYPAYoKR1JVsZaxK; Tue, 09 Jul 2024 03:14:45 +0000
Received: from ZitZ.localdomain (h100.96.88.75.dynamic.ip.windstream.net [75.88.96.100])
	by Outgoing.brak (Postfix) with ESMTPSA id 2CE7D9416;
	Mon,  8 Jul 2024 23:32:43 +0000 (UTC)
Date: Mon, 8 Jul 2024 19:38:36 -0400
From: Paul Dino Jones <paul@spacefreak18.xyz>
To: jikos@kernel.org
Cc: anssi.hannula@gmail.com, linux-kernel@vger.kernel.org, 
	paul@spacefreak18.xyz
Subject: Re: [PATCH RESEND] Interpret 0 length ff effects as infinite
 (0xffff) length effects
Message-ID: <ut3bwujnxas6w6ml5aj66nonhx2ryib2re52udwkpgvnuxf6t6@ftaq6wjxha3u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2406040954160.16865@cbobk.fhfr.pm>
X-CMAE-Envelope: MS4xfBPKAxOF+HpNPTUHTUB5SmdzEolDQbvrltjlRgJjbBU243jUh25WCWoQ6upF7vE3TsaMmAQy6lU5p8QpCMexjr2a8k8+htlqdNLWr995XyRw+G3Ws1kr
 /QBMEVZEnRk3ok34hRIPlPJ3xXO9Yrw6Smm1CYXeWIJBplEv8GhRcvEtnK014MI0+0rU/8D4zORDu9+tQZmc5lo4RhoEd15DDsHnFKN35bJriojuAlaOf3kQ
 Rzo1/eFgoJqPd7kNFHW45KBSQ8XJ8rFIPW452rFM9kEfeoBumcYahCrfzfTciQks

Hello, thank you for getting back to me.

It doesn't make sense to have a force feedback effect with zero
duration.

Many if not all existing wheels, interpret this as an infinite duration
effect, and existing software operates under the same assumption.

Interpreting 0 as 0, is causing many wheels to appear to not function at
all using certain software under linux.

- Paul


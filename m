Return-Path: <linux-kernel+bounces-216679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C8490A2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9E3281DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC417D364;
	Mon, 17 Jun 2024 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="NyfXQFmB"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253129D19
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718595617; cv=none; b=lB4xxaWXnGEQLVDC5PohvWsEVBJnGvU5w4YFc4OSaAwI1PpfI8Z6cVUubl07wWMN4gsfIR2bdsAlntT68coMZ5qJPT1cHknwe4trTutIjKYU+cShXdOkmc1DhaK1W7K9nhzO1FwByjk/MSGnw0D+6G95mBDhTUyYY+rO1xvNEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718595617; c=relaxed/simple;
	bh=VII6rEYUfEoXXzukSbL36pw2B8lYYvJ2aB6+K2X6hq0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=W3kheWO1+YSYfglXS9ceRogxTJnc/h7nawUJpueUUfh8PJfVrMpfek+JfW/LYpRrDfxBU/sSsxIa5goJEhjX+0CnsAicAMcTYZEHkUEZ2NSsw/4789qpz5PatNp8SW0f5uARouue2kogRVBP/yeMRr5nL/niFULHf7exnsImlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=NyfXQFmB; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OAaeFT6es5odjPZZSI68CN5wuSzdCfBiuIASXYyxw3M=; b=NyfXQFmB/deXqgVjUbSUer/KOX
	sGWFSP4di8dRsvUN71dk0ZRsELEe0ZuRJSQeIH1apbZ2AAZ2EaLQ6PorzGM0U9hEQofHhXPTY4Da8
	tW5SpJ6JOhytjwIpyBZ4KZ/FLK/qRyS7rL4hzkIFa9G43meaXnA0Meyj/tv+x7iVguiD0UrkzY4Cq
	S1UeTv4U6jlTG59PAWZHlnAMIbt2jMk1ccnnxmKowVWXEfuK9PNrOWa+mIecmzBJzpYrLOFNTSEdK
	jppGM70T+jehIj9HZt7Rth+WgQnSBCJR7kxct8EXPwPwxUIe2PvoPOLTOxJ6Ku1EY4PwOIwGMpXLo
	JizwLUlg==;
Received: from [2a02:fe1:716d:5f00:3871:1618:a772:f297] (port=65151)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1sJ3E5-00B5y6-5P
	for linux-kernel@vger.kernel.org;
	Mon, 17 Jun 2024 05:40:13 +0200
Message-ID: <9b9e613e-e691-4aa8-bc85-630fdc0e3294@malaika-12.net>
Date: Mon, 17 Jun 2024 05:40:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: Re: Hacker (The Vast X, Fair Pay Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I did some thinking on the concept Hacker. It seems inspired by the 
hippie peace logo, which seems mormon based. And that seems to lead to 
the diabolic interpretation.

Hacker really is based on AL HAQ, a name of ALA in The Quran.
It means The True.

There is really nothing wrong with being a Haqon, as a correct use of 
this concept would be (follower of Haq.)

However the mormon sect is an influental sect, and this is again an 
example of how association to The Bible goes wrong, instead of 
association to The Quran.

I was mostly with El, growing up. Associated to The Bible it typically 
involves club going. Even if I said I was computer oriented, and not 
usually the type for this, this occured. I did understand to associate 
it with The Quran instead, and one is free of this peer pressure here.

Is Haqon still relevant as computer lingo, when associating with The 
Quran instead, or will standard vocabulary do fine here, developer etc.

The diabolic association is ofcourse unwanted.

Here one should also see a difference between "Satan" (which seems a 
Downs-version of Diablo) and Diablo, as its right name is in italic script.

Syndromes indeed much what it is about. Joseph Smith, founder of the 
mormon sect probaly bipolar, and thus an association with him, suboptimal.

The Light Be With You,
Ywe.
https://the-vast-x.net/Ruhban/Ruhban.html


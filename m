Return-Path: <linux-kernel+bounces-358730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527F9982E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D988E1F21811
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BA1BD4FD;
	Thu, 10 Oct 2024 09:55:17 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F788191F62;
	Thu, 10 Oct 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554117; cv=none; b=ija3nJCa6gRO6j+aR0EGGxIpH/z1rhrUfcdQ+Cv6SB3eLtubmGOIJvkJI3e+yyswEo9HiVS09Xaam6K0kHFHOY57o/C2yZDsgv02M/omZAC8hjTRTfCRABY4J3Y5uART0UFuhLq5HraQ7CrQ99Bxm5SlF79qYMn3cM0QPEPA81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554117; c=relaxed/simple;
	bh=gz2smKnkk2RNcrj6xuDZIDac9lwnTzKH5lj78bfhCoc=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=DrEMFU1upTj8j9pxwYLRuyBrHx4hgzDTx94MEN40xXuObzZqP/EX2bNT69hQowoEogxut9U/Kzrw5rKko19FTMvK2OfHlhJ2jG07pX6I/vBAXrn0QUemf5PNkfBe1H7w+irpgLD4Jrejh67F8NY6rwxUN2KExREQJeoNW0N5Qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16707a47d7ca-c80d8;
	Thu, 10 Oct 2024 17:55:10 +0800 (CST)
X-RM-TRANSID:2ee16707a47d7ca-c80d8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Honor (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56707a47d9cd-49527;
	Thu, 10 Oct 2024 17:55:10 +0800 (CST)
X-RM-TRANSID:2ee56707a47d9cd-49527
Date: Thu, 10 Oct 2024 17:55:09 +0800
From: =?utf-8?B?5ZSQ5b2s?= <tangbin@cmss.chinamobile.com>
To: broonie <broonie@kernel.org>
Cc: lgirdwood <lgirdwood@gmail.com>, 
	perex <perex@perex.cz>, 
	tiwai <tiwai@suse.com>, 
	matthias.bgg <matthias.bgg@gmail.com>, 
	angelogioacchino.delregno <angelogioacchino.delregno@collabora.com>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: Re: [PATCH 1/2] ASoC: mediatek: mt8188: Remove unnecessary variable assignments
References: <20241010073547.3720-1-tangbin@cmss.chinamobile.com>, 
	<ZwejOZQlSsWbAWBg@finisterre.sirena.org.uk>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.213[cn]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202410101755089538782@cmss.chinamobile.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

SSBhbSBzb3JyeSwgaXQncyBteSBtaXN0YWtlLiBJIGtub3cgdGhlIHJ1bGUsIGp1c3QgbWlzdGFr
ZS4KCgoKCgoKCkZyb206wqBNYXJrIEJyb3duCgoKCkRhdGU6wqAyMDI0LTEwLTEwwqAxNzo0OQoK
CgpUbzrCoFRhbmcgQmluCgoKCkNDOsKgbGdpcmR3b29kOyBwZXJleDsgdGl3YWk7IG1hdHRoaWFz
LmJnZzsgYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdubzsgbGludXgtc291bmQ7IGxpbnV4LWtlcm5l
bDsgbGludXgtYXJtLWtlcm5lbDsgbGludXgtbWVkaWF0ZWsKCgoKU3ViamVjdDrCoFJlOiBbUEFU
Q0ggMS8yXSBBU29DOiBtZWRpYXRlazogbXQ4MTg4OiBSZW1vdmUgdW5uZWNlc3NhcnkgdmFyaWFi
bGUgYXNzaWdubWVudHMKCgoKT24gVGh1LCBPY3QgMTAsIDIwMjQgYXQgMDM6MzU6NDdQTSArMDgw
MCwgVGFuZyBCaW4gd3JvdGU6CgoKCj4gSW4gdGhlIGZ1bmN0aW9uIG10a19kYWlfaGRtaXR4X2Rw
dHhfaHdfcGFyYW1zLCB0aGUgdmFyaWFibGUKCgoKPiAncmV0JyBpcyByZWR1bmRhbnQsIHRodXMg
cmVtb3ZlIGl0LgoKCgrCoAoKCgpQbGVhc2UgZG9uJ3Qgc2VuZCBwYXRjaCBzZXJpZXNlcyB3aXRo
b3V0IGNvdmVyIGxldHRlcnMsIGhhdmluZyBhIGNvdmVyCgoKCmxldHRlciBtYWtlcyBpdCBlYXNp
ZXIgdG8gdGVsbCB3aHkgdGhlIHNlcmllcyBpcyBhIHNlcmllcyBhbmQgbWFrZXMgaXQKCgoKZWFz
aWVyIGZvciB0b29saW5nIHRvIHdvcmsgd2l0aCB0aGUgc2VyaWVzLgoKCgo=





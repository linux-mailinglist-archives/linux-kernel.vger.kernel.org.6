Return-Path: <linux-kernel+bounces-198821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064298D7DF5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C801F2106D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C6A7D095;
	Mon,  3 Jun 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="dAMSpX8x"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26BE74297
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405107; cv=none; b=MvldLpzVhSN1jb38kxvJH4FpVEWGYwbPK/D/UWQgdw7vJ7bl0rdBuqmJxrlquqahsCPSfDvfuSAy2FwDH0sBGKR9gPji97LYIQjnd0pORbxNE2XzOfTayle+Xji7piLA9ve1Op3SMk8g017NLCqmvXUo8pfxvy4ENk023BKtjck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405107; c=relaxed/simple;
	bh=1gvS5oTFLSHw9wAzd0/jc5CVlK6vtSCyngl+i3KgSG0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FOfmMGEt8GAviPTJKCXvUEpHayyZXfMZ3dudbPSem8zAW+3u0zEzTGXeF2uOcf/TS0bubnJ47NNAg1blHjwCZeUMFJkn91E9LRVFyz+xuS6fZL2z1JL60XbfQHxI6uhBLoHN3FnBJQlXbXr0G3goO700nAnYcZTec8HqfaaRYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=dAMSpX8x; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OI4iN7rTZFqkFjahLOLSYOHa/FwsAlgvib3CtEYUDbI=; b=dAMSpX8xTWgtZw0Hn2U5k2/62W
	Wylp2PBZXS1+drlk2Jo9C5o1FpqOlD+s2qSyohzTcr8IUYzmKN/EMW2kfn/uOvuOqYB6yZ1YjHNOU
	lvCN7MLNsgoqJT5ixEKYxBzYcL1DYScWYNPSzfGwJxN5pMul0a3ZB8o0KO7lwfiyC+++rs+/GLPF5
	SsBDs2/4DCNm5jkyAECXYtZKthbVimDMogq/zXHppgPTLKF5Zo7dTVGS6WmYI/Im9B4WNK/OHbfe/
	j/U5pXJrrEzvKcFX0aaOTmZ7qceD53dSPUE7OJVi4eePjL+b9hdWFFU10ONpSQYBUqiyM3EryafsI
	4LqtyEqg==;
Received: from [84.208.88.155] (port=57716 helo=[192.168.0.3])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1sE3WD-00CNDM-Gf
	for linux-kernel@vger.kernel.org;
	Mon, 03 Jun 2024 10:58:17 +0200
Message-ID: <894bbc40-0f78-4171-921d-d7adb24834e9@malaika-12.net>
Date: Mon, 3 Jun 2024 10:58:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: Defeating "God" (& Hitler, Osama Bin Laden, Breivik) (The Vast X, was
 Low-Jitter, Fair Pay Philosophy)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ultimately the grief of many here, is "God", that clearly is connected 
to Hitler, Osama Bin Laden and Breivik.

And many want correct action with all these.

The Vast X, masks "God", and instead launches a Fair Pay politics 
complaint O S, with full support for rational discourse in the Science 
catalog.

Science also means an acceptable allegory for monotheism, and people in 
general, and this means Islam, which must replace "God", which I have 
worked with translation of. ATM Hal seems perfect as translation of the 
arabic theo, ALA, for italic script that supports this.

Games being very popular, and Low Jitter suits both gaming and server.

The Light Be With You,
Ywe Cærlyn
https://www.reddit.com/user/Ruhban_The_Vast_X/


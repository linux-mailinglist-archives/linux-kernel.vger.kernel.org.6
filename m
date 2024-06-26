Return-Path: <linux-kernel+bounces-230126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD329178D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A529AB22642
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4F14D2A8;
	Wed, 26 Jun 2024 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="h2EJMhNk"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79BE542
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382957; cv=none; b=doc18lo715qxlDgyngj8x2b0D6HVnlRTBMoBEaunjYDeOYmWxF9RY/76xRgS8Nol4060OPvG3Oq0qyvDUKnKmF5kO3ChDsYuegKghlMC9OTWIx0iaNoLD0drqT1NOhi3CY6P76lI8IQMyeIDYfwp+pWOZZR0y08NrAFQ6nvrSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382957; c=relaxed/simple;
	bh=i8Es4Zte3SN2y3xQpjhof63uPgu63+n6XcqR2hqdcGc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nAglPLVLpxgncrx1IB/iXYc7lmYAhLEFRidk/MSzb6Wfm4jq35Wr+Y8FPKoNX5DqSZcF+e5ED/n0wDjZWKruuEZMdys1gN+XdMQTIwh856rqaC2xhd8XSwZeFRUFq/6fdue4hKrVLpeZrQgWlBkLQ43NUSA/Yr7ENtQLMsPbuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=h2EJMhNk; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GbBtHxKx/hbQLCt66A4+/E8hEhcuZIlyUmxaTdjWiDg=; b=h2EJMhNkt8hC1v9cGMbk36/zJZ
	EGWw8lNKyFzycrZOY071nXURC74F25R69P2rObVdKyQiXvqm20KldBMBpaqzutJG4CuGeOc3C1sf9
	5QeOT+1MD3eq4VwUmu6fQWIghNU/GDRVqt0N78fUIEPGhUoW16WpBLz7AajhtN5HAhch46bFg09/X
	92nIt7MTfCbf/7g3yhEKKAgG7k5y7oc5SSD8dtF6YZiDGPg6mydxyW5lH6PSAFTclbxINANkrhXaG
	p6X1+k3egaNUYTjKb88oINrkPPn52obHs764xUqcKSxrmmMcJ9WKcrH4SRVegOcgNQVy6BtMvo1iE
	2SWQpsow==;
Received: from [2a02:fe1:716d:5f00:4062:1f9d:2fd2:105b] (port=62836)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1sMLhC-00Fw8T-9U
	for linux-kernel@vger.kernel.org;
	Wed, 26 Jun 2024 07:59:54 +0200
Message-ID: <bb7dec69-39f9-4f74-b889-19949765c890@malaika-12.net>
Date: Wed, 26 Jun 2024 07:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: Philosophy of The Vast X continued (was Fair Pay & Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

As it comes to me, I send some emails, keeping a ping of me going :)

On the C64 many godconceptions were combined, really making out a MARUF 
not MUNKAR principle as it in Islam.

This is still relevant, as the Rainbow Computers Users, are still the 
ones it is about, and was Irix before, and now Open Source.

In an experimental culture, still in "debug mode", one ofourse needs to 
take the correct developments, and reject the bad.

MARUF not MUNKAR does this, and as we approach finality of things, we 
have a wide enough dataset to just take the MARUF (The Good) of this and 
not the Poor (MUNKAR).

The Vast X is this, and now instead of Rainbow logos, and also could be 
for hardware design aswell, for those wishing an alternative to SIN. (We 
do not need an association to Sinful here.)

Yes?

https://the-vast-x.net/Ruhban/Ruhban.html



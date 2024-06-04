Return-Path: <linux-kernel+bounces-200126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757FA8FAB78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3052A288F4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFE113F45B;
	Tue,  4 Jun 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="Ap8XBRmg"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BD4A0F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484283; cv=none; b=ECvMykXe9xkpi4zWLTRWilrc82eAB3fU437lDl2NmsfaJ/JMHRAkoPLOxCVHYmpgYdOiyqV2TZyFCUSMLHujNBQchRj/X5cRnyTyKG0J/OSMVWkXcAjIfMjY+TA7uqy+kuKMV/dsAm0/zT6MFpvT32GDSWLq/tsC9C8PUTu+mok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484283; c=relaxed/simple;
	bh=ASSOnbAEeJoFPMVEQvO8tAvU43+GCrWup9rr1201dwA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=sxPEt9fdwHurKssaI+PaQjord4icH+k+05+YDCTUi4/OXPe7DQOkdMqoTEEMxOqlEaso6vwC7+f0zo5BV/vEZoqS6lTATQ/kEDKmMTIAaq/LM0g4pjnTPeohEuKKTu/k+uQnkM6Mhl2eZHGAjw/o9IV0SjpYDs05Yq+WNnw0oSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=Ap8XBRmg; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JxrBbmJGldZAqjeIDM6lVnMmXx/fwNNk7j28tGNP99Y=; b=Ap8XBRmgZHqaPodA+kQJ37Exv0
	xarAvJ6ZWehNllfakoc+nNLXJtVbx7n7GytRX8kL4n7XieNwOrfe9HX+dziJQc1fkhxqaA2LNf3k0
	lFIk5LG4BUDh/GwtXjPsM7WXRBJ/6pWH3yfaMdjsu3303OCG5Sm2Mm/olZPaqRnMo7p+UNYUkAnLy
	m33F1FGHmQNIVMc03qHcVwl7LpVv2yZLqKMYZUyzC2uujNiKtg2WziizoDxXLgDWUgCRbgOGKYR3u
	rCWzIbCSllYjDkpxTYaMq+m5WeHyiFtM9mI75HkeUPL5EgHlSw/2LYcMhHyNaLD78ApOiEiXOobvc
	6c71RM/Q==;
Received: from [2a02:fe1:716d:5f00:8929:82fc:8c1c:ac3f] (port=57019)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1sEO7L-001JGP-CZ
	for linux-kernel@vger.kernel.org;
	Tue, 04 Jun 2024 08:57:59 +0200
Message-ID: <2113911d-c988-4ea5-b379-e58ae4944684@malaika-12.net>
Date: Tue, 4 Jun 2024 08:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: Disassociating from OpenSUSE (The Vast X, was low jitter, fair pay
 philosophy)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

OpenSUSE was considered for forking. It seemed close to The Vast X, but 
SUSE is source for schizophrenics, and the toad is a total put off.

I talked in their Reddit forum, and moderators took the side of "Shabbos 
Goy" for jews. Basically jews think they need a Shabbos Goy, to insert a 
lightbulb. (Wellknown). In Linux circles Linus Torvalds IS that Shabbos 
Goy, to Greg Kroah Hartman (jewish). We can see such things reflected in 
supposedly intelligent computer culture.

This I can´t have nothing to do with. I am always on the islamic side in 
such a debate, without a "Shabbos Goy", or just "Boy" to racists.

This is where the polarisation goes. And I totally diassociate from such 
things, and encourage that any sane person, does so aswell.

Rather Islam, for fair pay and natural potential.

The Light Be With You.
Ywe Cærlyn, Ruhban
https://www.reddit.com/r/The_Vast_X/


Return-Path: <linux-kernel+bounces-195383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C78D4BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7FA1F2317F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDF417F4F5;
	Thu, 30 May 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="aEjtNeDM"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFF9183087
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073197; cv=none; b=njlcpoVLx81aLmCciKceveE9V9qNEexRh2kC+4++3UnY46LfmybAxBI6dPByb4NtIsVxX0kqiTkun/rPMjh5+M7bmENZCte7G7f9uvNV+J5YSqKRmH3GjYoPNzmwao5+71i1/NUTiw62Lmh/5YpuvIt83h85FbrO4P666Kh7EHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073197; c=relaxed/simple;
	bh=dbZf0hxHxekc5cDDE6H4zR7So3FCqwLmnDbilc0vi5A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j2bSITJdilkwJlEnLmrQSMzazixh0d0LKskXggjkt1ltBlxKCFZLTwWZ1wKYgMUxZjpxfoGC5AFWByzmXaKxAnARsW/io+TRmZoHx/oDlodvG6I2GgPbLUH/I0G1q+jqyNzpg8z1z2cTRhWkO+CGt4Y15HQ75KfRn9OwDb2CC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=aEjtNeDM; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dbZf0hxHxekc5cDDE6H4zR7So3FCqwLmnDbilc0vi5A=; b=aEjtNeDM1Rzc7XmxMJ3kaTkmVS
	RCrocrOLmGWicD0D/fXU9nvLu9omffsAlp0EUAePGp1ZweRvAYEhxHuqsvLLMQ7nxfTigBYnmfw4P
	Y1doX7MdVmtIJ7/92DZMdZKAQZ9KLTe50FTvJ79Z10o2yqpKV8cRxPy3UJZqTMjYVH/i7hSSdwI0o
	0hFzbxYkWR22RJIi/p5jtTZi8pIw0Xcbquu6IKjbGzjq/wKiexRgtGiVgcuIajTVmHHJZVAx6R2PJ
	/8V2QaY5RRfk27doodwgQTPllK9aH7wn9QitZp+dZXvoK/Ye0JaRPJpm2tmjcadPCCpjH+NlXSdaT
	hx2T6sfg==;
Received: from [2a02:fe1:716d:5f00:699a:fbdf:2785:f641] (port=59537)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1sCfAq-009UoH-8e
	for linux-kernel@vger.kernel.org;
	Thu, 30 May 2024 14:46:28 +0200
Message-ID: <31f5e1bd-2899-4e30-86ed-241c7c706a4d@malaika-12.net>
Date: Thu, 30 May 2024 14:46:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: The Vast X on REDDIT (Fair Pay Background, Low-Jitter continued)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Please also visit The Vast X on REDDIT.

I do really prefer a bit more graphics capability in posts.

The Light Be With You,
Ywe.
https://www.reddit.com/r/The_Vast_X/


Return-Path: <linux-kernel+bounces-186645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCFB8CC6CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD081F222AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23B71422DD;
	Wed, 22 May 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="CVB91L3W"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6B171C4
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405652; cv=none; b=TuWNPeVL8HykIvTGmSmPgR50Dmxz2VPhVFS33TuYnxEaVXxLBsP4MuzWYngD9dA01YrVqaRhyBg3CouqrFwrji9lrzZTvedbvZVY6zikQzGC5bsdUEPktMNO/o2w1fD0NBhlJgpghHIZJrJEeWdwkLMXs1PVFoo0LpOmv229Tsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405652; c=relaxed/simple;
	bh=Tje/Q6oLYQsxHBdYnETsFi19LcO/P5qcbUtLM8YCos4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HCrMv4SP9pUCdA3FRoCrZf1d7qIDw6pF9fqSOU+s2aO/vFs3VYSDEjQp0GO/igaQE2mN0eeNPRAUBVf5LOrz2kP/WPmH07gECvn6Y/+UNE0eYM9gtr5vwGp/fB6PZUPdDsjWKYtTYpt8bhaZArY9oPmRNeNoDX5uFt91dO4qAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=CVB91L3W; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sz5UwloeVFFAv1VCWD/Hv/KM6THtj35f4mpqeOTJLYs=; b=CVB91L3WHBwZ82uC7jQELxmF14
	E3dlY+WoXjfBVV/NRXpoXWXvZbq8hU+lSN/4A8vtjGamLVv0ogAnpC18AFmp1ex81sgTfFFMpoSfo
	FpW6s4FTqSs201LxWjn9fj3Dnn7+/Zo5k1cte8zed1io30xCB+xBPUYr3O9V9IsGOiH6pMWjM7Fme
	6unspfu6nldx+3H730OPzqsQpOW8QlWxcZAZrP1lnsgcx2sw6zPdjD3f+tSSUnH1Ac0KMnE5AAlaB
	QPirbYYFcWq2prwyLU8k4MK4/fl3yQ2H9slghda7nXqixXDiqNWf6CLaIPjLnC5Ic98/dDVgvVtof
	eJHINbiQ==;
Received: from [2a02:fe1:7001:f100:e8f7:294a:c7de:596f] (port=57523)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1s9r3q-00Bjep-76
	for linux-kernel@vger.kernel.org;
	Wed, 22 May 2024 20:51:38 +0200
Message-ID: <3ba2f9c6-3e9e-4e34-a913-198eae5dccd2@malaika-12.net>
Date: Wed, 22 May 2024 20:51:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: The Vast (for inner loop programming, fair pay compliant) X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The Vast

The Vast is a name I know through research on the computer Bit.

It is optimal for inner loop programming, and coherent code.

It is reflected in the computer industry.

And particulary Mark Shuttleworth journey to space, is a symbolic 
support of The Vast.

The Vast is even reflected in the name Microsoft Satya Nadella.

Information hereby released into the public domain, for general benefit.

Encouraging The Vast X. With full support of fair pay politics.

More: https://the-vast-x.net/Bit/BIT.html

Hail ALA, The Grand, The Good.

The Light Be With You,

